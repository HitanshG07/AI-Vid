---
name: produce-video
description: Produce an AI-Vid video for a specified story ID.
---

Read `CORE.md` and `config.yaml` first. Never read `docs/_archive/` or old story folders. Follow `CORE.md` as the source of truth.

Follow CORE.md's V5.3 sequence: compile, voice, compile with `--sync-words`, preflight and Studio preview. Skip voice and word synchronization for beat_drop. Narrative formats need a web-originality PASS receipt before preflight. Use screen_capture on the set and cast lineup for visual QA.

Record only after the owner says "record". Run `run_take.py --draft`, inspect `rec/qa_beats.png`, then use `--final` only if every beat passes. Update the ledger to Produced, reset the camera after each take and move completed story objects to `ServerStorage._Old/<ID>` as directed in CORE.md.
