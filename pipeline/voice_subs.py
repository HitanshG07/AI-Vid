"""AI-Vid V5 Voiceover + tight silence compression + Whisper word timestamps + Safe-Zone 3-color .ass subtitles.

Key V5 upgrades:
  - Default style SafeCenterPop (MarginV=560) clears YouTube Shorts' bottom mobile UI overlay completely.
  - 3-color emphasis: White base, Red danger/twist words, Gold power/rule words + pop-scale animation.
  - Faster viral pacing (~185-195 WPM) with tighter silence compression (0.14s -> 0.05s) driven by config.yaml.
  - Supports Kokoro blended voices (e.g. 'am_michael:0.65,am_fenrir:0.35') with graceful fallback to am_adam.
"""
import argparse, asyncio, difflib, json, os, re, subprocess, sys, tempfile
from pathlib import Path
from config_loader import load_config

DANGER_WORDS = {
    "never", "nobody", "zero", "dead", "die", "died", "kill", "trap", "monster", "monsters",
    "blood", "screamed", "froze", "frozen", "panic", "crack", "snap", "boom", "lie", "lies",
    "lied", "betrayed", "disappear", "disappeared", "destroyed", "danger", "alarm", "gone",
}
POWER_WORDS = {
    "everyone", "every", "only", "forever", "instantly", "gold", "secret", "secrets", "rule",
    "rules", "million", "billion", "rank", "power", "powers", "awakened", "master", "clue",
    "truth", "subscribe", "like", "win", "won", "shock", "giant", "tiny", "wait",
}

STYLES = {  # name -> (primary BGR, alignment, marginV)
    "SafeCenterPop":   ("&H00FFFFFF", 2, 560),   # V5 DEFAULT: 100% clear of Shorts bottom UI
    "SafeCenterWhite": ("&H00FFFFFF", 2, 560),
    "UpperThirdPop":   ("&H00FFFFFF", 8, 240),
}


def ass_header(font="Arial Black", size=96, margin_v=560):
    styles = "\n".join(
        f"Style: {n},{font},{size},{c},&H00FFFFFF,&H00000000,&H64000000,-1,0,0,0,100,100,0,0,1,8,3,{a},90,90,{margin_v if n.startswith('SafeCenter') else m},1"
        for n, (c, a, m) in STYLES.items()
    )
    return (
        "[Script Info]\nScriptType: v4.00+\nPlayResX: 1080\nPlayResY: 1920\nWrapStyle: 0\nScaledBorderAndShadow: yes\n\n"
        "[V4+ Styles]\nFormat: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, "
        "Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding\n"
        f"{styles}\n\n[Events]\nFormat: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text\n"
    )


def get_silence_af(trigger=0.14, keep=0.05, thresh=-42):
    return (
        f"silenceremove=start_periods=1:start_silence=0.02:start_threshold={thresh}dB:"
        f"stop_periods=-1:stop_duration={trigger}:stop_threshold={thresh}dB:stop_silence={keep}"
    )


def tts_edge(text, out, voice, rate, pitch, af):
    import edge_tts
    raw = Path(str(out) + ".raw.mp3")
    for attempt in range(4):
        try:
            asyncio.run(edge_tts.Communicate(text, voice, rate=rate, pitch=pitch).save(str(raw)))
            break
        except edge_tts.exceptions.NoAudioReceived:
            if attempt == 3:
                raise
    subprocess.run(["ffmpeg", "-y", "-i", str(raw), "-af", af, "-c:a", "libmp3lame", "-q:a", "2", str(out)], check=True)
    raw.unlink(missing_ok=True)


def _resolve_kokoro_voice(pipe, spec: str, fallback: str):
    if ":" not in spec or "," not in spec:
        return spec
    try:
        blended = None
        for part in spec.split(","):
            vname, w = part.strip().split(":")
            vt = pipe.load_voice(vname.strip())
            blended = vt * float(w) if blended is None else blended + vt * float(w)
        return blended
    except Exception as e:
        print(f"Voice blend '{spec}' unavailable ({e}); falling back to {fallback}")
        return fallback


