# AI-Vid adoption guide (2026-11-17)

Reader: an AI model (GPT or Gemini) working in a copy of the AI-Vid repository, asked to build and adopt the improvements below. You have no access to the reference videos, to the conversation that produced this guide, or to any Claude-specific tooling. Follow this guide literally. Where it says "unknown", do not guess: run the stated test and record the answer.

Companion document: `docs/REFERENCE_STUDY_2026-11-17.md` (the evidence). When this guide says "the reference does X" it is an observation from that study. When it says "AI-Vid should do Y" it is a recommendation. Section numbers cited as "study 3.5" refer to that report.

---

## 1. What AI-Vid is and how it runs today

AI-Vid makes **original Roblox story shorts**: 1080x1920 video, at most 60 s per part, first-person voice-over, a "world rule plus twist" story (for example: "In this world, tapping your wrist rewinds 10 seconds but ages your hands one year"). They are posted to YouTube Shorts, Instagram Reels and TikTok. It runs on one Windows 11 laptop (RTX 4060 8 GB, 16 GB RAM) at no extra cost.

### 1.1 Folders

| Path | Contents |
|---|---|
| `AGENTS.md` | The rulebook every AI follows. Source of truth |
| `docs/` | `LESSONS_LEARNED.md` (hard-won rules), `ENGAGEMENT_RULES.md`, `ARGON_PIPELINE.md`, `SETUP_GUIDE.md`, `HARDENING_REPORT_2026-11-17.md`, the reference study and this guide |
| `ledger/STORY_LEDGER.md`, `ledger/verification/<ID>.md` | The story ledger and the web-verification evidence for each story |
| `ideas/` | `IDEA_BANK.md` (verified unused premises), `TRENDS.md` (weekly trend refresh, currently "Last refreshed: never") |
| `stories/<ID>_<slug>/` | One folder per story. Worked example: `stories/007_wrist-rewind/` |
| `templates/` | `script_template.md`, `beats_template.json`, `production_manifest_template.md`, `verification_template.md` |
| `pipeline/` | Python scripts: `voice_subs.py`, `make_sfx.py`, `record_take.py`, `finish_video.py`, `qa_sheet.py`, `test_voice_subs.py` |
| `engines/roblox/` | Luau cutscene engines (`story007_cutscene.luau` 1,324 lines is the working one; `RobloxStudio_MovieCutscene_Engine.luau` is a 105-line generic one), `roblox_look.luau` (lighting), `sets/`, `_bystanders.luau` |
| `engines/blender/` | Converters only (Blender never designs characters) |
| `assets/` | `rigs/`, `maps/`, `meshes/`, `faces/`, `sfx/`, and `INDEX.md` (every reusable asset gets a row) |
| `reference/` | `BENCHMARKS.md`, `ITERATION_LOG.md`, `design_bible/` (five style sheets) |
| `argon/`, `audits/` | Argon build bible, Argon handover zips and test reports, audit packages |
| `.claude/skills/`, `.claude/agents/` | Claude Code skills and agents. If you are not Claude Code, read the `SKILL.md` files as plain procedures |

### 1.2 The story-to-mp4 loop (as of today)

1. **Premise and verification** (the story side, section 2.1 below).
2. **Script, beats and manifest.** `script.md`, `narration_pN.txt`, `beats_pN.json`, and `MANIFEST.md` from `templates/production_manifest_template.md`. A verifier scores the script (average at least 8 of 10 plus a pass/fail meaning gate) and checks the manifest.
3. **Argon handover.** A zip in `audits/ARGON-<NNN>_<date>_<ID>_part1of1.zip` holds the build prompts and the manifest. The external AI "Argon" (Gemini) builds the characters, props and sets to one locked style and the results are exported into `assets/`. (Studio-MCP generation is the fallback.) **This step is open for replacement; see sections 3 and 4.**
4. **Voice and captions.** `python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>/p1 --text "$(cat narration_p1.txt)"` writes `voice.mp3` (Edge-TTS voice `en-US-AndrewNeural`, rate `+8%`), `words.json` (Faster-Whisper word times, spelling locked to the script) and `subs.ass`.
5. **SFX.** `python pipeline/make_sfx.py` synthesises `assets/sfx/*.wav` with ffmpeg.
6. **Studio setup.** The set, characters and faces are loaded in Roblox Studio (one Studio job at a time); the engine is served from `engines/roblox` by `python -m http.server 8765 --bind 127.0.0.1` and loaded with `_G.loadEngine("<story>_cutscene.luau")`.
7. **Record (only when the owner says "record").** The Roblox camera is rolled +90 degrees so the landscape Studio viewport holds a sideways 9:16 picture. `python pipeline/record_take.py --seconds N --out rec/pN_raw.mp4` brings Studio to the foreground, parks the cursor in the menu bar and records a fixed screen region with `ffmpeg gdigrab` at 30 fps; `--trim` cuts the black lead-in.
8. **Finish.** `python pipeline/finish_video.py --raw rec/pN.mp4 --part-dir pN --out <ID>_<slug>_partN.mp4 --end <last word + 0.3> --beats beats_pN.json` rotates (`transpose=2`), centre-crops to 9:16, scales to 1080x1920, burns the shifted subtitles, mixes SFX at their spoken times, normalises loudness (`loudnorm I=-14`) and cuts the end so the video never ends on black.
9. **QA.** `python pipeline/qa_sheet.py --video <mp4> --words pN/words.json --beats beats_pN.json --out rec/qa_pN.png` writes one frame per beat plus an END frame (tiles 216x384, 8 columns). A QA reviewer fails or passes every beat and the report is saved as `rec/qa_pN.md`.
10. `PUBLISH.md` (3 to 5 hashtags), set the ledger row to `Produced`.

### 1.3 File formats

- **`narration_pN.txt`**: plain text, the exact words spoken, one paragraph, about 150 to 175 words per part. Spoken words only.
- **`beats_pN.json`**: from `templates/beats_template.json`:
  `{"id","part","engine":"roblox","fps":30,"duration_s","narration","map","characters":[{"name","rig","start_face"}],"beats":[{"t","dur","shot","camera_target","face":{<name>:<emotion>},"action","vfx":[...],"sfx":"<name in assets/sfx>","line":"<words spoken at this beat>"}]}`. The first word of each beat's `line` must appear in `words.json`, or `qa_sheet.py` and the SFX mixer silently drop the beat.
- **`MANIFEST.md`**: sections A (meta) to H (QA checklist); G is a beat table every 1.2 to 2 s. Worked example: `stories/007_wrist-rewind/MANIFEST.md`.
- **`words.json`**: a list `[{"word": "Tapping", "start": 0.12, "end": 0.48}, ...]`, seconds from the start of `voice.mp3`.
- **`subs.ass`**: ASS subtitles, `PlayResX 1080`, `PlayResY 1920`. Styles in `pipeline/voice_subs.py` `STYLES`: `LowerThirdWhite`, `LowerThirdYellow` (default) and `UpperThirdWhite`, font Arial Black 80, outline 6, shadow 3. Lower styles use alignment 2 with `MarginV 230` (the text bottom sits at y = 1690); the upper style uses alignment 8 with `MarginV 220`. Each `Dialogue` line carries a short scale pop `{\fscx118\fscy118\t(0,85,\fscx100\fscy100)}` and the text in capitals. Cards are 1 to 3 words and never end on a function word (`NO_END` in `voice_subs.py`).

