Read `CORE.md` and `config.yaml` before doing any work. Never read `docs/_archive/` or old story folders.

## Default workflow: AI-Crafted (V6.4 Lean Craft Mode)
Only publishing is automated. When the owner asks for a new Short:
1. Claude writes the story, runs Gate 1 (`qa_gate.py --stage pre`), voice (`voice_subs.py` + `compile_story.py --sync-words`) and Gate 2 (`--stage audio`), records in Studio (only when the owner says record), renders with `run_take.py --final`, then visually inspects `rec/qa_beats.png` and `thumbnail.jpg` itself.
2. Any flaw (bad framing, awkward pacing, clipped text, flat beat) -> Claude fixes it and re-verifies on its own, with 0 Gemini Vision calls while iterating, until it looks genuinely polished.
3. Claude presents `<ID>_FINAL.mp4` for review. Nothing enters the upload queue until the owner says **approve**, which runs `python pipeline/upload_queue.py --approve <ID>`: it marks the episode APPROVED and uploads it right away (thumbnail, tags, playlist, next 19:00 IST slot, MP4 cleanup); the daily `AIVid_Publish` task retries anything approved that did not upload.
Never run `daemon.py --mode produce|full` or `vision_qa.py` unless the owner asks.
