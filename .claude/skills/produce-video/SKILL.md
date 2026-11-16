---
name: produce-video
description: Turn a scripted story folder into a final 1080x1920 60fps short (voice, subtitles, render, QA, mux). Use with a story ID.
argument-hint: "<ID>"
---
# Produce Video
Precondition: `stories/<ID>_*/` has narration.txt + beats.json, and `ledger/verification/<ID>.md` says PASS. Otherwise stop.

**Parallelism rule:** Roblox Studio work runs strictly ONE job at a time (generate_avatar etc. take minutes and time out if stacked; a timeout does not mean failure: check Workspace before retrying). Don't spawn extra agents to push more Studio jobs. While Studio is busy, run every step that doesn't need Studio in parallel: voice + subs (step 1), beat retiming, SFX gathering, ledger/index updates.

Read `docs/LESSONS_LEARNED.md` first. Every step below is a script any AI can run. Series: do each step per part (`p1/`, `p2/`, `beats_p1.json`, ...).

0. **Read `MANIFEST.md`** first. Confirm Argon has delivered every NEW asset in section D (check assets/INDEX.md and Studio). Section G is the spec for retiming and engine beats.
1. **Voice + subs** (low tier): `python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>/p1 --text "$(cat narration_p1.txt)"`
   This writes voice.mp3, words.json (script-locked spelling) and subs.ass. To change only the captions later, add `--subs-only`.
2. **SFX library**: `python pipeline/make_sfx.py`. Every `sfx` name used in beats must exist in `assets/sfx/` (add a line to make_sfx.py for new ones).
3. **Retime beats** to words.json (small shifts: render-qa; major rework: showrunner).
4. **Studio setup** (one job at a time):
   - Load the set.
   - Main cast from `generate_avatar`; bystanders from `assets/rigs/bystanders_school.luau` (dressed, never clones).
   - Faces from `ServerStorage.ApprovedFaces`.
   - Refresh SurfaceAppearances after any restart.
   - Serve the engine with `python -m http.server 8765 --bind 127.0.0.1` in engines/roblox, then `_G.loadEngine("<story>_cutscene.luau")`.
   - Cutscene shot rules are in LESSONS_LEARNED. Use `clearShot()` on every face camera.
5. **Record** (Studio in the foreground, nobody touching it):
   - In Studio, black the grade: `game.Lighting.Grade.Brightness = -1`.
   - `python pipeline/record_take.py --seconds <len+6> --out rec/pN_raw.mp4` (background).
   - Then `task.spawn(_G.Story007.play, N)`.
   - Then `python pipeline/record_take.py --trim rec/pN_raw.mp4 --out rec/pN.mp4`.
6. **Finish**: `python pipeline/finish_video.py --raw rec/pN.mp4 --part-dir pN --out <ID>_<slug>_partN.mp4 --end <last word + 0.3> --beats beats_pN.json`
   This rotates to 9:16 at 1080x1920 and 60fps, burns subs, mixes SFX and loudnorms. Never end on black.
7. **QA**: `python pipeline/qa_sheet.py --video <mp4> --words pN/words.json --beats beats_pN.json --out rec/qa_pN.png` (one frame per beat + END). Spawn `render-qa` (sonnet) on it. Fix, then re-record, until every beat passes. Also check: repeated frames under 2%, captions spelled per the script.
8. Write `PUBLISH.md` (3–5 hashtags per platform, a pinned comment that bridges the parts). Set the ledger status to `Produced`. Package the audit with `python audits/make_audit_package.py --story stories/<ID>_<slug> --scope story<ID>`.