Measured baseline of the worked example (story 007 part 1, measured 2026-11-17): final mp4 1080x1920 at **60 fps** (`ffprobe` reports `60/1`), 50.05 s; 152 words over 49.7 s, which is about 183 words per minute; `beats_p1.json` holds 27 beats averaging 2.07 s with a longest beat of 4.0 s.

---

## 2. Rules that must not be broken

### 2.1 The story side: keep exactly as it is

The owner is satisfied with how stories are made and cares about it most. Nothing in this guide changes it, and no reference method may replace or weaken it. It works as follows:

- **Golden rules** (`AGENTS.md`): (1) stories are never copied; every premise (world rule plus twist) is web-verified and the evidence is saved in `ledger/verification/<ID>.md` before any script is written; assets may be reused freely. (2) Engagement first: every script follows `docs/ENGAGEMENT_RULES.md` and scores at least 8 of 10 before production. (3) Meaningful and complete: a clear earned meaning and a real ending (series allowed; the final part resolves everything; no filler). (4) Never repeat: check `ledger/STORY_LEDGER.md`; no reused world rule, twist or core meaning.
- **Ledger** (`ledger/STORY_LEDGER.md`): columns ID, Date, Title or premise, World rule, Twist, Format, Core meaning, Status. Status flow `Idea` then `Verified` then `Scripted` then `Produced` then `Posted`, or `REJECTED` if a duplicate is found online. Every row except `Idea` needs `ledger/verification/<ID>.md`. Current rows: 000 to 010; 007 is Produced, 003 is REJECTED, 000 is a legacy unverified row, the rest are Verified.
- **Originality check** (`.claude/skills/verify-originality/SKILL.md`): at least five queries per premise (`"in this town" "<rule keyword>" roblox`, `"in this world" ... roblox story`, the core mechanic on Reddit or Wattpad, the twist keyword on YouTube Shorts, TikTok or Instagram, the rule in plain words as a short film or story); a low-tier researcher runs the searches and reports faithfully; a mid-tier verifier judges against the ledger (same rule or same twist anywhere means REJECT) and writes `ledger/verification/<ID>.md` from `templates/verification_template.md`. PASS puts a row in `ideas/IDEA_BANK.md`; REJECT sets the ledger row to `REJECTED`. No verification file means the story cannot be produced.
- **Freshness brief** (`AGENTS.md`): combine a rule category, an emotion core, a setting and a format, and differ from the last five ledger rows' combination.
- **Scripting** (`.claude/skills/new-story/SKILL.md`): brainstorm 3 to 5 premises, verify them, write `script.md`, `narration.txt`, `beats.json` and `MANIFEST.md`, score with the engagement rubric (hook, pacing, twist, payoff, plus the pass/fail meaning and completeness gate), rewrite below 8, then set the ledger to `Scripted`.
- **Engagement structure** (`docs/ENGAGEMENT_RULES.md`): hook in 0 to 1 s, show the rule, make it personal, escalate, twist that uses the rule, payoff with a one-line human takeaway; series parts end on a cliffhanger except the final part.
- **What the references do instead.** The reference tutorials generate the story inside one prompt, from "the most viral Roblox stories" or ten model pitches, with no web check, no ledger and no scoring. **That is not to be adopted.** The example rules shown in those tutorials (every lie shrinks you, every sneeze teleports you, yawning turns day to night, never be the last one awake) and the two finished example shorts' premises (everyone gets one superpower once; whoever pulls the sword from the stone marries the princess) are existing public stories. Never use them.

### 2.2 Other rules (from `AGENTS.md` and `docs/LESSONS_LEARNED.md`)

1. **Model tiers.** Low tier (Haiku, Gemini Flash, GPT-mini): web searching, URL collection, file moves, ledger appends, running commands. Mid tier (Sonnet, Gemini Pro, GPT standard): judging originality, scoring scripts, render QA, fixing coordinates. High tier (Opus or best available): brainstorming premises, writing final scripts and beats, scene code. Never use a high-tier model for low-tier work.
2. **Argon builds assets** is the current rule and is open to replacement. Until the owner answers decision D1 in section 4, do not change it. Blender never designs characters; it may only convert or import meshes.
3. **One Studio job at a time.** Never stack Studio generations. A timeout is not a failure: inspect the Workspace before retrying. Do non-Studio work (voice, subtitles, SFX, docs, scripts) in parallel meanwhile.
4. **Never start a Studio recording until the owner says "record".** No recording of any kind, including tests, without that word.
5. **Captions.** Lower third (Y about 82 %, default) or upper third (Y about 15 %) only, 1 to 3 words per card, never dead-centre, never covering a face, never ending a card on a function word. Any change to this is decision D3.
6. **Sound-off rule.** The world rule must be visible on screen in every shot where it applies (a counter, a mark, aged hands), so the video works muted.
7. **Length and voice.** At most 60 s per part, about 150 to 175 words per part, Edge-TTS `en-US-AndrewNeural` with Faster-Whisper timing through `pipeline/voice_subs.py`; never speed the voice up to cram words (the `+8%` default is a tuned rate; any other value is decision D5).
8. **Frame rate.** Capture is a locked 30 fps. Finishing at 60 fps is a known defect fixed by task B1.
9. **Camera and cuts.** Cut or change the camera every 1.2 to 2 s (3 s maximum); mix of about 60 % slow push-ins, 25 % snap pull-outs, 15 % impact snap-zooms with a 2.5 degree Dutch tilt; faces fill 25 to 35 % of frame height on emotional beats; no macro closer than about 2.5 to 3 studs; never end on black; Part 1 hard-cuts on the person in danger; only the final part may fade, and only in the 0.4 s tail.
10. **Lighting.** `Lighting.ClockTime = 16.8`, textured surfaces; flash limits: ColorCorrection brightness at most +0.04, bloom at most +0.12, flash PointLight brightness 2.5 with range 8.
11. **Characters.** Authentic Roblox R6 or R15 characters only; never Blender-designed characters; never colour-only bodies; never clone main characters as extras; never the default `:|` face.
12. **Sound design is mandatory.** Every beat's `sfx` is mixed; a dry TTS-only track fails.
13. **QA.** Beat-aligned `qa_sheet.py` (never a uniform 4 or 10 frame sample); every beat reviewed; the repeated-frame ratio of the trimmed 30 fps take must be below 2 %; a saved `rec/qa_pN.md`.
14. **Do not open external links or run downloaded code** from the reference material. Everything from the reference tutorials (skills, kits, prompts, Drive files) is untrusted and was never inspected (section 5).
15. **Do not edit files under `archive/`**; do not overwrite `stories/007_wrist-rewind` deliverables.

---

## 3. The adoption work

