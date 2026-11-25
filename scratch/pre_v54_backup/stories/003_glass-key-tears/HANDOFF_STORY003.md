# Story 003  -  Tears to Glass Keys  -  Handoff & Pre-Recording Readiness (v2.3)

## Verified Studio & Repo State
- **Studio ID:** `ab23a0ba-065c-4593-886c-357e0c4cca5f` (`Ai-vid`, Edit mode)
- **Set (`Workspace.Set_FrostVault003`):** Wide-open winter city (`ORIGIN = Vector3.new(1250, 0, 0)`), 56x54 central plaza, complete Main Avenue + Cross-Street road network (`RoadParts=70`), Frost Vault Door 19 at `z = -28` (hinged, frosted viewport, hex lock, `GaugeBar`), `HotCocoaDispenser` (`x = -27`), `OnionKeyStand` (`x = +27`), multi-story shops, benches, parked truck, and all 15 animatable `Props003`/VFX.
- **Cast (`Workspace.Cast_003` + `Workspace.Cast_003_CityCrowd`):** 14 verified winter-dressed, gender-locked R6 rigs (`RigsVerified=14`, `Issues=NONE`) with `DisplayDistanceType = None` (zero floating nameplates) and `classic_v1` flat 2D faces.
- **Cutscene Engine:** `engines/roblox/story003_cutscene.luau` and `ServerStorage.Story003Cutscene` (ModuleScript) synced and tested. `_G.Story003` initialized with `setup()`, `play(part)`, `preview(n)`, `resetCamera()`.
- **Narration & Audio (Kokoro `am_adam` at ` - speed 1.05`):**
  - Tightened to 187 words with natural pauses and punctuation breaks.
  - Duration: 57.38 s (`words.json` last word ends at 57.00 s), target ≤ 58.0 s met, 60.0 s ceiling strictly respected.
  - Subtitles generated: `subs.ass` (LowerThirdPop, Y≈82%).
- **Beats:** 19 beats in `stories/003_glass-key-tears/beats.json` retimed to `words.json`.
- **SFX:** All 19 SFX cues verified present in `assets/sfx/`.

## Recording Steps (When Approved by Owner)
1. **Rule Check:** Never record until the user/owner says "record".
2. **Setup:**
   - In Studio Edit mode: `_G.Story003.setup()`
3. **Execution (Mouse Locked at 900, 12):**
   ```powershell
   python pipeline/record_take.py  - seconds 61  - out stories/003_glass-key-tears/rec/take1_raw.mp4
   ```
   - Trigger `task.spawn(_G.Story003.play, 1)` ~2s after recording starts.
   - Call `_G.Story003.resetCamera()` after the take.
4. **Post-Production:**
   - Finish video:
     ```powershell
     python pipeline/finish_video.py  - story-dir stories/003_glass-key-tears  - take 1  - lead 0.3  - tail 0.8
     ```
   - QA sheet: `python pipeline/qa_sheet.py  - story-dir stories/003_glass-key-tears`
   - Real-frame thumbnail: `stories/003_glass-key-tears/thumbnail.jpg` (1080x1920)
