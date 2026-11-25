---
name: ai-vid-pipeline
description: "Master skill for making a new story and/or producing a video in AI-Vid V5.3 (StudVerse Tales). Use for 'new story', 'make a short', 'produce video <ID>'. Covers idea, web originality, story.yaml, compile/sync/lint, Studio preview, record, QA, thumbnail, ledger."
argument-hint: "[theme | format | <ID> to produce]"
---
# AI-Vid Pipeline (V5.3)

**Non-Claude AIs:** where this says "spawn an agent" (showrunner = high tier, verifier / render-qa = mid tier, researcher = low tier), do that step yourself on a model of that tier. Role files are in `.claude/agents/`.

Read ONLY `CORE.md` + `config.yaml` + `ledger/STORY_LEDGER.md` + the one matching `templates/formats/` template. Never read `docs/_archive/` or old story folders. Studio runs ONE job at a time.

## 1. Standards (never defy; details in CORE.md section 1)
- Real R6 catalog avatars only (no Part statues, no R15, no `generate_avatar`), built by `Engine.buildRig()`, gender-locked, season-matched, varied outfits. Faces only via `Engine.setFace(model, emotion)` (neutral, scared, shocked, grin, determined, proud).
- Textured, horizon-enclosed sets from `engines/roblox/sets/` via `set:`, plus 2-3 story props. Real `Enum.Material`; delete scripts from inserted models.
- Live locomotion: beat `action:` and `move_to:`, no frozen rigs, cuts every 1.2-2.2s, whole characters acting. No floating nameplates (engine disables them; verify in the lineup).
- Owner rules: NEVER record until the owner says "record". Record only via `pipeline/record_take.py` (cursor locked 900,12). Never edit `core_engine.luau`, `CORE.md`, `config.yaml`, `pipeline/*.py`, `assets/faces/` or skills without the owner. AI writes only `story.yaml` (+ a set script if the location is new) and `ledger/verification/` files; never hand-write narration, beats.json or PUBLISH.md.

## Phase A: Idea
- Check `ideas/IDEA_BANK.md` first and take a verified idea if it fits.
- Otherwise (showrunner, high tier) brainstorm 3-5 premises (rule, twist, meaning) that all differ from the last 5 ledger rows. Rotate freshness: vary world, hero, gender, season, set, format.
- Never repeat a rule, twist or core meaning from the ledger.

## Phase B: Originality (skill `verify-originality`)
- At least 5 web queries per premise (researcher, low tier, one call for all premises).
- Verifier (mid tier) judges against results + ledger: same rule OR same twist = REJECT.
- Log EVERY premise (PASS or REJECT) in `ledger/verification/ideas/<slug>.md` and the ledger "Verified ideas" table.
- ID = highest ID in the ledger Stories table + 1. Write the PASS receipt `ledger/verification/<ID>.md`. `beat_drop` is exempt.

## Phase C: Author
- Write only `stories/<ID>_<slug>/story.yaml` (3-5 KB) from the matching template: `cast:` (name/gender/default_face/pos), `set:`, optional `lighting:`, beats (face/cam/motion/action/move_to), 5th-grade spoken English, beats <= 2.2s, standalone arc.
- Self-check against CORE.md viral gates and the catchiness gates (active rule visible in frame 1, 3 planted clues, rule-of-3, rule-hack climax, action-echo ending, no moral lines; avg >= 8.5, none < 8).
- Verifier (mid tier) scores it; max 2 fix rounds.

## Phase D: Compile (0 AI tokens)
```powershell
python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml
python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>
python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml --sync-words
python pipeline/preflight_lint.py --story stories/<ID>_<slug>/story.yaml
```
- Skip voice_subs and --sync-words for `beat_drop`.
- Check WPM against `config.yaml`; lower `kokoro_speed` only with owner OK.
- Set ledger status `Scripted`.
- **STOP POINT:** if the owner asked only for a story, stop after preflight passes and report.

