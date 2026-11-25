---
name: new-story
description: Create a brand-new, web-verified Roblox short as a compact story.yaml (V5.2 lean workflow). Use when the user asks for a new story or video idea.
argument-hint: "[optional theme, format or count]"
---
> Non-Claude AIs: where this says "spawn <agent> (model)", do that step yourself using a model of that tier (low=cheap/flash, mid=standard, high=best). Agent role files are in `.claude/agents/`.

# New Story (V5.2)
Read ONLY `CORE.md` + `config.yaml`. Never scan old stories or `docs/_archive/`.
1. If `ideas/IDEA_BANK.md` has an unused PASS premise and the user wants no new ideas, offer it.
2. Spawn `showrunner` (opus): 3-5 premises (slug, format from `templates/formats/`, rule, twist, meaning), each differing from the last 5 ledger rows.
3. Run `verify-originality` on them (low + mid tier). Pick the strongest PASS; next ID = highest ledger Stories ID + 1 (next is 004); move its ledger row and evidence file.
3b. Web-verify (except `beat_drop`): save a `PASS` receipt to `ledger/verification/<ID>.md` from `templates/verification_template.md`. `preflight_lint.py` fails without it.
4. Spawn `showrunner` (opus) to write ONLY `stories/<ID>_<slug>/story.yaml` from the matching `templates/formats/*.yaml` (plus a set script in `engines/roblox/sets/` only if a new location is needed). Never hand-write narration.txt, beats.json, PUBLISH.md or big Luau.
5. Compile locally (0 tokens), order: compile -> voice -> sync -> lint:
   `python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml`
   `python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>` then `python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml --sync-words` (skip both for `beat_drop`)
   `python pipeline/preflight_lint.py --story stories/<ID>_<slug>/story.yaml` (fix flags, rerun).
6. Spawn `verifier` (sonnet) to check the CORE.md viral gates (standalone, 0-2s hook, max 2.2s/shot, 5th-grade English, gender on every cast entry). Fix and repeat max 2 times.
7. Set ledger status `Scripted`. Report title, hook, folder. Next: `/produce-video <ID>`.

Pick `set:` (street_day, school_yard, anime_arena, cozy_room) in story.yaml; per-beat `action:` and `move_to:` drive live locomotion.

Visual standards (CORE.md section 1) apply: real R6 catalog avatars, textured enclosed sets, live animation, no nameplates. The cast is built by `core_engine.luau` from the yaml cast (`gender` boy|girl|man|woman, matching outfits).
