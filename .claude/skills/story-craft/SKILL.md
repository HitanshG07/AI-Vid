---
name: story-craft
description: Writing rules with FAIL vs PASS examples so any model writes 9/10 Roblox Shorts scripts; use in ai-vid-pipeline Phases A & C (before story.yaml or voice_subs.py).
---
# Story Craft (apply with CORE.md; never contradicts it)
CORE.md still rules: kid-safe, ONE ending, earned meaning shown not stated, 4 engines, pitch gate (3 pitches, STOP for owner), >=30% dialogue, 16-24 beats, 40-55s.

## 1. Loud Stakes and Rule-of-3
Before the twist, 3 escalating PUBLIC reactions, each involving >=2 other characters.
- FAIL: a quiet solo object moment (a coin clicking under a bed). No one reacts, nothing is risked.
- PASS (story 008): Zoe calls it out ("Hey, is that *you* making that noise?") -> Milo steps back in the lunch line ("Dude, did you step in *something*?") -> dodgeball faceplant plus the ruined team photo ("He slipped on *nothing*!", "Uh... what's *on* you?"). Each reaction is bigger and more public than the last.

## 2. Zero-Spoiler Title and 2nd Twist
- FAIL: "The Roommate in the Mirror" (title names the cause; guessed by 0:07).
- PASS: "Why Is Everyone Laughing? 😭" (sells the reaction, hides the cause until beat 18+: "My wrapper. Stuck to my *shoe*.").
- If the first twist is guessable early (title or first 10s), you MUST add a genuine second twist (008: he re-throws, misses, wrapper sticks to the OTHER shoe).
- Title shares no distinctive noun with the last 3 lines (lint warns).

## 3. Static-Prop Reality Cap
- Set props: use only the built-in list in CORE.md "Verified built-in props" (do not invent others; do not copy the list here).
- `custom_props` (story.yaml `props:`): max 2 tiny STATIC Parts, e.g. a TrashCan plus a Wrapper welded to a shoe (`attach:`). Hide/show or re-attach per beat with `prop:` cues. Optional `custom_props:` key listing their names is accepted; lint warns above 2.
- BAN animated or mechanical props: rolling coins, rattling fans, working mirrors, room light switches, anything that must move on its own or flip lighting.
- If the engine cannot show it, the story cannot depend on it.

## 4. Caption and Word-Count Polish
- Put 1 `*starred*` emphasis word in >=60% of spoken beats (lint warns under 50%). Stars are stripped for TTS/captions by compile_story.
- Total spoken words 125-150 for 42-50s (~180-200 WPM). Lint warns over 155. Cut lines, do not raise speed.
- Short sentences, 5th-grade words, numbers/names spoken plainly.

## 5. Four-Question Kill-Switch (pass ALL before writing story.yaml or running voice_subs.py)
1. No early spoiler: neither the title nor the first 10s reveals the cause or ending.
2. 3 public escalations before the twist (block 1).
3. <=2 static custom props; everything else from the set inventory.
4. Ending is a physical callback to frame 1 (008: the wrapper, "walked off") OR a spoken debate/rewatch `cta:` question.
Any "no" = rewrite the pitch, not the polish.
