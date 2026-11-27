"""AI-Vid V5.4 Story Compiler: story.yaml -> narration.txt, narration_segments.json, beats.json, PUBLISH.md, scenes_<ID>.luau.

Win 2 Upgrade:
  - --sync-words locks every beat's exact t0 and dur directly to <story-dir>/words.json (0 timing drift, 0 manual retiming!).
  - For beat_drop shorts with bpm/drop_at, snaps beat timings to the exact BPM grid.
  - Compiles set, action, move_to, yaw, fx, badge, countdown, prop_stack, gravity, story props and per-beat prop cues into scenes_<ID>.luau.
"""
import argparse, json, re
from pathlib import Path
import yaml
from config_loader import ROOT, load_config


def luau_str(s: str) -> str:
    return '"' + str(s).replace('\\', '\\\\').replace('"', '\\"').replace('\n', ' ') + '"'


def strip_emphasis(text: str) -> str:
    return re.sub(r"\*([^*]+)\*", lambda m: m.group(1), text or "").strip()


def vec3_luau(v) -> str:
    if not v or len(v) < 3:
        return "nil"
    return f"Vector3.new({float(v[0]):.2f}, {float(v[1]):.2f}, {float(v[2]):.2f})"


def sync_beats_to_words(beats: list, words_path: Path) -> tuple[list, bool]:
    if not words_path.exists():
        return beats, False
    words = json.loads(words_path.read_text(encoding="utf-8"))
    if not words:
        return beats, False
    norm = lambda s: re.sub(r"\W+", "", s).lower()
    ws = [norm(w["word"]) for w in words]
    cursor = 0
    matched_spans = []  # (start, end) or None
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

    total_audio = float(words[-1]["end"]) + 0.25
    out = []
    for i, b in enumerate(beats):
        nb = dict(b)
        span = matched_spans[i]
        if span is not None:
            t0 = span[0]
            next_t = next((matched_spans[k][0] for k in range(i + 1, len(beats)) if matched_spans[k] is not None), None)
            if next_t is None:
                next_t = max(total_audio, span[1] + 0.20)
            dur = max(next_t - t0, 0.45)
            if i == len(beats) - 1 and b.get("allow_hold"):  # final beat may hold past the last word (ending button)
                dur = max(dur, float(b.get("dur", dur)))
        else:  # silent/unmatched: explicit dur, placed after previous beat
            t0 = (out[-1]["_t0"] + out[-1]["dur"]) if out else 0.0
            dur = float(b.get("dur", 1.4 if not strip_emphasis(b.get("line") or "") else 1.8))
        nb["_t0"] = round(t0, 3)
        nb["dur"] = round(dur, 3)
        out.append(nb)
    return out, True


def apply_bpm_grid(beats: list, bpm: float | None, drop_at: float | None) -> list:
    if not bpm or bpm <= 0:
        return beats
    bar_sec = (60.0 / float(bpm)) * 4.0  # 4-beat bar
    half_bar = bar_sec / 2.0
    out, t = [], 0.0
    for b in beats:
        nb = dict(b)
        raw_dur = float(b.get("dur", half_bar))
        snapped = max(round(raw_dur / half_bar) * half_bar, half_bar)
        if drop_at and nb.get("fx") in ("neon_flip", "impact", "aura_on") and abs(t - float(drop_at)) < half_bar:
            t = float(drop_at)
        nb["_t0"] = round(t, 3)
        nb["dur"] = round(snapped, 3)
        t += snapped
        out.append(nb)
    return out


def prop_luau(d: dict) -> str:
    """story.yaml prop or prop cue -> Luau table (name, shape, size, color, material, pos, rot, attach, offset, hide, show)."""
    parts = [f"name = {luau_str(d['name'])}"]
    for k in ("shape", "material", "attach", "kit", "text"):  # kit: phone | banner (V6 prop kits)
        if d.get(k):
            parts.append(f"{k} = {luau_str(d[k])}")
    for k in ("size", "pos", "rot", "offset"):
        if d.get(k):
            parts.append(f"{k} = {vec3_luau(d[k])}")
    if d.get("color"):
        c = d["color"]
        parts.append(f"color = Color3.fromRGB({int(c[0])}, {int(c[1])}, {int(c[2])})")
    for k in ("hide", "show"):
        if d.get(k):
            parts.append(f"{k} = true")
    return "{ " + ", ".join(parts) + " }"


