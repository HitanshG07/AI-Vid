# AI-Vid Instructions

Read `CORE.md` and `config.yaml` first. `CORE.md` is the single source of truth (visual standards, owner rules, V5.4 story and format rules, loop, QA).

- Author only `stories/<ID>_<slug>/story.yaml` from `templates/story_schema.yaml` (examples in `templates/blueprints/`); the pipeline compiles everything else.
- Next story ID = highest ID in `ledger/STORY_LEDGER.md` + 1. Web-verify originality and save a PASS receipt in `ledger/verification/<ID>.md` before preflight.
- Record ONLY after the owner says "record", via `pipeline/run_take.py`.
- Protected: never edit `core_engine.luau`, `CORE.md`, `config.yaml`, `pipeline/*.py` or `assets/faces/` unless the owner says so.
- Skills are owner-only: never edit `.claude/skills`, `.agents/skills` or `.agent/skills` (read-only; the owner edits `.claude/skills` and runs `.claude/sync_skills.ps1`).
