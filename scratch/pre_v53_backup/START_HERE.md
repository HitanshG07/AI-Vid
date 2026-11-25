# AI-Vid V5 — 60-Second Quickstart

## One-Time Setup (Windows 11)
1. Run `powershell -ExecutionPolicy Bypass -File setup.ps1`
2. Build starter SFX once: `python pipeline/make_sfx.py`
3. Drop any extra CC0 / YouTube Audio Library mood BGM tracks into `assets/sfx/` (`bgm_mystery.mp3`, `bgm_action.mp3`, `bgm_wholesome.mp3`, `bgm_dark.mp3` — falls back automatically to `roblox-story-bg.mp3`).

## Low-Quota 3-Turn AI Workflow
- **Turn 1 (Prompt your AI):** *"Read CORE.md and config.yaml. Web-verify originality (save `PASS` to `ledger/verification/004.md`) and create `stories/004_my-slug/story.yaml` using `templates/formats/02_anime_fight.yaml`. Keep it 100% standalone, 5th-grade English, max 2.0s per beat."*
- **Turn 2 (Run locally — 0 AI tokens!):**
  ```powershell
  python pipeline/compile_story.py --story stories/004_my-slug/story.yaml
  python pipeline/voice_subs.py --story-dir stories/004_my-slug
  python pipeline/preflight_lint.py --story stories/004_my-slug/story.yaml
  ```
- **Turn 3 (Studio + 1-Command Record & Export):**
  Load `core_engine.luau` + `scenes_004.luau` in Roblox Studio, then run:
  ```powershell
  python pipeline/run_take.py --story-dir stories/004_my-slug --draft
  # Check rec/qa_beats.png -> when happy:
  python pipeline/run_take.py --story-dir stories/004_my-slug --final
  ```
