"""Voiceover (Edge-TTS) + silence compression + word timestamps (Faster-Whisper) + off-center .ass subs + optional ffmpeg mux.

Voice presets (--voice-preset; --voice/--rate/--pitch override individually):
  viral_storyteller (DEFAULT): en-US-ChristopherNeural, +18%, +2Hz  (youthful, urgent storyteller)
  urgent_teen:                 en-US-SteffanNeural,     +18%, +3Hz
  fast_mystery:                en-US-GuyNeural,         +16%, +0Hz
  classic_andrew:              en-US-AndrewNeural,      +15%, +2Hz
  kokoro_adam (use with --engine kokoro): Kokoro-82M voice am_adam, speed 1.15 (owner's narrator for story 002)
Engines: --engine edge (DEFAULT) | kokoro. Kokoro flags: --kokoro-voice (default am_adam), --speed (default 1.15).
  Kokoro deps (transformers 4.57.6, huggingface_hub 0.36.2, tokenizers 0.22.2) live in C:/AI-Vid/.kokoro_deps (gitignored),
  prepended to sys.path only in the kokoro branch.
Silence: ffmpeg silenceremove COMPRESSES pauses longer than 0.25s down to 0.1s (never deletes them) before Whisper runs,
so words.json/subs.ass stay locked to the final voice.mp3.
Subs: default style LowerThirdPop = white text with one gold (IMPACT_WORDS) keyword per card.

Usage:
  python pipeline/voice_subs.py --story-dir stories/001_slug                # reads <dir>/narration.txt
  python pipeline/voice_subs.py --story-dir stories/_test --text "In this town..."
  python pipeline/voice_subs.py --story-dir stories/001_slug --raw-video stories/001_slug/render.mp4
Outputs into --story-dir: voice.mp3, words.json, subs.ass, (final.mp4 if --raw-video given)
"""
import argparse, asyncio, json, re, subprocess
from pathlib import Path

VOICE_PRESETS = {  # name -> (voice, rate, pitch)
    "viral_storyteller": ("en-US-ChristopherNeural", "+18%", "+2Hz"),
    "urgent_teen":       ("en-US-SteffanNeural",     "+18%", "+3Hz"),
    "fast_mystery":      ("en-US-GuyNeural",         "+16%", "+0Hz"),
    "classic_andrew":    ("en-US-AndrewNeural",      "+15%", "+2Hz"),
    "kokoro_adam":       ("am_adam",                 "1.15", ""),  # kokoro engine: (voice, speed, -)
}
IMPACT_WORDS = {
    "never", "only", "every", "everyone", "nobody", "zero", "forever", "instantly", "froze", "frozen", "screamed",
    "shouted", "poof", "click", "thud", "crack", "boom", "wham", "ding", "stamp", "approved", "gold", "giant",
    "tiny", "secret", "secrets", "rule", "rules", "lie", "lies", "die", "dead", "trap", "sprinted", "shock",
    "panic", "monster", "beast",
}

STYLES = {  # name -> (primary colour BGR, alignment, marginV). Never dead-center.
    "LowerThirdPop": ("&H00FFFFFF", 2, 235),
    "LowerThirdWhite": ("&H00FFFFFF", 2, 230),
    "LowerThirdYellow": ("&H0015CCFA", 2, 230),
    "UpperThirdPop": ("&H00FFFFFF", 8, 220),
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

def get_silence_af(pause_silence=0.1):
    return (f"silenceremove=start_periods=1:start_silence=0.02:start_threshold=-42dB:"
            f"stop_periods=-1:stop_duration=0.25:stop_threshold=-42dB:stop_silence={pause_silence}")

def tts(text, out, voice, rate, pitch="+0Hz", pause_silence=0.1):
    import edge_tts
    raw = Path(str(out) + ".raw.mp3")
    for attempt in range(4):  # Edge-TTS service intermittently returns no audio
        try:
            asyncio.run(edge_tts.Communicate(text, voice, rate=rate, pitch=pitch).save(str(raw)))
            break
        except edge_tts.exceptions.NoAudioReceived:
            if attempt == 3:
                raise
    # compress (not delete) pauses >0.25s
    subprocess.run(["ffmpeg", "-y", "-i", str(raw), "-af", get_silence_af(pause_silence),
                    "-c:a", "libmp3lame", "-q:a", "2", str(out)], check=True)
    raw.unlink(missing_ok=True)

def tts_kokoro(text, out, voice="am_adam", speed=1.15, pause_silence=0.1):
    import sys
    sys.path.insert(0, "C:/AI-Vid/.kokoro_deps")  # must precede the kokoro import (pinned transformers set)
    import numpy as np, soundfile as sf
    from kokoro import KPipeline
    chunks = []
    for _, _, audio in KPipeline(lang_code="a")(text, voice=voice, speed=speed):
        a = audio.detach().cpu().numpy() if hasattr(audio, "detach") else np.asarray(audio)
        chunks.append(a.astype(np.float32).reshape(-1))
    wav = Path(str(out) + ".raw.wav")
    sf.write(str(wav), np.concatenate(chunks), 24000)
    subprocess.run(["ffmpeg", "-y", "-i", str(wav), "-af", get_silence_af(pause_silence),
                    "-c:a", "libmp3lame", "-q:a", "2", str(out)], check=True)
    wav.unlink(missing_ok=True)

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
        # Only use a short prompt snippet to avoid whisper hallucination/skipping on long initial_prompt
        prompt_snippet = (script_text[:100] if script_text else None)
        segs, _ = WhisperModel("small.en", device=device, compute_type=ctype).transcribe(str(audio), word_timestamps=True, initial_prompt=prompt_snippet)
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


def colorize_chunk_words(c, style):
    """Upper-case card text; in *Pop styles the first IMPACT_WORDS hit goes gold."""
    if "Pop" not in style:
        return " ".join(w["word"] for w in c).upper()
    out, hit = [], False
    for w in c:
        up = w["word"].upper()
        if not hit and re.sub(r"\W+", "", w["word"]).lower() in IMPACT_WORDS:
            up, hit = "{\c&H0015CCFA&}" + up + "{\c&H00FFFFFF&}", True
        out.append(up)
    return " ".join(out)

def build_ass(words, style, per_beat):
    lines = []
    for c in chunk_words(words, max_words=max(per_beat, 3)):
        phrase = colorize_chunk_words(c, style)
        # Sanitize any em dashes, en dashes or double hyphens
        phrase = phrase.replace("—", " ").replace("–", " ").replace("--", " ")
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
    p.add_argument("--style", default="LowerThirdPop", choices=list(STYLES))
    p.add_argument("--words-per-beat", type=int, default=2)
    p.add_argument("--voice-preset", default="viral_storyteller", choices=list(VOICE_PRESETS))
    p.add_argument("--engine", default="edge", choices=["edge", "kokoro"])
    p.add_argument("--kokoro-voice", default=None, help="Kokoro voice (default am_adam)")
    p.add_argument("--speed", type=float, default=None, help="Kokoro speed (default 1.15)")
    p.add_argument("--pause-silence", type=float, default=0.1, help="silence compression stop duration (default 0.1)")
    p.add_argument("--voice", help="override Edge-TTS voice name")
    p.add_argument("--rate", help="override rate (e.g. +18%%)")
    p.add_argument("--pitch", help="override pitch (e.g. +2Hz)")
    p.add_argument("--raw-video")
    p.add_argument("--subs-only", action="store_true", help="rebuild words.json + subs.ass from the existing voice/words")
    a = p.parse_args()
    pv, pr, pp = VOICE_PRESETS[a.voice_preset]
    voice, rate, pitch = a.voice or pv, a.rate or pr, a.pitch or pp
    d = Path(a.story_dir); d.mkdir(parents=True, exist_ok=True)
    text = a.text or (d / "narration.txt").read_text(encoding="utf-8")
    if a.subs_only:  # keep voice.mp3, re-lock + re-chunk existing words.json
        words = script_lock(json.loads((d / "words.json").read_text(encoding="utf-8")), text)
    else:
        if a.engine == "kokoro":
            voice, rate = a.kokoro_voice or "am_adam", a.speed or 1.15
            tts_kokoro(text, d / "voice.mp3", voice, rate, a.pause_silence)
        else:
            tts(text, d / "voice.mp3", voice, rate, pitch, a.pause_silence)
        words = script_lock(word_timestamps(d / "voice.mp3", text), text)
    (d / "words.json").write_text(json.dumps(words, indent=1), encoding="utf-8")
    (d / "subs.ass").write_text(build_ass(words, a.style, a.words_per_beat), encoding="utf-8")
    if a.raw_video:
        mux(a.raw_video, d / "voice.mp3", d / "subs.ass", d / "final.mp4")
    print(f"done: {d} (voice={voice}, rate={rate}, pitch={pitch}, style={a.style})")

if __name__ == "__main__":
    main()
