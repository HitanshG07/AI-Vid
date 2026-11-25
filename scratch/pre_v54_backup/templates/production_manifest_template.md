# <ID> — <Title> — PRODUCTION MANIFEST
<!-- Mandatory for every story (AGENTS.md). Zero vagueness: if a reader (engine AI, auditor) has to guess, it is incomplete.
     Fill EVERY section. Write "none" explicitly rather than leaving blank. Worked example: stories/001_brave-glow/MANIFEST.md -->

## A. Story meta
- **Format:** Standalone / Part X of N · length per part · ~words per part · 30 fps · 1080x1920
- **World rule:** 
- **Twist:** 
- **Core meaning:** 
- **Cliffhanger / ending plan:** (Part 1 ends ON the person in danger, hard cut, no fade. The final part may fade only in the ≤0.4 s tail after the last word; the video never ends on a black hold.)
- **Freshness combo:** rule category · emotion core · setting (AGENTS.md freshness brief; must differ from the last 5 ledger rows)
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
| Rule visibility (sound-off) | how the world rule is visible in every shot |

## C. Characters (what each one does + ALL emotions needed)
One block per character (main, kid/aged variant, every extra):
| Field | Value |
|---|---|
| Engine name | Hero / Mia / Extra1 … |
| Role | who they are to the story |
| Look | age, scale (kid 0.62 / teen 1.0 / adult 1.08), skin hex, hair, outfit colours, accessories |
| Catalog items (R6) | Shirt id, Pants id, Hair id(s), accessory ids (via `AvatarEditorService:SearchCatalog`, Relevance), skin hex, default face |
| Source | REUSE <path> / NEW (entry in `engines/roblox/cast_<ID>.luau`) |
| Face set | from `assets/faces/classic_v1/ids.json`: neutral, scared, shocked, grin, determined, proud (new emotions are added to `engines/faces/classic_faces.py`) |
| Emotions needed | full list, mapped to the face set above |
| Body states | e.g. hand aging 0→1, sleeves pulled over hands, wet hair |
| What they do (whole story) | ordered list of every physical action with part + time, e.g. "P1 0.0 taps left wrist with right index finger" |
| Held props | prop → which hand, when |

## D. Assets (Studio-built / Creator Store; Argon retired for 3D 2026-11-17)
| # | Engine name | What / description | Size (studs) | Material · colour | Sub-parts that animate | CanQuery | Placement / socket | Used in (beats) | Source: Studio-built / Creator Store id (scripts inspected) / REUSE path |
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
> Shot column must name the camera mode: pushIn / snapOut / impactZoom (+2.5° Dutch)
| # | t start→end | Spoken line | Caption chunks (1–3 words) | Shot (type, FOV, move, clearShot) | What each character does | Face swaps | Props state | VFX | SFX (trigger word) | Grade |
|---|---|---|---|---|---|---|---|---|---|---|

## H. Pre-render QA checklist
- [ ] Every beat in G has a camera, an action for each visible character, and a face per visible character
- [ ] No cloned or bare extras, no default faces
- [ ] No prop covers a face (clearShot); held props welded
- [ ] No overlay hovers off a limb; VFX within the flash caps
- [ ] Captions 1–3 words, lower or upper third, never end on a function word
- [ ] Every beat has a `line` whose first word is spoken (qa_sheet and the SFX mixer drop beats without one)
- [ ] Every `sfx` name exists in `assets/sfx/`
- [ ] Camera modes in G add up to roughly 60% pushIn / 25% snapOut / 15% impactZoom
- [ ] World rule visible in every shot where it applies (sound-off)
- [ ] Part 1 hard-cuts on the person in danger; final part resolves, fades only in the tail, never holds black
- [ ] Beat sheet (`pipeline/qa_sheet.py`, frames = beats + 1) reviewed by render-qa and saved as `rec/qa_pN.md`; repeated frames <2% on the 30 fps take
- [ ] Cast builder `engines/roblox/cast_<ID>.luau` written; every face name in G is in `assets/faces/classic_v1/ids.json`

## C addendum (every character)
- Gender (boy/girl/man/woman):
- Catalog item names (shirt / pants / hair / accessories), each checked to match gender:
