p='pipeline/compile_story.py'
s=open(p,encoding='utf8').read()
def rep(a,b):
    global s
    assert s.count(a)==1,(a,s.count(a)); s=s.replace(a,b)
rep('V5.3 Story Compiler: story.yaml -> narration.txt,','V5.4 Story Compiler: story.yaml -> narration.txt, narration_segments.json,')
rep('def vec3_luau','def strip_emphasis(text: str) -> str:\n    return re.sub(r"\*([^*]+)\*", r"\1", text or "").strip()\n\n\ndef vec3_luau')
a=s.index('    matched_starts = []'); b=s.index('    total_audio')
s=s[:a]+r'''    matched_spans = []  # (start, end) or None
    for b in beats:
        line_toks = [norm(x) for x in strip_emphasis(b.get("line") or "").split() if norm(x)]
        if not line_toks:  # silent reaction beat: keeps its explicit dur
            matched_spans.append(None)
            continue
        found = None
        for win in (min(3, len(line_toks)), min(2, len(line_toks)), 1):  # 3-, 2-, then 1-word window
            needle = line_toks[:win]
            found = next((k for k in range(cursor, len(ws) - win + 1) if ws[k:k + win] == needle), None)
            if found is not None:
                break
        if found is not None:
            end_idx = min(found + len(line_toks) - 1, len(words) - 1)
            matched_spans.append((float(words[found]["start"]), float(words[end_idx]["end"])))
            cursor = min(found + max(1, len(line_toks) - 1), len(ws))
        else:
            matched_spans.append(None)

'''+s[b:]
a=s.index('        t0 = matched_starts[i]'); b=s.index('        nb["_t0"]')
s=s[:a]+r'''        span = matched_spans[i]
        if span is not None:
            t0 = span[0]
            next_t = next((matched_spans[k][0] for k in range(i + 1, len(beats)) if matched_spans[k] is not None), None)
            if next_t is None:
                next_t = max(total_audio, span[1] + 0.20)
            dur = max(next_t - t0, 0.45)
        else:  # silent/unmatched: explicit dur, placed after previous beat
            t0 = (out[-1]["_t0"] + out[-1]["dur"]) if out else 0.0
            dur = float(b.get("dur", 1.4 if not strip_emphasis(b.get("line") or "") else 1.8))
'''+s[b:]
rep('        nb["dur"] = round(max(next_t - t0, 0.4), 3)','        nb["dur"] = round(dur, 3)')
rep('def compile_luau(data: dict, beats: list) -> str:','def compile_luau(data: dict, beats: list, default_fov: int = 50) -> str:')
rep('        move_to = vec3_luau(b.get("move_to"))\n','        move_to = vec3_luau(b.get("move_to"))\n        fov = int(b.get("fov", default_fov))\n        snap_to = vec3_luau(b.get("snap_to"))\n')
a=s.index('        if isinstance(partners, dict):'); b=s.index('        partner_str')
s=s[:a]+r'''        partner_entries = []
        if isinstance(partners, dict):
            for name, action in partners.items():
                partner_entries.append(f"{{ name = {luau_str(name)}, action = {luau_str(action)} }}")
        else:
            for item in partners:
                if isinstance(item, dict):  # {name, action, face, move_to}
                    parts = [f"name = {luau_str(item['name'])}"]
                    if item.get("action"):
                        parts.append(f"action = {luau_str(item['action'])}")
                    if item.get("face"):
                        parts.append(f"face = {luau_str(item['face'])}")
                    if item.get("move_to"):
                        parts.append(f"move_to = {vec3_luau(item['move_to'])}")
                    partner_entries.append("{ " + ", ".join(parts) + " }")
                else:
                    partner_entries.append(f"{{ name = {luau_str(item)} }}")
'''+s[b:]
rep('cam = {luau_str(b.get("cam", "closeup"))}, \'','cam = {luau_str(b.get("cam", "closeup"))}, fov = {fov}, \'')
rep("move_to = {move_to}, '","move_to = {move_to}, snap_to = {snap_to}, '")
rep('(V5.3) — do not','(V5.4) — do not'); rep('[AI-Vid V5.3] Story','[AI-Vid V5.4] Story')
a=s.index('    lines = [b["line"]'); b=s.index('    # 2. Timing')
s=s[:a]+r'''    segments = []
    for idx, b in enumerate(beats, 1):
        raw = (b.get("line") or "").strip()
        if raw:
            pz = b.get("pause", b.get("pause_before", 0.0))  # seconds, or true = twist pause
            pz = float(cfg["voice"].get("twist_pause_sec", 0.3)) if pz is True else float(pz or 0.0)
            segments.append({"beat": idx, "speaker": b.get("speaker", "narrator"), "pause_before": pz,
                             "raw_line": raw, "text": strip_emphasis(raw)})
    if segments:
        (sdir / "narration.txt").write_text(" ".join(x["text"] for x in segments) + "\n", encoding="utf-8")
        (sdir / "narration_segments.json").write_text(json.dumps(segments, indent=2), encoding="utf-8")

'''+s[b:]
rep('"line": b.get("line", ""), "cam"','"line": strip_emphasis(b.get("line", "")), "speaker": b.get("speaker", "narrator"), "fov": int(b.get("fov", cfg["video"].get("default_fov", 50))), "cam"')
rep('compile_luau(data, beats)','compile_luau(data, beats, int(cfg["video"].get("default_fov", 50)))')
rep('    pub = (','    clean_title = re.sub(r"\s*#\w+", "", data["title"]).strip()  # hashtags live in description only\n    pub = (')
rep("{data['title']} {tag_str}", "{clean_title}")
open(p,'w',encoding='utf8',newline='').write(s)