## Phase E: Produce
Precondition: preflight passed and `ledger/verification/<ID>.md` says PASS.
1. Studio hygiene: Workspace holds only Camera, Terrain, Baseplate, SpawnLocation and the current story.
2. Localhost HTTP is blocked: paste `engines/roblox/core_engine.luau` and the compiled `scenes_<ID>.luau` (plus the set script) into `execute_luau` / loadstring.
3. `screen_capture` lineup check: R6 catalog cast, horizon enclosure, no clipping, no nameplates, season-matched outfits.
4. Wait for the owner to say "record". Then `python pipeline/run_take.py --story-dir stories/<ID>_<slug> --draft`.
5. render-qa (mid tier) judges `rec/qa_beats.png` against CORE.md section 1 and `reference/design_bible/`; fix and re-draft until every beat passes, then `--final`.
6. Reset the camera (`Engine.resetCamera()`, roll 0, FOV 70) after every take.

### Retakes and export checks
- Studio-authored retake: require a FRESH instance of the edited ModuleScript in the same session (an already-required instance can replay old behavior). Use the exact runner verified in preview; remove temporary clones afterward.
- Give each retake its own raw and trimmed paths: the default runner reuses an existing `rec/trimmed.mp4`, so confirm draft and final consume the current take. For a custom live cut, check the draft against the runner's shot timings when generated beat metadata is stale.
- Every retake reloads a FRESH Studio playback module (re-paste/reload `scenes_<ID>.luau` + `core_engine`) so the recorder picks up scene edits.
- Each take gets its own files (e.g. `rec/take<N>_raw.mp4`, `rec/take<N>.mp4`); never overwrite an earlier take.
- Before replacing the final, verify the revised action in the actual recording, caption and audio timing, and that the ending shows the camera reset (no stuck/rolled last frame).
- Inspect frames before, during and after the revised action. Check the ending camera reset, that narration and captions share the same lead-in, and final dimensions, duration and audio before updating the ledger. Keep the last usable export until its replacement passes.

### Finish
- Thumbnail `thumbnail.jpg` (1080x1920, real story frame, 2-3 line teaser, no spoiler, Arial Black, white + one accent) referenced in PUBLISH.md. Music/voice/captions come from `config.yaml`.
- Ledger status `Produced`.
- Studio hygiene: move this story's sets, casts, props and FX from Workspace to `ServerStorage._Old/<ID>`; never delete. Workspace.Script must load the current engine only. `save_place` after builds.

### Upload prep (only when the owner asks for publish copy)
- Title built around a moment or choice specific to the story; keep "In This World" as the series hook while the rest sounds natural; caps, emoji and hashtags where they help the hook.
- Description is spoiler-free and leads with the character's dilemma or the weird rule and keeps the payoff for the video. Keep comma-separated tag suggestions separate from title hashtags.
- PUBLISH.md links the verified final video and the chosen cover (thumbnail). Verify current YouTube guidance on audience and AI disclosures and state your assumptions.
- Recording approval does NOT authorize publishing.
- Post-publish cleanup (only after ledger status Posted AND the owner asks): verify the published take; KEEP final video, selected cover, PUBLISH.md/metadata and rebuild inputs (story.yaml, narration, words.json, subs, voice, beats/scenes); send superseded recordings and temporary QA files to the Recycle Bin (not permanent delete); baseplate restoration and viewport check follow the Studio hygiene rule.

## Formats (CORE.md section 4)
| Format | Template | Playlist | Length | Voice |
|---|---|---|---|---|
| `story` | `01_story.yaml` | In This World Stories | 50-58s or 2:00-2:30 | Yes |
| `anime_fight` | `02_anime_fight.yaml` | Roblox Anime Fights | 35-55s | Yes |
| `spot_the_lie` | `03_spot_the_lie.yaml` | Spot The Lie Mysteries | 40-55s | Yes |
| `beat_drop` | `04_beat_drop.yaml` | Beat-Drop Edits | 15-28s | No (YT Audio) |
| `psychology` | `05_psychology.yaml` | Roblox Mind Rules | 30-45s | Yes |
| `thought_sim` | `06_thought_sim.yaml` | What If Simulations | 45-60s | Yes |
