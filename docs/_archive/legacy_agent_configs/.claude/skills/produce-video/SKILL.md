---
name: produce-video
description: Turn a scripted story folder into a final 1080x1920 short (voice, subtitles, Studio record at 30 fps, QA, mux). Use with a story ID.
argument-hint: "<ID>"
---
# Produce Video
Precondition: `stories/<ID>_*/` has narration.txt + beats.json + MANIFEST.md, `ledger/verification/<ID>.md` says PASS, and script.md records an engagement average ≥ 8.5 (none below 8), every catchiness gate passed, and a verifier PASS on the manifest. Otherwise stop.

**Parallelism rule:** Roblox Studio work runs strictly ONE job at a time (Studio generation jobs take minutes and time out if stacked; a timeout does not mean failure: check Workspace before retrying). Don't spawn extra agents to push more Studio jobs. While Studio is busy, run every step that doesn't need Studio in parallel: voice + subs (step 1), beat retiming, SFX gathering, ledger/STORY_LEDGER.md updates.

Read `docs/QUALITY_PLAYBOOK.md` and `docs/LESSONS_LEARNED.md` first. The cutscene starts as a copy of `engines/roblox/story001_cutscene.luau`. Every step below is a script any AI can run. Series: do each step per part (`p1/`, `p2/`, `beats_p1.json`, ...).

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
5. **Mouse lock (owner rule):** every take is recorded ONLY via `pipeline/record_take.py`, which locks the cursor at the top menu bar (900,12) for the whole take and releases it after; never record any other way, never move or unlock the mouse during a take, and never park it at the bottom/corners (taskbar pops up).
   **Record — only after the user says "record"** (Studio in the foreground, nobody touching it):
   - In Studio, black the grade: `game.Lighting.Grade.Brightness = -1`. Clear the Selection.
   - `python pipeline/record_take.py --seconds <len+6> --out rec/pN_raw.mp4` (background).
   - Then `task.spawn(_G.Story<ID>.play, N)`.
   - As soon as the recorder exits: `_G.Story<ID>.resetCamera()` (owner rule: after EVERY take, the Studio viewport goes back to roll 0, FOV 70, via a FRESH editor camera (free right-mouse look), and the fade card is hidden). Check it returned before doing anything else.
   - Then `python pipeline/record_take.py --trim rec/pN_raw.mp4 --out rec/pN.mp4`.
   - Run the repeated-frame check from LESSONS "Recording" on `rec/pN.mp4` (the 30 fps take). ≥2% → re-record.
6. **Finish**: `python pipeline/finish_video.py --raw rec/pN.mp4 --part-dir pN --out <ID>_<slug>_partN.mp4 --end <last word + 0.3> --beats beats_pN.json`
   This rotates to 9:16 at 1080x1920, burns subs, mixes the locked continuous background music bed (`assets/sfx/roblox-story-bg.mp3` at `--bgm-gain 0.14`, looped seamlessly; zero synthesized static noise beds), mixes beat SFX and loudnorms. Check the printed `SFX cues: N` equals the number of beats with an `sfx`. Never end on black.
   Note: the script currently resamples to 60 fps (`fps=60`), while capture is 30 fps; see `docs/HARDENING_REPORT_2026-11-17.md`.
7. **QA**: `python pipeline/qa_sheet.py --video <mp4> --words pN/words.json --beats beats_pN.json --out rec/qa_pN.png` (one frame per beat + END). The printed frame count must equal beats + 1; if lower, a beat was dropped (fix its `line`). Spawn `render-qa` (sonnet) on it. Fix, then re-record, until every beat passes. Save render-qa's per-beat PASS/FAIL list, the repeated-frame ratio and the caption spelling check as `rec/qa_pN.md`. No `qa_pN.md` = not done.
7b. **Thumbnail (owner rule 2026-11-19):** every story ships `stories/<ID>_<slug>/thumbnail.jpg` (1080x1920) made from a real frame of the story itself, taken from the caption-free take (`rec/takeN.mp4`, transpose=2 + crop) at the most gripping moment, with no generated art. Add a 2–3 line bold title (Arial Black, white plus one accent colour, thick black border) in the top and bottom thirds that teases the rule without spoiling the twist. Reference it in PUBLISH.md. Example: story 002.
   Command pattern: `ffmpeg -ss <t> -i rec/takeN.mp4 -frames:v 1 -vf "transpose=2,scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,eq=contrast=1.12:saturation=1.25,drawtext=fontfile='C\:/Windows/Fonts/ariblk.ttf':text='...':fontsize=118:fontcolor=white:borderw=9:bordercolor=black:x=(w-tw)/2:y=170" thumbnail.jpg`