def tts_kokoro(text, out, voice, fallback, speed, af):
    sys.path.insert(0, "C:/AI-Vid/.kokoro_deps")
    import numpy as np, soundfile as sf
    from kokoro import KPipeline
    pipe = KPipeline(lang_code="a")
    v = _resolve_kokoro_voice(pipe, voice, fallback)
    chunks = []
    for _, _, audio in pipe(text, voice=v, speed=speed):
        a = audio.detach().cpu().numpy() if hasattr(audio, "detach") else np.asarray(audio)
        chunks.append(a.astype(np.float32).reshape(-1))
    wav = Path(str(out) + ".raw.wav")
    sf.write(str(wav), np.concatenate(chunks), 24000)
    subprocess.run(["ffmpeg", "-y", "-i", str(wav), "-af", af, "-c:a", "libmp3lame", "-q:a", "2", str(out)], check=True)
    wav.unlink(missing_ok=True)


def synth_segments(segments, out_mp3, engine, vc, af, default_voice, speed):
    """Per-beat speaker voices + pause_before silence, concatenated to one mp3. Narrator keeps the default voice/speed."""
    tmp = Path(tempfile.mkdtemp()); clips = []
    pipe = None
    if engine == "kokoro":
        sys.path.insert(0, "C:/AI-Vid/.kokoro_deps")
        from kokoro import KPipeline
        pipe = KPipeline(lang_code="a")
    spk = vc.get("speakers", {})
    for i, seg in enumerate(segments):
        pz = float(seg.get("pause_before", 0.0))
        if pz > 0.02:
            sil = tmp / f"sil_{i:03d}.wav"
            subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", "anullsrc=r=24000:cl=mono", "-t", f"{pz:.3f}", str(sil)], check=True)
            clips.append(sil)
        who = seg.get("speaker", "narrator")
        cs = spk.get(who, {}) if who != "narrator" else {}
        wav = tmp / f"seg_{i:03d}.wav"
        if engine == "kokoro":
            import numpy as np, soundfile as sf
            v = _resolve_kokoro_voice(pipe, cs.get("kokoro", default_voice), vc["kokoro_fallback"])
            ch = [(a.detach().cpu().numpy() if hasattr(a, "detach") else np.asarray(a)).astype(np.float32).reshape(-1)
                  for _, _, a in pipe(seg["text"], voice=v, speed=float(cs.get("speed", speed)))]
            raw = wav.with_suffix(".raw.wav"); sf.write(str(raw), np.concatenate(ch), 24000)
        else:
            import edge_tts
            raw = wav.with_suffix(".raw.mp3")
            for attempt in range(4):
                try:
                    asyncio.run(edge_tts.Communicate(seg["text"], cs.get("edge", vc["edge_voice"]), rate=vc["edge_rate"], pitch=vc["edge_pitch"]).save(str(raw)))
                    break
                except edge_tts.exceptions.NoAudioReceived:
                    if attempt == 3:
                        raise
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", str(raw), "-af", af, "-ar", "24000", "-ac", "1", str(wav)], check=True)
        clips.append(wav)
    lst = tmp / "concat.txt"
    lst.write_text("\n".join(f"file '{str(c).replace(chr(92), '/')}'" for c in clips), encoding="utf-8")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "concat", "-safe", "0", "-i", str(lst), "-c:a", "libmp3lame", "-q:a", "2", str(out_mp3)], check=True)


_DLL_HANDLES = []


def _setup_cuda_dlls():
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
        # No initial_prompt: Whisper treats prompt text as already spoken, skipping the opening lines and looping
        # ("no, no, no..."). script_lock() snaps words to the script afterwards, so the prompt is not needed.
        segs, _ = WhisperModel("small.en", device=device, compute_type=ctype).transcribe(
            str(audio), word_timestamps=True,
            condition_on_previous_text=False,  # stops "no, no, no..." repetition loops on short repeated lines
        )
        return [{"word": w.word.strip(), "start": w.start, "end": w.end} for s in segs for w in (s.words or [])]
    try:
        return run("cuda", "float16")
    except Exception as e:
        print("CUDA whisper failed, using CPU:", e)
        return run("cpu", "int8")


