# AI-Vid V6.4 — Lean Craft Mode Rulebook

**Single source of truth.** Read `CORE.md` + `config.yaml` + `assets/manifest.json` (the only allowed sets, spots, cameras, motions, actions, faces, fx, prop kits, SFX and overlays) + `ledger/STORY_LEDGER.md`. Copy the shape of the newest `stories/*/story.yaml`. Never scan `docs/_archive/` or old story folders. How-to detail lives in `.claude/skills/ai-vid-pipeline` (master) and `.claude/skills/story-craft` (writing).

## 1. Non-Negotiable Visual & Studio Standards (NEVER Defy)
1. **Real R6 Catalog Avatars ONLY (NEVER primitive Part blocks/statues, NEVER R15, NEVER `generate_avatar`):**
   - Spawn EVERY character (main cast AND crowd extras) via `Engine.buildRig()` in `engines/roblox/core_engine.luau` (`CreateHumanoidModelFromDescription(..., R6)`), gender-locked (`boy|girl|man|woman`), season-matched, varied outfits (never clones; seeded by `wardrobe_seed`, default = story id).
   - Anchor ONLY `HumanoidRootPart`, `m.PrimaryPart = m.HumanoidRootPart`, feet planted on the real floor, no floating nameplates (`DisplayDistanceType = None`, `HealthDisplayType = AlwaysOff`, `DisplayName = ""`).
   - Faces ONLY via `Engine.setFace(model, emotion)` (2D decals, `assets/faces/classic_v1/ids.json`: `neutral`, `scared`, `shocked`, `grin`, `determined`, `proud`).
2. **Real Textured Sets & Enclosed Horizons:** pick a set from `assets/manifest.json` (`school_yard`, `school_hallway`, `classroom`, `auditorium`, `living_room`, `street`, `street_day`, `street_002_winter`, `cozy_room`, `anime_arena`) via `set:` (per-beat `set:` cuts rooms); use only that set's spots. Custom props use real `Enum.Material`, Future lighting, and Creator Store models have all scripts deleted.
3. **Live R6 Locomotion & Body-First Framing:** `core_engine.luau` drives R6 Motor6D actions (see manifest) + `move_to`; no frozen rigs; whole characters acting; no actor sunk into a floor/stage or floating; no partner or prop filling the lens.
4. **Engine guards (protected):** `WorldPivot`-locked `Engine.setScale`, `Engine.unclipCamera` before the floor clamp, scaled feet height in `pushOut`, counter-sign edge/overlap hiding, crowd placed on the real floor of its beat's set, fail-closed gates, UTF-8 subprocesses. Reset the camera (`_G.AIVidCore.resetCamera()`) after every take.

## 2. Owner-Only Rules
1. **The AI writes ONLY `stories/<ID>_<slug>/story.yaml`** (+ `ledger/verification/` receipts). Never hand-write `narration.txt`, `beats.json`, `scenes_<ID>.luau` or `PUBLISH.md` (compiled).
2. **Never edit or delete** `CORE.md`, `config.yaml`, `core_engine.luau`, `pipeline/*.py`, `assets/`, `templates/`, the ledger, skills, or move/delete files, unless the owner directs it. List everything before deleting.
3. **Recording:** NEVER record until the owner says `"record"`. Always record via `pipeline/record_take.py` (cursor locked at `900, 12`).
4. **Publishing:** NEVER upload until the owner says `"approve"`. Never spend Gemini quota (`story_gen.py --auto`, `vision_qa.py`, `daemon.py --mode produce|full`) unless the owner asks.

## 3. AI-Crafted Workflow (only publishing is automated)
1. **Idea + originality:** next ID = highest ID in `stories/` and the ledger + 1. Web-verify every AI-written premise (skill `verify-originality`; same rule OR same twist = REJECT). Exception: `story_gen.py --auto` Gemini stories skip the web check (owner Googles the premise).
2. **Author** `story.yaml` (section 5), then compile, Gate 1, voice, sync, Gate 2 (0 AI tokens):
   ```powershell
   python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml
   python pipeline/qa_gate.py --story-dir stories/<ID>_<slug> --stage pre
   python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>
   python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml --sync-words
   python pipeline/qa_gate.py --story-dir stories/<ID>_<slug> --stage audio
   ```
3. **Studio:** load `core_engine.luau` + the story's set scripts + `scenes_<ID>.luau`, `_G["Story<ID>"].setup()`, check the lineup in the viewport. After the owner says `"record"`: capture, then `python pipeline/run_take.py --story-dir stories/<ID>_<slug> --final` (deletes raw/trimmed/ov_*.png; `--keep-raw` keeps the capture, `--zip` writes an audit zip) and Gate 3 (`--stage render --video <dir>/<ID>_FINAL.mp4`).
4. **Self-verify:** the AI inspects every tile of `rec/qa_beats.png` and `thumbnail.jpg` (0 Gemini Vision calls while iterating), fixes any flaw (framing, blocked lens, sunk/floating actors, pacing, clipped text, flat beat), re-records/re-renders, re-verifies until polished.
5. **Present** `<ID>_FINAL.mp4`. Only when the owner says `"approve"`: `python pipeline/upload_queue.py --approve <ID>` (marks APPROVED and uploads now: thumbnail, tags, playlist, next 19:00 IST slot, post-upload MP4 cleanup). Scheduled tasks (`setup_v6_scheduler.ps1`): `AIVid_Publish` (daily retry of approved uploads) + `AIVid_AnalyticsSync` (`daemon.py --mode sync`).

