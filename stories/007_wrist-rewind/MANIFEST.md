# 007 — Wrist Rewind — PRODUCTION MANIFEST (worked reference, v3)
<!-- Built from the engine as it really runs (engines/roblox/story007_cutscene.luau, B1/B2 tables), script.md and assets/INDEX.md.
     All times are seconds from the first spoken word. Coordinates are Roblox studs. -->

## A. Story meta
- **Format:** 2-part series. P1 is 50.05 s and P2 is 51.55 s (cut points). P1 has 151 words and P2 has 156. 30 fps, 1080x1920.
- **World rule:** Tapping your wrist rewinds the last 10 seconds, and your hands age 1 year per tap.
- **Twist:** Force fails twice (yelling, then grabbing). The third loop is pure observation. On the fourth loop he swaps the bottles during Jace's selfie turn.
- **Core meaning:** Spend your sacrifices on people, not pride.
- **Cliffhanger / ending plan:**
  - P1 hard-cuts on Mia, with glass shards frozen beside her face on "on her?". There is no fade.
  - P2 ends warm and bright on "They were saved for her.", then fades only in the 0.4 s tail after the voice.
- **Hashtags (5):** see PUBLISH.md
- **Verification:** ledger/verification/007.md (PASS)

## B. Sets & lighting
### Set_ChemLab (REUSE, assets/maps/story007.rbxl)
| Field | Value |
|---|---|
| Look | School chemistry lab at golden hour. Rows of lab benches, chalkboard wall with a wall clock (CLK ≈ 12,14,−419.4), tall windows with warm sun beams, shelves of glassware, closed ceiling |
| Key surfaces | Bench top TOP = 6.8 (raycast-measured at run time). Hero/Jace/Mia bench row at Z = ZP = −395.4. Risers of height DY = TOP − 4.4 under kids when the benches are tall |
| Prop marks | Water bottle W0 (−16.4, TOP, ZP). Acid bottle A0 (−15.6, TOP, ZP). Beaker B0 (−14.0, TOP, ZP). Pencil PEN0 (−12.6, TOP+0.08, ZP+0.5) |
| Character marks | Hero X = −20, Jace X = −15.5, Mia X = −11.5, all behind the bench facing +Z. Teacher at the chalkboard. Extras at other benches |
| Grades | G.n present, G.r rewind, G.s memory (in the engine's `G` table) |
| DOF | Focus on the shot target. Background extras blurred (EditQualityLevel 21) |
| Sound bed | quiet room tone. SFX carry the scene |

### Set_Hallway (REUSE)
| Field | Value |
|---|---|
| Look | School corridor with lockers, used only for the P1 rule montage (kids with the phone and the milk) |
| Marks | Extra1 (98.5, −404), Extra2 (101.5, −399), Extra3 (100, −396) |
| Grade | G.r |

### Set_GrandmaRoom (REUSE, engines/roblox/sets/grandma_room.luau, v3 look)
| Field | Value |
|---|---|
| Look | Small warm living room: dusty-rose walls, wainscot, red rug, wooden bookshelf (`Shelf` at 188.9, 3.5, −394), armchair |
| Marks | Grandma seated in the armchair (SIT_DY −0.6). LittleHero at (198.3, −406.2), yaw −90 |
| Grade | G.s sepia, soft fill PointLight capped at 0.8 |

## C. Characters
| Engine name | Role | Look | Source | Emotions needed | Body states | What they do (whole story) | Held props |
|---|---|---|---|---|---|---|---|
| Hero | 15-year-old narrator, 0 taps | Teen R15, skin #E8CFA8, lab coat with blue shirt | REUSE (generate_avatar + ApprovedFaces) | Determined, Shocked, Worried, Straining, Crying, Sad, Happy | Hand aging 0 → 0.25 → 0.5 → 0.75 → 1 (P2 taps). Sleeves pulled over the hands (P2 30.3) | **P1:** taps wrist (0.3); fists hand (19.8); head down (25.9); eyes the bottles (30.4); turns head to Jace (35.8); finger trembles over wrist (44.3–48). **P2:** trembles; taps (1.6); yells, arms out (4.6); taps (6.7); grabs Jace's arm (7.1); gets shoved back (8.3); taps, cries (9.9); steps back, watches (12–17); taps (20.7); eyes follow Jace (22.1); swaps the bottles with both hands (23.8); pulls sleeves down (30.3); caught by Mia (32.3); 4 rapid taps shown (35.1); smiles holding the pencil (46.7–51) | Pencil, right hand (P2 46.7+) |
| Jace | Show-off, 30-year-old hands | Teen R15, skin #F2CFA4, flashy outfit | REUSE | Smirk, Happy, Shocked | Hands aged 0.7–0.85 | Selfie poses with flash (P1 9.7, 27.4); shows aged hands (11.3); grabs the red bottle (35.8); pours acid (38.5); holds it tilted (40–50). **P2:** pours each loop; shoves Hero (8.3); turns ≤40° to pose (17.7); turns away (22.1); pours water (25.8); checks his selfie (27.4); taps for a selfie (42.3) | Phone, left hand (always). Bottle, right hand |
| Mia | Classmate in danger, the pencil lender | Teen R15, skin #EBCBB2 | REUSE | Happy, Shocked, Worried, Smiling | none | Turns her head (23.3); slides the pencil (24.8); leans in to watch (37.2); shards freeze at her face (48.9–50). **P2:** asks "why now?" (32.3); smiles (38.2); slides the pencil again (40.7); laughs (48.3) | Pencil (slid along the bench) |
| Teacher | Chemistry teacher | Adult R15, skin #EFD5B8 | REUSE | Happy | none | Writes on the chalkboard, back turned (21, 43.2). Doesn't see anything | none |
| Grandma | Spent her taps on herself | Elder R15, skin #F3D9C8, plum cardigan rgb(142,99,141) | REUSE | Sad, Crying | Fully aged, shaking hands | Taps repeatedly (15.3); hand shakes and drops from LittleHero's (17.4); trembling hands (P1 47.8, P2 44.5) | none |
| LittleHero | Hero as a small kid (flashback) | Kid scale R15 | REUSE | Crying | none | Reaches for Grandma's hand, which drops (17.4) | none |
| Extra1..6 | Students | Dressed HumanoidDescription (assets/rigs/bystanders_school.luau), 3-layer face decals (Extra*_Neutral) | REUSE | Neutral, Happy, Shocked | Extra3's hand ages (4.5) | Extra1 drops the phone and rewinds it (6.7); Extra2's milk flows back into the cup (6.7); Extra3 taps and ages (4.5); Extra5/6 walk into class (21); Extra1/2 turn away from Hero (25.9) | Phone2 (Extra1), MilkCup (Extra2) |

## D. Assets & meshes
| # | Engine name | What | Size | Material · colour | Animated sub-parts | CanQuery | Placement / socket | Beats | Source |
|---|---|---|---|---|---|---|---|---|---|
| 1 | PR.Acid | Same-shape bottle with a red label | ~0.5×1.2 | Glass with a red label | label highlight (F.hl) | yes | bench A0 → Jace's RightHand (HOLD_OFF) | P1 30–50, P2 all | REUSE (engine, kit AcidBottle.obj ref) |
| 2 | PR.Water | Same bottle, plain | same | Glass | — | yes | bench W0 → swap arc | P1 30, P2 14, 23.8 | REUSE |
| 3 | PR.Beaker | Beaker with Glass, Liquid and Rim | 1.4 h × 1.0 d | Glass, green liquid, white rim | liquid glow, 5 Crack neon lines | yes | bench B0 | P1 38–50, P2 0–9 | REUSE |
| 4 | SH[1..12] | Glass shard needles | 0.05×0.07×0.45 | alternating Neon/Glass | fly toward Mia's face, freeze | no | spawned at the beaker | P1 44–50, P2 0–3 | v3 |
| 5 | PR.Phone | Jace's phone with Flash light | small | black | flash PointLight ≤2.5 | no | Jace LeftHand (PHONE_OFF) | everywhere | REUSE |
| 6 | PR.Phone2 | Dropped phone | small | — | flies back up into the hand | no | Extra1 RightHand | P1 6.7 | REUSE |
| 7 | PR.Cup | Red milk cup with Rim and Milk | 0.85 h × 0.58 d | red, white rim, white milk | milk stream, puddle | yes | Extra2 RightHand × CF(0,−0.68,−0.58) | P1 6.7 | v3 |
| 8 | PR.Pencil | Yellow pencil with eraser | 0.14×1.3 | yellow, pink eraser | slides along the bench | yes | bench → Hero RightHand (PENCIL_OFF) | P1 24.8, P2 40.7–51 | REUSE |
| 9 | CLK | Wall clock | 2.8 d | black rim | hands spin backward (−900°/s), tick | — | chalkboard wall | P1 3.1, P2 37 | REUSE |
| 10 | PR.Ripple | Tap ring | 0.05 thick, 0.3→1.6 d | Neon blue | expands and fades + 26 sparkle particles (0.14) | no | at the tapping hand | every tap | v3 |
| 11 | S7AgeVein* | Dorsal vein lines (3 per hand) | 0.28×0.032×0.032 | dark brown | fade in with age | no | welded inside Hero/Jace hands | all aging | v3 |
| 12 | PR.Streaks (8), Smoke (4), Stream, MilkStream, Puddle, Fade, Fill | VFX parts | — | Neon / white | see F | no | — | — | REUSE |
| Faces | ServerStorage.ApprovedFaces (main cast), Extra1..6 decals rbxassetid 131430446387323 / 90546557382270 / 131213930194529 / 138853253386211 / 96503360762037 / 97242020936817 | | | | | | | | REUSE + v3 |
| SFX | assets/sfx: whoosh, rewind_zip, skin_creak, shutter, ding, tick, piano_note, bell, glass_clink, pour, hiss_crack, thud | | | | | | | | REUSE (pipeline/make_sfx.py) |

## E. Animations (engine helpers, driven per frame)
| Name | Who | Description | Type |
|---|---|---|---|
| tapPose(r, k, tap, tremble) | Hero, Grandma, Extra3, Jace | Left forearm raised across the chest, right index finger hovers, then taps at `tap` (0→1 spike over 0.07); optional tremble | one-shot / loop |
| selfie(r, k) | Jace | Left arm raised with the phone at the face, head tilted | hold |
| reach(r, side, k, yaw) | all | Arm extends forward toward the bench | one-shot |
| hold(r, k, tilt) | Jace | Bottle in RightHand; tilt 0→95° pours | hold |
| lean(r, k) | Mia | Upper torso leans toward the beaker; negative values lean back | hold |
| arm(r, side, pitch, yaw, roll) / P(r, joint, ...) | all | Direct joint angles (head turns, shove, sleeves) | per beat |
| fist(r, k) | Hero | Hand closes | one-shot |
| walk(r, L, speed) | Extra5/6 | Bob plus leg swing | loop |
| labStand(r, x, yaw) / place(r, x, z, yaw) | all | Position and yaw on the marks (face shots yaw ≤40°) | — |
| applyFaces / setAge | all | Face swaps from ApprovedFaces; vein + tint aging | — |

## F. VFX
| Name | Trigger | Look | Duration | Limits |
|---|---|---|---|---|
| Grade switch | `g` per beat; P1 0.3 tap → G.r | n warm / r cyan / s sepia | per beat | — |
| Ripple ring + burst | every tap | thin blue ring + 26 particles | 0.3 s | never covers the face |
| Rewind streaks | P1 3.1 clock, 6.7 hallway; P2 2.5 rewind | 8 neon streaks spiralling backward | beat | — |
| Clock spin / tick | P1 3.1, P2 37 | hands spin back, then one tick | beat | — |
| Pour stream | P1 38.5; P2 4.6, 8.3, 25.8 | green neon (acid) / pale (water) cylinder | 0.5–1 s | — |
| Smoke | acid in the beaker | 4 pale balls rising | until the rewind | not over Mia's face |
| Crack | P1 40.3 | 5 neon lines grow across the beaker | 1.7 s | — |
| Shards | P1 44.3–50, P2 0–2.5 | 12 needles fly toward Mia, freeze at 0.72–0.8 | — | fly in from the side, never over the face |
| Phone flash | selfies | PointLight + screen brighten | 0.15 s | brightness +0.04, bloom +0.12, light 2.5, range 8 |
| Shake | taps, crack, shove | camera jitter 0.3–1.5 | beat | — |
| Aging | P2 taps | veins + tint, 0.25 per tap | instant on the tap | flush with the hand |
| Bloom swell | P2 38.2–51 | warm bloom 0.4–0.6 | — | — |
| Fade | P2 only, after the voice | black in the 0.4 s tail | 0.4 s | P1 never fades |

## G. Beat-by-beat director table
Face = the expression on the visible face. Grade n/r/s = G.n/G.r/G.s.

### Part 1
| # | t | Line | Captions | Shot | Characters do | Faces | Props | VFX | SFX | Grade |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 0.00–3.14 | In my world, tapping your wrist rewinds any mistake | IN MY / WORLD, TAPPING / YOUR WRIST / REWINDS ANY / MISTAKE | Hero faceCam push-in (FOV 55), cut at 58% to camHand insert | Hero raises wrist, taps at 0.3 | Hero Determined → Shocked after the tap | — | ripple, shake 0.8 | whoosh | n→r |
| 2 | 3.14–4.48 | by ten seconds. | BY TEN / SECONDS. | Wall clock macro, dolly-in FOV 40 | — | — | clock spins −900°/s | streaks | rewind_zip | r |
| 3 | 4.48–6.68 | But your hands age one year every time. | … | Hand insert on Extra3, cut at 50% to a closer one | Extra3 taps ×3, hand ages | Extra3 Shocked | — | ripple loops, age 0→1 | skin_creak | r |
| 4 | 6.68–9.66 | Kids rewind dropped phones and spilled milk. | … | Hallway wide FOV 50, cut to milk insert FOV 45 | Extra1 grabs the falling phone; Extra2's milk returns | extras Happy | Phone2 flies up, milk flows back into the red cup | streaks | rewind_zip | r |
| 5 | 9.66–11.30 | Jace rewinds bad selfies | … | Jace faceCam | Jace selfie, turns −35° | Jace Smirk | phone | flash at 55% | shutter | n |
| 6 | 11.30–13.18 | he has thirty-year-old hands. | … | Both hands insert FOV 40 | Jace holds both hands out | — | — | aged veins visible | skin_creak | n |
| 7 | 13.18–15.26 | Mine are fifteen. Zero taps. | … | Two-hand insert, cut at 50% to Hero faceCam | Hero and Jace show hands | Hero Worried | — | — | — | n |
| 8 | 15.26–17.40 | My grandma spent her taps on herself, | … | Grandma room wide, cut to Grandma face | Grandma taps ×4 | Grandma Sad | — | ripples | piano_note | s |
| 9 | 17.40–19.84 | her hands shook too hard to hold mine. | … | Two-hand close, cut at 55% to LittleHero face | Grandma's hand shakes and drops; LittleHero reaches | LittleHero Crying | — | — | piano_note | s |
| 10 | 19.84–20.96 | So I saved mine. | … | Hero faceCam | Hero makes a fist | Hero Determined | — | — | — | n |
| 11 | 20.96–23.34 | Then chemistry class, last period. | … | High establishing crane over the lab, FOV 60 | Extra5/6 walk in; Teacher writes | — | — | — | bell | n |
| 12 | 23.34–24.78 | Mia sits beside Jace. | … | Mia faceCam | Mia turns her head 18° | Mia Happy | — | — | — | n |
| 13 | 24.78–25.92 | She once lent me a pencil | … | Medium across the bench, FOV 48 | Mia slides the pencil | Mia Happy, Hero Happy | pencil −16.2 → −19.2 | — | ding | s |
| 14 | 25.92–27.38 | when nobody else would talk to me. | … | Hero medium | Extra1/2 turn their backs; Hero lowers his head | Hero Sad | — | — | — | s |
| 15 | 27.38–30.44 | Jace was showing off for his phone, as always. | … | Jace faceCam, cut at 50% to the other side (FOV 42) | Jace selfie, sways, tilts head | Jace Smirk | phone | flash at 60% | shutter | n |
| 16 | 30.44–33.06 | Two bottles, same shape, side by side. | … | topInsert on the bottles, cut at 55% to Hero face | Hero eyes the bottles | Hero Worried | bottles | — | glass_clink | n |
| 17 | 33.06–35.78 | Red label is acid. Plain one is water. | … | Two low bottle inserts FOV 34 | — | — | acid highlight, then water highlight | — | — | n |
| 18 | 35.78–37.22 | He grabbed the red one. | … | Jace faceCam (low aim) | Jace reaches and grabs the acid; Hero turns his head | Jace Smirk | acid in hand | — | — | n |
| 19 | 37.22–38.46 | Mia leaned in to watch. | … | Mia eyeCam | Mia leans in | Mia Happy | — | — | — | n |
| 20 | 38.46–40.34 | He poured. The beaker hissed. | … | Pour from above, cut at 55% to Mia eyeCam | Jace tilts 95° | Mia Shocked | stream | smoke | pour, hiss_crack | n |
| 21 | 40.34–43.20 | The glass cracked, bulging toward her face. | … | Crack insert, cut at 50% to Mia eyeCam | Jace eases the tilt to 40° | Mia Shocked | crack 0→1, liquid glow | shake 0.5 | hiss_crack | n |
| 22 | 43.20–44.34 | Nobody else saw it. | … | High whip-pan from the teacher to the bench FOV 55 | Teacher writes, back turned | — | — | shake | tick | n |
| 23 | 44.34–46.34 | My finger hovered over my wrist. | … | Hand insert, cut at 50% to Hero face | Hero's finger trembles | Hero Worried | shards 0.4 | — | tick | r |
| 24 | 46.34–47.82 | Fifteen years of saving. | … | Hero tight faceCam | Hero trembles | Hero Straining | shards 0.45 | — | tick | n |
| 25 | 47.82–48.96 | One tap breaks it. | … | Grandma's shaking hands | Grandma trembles | Grandma Sad | — | — | piano_note | s |
| 26 | 48.96–49.56 | Do I spend it | … | Mia, shards approaching | — | Mia Shocked | shards 0.5→0.72 | — | hiss_crack | n |
| 27 | 49.56–50.05 | on her? | ON HER? | Hold on Mia, shards frozen beside her face. **HARD CUT** | — | Mia Shocked | shards 0.72→0.8 | — | whoosh | n |

### Part 2
| # | t | Line | Shot | Characters do | Faces | Props | VFX | SFX | Grade |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 0.00–1.62 | Fifteen years of saving. | Hero tight face (hook) | finger trembles | Hero Straining | acid held, crack, shards 0.72 | smoke | hiss_crack | n |
| 2 | 1.62–2.54 | One tap. | Hand close, FOV 46→38 | taps (age → 0.25) | — | same | ripple, shake 1.2 | rewind_zip | r |
| 3 | 2.54–4.56 | Ten seconds back, before the pour. | Bench rewind wide, cut to Hero face | Jace un-pours; Mia leans back | Hero Determined | crack and shards reverse | streaks | rewind_zip | r |
| 4 | 4.56–6.66 | I yelled. He poured anyway. | Hero face (yelling), cut to pour from above | Hero arms out; Jace pours | Hero Shocked | stream | shake, smoke | hiss_crack | n |
| 5 | 6.66–7.12 | Tap. | tapBeat close | taps (0.5) | — | — | ripple | rewind_zip | r |
| 6 | 7.12–8.28 | I grabbed his arm. | Raised two-shot FOV 45 (clearShot) | Hero steps in and grabs | Hero Determined, Jace Shocked | — | shake 0.7 | — | n |
| 7 | 8.28–9.90 | He shoved me, and poured. | Two-shot | Jace shoves; Hero staggers back; pour | Jace Smirk | stream | shake 1.4 | thud, pour | n |
| 8 | 9.90–12.00 | Tap. My knuckles started to wrinkle. | camHand, cut at 60% to Hero face | taps (0.75) | Hero Crying | — | ripple, veins | skin_creak | r |
| 9 | 12.00–14.22 | So I stopped fighting and started watching. | Hero face (side −0.6) | steps back, eyes turn | Hero Determined | — | — | tick | n |
| 10 | 14.22–16.14 | Water bottle, left of the acid. | Hero POV on the water bottle FOV 32 | — | — | water highlighted | — | tick | n |
| 11 | 16.14–17.72 | He pours with his right hand. | Front insert on Jace's hand (clearShot) | Jace reaches and grabs | Jace Smirk | acid | — | tick | n |
| 12 | 17.72–20.72 | At second seven, he turns to pose for his phone. | Jace faceCam, then the other side | turns ≤40°, selfie | Jace Smirk | phone | flash at 85% | shutter | n |
| 13 | 20.72–22.08 | Tap. Last loop. | tapBeat | taps (1.0) | Hero Straining | — | ripple | rewind_zip | r |
| 14 | 22.08–23.76 | I waited. He turned. | Hero face | Jace turns 150°; Hero's eyes follow | Hero Determined | — | — | — | n |
| 15 | 23.76–25.84 | Flash. I swapped the bottles. | Steep topInsert FOV 40 | Hero swaps with both hands | — | bottles arc and swap | flash at 8% | shutter | n |
| 16 | 25.84–27.40 | He poured water. Nothing happened. | Pour from above | Jace pours the water | — | water stream | — | pour | n |
| 17 | 27.40–30.26 | Jace checked his selfie, never the beaker. | Jace face, cut to two-shot | Jace looks at the phone | Jace Happy, Hero Happy | — | flash | shutter | n |
| 18 | 30.26–32.30 | I pulled my sleeves over my hands. | Hands low with the face above, FOV 42 | Hero pulls his sleeves | Hero Sad | — | aged hands | — | n |
| 19 | 32.30–35.14 | Mia saw them anyway. You never tap. Why now? | Mia face, cut at 55% to Hero face | Mia looks; Hero is caught | Mia Worried, Hero Sad | — | — | thud | n |
| 20 | 35.14–36.98 | Four taps. Four years. | camHand | 4 quick taps, age stepping up | — | — | ripples, flash 0.6 | — | n |
| 21 | 36.98–38.22 | For ten seconds. | Clock close | — | — | clock ticks once | — | tick | r |
| 22 | 38.22–40.70 | Mia smiled at me, her face perfect, | Mia faceCam (far side, FOV 38) | Mia smiles | Mia Happy | — | bloom 0.5 | — | n |
| 23 | 40.70–42.32 | and lent me a pencil again. | Medium across the bench | Mia slides the pencil | Mia Happy, Hero Happy | pencil | bloom | ding | n |
| 24 | 42.32–44.48 | Jace spends his years on selfies. | Jace face (hand low) | Jace taps, then selfie | Jace Smirk | phone | ripple, age 0.85, flash | shutter | n |
| 25 | 44.48–46.72 | Grandma spent hers on her own mistakes. | Grandma's hands, then her face | trembles | Grandma Sad | — | fill ≤0.8 | piano_note | s |
| 26 | 46.72–48.28 | I spent mine on someone else. | Hero face (pencil low) | holds the pencil | Hero Happy | pencil in hand | bloom | piano_note | n |
| 27 | 48.28–50.14 | A few years of my hands for her whole face. | Two-shot arc | Mia laughs | Mia Happy, Hero Happy | pencil | bloom | piano_note | n |
| 28 | 50.14–51.55 | They were saved for her. | Hero face easing out to a wide of the three | Hero rests his wrist | Hero Happy | — | bloom 0.6, **stays bright**; fade only after 51.55 | piano_note | n |

Caption chunks for every beat come from `pN/subs.ass` (script-locked, 1–3 words, function words carried to the next card).

## H. Pre-render QA checklist
- [x] Every beat has a camera, actions and faces (table above)
- [x] No cloned or bare extras; extras have 3-layer faces (v3)
- [x] Occlusion guard = Spherecast 0.52 (v3)
- [x] Flush veins, thin ring, needle shards, cup outside the hand (v3)
- [x] Captions script-locked
- [x] P1 hard cut on Mia; P2 bright to the last word
- [ ] Beat sheets rec/v3/qa_p1.png / qa_p2.png reviewed (after recording)
- [ ] Argon handover: not needed (assets pre-date Argon)
