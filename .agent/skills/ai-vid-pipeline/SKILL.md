---
name: ai-vid-pipeline
description: "Master skill for making a new story and/or producing a video in AI-Vid V6.4 Lean Craft Mode (StudVerse Tales). Use for 'new story', 'make a short', 'produce video <ID>', 'approve <ID>'. Covers idea, originality, story.yaml, Gates 1-3, voice, Studio record, render, self-verification, approval and publishing."
argument-hint: "[theme | <ID> to produce | approve <ID>]"
---
# AI-Vid Pipeline (V6.4 Lean Craft Mode)

**Non-Claude AIs:** where this says "spawn an agent" (showrunner = high tier, verifier / render-qa = mid tier, researcher = low tier), do that step yourself on a model of that tier. Role files are in `.claude/agents/`.

Read `CORE.md` + `config.yaml` + `assets/manifest.json` (the only allowed sets, spots, cameras, actions, faces, fx, prop kits, overlays) + `ledger/STORY_LEDGER.md`. Never read `docs/_archive/` or old story folders. Studio runs ONE job at a time. CORE.md (V6.4) is the rulebook; this skill is the how-to.

## 0. Workflow: AI-crafted, only publishing automated
1. The AI writes the story, runs Gate 1, voice and Gate 2, records in Studio (only after the owner says "record"), renders, then **visually inspects `rec/qa_beats.png` and `thumbnail.jpg` itself**.
2. Any flaw (bad framing, actor blocking the lens, sunk/floating actors, awkward pacing, clipped text, flat beat) -> fix it and re-verify on your own. **0 Gemini Vision API calls while iterating.** Repeat until genuinely polished.
3. Present `<ID>_FINAL.mp4` to the owner. Nothing is queued until the owner says **approve**.
4. Approve = `python pipeline/upload_queue.py --approve <ID>`: marks APPROVED and uploads right away (thumbnail, tags, playlist, next 19:00 IST slot, post-upload MP4 cleanup). The scheduled `AIVid_Publish` task (from `setup_v6_scheduler.ps1`) retries approved episodes; `AIVid_AnalyticsSync` runs `daemon.py --mode sync`.
- Never run `daemon.py --mode produce|full`, `vision_qa.py` or `story_gen.py --auto` (Gemini quota) unless the owner asks. Never upload without "approve".

## 1. Standards (never defy)
- Real R6 catalog avatars only, built by `Engine.buildRig()`, gender-locked (`gender:` on every cast entry), season-matched, varied outfits. Faces only via `Engine.setFace` (neutral, scared, shocked, grin, determined, proud). No nameplates.
- Record only via `pipeline/record_take.py` (cursor locked at 900,12). Engine guards stay: `WorldPivot`-locked `setScale`, `unclipCamera`, floor clamps, fail-closed gates, UTF-8 subprocesses.
- Owner-only: `core_engine.luau`, `CORE.md`, `config.yaml`, `pipeline/*.py`, `assets/`, skills and the ledger change only when the owner directs it. The AI normally writes only `story.yaml` (+ `ledger/verification/` receipts); never hand-write narration, beats.json, scenes or PUBLISH.md.

## Phase A: Idea
- Check `ideas/IDEA_BANK.md` first (verified premises; titles there may predate the V6 "In This World/Town" format, so retitle). Otherwise brainstorm 3 premises (one engine each: ironic_reframe, social_karma, clever_loophole, moral_dilemma) that differ from the last 5 ledger rows; vary world, hero, gender, set. If the owner asked you to choose, pick yourself; otherwise STOP for the owner's pick.
- The rule must be stageable with the engine (see `story-craft` capability contract): shrinking/growing = `scale:`, vanishing = `invisible:`, rule numbers = `counter:`.
- Apply skill `story-craft` to every pitch.

## Phase B: Originality (skill `verify-originality`)
- Every AI-written premise is web-verified (>= 5 queries, same rule OR same twist = REJECT) and logged in `ledger/verification/ideas/<slug>.md`.
- Gate 1 also blocks recycled scripts automatically (blended unigram+bigram Jaccard vs every story, `qa.max_script_jaccard` 0.42) and similar titles (`max_premise_jaccard`).
- Exception (owner-approved): `story_gen.py --auto` Gemini stories skip the web check; tell the owner to Google the premise before producing.