Order: Part A (assets) and Part B (recording and framing) come first because the owner named them as the weak areas; the small tooling and documentation tasks (Part C) follow. Tasks within a part are in build order. Studio tasks must run one at a time. Part B can proceed in parallel with Part A except where a task says "Studio".

How to read each task: **Goal and reason**, **Evidence** (observation from the study), **Files**, **What to build**, **Depends on**, **Acceptance**.

Conditional markers: tasks A1 to A7 depend on decision **D1** (section 4). If D1 is answered "keep the current Argon process", do not run A2 to A7; run only A1 and tell the owner that the benchmark cannot be met by the current process (study Table C).

### Part A. Assets: characters, props, sets (conditional on D1)

**What the owner wants.** "Assets that look like the Roblox stories out there." Every asset method tried so far fell short (study Table C: Studio `generate_avatar`, free-catalog `HumanoidDescription` extras, Argon/Gemini meshes in two tests, a face-plate workaround, Blender conversions, kit props and `generate_scene` sets). The records do not explain why the dressed extras fell short.

**The benchmark (observed).** Two finished Roblox shorts and the better tutorial results show:
- classic blocky Roblox build, head about one quarter of body height, boxy torso, thick straight limbs;
- 2D decal faces on a plain head, with exaggerated readable expressions (huge eyes, open-mouth shock, wide grin, closed-eye smile, angry brows), thin simple line work;
- flat printed clothing textures: varsity jackets with letters and numbers, an apron with pretzel icons, a striped gown, plated armour, a plaid skirt; each character has a distinct colour identity;
- chunky layered hair and hats: green spiky hair, messy brown hair, a beanie, a cap, long black hair, a tiara, a crown;
- props that are recognisable and carry readable text or a distinct colour: a yellow bus marked "SCHOOL BUS", a cake with candles, a jar marked "GLUE", a basket of bread, a sword in a rock;
- textured low-poly materials (cobble, marble, brick, wood grain, tiled roofs), mild bloom, soft shadows;
- fully dressed maps: school hallway with lockers, marble floor and windows; playground; bridge with arches, cars and a skyline; a half-timbered medieval town with lit windows, bunting strings, market tents and a castle, shown at day, dusk and night; crowds of distinct extras.

**The recommendation (not observed; to be tested).** Build characters on the standard R6 or R15 rig with printed clothing textures, chunky layered hair or hats and a 2D decal face; make Argon (or any image model) produce 2D art only (clothing textures, face decals, prop label art) instead of 3D meshes; build sets from Roblox-native parts and free Toolbox models dressed to the density above; give every key prop readable text or a distinct colour. The study could not see how the example creators made their assets, so every step below ends in a test against the benchmark.

#### A1. Write the benchmark and checklist (needed whatever D1 says)
- **Goal and reason:** a written, checkable definition of "looks like the Roblox stories out there", because you cannot see the reference videos.
- **Evidence:** study 3.5, Visual benchmark table.
- **Files to create:** `docs/ASSET_BENCHMARK.md`; folder `reference/benchmark_frames/` with a `README.md` saying "owner to add 6 to 10 frames from the reference shorts; filenames `07_t<seconds>.jpg`, `09_t<seconds>.jpg`".
- **What to put in `docs/ASSET_BENCHMARK.md`:** the benchmark list above (copy it) and this pass/fail checklist, one line each, to be answered Yes or No for every character, prop and set in a test frame:
  1. Body is a standard R6 or R15 rig with Roblox proportions (head about 25 % of body height), no sculpted anatomy.
  2. Face is a 2D decal on the standard head, expression readable at 25 % of frame height without zooming.
  3. Clothing reads as a flat printed texture with a clear colour identity (at least two colours and one printed detail such as a number, icon or stripe).
  4. Hair or hat has a strong silhouette distinct from every other character in the shot.
  5. Every prop in the shot is recognisable in under one second; key props carry readable text or a unique colour; none is a pale untextured shape.
  6. The set behind the character contains at least three recognisable set objects and a sky or horizon; no baseplate grid, no empty void.
  7. Surfaces use at least one real material texture (brick, wood, cobble, marble, fabric).
  8. No body part is default grey or black, and no texture failed to load.
  9. Extras in a crowd shot (at least three) have different hair and outfits.
  10. Lighting follows `ClockTime = 16.8` with soft shadows and no blown-out areas.
- **Depends on:** nothing.
- **Acceptance:** `grep -c "^  [0-9]*\. " docs/ASSET_BENCHMARK.md` prints at least `10`; `reference/benchmark_frames/README.md` exists; the owner confirms the list matches what they mean (record the answer in the file).

#### A2. Spike: find out how clothing, faces and accessories can be applied (Studio, unknown)
- **Goal and reason:** the study does not show how the example creators dressed their avatars. Several facts the recommendation relies on are unknown and must be found out, not assumed.
- **Unknowns to resolve, each with a one-line answer in the result file:**
  1. Can a custom 2D image be applied to a standard R6 or R15 body as clothing without publishing a catalog item (for example as `Shirt.ShirtTemplate` or `Pants.PantsTemplate` pointing at an uploaded image asset, or as a `Decal` or `SurfaceAppearance` on the torso and limb parts)? What works in Edit mode in Studio?
  2. If a catalog clothing item must be created and uploaded, what is the current upload cost and moderation delay? (Do not spend money; find the published figure on the Roblox Creator Hub documentation and record the URL.)
  3. Roblox's published classic-clothing template size (believed to be 585 by 559 px for shirts and pants; verify before relying on it).
  4. Does swapping `Head.face` `Decal.Texture` on a standard head change the face cleanly (the repository notes that texture-only swaps failed on the old `generate_avatar` head because the mesh differed)?
  5. Which accessory pool is available for hair and hats: free catalog items only (`MaxPrice 0`, as in `assets/rigs/bystanders_school.luau`) or paid items? What is the visual difference to the benchmark?
  6. Which Toolbox sets and props are free to use (licence shown on the item page), and can `insert_asset` or the Toolbox insert them in Edit mode?
- **Files to create:** `docs/ASSET_SPIKE_RESULT.md` with a table: unknown, how tested, result, evidence (screenshot path under `assets/spike/`). Create `assets/spike/` for screenshots.
- **How:** Studio, one job at a time. Create a new empty place `assets/maps/spike.rbxl`. Use a Studio automation tool if you have one (for example a script executor); otherwise paste Luau into the Studio command bar. Every claim in the result file must be labelled `executed`, `statically checked` or `not run`.
- **Depends on:** A1.
- **Acceptance:** `docs/ASSET_SPIKE_RESULT.md` has an answer (or "not determinable, because ...") for all six unknowns, and at least one screenshot per resolved unknown exists in `assets/spike/`.