8. Write `PUBLISH.md` (3–5 hashtags per platform, a pinned comment that bridges the parts). Set the ledger status to `Produced`.


## Learned on story 002 (2026-11-19)
- **Loading into Studio:** the Studio MCP blocks localhost HTTP, so `_G.loadEngine` does not work. Paste each file's text into `execute_luau`. For big engines, store the text in a `ServerStorage` StringValue and run it with `loadstring`. **Mirror the live source to disk at the end of every work block**, or a crash loses it.
- **Preview vs play:** `preview(n)` must step the R6 tracks (otherwise rigs show as T-poses) and may skip the camera roll through a preview-only flag. `play()` ALWAYS rolls +90. A preview roll left on made take 1 come out sideways.
- **Voice:** the default narrator is Kokoro `am_adam` (`--engine kokoro --kokoro-voice am_adam --speed 1.15`). Check `voice.mp3` length before Studio work. If it is too long, raise the speed (or the Edge rate) before cutting words.
- **Sync:** actions start on a beat's first word, so they land ~0.8 s behind the voice. Finish with `--lead 1.1` (engine LEAD 0.3) and build the QA sheet with the same `--lead`. Check one action frame against words.json first.
- **Captions:** after `voice_subs.py`, scan `subs.ass` for a 1-word card after a 3-word card ("MY TRAIL BLAZED / WHITE.") and re-split it by hand before the final burn.
- **Takes:** raw take → `--trim` → repeated-frame check (<2%) → finish → `qa_sheet` → render-qa. Re-take until there are no blocking issues; log each finding in LESSONS.
- **Quota:** for a follow-up Studio job, start a FRESH mid-tier agent with a tight brief rather than resuming one with a huge context. When quota is low, spot-check frames yourself instead of running a full render-qa pass, and say so in the QA file.

## Learned on story 003 (2026-11-20)
- **Set & Geometry Containment:** Interior platforms (e.g. CatwalkFloor inside a vault) must be strictly constrained inside the building or chamber bounds and never protrude past doorways or exterior facades into camera paths. A 12-stud slab extending 5.5 studs forward created a massive blue bar across the bottom of the frame in multiple beats. Check coordinates against door planes before recording.
- **R6 Joint Rotation Axes:** In R6 Motor6D joints, local Z is pitch (forward/backward swing), and local X is roll/abduction. Swapping them causes limbs to flail sideways like jumping jacks instead of swinging along the line of motion.
- **Real R6 Animations vs Manual Loops:** Reset loco = nil every frame, set loco = 'walk' or 'run' when moving, and let the native R6 AnimationTracks drive hips and shoulders smoothly. Reserve procedural joint offsets for upper-body gestures (clutching, chopping, hugging).
- **Cart & Stand Placement:** Never call PivotTo() per frame on complex multi-part models without a verified primary part. Doing so rotates the model along its uncentered pivot. Anchor once statically, place vendors behind the counter, and position customers at an offset with a 3/4 camera angle.
- **Camera Staging:** Never radially align characters along the camera ray (collinear stacking). Arrange characters side-by-side across the frame to prevent foreground actors from blocking the scene with giant tilted heads.
- **Two-Part Series Splitting & Outro Hook:** When splitting long reels into Part 1 and Part 2: Part 1 hard-cuts at peak danger/crisis with a spoken outro hook (Kokoro `am_adam`: "Watch Part 2 to see how he saved her") and animated LowerThird CTA card. Part 2 resumes immediately on the panicking crowd, pays off planted props (e.g. Dad's pocket watch ticking again), and delivers the action-echo ending.
- **Audio Bed Standard:** Continuous BGM is locked to `assets/sfx/roblox-story-bg.mp3` (`--bgm roblox-story-bg.mp3 --bgm-gain 0.14`). Static sound beds, ambient hiss, and noise waves are strictly banned.
- **Studio Cloud Persistence:** Run `save_place` to version the place to Roblox Cloud after building sets or casts, and write an auto-loader in `Workspace.Script` so DataModel reloads automatically after reboots.
