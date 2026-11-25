# START HERE: give this file to any AI

You are joining the AI-Vid project (C:\AI-Vid): original Roblox story shorts for YouTube Shorts, Reels and TikTok.

## Step 1: read before doing anything (in this order)
1. `AGENTS.md`: the rulebook. It always wins.
2. `docs/QUALITY_PLAYBOOK.md`: how to hit the quality bar.
3. `docs/HANDOFF.md`: current status.
4. `docs/LESSONS_LEARNED.md`: pitfalls.
5. `docs/AI_ADAPTERS.md`: setup for your specific tool.

## Step 2: ASK THE OWNER this question, then STOP and wait for the answer
> **How should we pick the next story?**
> 1. **Idea bank:** use a verified, unused idea from `ideas/IDEA_BANK.md`.
> 2. **Candidates:** pick from the ready-made but UNVERIFIED ideas in `ideas/candidates_2026-11-19/` (100 ideas, hush-hush ideas, 10 five-part series). They must pass the originality check first.
> 3. **Find new:** research what is trending now (refresh `ideas/TRENDS.md`), then propose ideas built on those formats.
> 4. **Brainstorm:** invent 3–5 brand-new premises from the freshness brief in AGENTS.md.
> 5. **I have my own idea:** the owner describes it, and you shape it to the rules.
>
> Also: **format?** Standalone (≤60 s), 2–3 part series, or 5-part series.

Do not choose for the owner. Do not write anything until they answer.

## Step 3: after the answer
- Show 3 options. For each give the one-line rule ("In this town, every time you X, Y happens…"), the twist, and the ending sting. Ask the owner to pick one.
- Run the originality check on the pick (`.claude/skills/verify-originality/SKILL.md`). Real URLs go in `ledger/verification/ideas/<slug>.md` (it becomes `ledger/verification/<ID>.md` once the pick gets its story ID). REJECT means pick another.
- Then follow the loop in `.claude/skills/new-story/SKILL.md` and `.claude/skills/produce-video/SKILL.md`: script, MANIFEST, cast builder, score (≥ 8.5, every gate passes), voice, Studio, QA.

## Non-negotiables (full list in AGENTS.md)
- Stories are never copied. Every premise is web-verified first.
- Catchiness engine: active rule visible in frame 1, 3 planted clues, taboo broken by 25 s, rule of 3, rule-hack climax, action-echo ending. No moral lines.
- R6 catalog characters. Outfits match gender: boys never wear girls' items, and girls never wear boys' items.
- The cutscene is a copy of `engines/roblox/story001_cutscene.luau`. Every rig animates. Frame whole bodies, with no wall clipping and no giant-face filler.
- Voice: Kokoro `am_adam` (`--engine kokoro`), owner's choice. About 185–210 words per part.
- **Mouse lock (owner rule):** every take is recorded ONLY via `pipeline/record_take.py`, which locks the cursor at the top menu bar (900,12) for the whole take and releases it after; never record any other way, never move or unlock the mouse during a take, and never park it at the bottom/corners (taskbar pops up).
- **Thumbnail (owner rule 2026-11-19):** every story ships `stories/<ID>_<slug>/thumbnail.jpg` (1080x1920) made from a real frame of the story itself, taken from the caption-free take (`rec/takeN.mp4`, transpose=2 + crop) at the most gripping moment, with no generated art. Add a 2–3 line bold title (Arial Black, white plus one accent colour, thick black border) in the top and bottom thirds that teases the rule without spoiling the twist. Reference it in PUBLISH.md. Example: story 002.
- One Studio job at a time. **Never record until the owner says "record".**
- Cheapest model that can do each job (low, mid, high tiers per AGENTS.md).
- Never change rules, skills, templates, pipeline, assets or ledger rows, and never delete or move files, unless the owner says so.

## When you report back
Say what you did, what is verified (and how), what was not run, and what the owner must decide next.

- Endings: twist + a short warm conclusion that echoes the rule (owner feedback, story 002).