SET_GAP = 400.0  # studs between the sets one story builds side by side on X (every set fits inside +-100)


def story_sets(data: dict) -> dict:
    """V6 multi-set: top-level `set` (default, at the origin) + every per-beat `set:` override in order of first use
    -> {set_name: [x_offset, 0, 0]}. The engine builds each set at its offset."""
    order = [data.get("set", "street_day")]
    for b in data.get("beats", []):
        if b.get("set") and b["set"] not in order:
            order.append(b["set"])
    return {name: [i * SET_GAP, 0.0, 0.0] for i, name in enumerate(order)}


def resolve_spots(data: dict, manifest: dict) -> dict:
    """Turn named standing spots (assets/manifest.json sets.<set>.spots: [x, y, z, yaw]) into raw coordinates.
    cast `spot:` -> pos + yaw (default set); beat/partner `spot:` -> move_to (+ yaw); `snap_spot:` -> snap_to (+ yaw),
    looked up in the beat's own `set:` and shifted by that set's offset (explicit coordinates in an offset beat are
    set-local and shifted too). Explicit pos / move_to / snap_to / yaw win. Unknown spot names fail loudly."""
    sets = story_sets(data)
    default = data.get("set", "street_day")
    data["_sets"] = sets

    def look(name, set_name, where):
        spots = manifest.get("sets", {}).get(set_name, {}).get("spots", {})
        if name not in spots:
            raise SystemExit(f"Unknown spot '{name}' in {where} for set '{set_name}'. Valid: {sorted(spots)}")
        x, y, z, yaw = spots[name]
        return [x, y, z], yaw

    def shift(v, off):
        return [float(v[0]) + off[0], float(v[1]) + off[1], float(v[2]) + off[2]]

    for c in data.get("cast", []):
        if c.get("spot"):
            pos, yaw = look(c["spot"], default, f"cast {c.get('name')}")
            c.setdefault("pos", pos); c.setdefault("yaw", yaw)
    for i, b in enumerate(data.get("beats", []), 1):
        bset = b.get("set") or default
        off = sets[bset]
        for item in [b] + [w for w in (b.get("with") or []) if isinstance(w, dict)]:
            if any(off):
                for key in ("move_to", "snap_to"):
                    if item.get(key):
                        item[key] = shift(item[key], off)
            for key, dest in (("spot", "move_to"), ("snap_spot", "snap_to")):
                if item.get(key):
                    pos, yaw = look(item[key], bset, f"beat {i}")
                    item.setdefault(dest, shift(pos, off))
                    if key == "snap_spot":  # beat yaw applies at beat start; a walker would face away before walking
                        item.setdefault("yaw", yaw)
        if any(off):
            cues = b.get("prop") or []
            for cue in ([cues] if isinstance(cues, dict) else cues):
                if cue.get("pos"):
                    cue["pos"] = shift(cue["pos"], off)
    return data  # ponytail: walkers keep travel facing on arrival; add arrival-yaw easing if shots need it