def t_ass(sec):
    return f"{int(sec // 3600)}:{int(sec % 3600 // 60):02d}:{sec % 60:05.2f}"


NO_END = {"to", "into", "in", "on", "of", "for", "with", "at", "by", "from", "the", "a", "an", "my", "his", "her", "our", "their", "your", "and", "or", "but"}


def script_lock(words, script_text):
    toks = script_text.replace('"', '').split()
    norm = lambda s: re.sub(r"\W+", "", s).lower()
    out = []
    for tag, i1, i2, j1, j2 in difflib.SequenceMatcher(None, [norm(w["word"]) for w in words], [norm(x) for x in toks]).get_opcodes():
        ws, ts = words[i1:i2], toks[j1:j2]
        if tag == "equal":
            out += [{"word": x, "start": w["start"], "end": w["end"]} for x, w in zip(ts, ws)]
        elif ts:
            t0 = ws[0]["start"] if ws else (out[-1]["end"] if out else 0.0)
            t1 = ws[-1]["end"] if ws else (words[i1]["start"] if i1 < len(words) else t0 + 0.28 * len(ts))
            step = max(t1 - t0, 0.05 * len(ts)) / len(ts)
            out += [{"word": x, "start": round(t0 + k * step, 3), "end": round(t0 + (k + 1) * step, 3)} for k, x in enumerate(ts)]
    return out


def chunk_words(words, max_words=2, max_chars=12, min_card_sec=0.55):
    merged = []
    for w in words:
        if merged and w["word"].startswith("-"):
            merged[-1] = {"word": merged[-1]["word"] + w["word"], "start": merged[-1]["start"], "end": w["end"]}
        else:
            merged.append(dict(w))
    chunks, cur = [], []
    for w in merged:
        cur.append(w)
        txt = " ".join(x["word"] for x in cur)
        if w["word"][-1:] in ".,!?;:" or (len(cur) >= max_words and w["word"].lower() not in NO_END) or len(cur) > max_words or len(txt) >= max_chars:
            carry = []
            while len(cur) > 1 and cur[-1]["word"][-1:] not in ".,!?;:" and cur[-1]["word"].lower() in NO_END:
                carry.insert(0, cur.pop())
            chunks.append(cur); cur = carry
    if cur:
        chunks.append(cur)
    out = []
    for c in chunks:
        short = (c[-1]["end"] - c[0]["start"]) < min_card_sec
        if out and len(c) == 1 and (len(c[0]["word"]) <= 3 or short) and out[-1][-1]["word"][-1:] not in ".!?" and (c[-1]["word"].lower() not in NO_END or c[-1]["word"][-1:] in ".,!?;:") and len(" ".join(x["word"] for x in out[-1] + c)) <= max_chars + 4:
            out[-1] = out[-1] + c
        else:
            out.append(c)
    return out


def colorize_chunk(c, style, starred=frozenset()):
    if "Pop" not in style:
        return " ".join(w["word"] for w in c).upper()
    out, hit = [], False
    for w in c:
        up = w["word"].upper()
        key = re.sub(r"\W+", "", w["word"]).lower()
        if not hit and key in starred:
            up, hit = "{\\c&H0015CCFA&}" + up + "{\\c&H00FFFFFF&}", True   # starred keyword = gold
        elif not hit and not starred and key in DANGER_WORDS:
            up, hit = "{\\c&H003B3BFF&}" + up + "{\\c&H00FFFFFF&}", True   # bright red BGR
        elif not hit and not starred and key in POWER_WORDS:
            up, hit = "{\\c&H0015CCFA&}" + up + "{\\c&H00FFFFFF&}", True   # vibrant gold BGR
        out.append(up)
    return " ".join(out)


