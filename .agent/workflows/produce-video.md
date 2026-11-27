---
description: Produce an AI-Vid V6.4 short for a story ID (craft, record on command, render, self-verify, present for approval)
---

Read `CORE.md` and `config.yaml` first, then follow `.agent/skills/produce-video/SKILL.md`. Record ONLY after the owner says "record" (cursor locked at 900,12 via record_take.py). Inspect `rec/qa_beats.png` + `thumbnail.jpg` yourself and fix until polished (0 Gemini Vision calls). Queue nothing until the owner says "approve" (`python pipeline/upload_queue.py --approve <ID>`).
