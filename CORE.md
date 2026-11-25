# AI-Vid V5.4 — Lean Production Rulebook (Working Visuals + Fast Auto-Sync Loop)

**Single source of truth.** Read ONLY `CORE.md` + `config.yaml` + `ledger/STORY_LEDGER.md` (and `templates/story_schema.yaml`; worked examples in `templates/blueprints/`). Never scan `docs/_archive/` or old story folders.

## 1. Non-Negotiable Visual & Studio Standards (NEVER Defy)
1. **Real R6 Catalog Avatars ONLY (NEVER primitive Part blocks/statues, NEVER R15, NEVER `generate_avatar`):**
   - Spawn EVERY character (main cast AND crowd extras) via `Engine.buildRig()` in `engines/roblox/core_engine.luau` (`CreateHumanoidModelFromDescription(..., R6)`), gender-locked (`boy|girl|man|woman`), season-matched, varied outfits (never clones).
   - Anchor ONLY `HumanoidRootPart`, set `m.PrimaryPart = m.HumanoidRootPart`, floor-snap by lowest `BasePart`, and disable floating nameplates (`DisplayDistanceType = None`, `HealthDisplayType = AlwaysOff`, `DisplayName = ""`).
   - Faces ONLY via `Engine.setFace(model, emotion)` (`assets/faces/classic_v1/ids.json`: `neutral`, `scared`, `shocked`, `grin`, `determined`, `proud`).
2. **Real Textured Sets & Enclosed Horizons (NEVER flat SmoothPlastic dioramas or empty green voids):**
   - Pick one of the 4 pre-built horizon-enclosed sets in `engines/roblox/sets/` (`street_day`, `school_yard`, `anime_arena`, `cozy_room`, or `street_002_winter`) via `set:` in `story.yaml`, and add 2–3 story-specific props.
   - Any custom prop/set must use real `Enum.Material` textures (`Brick`, `Cobblestone`, `WoodPlanks`, `Concrete`, `Grass`, `Fabric`), Future lighting (`ClockTime = 16.8` default, Bloom/SunRays disabled), enclosed background horizon, and delete ALL `LuaSourceContainer` scripts from inserted Creator Store models.
3. **Live R6 Locomotion & Body-First Framing (Zero Frozen Rigs):**
   - `core_engine.luau` drives real R6 Motor6D animation (`idle`, `walk`, `run`, `wave`, `point`, `punch`, `block`, `knockback`, `dance`) + `move_to` travel synced to `LookVector` (local Z = pitch, local X = roll, `r.loco = nil` reset per frame).
   - Frame whole characters acting; cut every **1.2–2.2s**; run `screen_capture` visual QA on set + cast before recording; reset camera (`Engine.resetCamera()`) after every take.

## 2. Token-Saving & Owner-Only Rules
1. **AI writes ONLY `stories/<ID>_<slug>/story.yaml` (~3–5 KB)** + `ledger/verification/<ID>.md`. Never hand-write `narration.txt`, `beats.json`, `PUBLISH.md`, or 80 KB cutscene monoliths.
2. **Never edit `CORE.md`, `config.yaml`, `core_engine.luau`, `pipeline/*.py`, or `assets/faces/`** unless directed by the owner.
3. **Recording (Owner Rule):** NEVER record until the owner says `"record"`. Always record via `pipeline/record_take.py` (locks cursor at `900, 12`).

## 3. The 4-Step Auto-Synced Fast Loop (~20–30 min per Short)
1. **Kickoff, Web Originality Gate & `story.yaml`:**
   - Check next contiguous Story ID in `ledger/STORY_LEDGER.md` . Never repeat a rule, twist, or core meaning.
   - **Web Originality Gate** (mandatory for all formats except `beat_drop`): run a quick web search (YouTube, TikTok, Reddit) on the world rule + twist and save a concise `PASS` receipt in `ledger/verification/<ID>.md`.
   - Write `stories/<ID>_<slug>/story.yaml` (standalone 40–60s arc, 5th-grade spoken English, ≤2.2s beats, `set:`, `action:`, `move_to:`).
2. **Compile → Voice → Auto-Sync → Lint (0 AI tokens!):**
   ```powershell
   python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml
   python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>
   python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml --sync-words
   python pipeline/preflight_lint.py --story stories/<ID>_<slug>/story.yaml
   ```
   *(Skip `voice_subs.py` and `--sync-words` for `beat_drop`; BPM grid snapping runs automatically!)*