#### A3. Classic avatar builder
- **Goal and reason:** one function that builds any cast member as a benchmark-style avatar, replacing the per-method scripts that failed.
- **Evidence:** benchmark table; the extras script `assets/rigs/bystanders_school.luau` already uses `Players:CreateHumanoidModelFromDescription`.
- **File to create:** `engines/roblox/classic_avatar.luau` (a ModuleScript returning a table).
- **Signature and behaviour:**
  ```
  type AvatarSpec = {
    name: string,                 -- Model name = character name (e.g. "Mia")
    rig: "R6" | "R15",
    skinHex: string,              -- from assets/faces/skin_tones.json, e.g. "#E8B98A"
    shirtImage: string?,          -- rbxassetid for the clothing texture (see A2 result)
    pantsImage: string?,
    hairIds: {number},            -- accessory asset ids (hair, hats)
    faceDecals: {[string]: string}, -- emotion name -> rbxassetid, e.g. {Happy="rbxassetid://..."}
    startFace: string,
    scale: number?,               -- 1.0 teen, 0.62 kid, 1.08 adult
  }
  function build(spec: AvatarSpec): Model
  function setFace(model: Model, emotion: string): ()   -- swaps Head.face Decal.Texture
  function placeAt(model: Model, cf: CFrame): ()
  ```
  `build` creates a `HumanoidDescription`, sets `HeadColor`, `TorsoColor`, `LeftArmColor`, `RightArmColor`, `LeftLegColor`, `RightLegColor` to `skinHex`, assigns `HairAccessory` and `HatAccessory` from `hairIds`, calls `Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType[spec.rig])`, then applies the clothing method that A2 proved works, sets the start face and applies `scale`. It names the model `spec.name`, adds `CanQuery = true` on every part, and returns it. It must work in Edit mode (the cutscene engine has no Animator in Edit mode; see `docs/LESSONS_LEARNED.md`). Use `task.wait`, never `wait()`.
- **Depends on:** A2.
- **Acceptance:** run in Studio (one job): build `Test_Hero` (R6) and `Test_Mia` (R15) and print for each: `RigType`, number of `Accessory` children, whether `Head:FindFirstChild("face")` exists, and the count of `BasePart` children whose `Color` equals the default grey `Color3.fromRGB(163,162,165)`. Expected: rig types as requested, at least 1 accessory each, `face` exists, grey count 0. Save the output to `assets/spike/A3_output.txt`.

#### A4. Argon becomes a 2D art supplier (only if D1 says replace)
- **Goal and reason:** Argon's 3D mesh output failed twice (`audits/argon_002`, `audits/argon_003`); image generation is a different task and is what a flat clothing texture and a face decal need.
- **Files to change:** `docs/ARGON_PIPELINE.md` (style lock section and the prompts), `templates/production_manifest_template.md` (sections C and D), `.claude/skills/new-story/SKILL.md` step 6c (what the zip contains).
- **What to write:**
  - In `docs/ARGON_PIPELINE.md` add a section "2D art deliverables" that lists exactly: per character, one clothing texture PNG for the shirt and one for the pants at the template size found in A2; one face PNG per emotion needed (standard set: Determined, Happy, Shocked, Worried, Crying, Smirk, Sad, Straining), square, transparent background, exaggerated expressions with thin line work as in the benchmark; per key prop, one label or texture PNG; export paths `assets/faces/<Char>/<Emotion>.png`, `assets/clothing/<Char>_shirt.png`, `assets/clothing/<Char>_pants.png`, `assets/props/<Prop>_label.png`; each gets an `assets/INDEX.md` row (path, what it is, "Argon 2D", prompt used, story).
  - State in that section: "Argon does not build 3D character meshes, rigs, hair meshes or sets for new stories. Characters are built by `engines/roblox/classic_avatar.luau`; sets are built from Roblox-native parts and Toolbox models (task A5)."
  - Write a new prompt block "PROMPT 3: 2D art" that tells Argon to follow the benchmark list (copy it from `docs/ASSET_BENCHMARK.md`), the skin hex per character, and the file names above.
  - In the manifest template section C, replace the "Source: REUSE / NEW (Argon)" row with "Clothing texture / face set: REUSE <path> / NEW (Argon 2D)" and add "Hair or hat asset ids".
- **Depends on:** A2 (template size), owner decision D1.
- **Acceptance:** `grep -n "2D art deliverables" docs/ARGON_PIPELINE.md` returns one line; `grep -n "PROMPT 3" docs/ARGON_PIPELINE.md` returns one line; the section lists every export path above.

#### A5. Set dressing kit
- **Goal and reason:** the benchmark maps are fully dressed; the project's sets arrived empty, below the baseplate and with missing walls (`docs/LESSONS_LEARNED.md`, "Sets").
- **Files to create:** `docs/SET_DRESSING.md`; `engines/roblox/sets/hallway_dressed.luau` (one idempotent builder script). Log every Toolbox model used in `assets/INDEX.md` with its source URL and licence.
- **What to put in `docs/SET_DRESSING.md`:** a dressing checklist per set type with minimum counts: *school hallway*: at least 12 lockers in two colours, at least 3 windows with sky visible, one floor material with texture, one notice board with readable text, a ceiling, a door at each end, at least 4 small props (bench, bin, poster, clock). *Town street*: at least 6 buildings with lit windows, a strand of bunting or lamps, 3 market stalls or cars, a skyline, ground material (cobble or asphalt). *Any set*: bottom at Y about 0.05, closed walls and ceiling, signs at least 1.2 studs below the ceiling, no grey baseplate visible in any shot, builder scripts idempotent (running twice produces one set, not two).
- **How:** the builder deletes any model named `Set_<Name>` before building it. It uses Roblox-native `Part`s with `Material` and `SurfaceAppearance`, plus free Toolbox models resolved by A2.
- **Depends on:** A2.
- **Acceptance:** in Studio, run the builder twice; print `#workspace:GetChildren()` counts for models named `Set_Hallway`: expected `1`. Count objects by class with a script and confirm every minimum in the checklist (print a table). Take three screenshots from the engine's cameras into `assets/spike/A5_*.png` and check them against A1 items 6, 7 and 8.

#### A6. Side-by-side test and owner sign-off
- **Goal and reason:** prove, with a picture, that the new method closes the gap before changing any rule.
- **What to do (Studio, one job; no recording, still screenshots only):** build one test cast (two characters with different outfits, hair and faces; three extras) with A3 and A4's 2D art, in the A5 hallway. Capture three still frames per character class at 1080x1920: face close-up (face 25 to 35 % of frame height), medium shot, wide shot with extras. Save to `assets/spike/A6_*.png` and put them next to the owner's benchmark frames in one contact sheet `assets/spike/A6_vs_benchmark.png`.
- **Files to create:** `assets/spike/A6_report.md` answering each A1 checklist item Yes or No per frame with a one-line reason.
- **Depends on:** A1, A3, A4, A5; the owner must have supplied benchmark frames (A1).
- **Acceptance:** all ten checklist items are Yes for every test frame, and the owner replies "matches" in writing. If any item is No, record why and stop; do not change any rule (A7).

