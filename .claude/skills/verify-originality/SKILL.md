---
name: verify-originality
description: Web-verify that a story premise is not already an existing story/video before it is scripted. Use for every brainstormed premise and to re-verify ledger rows.
---
# Verify Originality
Input: one or more premises (rule, twist, meaning) with IDs. Any AI can run these steps in order.

1. **Queries.** For each premise build at least 5:
   - `"in this town" "<rule keyword>" roblox`
   - `"in this world" "<rule keyword>" roblox story`
   - `"<core mechanic>" story` (Reddit r/WritingPrompts, Wattpad)
   - `"<twist keyword>" roblox` (YouTube Shorts / TikTok / Instagram)
   - `"<rule in plain words>" short film OR short story`
2. **Search.** Spawn the `researcher` agent (haiku) with all queries for all premises in ONE call.
3. **Judge.** Spawn the `verifier` agent (sonnet) with the results + `ledger/STORY_LEDGER.md`. Same rule OR same twist anywhere = REJECT.
4. **Record.** Verifier writes `ledger/verification/<ID>.md` (from `templates/verification_template.md`) for every premise, PASS or REJECT.
5. **Update.** PASS: ledger status `Verified` + a row in `ideas/IDEA_BANK.md`. REJECT: ledger status `REJECTED` so it is never pitched again.

Never skip step 4. No verification file = the story cannot be produced.
