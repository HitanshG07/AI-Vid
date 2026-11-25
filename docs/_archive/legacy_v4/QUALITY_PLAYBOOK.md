# Quality Playbook: how to match the reference output (for ANY AI)

AGENTS.md is the law. This file explains **how** to meet it. Read it before writing a story or touching Studio.
An earlier story failed because another AI skipped these habits. It rewrote the engine, froze the rigs, filled shots with giant faces, and put boys in girls' clothes. Don't repeat that.

## 0. Mindset
- **Reuse before you invent.** Start every cutscene from `engines/roblox/story001_cutscene.luau`, which is the approved engine. Copy it to `story<ID>_cutscene.luau` and change only the beats, the sets and the cast. Never write a new animation system.
- **Prove it, don't claim it.** Every claim is labelled executed, statically checked, or not run. A take is done only when `rec/qa_pN.md` exists with a PASS for every beat.
- **Cheapest model that can do the job.** Low tier does searches, copies, commands and ledger rows. Mid tier does merges, reviews, scoring and QA. High tier does premises, scripts, scene code and hard debugging.
- **Never record until the owner says "record".**

## 1. Story: the catchiness engine (docs/ENGAGEMENT_RULES.md)
Write the premise as one line first:
> In this <place>, every time you <everyday action X>, <physical thing Y> happens (small X = tiny Y, huge X = giant Y).

If the rule just sits there (a glow or a label), throw it away. Then fill this skeleton. Times are for a 55–60 s part.

| s | Beat | Checklist |
|---|---|---|
| 0–2.5 | Hook | Rule stated and **visible in frame 1** |
| 2.5–13 | Playground | 1 absurd public disaster, 1 weird town adaptation, **3 planted clues** (concrete objects or facts) |
| 13–21 | Personal trap | Why the narrator is uniquely stuck, plus a ticking clock. Taboo broken on screen by 25 s at the latest |
| 21–39 | Rule of 3 | Clue 1 fails, clue 2 fails worse, clue 3 fails at the brink. Each lands on a spoken impact word ("Snap!") synced to an SFX cut |
| 39–51 | Rule-hack | The hero wins with the rule's **own mechanics** (scale overload or a loophole). No luck, no outside helper |
| 51–60 | Action echo | The rule fires one last time to prove the meaning, plus a 2 s karmic or comic sting. **No moral line** |

Alternative allowed shape: a dark hook that turns into a wholesome 180° flip (Revan style). It still needs the 3 planted clues to pay off.
Self-check before handing to the verifier:
- Would a scroller stop in 1 s?
- Is there any line an adult says to explain the moral? Delete it.
- Is every clue fired?
- Does the last shot make someone comment?

Length is about 165–180 words per part (Kokoro `am_adam`, measured); always confirm voice.mp3 < 60 s. Too long? Split into parts. Never cram.

## 2. Cast: R6 catalog, gender-locked
- One entry per character in `engines/roblox/cast_<ID>.luau`. Every entry has `gender = "boy"|"girl"|"man"|"woman"`, and `build()` asserts it.
- Search the catalog with gendered terms ("boy hoodie", "girl ponytail hair", "women blouse", "men work jacket"). Read each item's catalog **name** and log it in MANIFEST section C. Neutral names (plaid shirt, jeans) are OK, but check the thumbnail on girls and women.
- Girls get girls' hair. Boys never get skirts, dresses or feminine hair. Default "Man"-body hair is male.
- Vary outfits so crowds aren't clones. Faces come only from `assets/faces/classic_v1/ids.json`, and you change emotion with `setFace`.

