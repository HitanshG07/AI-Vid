---
name: produce-video
description: Produce an AI-Vid video for a specified story ID.
---

Read `CORE.md` and `config.yaml` first. Never read `docs/_archive/` or old story folders. Follow `CORE.md` as the source of truth.

Follow CORE.md's V5.3 sequence: compile, voice, compile with `--sync-words`, preflight and Studio preview. Skip voice and word synchronization for beat_drop. Narrative formats need a web-originality PASS receipt before preflight. Use screen_capture on the set and cast lineup for visual QA.

Record only after the owner says "record". Run `run_take.py --draft`, inspect `rec/qa_beats.png`, then use `--final` only if every beat passes. Update the ledger to Produced, reset the camera after each take and move completed story objects to `ServerStorage._Old/<ID>` as directed in CORE.md.

### Retakes and export checks

For a Studio-authored retake, require a fresh instance of the edited ModuleScript in the same Studio session. Requiring an instance already loaded can return the old playback even after its Source changes. Use the exact runner verified in the preview for the take and clean up any temporary clone afterward.

Give each retake its own raw and trimmed paths. The default runner reuses an existing `rec/trimmed.mp4`, so check that the draft and final actually consume the current take. For a custom live cut, verify the draft against the current runner's shot timings when generated beat metadata is stale. Inspect captured frames before, during, and after the revised action. Check the ending for a camera reset, confirm the narration and captions use the same lead-in, and verify final dimensions, duration, and audio before updating the ledger. Keep the last usable export until its replacement passes.

### Upload prep

When the owner asks for publish copy, make the title about one story-specific stake. Use “In This World” when it fits the series or the owner requests it, and use caps, emoji, and hashtags where they help the hook. Lead the description with the character's dilemma or the weird rule and save the payoff for the video. Keep comma-separated tag suggestions separate from title hashtags. Point to the verified final video and the selected cover. Verify current YouTube guidance for audience and AI disclosures and state the assumptions behind any suggested setting. Recording approval does not authorize publishing.
