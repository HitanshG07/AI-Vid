# Story 003  -  Tears to Glass Keys  -  Pre-Record QA

- **Date:** 2026-11-19
- **Verification:** `ledger/verification/006.md` (PASS)
- **Script & Beats:** `stories/003_glass-key-tears/narration.txt` (178 words), `script.md` (9.0/10 avg, all v2 Catchiness Engine gates PASS), `beats.json` (36 beats, 0.0-57.0 s, 61.1% `pushIn` / 25.0% `snapOut` / 13.9% `impactZoom` +2.5 deg Dutch, all SFX verified in `assets/sfx/`), `MANIFEST.md`, `PUBLISH.md`.
- **Studio Set (`Workspace.Set_FrostVault003` at `1250, 0, 0`):** Executed & visually verified (243 parts; `FROST VAULT  -  DOOR 19` sign, hinged `Door19` + hexagonal `LockPlate`, `ThermometerGauge`/`GaugeBar`, `HotCocoaDispenser`, `OnionKeyStand`, `Props003`, `SnowEmitter`, Bloom glare disabled).
- **Studio Cast (`Workspace.Cast_003`):** Executed & visually verified (6 gender-locked winter R6 rigs: `Bram`, `Extra1`, `Leo`, `Maya`, `Vendor`, `Extra2`; `classic_v1` flat 2D faces; zero beachwear; lowest-part floor snap).
- **Cutscene Engine (`ServerStorage.Story003Cutscene` / `engines/roblox/story003_cutscene.luau`):** Executed `_G.Story003.setup()` (`STORY003_SETUP_OK beats=36`) and `_G.Story003.preview(2, 0.7)` (`PREVIEW_BEAT_2`); `resetCamera()` executed after preview.
- **Not Yet Run (Awaiting Owner Go-Ahead):**
  1. Voice & subtitles generation (`python pipeline/voice_subs.py  - story-dir stories/003_glass-key-tears  - engine kokoro  - kokoro-voice am_adam  - speed 1.15  - text "$(cat stories/003_glass-key-tears/narration.txt)"`)
  2. Recording via `pipeline/record_take.py` (owner rule: NEVER record until owner explicitly says "record").