def build_ass(words, style, max_words=2, max_chars=12, font="Arial Black", size=96, margin_v=560, min_card_sec=0.55, starred=frozenset()):
    if style not in STYLES:
        raise ValueError(f"Unsafe caption style {style!r}; allowed: {list(STYLES)}")
    lines = []
    chunks = chunk_words(words, max_words=max_words, max_chars=max_chars, min_card_sec=min_card_sec)
    for i, c in enumerate(chunks):
        t0 = c[0]["start"]
        t1 = max(c[-1]["end"], t0 + min_card_sec)  # >= min hold
        if i + 1 < len(chunks) and chunks[i + 1][0]["start"] > t0:
            t1 = min(t1, chunks[i + 1][0]["start"])
        phrase = colorize_chunk(c, style, starred).replace("—", " ").replace("–", " ").replace("--", " ")
        lines.append(
            f"Dialogue: 0,{t_ass(t0)},{t_ass(t1)},{style},,0,0,0,,"
            "{\\fscx116\\fscy116\\t(0,80,\\fscx100\\fscy100)}" + phrase
        )
    return ass_header(font, size, margin_v) + "\n".join(lines) + "\n"


def main():
    cfg = load_config()
    vc, cc = cfg["voice"], cfg["captions"]
    p = argparse.ArgumentParser()
    p.add_argument("--story-dir", required=True)
    p.add_argument("--text", help="Override narration text")
    p.add_argument("--engine", default=vc["engine"], choices=["kokoro", "edge"])
    p.add_argument("--style", default=cc["style"], choices=list(STYLES))
    p.add_argument("--speed", type=float, default=float(vc["kokoro_speed"]))
    p.add_argument("--kokoro-voice", default=vc["kokoro_voice"])
    p.add_argument("--margin-v", type=int, default=None, help="Override caption MarginV (else story.yaml caption_margin_v, else config)")
    p.add_argument("--subs-only", action="store_true")
    a = p.parse_args()

    d = Path(a.story_dir); d.mkdir(parents=True, exist_ok=True)
    text = a.text or (d / "narration.txt").read_text(encoding="utf-8")
    seg_f = d / "narration_segments.json"
    segments = json.loads(seg_f.read_text(encoding="utf-8")) if seg_f.exists() else []
    starred = {re.sub(r"\W+", "", t).lower() for s_ in segments for m in re.findall(r"\*([^*]+)\*", s_.get("raw_line", "")) for t in m.split()}
    margin_v = a.margin_v
    if margin_v is None:
        margin_v = int(cc["margin_v"])
        sy = d / "story.yaml"
        if sy.exists():
            import yaml
            margin_v = int((yaml.safe_load(sy.read_text(encoding="utf-8")) or {}).get("caption_margin_v", margin_v))
    af = get_silence_af(vc["silence_trigger_sec"], vc["silence_keep_sec"], vc["silence_threshold_db"])

    if a.subs_only:
        words = script_lock(json.loads((d / "words.json").read_text(encoding="utf-8")), text)
    else:
        if segments and not a.text:
            synth_segments(segments, d / "voice.mp3", a.engine, vc, af, a.kokoro_voice, a.speed)
        elif a.engine == "kokoro":
            tts_kokoro(text, d / "voice.mp3", a.kokoro_voice, vc["kokoro_fallback"], a.speed, af)
        else:
            tts_edge(text, d / "voice.mp3", vc["edge_voice"], vc["edge_rate"], vc["edge_pitch"], af)
        raw_words = word_timestamps(d / "voice.mp3", text)
        (d / "raw_transcript.txt").write_text(" ".join(w["word"] for w in raw_words), encoding="utf-8")
        words = script_lock(raw_words, text)

    (d / "words.json").write_text(json.dumps(words, indent=1), encoding="utf-8")
    (d / "subs.ass").write_text(build_ass(words, a.style, cc["max_words_per_card"], cc["max_chars_per_card"], cc["font"], cc["font_size"], margin_v, float(cc.get("min_card_sec", 0.55)), starred), encoding="utf-8")
    dur = words[-1]["end"] if words else 0.0
    wpm = (len(words) / (dur / 60.0)) if dur > 0 else 0.0
    print(f"done: {d} | {len(words)} words | {dur:.1f}s ({wpm:.0f} WPM) | style={a.style} MarginV={margin_v}")


if __name__ == "__main__":
    main()
