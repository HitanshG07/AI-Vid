"""Voiceover (Edge-TTS) + word timestamps (Faster-Whisper) + off-center .ass subs + optional ffmpeg mux.

Usage:
  python pipeline/voice_subs.py --story-dir stories/011_slug                # reads <dir>/narration.txt
  python pipeline/voice_subs.py --story-dir stories/_test --text "In this town..."
  python pipeline/voice_subs.py --story-dir stories/011_slug --raw-video stories/011_slug/render.mp4
Outputs into --story-dir: voice.mp3, words.json, subs.ass, (final.mp4 if --raw-video given)
"""
import argparse, asyncio, json, subprocess
from pathlib import Path

STYLES = {  # name -> (primary colour BGR, alignment, marginV). Never dead-center.
    "LowerThirdWhite": ("&H00FFFFFF", 2, 230),
    "LowerThirdYellow": ("&H0015CCFA", 2, 230),
    "UpperThirdWhite": ("&H00FFFFFF", 8, 220),
}

def ass_header():
    styles = "\n".join(
        f"Style: {n},Arial Black,80,{c},&H00FFFFFF,&H00000000,&H64000000,-1,0,0,0,100,100,0,0,1,6,3,{a},90,90,{m},1"
        for n, (c, a, m) in STYLES.items())
    return ("[Script Info]\nScriptType: v4.00+\nPlayResX: 1080\nPlayResY: 1920\nWrapStyle: 0\nScaledBorderAndShadow: yes\n\n"
            "[V4+ Styles]\nFormat: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, "
            "Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding\n"
            f"{styles}\n\n[Events]\nFormat: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text\n")

def tts(text, out, voice, rate):
    import edge_tts
    for attempt in range(4):  # Edge-TTS service intermittently returns no audio
        try:
            return asyncio.run(edge_tts.Communicate(text, voice, rate=rate).save(str(out)))
        except edge_tts.exceptions.NoAudioReceived:
            if attempt == 3:
                raise

_DLL_HANDLES = []

def _setup_cuda_dlls():
    import os, sys
    if sys.platform == "win32":
        import importlib.util
        for pkg in ["nvidia.cublas", "nvidia.cudnn"]:
            spec = importlib.util.find_spec(pkg)
            if spec and spec.submodule_search_locations:
                bin_dir = os.path.join(list(spec.submodule_search_locations)[0], "bin")
                if os.path.isdir(bin_dir):
                    _DLL_HANDLES.append(os.add_dll_directory(bin_dir))
                    if bin_dir not in os.environ.get("PATH", ""):
                        os.environ["PATH"] = bin_dir + os.pathsep + os.environ.get("PATH", "")

def word_timestamps(audio, script_text=None):
    _setup_cuda_dlls()
    from faster_whisper import WhisperModel
    def run(device, ctype):
        segs, _ = WhisperModel("small.en", device=device, compute_type=ctype).transcribe(str(audio), word_timestamps=True, initial_prompt=script_text)
        return [{"word": w.word.strip(), "start": w.start, "end": w.end} for s in segs for w in (s.words or [])]
    try:
        return run("cuda", "float16")
    except Exception as e:  # CUDA DLLs missing (cublas/cudnn) -> CPU; fix with: pip install nvidia-cublas-cu12 nvidia-cudnn-cu12
        print("CUDA whisper failed, using CPU:", e)
        return run("cpu", "int8")

def t(sec):
    return f"{int(sec // 3600)}:{int(sec % 3600 // 60):02d}:{sec % 60:05.2f}"

NO_END = {"to", "into", "in", "on", "of", "for", "with", "at", "by", "from", "the", "a", "an", "my", "his",
          "her", "our", "their", "your", "and", "or", "but"}

def script_lock(words, script_text):
    """SPELLING from the script, TIMING from Whisper (fixes FOR/FOUR, numbers). Aligned with difflib, so a
    count mismatch (e.g. Whisper splitting 'thirty-year-old') still locks; unmatched runs share their time span."""
    import difflib, re
    toks = script_text.replace('"', '').split()
    norm = lambda s: re.sub(r"\W+", "", s).lower()
    out = []
    for tag, i1, i2, j1, j2 in difflib.SequenceMatcher(None, [norm(w["word"]) for w in words], [norm(t) for t in toks]).get_opcodes():
        ws, ts = words[i1:i2], toks[j1:j2]
        if tag == "equal":
            out += [{"word": t, "start": w["start"], "end": w["end"]} for t, w in zip(ts, ws)]
        elif ts:  # replace/insert: spread script tokens over the whisper span (or the gap before the next word)
            t0 = ws[0]["start"] if ws else (out[-1]["end"] if out else 0.0)
            t1 = ws[-1]["end"] if ws else (words[i1]["start"] if i1 < len(words) else t0 + 0.3 * len(ts))
            step = max(t1 - t0, 0.05 * len(ts)) / len(ts)
            out += [{"word": t, "start": round(t0 + k * step, 3), "end": round(t0 + (k + 1) * step, 3)} for k, t in enumerate(ts)]
    return out


