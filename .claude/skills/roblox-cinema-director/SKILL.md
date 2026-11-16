---
name: roblox-cinema-director
description: Directing rules for Roblox story shorts. Covers shot grammar, faces, VFX, subtitles and QA, built on Argon assets and the per-story MANIFEST.md. Use when planning or fixing cameras, beats or visual quality.
---

# Roblox Cinema Director

Source of truth: `AGENTS.md`, `docs/LESSONS_LEARNED.md` and `docs/ARGON_PIPELINE.md`. The story's spec is `stories/<ID>_<slug>/MANIFEST.md`, section G.

## Hard bans
- No non-Roblox bodies, no Blender-built characters, no default `:|` faces, no cloned or bare extras.
- No slideshows or OpenCV boxes. Render in Roblox Studio (Future lighting).
- No dead-center subtitles. Captions are 1–3 words, lower third (Y≈82%), and never end on a function word.
- No robotic TTS. Use Edge-TTS AndrewNeural, with Faster-Whisper timing via `pipeline/voice_subs.py`.

## Shot grammar
- Hook: a big face or the key action inside the first ~1.2 s.
- Cut or change the camera every 1.2–2 s.
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
