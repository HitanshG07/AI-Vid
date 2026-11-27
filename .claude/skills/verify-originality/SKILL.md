---
name: verify-originality
description: Web-verify that a story premise is not already an existing story/video before it is scripted. Use for every brainstormed premise and to re-verify ledger rows.
---
# Verify Originality
**Non-Claude AIs:** where this says "spawn an agent" (researcher = low tier, verifier = mid tier), do that step yourself on a model of that tier; role files are in `.claude/agents/`. Read `CORE.md` and `config.yaml` first; beat_drop is exempt from the gate.

Input: one or more premises (rule, twist, meaning) with slugs (a premise has no story ID until it is produced). Any AI can run these steps in order.

1. **Queries.** For each premise build at least 5:
   - `"in this town" "<rule keyword>" roblox`
   - `"in this world" "<rule keyword>" roblox story`
   - `"<core mechanic>" story` (Reddit r/WritingPrompts, Wattpad)
   - `"<twist keyword>" roblox` (YouTube Shorts / TikTok / Instagram)
   - `"<rule in plain words>" short film OR short story`
2. **Search.** Spawn the `researcher` agent (low tier) with all queries for all premises in ONE call.
3. **Judge.** Spawn the `verifier` agent (mid tier) with the results + `ledger/STORY_LEDGER.md` (check both tables). Same rule OR same twist anywhere = REJECT.
4. **Record.** Verifier writes `ledger/verification/ideas/<slug>.md` (from `templates/verification_template.md`) for every premise, PASS or REJECT.
5. **Update.** PASS: a row in the ledger's "Verified ideas" table (status `Verified`) + a row in `ideas/IDEA_BANK.md`. REJECT: a row in "Verified ideas" with status `REJECTED` so it is never pitched again.

Never skip step 4. No verification file = the story cannot be produced.

On PASS of the chosen premise, also write the receipt `ledger/verification/<ID>.md`.

## V6.4 notes
- Gate 1 (`qa_gate.py --stage pre`) adds two automatic checks on top of this web check: title/premise Jaccard vs recent episodes (`qa.max_premise_jaccard` 0.42) and a full-script blended unigram+bigram Jaccard vs every `stories/*/story.yaml` (`qa.max_script_jaccard` 0.42). Both must pass; they do not replace the web check.
- Owner-approved exception: stories from `story_gen.py --auto` (Gemini writer + independent Gemini judge) skip the web check; flag them so the owner Googles the premise before producing.
