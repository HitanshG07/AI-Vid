---
name: produce-video
description: Turn a scripted story folder into a final 1080x1920 short (voice, subtitles, Studio record at 30 fps, QA, mux). Use with a story ID.
argument-hint: "<ID>"
---
# Produce Video
Precondition: `stories/<ID>_*/` has narration.txt + beats.json + MANIFEST.md, `ledger/verification/<ID>.md` says PASS, and script.md records an engagement average ≥ 8 and a verifier PASS on the manifest. Otherwise stop.

**Parallelism rule:** Roblox Studio work runs strictly ONE job at a time (Studio generation jobs take minutes and time out if stacked; a timeout does not mean failure: check Workspace before retrying). Don't spawn extra agents to push more Studio jobs. While Studio is busy, run every step that doesn't need Studio in parallel: voice + subs (step 1), beat retiming, SFX gathering, ledger/index updates.

Read `docs/LESSONS_LEARNED.md` first. Every step below is a script any AI can run. Series: do each step per part (`p1/`, `p2/`, `beats_p1.json`, ...).

Studio MCP hygiene comes from the third-party skill `.claude/skills/roblox-studio-workflow` (`list_roblox_studios` + pass `studio_id` when more than one Studio is open; inventory before editing; clean temporary parts; label every claim executed / statically checked / not run). Luau style comes from `.claude/skills/roblox-luau` (`task.wait`/`task.spawn`, never `wait()`). Ignore their Rojo, selene and play-test steps: our cutscene runs in **Edit mode** with no Rojo project, and our rules here win on any conflict.

0. **Read `MANIFEST.md`** first. Confirm every NEW asset in section D exists (Studio-built or Creator Store, logged in assets/INDEX.md) and `engines/roblox/cast_<ID>.luau` exists. Section G is the spec for retiming and engine beats.
1. **Voice + subs** (low tier): `python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>/p1 --text "$(cat narration_p1.txt)"`
   This writes voice.mp3, words.json (script-locked spelling) and subs.ass. To change only the captions later, add `--subs-only`.
2. **SFX library**: `python pipeline/make_sfx.py`. Every `sfx` name used in beats must exist in `assets/sfx/` (add a line to make_sfx.py for new ones). `finish_video.py` silently skips a missing wav, so list the beat `sfx` names and check each file exists before step 6.
3. **Retime beats** to words.json (small shifts: render-qa; major rework: showrunner). Every beat needs a `line` whose first word is spoken: `qa_sheet.py` and the SFX mixer both find beats by that word and silently drop beats without it.
4. **Studio setup** (one job at a time):
   - Load the set.
   - Main cast and extras: build with the story's cast builder (`engines/roblox/cast_<ID>.luau`, R6 catalog method, MANIFEST section C). Dressed and varied, never clones.
   - Faces: `setFace(model, emotion)` using `assets/faces/classic_v1/ids.json`; no head swapping.
   - Serve the engine with `python -m http.server 8765 --bind 127.0.0.1` in engines/roblox, then `_G.loadEngine("<story>_cutscene.luau")`.
   - Cutscene shot rules are in LESSONS_LEARNED. Use `clearShot()` on every face camera.
   - Dry run plus beat sheet (LESSONS "QA loop") before asking the user to record.
5. **Record — only after the user says "record"** (Studio in the foreground, nobody touching it):
   - In Studio, black the grade: `game.Lighting.Grade.Brightness = -1`. Clear the Selection.
   - `python pipeline/record_take.py --seconds <len+6> --out rec/pN_raw.mp4` (background).
   - Then `task.spawn(_G.Story<ID>.play, N)`.
   - As soon as the recorder exits: `_G.Story<ID>.resetCamera()` (owner rule: after EVERY take, the Studio viewport goes back to roll 0, FOV 70, via a FRESH editor camera (free right-mouse look), and the fade card is hidden). Check it returned before doing anything else.
   - Then `python pipeline/record_take.py --trim rec/pN_raw.mp4 --out rec/pN.mp4`.
   - Run the repeated-frame check from LESSONS "Recording" on `rec/pN.mp4` (the 30 fps take). ≥2% → re-record.
6. **Finish**: `python pipeline/finish_video.py --raw rec/pN.mp4 --part-dir pN --out <ID>_<slug>_partN.mp4 --end <last word + 0.3> --beats beats_pN.json`
   This rotates to 9:16 at 1080x1920, burns subs, mixes SFX and loudnorms. Check the printed `SFX cues: N` equals the number of beats with an `sfx`. Never end on black.
   Note: the script currently resamples to 60 fps (`fps=60`), while capture is 30 fps; see `docs/HARDENING_REPORT_2026-11-17.md`.
7. **QA**: `python pipeline/qa_sheet.py --video <mp4> --words pN/words.json --beats beats_pN.json --out rec/qa_pN.png` (one frame per beat + END). The printed frame count must equal beats + 1; if lower, a beat was dropped (fix its `line`). Spawn `render-qa` (sonnet) on it. Fix, then re-record, until every beat passes. Save render-qa's per-beat PASS/FAIL list, the repeated-frame ratio and the caption spelling check as `rec/qa_pN.md`. No `qa_pN.md` = not done.
8. Write `PUBLISH.md` (3–5 hashtags per platform, a pinned comment that bridges the parts). Set the ledger status to `Produced`. Package the audit with `python audits/make_audit_package.py --story stories/<ID>_<slug> --scope story<ID>`.
