# <ID> — <Title> — PRODUCTION MANIFEST
<!-- Mandatory for every story (AGENTS.md). Zero vagueness: if a reader (Argon, engine AI, auditor) has to guess, it is incomplete.
     Fill EVERY section. Write "none" explicitly rather than leaving blank. Worked example: stories/007_wrist-rewind/MANIFEST.md -->

## A. Story meta
- **Format:** Standalone / Part X of N · length per part · ~words per part · 30 fps · 1080x1920
- **World rule:** 
- **Twist:** 
- **Core meaning:** 
- **Cliffhanger / ending plan:** (Part 1 ends ON the person in danger, hard cut, no fade. The final part fades to black.)
- **Hashtags (3–5):** 
- **Verification:** ledger/verification/<ID>.md (PASS)

## B. Sets & lighting (where it is set)
One block per set:
| Field | Value |
|---|---|
| Set name (exact model name) | e.g. Set_ChemLab · REUSE <path> / NEW |
| What it looks like | walls, floor, windows, furniture, mood, era, what's on the walls |
| Origin / extents (studs) | origin X,Y,Z · size |
| Key surfaces | bench/table top Y, seat heights, door positions |
| Prop placements | prop → X,Y,Z, rotation |
| Character marks | who stands/sits where (X,Z, yaw) |
| Grade(s) used | G.n / G.r / G.s / G.h / new (define it) |
| Time of day / light sources | sun angle, lamps, window beams |
| DOF / focus | default focus target, how much background blurs |
| Ambient sound bed | e.g. classroom murmur at −28 dB |

## C. Characters (what each one does + ALL emotions needed)
One block per character (main, kid/aged variant, every extra):
| Field | Value |
|---|---|
| Engine name | Hero / Mia / Extra1 … |
| Role | who they are to the story |
| Look | age, scale (kid 0.62 / teen 1.0 / adult 1.08), skin hex, hair, outfit colours, accessories |
| Source | REUSE <path> / NEW (Argon) |
| Emotions needed | full list, e.g. Determined, Shocked, Worried, Crying, Happy |
| Body states | e.g. hand aging 0→1, sleeves pulled over hands, wet hair |
| What they do (whole story) | ordered list of every physical action with part + time, e.g. "P1 0.0 taps left wrist with right index finger" |
| Held props | prop → which hand, when |

## D. Assets & meshes (for Argon)
| # | Engine name | What / description | Size (studs) | Material · colour | Sub-parts that animate | CanQuery | Placement / socket | Used in (beats) | REUSE path / NEW |
|---|---|---|---|---|---|---|---|---|---|
Also list here:
- face decals/PNGs per character and emotion
- textures and decals (labels, signs)
- SFX .wav files
- music (if any)

## E. Animations
| # | Name | Who | Description (joints, angles, timing) | Loop / one-shot | Beats |
|---|---|---|---|---|---|
Examples: tapPose, selfie, reach, hold+pour tilt, lean, walk, fist, tremble, idle breathing, blink, lip-sync.

## F. VFX
| # | Name | Trigger (beat / word) | Look (colour, size, count, motion) | Duration | Limits / rules |
|---|---|---|---|---|---|
Examples: grade switch, ripple ring, motion streak, smoke, crack, shards, flash, shake, bloom swell.

## G. Beat-by-beat director table (every ~1.2–2 s, from 0.00 to the last frame, for each part)
| # | t start→end | Spoken line | Caption chunks (1–3 words) | Shot (type, FOV, move, clearShot) | What each character does | Face swaps | Props state | VFX | SFX (trigger word) | Grade |
|---|---|---|---|---|---|---|---|---|---|---|

## H. Pre-render QA checklist
- [ ] Every beat in G has a camera, an action for each visible character, and a face per visible character
- [ ] No cloned or bare extras, no default faces
- [ ] No prop covers a face (clearShot); held props welded
- [ ] No overlay hovers off a limb; VFX within the flash caps
- [ ] Captions 1–3 words, lower third, never end on a function word
- [ ] Part 1 hard-cuts on the person in danger; final part resolves and fades
- [ ] Beat sheet (`pipeline/qa_sheet.py`) reviewed by render-qa
- [ ] Argon handover package built: audits/ARGON-<NNN>_<date>_<ID>_part1of1.zip