## 4. Gates (fail closed)
- **Gate 1 `--stage pre`:** manifest values only; story shape (section 5); overlays (max 5, text rules); `counter` (max 18 chars, A-Z 0-9 : = + - / ! ? . , # % ' & only); `scale` 0.2-2.5; `face_mid` known face; required clarity fields; channel sameness; title Jaccard (`qa.max_premise_jaccard` 0.42) and full-script blended unigram+bigram Jaccard vs every story (`qa.max_script_jaccard` 0.42).
- **Gate 2 `--stage audio`:** 35-58.5 s, no silence > 1.5 s, ASR WER <= 10%.
- **Gate 3 `--stage render`:** 1080x1920, 30 fps, no black/freeze segments, ~-14 LUFS.
- **Gate 4 vision** (Gemini) runs only when the owner asks; otherwise the AI's own visual check replaces it.

## 5. V6 Story & Format Rules
**Story** (enforced by Gate 1 / `story_gen.kid_simple_errors`; details + examples in skill `story-craft`)
- Title `In This World, <rule>` or `In This Town, <rule>`, max 60 chars, no hashtags/emojis.
- 20-24 beats (aim 22, `dur: 2.4`, re-synced to the voice); spoken lines 2-9 words, 4th-grade spoken English; narrator <= 30% of beats; `rule:` one line, max 14 words; no adult/essay words.
- Required: `title, description, set, bgm_mood, lighting, engine, rule_type, opening_variant, ending_type, rule, visible_proof, personal_stake, motivated_choice, rule_payoff, cta, cast, beats`.
- Beats 1-3 = world-rule montage (the rule happening to others, readable on mute); the hero's stake starts at beat 4. 3 escalating PUBLIC reactions before the twist.
- One ending: a visible callback or karma flip, closed by the spoken dilemma question (`cta:`). No `binary_cta` card. Earned meaning shown through the twist or the cost, never a stated moral.
- Kid-safe: no romance or kissing; creepy, not gory. Standalone, no Part 1/2 splits.
- **Engines** (`engine:`): `ironic_reframe`, `social_karma`, `clever_loophole`, `moral_dilemma`.
- **Capability contract:** the rule must happen on screen with engine fields only: shrink/grow = `scale:` (persists), vanish = `invisible: true`, rule numbers = `counter:`, mid-beat face change = `face_mid:` (4-6 per story), props = prop kits or max 2 small static custom `props:` (`attach:` / `hide:` / per-beat `prop:` cues). Rules that say shrink/grow/vanish without the field fail Gate 1.
- **Overlays:** 1-2 per story (max 5): `speedlines` (shock), `crimson_vignette` (danger), `sweat`, `hearts`, `flash_red_blue`, `bubble` + text 2-16 chars, `phone_card` + "TITLE | message" 4-64 chars. Never stack them.

**Captions, voice, edit**
- Captions: `MarginV` 560 (per-story `caption_margin_v` override), 1-2 words per card, >= 0.55 s hold, `*word*` highlight in >= 60% of spoken beats.
- Voice (`config.yaml` `voice:`): Kokoro `kokoro_speed` 0.98, speakers 0.96-1.00, `beat_pause_sec` 0.25, `final_beat_hold_sec` 0.8 (~195-205 WPM, ~44-50 s). Fix length by cutting lines, never by raising speed.
- Edit (`finish_video.py`): punch-zooms on impact beats (`bgm_duck` / `bgm_climax` / shocked or scared face), overlays, thin gold top progress bar (`video.progress_bar`), captions on top; music bed from `bgm_mood` (`mystery` = `roblox-story-bg.mp3`); final export preset medium, CRF 19, 4 threads.

**Analytics** (ledger, via `daemon.py --mode sync`): YouTube URL, Final Duration, Stayed-to-Watch %, APV %, First Drop (s).

## Studio Hygiene (Owner Rule)
- After every story, move its sets, casts, props and FX out of `Workspace` into `ServerStorage._Old/<ID>`; never delete them. Before a new story, `Workspace` holds only Camera, Terrain, Baseplate, SpawnLocation and the current story's folders.
- `Workspace.Script` (auto-loader) must load the current engine version only.

## Skills are owner-only
- AI agents must NEVER edit, rewrite, shorten or delete anything in `.claude/skills`, `.agents/skills` or `.agent/skills` unless the owner directs it. Propose changes instead.
- Skill files are read-only on disk. `.claude/skills` is the source; after an owner-directed edit run `.claude/sync_skills.ps1` (copies to Codex/Antigravity and relocks).

## Reference: built-in set props (from `engines/roblox/sets/set_*.luau`)
- `cozy_room`: Floor, Rug, Ceiling, 4 walls, window (WinFrame/WinGlass), desk, Monitor/Screen, bed (BedFrame, Mattress, Pillow), Bookshelf, Door, CeilingLamp.
- `school_yard`: Courtyard, SchoolMain + wings, BackFence, windows, EntryDoor, EntryCanopy, SchoolSign, EntryWalk, PlayCourt + basket, Planter, Bench, SchoolShowStage, TryoutSign, CoachTable.
- `street_day`: Road, sidewalks, Crosswalk, storefronts (Bldg, Door, Awning), LampPost, BusStopSign/BusStopBoard, Bench.
- `anime_arena`: ArenaFloor, CenterPad, neon trims, 8 Pillars + Braziers, 4 walls, 3 banners.
- `auditorium`, `classroom`, `school_hallway`, `living_room`, `street`, `street_002_winter`: see each set's `props` list in `assets/manifest.json` (e.g. auditorium: StageDeck, Podium, Mic, StageRamp, StageLight, AudSeat, DebateBanner, Backdrop).
- **SFX:** only names in `assets/manifest.json` `active_sfx` (real wavs in `assets/sfx/`).
