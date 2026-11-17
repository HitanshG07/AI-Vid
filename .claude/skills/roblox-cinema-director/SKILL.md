---
name: roblox-cinema-director
description: Directing rules for Roblox story shorts. Covers shot grammar, faces, VFX, subtitles and QA, built on the locked R6 catalog characters, our 2D face decals and the per-story MANIFEST.md. Use when planning or fixing cameras, beats or visual quality.
---

# Roblox Cinema Director

Source of truth: `AGENTS.md`, `docs/LESSONS_LEARNED.md` (grade presets still in `docs/ARGON_PIPELINE.md`). The story's spec is `stories/<ID>_<slug>/MANIFEST.md`, section G.

## Hard bans
- No non-Roblox bodies, no Blender/Argon/mesh-built characters, no R15 default rigs, no default `:|` faces, no cloned or bare extras.
- Faces are only our flat 2D decals (`assets/faces/classic_v1/`: neutral, scared, shocked, grin, determined, proud). Swap by changing the Head `face` Decal Texture; manifest face names come from that set (new ones are added to `engines/faces/classic_faces.py`).
- No slideshows or OpenCV boxes. Render in Roblox Studio (Future lighting).
- No dead-center subtitles. Captions are 1–3 words, lower third (Y≈82%, default) or upper third (Y≈15%) per AGENTS.md, and never end on a function word.
- No robotic TTS. Use Edge-TTS AndrewNeural, with Faster-Whisper timing via `pipeline/voice_subs.py`.

## Shot grammar
- Hook: a big face or the key action inside the first ~1.2 s.
- Cut or change the camera every 1.2–2 s (3 s max).
- Camera mix (AGENTS.md): ~60% slow push-in, ~25% snap pull-out, ~15% impact snap-zoom with 2.5° Dutch. Section G names the mode per beat; count them before handing the table over.
- Camera code: `CameraType = Scriptable` before setting CFrame, or the default camera scripts overwrite it; FOV clamps to 1–120 (default 70) and extremes are discouraged (Creator Hub, Camera class). Our ranges: ~50 default, 38–45 for inserts (LESSONS). A plain FOV tween is not a dolly zoom; distance must change with FOV.
- Face shots: subject yaw ≤40°, never their back.
- Every camera goes through `clearShot` so no prop or rig covers a face.
- Props sit low in frame, faces high. Use top-down inserts for bench props.
- Part 1 hard-cuts on the person in danger. Only the final part fades.

## VFX
- Use only the grade presets G.n, G.r, G.s, G.h and any defined in the manifest.
- Flash caps: brightness +0.04, bloom +0.12, light 2.5 with range 8.
- Power effects are thin rings or particles. Overlays sit flush with the limb.

## QA
- Run `pipeline/qa_sheet.py` for one frame per beat plus END, then have the `render-qa` agent check every tile against MANIFEST section H and `reference/design_bible/05_*.jpg`.
- Never record until the user says "record".

## Related skills
- `.claude/skills/roblox-studio-workflow` (third party): Studio MCP hygiene and evidence labels. Its Rojo and play-test steps don't apply to our Edit-mode cutscenes.
- `.claude/skills/roblox-luau` (third party): Luau style for engine code (`task.*`, own every connection).
