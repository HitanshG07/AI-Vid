# 007 — Wrist Rewind (2-part series)
- **Format:** Part 1 of 2 / Part 2 of 2 (each <=60s; Part 1 ends on a cliffhanger, Part 2 fully resolves)
- **Style ref:** zaylento (golden-hour classroom, warm bloom; lab shifts to cold smoke-grey during the crisis)
- **Subtitle style:** LowerThirdYellow
- **Core meaning:** Spend your sacrifices on people, not pride.
- **Engagement score (Part 1):** hook 8/10 · pacing 8/10 · cliffhanger (in place of twist) 8/10 · cliffhanger (in place of payoff) 8/10 → avg 8.0 · meaning & completeness gate: PASS
- **Engagement score (Part 2):** hook 7/10 · pacing 8/10 · twist 8/10 · payoff 8/10 → avg 7.75 · meaning & completeness gate: PASS (fix hook, then re-average to 8.0)
- **Fixes (verifier):** P2 hook: open with a stronger recap, e.g. "Fifteen years of saving. One tap." instead of "Last time: acid, glass, Mia's face." P2: replace "Jace laughed and called me boring" (weak, no payoff) with a line that pays off his selfie habit or cut it. P2: add one beat of Mia seeing the hands or Jace's reaction being about the age gap, to avoid "you're nineteen?" reading oddly from a 30-year-old-handed kid.
- **History:** Standalone R0 8/8/6/7; R1 8/8/8/8 PASS, but narration measured 84.8s (258 words), so split into 2 parts. Old files in old/. Needs re-scoring.
- **Files:** narration_p1.txt + beats_p1.json, narration_p2.txt + beats_p2.json

## Part 1 narration (151 words, ~50s speech, 56s cut) — narration_p1.txt
In my world, tapping your wrist rewinds any mistake by ten seconds. But your hands age one year every time. Kids rewind dropped phones and spilled milk. Jace rewinds bad selfies; he has thirty-year-old hands. Mine are fifteen. Zero taps. My grandma spent her taps on herself, and her hands shook too hard to hold mine. So I saved mine. Then chemistry class, last period. Mia sits beside Jace. She once lent me a pencil when nobody else would talk to me. Jace was showing off for his phone, as always. Two bottles, same shape, side by side. Red label is acid. Plain one is water. He grabbed the red one. Mia leaned in to watch. He poured. The beaker hissed. The glass cracked, bulging toward her face. Nobody else saw it. My finger hovered over my wrist. Fifteen years of saving. One tap breaks it. Do I spend it on her?

## Part 2 narration (156 words, ~52s speech, 58s cut) — narration_p2.txt
Fifteen years of saving. One tap. Ten seconds back, before the pour. I yelled. He poured anyway. Tap. I grabbed his arm. He shoved me, and poured. Tap. My knuckles started to wrinkle. So I stopped fighting and started watching. Water bottle, left of the acid. He pours with his right hand. At second seven, he turns to pose for his phone. Tap. Last loop. I waited. He turned. Flash. I swapped the bottles. He poured water. Nothing happened. Jace checked his selfie, never the beaker. I pulled my sleeves over my hands. Mia saw them anyway. "You never tap. Why now?" Four taps. Four years. For ten seconds. Mia smiled at me, her face perfect, and lent me a pencil again. Jace spends his years on selfies. Grandma spent hers on her own mistakes. I spent mine on someone else. A few years of my hands for her whole face. They were saved for her.

**Setups -> payoffs (across the series):**
- P1 two same-shaped bottles side by side, red = acid, plain = water (~30s) -> P2 the swap (~27s).
- P1 Jace's selfie habit + "showing off for his phone" (~8s, ~28s) -> P2 he turns to pose at second seven, opening the swap window.
- P2 loops: 1-2 fail by force, 3 is pure observation, 4 executes.
- P1 Mia's pencil (~24s) -> P2 she lends it again (~42s).
- P1 grandma spent taps on herself, Jace on selfies -> P2 contrast line: Jace (pride), grandma (herself), narrator (someone else) = the meaning.
- P1 "So I saved mine" / cliffhanger "Do I spend it on her?" -> P2 last line "They were saved for her."

## SFX cues — Part 1
| ~sec | SFX |
|---|---|
| 0.0 | whoosh |
| 2.0 | rewind_zip |
| 4.0 | skin_creak |
| 6.0 | rewind_zip (phone/milk) |
| 8.0 | shutter (Jace selfie) |
| 14-18 | piano_note (grandma) |
| 20.0 | bell |
| 24.0 | ding (pencil) |
| 28.0 | shutter (showing off) |
| 30.0 | glass_clink (bottles) |
| 38.0 | pour |
| 40.0 | hiss_crack |
| 42-46 | tick |
| 50.0 | hiss_crack (frozen shards) |
| 52.0 | whoosh, cut to black |

## SFX cues — Part 2
| ~sec | SFX |
|---|---|
| 0.0 | hiss_crack (recap) |
| 3.0 | rewind_zip (tap 1) |
| 6.5 | hiss_crack |
| 8.5 | rewind_zip (tap 2) |
| 12.0 | thud |
| 14.0 | skin_creak (tap 3) |
| 16-22 | tick (observing) |
| 22.0 | shutter |
| 24.0 | rewind_zip (tap 4) |
| 27.0 | shutter (swap) |
| 29.0 | pour |
| 31.0 | shutter (Jace checks selfie) |
| 35.0 | thud |
| 40.5-42.5 | ding (pencil again) |
| 44.5 | shutter (Jace selfie) |
| 46.5-58 | piano_note |

## Required assets
| Path (placeholder) | What | How to make |
|---|---|---|
| assets/rigs/hero_teen.rbxm | Narrator, R15 teen, lab coat + goggles, sleeves that can be pulled over hands | MCP generate_avatar |
| assets/rigs/jace_teen.rbxm | Jace, flashy R15 teen, phone accessory, visibly aged hands | generate_avatar |
| assets/rigs/mia_teen.rbxm | Mia, R15 teen, lab coat, pencil | generate_avatar |
| assets/rigs/teacher.rbxm | Chemistry teacher, R15 adult | generate_avatar |
| assets/rigs/grandma.rbxm | Grandma, R15 elder, for flashback | generate_avatar |
| assets/rigs/extras_kids.rbxm | 1-2 kids (phone kid) for rule montage (Part 1 only) | generate_avatar |
| assets/maps/school_lab.luau | Chemistry lab: benches, shelves, fume hood, windows (golden hour) | Luau builder |
| assets/maps/school_hallway.luau | Hallway for rule montage (Part 1 only) | Luau builder |
| assets/maps/grandma_room.luau | Small warm bedroom for flashback | Luau builder |
| assets/props/lab_kit.rbxm | Beaker, two identical-shaped bottles (one red label = acid, one plain = water), phone, pencil, milk carton | generate_mesh |
| assets/textures/aged_hands_1-4.png | Hand skin textures 15 -> 19 yrs + Jace 30 yrs | generate_texture |
| assets/faces/{Happy,Shocked,Worried,Straining,Crying,Determined,Sad,Smirk}.png | Face decals | PNG |
| assets/sfx/{whoosh,rewind_zip,hiss_crack,glass_clink,shutter,bell,tick,ding,pour,piano_note,crowd_ooh,thud,skin_creak}.wav | SFX (only these are used in beats) | free/CC0 |
| VFX (in-engine) | rewind blue-tint + motion trail, acid splash/smoke, glass shards (freeze-frame for P1 ending), volumetric window beams, loop counter flash | Studio particles/post-FX |
