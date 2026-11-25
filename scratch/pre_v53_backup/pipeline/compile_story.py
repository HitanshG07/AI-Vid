"""Compile a single compact story.yaml into narration.txt, beats.json, PUBLISH.md, and scenes_<ID>.luau (0 AI tokens!).

Usage:
  python pipeline/compile_story.py --story stories/016_slug/story.yaml
"""
import argparse, json
from pathlib import Path
import yaml
from config_loader import ROOT, load_config


def luau_str(s: str) -> str:
    return '"' + str(s).replace('\\', '\\\\').replace('"', '\\"').replace('\n', ' ') + '"'


def compile_luau(data: dict) -> str:
    sid = str(data["id"])
    fmt = data.get("format", "story")
    lighting = data.get("lighting", "day_bright")
    cast_lines = []
    for c in data.get("cast", []):
        cast_lines.append(
            f'  {{ name = {luau_str(c["name"])}, gender = {luau_str(c.get("gender", "boy"))}, '
            f'face = {luau_str(c.get("default_face", "neutral"))}, '
            f'pos = Vector3.new({c.get("pos", [0,3,0])[0]}, {c.get("pos", [0,3,0])[1]}, {c.get("pos", [0,3,0])[2]}) }},'
        )
    beat_lines = []
    t_cursor = 0.0
    for idx, b in enumerate(data.get("beats", []), 1):
        dur = float(b.get("dur", 1.8))
        cam = b.get("cam", "closeup")
        motion = b.get("motion", "push_in")
        target = b.get("target", (data.get("cast") or [{"name": "Hero"}])[0]["name"])
        face = b.get("face", "")
        fx = b.get("fx", "")
        badge = b.get("badge", "")
        action = b.get("action", "idle")
        beat_lines.append(
            f'  {{ n = {idx}, t0 = {t_cursor:.2f}, dur = {dur:.2f}, cam = {luau_str(cam)}, '
            f'motion = {luau_str(motion)}, target = {luau_str(target)}, action = {luau_str(action)}, '
            f'face = {luau_str(face)}, fx = {luau_str(fx)}, badge = {luau_str(badge)} }},'
        )
        t_cursor += dur

    return f"""-- Auto-compiled by pipeline/compile_story.py from story.yaml (do not hand-edit)
-- Story {sid}: {data.get("title", "")} | Format: {fmt}
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {{
  id = {luau_str(sid)},
  format = {luau_str(fmt)},
  lighting = {luau_str(lighting)},
  totalDuration = {t_cursor:.2f},
  cast = {{
{chr(10).join(cast_lines)}
  }},
  beats = {{
{chr(10).join(beat_lines)}
  }},
}}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5] Story %s ready (%.1fs, %d beats)", SceneSpec.id, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
"""


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--story", required=True, help="Path to stories/<ID>_<slug>/story.yaml")
    a = p.parse_args()

    cfg = load_config()
    sp = Path(a.story).resolve()
    sdir = sp.parent
    data = yaml.safe_load(sp.read_text(encoding="utf-8"))

    fmt = data.get("format", "story")
    beats = data.get("beats", [])

    # 1. narration.txt (skip empty lines for beat_drop music-only shorts)
    lines = [b["line"].strip() for b in beats if (b.get("line") or "").strip()]
    if lines:
        (sdir / "narration.txt").write_text(" ".join(lines) + "\n", encoding="utf-8")

    # 2. beats.json (compatible with finish_video.py & qa_sheet.py)
    beat_objs = []
    t_cursor = 0.0
    for idx, b in enumerate(beats, 1):
        dur = float(b.get("dur", 1.8))
        beat_objs.append({
            "n": idx,
            "start": round(t_cursor, 2),
            "dur": dur,
            "line": b.get("line", ""),
            "cam": b.get("cam", "closeup"),
            "motion": b.get("motion", "push_in"),
            "sfx": b.get("sfx", ""),
            "fx": b.get("fx", ""),
        })
        t_cursor += dur
    (sdir / "beats.json").write_text(json.dumps({"id": data["id"], "format": fmt, "beats": beat_objs}, indent=2), encoding="utf-8")

    # 3. Declarative Luau scene file (tiny!)
    luau_out = ROOT / "engines" / "roblox" / f"scenes_{data['id']}.luau"
    luau_out.parent.mkdir(parents=True, exist_ok=True)
    luau_out.write_text(compile_luau(data), encoding="utf-8")

    # 4. PUBLISH.md
    playlist = cfg["playlists"].get(fmt, "In This World Stories")
    tags = data.get("hashtags") or cfg["channel"]["default_hashtags"]
    tag_str = " ".join(tags[:5])
    pub = (
        f"# Publish Metadata — Story {data['id']}\n\n"
        f"**Playlist:** {playlist}\n"
        f"**Format:** `{fmt}` | **Mood BGM:** `{data.get('bgm_mood', 'mystery')}` | **Est. Duration:** {t_cursor:.1f}s\n\n"
        f"## Title\n{data['title']} {tag_str}\n\n"
        f"## Description\n{data.get('description', data['title'])}\n\n{tag_str}\n"
    )
    (sdir / "PUBLISH.md").write_text(pub, encoding="utf-8")
    print(f"Compiled Story {data['id']} ({fmt}) -> {len(beats)} beats ({t_cursor:.1f}s) | {luau_out.name}")


if __name__ == "__main__":
    main()
