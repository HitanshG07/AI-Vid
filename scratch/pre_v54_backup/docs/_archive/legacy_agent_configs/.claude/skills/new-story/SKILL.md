---
name: new-story
description: Create a brand-new, web-verified, engaging Roblox story (premise, originality check, script, beats). Use when the user asks for a new story or video idea.
argument-hint: "[optional theme or count]"
---
# New Story
1. If `ideas/IDEA_BANK.md` has an unused PASS premise and the user did not ask for new ideas, offer it first.
2. Spawn `showrunner` (opus) to brainstorm 3-5 premises using the freshness brief in AGENTS.md (plus any theme in $ARGUMENTS). Premises have no story ID yet: label each with a short slug. Each premise states its combo (rule category · emotion core · setting) and names the last 5 ledger rows' combos it differs from, because the ledger has no combo columns to check against.
3. Run the `verify-originality` skill on all of them.
4. Pick the strongest PASS (ask the user if several are strong). Assign the pick the next story ID (highest ID in the ledger's Stories table + 1), move its row from "Verified ideas" to "Stories" and its evidence file from `ledger/verification/ideas/<slug>.md` to `ledger/verification/<ID>.md`. If none pass, return to step 2 (max 3 rounds, then report).
5. Spawn `showrunner` (opus) to write `stories/<ID>_<slug>/`: script.md, narration.txt, beats.json (from templates/).
5b. Spawn `showrunner` (opus) to write `MANIFEST.md` from `templates/production_manifest_template.md`. Every section and every beat must be filled, at minute detail: what each character does, where it is set, all emotions, all props and sets, all animations, all VFX. Mark each asset REUSE <path> (check assets/INDEX.md) or NEW (Studio-built / Creator Store source). Section C lists catalog item ids and the face set per character.
6. Spawn `verifier` (sonnet) to score it with docs/ENGAGEMENT_RULES.md. Average below 8: send the fixes back to showrunner and repeat (max 2 rewrites).
6b. `verifier` also checks MANIFEST.md against the template and section H. Any blank, vague ("some props") or missing beat → back to showrunner.
6c. Spawn `showrunner` (opus) to write the cast builder `engines/roblox/cast_<ID>.luau` from MANIFEST section C (catalog ids found via `AvatarEditorService:SearchCatalog`, skin, default face; pattern: `engines/roblox/cast_001.luau`; faces: `assets/faces/classic_v1/`). No Argon handover zip (retired 2026-11-17).
7. Set ledger status `Scripted` and remove it from IDEA_BANK. Report the title, hook line, scores and folder path. Next step: `/produce-video <ID>`.


## v2 rules (2026-11-19, owner-approved)
- Follow the **catchiness engine** in `docs/ENGAGEMENT_RULES.md`: active rule (not a badge), rule visible in frame 1, 3 planted clues, taboo broken by 25s, rule-of-3 attempts, rule-hack climax, action-echo ending, no moral/lecture lines. Avg >= 8.5, none below 8, every gate passes.
- ~165–180 words per part (default voice preset `viral_storyteller`).
- Every cast entry declares `gender` (boy/girl/man/woman); all clothing, hair and accessories must match it.
- New cutscenes start from `engines/roblox/story001_cutscene.luau`; reset `loco` every frame; no frozen rigs; no wall-clipping or tilted giant-face filler shots.

- Endings: twist + a short warm conclusion that echoes the rule (owner feedback, story 002).
