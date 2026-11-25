---
name: produce-video
description: Turn a compiled story.yaml into a final 1080x1920 short (voice, subs, Studio record, auto-QA, export) with the V5.2 one-command loop. Use with a story ID.
argument-hint: "<ID>"
---
> Non-Claude AIs: where this says "spawn <agent> (model)", do that step yourself using a model of that tier (low=cheap/flash, mid=standard, high=best). Agent role files are in `.claude/agents/`.

# Produce Video (V5.2)
Read ONLY `CORE.md` + `config.yaml`. Precondition: `stories/<ID>_*/story.yaml` exists, `ledger/verification/<ID>.md` contains PASS (lint enforces it, except `beat_drop`), preflight passed. Studio work is ONE job at a time.
1. Compile + voice + sync + lint (0 tokens):
   `python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml`
   `python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>` (skip for `beat_drop`)
   `python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml --sync-words` (skip for `beat_drop`; locks beats to words.json)
   `python pipeline/preflight_lint.py --story stories/<ID>_<slug>/story.yaml`
2. Studio preview: paste `engines/roblox/core_engine.luau` then the compiled `scenes_<ID>.luau` via `execute_luau` (Studio MCP blocks localhost HTTP; use a ServerStorage StringValue + `loadstring` for big files). Never edit core_engine.luau. Check cast gender-lock and lighting, and run `screen_capture` on the set + cast lineup (real R6 catalog outfits, horizon enclosure, no clipping, no nameplates) before asking the owner to record. Use `save_place` after builds.
3. **Record only after the user says "record".** Always via `pipeline/record_take.py` (cursor locked at 900,12, never moved). Reset the Studio camera (roll 0, FOV 70) after every take.
   `python pipeline/run_take.py --story-dir stories/<ID>_<slug> --draft`
4. Spawn `render-qa` (sonnet) on `rec/qa_beats.png`; fix and re-draft until every beat passes, then:
   `python pipeline/run_take.py --story-dir stories/<ID>_<slug> --final`
5. Thumbnail `thumbnail.jpg` (1080x1920, real frame + 2-3 line teaser, no spoiler), referenced in PUBLISH.md. Set ledger status `Produced`.
6. **Studio hygiene (owner rule):** move this story's sets, casts, props and FX from `Workspace` into `ServerStorage._Old/<ID>` (never delete), so the next story starts on a clean origin.
Music, voice and caption settings come from `config.yaml` (never static/noise beds).
