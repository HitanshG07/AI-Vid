# AI-Vid V5.4 — 60-Second Quickstart

## One-Time Setup (Windows 11)
1. `powershell -ExecutionPolicy Bypass -File setup.ps1`
2. Optional: drop 3 free CC0 / YouTube Audio Library mood BGM tracks into `assets/sfx/` (`bgm_action.mp3`, `bgm_wholesome.mp3`, `bgm_dark.mp3` — falls back to `roblox-story-bg.mp3`).

## Fast 4-Step Auto-Synced Loop
```powershell
python pipeline/compile_story.py --story stories/<ID>_slug/story.yaml
python pipeline/voice_subs.py --story-dir stories/<ID>_slug
python pipeline/compile_story.py --story stories/<ID>_slug/story.yaml --sync-words
python pipeline/preflight_lint.py --story stories/<ID>_slug/story.yaml
```
Then preview in Roblox Studio (`core_engine.luau` + `sets/set_<name>.luau` + `scenes_<ID>.luau`), and after you say `"record"`:
```powershell
python pipeline/run_take.py --story-dir stories/<ID>_slug --draft
python pipeline/run_take.py --story-dir stories/<ID>_slug --final
```
