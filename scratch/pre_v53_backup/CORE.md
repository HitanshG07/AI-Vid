# AI-Vid V5.2 — Production Rulebook (Working-Standard Visuals + Low-Quota V5 Loop)

**Single source of truth.** Read ONLY `CORE.md` + `config.yaml` before starting a Short. Never scan `docs/_archive/` or old story folders unless debugging a rare edge case.

## 1. Non-Negotiable Visual & Studio Standards (From Working Package — NEVER Defy)
1. **Real R6 Catalog Avatars ONLY (NEVER primitive Part blocks/statues, NEVER R15, NEVER `generate_avatar`, NEVER Blender):**
   - Build EVERY character (main cast AND crowd extras) via `Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R6)` (built into `core_engine.luau`'s `Engine.buildRig()` — or follow `engines/roblox/cast_001.luau` / `cast_002.luau`).
   - Use 0-Robux community catalog Shirts, Pants, Hair, and Accessories via `AvatarEditorService:SearchCatalog` (gender-locked `boy|girl|man|woman`, season-matched to the set's climate, varied outfits so crowds are never clones).
   - Anchor **ONLY `HumanoidRootPart`** (never accessory handles, or hair detaches). Set `m.PrimaryPart = m.HumanoidRootPart`. Floor-snap by lowest `BasePart` child.
   - **Zero floating nameplates:** Always set `hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None`, `hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff`, and `hum.DisplayName = ""` on EVERY rig.
   - **Faces ONLY via `Engine.setFace(model, emotion)`** using `assets/faces/classic_v1/ids.json` (`neutral`, `scared`, `shocked`, `grin`, `determined`, `proud`). No head swapping, no Creator Store face decals.
2. **Real Textured Roblox Sets & Full Horizon Enclosure (NEVER flat SmoothPlastic dioramas or empty green baseplate voids):**
   - Match the architectural density of `engines/roblox/sets/street_002_winter.luau`: use real `Enum.Material` textures (`Brick`, `Cobblestone`, `WoodPlanks`, `Concrete`, `Grass`, `Fabric`), `ClockTime = 16.8` (or mood preset) with Future lighting, and control `BloomEffect`/`SunRaysEffect` glare so faces read clearly.
   - Insert free Creator Store models (trees, benches, lamps, fences, props, background buildings) via `search_asset` + `insert_asset` and **delete ALL `LuaSourceContainer` scripts** after insert.
   - Enclose the entire background horizon (buildings, fences, trees, hedges, streets) so no empty baseplate void is ever visible on camera. Populate town/fair/street sets with 8+ varied, nameplate-free R6 background extras.
3. **Live R6 Animation & Body-First Framing (Zero Frozen Rigs):**
   - Every on-stage rig plays live R6 `AnimationTrack`s (`idle` with randomized `TimePosition`, `walk`/`run` scaled to ground speed); reset `r.loco = nil` every frame before the beat runs so rigs never stay stuck walking.
   - Motor6D limb rule: local Z = pitch (forward/back swing), local X = roll. Ensure travel direction matches `LookVector` (no moonwalking). Gestures override 1 joint at a time via C0 for max 1 beat.
   - Frame **whole characters acting** (60% slow push-ins, 25% snap pull-outs, 15% impact snap-zooms with 2.5° Dutch tilt). Cut every **1.2–2.2s** (max 2.2s static hold). Never clip walls or fill frames with tilted giant heads.
   - **Mandatory Visual QA before recording:** Run `screen_capture` on set + cast lineup to verify real R6 catalog outfits, horizon enclosure, lighting, and zero clipping/nameplates before asking the owner to record. Reset camera (`roll = 0, FOV = 70`) after every take.

## 2. Token-Saving & Owner-Only Rules
1. **AI writes ONLY `stories/<ID>_<slug>/story.yaml` (~3–5 KB)** (plus custom set script in `engines/roblox/sets/` if a new location is needed). Never hand-write `narration.txt`, `beats.json`, `PUBLISH.md`, or 80 KB cutscene monoliths—`pipeline/compile_story.py` compiles them locally at 0 AI tokens.
2. **Never edit `core_engine.luau`, `CORE.md`, `config.yaml`, `pipeline/*.py`, or `assets/faces/`** unless explicitly directed by the owner.
3. **Mouse Lock & Recording (Owner Rule):** NEVER record until the owner says `"record"`. Always record via `pipeline/record_take.py` (locks cursor at `900, 12`).
4. **Model Tiering:** Use low-tier models for web originality checks, ledger appends, and running CLI scripts; mid/high-tier ONLY for writing `story.yaml` and custom set/camera fixes.

## 3. The 4-Step Fast Loop (~20–30 min per Short)
1. **Verify Originality & Author (`story.yaml`):**
   - Check `ledger/STORY_LEDGER.md` (next ID starts at `004`; never repeat a world rule, twist, or core meaning).
   - **Web Originality Gate:** For all narrative formats (`story`, `anime_fight`, `spot_the_lie`, `psychology`, `thought_sim`), run a quick web search (YouTube, TikTok, Reddit) on the world rule + twist to verify it does not already exist online, and save a concise `PASS` receipt in `ledger/verification/<ID>.md` (using `templates/verification_template.md`). (`beat_drop` music edits are exempt.)
   - Write `stories/<ID>_<slug>/story.yaml` from the matching template in `templates/formats/`.
2. **Compile, Voice & Pre-Flight Lint (0 AI tokens):**
   ```powershell
   python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml
   python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>
   python pipeline/preflight_lint.py --story stories/<ID>_<slug>/story.yaml
   ```
   *(Skip `voice_subs.py` for `beat_drop` music-only shorts. Fix any lint errors before touching Studio.)*
3. **Studio Set, R6 Cast & Visual QA:**
   - Build/load the textured Roblox set + real R6 catalog cast (via `Engine.buildRig()` or `cast_<ID>.luau`), load `core_engine.luau` + compiled `scenes_<ID>.luau`, and run `screen_capture` visual QA.
4. **Record, Auto-QA & Final Export (only after owner says `"record"`):**
   ```powershell
   python pipeline/run_take.py --story-dir stories/<ID>_<slug> --draft
   # Inspect rec/qa_beats.png -> if every beat PASSES:
   python pipeline/run_take.py --story-dir stories/<ID>_<slug> --final
   ```
   Then update `ledger/STORY_LEDGER.md` to `Produced`.

## 4. Viral & Monetization Gates (Enforced by `preflight_lint.py`)
- **Web Originality:** `ledger/verification/<ID>.md` must exist with `PASS` for narrative formats.
- **Standalone by Default:** Complete 30–58s or 1:45–2:30 arcs (no Part 1/2 splits unless a video already broke 50K views).
- **Hook & Pacing:** Rule/power/clue visible in frame 1; conflict by 12–15s; 1.2–2.2s cuts; 5th-grade spoken English (zero formal AI jargon); **185–195 WPM**; captions in `SafeCenterPop` (`MarginV = 560`) clear of Shorts bottom UI.
- **Monetization Safety:** 100% native Roblox Studio animation for `anime_fight` (never splice raw anime clips). Keep `beat_drop` ≤58s and attach trending audio via YouTube Shorts' official sound library.

## 5. Channel Playlists (`templates/formats/`)
| Format | Playlist | Length | Voice | Core Hook |
|---|---|---|---|---|
| `story` | In This World Stories | 50–58s or 2:00–2:30 | Yes | Active rule + 15s conflict + shock twist/CTA |
| `anime_fight` | Roblox Anime Fights | 35–55s | Yes | Underdog awakening + impact frames + aura clash |
| `spot_the_lie` | Spot The Lie Mysteries | 40–55s | Yes | Hidden visual clue in frame 1 (130%+ rewatch loop) |
| `beat_drop` | Beat-Drop Edits | 15–28s | No (YT Audio) | Setup → bass-drop lighting flip + synced emote |
| `psychology` | Roblox Mind Rules | 30–45s | Yes | Relatable life/psychology rule via 3D physical metaphor |
| `thought_sim` | What If Simulations | 45–60s | Yes | Real-life physics/survival scenario + comment debate |