3. **Studio Preview & Visual QA:** Load `core_engine.luau` + chosen set (`engines/roblox/sets/set_<name>.luau`) + compiled `scenes_<ID>.luau`, then run `screen_capture` to verify R6 catalog cast, horizon enclosure, and zero clipping/nameplates.
4. **Record, Auto-QA & Final Export (only after owner says `"record"`):**
   ```powershell
   python pipeline/run_take.py --story-dir stories/<ID>_<slug> --draft
   # Inspect rec/qa_beats.png -> if every beat PASSES:
   python pipeline/run_take.py --story-dir stories/<ID>_<slug> --final
   ```
   Update `ledger/STORY_LEDGER.md` to `Produced`.

## 4. Formats & Templates
Author from `templates/story_schema.yaml` (blank schema + 6-question brief). Worked examples: `templates/blueprints/01_action_mystery_50s.yaml`, `02_roblox_obby_twist_45s.yaml`. Focus on 1–2 formats (`story`, `roblox_game`/`mystery`); `beat_drop` stays 15–28s, no voice. Old V4 templates/format stubs are in `docs/_archive/legacy_v4/`.

## 5. V5.4 Story & Format Rules
**Story**
- Open in media res: a character in trouble or making a visible choice, readable on mute. No world-rule lecture; stakes visible by ~3s.
- 6-question editorial brief (answer in `story.yaml` header before beats; replaces self-scored "hook 9/10"): (1) opening picture on mute, (2) what the character wants, (3) visible obstacle, (4) choice and cost, (5) final picture flips the opening, (6) cut 1 redundant line the animation already shows.
- 30–50% of lines are character dialogue (`speaker:`), rest narrator.
- Real friction or misunderstanding for most of the short before the payoff. One ending, no double endings.
- Kid-safe: no romance or kissing; creepy, not gory. Roblox-native premises encouraged (obby, school, siblings).
- Standalone 40–60s. No Part 1/2 splits. Warn on >60s.
- Titles: 2–6 words + 1 emoji, no "In This World...", no hashtags in titles (hashtags go in the description).

**Captions & voice**
- Captions: `MarginV` 560 default (per-story `caption_margin_v` override allowed when it covers evidence), 1–2 words per card, >=0.55s hold, 1 highlighted keyword (`*word*`).
- Voice: kokoro speed 1.08–1.12; 0.25–0.35s `pause_before` on twists. Fix pacing by cutting lines, not by raising speed.

**QA** (adds to section 3 step 4): muted first-3-seconds check (is the situation and stake clear with no audio?) and a normal-speed playback check (not only the contact sheet).

**Analytics** (ledger, filled after posting): YouTube URL, Final Duration, Stayed-to-Watch %, APV %, First Drop (s).

## Studio Hygiene (Owner Rule, 2026-11-21)
- **After every story is completed** (ledger status `Produced`), move that story's sets, casts, props and FX out of `Workspace` into `ServerStorage._Old/<ID>` so the origin stays clean for the next story and visual QA. Never delete them. Before a new story, `Workspace` should hold only Camera, Terrain, Baseplate, SpawnLocation and the current story's folders.
- `Workspace.Script` (auto-loader) must load the current engine version only.

## Skills are owner-only (2026-11-22)
- AI agents must NEVER edit, rewrite, shorten or delete anything in `.claude/skills`, `.agents/skills` or `.agent/skills`. Propose changes to the owner instead.
- Skill files are read-only on disk. `.claude/skills` is the source; the owner edits there and runs `.claude/sync_skills.ps1`.

## V5.4.5 Story Creativity Protocol (Required Before Writing `story.yaml`)
Every story follows these 4 steps (adds to the editorial brief; does not replace any owner rule):
1. **Pick 1 of 4 engines** and set `engine:` in story.yaml: `ironic_reframe` (looked fine for 40s, flips in the last 5s; dark reframes stay kid-safe: creepy not gory, no romance), `social_karma` (fake friend / scammer / greedy teammate, clever payback), `clever_loophole` (underdog beats a rigged or absurd rule with a specific workaround), `moral_dilemma` (no cartoon villain; a hard choice viewers argue about).
2. **Write the rewatch-flip ending first.** The final 5s recontextualises a detail from the opening 0:01-0:03. This is the ONE ending.
3. **Kill-AI-Prose / Specificity pass.** Cut abstract emotion lines ("I felt scared", "my stomach dropped", "I realized the truth"). Add at least 2 hyper-specific, animatable Roblox details (an unplugged cord on the rug, pushing a Pull door).
4. **1-line in-world CTA or debate question** at the very end, set `cta:` in story.yaml (e.g. "Fair payback or too harsh?"). Never generic "like and subscribe". It is a prompt, NOT a second ending.
- **Brainstorm:** one pitch per engine, ending invented first. Banned overused tropes unless truly subverted: floating timers, glowing marks, haunted buses, 3AM hallways, "In This Town/World".
- **Earned meaning (kept):** every story still needs an earned meaning, shown through the twist or the cost, never a stated Hallmark moral line.

## Model Parity Gate (2026-11-22, applies to GPT, Gemini and Claude equally)
**a) Pitch gate.** Output 3 five-line pitches (engine, opening picture, ending flip, title, set), then STOP. Do not write `story.yaml` or run TTS until the owner picks one.
**b) Self-kill tests before writing** (fail any = rewrite or scrap):
- Spoiler test: could a viewer guess the ending by ~10s or from the title? Add a real second turn or scrap it.
- Loud stakes test: something funny, risky, unfair or embarrassing happens in the first 5s. Quiet subtle object moments are scrapped.
- Set prop reality check: use only the set's built-in props below, at most 2 small custom props, no lighting flips the engine does not support.
  Custom props go in story.yaml `props:` (built by `Engine.spawnProps`; `pos:` or `attach: "Actor/Part"`) and change per beat with `prop:` cues (attach/hide/show). Use `cam: foot_insert` for shoe/floor details.
**c) Hard numbers (enforced by `pipeline/preflight_lint.py`):** 16-24 beats, 40-55s; beat 1 speaks by 0.6s; >=30% of spoken lines are non-narrator; >=3 beats with `with:` partners (target 4); >=4 beats with active SFX (target 5); <=2 beats with `pause_before` (twist/reveal only); no `move_to` within 0.5 studs of the actor's current position; no voice gap >1.2s (except at a pause_before or silent reaction beat).
**Verified built-in props (from `engines/roblox/sets/set_*.luau`):**
- `cozy_room`: Floor, Rug, Ceiling, 4 walls, window (WinFrame/WinGlass), desk (DeskTop, DeskLegL/R), Monitor/Screen, bed (BedFrame, Mattress, Pillow), Bookshelf, Door, CeilingLamp (PointLight).
- `school_yard`: Courtyard, SchoolMain + wings, BackFence, windows, EntryDoor (glass + pull handle), EntryCanopy, SchoolSign, EntryWalk, PlayCourt + BasketPost/Backboard/BasketRim, Planter, Bench, SchoolShowStage (riser, curtains, speakers, stage lights, PerformerMark), TryoutSign, CoachTable.
- `street_day`: Road, sidewalks, lane dashes, Crosswalk, storefronts (Bldg, Door, Awning, windows), LampPost + LampGlobe, BusStopSign/BusStopBoard, Bench.
- `anime_arena`: ArenaFloor, CenterPad, neon TrimN/TrimS, 8 Pillars + Braziers, 4 walls, 3 red BannerN.
**Active SFX** (real wav in `assets/sfx/`, audible in `finish_video.py`): bass_hit, bass_hit_warm, bell, bell_clang_loud, bell_ring_fading, chime_soft, ding, drone_smash, footsteps_sand, footsteps_wood, glass_clink, gold_dissolve, heartbeat, heartbeat_fast, hiss_crack, ignite_shimmer, ignite_shimmer_big, impact_whoosh, piano_note, pour, railing_snap, resolution_chord, rewind_zip, rope_creak, scraping_drag, shutter, skin_creak, splash, stone_thud, swim_splash, thud, thunder, tick, whistle_blow, whoosh, whoosh_hit, whoosh_rewind. **Banned (muted/placeholder or no file):** music_soft, music_swell, music_end_chime, waves, waves_heavy, crowd_beach, crowd_cheer, crickets_waves, seagulls, and any name without a wav.