## Phase C: Author `stories/<ID>_<slug>/story.yaml`
- ID = highest ID in `stories/` and the ledger + 1. Copy the shape of the newest `stories/*/story.yaml`.
- Required top-level fields: `title, description, set, bgm_mood, lighting, engine, rule_type, opening_variant, ending_type, rule, visible_proof, personal_stake, motivated_choice, rule_payoff, cta, cast, beats`.
- Shape (enforced by Gate 1 / `kid_simple_errors`): title `In This World, ...` / `In This Town, ...` (max 60 chars); 20-24 beats (aim 22, `dur: 2.4`); spoken lines 2-9 words; narrator <= 30% of beats; rule one line (max 14 words); no adult/essay words; no emojis.
- Beats 1-3 = world-rule montage (the rule happening to others); stake starts at beat 4. Final beat ends on the spoken dilemma question (no `binary_cta` card).
- 1-2 overlays per story; speedlines on the shock beat, crimson_vignette on danger. Never stack overlays.

## Phase D: Compile, voice, Gates 1-2 (0 AI tokens)
```powershell
python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml
python pipeline/qa_gate.py --story-dir stories/<ID>_<slug> --stage pre --no-db
python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>
python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml --sync-words
python pipeline/qa_gate.py --story-dir stories/<ID>_<slug> --stage audio --no-db
```
- Voice: Kokoro `kokoro_speed` 0.98 + per-speaker 0.96-1.00, 0.25 s `beat_pause_sec` between beats, 0.8 s `final_beat_hold_sec` (~195-205 WPM, ~44-50 s). Gate 2: 35-58.5 s, no silence > 1.5 s, ASR WER <= 10%.
- Drop `--no-db` to record the status in `ledger/pipeline.db` (GATE1_PASS -> AUDIO_PASS).
- **STOP POINT:** if the owner asked only for a story, stop here and report.

## Phase E: Record, render, self-verify
1. Studio hygiene: Workspace holds only Camera, Terrain, Baseplate, SpawnLocation and the current story; old stories go to `ServerStorage._Old/<ID>` (never delete).
2. Load into Studio via MCP `execute_luau`: `engines/roblox/core_engine.luau`, each set script from `assets/manifest.json`, then `scenes_<ID>.luau`; `_G["Story<ID>"].setup()`. Check the lineup in the viewport (R6 cast, no clipping, no sunk/floating rigs, no nameplates).
3. Wait for the owner to say "record". Then record via the capture path (`daemon.trigger_studio_capture` / `record_take.py`) and run `python pipeline/run_take.py --story-dir stories/<ID>_<slug> --final` (deletes raw/trimmed/ov_*.png afterwards; `--keep-raw` keeps the capture for re-renders, `--zip` writes an audit zip).
4. Gate 3: `python pipeline/qa_gate.py --story-dir <dir> --stage render --video <dir>/<ID>_FINAL.mp4 --no-db` (1080x1920, 30 fps, no black/freeze, -14 LUFS).
5. Self-verify every tile of `rec/qa_beats.png` + `thumbnail.jpg` (pull extra frames with ffmpeg where a tile is unclear). Fix -> re-record/re-render -> re-verify. Reset the camera (`_G.AIVidCore.resetCamera()`) after every take.
6. Present the FINAL to the owner; wait for "approve" (section 0).

### Retakes
- Every retake reloads a FRESH engine + set + scenes so scene edits are picked up; a retake must never reuse a stale `rec/trimmed.mp4` (run_take always re-trims).
- Keep the last good FINAL until its replacement passes your review.

## Finish
- Thumbnail `thumbnail.jpg` is made by `run_take.py --final` (`make_thumbnail.py`, `thumb_beat:` in story.yaml picks the frame).
- After publishing, `upload_queue.py` purges raw captures; quarantine MP4s expire after 14 days.
- Analytics columns in the ledger come from `daemon.py --mode sync`.
