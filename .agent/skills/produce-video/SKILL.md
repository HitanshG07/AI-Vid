---
name: produce-video
description: Produce an AI-Vid video for a specified story ID using the V6.4 AI-Crafted workflow (the AI crafts and visually verifies; only publishing is automated).
argument-hint: "<ID>"
---
Follow `.claude/skills/ai-vid-pipeline/SKILL.md` section 0 and phases D-E for the given ID:

1. **Craft:** Gate 1 `python pipeline/qa_gate.py --story-dir <dir> --stage pre` -> `python pipeline/voice_subs.py --story-dir <dir>` + `python pipeline/compile_story.py --story <dir>/story.yaml --sync-words` -> Gate 2 `--stage audio`.
2. **Record** in Studio only after the owner says "record"; then `python pipeline/run_take.py --story-dir <dir> --final` (deletes raw/trimmed/ov_*.png; `--keep-raw` keeps the capture, `--zip` writes an audit zip). Gate 3 `--stage render`.
3. **Verify yourself:** look at every tile of `rec/qa_beats.png` and at `thumbnail.jpg`. Any flaw (bad framing, actor blocking the lens, sunk/floating actors, awkward pacing, clipped text, flat beat) -> fix, re-record or re-render, re-verify. 0 Gemini Vision API calls while iterating.
4. **Present** `<ID>_FINAL.mp4` to the owner. Do NOT queue it.
5. **Approve:** only when the owner says "approve", run `python pipeline/upload_queue.py --approve <ID>`: marks APPROVED and uploads right away (thumbnail, tags, playlist, next 19:00 IST slot, post-upload MP4 cleanup).

Never run `daemon.py --mode produce|full` or `vision_qa.py` unless the owner explicitly asks.
