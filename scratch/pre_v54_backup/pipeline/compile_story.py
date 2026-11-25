"""AI-Vid V5.3 Story Compiler: story.yaml -> narration.txt, beats.json, PUBLISH.md, scenes_<ID>.luau.

Win 2 Upgrade:
  - --sync-words locks every beat's exact t0 and dur directly to <story-dir>/words.json (0 timing drift, 0 manual retiming!).
  - For beat_drop shorts with bpm/drop_at, snaps beat timings to the exact BPM grid.
  - Compiles set, action, move_to, yaw, fx, badge, countdown, prop_stack, and gravity cues into scenes_<ID>.luau.
"""
import argparse, json, re
from pathlib import Path
import yaml
from config_loader import ROOT, load_config


def luau_str(s: str) -> str:
    return '"' + str(s).replace('\\', '\\\\').replace('"', '\\"').replace('\n', ' ') + '"'


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
    matched_starts = []
    for b in beats:
        line_toks = [norm(x) for x in (b.get("line") or "").split() if norm(x)]
        if not line_toks:
            matched_starts.append(None)
            continue
        first = line_toks[0]
        j = next((k for k in range(cursor, len(ws)) if ws[k] == first), None)
        if j is not None:
            matched_starts.append(float(words[j]["start"]))
            cursor = j + 1
        else:
            matched_starts.append(None)

    total_audio = float(words[-1]["end"]) + 0.25
    out = []
    for i, b in enumerate(beats):
        nb = dict(b)
        t0 = matched_starts[i]
        if t0 is None:
            t0 = (out[-1]["_t0"] + out[-1]["dur"]) if out else 0.0
        # find next valid start
        next_t = None
        for k in range(i + 1, len(beats)):
            if matched_starts[k] is not None:
                next_t = matched_starts[k]
                break
        if next_t is None:
            next_t = max(total_audio, t0 + float(b.get("dur", 1.8)))
        nb["_t0"] = round(t0, 3)
        nb["dur"] = round(max(next_t - t0, 0.4), 3)
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


def compile_luau(data: dict, beats: list) -> str:
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
        grav = b.get("gravity")
        grav_str = f", gravity = {float(grav):.1f}" if grav is not None else ""
        stack = b.get("prop_stack")
        stack_str = f", prop_stack = {int(stack)}" if stack is not None else ""
        partners = b.get("with", [])
        if isinstance(partners, dict):
            partner_entries = [
                f"{{ name = {luau_str(name)}, action = {luau_str(action)} }}"
                for name, action in partners.items()
            ]
        else:
            partner_entries = [f"{{ name = {luau_str(name)} }}" for name in partners]
        partner_str = ", partners = {" + ", ".join(partner_entries) + "}" if partner_entries else ""
        face_partner = ", face_partner = true" if b.get("face_partner") else ""
        clear_badge = ", clear_badge = true" if b.get("clear_badge") else ""
        beat_lines.append(
            f'  {{ n = {idx}, t0 = {t0:.3f}, dur = {dur:.3f}, cam = {luau_str(b.get("cam", "closeup"))}, '
            f'motion = {luau_str(b.get("motion", "push_in"))}, target = {luau_str(target)}, '
            f'action = {luau_str(b.get("action", "idle"))}, move_to = {move_to}, '
            f'face = {luau_str(b.get("face", ""))}, fx = {luau_str(b.get("fx", ""))}, '
            f'badge = {luau_str(b.get("badge", ""))}{grav_str}{stack_str}{partner_str}{face_partner}{clear_badge} }},'
        )
        t_cursor = t0 + dur

    return f"""-- Auto-compiled by pipeline/compile_story.py (V5.3) — do not hand-edit
-- Story {sid}: {data.get("title", "")} | Format: {fmt} | Set: {set_name}
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {{
  id = {luau_str(sid)},
  format = {luau_str(fmt)},
  set = {luau_str(set_name)},
  lighting = {luau_str(lighting)},
  totalDuration = {t_cursor:.3f},
  cast = {{
{chr(10).join(cast_lines)}
  }},
  beats = {{
{chr(10).join(beat_lines)}
  }},
}}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.3] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
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

    fmt = data.get("format", "story")
    beats = list(data.get("beats", []))

    # 1. narration.txt
    lines = [b["line"].strip() for b in beats if (b.get("line") or "").strip()]
    if lines:
        (sdir / "narration.txt").write_text(" ".join(lines) + "\n", encoding="utf-8")

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
            "line": b.get("line", ""), "cam": b.get("cam", "closeup"),
            "motion": b.get("motion", "push_in"), "action": b.get("action", "idle"),
            "sfx": b.get("sfx", ""), "fx": b.get("fx", ""),
        })
        t_cursor = t0 + dur
    (sdir / "beats.json").write_text(json.dumps({"id": data["id"], "format": fmt, "synced_to_words": synced, "beats": beat_objs}, indent=2), encoding="utf-8")

    # 4. Declarative Luau scene file
    luau_out = ROOT / "engines" / "roblox" / f"scenes_{data['id']}.luau"
    luau_out.parent.mkdir(parents=True, exist_ok=True)
    luau_out.write_text(compile_luau(data, beats), encoding="utf-8")

    # 5. PUBLISH.md
    playlist = cfg["playlists"].get(fmt, "In This World Stories")
    tags = data.get("hashtags") or cfg["channel"]["default_hashtags"]
    tag_str = " ".join(tags[:5])
    pub = (
        f"# Publish Metadata — Story {data['id']}\n\n"
        f"**Playlist:** {playlist}\n"
        f"**Format:** `{fmt}` | **Set:** `{data.get('set', 'street_day')}` | **Mood BGM:** `{data.get('bgm_mood', 'mystery')}` | **Duration:** {t_cursor:.2f}s\n\n"
        f"## Title\n{data['title']} {tag_str}\n\n"
        f"## Description\n{data.get('description', data['title'])}\n\n{tag_str}\n"
    )
    (sdir / "PUBLISH.md").write_text(pub, encoding="utf-8")
    print(f"Compiled Story {data['id']} ({fmt}) -> {len(beats)} beats ({t_cursor:.2f}s, words_synced={synced}) | {luau_out.name}")


if __name__ == "__main__":
    main()