#### A7. Make the new method the standard (only after A6 passes)
- **Files to change:** `AGENTS.md` (the "Argon assets" section, the "Asset process" section, the "Hard production rules" line on characters), `docs/ARGON_PIPELINE.md` (header, "Who does what", "Style lock"), `docs/LESSONS_LEARNED.md` ("Characters & faces", "Sets"), `.claude/skills/roblox-characters/SKILL.md`, `.claude/skills/roblox-cinema-director/SKILL.md`, `docs/SETUP_GUIDE.md`, `assets/INDEX.md`.
- **What to write:** replace "Argon builds all assets" with: "Characters are classic R6 or R15 avatars built by `engines/roblox/classic_avatar.luau`; Argon supplies 2D art only; sets are Roblox-native with free Toolbox models, dressed per `docs/SET_DRESSING.md`; every asset must pass `docs/ASSET_BENCHMARK.md`." Mark the old methods (Studio `generate_avatar` for the main cast, face head clones, Argon meshes, Blender conversions) as "tried, did not meet the benchmark; see `docs/REFERENCE_STUDY_2026-11-17.md` Table C". Keep every rule about one Studio job at a time and about recording only when told.
- **Depends on:** A6 passed and the owner's written approval.
- **Acceptance:** `grep -rn "Argon builds all assets" AGENTS.md docs .claude` returns nothing; `grep -rn "classic_avatar" AGENTS.md docs` returns at least three lines; the owner has approved the diff.

### Part B. Recording and framing

**Observed in the repository (not the references).** Capture is `ffmpeg gdigrab` of a hard-coded region (`REGION = x 4, y 160, w 1882, h 966` in `pipeline/record_take.py`) with the camera rolled 90 degrees. After rotation the picture is only 966 px wide, scaled to 1080 (about 12 % upscale); `docs/LESSONS_LEARNED.md` itself asks for at least 968 px. In `finish_video.py` the crop `crop=iw:min(ih,iw*16/9)` also cuts the rotated 1882 px side to 1717 px, so the engine's camera sees about 9 % more than the final frame at the viewport's long edges. The output is resampled to 60 fps. Every shot gets the same slow push-in (`story007_cutscene.luau` lines 1277 to 1283); snap-out and impact-zoom do not exist. In the story 007 beat sheet (`stories/007_wrist-rewind/audit_v2/02_after_part1_beat_sheet.png`) beats B2, B16, B17, B20 and B21 are macros where an object fills the frame and the action is unreadable, a glass beaker sits in front of Jace's face in B5, B6, B15 and B17, the first beat opens on a hand, and captions sit on a dark bench strip. The external audit scored "Camera and Scene Framing" 5 of 10.

**Observed in the references.** The Studio tutorial (03) uses the same capture: roll the camera 90 degrees, record the Studio window, rotate (03, 05:39 to 05:55). Both finished shorts cut about every 1.1 to 1.3 s and keep the subject large with captions in a different part of the frame from the face (07 captions at about 64 to 69 % from the top, 09 at about 24 to 29 %). The Blender tutorial (02) previews three small pictures of every shot before the long render. So the recommendation keeps the capture method and fixes resolution, shot design and checking.

#### B1. Finish at 30 fps
- **Goal and reason:** removes the 30-to-60 fps duplication that makes the 2 % repeated-frame gate meaningless on the final file; both example shorts are 30 fps.
- **Files to change:** `pipeline/finish_video.py` line 75: replace `fps=60` with `fps=30`; the module docstring line 4: replace `@60fps` with `@30fps`; `.claude/skills/produce-video/SKILL.md` step 6: delete the sentence "Note: the script currently resamples to 60 fps ..."; `templates/beats_template.json` already says 30; set `"fps": 30` in `stories/007_wrist-rewind/beats_p1.json` and `beats_p2.json` only if the owner allows editing story 007 (otherwise leave them).
- **Depends on:** nothing.
- **Acceptance:** create a synthetic raw clip and finish it:
  `ffmpeg -y -f lavfi -i testsrc=size=1882x966:rate=30 -t 6 stories/_test/raw.mp4` then
  `python pipeline/finish_video.py --raw stories/_test/raw.mp4 --part-dir stories/007_wrist-rewind/p1 --out stories/_test/fin.mp4 --end 5` then
  `ffprobe -v error -select_streams v -show_entries stream=r_frame_rate,width,height -of csv=p=0 stories/_test/fin.mp4`.
  Expected output: `1080,1920,30/1` (field order as printed by ffprobe). Delete `stories/_test/raw.mp4` and `fin.mp4` afterwards.

#### B2. Capture region from the real window, with a resolution gate
- **Goal and reason:** the hard-coded region silently records the wrong area if Studio's panels change, and 966 px is below the repository's own 968 px floor.
- **File to change:** `pipeline/record_take.py`.
- **What to build:**
  ```
  def window_rect(title: str) -> tuple[int, int, int, int]:
      """(left, top, right, bottom) of the window whose title contains `title`, via ctypes
      user32.FindWindowW / GetWindowRect; raise SystemExit with a clear message if not found."""

  def check_region(region: dict) -> int:
      """Return the native width after rotation (= region['h']). Print it, and:
         < 968  -> raise SystemExit('viewport too small: collapse the ribbon and panels')
         968..1079 -> print 'WARN: upscale x%.2f to 1080' % (1080 / region['h'])
         >= 1080 -> print 'OK: native'. """
  ```
  Add flags `--region x,y,w,h` (overrides `REGION`) and `--check-region` (prints the Studio window rectangle, the region in use, calls `check_region`, exits without recording). `record()` must call `check_region(REGION)` before starting ffmpeg. Do not change gdigrab options (`-framerate 30 -draw_mouse 0`).
- **Depends on:** nothing. Needs Studio open to test; no recording is made, so the "record" rule is not triggered.
- **Acceptance:** with Studio open, `python pipeline/record_take.py --check-region --out x.mp4` prints the window rectangle and the region and one of `WARN: upscale x1.12 to 1080` (for the current 966 px) or `OK: native`, and exits with code 0 for 968 or more and non-zero below 968. Test the non-zero path with `--region 4,160,1882,900`: expected a `viewport too small` message and a non-zero exit code (`echo $?` or `$LASTEXITCODE`).