def compile_luau(data: dict, beats: list, default_fov: int = 50) -> str:
    sid = str(data["id"])
    fmt = data.get("format", "story")
    lighting = data.get("lighting", "day_bright")
    set_name = data.get("set", "street_day")

    cast_lines = []
    for c in data.get("cast", []):
        pos = c.get("pos", [0, 0, 0])
        yaw = float(c.get("yaw", 0))
        scale = c.get("scale")
        scale_part = f", scale = {float(scale):.2f}" if scale else ""
        wardrobe = "".join(f", {key} = {int(c[key])}" for key in ("shirt", "pants", "hair") if key in c)
        if c.get("invisible"):
            wardrobe += ", invisible = true"
        if c.get("stone"):
            wardrobe += ", stone = true"
        if c.get("counter") is not None:
            wardrobe += f", counter = {luau_str(c['counter'])}"
        if c.get("scale") is not None:
            wardrobe += f", scale = {float(c['scale'])}"
        cast_lines.append(
            f'  {{ name = {luau_str(c["name"])}, gender = {luau_str(c.get("gender", "boy"))}, '
            f'face = {luau_str(c.get("default_face", "neutral"))}, '
            f'pos = Vector3.new({pos[0]}, {pos[1]}, {pos[2]}), yaw = {yaw:.1f}{scale_part}{wardrobe} }},'
        )

    beat_lines = []
    t_cursor = 0.0
    for idx, b in enumerate(beats, 1):
        t0 = float(b.get("_t0", t_cursor))
        dur = float(b.get("dur", 1.8))
        target = b.get("target", (data.get("cast") or [{"name": "Hero"}])[0]["name"])
        move_to = vec3_luau(b.get("move_to"))
        fov = int(b.get("fov", 48 if b.get("cam") in ("ots", "reverse_ots") else default_fov))
        snap_to = vec3_luau(b.get("snap_to"))
        grav = b.get("gravity")
        grav_str = f", gravity = {float(grav):.1f}" if grav is not None else ""
        stack = b.get("prop_stack")
        stack_str = f", prop_stack = {int(stack)}" if stack is not None else ""
        partners = b.get("with", [])
        partner_entries = []
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
                    if item.get("snap_to"):
                        parts.append(f"snap_to = {vec3_luau(item['snap_to'])}")
                    if item.get("yaw") is not None:
                        parts.append(f"yaw = {float(item['yaw']):.1f}")
                    if item.get("counter") is not None:
                        parts.append(f"counter = {luau_str(item['counter'])}")
                    if item.get("scale") is not None:
                        parts.append(f"scale = {float(item['scale'])}")
                    if item.get("face_mid"):
                        parts.append(f"face_mid = {luau_str(item['face_mid'])}")
                    if item.get("invisible") is not None:
                        parts.append(f"invisible = {'true' if item['invisible'] else 'false'}")
                    if item.get("stone") is not None:
                        parts.append(f"stone = {'true' if item['stone'] else 'false'}")
                    partner_entries.append("{ " + ", ".join(parts) + " }")
                else:
                    partner_entries.append(f"{{ name = {luau_str(item)} }}")
        partner_str = ", partners = {" + ", ".join(partner_entries) + "}" if partner_entries else ""
        # V6: unset = engine auto-faces partners; only an explicit true/false is written
        face_partner = {True: ", face_partner = true", False: ", face_partner = false"}.get(b.get("face_partner"), "")
        clear_badge = ", clear_badge = true" if b.get("clear_badge") else ""
        yaw_str = f", yaw = {float(b['yaw']):.1f}" if b.get("yaw") is not None else ""
        if b.get("set"):
            yaw_str += f", set = {luau_str(b['set'])}"
        if b.get("counter") is not None:
            yaw_str += f", counter = {luau_str(b['counter'])}"
        if b.get("scale") is not None:
            yaw_str += f", scale = {float(b['scale'])}"
        if b.get("face_mid"):
            yaw_str += f", face_mid = {luau_str(b['face_mid'])}"
        if b.get("invisible") is not None:
            yaw_str += f", invisible = {'true' if b['invisible'] else 'false'}"
        if b.get("stone") is not None:
            yaw_str += f", stone = {'true' if b['stone'] else 'false'}"
        cues = b.get("prop") or []
        cues = [cues] if isinstance(cues, dict) else cues
        prop_str = ", props = {" + ", ".join(prop_luau(c) for c in cues) + "}" if cues else ""
        beat_lines.append(
            f'  {{ n = {idx}, t0 = {t0:.3f}, dur = {dur:.3f}, cam = {luau_str(b.get("cam", "closeup"))}, fov = {fov}, '
            f'motion = {luau_str(b.get("motion", "push_in"))}, target = {luau_str(target)}, '
            f'action = {luau_str(b.get("action", "idle"))}, move_to = {move_to}, snap_to = {snap_to}, '
            f'face = {luau_str(b.get("face", ""))}, fx = {luau_str(b.get("fx", ""))}, '
            f'badge = {luau_str(b.get("badge", ""))}{grav_str}{stack_str}{partner_str}{face_partner}{clear_badge}{prop_str}{yaw_str} }},'
        )
        t_cursor = t0 + dur

    return f"""-- Auto-compiled by pipeline/compile_story.py (V5.4) — do not hand-edit
-- Story {sid}: {data.get("title", "")} | Format: {fmt} | Set: {set_name}
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {{
  id = {luau_str(sid)},
  wardrobe_seed = {luau_str(str(data.get('wardrobe_seed') or sid))},
  format = {luau_str(fmt)},
  set = {luau_str(set_name)},
  lighting = {luau_str(lighting)},
  sets = {{ {", ".join("{ name = " + luau_str(n) + ", offset = " + vec3_luau(o) + " }" for n, o in (data.get("_sets") or story_sets(data)).items())} }},
  totalDuration = {t_cursor:.3f},
  cast = {{
{chr(10).join(cast_lines)}
  }},
  props = {{
{chr(10).join("  " + prop_luau(pr) + "," for pr in data.get("props", []))}
  }},
  beats = {{
{chr(10).join(beat_lines)}
  }},
}}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
"""


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--story", required=True, help="Path to stories/<ID>_<slug>/story.yaml")
    p.add_argument("--sync-words", action="store_true", help="Lock beat t0/dur to <story-dir>/words.json")
    a = p.parse_args()

    cfg = load_config()
    sp = Path(a.story).resolve()
    sdir = sp.parent
    data = yaml.safe_load(sp.read_text(encoding="utf-8"))
    resolve_spots(data, json.loads((ROOT / "assets" / "manifest.json").read_text(encoding="utf-8")))

    fmt = data.get("format", "story")
    beats = list(data.get("beats", []))

    # 1. narration.txt
    segments = []
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

    # 2. Timing resolution: words.json auto-sync OR BPM grid for beat_drop
    synced = False
    if a.sync_words or (sdir / "words.json").exists():
        beats, synced = sync_beats_to_words(beats, sdir / "words.json")
    elif fmt == "beat_drop" and data.get("bpm"):
        beats = apply_bpm_grid(beats, data.get("bpm"), data.get("drop_at"))

    # 3. beats.json
    beat_objs, t_cursor = [], 0.0
    for idx, b in enumerate(beats, 1):
        t0 = float(b.get("_t0", t_cursor))
        dur = float(b.get("dur", 1.8))
        beat_objs.append({
            "n": idx, "start": round(t0, 3), "dur": round(dur, 3),
            "line": strip_emphasis(b.get("line", "")), "speaker": b.get("speaker", "narrator"), "fov": int(b.get("fov", 48 if b.get("cam") in ("ots", "reverse_ots") else cfg["video"].get("default_fov", 50))), "cam": b.get("cam", "closeup"),
            "motion": b.get("motion", "push_in"), "action": b.get("action", "idle"),
            "sfx": b.get("sfx", ""), "fx": b.get("fx", ""),
            "bgm_duck": bool(b.get("bgm_duck", False)), "bgm_climax": bool(b.get("bgm_climax", False)),
            "face": b.get("face", ""), "overlay": b.get("overlay", ""), "overlay_text": b.get("overlay_text", ""),
        })
        t_cursor = t0 + dur
    (sdir / "beats.json").write_text(json.dumps({"id": data["id"], "format": fmt, "synced_to_words": synced, "beats": beat_objs}, indent=2), encoding="utf-8")

    # 4. Declarative Luau scene file
    luau_out = ROOT / "engines" / "roblox" / f"scenes_{data['id']}.luau"
    luau_out.parent.mkdir(parents=True, exist_ok=True)
    luau_out.write_text(compile_luau(data, beats, int(cfg["video"].get("default_fov", 50))), encoding="utf-8")

    # 5. PUBLISH.md
    playlist = cfg["playlists"].get(fmt, "In This World Stories")
    tags = data.get("hashtags") or cfg["channel"]["default_hashtags"]
    tag_str = " ".join(tags[:5])
    clean_title = re.sub(r"\s*#\w+", "", data["title"]).strip()  # hashtags live in description only
    pub = (
        f"# Publish Metadata — Story {data['id']}\n\n"
        f"**Playlist:** {playlist}\n"
        f"**Format:** `{fmt}` | **Set:** `{data.get('set', 'street_day')}` | **Mood BGM:** `{data.get('bgm_mood', 'mystery')}` | **Duration:** {t_cursor:.2f}s\n\n"
        f"## Title\n{clean_title}\n\n"
        f"## Description\n{data.get('description', data['title'])}\n\n{tag_str}\n"
    )
    (sdir / "PUBLISH.md").write_text(pub, encoding="utf-8")
    print(f"Compiled Story {data['id']} ({fmt}) -> {len(beats)} beats ({t_cursor:.2f}s, words_synced={synced}) | {luau_out.name}")


if __name__ == "__main__":
    main()
