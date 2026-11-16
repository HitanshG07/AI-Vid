# Argon handover package (no videos)

Videos and `rec/` capture folders are intentionally excluded. Everything here is text, images, or mesh/source files.

## Start here

1. **`ARGON-002_character-mesh-test/ARGON_REPORT_character_mesh_test.md`** - the latest request: rebuild Mia v2 to the spec in this report. Read it first.
2. **`ARGON-001_theme-lock/01_ARGON_THEME_LOCK_PROMPT.txt`** - the house style. Lock this first, before any asset work.
3. **`docs/ARGON_PIPELINE.md`** (also at `ARGON-001_theme-lock/ARGON_PIPELINE.md`) - the full rules.

## Story spec format

- `templates/production_manifest_template.md` - the blank template (copy also at `ARGON-001_theme-lock/production_manifest_template.md`).
- `stories/007_wrist-rewind/MANIFEST.md` - a worked example of a filled-in manifest.

## Style and faces

- `reference/design_bible/` - style sheets (`STYLE.md`, `STYLE_kit_v3.md`) and the cast/framing/QA reference boards.
- `assets/faces/skin_tones.json` - skin tone definitions.
- `assets/faces/generated_pngs/` - the face decal/head PNGs.
- `ARGON-001_theme-lock/REUSE_LIBRARY/` - reusable props and face PNGs from the theme lock.

## Meshes

- `assets/meshes/` - current props and converted test meshes (characters, heads, props/glb).
- `kit_v3_meshes/` - the original kit v3 meshes (characters and props, OBJ/MTL/JSON).

## Audit history

- `AUDIT-003_reports/AI-Vid/` - the Story 007 audit history: `AUDIT_LOG.md`, `LESSONS_LEARNED.md`, verification, `AUDIT_REPORT_v2.md`, the QA playbook and the `audit_v2/` before/after frames. The `rec/` folders were removed on purpose.

## Notes

- Paths inside `AUDIT-003_reports/` keep the original `AI-Vid/` prefix from the source zip.
- Ignore any `.zip` files; they were extracted here on purpose.