#### B3. Frame specification and a guide overlay on the QA sheet
- **Goal and reason:** a written definition of a correct 1080x1920 frame, and a way to see violations on every beat tile. The owner reports the framing was not good; the story 007 sheet shows unreadable macros, occluded faces and bench-covered captions.
- **Files to create:** `docs/FRAMING_SPEC.md`. **Files to change:** `pipeline/qa_sheet.py` (add `--guides`), `.claude/agents/render-qa.md` and `.claude/skills/roblox-cinema-director/SKILL.md` (link to the spec; add the fail conditions below).
- **What to put in `docs/FRAMING_SPEC.md` (all values for the final 1080x1920 frame):**
  - **Reserved zones.** Top 192 px (10 %): platform header, nothing important. Bottom 346 px (18 %), y from 1574: caption and platform controls. Right 130 px (12 %), x from 950: platform buttons. Left margin 54 px. The **action-safe box** is x 54 to 950, y 192 to 1574 (896 by 1382 px). Faces, the world-rule marker and the key prop must be inside it.
  - **Caption placement (decision D3).** Lower captions: the text block lies between y 1500 and 1690, so every face must end above y 1450. Upper captions: the block lies between y 170 and 380, so every face starts below y 400. References measured: 07 captions at 64 to 69 % (y about 1230 to 1325), 09 at 24 to 29 % (y about 460 to 560). The caption never covers a face.
  - **Face beat.** Face height (chin to top of hair) 25 to 35 % of frame height (480 to 672 px). Eye line 30 to 40 % from the top (y 576 to 768). Headroom above the hair at least 4 % (77 px). Never crop the forehead, chin or ears. One subject: face centre x between 300 and 780.
  - **Two-shot.** Both faces fully visible, combined width at most 85 % (918 px).
  - **Insert (hand or prop).** The object is 35 to 60 % of frame height with context (wrist and sleeve, or the holder's face in the background). Duration at most 1.2 s; at most 20 % of all beats are inserts; never a pale untextured shape; any text on the object at least 77 px tall.
  - **Wide establishing shot.** Horizon between 35 and 55 % from the top; at least three recognisable set objects visible.
  - **Opening beat.** The first beat shows a face or the key action, not a bare insert (the story 007 hook opens on a hand and was flagged).
  - **Never cut off or covered:** top of head, eyes, the world-rule marker (counter, mark, aged hands), a held key prop (except a deliberate macro). Nothing between camera and face: the `clearShot()` raycast to the eyes and chest must both be clear.
  - **Crop reality.** After the roll and rotation the engine's viewport is cropped from 1882 to 1717 px by `finish_video.py`; the engine should frame inside the central 91 % of its viewport's long side.
- **What to build in `qa_sheet.py`:** a `--guides` flag that, before the tile is scaled to 216x384, draws the action-safe box and the reserved bottom zone on the full-size frame. The ffmpeg filter to prepend to the existing `scale=216:384,drawtext=...` chain is:
  `drawbox=x=54:y=192:w=896:h=1382:color=lime@0.9:t=4,drawbox=x=0:y=1574:w=1080:h=346:color=red@0.25:t=fill,`
  (put it first in the `-vf` string, keep the existing scale and drawtext after it).
- **New fail conditions to add to `render-qa.md`:** a face height outside 25 to 35 % on a face beat; the eye line outside 30 to 40 %; headroom under 4 %; the world-rule marker outside the action-safe box; an insert longer than 1.2 s; an opening beat that is a bare insert.
- **Depends on:** nothing.
- **Acceptance:** `python pipeline/qa_sheet.py --video stories/007_wrist-rewind/007_wrist-rewind_part1.mp4 --words stories/007_wrist-rewind/p1/words.json --beats stories/007_wrist-rewind/beats_p1.json --lead 0.3 --guides --out stories/_test/qa_guides.png` prints `28 frames -> stories/_test/qa_guides.png` (27 beats plus END) and the PNG shows a lime rectangle and a translucent red bottom band on every tile. Check one tile by eye. Delete the test PNG afterwards. `grep -c "action-safe" docs/FRAMING_SPEC.md` is at least 1.

#### B4. Beat-table linter with framing fields
- **Goal and reason:** story 007's table breaks the project's own limits (average 2.07 s, maximum 4.0 s); the camera mix is required but never counted; the study's references cut every 1.1 to 1.3 s.
- **Files to create:** `pipeline/check_beats.py`. **Files to change:** `templates/beats_template.json` (new optional fields), `.claude/skills/produce-video/SKILL.md` (new step 3b).
- **New beat fields** (documented in the template and in `docs/FRAMING_SPEC.md`): `"mode"`: one of `"push"`, `"snapOut"`, `"impact"`, `"static"`; `"size"`: one of `"face"`, `"two"`, `"insert"`, `"wide"`, `"action"`; `"subject"`: the character or prop name; `"face_pct"`: target face height in percent for `size` `"face"` (25 to 35).
- **What to build:** `python pipeline/check_beats.py <beats.json> [--words words.json] [--sfx-dir assets/sfx] [--strict]`. Constants at the top: `AVG_MIN = 1.0`, `AVG_MAX = 2.0` (change after decision D4), `DUR_MAX = 3.0`, `INSERT_DUR_MAX = 1.2`, `INSERT_SHARE_MAX = 0.20`, `MIX = {"push": 0.60, "snapOut": 0.25, "impact": 0.15}`, `MIX_TOL = 0.15`. Output, one line each: beat count; average and maximum `dur`; the mode counts and shares versus `MIX` (beats with no `mode` count as `unknown` and print `WARN`); the share and longest duration of `insert` beats; every beat whose `line` is missing, or whose first word is not in `words.json` (if given) → `FAIL beat N dropped: <line>`; every `sfx` whose `<sfx-dir>/<name>.wav` is missing → `FAIL`; first beat `size` equal to `insert` → `WARN`. Exit code 1 if any FAIL, or any limit is broken; `--strict` turns WARN into failure.
- **Depends on:** nothing.
- **Acceptance:** `python pipeline/check_beats.py stories/007_wrist-rewind/beats_p1.json --words stories/007_wrist-rewind/p1/words.json --sfx-dir assets/sfx; echo $?` must print `27 beats`, `avg 2.07`, `max 4.0`, report the average and maximum as breaking the limits (`FAIL avg > 2.0` and `FAIL max > 3.0`), report all modes as `unknown`, and exit with code `1`. A hand-made file with 10 beats of `dur` 1.5, `mode` mixed as 6 push, 3 snapOut, 1 impact, every `line` present, and an existing sfx name must print `OK` and exit `0`.

#### B5. Camera modes in the engine
- **Goal and reason:** the required mix (about 60 % push-in, 25 % snap pull-out, 15 % impact snap-zoom with a 2.5 degree tilt) is not implemented; every shot uses one push-in. The Studio tutorial (03, 05:21 to 05:35, a claim) also describes mostly push-ins, snaps and tilted shots.
- **Files to create:** `engines/roblox/camera_modes.luau` (ModuleScript with a self-test). Wiring it into a story engine is done per story; do not edit `story007_cutscene.luau` unless the owner allows.
- **Signatures:**
  ```
  type Frame = { cf: CFrame, fov: number }
  function pushIn(base: CFrame, dist: number, t: number, dur: number, fov: number): Frame
      -- move the camera forward by dist*0.04*ease(t) per second, capped at dist*0.15; FOV unchanged
  function snapOut(base: CFrame, dist: number, t: number, dur: number, fov: number): Frame
      -- start at 0.55*dist from the subject, ease to dist over 0.25 s, then hold with a slow push
  function impact(base: CFrame, dist: number, t: number, dur: number, fov: number): Frame
      -- FOV punch of -8 degrees returning over 0.12 s, plus a fixed roll of 2.5 degrees (math.rad(2.5))
  function apply(mode: string, ...): Frame        -- dispatch on beat.mode, default push
  ```
  All functions are pure (no Instance access) so they can be self-tested. FOV is clamped to 1 to 120; `CameraType = Scriptable` must be set by the caller before assigning `CFrame`.
- **Depends on:** B4 (the `mode` field).
- **Acceptance:** run the module's self-test in Studio (`execute_luau` or the command bar). It must print `camera_modes ok` after asserting: `snapOut(...)` at t = 0 returns a camera 0.55 of the distance from the subject and at t = 0.25 returns 1.0 (tolerance 0.01); `impact(...)` at t = 0 returns `fov` minus 8 and a roll of 2.5 degrees, and at t = 0.12 returns `fov` within 0.1; `pushIn(...)` at t = 0 returns the base `CFrame` unchanged.

#### B6. Pre-record shot preview step
- **Goal and reason:** the references preview every shot cheaply before the long run (02, 01:49: "three small pictures of every shot", about 12 s; 03, 03:24: Claude presses play and checks every shot ran). AI-Vid's dry run records a video; a preview of stills catches wrong framing earlier.
- **Files to change:** `.claude/skills/produce-video/SKILL.md` (a new sub-step in step 4, before the owner is asked to record); `docs/FRAMING_SPEC.md` (a "Preview" paragraph).
- **What to write:** "For each beat, set the camera at the beat midpoint and save one still at 1080x1920 equivalent (Studio screenshot of the rolled viewport, rotated) to `rec/preview_pN/B<n>.png`; build a contact sheet with the same ffmpeg tile used by `qa_sheet.py` and `--guides`; run the FRAMING_SPEC checks. No video is recorded in this step, so the 'record' rule does not apply."
- **Depends on:** B3.
- **Acceptance:** the step exists in `SKILL.md` (`grep -n "preview_p" .claude/skills/produce-video/SKILL.md` returns a line) and a preview folder for one story contains as many PNGs as `beats_pN.json` has beats.

### Part C. Small tooling and documentation tasks

#### C1. `pipeline/measure_video.py`
- **Goal and reason:** turns "feels fast" into numbers, with the same method the study used; lets AI-Vid compare its output with any local reference file the owner supplies.
- **File to create:** `pipeline/measure_video.py`; uses only ffmpeg and ffprobe (already required). Never downloads anything.
- **Behaviour:** `python pipeline/measure_video.py <video> [--words words.json | --transcript text.txt] [--sheet out.jpg]`. Prints (one `key: value` per line): `duration_s`, `fps` (from `r_frame_rate`), `size`, `cuts` (count of frames where `select='gt(scene,0.3)'` with `showinfo` gives a `pts_time` greater than 0), `avg_shot_s` = duration / (cuts + 1), `words` and `wpm` (= words / duration x 60; from `words.json` entries or whitespace-separated tokens of the transcript, ignoring bracketed timestamps). `--sheet` writes a contact sheet of one frame per second, 6 columns by up to 5 rows (`fps=1,scale=225:-2,tile=6x5`), starting at 0.
- **Depends on:** nothing.
- **Acceptance:** `python pipeline/measure_video.py stories/007_wrist-rewind/007_wrist-rewind_part1.mp4 --words stories/007_wrist-rewind/p1/words.json` prints `fps: 60.0` (before B1), `size: 1080x1920`, `duration_s: 50.05`, `cuts` between 46 and 52 (measured 49 on 2026-11-17), `avg_shot_s` between 0.95 and 1.1, `words: 152`, and `wpm` between 180 and 187.

#### C2. Highlighted-keyword captions (optional style)
- **Goal and reason:** the craftee_films reel (09) puts one keyword per card in bright green (white elsewhere, black outline); the repository's own hardening report lists this as an experiment. It adds emphasis when the video is muted.
- **Files to change:** `pipeline/voice_subs.py`, `pipeline/test_voice_subs.py`.
- **What to build:** a flag `--highlight` (default off) and a constant `HIGHLIGHT = "&H002EE82E&"` (ASS colour order is blue-green-red, so this is the green `#2EE82E`). In `voice_subs.py` add
  ```
  def pick_highlight(card_words: list[dict]) -> int:
      """index of the last word whose normalised form (letters only, lower case) is not in NO_END
      and has at least 3 letters; if none, the last word."""
  ```
  and make `build_ass(words, style, per_beat, highlight=False)` wrap that word as `{\c&H002EE82E&}WORD{\c}` (a bare `\c` returns to the style colour) inside the existing upper-cased phrase; keep the existing scale-pop tag at the start. Pass `highlight=a.highlight` from `main`. Do not change the default output when the flag is absent.
- **Observed in 09:** the highlighted word is nearly always the last content word of the card (the, SWORD; marries the, PRINCESS; I, TRIPPED; for 100, YEARS).
- **Depends on:** nothing.
- **Acceptance:** add to `test_voice_subs.py`:
  ```
  from voice_subs import pick_highlight, build_ass
  c = lambda *ws: [{"word": x, "start": 0, "end": 0.2} for x in ws]
  assert pick_highlight(c("the", "sword")) == 1
  assert pick_highlight(c("marries", "the", "princess")) == 2
  assert pick_highlight(c("I", "tripped")) == 1
  assert "{\\c&H002EE82E&}" in build_ass(c("the", "sword"), "LowerThirdWhite", 2, highlight=True)
  assert "{\\c&H002EE82E&}" not in build_ass(c("the", "sword"), "LowerThirdWhite", 2)
  ```
  `python pipeline/test_voice_subs.py` must print `ok`.

#### C3. Documentation corrections and additions
- **`reference/BENCHMARKS.md`, row 2 (craftee_films "The SWORD"), last column.** Replace the text `**Lower-Third (`Y = 82%`)**, bold white & green outlined text.` with `**Upper third, about Y = 24 to 29 %**, two lines, white text with the keyword in bright green, black outline (measured 2026-11-17, see docs/REFERENCE_STUDY_2026-11-17.md).` Reason: the frames show the captions in the upper third.
- **`docs/ENGAGEMENT_RULES.md`:** append a section "Patterns seen in the reference shorts (optional)": (1) plant three small details early that return at the end (03, 03:45, a tutorial claim; 09 plants the bread the princess keeps taking and pays it off as proof of her plan); (2) a reveal that recasts the opening line (09: she loosened the sword herself); (3) a recap during the last line that reuses earlier shots (07 `sheet_02` tiles 4,4 to 4,6); (4) the story rule may be shown by a persistent on-screen mark on every character (07: a yellow star on each hand). State that these are options and that the existing gates (meaning, completeness, no filler, verification) still apply.
- **`templates/production_manifest_template.md`:** in section D add the row `| Readable label | text on the prop at least 77 px tall in the shot, or a unique colour | ... |`; in section H add the checks "every key prop has readable text or a unique colour" and "every face beat meets docs/FRAMING_SPEC.md".
- **Depends on:** B3 for the FRAMING_SPEC link.
- **Acceptance:** `grep -n "Upper third, about Y = 24" reference/BENCHMARKS.md` returns one line; `grep -n "Patterns seen in the reference shorts" docs/ENGAGEMENT_RULES.md` returns one line; `grep -n "Readable label" templates/production_manifest_template.md` returns one line.

---

## 4. Decide with the owner before building

Ask each question as written; do not start the dependent tasks until it is answered.

**D1. Assets: replace "Argon builds all assets"? DECIDED 2026-11-17: option (a), owner approval after the side-by-side test (classic R6 + catalog items; Argon 2D art only; rules updated).** The current rule has not delivered the owner's standard ("assets that look like the Roblox stories out there"): every method tried failed (Studio `generate_avatar`, free-catalog extras, two Argon mesh tests, a face-plate workaround, Blender conversions, kit props, generated sets; study Table C). Options: (a) replace it: classic R6 or R15 avatars with printed clothing and decal faces, Argon producing 2D art only, sets built from Roblox-native parts and free Toolbox models, tested first (tasks A1 to A7); (b) keep Argon building 3D assets and iterate on the meshes (no task in this guide supports it; the two mesh tests ended with "neither option is ready"); (c) cast from catalog avatars only with Toolbox sets and no custom art (the lowest-effort option, least control over identity). **Recommendation: (a), gated by the side-by-side test A6 and applied to the rules only in A7.** It conflicts with "Argon builds all assets", with the `generate_avatar` and head-clone face rules, and with the locked "v1" face style, and the guide says so plainly.

**D2. Faces. DECIDED 2026-11-17: flat 2D decal faces on the standard R6 head (`assets/faces/classic_v1/`), owner approval.** Change from the locked semi-realistic "v1" head clones to simple exaggerated 2D decals on the standard head, as the two finished shorts do? Options: yes; no (keep v1); test both on one character in A6. **Recommendation: test both in A6 and let the owner choose from the frames.**

**D3. Caption placement.** Keep only the lower third (Y about 82 %) and upper third (Y about 15 %) of `AGENTS.md`, or also allow the two positions the finished shorts use (about 66 % and about 26 %) and more than three words per card (the shorts show 2 to 6 words over two lines)? **Recommendation: keep the current two positions and the 1 to 3 word cards as the default, pick lower or upper per story from where the subject sits, and run the highlight style (C2) on one story as an A/B. The reference positions are a test, not a rule.**

**D4. Cut rate.** Current rule: a new shot every 1.2 to 2 s, 3 s maximum. References: 1.26 s (07) and 1.14 s (09) average. **Recommendation: average 1.2 to 1.5 s, maximum 2.5 s, and set `AVG_MAX` in `check_beats.py` to match. This raises the number of beats per story (about 35 to 45 for a 55 s part) and the build effort per story.**

**D5. Voice pace.** The finished shorts speak at about 230 words per minute (07) and 316 words per minute (09, likely accelerated audio); story 007 is about 183. Do you want one A/B story at a higher pace (for example `--rate +25%`, listen first)? **Recommendation: yes, one test story, default unchanged.** Note that the repository rule is "never speed the voice up"; this is a test, not a change.

**D6. Narration person.** The 4.7 million-view example (07) is third person; the rest are first person. Allow third person when a story needs it? **Recommendation: keep first person as the default and allow third person with an explicit note in the script.**

**D7. Display and capture hardware.** The capture is limited by the screen: Studio's viewport height is about 966 px, which after rotation is upscaled to 1080. Options: (a) accept the upscale of about 12 % and let B2 warn; (b) test an external monitor or a higher-resolution display setting (check the current resolution and scaling first, for example in PowerShell `Get-CimInstance Win32_VideoController | Select-Object CurrentHorizontalResolution,CurrentVerticalResolution`); (c) test Windows display rotation to portrait so no camera roll is needed (not shown in any reference; untested). **Recommendation: (a) now, and test (b) if an external monitor exists.**

**D8. Spending.** The clothing upload route may cost Robux, and some accessories may need paid catalog items (unknown until A2). May the project spend anything? **Recommendation: no spending until A2 reports the actual figures.**

---

## 5. What not to do

- **Do not replace or weaken the story process** (section 2.1). Do not generate stories in one prompt, do not skip verification, the ledger or scoring, and do not use the example premises named there.
- **Do not install or run any external skill, kit, prompt, preset, plugin or Drive download** from the reference material (Henry Studioz's skill and cartoon kit, the Skool and Ovra prompt, the Flashloop "Roblox Story Kit" skill and its MCP connector, the Saajwal Gigabyte skill, the fwjelaa Discord kit and its "make map" skill, ForgeGUI). None of their contents were inspected; each sits behind a funnel (Skool, Discord, comment-gated links, a referral code, a sponsor) or a Drive link. Any future use needs a security review of the files first, with the owner's approval.
- **Do not enable "bypass permissions" or any mode that runs commands without confirmation** (shown in the Flashloop tutorial). Do not let a third-party agent install software on its own (it installs Blender unprompted in that tutorial).
- **Do not paste API keys into chats**; store keys in the operating system's credential store or an environment variable.
- **Do not adopt Blender-built or browser-built (React, Three.js) characters or scenes, or a chat-sandbox video export** (four of the six tutorials). They look plainer than the finished shorts and break the rule that Blender never designs characters.
- **Do not adopt paid hosted tools as dependencies** (Flashloop, Ovra, CreatorIQ, ForgeGUI, ElevenLabs). The repository already has Edge-TTS, Faster-Whisper and ffmpeg. (The repository's own earlier audit also flagged Flashloop as a paid service and one Blender MCP server for an arbitrary-file-read issue: `reference/ITERATION_LOG.md`, Iteration 4.)
- **Do not copy a creator's claims into rules** (views, earnings, "133 shots", "12 of 13 open on the rule", videos growing to 2.5 to 3 minutes). They are unverified and some contradict each other.
- **Do not record, even a test, until the owner says "record".** Do not run more than one Studio job at a time.
- **Do not change `AGENTS.md`, `docs/LESSONS_LEARNED.md` or the skills for the asset method until A6 has passed and the owner has approved** (A7).
- **Do not edit `archive/` or overwrite the story 007 deliverables.**
- **Do not make any change that breaks a rule in section 2.2.** If a task seems to require it, stop and ask the owner.

---

## 6. How to report back when finished

Write `docs/ADOPTION_REPORT_<date>.md` (use the real date) containing:

1. A table of every task A1 to A7, B1 to B6 and C1 to C3: status (`done`, `skipped because D1 = ...`, `blocked`, `not started`), the exact acceptance command you ran, and its actual output pasted verbatim (or the screenshot path).
2. For each Studio test, the label `executed`, `statically checked` or `not run`.
3. The answers to the six unknowns in A2 and the contents of `assets/spike/A6_report.md`.
4. The owner's answers to D1 to D8 as given, with the date.
5. A list of every file created or changed (paths), and a statement that no file under `archive/` and no deliverable of story 007 was changed.
6. Anything that did not work, and anything the evidence could not settle (for example, whether the finished reference shorts used Studio, which catalog accessories they used, and whether clothing can be applied without a paid upload).
7. Confirmation that no external link was opened, no downloaded skill or kit was run, and no recording was started without the owner's "record".

Then tell the owner, in at most 200 words: which tasks passed, which decisions are still open, and the single next action.
