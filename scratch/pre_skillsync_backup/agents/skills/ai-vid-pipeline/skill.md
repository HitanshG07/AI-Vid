---
name: ai-vid-pipeline
description: End-to-end, low-quota Roblox Studio Shorts production pipeline for StudVerse Tales (AI-Vid V5.2). Enforces real R6 catalog avatars, textured enclosed Roblox sets, web originality verification, 185-195 WPM pacing, safe-zone captions, and 6 channel playlist formats across Claude, Codex, Antigravity, and Cursor.
---

# AI-Vid V5.2 — Universal Pipeline Skill

Use this skill whenever creating, updating, or QA-checking a Roblox Short in `C:\AI-Vid` (`@studversetales`).

## Token-Saving Startup Rule
Read ONLY `config.yaml` and `ledger/STORY_LEDGER.md` (plus the single matching template in `templates/formats/`). **Do NOT read `docs/_archive/`, old story folders, or `core_engine.luau`** unless debugging a specific runtime error.

## Step 0 — Interactive Kickoff (When User Starts a New Session)
1. Check the next contiguous Story ID in `ledger/STORY_LEDGER.md` (e.g., `004`).
2. Ask the user what we are making today by listing the 6 playlist formats (`story`, `anime_fight`, `spot_the_lie`, `beat_drop`, `psychology`, `thought_sim`) and asking whether they already have a concept or want 3 fresh, original pitches.

## Step 1 — Web Originality Gate & `story.yaml` (Never Skip)
1. **No repeats:** Confirm the world rule, twist, and core meaning are not in `ledger/STORY_LEDGER.md`.
2. **Web authenticity check (mandatory for all formats except `beat_drop`):** Run a quick web search (YouTube, TikTok, Reddit) on the core rule + twist to confirm the story does not already exist online. Save a concise `PASS` receipt in `ledger/verification/<ID>.md` using `templates/verification_template.md`. If a duplicate exists, pitch a fresh twist.
3. **Write ONLY `stories/<ID>_<slug>/story.yaml` (~3–5 KB):**
   - **Standalone by default:** Complete 30–58s or 1:45–2:30 arc (no Part 1/Part 2 splits unless a prior upload broke 50K views).
   - **5th-grade spoken English:** Short, natural sentences. Zero formal AI jargon (`permafrost`, `pneumatic`, `cryo-architect`, `resonance`).
   - **Retention rhythm:** Rule/power/clue visible in frame 1; conflict by 12–15s; **every beat ≤2.2s** with camera motion (`push_in`, `pull_out`, `orbit360`, `shake`); sharp twist or in-story CTA ending (no preachy moral lines).
   - **Gender-locked cast:** Every character declares `gender: boy | girl | man | woman`.
   - **Monetization safety:** 100% native Roblox Studio animation for `anime_fight` (never splice raw anime clips). Keep `beat_drop` ≤58s and attach trending audio via YouTube Shorts' official sound library.

## Step 2 — Local Compile, Voice & Pre-Flight Lint (0 AI Tokens)
Run these local commands in `C:\AI-Vid`:
```powershell
python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml
python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>
python pipeline/preflight_lint.py --story stories/<ID>_<slug>/story.yaml
```
- Skip `voice_subs.py` for `beat_drop` music-only shorts.
- `compile_story.py` auto-generates `narration.txt`, `beats.json`, `PUBLISH.md`, and `engines/roblox/scenes_<ID>.luau`. **Never hand-write 80 KB cutscene monoliths.**
- `voice_subs.py` targets **185–195 WPM**, tight silence compression (`0.14s -> 0.05s`), and `SafeCenterPop` (`MarginV = 560`) clear of Shorts' bottom UI.
- Fix any `preflight_lint.py` errors/warnings in `story.yaml` and re-run until `PREFLIGHT PASSED`.

## Step 3 — Roblox Studio Visual Standards (STRICT — NEVER Defy)
1. **Real R6 Catalog Avatars ONLY (NEVER primitive Part block statues, NEVER R15, NEVER `generate_avatar`, NEVER Blender):**
   - Build EVERY character (main cast AND crowd extras) via `Engine.buildRig()` in `engines/roblox/core_engine.luau` (`Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R6)`) or follow `engines/roblox/cast_001.luau`.
   - Use 0-Robux catalog Shirts, Pants, Hair, and Accessories via `AvatarEditorService:SearchCatalog`, season-matched to the set climate and gender-locked, with varied outfits (never clones).
   - Anchor **ONLY `HumanoidRootPart`**, set `m.PrimaryPart = m.HumanoidRootPart`, floor-snap by lowest `BasePart`, and disable floating nameplates (`DisplayDistanceType = None`, `HealthDisplayType = AlwaysOff`, `DisplayName = ""`).
   - Apply faces **ONLY** via `Engine.setFace(model, emotion)` using `assets/faces/classic_v1/ids.json` (`neutral`, `scared`, `shocked`, `grin`, `determined`, `proud`).
2. **Real Textured Roblox Sets & Full Horizon Enclosure (NEVER flat SmoothPlastic dioramas or empty green voids):**
   - Match the detail level of `engines/roblox/sets/street_002_winter.luau`: use real `Enum.Material` textures (`Brick`, `Cobblestone`, `WoodPlanks`, `Concrete`, `Grass`, `Fabric`), `ClockTime = 16.8` (or mood preset), Future lighting, and disable harsh `BloomEffect`/`SunRaysEffect` glare.
   - Insert free Creator Store trees, fences, lamps, benches, and background buildings via `search_asset` + `insert_asset`, and **delete ALL `LuaSourceContainer` scripts** after insert.
   - Enclose the full camera horizon so no empty baseplate void is ever visible. Add 8+ varied, nameplate-free R6 crowd extras on town/street/fair sets.
3. **Live Animation & Framing QA:**
   - Rigs play live R6 animations (`r.loco = nil` reset per frame; Motor6D local Z = pitch, local X = roll; travel direction matches `LookVector`).
   - Frame whole bodies acting (60% `push_in`, 25% `pull_out`, 15% impact zoom + 2.5° Dutch tilt); zero wall clipping or giant-head filler.
   - Run `screen_capture` on the set + cast lineup and confirm all visual standards pass before asking the owner to record.

## Step 4 — Record, Draft QA & Final Export (Owner-Gated)
- **NEVER record until the owner explicitly says `"record"`.**
- Always record via `pipeline/record_take.py` (locks cursor at `900, 12`), then run:
```powershell
python pipeline/run_take.py --story-dir stories/<ID>_<slug> --draft
# Inspect rec/qa_beats.png -> when every beat PASSES:
python pipeline/run_take.py --story-dir stories/<ID>_<slug> --final
```
- Reset Studio camera (`Engine.resetCamera()`) after every take and update `ledger/STORY_LEDGER.md` to `Produced`.

## Channel Format Reference (`templates/formats/`)
| Format | Template | Playlist | Target Length | Voice |
|---|---|---|---|---|
| `story` | `01_story.yaml` | In This World Stories | 50–58s or 2:00–2:30 | Yes |
| `anime_fight` | `02_anime_fight.yaml` | Roblox Anime Fights | 35–55s | Yes |
| `spot_the_lie` | `03_spot_the_lie.yaml` | Spot The Lie Mysteries | 40–55s | Yes |
| `beat_drop` | `04_beat_drop.yaml` | Beat-Drop Edits | 15–28s | No (YT Audio) |
| `psychology` | `05_psychology.yaml` | Roblox Mind Rules | 30–45s | Yes |
| `thought_sim` | `06_thought_sim.yaml` | What If Simulations | 45–60s | Yes |