def chunk_words(words, max_words=3, max_chars=16):
    """Natural subtitle chunks: break after punctuation, ≤max_words / ≤max_chars, no lone tiny words."""
    merged = []
    for w in words:  # whisper splits "30-year-old" into "30","-year","-old": glue hyphen pieces back on
        if merged and w["word"].startswith("-"):
            merged[-1] = {"word": merged[-1]["word"] + w["word"], "start": merged[-1]["start"], "end": w["end"]}
        else:
            merged.append(dict(w))
    chunks, cur = [], []
    for w in merged:
        cur.append(w)
        text = " ".join(x["word"] for x in cur)
        if w["word"][-1:] in ".,!?;:" or len(cur) >= max_words or len(text) >= max_chars:
            # never end a card on a dangling function word ("OFF FOR HIS" / "DO I SPEND"): carry the tail over
            carry = []
            while len(cur) > 1 and cur[-1]["word"][-1:] not in ".,!?;:" and cur[-1]["word"].lower() in NO_END:
                carry.insert(0, cur.pop())
            chunks.append(cur); cur = carry
    if cur:
        chunks.append(cur)
    # merge a lone short word (e.g. "HE", "IT") into its neighbour when that stays readable
    out = []
    for c in chunks:
        if out and len(c) == 1 and len(c[0]["word"]) <= 3 and out[-1][-1]["word"][-1:] not in ".!?" \
                and len(" ".join(x["word"] for x in out[-1] + c)) <= max_chars + 4:
            out[-1] = out[-1] + c
        else:
            out.append(c)
    return out


def build_ass(words, style, per_beat):
    lines = []
    for c in chunk_words(words, max_words=max(per_beat, 3)):
        phrase = " ".join(w["word"] for w in c).upper()
        lines.append(f"Dialogue: 0,{t(c[0]['start'])},{t(c[-1]['end'])},{style},,0,0,0,,"
                     "{\\fscx118\\fscy118\\t(0,85,\\fscx100\\fscy100)}" + phrase)
    return ass_header() + "\n".join(lines) + "\n"

def mux(video, audio, ass, out):
    esc = str(ass).replace("\\", "/").replace(":", "\\:")
    subprocess.run(["ffmpeg", "-y", "-i", str(video), "-i", str(audio), "-vf", f"ass='{esc}'",
                    "-c:v", "libx264", "-crf", "17", "-pix_fmt", "yuv420p", "-c:a", "aac", "-b:a", "192k",
                    "-shortest", str(out)], check=True)

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--story-dir", required=True)
    p.add_argument("--text", help="narration text; default reads <story-dir>/narration.txt")
    p.add_argument("--style", default="LowerThirdYellow", choices=list(STYLES))
    p.add_argument("--words-per-beat", type=int, default=2)
    p.add_argument("--voice", default="en-US-AndrewNeural")
    p.add_argument("--rate", default="+8%")
    p.add_argument("--raw-video")
    p.add_argument("--subs-only", action="store_true", help="rebuild words.json + subs.ass from the existing voice/words")
    a = p.parse_args()
    d = Path(a.story_dir); d.mkdir(parents=True, exist_ok=True)
    text = a.text or (d / "narration.txt").read_text(encoding="utf-8")
    if a.subs_only:  # keep voice.mp3, re-lock + re-chunk existing words.json
        words = script_lock(json.loads((d / "words.json").read_text(encoding="utf-8")), text)
    else:
        tts(text, d / "voice.mp3", a.voice, a.rate)
        words = script_lock(word_timestamps(d / "voice.mp3", text), text)
    (d / "words.json").write_text(json.dumps(words, indent=1), encoding="utf-8")
    (d / "subs.ass").write_text(build_ass(words, a.style, a.words_per_beat), encoding="utf-8")
    if a.raw_video:
        mux(a.raw_video, d / "voice.mp3", d / "subs.ass", d / "final.mp4")
    print("done:", d)

if __name__ == "__main__":
    main()
