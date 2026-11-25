# START HERE — running the AI-Vid story-video loop (for any AI)

Written 2026-11-18 for an AI that has not seen any earlier conversation. Everything here is taken from the files named below. If something is not written in those files, this document does not claim it. Where the owner gave an instruction that is not yet in the repo docs, it is marked **(owner note)**.

## 1. What AI-Vid is

AI-Vid makes original, high-retention Roblox story shorts: 1080x1920, 30 fps, 60 s or less per part, first-person narration of about 150–175 words per part. Each story is built in Roblox Studio with classic R6 avatars, recorded from the Studio viewport, voiced with Edge-TTS, captioned, and finished with ffmpeg.

The YouTube channel is **StudVerse Tales**, handle **@StudVerseTales** (https://www.youtube.com/@StudVerseTales). Channel copy, keywords and the upload template are in `branding/CHANNEL.md`. Keep "Roblox" out of the channel name, but it is fine in titles and tags.

## 2. Read-first order

Read these four before doing anything, in this order:

1. `AGENTS.md`: the rulebook. Golden rules, workflow, model tiers, hard production rules, asset process.
2. `docs/HANDOFF.md`: where things stand now (stories 001-003 are DONE; the next story is 004), the Studio engine how-to, and the pitfalls.
3. `docs/QUALITY_PLAYBOOK.md`: HOW to hit the quality bar (catchiness engine, gender-locked cast, live animation, framing, QA, definition of done). An earlier story failed because these habits were skipped.
4. `docs/LESSONS_LEARNED.md`: hard-won rules on faces, sets, shots, recording and delivery. Read it before any production step.

Then, for the step you are on, read the matching skill file:
- `.claude/skills/new-story/SKILL.md` (premise to script to MANIFEST to cast builder)
- `.claude/skills/verify-originality/SKILL.md` (web checks and the verification file)
- `.claude/skills/produce-video/SKILL.md` (voice, Studio record, finish, QA, publish)

Also useful: `docs/ENGAGEMENT_RULES.md` (score rubric), `templates/production_manifest_template.md`, `docs/AI_ADAPTERS.md`.

## 3. Setup

### (a) Tools that can edit files (Codex, Gemini CLI, Cursor, Antigravity, etc.)
1. Open the folder `C:\AI-Vid` in your tool.
2. Do the one-time adapter setup in `docs/AI_ADAPTERS.md`. It tells you which pointer files to create for your tool (rules, the three commands `new-story`, `verify-originality`, `produce-video`, and the model mapping). Adapter files must only point to `AGENTS.md` and the skill files. Do not paste workflow steps into them.
3. Start every session by reading `AGENTS.md` and then `docs/HANDOFF.md`.

### (b) Chat-only AIs (ChatGPT web, etc.) with no file access
1. Upload `audits/HANDOFF_PACKAGE_V2_VIRAL_STORY_AND_VOICE_UPGRADE_2026-11-18-2.zip`. It contains the rulebook and the skill files.
2. You can only do the premise, script, beats and MANIFEST text, plus the cast table. The owner saves your output files. You cannot run originality searches unless your tool browses. If you cannot browse, do not accept a PASS.
3. You cannot render, record or run Python. Say so when asked to.

### (c) Roblox Studio MCP (needed for anything in Studio)
1. (owner note) Open the **Ai-vid** place in Roblox Studio.
2. (owner note) In Studio: Assistant → Manage MCP Servers → enable **"Studio as MCP server"** → Quick connect.
3. Register the Studio MCP server in your tool's MCP settings (see `docs/AI_ADAPTERS.md` Step 3). Confirm with `get_studio_state`.
4. Without MCP you can still do premise, verification, script, voice and subtitles. Tell the owner that rendering is blocked.

### (d) Python and tools (only what `pipeline/` uses)
- Python 3 with the packages the scripts import. Check the import lines at the top of each `pipeline/*.py` file.
- **ffmpeg** on the PATH. `pipeline/record_take.py` calls `ffmpeg` with `gdigrab` (Windows screen capture). `pipeline/finish_video.py` calls ffmpeg for rotate, crop, scale, subtitles, SFX mix and loudnorm.
- **Edge-TTS** (voice `en-US-AndrewNeural`) and **Faster-Whisper** (word timing), both used by `pipeline/voice_subs.py`.
- `pipeline/make_sfx.py` generates `assets/sfx/*.wav`.
- Blender is optional and secondary (`engines/blender/`). Characters never come from Blender.

## 4. The loop

Tiers: **cheap** = Haiku / Gemini Flash / GPT-mini. **mid** = Sonnet / Gemini Pro / GPT standard. **best** = Opus / best available. Never use a best-tier model for cheap work. (`AGENTS.md` calls these low / mid / high.)

Story ID: 3 digits, starting at 001. A premise gets the next ID (highest ID in the ledger's Stories table + 1) only when it is chosen for production; unproduced premises have no ID (slug + `ledger/verification/ideas/<slug>.md`). Folder: `stories/<ID>_<kebab-slug>/`.

1. **Premise (best).** Brainstorm 3–5 premises from the freshness brief in `AGENTS.md`. Read `ledger/STORY_LEDGER.md`, `ideas/TRENDS.md` and `ideas/IDEA_BANK.md` first. Each premise has a world rule, a twist and a core meaning, and it names its combo (rule category · emotion core · setting). Trend refresh (cheap) is `ideas/TRENDS.md`, formats and themes only.

2. **Originality check (cheap, then mid).** Follow `.claude/skills/verify-originality/SKILL.md` exactly. Run at least 5 queries per premise, across Google, YouTube, Reddit r/WritingPrompts and TikTok/Instagram, using the query patterns in that skill. Record the real URLs (never invent them). A mid-tier judge decides. Output: `ledger/verification/<ID>.md` from `templates/verification_template.md`, for PASS and REJECT alike. No verification file = no production. Status in the ledger: `Verified` (PASS) or `REJECTED`.

3. **Script, beats, narration (best).** Output in `stories/<ID>_<slug>/`: `script.md` (from `templates/script_template.md`), `narration.txt` (150–175 words per part), `beats.json` (from `templates/beats_template.json`; every beat has a `line` whose first word is spoken).

4. **MANIFEST (best, then mid check).** Write `stories/<ID>_<slug>/MANIFEST.md` from `templates/production_manifest_template.md`. Every section A–H filled at minute detail: each character's action, every emotion, every asset (REUSE path from `assets/INDEX.md` or NEW), every animation, every VFX, and a beat table every ~1.2–2 s. The verifier checks it against section H. Any blank or vague line sends it back.

5. **Cast builder (best).** Write `engines/roblox/cast_<ID>.luau` from MANIFEST section C: catalog item ids (found with `AvatarEditorService:SearchCatalog`, Relevance sort, 0 Robux), skin hex, default face. Pattern: `engines/roblox/cast_001.luau`. Faces: `assets/faces/classic_v1/ids.json`. Interface: `build(name, x, floorY, z, yaw, parent)` and `setFace(model, emotion)`.

6. **Engagement score (mid).** Score the script with `docs/ENGAGEMENT_RULES.md`. Average must be **≥ 8**, and the meaning and completeness check must pass. Below 8: rewrite and re-score (max 2 rewrites). Record the score in `script.md`.

7. **Voice and subtitles (cheap).** Run:
   `python pipeline/voice_subs.py --story-dir stories/<ID>_<slug> --text "$(cat stories/<ID>_<slug>/narration.txt)"`
   (For a series use the part folder, e.g. `.../p1`, and pass that part's narration.) This writes `voice.mp3`, `words.json` (script-locked spelling) and `subs.ass`. To rebuild only captions: add `--subs-only`. Check numbers in the subs before publishing.

8. **SFX library (cheap).** Run `python pipeline/make_sfx.py`. Every `sfx` name in `beats.json` must have a file in `assets/sfx/`. `finish_video.py` silently skips missing files, so check them yourself.

9. **Set and cutscene engine (best for code, mid for checks).** The set is built in Studio from Roblox-native Parts, Terrain and free Creator Store models. Inspect every inserted free model and delete every script (`LuaSourceContainer`). Log each source in `assets/INDEX.md`. The cutscene engine is written per story; the template is `engines/roblox/story001_cutscene.luau` (exposes `_G.Story001 = { setup(), play(), preview(n), resetCamera() }`). Keep `engines/roblox/RobloxStudio_MovieCutscene_Engine.luau` and `roblox_look.luau` for reference.

10. **Load and dry run (mid).** One Studio job at a time. Send the whole engine text as one `execute_luau` call (Edit datamodel), then `_G.Story001.setup()` (rename for your story). Preview each beat with `_G.Story001.preview(n)` and check it. (`.claude/skills/produce-video/SKILL.md` step 4 also describes a local HTTP plus `_G.loadEngine` loader.) Fix shots until every beat passes the checklist in step 13. Then `_G.Story001.resetCamera()`.

11. **Record (ONLY after the owner says "record").**
    - Run `engines/roblox/texture_keepers.luau` as `execute_luau` right before the take.
    - In Studio: `game.Lighting.Grade.Brightness = -1` (black the grade). Clear the Selection.
    - Run `python pipeline/record_take.py --seconds <length + 6> --out stories/<ID>_<slug>/rec/takeN_p1_raw.mp4` in the background. It brings Studio to the foreground, locks the mouse at the top menu bar for the whole take (ClipCursor, always released), and records the viewport at a locked 30 fps with gdigrab.
    - About 2 s later: `task.spawn(_G.Story<ID>.play, 1)`.
    - As soon as the recorder exits: `_G.Story<ID>.resetCamera()`. Check it returned.
    - Trim: `python pipeline/record_take.py --trim <raw> --out <take>`.
    - Repeated-frame check on the trimmed 30 fps take (command in `docs/LESSONS_LEARNED.md`, "Recording"). Re-record if the ratio is 2% or more.
    - Nobody touches Studio during a take.

12. **Finish (cheap).** Run:
    `python pipeline/finish_video.py --raw <take> --part-dir stories/<ID>_<slug> --out stories/<ID>_<slug>/<ID>_<slug>_takeN.mp4 --lead 0.3 --end <last spoken word + 0.3> --beats stories/<ID>_<slug>/beats.json`
    It rotates to upright (`--transpose 2`), crops to 9:16, scales to 1080x1920 at 30 fps, delays voice and subs by `--lead`, mixes the SFX, and loudnorms. Check that the printed `SFX cues` count equals the number of beats with an `sfx`. Never end on black. Before the finish, trim or patch any single bad shots by splicing the same seconds from another take on exact shot cuts (LESSONS). Flash-frame patches are done the same way.

13. **Frame-by-frame audit (mid).** Run `python pipeline/qa_sheet.py --video <mp4> --words <words.json> --beats <beats.json> --out <png>` (one frame per beat plus END). The frame count must equal beats + 1. Do not use uniform 4- or 10-frame sheets alone. Check every category below at 4 fps contact sheets and 30 fps strips. Save the per-beat PASS/FAIL list, repeated-frame ratio and caption check as a QA note.

    The audit checklist (from `stories/001_brave-glow/rec/audit3_report.md`; that folder may not exist in a fresh clone, so the categories are listed here):
    - **A.** Hair or clothes popping white, pale or wrong colour on the first frames of a shot
    - **B.** Outfit swapped late (wrong top or shorts for a few frames)
    - **C.** Poses: T-poses, sitting or crate poses with rotated limbs, arms crossed through the torso, buried in sand, lying on the sand
    - **D.** Swimming and water: pose reads as lying on top, tiny or unreadable in the water
    - **E.** Eyeline: subject stares into the lens, back of head to camera, face hidden
    - **F.** Animation: stiff run or idle, glitter decals on limbs, exaggerated gestures
    - **G.** Camera: clipping into geometry, occlusion by an extra or rail, blur or DOF hiding faces, blank or black sky band
    - **H.** Highlight or outline tint that darkens the hair or clothes
    - **I.** Extras walking through the camera path
    - **J.** Captions: spelling, numbers, placement (upper or lower third, 1–3 words)
    - **K.** Colour, rendering and physics: grade jumps, banding, blown-out sun, bloom or DOF washing out the frame, speed-line or particle streaks read as dots, unlit pale faces
    - **L.** Duplicate frames or stalls mid-shot (repeated-frame check)
    Fix, then repeat from step 10 (or splice from another take). Repeat until clean, then show the owner.

14. **Owner review (owner).** Show the owner the viewport and the finished file. Do not treat a passing audit as owner approval. The owner decides which take is FINAL.

15. **Publish and log (cheap).** Write `stories/<ID>_<slug>/PUBLISH.md` (3–5 hashtags per platform; a pinned comment that bridges the parts). Use the upload template in `branding/CHANNEL.md`. Set the ledger row in `ledger/STORY_LEDGER.md` to `Produced` once the owner approves. Add any new assets to `assets/INDEX.md`. Commit only when the owner asks.

## 5. Hard rules

- **Owner-only changes.** Never change the workflow, rules, skills, agents, templates, pipeline scripts, engine code, cast/face assets or ledger rows, and never delete or move files, unless the owner explicitly directs that specific change. Story work inside the normal loop is allowed. If a workflow change would help, propose it and wait for approval.
- **Never copy a story.** Every premise is web-verified and `ledger/verification/<ID>.md` exists before any script. Assets (rigs, maps, SFX, faces) may be reused.
- **Engagement ≥ 8/10** (`docs/ENGAGEMENT_RULES.md`) before production.
- **Complete and meaningful.** Every story has an earned meaning and a real ending. A series must be finished in its final part.
- **Never repeat** a world rule, twist or core meaning from `ledger/STORY_LEDGER.md`.
- **Characters:** classic **R6** avatars built with `Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R6)`, dressed with real catalog items. No R15, no Argon, no mesh, no `generate_avatar`, no Blender characters, no generic primitives.
- **Faces:** our own flat 2D decals in `assets/faces/classic_v1/` (ids in `ids.json`). An emotion swap changes the Head's `face` Decal Texture. Add new emotions to `engines/faces/classic_faces.py`, never take free Creator Store faces.
- **Captions:** upper third (Y ≈ 15%) or lower third (Y ≈ 82%) only, 1–3 words per beat. Never dead centre.
- **World rule visible on screen** in every shot where it applies, so the video works muted.
- **Camera mix:** about 60% slow push-ins, 25% snap pull-outs, 15% impact snap-zooms with a 2.5° Dutch tilt. Cuts every 1.2–2 s.
- **Light:** default present-day grade uses `Lighting.ClockTime = 16.8` and textured surfaces (brick, wood, wainscot).
- **Format:** 1080x1920, 30 fps, ≤ 60 s per part, 150–175 words per part, 1st person. Never speed up the voice.
- **One Studio job at a time.** Do not stack Studio jobs or spawn agents to run more. A timeout is not a failure: check Workspace before retrying. Do voice, subs, SFX and docs in parallel.
- **Never record until the owner says "record".**
- **Reset the camera after every take** (`_G.Story<ID>.resetCamera()`, which swaps in a fresh Camera). Check it returned before doing anything else.
- **Show work in the Studio viewport**, not in screenshots (owner rule).
- **Mouse lock (owner rule):** every take is recorded ONLY via `pipeline/record_take.py`, which locks the cursor at the top menu bar (900,12) for the whole take and releases it after; never record any other way, never move or unlock the mouse during a take, and never park it at the bottom/corners (taskbar pops up).
- **MANIFEST.md is mandatory** and must pass the verifier before production.
- **Only use the locked method:** no Argon for characters, props or sets.

## 6. Known pitfalls

From `docs/LESSONS_LEARNED.md` and `docs/HANDOFF.md`:
- **Mid-line `--` comments in Luau.** `a or -- note b` comments out the rest of the line. Put comments on their own line.
- **R6 rigs pivot on the Head** (`PrimaryPart` = Head). Tilting rotates the body around the head. Keep characters upright; swim = upright and chest-deep, head just above the water. Do not build lying or sitting poses by tilting.
- **Use real R6 animation tracks** (`Animator:LoadAnimation`, `track:Play()`, `animator:StepAnimations(dt)` every frame in Edit mode; walk 180426354, idle 180435571). Hand-built limb swings look stiff.
- **Front-crawl swim** is the swim that read best on story 001 (HANDOFF "FINAL" row).
- **Water for swim shots:** a steep shore (≥ 4 studs deep within 1–2 studs of the waterline) and WaterTransparency ≈ 0.12. A gentle slope leaves swimmers lying on sand.
- **Do not hide characters** by transparency or by parking them far away. Textures unload and hair renders white. Keep them visible off-camera nearby, and run `engines/roblox/texture_keepers.luau` before every take.
- **Highlight fill tints hair and clothes.** Use the outline only.
- **Glowing VFX discs read as a blown-out sun.** Keep VFX thin and translucent, or drop them.
- **Noise-bed SFX read as static** on phone speakers. `pipeline/finish_video.py` mutes them on purpose (gain 0).
- **Splice single shots between takes on exact cuts.** Find cut frames with `ffmpeg ... select='gt(scene,0.25)'`, and check the cast looks identical in both takes.
- **Camera lock:** Studio's `execute_luau` can force the camera to Scriptable, which locks the owner's viewport. `resetCamera()` swaps in a fresh Camera to fix that.
- **Free face decals are mostly unusable** (opaque or fake checker backgrounds). Draw faces with `engines/faces/classic_faces.py`.
- **A Creator Store Decal id is not its image id.** Resolve with `game:GetObjects("rbxassetid://<id>")[1].Texture`.
- **Floor-snap by the lowest body part**, not the bounding box. Anchor only `HumanoidRootPart`.
- **Subtitles can mishear numbers and homophones.** `voice_subs.py` passes the script as a prompt and locks spelling to the script. Check anyway.
- **Pace (owner note):** keep the on-screen action at or below 1.4x normal speed. This is not written in the repo docs yet.
- **Known open flaw in story 001:** Rosa's hair flashes white around 16.8 s, cause unknown. Do not assume the keepers fix it.

## 7. START PROMPT (copy and paste as the first message)

```
You are continuing the AI-Vid story-video project in C:\AI-Vid. You have not seen any earlier conversation, so read these files first, in this order:
1. AGENTS.md (rulebook)
2. docs/HANDOFF.md (current status; stories 001-003 are DONE; the next story is 004)
3. docs/QUALITY_PLAYBOOK.md (HOW to hit the quality bar; follow it exactly)
4. docs/LESSONS_LEARNED.md (pitfalls; read before any production step)
Then read docs/START_WITH_ANOTHER_AI.md (this loop), and for each step the matching skill file: .claude/skills/new-story/SKILL.md, .claude/skills/verify-originality/SKILL.md, .claude/skills/produce-video/SKILL.md.

TASK: make the next story (next ID = highest in ledger/STORY_LEDGER.md plus 1; verify it).
Follow the loop in docs/START_WITH_ANOTHER_AI.md section 4, in order:
premise -> originality check (at least 5 searches per premise across Google, YouTube, Reddit r/WritingPrompts, TikTok/Instagram; record real URLs in ledger/verification/<ID>.md; never invent URLs) -> script.md, narration.txt, beats.json -> stories/<ID>_<slug>/MANIFEST.md (sections A-H, no vague lines, gender + catalog names per character) -> engines/roblox/cast_<ID>.luau (R6 catalog method, gender field on every entry, faces from assets/faces/classic_v1/) -> engagement score (average 8.5+, none below 8, every catchiness gate passes; record it in script.md) -> voice and subs (pipeline/voice_subs.py) -> SFX (pipeline/make_sfx.py) -> Studio set and cutscene engine (COPY engines/roblox/story001_cutscene.luau, change only beats/sets/cast; reset loco every frame) -> preview every beat -> STOP and report.

HARD RULES:
- NEVER change the workflow, rules, skills, scripts, assets or ledger, and never delete or move files, unless I explicitly tell you to. Propose changes and wait.
- Stories are never copied. Premise must be web-verified before any script.
- Complete story with an earned meaning and a real ending. No filler. Catchiness engine (docs/ENGAGEMENT_RULES.md): active rule visible in frame 1, 3 planted clues, taboo broken by 25 s, rule of 3, rule-hack climax, action-echo ending, NO moral lines.
- Outfits match gender: boys never wear girls' items and vice versa.
- Every on-stage rig animates (idle/walk track), never frozen; frame whole bodies acting, no wall clipping or giant-face filler.
- Characters: classic R6 + catalog items + our own faces only. No R15, Argon, mesh, generate_avatar or Blender characters.
- Captions upper third (Y about 15%) or lower third (Y about 82%), 1-3 words per beat. Never centre.
- The world rule must be visible on screen in every shot where it applies.
- Output 1080x1920, 30 fps, 60 s or less, 165–180 words per part with the default viral_storyteller voice. Split into parts rather than cram.
- One Studio job at a time. Check Workspace before retrying a timeout.
- Show work in the Studio viewport, not screenshots.
- NEVER RECORD until I say "record". Do not run record_take.py before that.
- After any take, run _G.Story<ID>.resetCamera() (or the matching name for your engine).
- Mouse lock (owner rule): every take is recorded ONLY via `pipeline/record_take.py`, which locks the cursor at the top menu bar (900,12) for the whole take and releases it after; never record any other way, never move or unlock the mouse during a take, and never park it at the bottom/corners (taskbar pops up).
- Do not write report/summary .md files except the files the loop names. Do not edit archive/.

MODEL TIERS: cheap (Haiku / Gemini Flash / GPT-mini) for searching, running commands, voice, file moves, ledger updates. Mid (Sonnet / Gemini Pro / GPT standard) for originality judging, engagement scoring, Studio QA, frame audits. Best (Opus / best available) for premises, scripts, beats, MANIFEST and engine/scene code. Never use best-tier for cheap work.

Before you change anything, tell me: the story ID you chose, the three premises you considered, and the file list you will create. Then wait for my reply before Studio work.
```

## 8. How to report back

When you finish a step, report in plain text, with no emojis:
1. **Step** (number and name from section 4) and its **status**: done, blocked or failed.
2. **Files** you created or changed, as full absolute paths (for example `C:\AI-Vid\ledger\verification\004.md`).
3. **Evidence**: the verification verdict, engagement score, voice duration, SFX cue count, repeated-frame ratio and frame count from `qa_sheet.py`, as applicable.
4. **Blockers**: anything that needs the owner (Studio state, a decision, a "record" word).
5. **Next step** you recommend, in one line.

Never report a step as PASS without the evidence file or output. Never claim a URL you did not open or a search you did not run.


## v2 rules (2026-11-19, owner-approved)
- Follow the **catchiness engine** in `docs/ENGAGEMENT_RULES.md`: active rule (not a badge), rule visible in frame 1, 3 planted clues, taboo broken by 25s, rule-of-3 attempts, rule-hack climax, action-echo ending, no moral/lecture lines. Avg >= 8.5, none below 8, every gate passes.
- ~165–180 words per part (default voice preset `viral_storyteller`).
- Every cast entry declares `gender` (boy/girl/man/woman); all clothing, hair and accessories must match it.
- New cutscenes start from `engines/roblox/story001_cutscene.luau`; reset `loco` every frame; no frozen rigs; no wall-clipping or tilted giant-face filler shots.

- **Thumbnail (owner rule 2026-11-19):** every story ships `stories/<ID>_<slug>/thumbnail.jpg` (1080x1920) made from a real frame of the story itself, taken from the caption-free take (`rec/takeN.mp4`, transpose=2 + crop) at the most gripping moment, with no generated art. Add a 2–3 line bold title (Arial Black, white plus one accent colour, thick black border) in the top and bottom thirds that teases the rule without spoiling the twist. Reference it in PUBLISH.md. Example: story 002.
