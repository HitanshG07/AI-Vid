# ARGON-001: Argon theme-lock handover (2026-11-16)

This package locks Argon to the AI-Vid house style before any new story. Story 007 is already built, so nothing here rebuilds it.

## Order
1. Paste **01_ARGON_THEME_LOCK_PROMPT.txt** into Argon once. Wait for its confirmation.
2. Give Argon the **reference/** images (design bible 01–05; treat 05 as the DO/DON'T board) and **skin_tones.json**.
3. **REUSE_LIBRARY/** holds the existing prop meshes (.obj) and face PNGs. Argon should reuse or match them instead of remaking them.
4. For each new story (008+), the AI sends a second zip `ARGON-<NNN>_<date>_<ID>` with `02_ARGON_BUILD_PROMPT_<ID>.txt` + `MANIFEST.md` + `ASSET_CHECKLIST.csv`. Paste 02, and Argon builds and exports to the listed repo paths.

## Files
| File | What |
|---|---|
| 01_ARGON_THEME_LOCK_PROMPT.txt | Paste-once style lock |
| ARGON_PIPELINE.md | Full rules: who does what, style lock, grade presets, storage |
| production_manifest_template.md | What every story spec will contain (sections A–H) |
| reference/*.jpg | Design bible |
| skin_tones.json | Locked skin hex per character |
| REUSE_LIBRARY/props/*.obj,.mtl | 12 existing prop meshes |
| REUSE_LIBRARY/faces/<Char>/*.png | 88 existing face PNGs (3-layer eyes) |
