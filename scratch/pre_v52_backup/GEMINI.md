# AI-Vid V5 Instructions

Read `CORE.md` and `config.yaml` first.

- **Authoring:** Write ONLY `stories/<ID>_<slug>/story.yaml` (from `templates/formats/*.yaml`). Never hand-write `narration.txt`, `beats.json`, `PUBLISH.md`, or Luau files.
- **Protected Files:** Never edit `engines/roblox/core_engine.luau`, `CORE.md`, `config.yaml`, or `pipeline/*.py` unless the owner explicitly says so.
- **Production Loop:** `compile_story.py` -> `voice_subs.py` -> `preflight_lint.py` -> Studio preview -> record ONLY after the owner says "record", via `run_take.py` (`--draft` then `--final`), cursor locked at `900, 12`.
- **Story Standards:** Next story ID is `004`. Stories must be standalone, written in 5th-grade English, max 2.2s per shot.
- **Cast:** Every cast entry has gender `boy|girl|man|woman` with matching outfits.
- **Model Tiers:** Cheap model for searches/ledger; strong model only for writing `story.yaml`.
