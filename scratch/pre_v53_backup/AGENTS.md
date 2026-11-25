# AI-Vid V5.2 Instructions

Read `CORE.md` and `config.yaml` first. Do not read archived docs or old story folders. Follow these instructions for all Codex skills.

- **Visual Standards (CORE.md Section 1):** Follow non-negotiable visual standards: real R6 catalog avatars via `CreateHumanoidModelFromDescription` (never primitives, R15, `generate_avatar`, or Blender); textured enclosed sets with no empty baseplate void; zero floating nameplates; live R6 animation with no frozen rigs; faces only via `setFace`; mandatory `screen_capture` lineup check before asking the owner to record.
- **Authoring:** Write ONLY `stories/<ID>_<slug>/story.yaml` (from `templates/formats/*.yaml`), plus a set script in `engines/roblox/sets/` only if a new location is needed. Never hand-write `narration.txt`, `beats.json`, `PUBLISH.md`, or big Luau files.
- **Originality Gate:** Before preflight, web-verify originality (skip for `beat_drop`) and save a `PASS` receipt to `ledger/verification/<ID>.md` using `templates/verification_template.md`. `preflight_lint.py` fails without it.
- **Production Loop:** `compile_story.py` -> `voice_subs.py` (skip for `beat_drop`) -> `preflight_lint.py` -> Studio preview -> record ONLY after the owner says "record", via `run_take.py` (`--draft`, then `--final` if QA passes), cursor locked at `900, 12`.
- **Story Standards:** Next story ID is `004`. Stories must be standalone, 5th-grade English, max 2.2s per shot. Every cast entry has gender `boy|girl|man|woman` with matching outfits.
- **Protected Files:** Never edit `core_engine.luau`, `CORE.md`, `config.yaml`, `pipeline/*.py`, or `assets/faces/` unless the owner says so.
- **Model Tiers:** Cheap model for searches, ledger, and running scripts; strong model only for `story.yaml` and custom set/camera fixes.
