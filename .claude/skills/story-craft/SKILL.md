---
name: story-craft
description: V6.4 writing rules with FAIL vs PASS examples so any model writes 9/10 Roblox Shorts scripts that pass Gate 1 and can be staged by the engine; use in ai-vid-pipeline Phases A & C (before story.yaml or voice_subs.py).
---
# Story Craft (V6.4; the gates in `pipeline/qa_gate.py` + `story_gen.kid_simple_errors` enforce the numbers)
Kid-safe, ONE ending, earned meaning shown not stated, one of 4 engines (ironic_reframe, social_karma, clever_loophole, moral_dilemma).

## 1. Shape (hard numbers)
- Title: `In This World, <rule>` or `In This Town, <rule>`, max 60 chars (e.g. "In This Town, Every Lie Makes Your Shoes Squeak").
- 20-24 beats (aim 22, `dur: 2.4`), spoken lines 2-9 words (mostly 5-9), 4th-grade spoken English, narrator <= 30% of beats.
- `rule:` one line, max 14 words. No adult/essay words (championship, official, consequence, therefore, policy ...). No emojis anywhere.
- Fill `rule, visible_proof, personal_stake, motivated_choice, rule_payoff, cta`.

## 2. Opening and ending
- Beats 1-3 = world-rule montage: fast, different on-screen proofs of the rule happening to other people/places. The hero's personal stake starts at beat 4.
- Final beat ends on the spoken dilemma question (also the `cta:`), e.g. "Would you tell the truth or keep squeaking?". No `binary_cta` card (it covers the character).
- Ending is a physical callback to the opening OR a karma flip the viewer can see.

## 3. Loud stakes and rule-of-3
Before the twist, 3 escalating PUBLIC reactions, each with >= 2 other characters.
- FAIL: a quiet solo object moment no one reacts to.
- PASS (story 008): Zoe calls it out -> Milo steps back in the lunch line -> the dodgeball faceplant ruins the team photo. Each reaction bigger and more public.

## 4. Engine capability contract (if the engine cannot show it, the story cannot depend on it)
- Only values from `assets/manifest.json`: sets + their spots, cameras, motions, actions, faces, fx, prop kits (banner, locker, paper, phone, podium), lighting.
- Shrinking/growing = `scale:` (0.2-2.5, persists); vanishing = `invisible: true`; rule numbers = `counter:` (max 18 chars, A-Z 0-9 : = + - / ! ? . % only); face change mid-beat = `face_mid:` (4-6 per story).
- Overlays: 1-2 per story (max 5 allowed): `speedlines` (shock/reveal), `crimson_vignette` (danger), `sweat`, `hearts`, `flash_red_blue`, `bubble` + `overlay_text` 2-16 chars, `phone_card` + `overlay_text` "TITLE | message" 4-64 chars. Never stack them.
- A rule that says shrink/grow/tiny/vanish without the matching field fails Gate 1 before any judge.
- Custom static props: max 2 tiny Parts (`props:` with `attach:` / `hide:`); no props that must move on their own.
- Prefer tight expressive close-ups over walks across the room.

## 5. Captions and pacing
- 1 `*starred*` emphasis word in >= 60% of spoken beats (stars are stripped for TTS/captions).
- ~140-155 spoken words lands at ~44-50 s with the V6.4 voice (0.98 speed, 0.25 s beat breaths). Fix length by cutting lines, never by raising speed.

## 6. Kill-switch (all must be yes before writing story.yaml)
1. The rule reads on mute in beats 1-3.
2. 3 public escalations before the twist.
3. Every rule effect maps to an engine field (scale / invisible / counter / face_mid / overlay).
4. The ending is a visible callback or karma flip, closed by the spoken question.
Any "no" = rewrite the pitch, not the polish.
