# AI-Vid: Original Roblox Story Shorts, AI-automated

**Rules for every AI:** [AGENTS.md](AGENTS.md). **Ledger:** [ledger/STORY_LEDGER.md](ledger/STORY_LEDGER.md)

## Quickstart (full guide for humans and AIs: [docs/SETUP_GUIDE.md](docs/SETUP_GUIDE.md))
1. One-time: `powershell -ExecutionPolicy Bypass -File setup.ps1`
2. New story (Claude Code): `/new-story` (brainstorm, web-verify, script, engagement score)
3. Make the video: `/produce-video <ID>`
4. Other AIs (Antigravity, Codex, Gemini, Cursor): "Read docs/AI_ADAPTERS.md, set yourself up, then run new-story."
5. Weekly: ask the researcher agent to refresh `ideas/TRENDS.md`.

Stories are authored as a single `story.yaml` (see CORE.md and `templates/story_schema.yaml`).

## Where things live
- `stories/<ID>_<slug>/`: everything for one video
- `ledger/verification/`: proof that each story is original
- `assets/`: reusable rigs, maps, faces, SFX (add exports from Roblox Studio here, log them in `assets/INDEX.md`)
- `archive/`: the original kit and notes (read-only)