## 3. Animation: why our takes look alive
- Every on-stage rig plays a **real R6 AnimationTrack** every frame: idle when standing, walk or run when moving, with walk speed scaled to ground speed.
- In the per-frame loop, **reset `r.loco = nil` before the beat function runs**. Otherwise a rig that walked once stays stuck in walk (this was an earlier story's bug).
- Gestures (wave, point, head turn) override **one joint at a time** through C0, for at most one beat, and then return to idle.
- No rig stands frozen or holds a T-pose. Off-stage rigs have `r.on = false` and are hidden.
- Breathe out of sync: start each idle at a random `TimePosition`.

## 4. Camera: show bodies acting
- Mix: about 60% slow push-ins, 25% snap pull-outs, 15% impact snap-zooms with a 2.5° Dutch tilt. Cut every 1.2–2 s.
- Frame **whole characters doing the action**. Use close-ups only for an emotion swap, and keep the face plus shoulders in frame.
- Never: a camera inside or behind a wall, giant heads filling the frame as filler, a tilted torso with no face, or an unreadable dark frame. Run `clearShot()` on every face camera.
- The world rule is visible in every shot where it applies, so the story works with the sound off.
- Light: `ClockTime = 16.8`, textured surfaces, Future lighting.

## 5. Voice, captions, sound
- `python pipeline/voice_subs.py --story-dir <dir> --text "$(cat narration.txt)"`. Default narrator: Kokoro `am_adam` (`--engine kokoro --kokoro-voice am_adam --speed 1.15`). Edge fallbacks: `viral_storyteller` (ChristopherNeural), `urgent_teen` for a teen narrator, `fast_mystery` for dark mysteries, `classic_andrew` for warm family stories.
- Kokoro option (owner-chosen narrator for story 002): `python pipeline/voice_subs.py --story-dir <dir> --engine kokoro --kokoro-voice am_adam --speed 1.15 --text "$(cat narration.txt)"` (preset name `kokoro_adam`; deps pinned in `.kokoro_deps/`). Voice+last word must end by 59.3 s; if longer raise `--speed` in 0.05 steps (max 1.35).
- Captions are `LowerThirdPop`: 1–3 words, lower or upper third, gold on impact words. Never dead centre.
- `finish_video.py` adds the continuous background music bed (`assets/sfx/roblox-story-bg.mp3` at `--bgm-gain 0.14`, looped seamlessly; never synthesized static sounds or noise beds) and the beat SFX cues. Every beat `sfx` must exist in `assets/sfx/`.

## 6. QA loop (do not skip)
1. Dry run in Studio, then `qa_sheet.py` for a beat sheet (one frame per beat plus END).
2. Check each frame:
   - rule visible
   - characters animated, not frozen
   - outfits match gender
   - no wall clipping
   - caption readable and correctly spelled
   - no black tail
3. Fix and repeat until every beat passes. Only then ask the owner to say "record".
4. **Mouse lock (owner rule):** every take is recorded ONLY via `pipeline/record_take.py`, which locks the cursor at the top menu bar (900,12) for the whole take and releases it after; never record any other way, never move or unlock the mouse during a take, and never park it at the bottom/corners (taskbar pops up).
5. After every take, reset the camera (`resetCamera()`: roll 0, FOV 70).

## 7. Definition of done
- [ ] Verification file PASS
- [ ] Verifier average ≥ 8.5, none below 8, all catchiness gates pass
- [ ] MANIFEST complete, with gender and catalog names in section C
- [ ] Voice, subs and final at 1080x1920, 30 fps
- [ ] `rec/qa_pN.md` with every beat PASS and a repeated-frame ratio under 2%
- [ ] thumbnail.jpg made from a story frame (owner rule)
- [ ] PUBLISH.md written and the ledger row updated


## 8. Story 002 additions (2026-11-19)
- Voice: Kokoro `am_adam` is the owner's chosen narrator (`--engine kokoro`). Keep about 165–180 words and confirm the length is under 60 s.
- Finishing: `--lead 1.1` so actions land on their words. Hand-fix split captions.
- Ending = twist + conclusion. Close every thread, then end on a warm beat that echoes the rule.
- Studio: paste code, not HTTP. Mirror the live code to disk after every work block. `play()` always rolls +90.
- Full detail: `.claude/skills/produce-video/SKILL.md`, `roblox-cinema-director`, `roblox-characters` (the "Learned on story 002" sections) and `docs/LESSONS_LEARNED.md`.
