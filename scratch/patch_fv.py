p='pipeline/finish_video.py'
s=open(p,encoding='utf8').read()
def rep(a,b):
    global s
    assert s.count(a)==1,(a,s.count(a)); s=s.replace(a,b)
rep('def sfx_cues(beats_json: Path, words_json: Path | None):\n    beats = json.loads(beats_json.read_text(encoding="utf-8"))\n    beats = beats.get("beats", beats) if isinstance(beats, dict) else beats\n',
r'''def load_beats(beats_json: Path | None) -> list:
    if not beats_json or not beats_json.exists():
        return []
    raw = json.loads(beats_json.read_text(encoding="utf-8"))
    return raw.get("beats", raw) if isinstance(raw, dict) else raw


def build_bgm_volume_expr(beats: list, lead: float, base_g: float, duck_g: float, climax_g: float) -> str:
    """ffmpeg volume expr: base gain, near-silence on bgm_duck beats (music drop), louder on bgm_climax beats."""
    expr = f"{base_g:.3f}"
    for b in reversed(beats):
        t0 = float(b.get("start", 0.0)) + lead
        t1 = t0 + float(b.get("dur", 1.8))
        if b.get("bgm_duck"):
            expr = f"if(between(t,{t0:.2f},{t1:.2f}),{duck_g:.3f},{expr})"
        elif b.get("bgm_climax"):
            expr = f"if(between(t,{t0:.2f},{t1:.2f}),{climax_g:.3f},{expr})"
    return expr


# ponytail: SFX are still synthesized sine beeps (make_sfx.py); swap in owner-sourced CC0 wavs in assets/sfx/ -- do not auto-download.
def sfx_cues(beats: list, words_json: Path | None):
''')
rep('    ws, i, cues = [norm(w["word"]) for w in words], 0, []','    ws, i, cues, missing = [norm(w["word"]) for w in words], 0, [], []')
rep('''        if not name or not (SFX_DIR / f"{name}.wav").exists():
            continue''','''        if not name:
            continue
        if not (SFX_DIR / f"{name}.wav").exists():
            missing.append(name)
            continue''')
rep('            first = next((norm(x) for x in b["line"].split() if norm(x)), None)','            first = next((norm(x) for x in b["line"].split() if norm(x)), None)  # first-word match, same as compile (ponytail: 1 word)')
rep('    return cues\n','    return cues, missing\n')
rep('''    if bgm_file and not bgm_file.exists():
        bgm_file = SFX_DIR / "roblox-story-bg.mp3"
    use_bgm''','''    bgm_status = "exact"
    if a.bgm_mood != "none" and bgm_file and not bgm_file.exists():
        print(f"!!! WARNING: BGM mood '{a.bgm_mood}' track MISSING: {bgm_file} -> FALLING BACK to roblox-story-bg.mp3. Add the file or pick another mood.")
        bgm_status = "FALLBACK"
        bgm_file = SFX_DIR / "roblox-story-bg.mp3"
    use_bgm''')
rep('''    cues = sfx_cues(beats_p, None if a.music_only else (d / "words.json")) if beats_p else []
''','''    beats = load_beats(beats_p)
    cues, missing_sfx = sfx_cues(beats, None if a.music_only else (d / "words.json"))
    print(f"[AUDIO REPORT] BGM mood='{a.bgm_mood}' [{bgm_status}] file={bgm_file if use_bgm else 'none'}")
    print(f"[AUDIO REPORT] SFX resolved={[str(f) for _, f, _ in cues] or 'none'}")
    if missing_sfx:
        print(f"!!! WARNING: SFX named in beats but missing in {SFX_DIR}: {missing_sfx}")
    bgm_vol = f"'{build_bgm_volume_expr(beats, a.lead, a.bgm_gain, float(cfg['audio']['duck_bgm_gain']), float(cfg['audio']['climax_bgm_gain']))}':eval=frame"
''')
rep('volume={a.bgm_gain}[bgm];")\n                labels.append("[bgm]")','volume={bgm_vol}[bgm];")\n                labels.append("[bgm]")')
rep('volume={a.bgm_gain}[bgm];")\n            labels.append("[bgm]")','volume={bgm_vol}[bgm];")\n            labels.append("[bgm]")')
open(p,'w',encoding='utf8',newline='').write(s)

p='pipeline/run_take.py'
s=open(p,encoding='utf8').read()
rep('    if raw.exists() and not trimmed.exists():','    if raw.exists():  # always re-trim: a retake must never reuse a stale trimmed.mp4')
rep('    src_vid = trimmed if trimmed.exists() else raw','    src_vid = trimmed if raw.exists() else raw')
open(p,'w',encoding='utf8',newline='').write(s)
