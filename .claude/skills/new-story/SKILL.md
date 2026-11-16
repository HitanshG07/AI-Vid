---
name: new-story
description: Create a brand-new, web-verified, engaging Roblox story (premise, originality check, script, beats). Use when the user asks for a new story or video idea.
argument-hint: "[optional theme or count]"
---
# New Story
1. If `ideas/IDEA_BANK.md` has an unused PASS premise and the user did not ask for new ideas, offer it first.
2. Spawn `showrunner` (opus) to brainstorm 3-5 premises using the freshness brief in AGENTS.md (plus any theme in $ARGUMENTS). Assign the next IDs from the ledger.
3. Run the `verify-originality` skill on all of them.
4. Pick the strongest PASS (ask the user if several are strong). If none pass, return to step 2 (max 3 rounds, then report).
5. Spawn `showrunner` (opus) to write `stories/<ID>_<slug>/`: script.md, narration.txt, beats.json (from templates/).
5b. Spawn `showrunner` (opus) to write `MANIFEST.md` from `templates/production_manifest_template.md`. Every section and every beat must be filled, at minute detail: what each character does, where it is set, all emotions, all assets/meshes, all animations, all VFX. Mark each asset REUSE <path> (check assets/INDEX.md) or NEW.
6. Spawn `verifier` (sonnet) to score it with docs/ENGAGEMENT_RULES.md. Average below 8: send the fixes back to showrunner and repeat (max 2 rewrites).
6b. `verifier` also checks MANIFEST.md against the template and section H. Any blank, vague ("some props") or missing beat → back to showrunner.
6c. Spawn `researcher` (haiku) to build the Argon handover package: `audits/ARGON-<NNN>_<date>_<ID>_part1of1.zip` (≤100 MB). It contains:
   - README.md (what's where, and the order: paste 01, then 02, then export to the listed paths)
   - 01_ARGON_THEME_LOCK_PROMPT.txt (PROMPT 1 from docs/ARGON_PIPELINE.md)
   - 02_ARGON_BUILD_PROMPT_<ID>.txt (written from MANIFEST B–F, NEW items only, with the exact engine names and repo export paths)
   - MANIFEST.md
   - ASSET_CHECKLIST.csv (name, new/reuse, size, material, socket, export path)
   - reference/design_bible/*.jpg, assets/faces/skin_tones.json
   - any REUSE reference files Argon needs
   Log the package in audits/AUDIT_LOG.md.
7. Set ledger status `Scripted` and remove it from IDEA_BANK. Report the title, hook line, scores and folder path. Next step: `/produce-video <ID>`.
