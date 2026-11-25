---
name: ai-vid-pipeline
description: Produce and review AI-Vid Roblox Shorts using the V5.3 workflow.
---

Read `CORE.md` and `config.yaml` first. Never read `docs/_archive/` or old story folders. Follow `CORE.md` as the source of truth.

Check the ledger and next contiguous ID. Web-verify narrative premises and save a PASS receipt at `ledger/verification/<ID>.md`; beat_drop is exempt. Write `stories/<ID>_<slug>/story.yaml` from the matching format template and select a pre-built set. Follow CORE.md for visual standards and protected files.

Compile, run voice, compile again with `--sync-words`, then run preflight. Skip voice and word synchronization for beat_drop. Preview the set and cast in Studio and use screen_capture for visual QA.

Record only after the owner says "record". Run `run_take.py --draft`, inspect `rec/qa_beats.png`, then run `--final` if every beat passes. Update the ledger to Produced and follow CORE.md Studio hygiene, moving the completed story's objects to `ServerStorage._Old/<ID>` without deleting them.
