---
name: new-story
description: Create a new AI-Vid Roblox short (V6.4) from a theme or format.
argument-hint: "[theme | format]"
---
This is an alias. Follow `.claude/skills/ai-vid-pipeline/SKILL.md` phases A-D (idea, originality, author story.yaml, compile + Gate 1 + voice + Gate 2) and stop at the Phase D STOP POINT unless the owner also asked to produce it.
Batch alternative (Gemini quota, owner must ask): `python pipeline/story_gen.py --auto N`. Inbox alternative: drop `<name>.yaml` + `<name>.judge.json` (writer_model, judge_model that differ, `pass: true`) into `stories/_inbox/`, then `python pipeline/story_gen.py --ingest`.
