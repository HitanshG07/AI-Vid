# AI-Vid V5.3 — Lean Production Rulebook (Working Visuals + Fast Auto-Sync Loop)

**Single source of truth.** Read ONLY `CORE.md` + `config.yaml` + `ledger/STORY_LEDGER.md` (and the 1 matching template in `templates/formats/`). Never scan `docs/_archive/` or old story folders.

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
   - Check next contiguous Story ID in `ledger/STORY_LEDGER.md` (`004`+). Never repeat a rule, twist, or core meaning.
   - **Web Originality Gate** (mandatory for all formats except `beat_drop`): run a quick web search (YouTube, TikTok, Reddit) on the world rule + twist and save a concise `PASS` receipt in `ledger/verification/<ID>.md`.
   - Write `stories/<ID>_<slug>/story.yaml` (standalone 30–58s or 1:45–2:30 arc, 5th-grade spoken English, ≤2.2s beats, `set:`, `action:`, `move_to:`).
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

## 4. Channel Playlists (`templates/formats/`)
| Format | Template | Playlist | Length | Voice |
|---|---|---|---|---|
| `story` | `01_story.yaml` | In This World Stories | 50–58s or 2:00–2:30 | Yes |
| `anime_fight` | `02_anime_fight.yaml` | Roblox Anime Fights | 35–55s | Yes |
| `spot_the_lie` | `03_spot_the_lie.yaml` | Spot The Lie Mysteries | 40–55s | Yes |
| `beat_drop` | `04_beat_drop.yaml` | Beat-Drop Edits | 15–28s | No (YT Audio) |
| `psychology` | `05_psychology.yaml` | Roblox Mind Rules | 30–45s | Yes |
| `thought_sim` | `06_thought_sim.yaml` | What If Simulations | 45–60s | Yes |

## Studio Hygiene (Owner Rule, 2026-11-21)
- **After every story is completed** (ledger status `Produced`), move that story's sets, casts, props and FX out of `Workspace` into `ServerStorage._Old/<ID>` so the origin stays clean for the next story and visual QA. Never delete them. Before a new story, `Workspace` should hold only Camera, Terrain, Baseplate, SpawnLocation and the current story's folders.
- `Workspace.Script` (auto-loader) must load the current engine version only.
