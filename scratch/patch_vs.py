p='pipeline/voice_subs.py'
s=open(p,encoding='utf8').read()
def rep(a,b):
    global s
    assert s.count(a)==1,(a,s.count(a)); s=s.replace(a,b)
rep('import argparse, asyncio, difflib, json, os, re, subprocess, sys\n','import argparse, asyncio, difflib, json, os, re, subprocess, sys, tempfile\n')
rep('    "LowerThirdPop":   ("&H00FFFFFF", 2, 235),   # legacy V4\n','')
rep(r'''def ass_header(font="Arial Black", size=82):
    styles = "\n".join(
        f"Style: {n},{font},{size},{c},&H00FFFFFF,&H00000000,&H64000000,-1,0,0,0,100,100,0,0,1,7,3,{a},90,90,{m},1"
        for n, (c, a, m) in STYLES.items()
    )''', r'''def ass_header(font="Arial Black", size=96, margin_v=560):
    styles = "\n".join(
        f"Style: {n},{font},{size},{c},&H00FFFFFF,&H00000000,&H64000000,-1,0,0,0,100,100,0,0,1,8,3,{a},90,90,{margin_v if n.startswith('SafeCenter') else m},1"
        for n, (c, a, m) in STYLES.items()
    )''')
rep('_DLL_HANDLES = []', r'''def synth_segments(segments, out_mp3, engine, vc, af, default_voice, speed):
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


_DLL_HANDLES = []''')
rep('def chunk_words(words, max_words=3, max_chars=16):','def chunk_words(words, max_words=2, max_chars=12, min_card_sec=0.55):')
rep('''    for c in chunks:
        if out and len(c) == 1 and len(c[0]["word"]) <= 3 and''','''    for c in chunks:
        short = (c[-1]["end"] - c[0]["start"]) < min_card_sec
        if out and len(c) == 1 and (len(c[0]["word"]) <= 3 or short) and''')
rep('def colorize_chunk(c, style):','def colorize_chunk(c, style, starred=frozenset()):')
rep('        if not hit and key in DANGER_WORDS:', r'''        if not hit and key in starred:
            up, hit = "{\\c&H0015CCFA&}" + up + "{\\c&H00FFFFFF&}", True   # starred keyword = gold
        elif not hit and not starred and key in DANGER_WORDS:''')
rep('        elif not hit and key in POWER_WORDS:','        elif not hit and not starred and key in POWER_WORDS:')
rep('''def build_ass(words, style, max_words=3, max_chars=16, font="Arial Black", size=82):
    lines = []
    for c in chunk_words(words, max_words=max_words, max_chars=max_chars):
        phrase = colorize_chunk(c, style)''','''def build_ass(words, style, max_words=2, max_chars=12, font="Arial Black", size=96, margin_v=560, min_card_sec=0.55, starred=frozenset()):
    if style not in STYLES:
        raise ValueError(f"Unsafe caption style {style!r}; allowed: {list(STYLES)}")
    lines = []
    chunks = chunk_words(words, max_words=max_words, max_chars=max_chars, min_card_sec=min_card_sec)
    for i, c in enumerate(chunks):
        t0 = c[0]["start"]
        t1 = max(c[-1]["end"], t0 + min_card_sec)  # >= min hold
        if i + 1 < len(chunks) and chunks[i + 1][0]["start"] > t0:
            t1 = min(t1, chunks[i + 1][0]["start"]) if chunks[i + 1][0]["start"] - t0 >= min_card_sec else t1
        phrase = colorize_chunk(c, style, starred)''')
rep('''f"Dialogue: 0,{t_ass(c[0]['start'])},{t_ass(c[-1]['end'])},{style},,0,0,0,,"''','''f"Dialogue: 0,{t_ass(t0)},{t_ass(t1)},{style},,0,0,0,,"''')
rep('    return ass_header(font, size) + "\\n".join(lines)','    return ass_header(font, size, margin_v) + "\\n".join(lines)')
rep('    p.add_argument("--subs-only", action="store_true")','    p.add_argument("--margin-v", type=int, default=None, help="Override caption MarginV (else story.yaml caption_margin_v, else config)")\n    p.add_argument("--subs-only", action="store_true")')
rep('''        if a.engine == "kokoro":
            tts_kokoro(text, d / "voice.mp3", a.kokoro_voice''','''        if segments and not a.text:
            synth_segments(segments, d / "voice.mp3", a.engine, vc, af, a.kokoro_voice, a.speed)
        elif a.engine == "kokoro":
            tts_kokoro(text, d / "voice.mp3", a.kokoro_voice''')
rep('    af = get_silence_af(','''    seg_f = d / "narration_segments.json"
    segments = json.loads(seg_f.read_text(encoding="utf-8")) if seg_f.exists() else []
    starred = {re.sub(r"\\W+", "", t).lower() for s_ in segments for m in re.findall(r"\\*([^*]+)\\*", s_.get("raw_line", "")) for t in m.split()}
    margin_v = a.margin_v
    if margin_v is None:
        margin_v = int(cc["margin_v"])
        sy = d / "story.yaml"
        if sy.exists():
            import yaml
            margin_v = int((yaml.safe_load(sy.read_text(encoding="utf-8")) or {}).get("caption_margin_v", margin_v))
    af = get_silence_af(''')
rep('cc["font"], cc["font_size"]), encoding','cc["font"], cc["font_size"], margin_v, float(cc.get("min_card_sec", 0.55)), starred), encoding')
rep('style={a.style}")','style={a.style} MarginV={margin_v}")')
open(p,'w',encoding='utf8',newline='').write(s)
