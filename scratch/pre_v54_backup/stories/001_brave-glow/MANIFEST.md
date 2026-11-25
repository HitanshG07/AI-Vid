# 001 — The Glow You Get for Being Brave — PRODUCTION MANIFEST
<!-- Engine: engines/roblox/story001_cutscene.luau (_G.Story001). Cast: engines/roblox/cast_001.luau (ServerStorage.Cast001).
     All times are REAL audio seconds from words.json (voice.mp3 = 52.1 s). Video time = audio + 0.3 s lead. -->

## A. Story meta
- **Format:** Standalone, Part 1 of 1 · 52.1 s audio + 0.3 s lead + 0.8 s held last image ≈ 53.2 s · 165 words · 30 fps · 1080x1920 · 48 beats (beats.json revision 1)
- **World rule:** the first time you are truly brave, your outline glows gold forever (gold Highlight outline on the person).
- **Twist:** the brightest glow, Rosa the lifeguard, got hers by screaming for help while too scared to swim; Kai ignites the same way, by ringing the shore bell instead of swimming.
- **Core meaning:** courage isn't being fearless; it's doing the right small thing while you're still scared.
- **Ending plan:** standalone, everything resolves. Last image (Kai + Milo glowing on the pier, bell swinging behind) holds 0.8 s. No fade, no black hold.
- **Freshness combo:** light/shadow (emotion made visible) · courage · beach town
- **Hashtags:** #roblox #robloxstory #brave #shorts #storytime
- **Verification:** ledger/verification/001.md (PASS)

## B. Sets & lighting
One physical set (workspace.Set_Beach001, already built), dressed four ways by grade preset.

| Field | Value |
|---|---|
| Set name | `Set_Beach001` (Props, Huts) · REUSE (built in Studio 2026-11-17) |
| What it looks like | Sand beach sloping into open Terrain ocean toward −X; wooden pier with handrails running out to sea, bronze shore bell on a post at its far end; two white/red lifeguard towers; striped umbrellas, towels, beach ball, cooler; row of colourful beach huts and a boardwalk as the inland backdrop. Present-day small beach town. |
| Origin / extents | Sand y = 8.02 for x ≥ 602; shoreline slope x 580–600; Terrain water surface y = 5.4 for x < ~600 to the horizon. Huts along x = 745, z −560…−274; boardwalk x = 733. |
| Key surfaces | Pier: planks x 548→606 at z = −380, deck top y = 8.6, width 7, handrails z −383.2 / −376.8 (top y 11). Bell hinge (550.5, 15.2, −380) (attr HingeY); child model `Swing` (PrimaryPart `Cup`) rotates about Z; `Rope` hangs to ~deck height. Tower_Rosa centred (630, −410); Tower_Far centred (630, −500), ~33×18×18, platform ~10 above sand. |
| Prop placements | Umbrella_1 (660, −385) · Umbrella_2 (676, −440) · towels x 646–664, z −364…−376 · BeachBall (645, 8.8, −372) · Cooler (652, 8.7, −366) · engine Crate (609.3, sand+1, −405) and Lantern (611.3, sand+0.6, −407) only in tower_night |
| Character marks | Engine `ST` table (x, z, yaw; yaw 0 faces −Z, 90 faces the sea −X, −90 faces inland +X): **beach** Kai 620,−386,90 · Milo 622.5,−389.5,90 · Rosa 611,−414,90 · E1 626,−378,180 · E2 629,−395,0 · E3 650,−371 sit · E4 656,−366 sit · E5 641,−375,−90 · E6 648,−375,90. **storm** Kai 603,−390,90 · Milo float 594,−392,−90 · Rosa 618,−399 · E1–E5 huddle x 624–631, z −399…−408. **night** Rosa on crate 609,−405,90 · Kai 605.5,−400,−35. **flash** YoungRosa 604,−440,90 · E3 float 566,−446 · E1 624,−436 · E2 626,−444. **climax** Kai 603,−364,90 · Kid float 586,−372 · Rosa 612,−492,0 · E1 612,−503,180 · E2 615.5,−505,180 · E3/E4 towels · E5 pier 562,−382.4,90 · E6 pier 586,−377.6,180 · Milo 640,−372. **finale** Kai 598,−380,−90 · Milo 599.6,−380,90 · Rosa 604.5,−374.5 · Kid sit 607,−370.5,90 · E1–E4 crowd x 612–615.5, z −366.5…−375.5 · E5/E6 on pier. |
| Grade: sunny_beach | ClockTime 16.8 (lerps to 17.5 over beats 45–48) · Brightness 2.4 · Exposure 0 · OutdoorAmbient 140,130,120 · Grade tint 255,240,222, Sat +0.12, Contrast +0.08, Bright +0.02 · Atmosphere D 0.28 H 1.2 colour 205,225,245 · Bloom 0.5 · SunRays 0.08 |
| Grade: stormy_beach | ClockTime 15.0 · Brightness 0.7 · Exposure −0.3 · Ambient 95,105,120 · tint 185,200,225, Sat −0.4, Con +0.14, Bright −0.04 · Atmosphere D 0.55 H 3 colour 130,140,155 · Bloom 0.3 · SunRays 0 · rain ON (700/s) |
| Grade: tower_night | ClockTime 21.0 · Brightness 0.5 · Exposure +0.2 · Ambient 60,70,100 · tint 175,195,255, Sat −0.1, Con +0.1 · Atmosphere D 0.35 H 0.5 colour 40,50,80 · Bloom 0.6 · lantern PointLight 255,190,110, range 16, brightness 2.2 |
| Grade: flashback_beach | ClockTime 16.8 · Brightness 2.0 · Ambient 140,125,105 · tint 255,222,175 (sepia), Sat −0.65, Con +0.06 · Atmosphere D 0.3 H 1.5 colour 220,200,170 · Bloom 0.4 · SunRays 0.05 · camera-attached black edge bars at 45% transparency (vignette) |
| DOF / focus | Lighting.DOF on: focus = shot target, in-focus radius 2, near 0.4, far 0.45 (background beach softly blurred) |
| Ambient sound bed | waves + gulls (sunny) −28 dB; heavy surf + rain (storm) −24 dB; crickets + soft waves (night) −30 dB; muffled reversed bed (flashback) −30 dB |
| Rule visibility | Gold outline (Highlight, OutlineColor 255,200,60, FillTransparency 1, DepthMode Occluded) on every on-stage character except Kai until 39.75 s and YoungRosa until 24.9 s. Every beat frames at least one glowing character next to unlit Kai, except the pure bell insert opening beat 27/45 and the first 0.35 s of beat 38. |

All grade/Lighting values are restored by `resetCamera()` (originals snapshotted at first setup).

## C. Characters
Faces for everyone: `assets/faces/classic_v1/ids.json` (neutral 70950815478959, scared 94514852927815, shocked 103057607693548, grin 96253429845051, determined 109687999939498, proud 96477668083717) via `Cast001.setFace`. Rig R6, built by `Cast001.build` into workspace.Cast_001. Heights: adults ≈ 5.27, Milo/Kid ≈ 4.04 (scale 0.75), YoungRosa ≈ 4.25 (scale 0.85).

| Engine name | Role | Catalog items (R6) | Skin | Emotions needed | What they do (audio s) |
|---|---|---|---|---|---|
| **Kai** | narrator, 16, never lit | shirt 86330417861158 · pants 12671481024 · hair 98588731108499 | #EABE96 | shocked, neutral, scared, determined, proud, grin | 0.0 stares at own hands · 1.4–6.8 stands in crowd, looks down · 8.5 turns to Milo · 9.5 freezes · 10.7–16.5 frozen at shoreline in storm · 19.4 stands back · 20.6 looks down at seated Rosa (night) · 27.4 listens · 33.6 steps back from water · 34.8 turns to pier · 35.8 sprints down pier (26 studs/s) · 37.8 reaches rope, arms up · 38.0 pulls rope (bell) · 39.4 looks at his hands, **ignites 39.75** · 40.4 looks up, proud · 43.9 opens arms, hugs Milo · 46.6 stands with Milo · 48.2 faces camera · 49.8 arm round Milo · 50.5 stands tall |
| **Milo** | little brother, glowing | shirt 139637579996070 · pants 124776138615892 · hair 94946081980224 · waist 7172656303 (duck floaty) | #EABE96 | grin, scared, shocked, proud | 6.8 waves with floaty · 8.5 grins up at Kai · 10.7 floats near shore · 11.9–19.4 drifts seaward x 594→566 (4.2 studs/s), waves both arms, reaches, screams · 19.4 dragged ashore seated, coughing · 43.9 runs along pier and hugs Kai · 46.6–50.5 stands beside Kai, looks up |
| **Rosa** | lifeguard, brightest glow | shirt 133484080647039 · pants 17824126134 · hair 82307426197865 · neck 28672417 (whistle) | #B07C5C | neutral, determined, scared, proud, grin, shocked | 16.5 sprints past Kai · 17.5 runs into surf · 18.6 swims (crawl) · 19.4 walks backwards towing Milo · 20.6–21.0 sits on crate, hands trembling · 26.7–27.4 turns to Kai, proud smile, still trembling · 31.7 at Tower_Far facing away, head turned down beach · 32.6 waves at tourists, back to camera · 38.5 turns toward the bell, whistle to mouth · 41.6 swims toward the kid · 42.5 stands beside the rescued kid |
| **YoungRosa** | Rosa as a child (flashback) | shirt 91467779965025 · pants 13979853518 · hair 82307426197865 | #B07C5C | scared, determined | 22.1 frozen at waterline · 23.2 steps back · 24.4 waves both arms, yells, **ignites 24.9** · 25.4 points at the water |
| **Kid** | swept-out child | shirt 9583523089 · pants 140104955076438 · hair 94946081980224 | #CD966E | scared, shocked, grin | 28.5–41.6 floats north of pier (z −372), drifts x 586→566 (1.5 studs/s), waves arms, reaches · 42.5 sits on sand, safe |
| **E1** | beachgoer / surf runner / tourist | shirt 17424992678 · pants 13864024636 · hair 138332213451880 · face acc 132447033477670 | #F5CDAA | grin, determined, scared | walks past (0–6.8) · runs into surf (2.0) · huddles in storm · flashback adult running to water (25.4) · tourist waving at Rosa (32.6) · claps (42.5) |
| **E2** | beachgoer | shirt 8836645430 · pants 14262996290 · hair 140624854156017 · hat 14873143034 | #E6B98C | grin, scared, determined, shocked | walks past · huddles · flashback runner · tourist · stands beside Kai shocked (34.8) · claps |
| **E3** | sunbather / flashback swimmer | shirt 78421295651694 · pants 12574395860 · hair 71343213020367 · hat 12400948539 | #966446 | grin, scared | sits on towel · huddles · struggling swimmer waving (22.1–26.7) · claps |
| **E4** | sunbather | shirt 85435724220934 · pants 18332980667 · hair 17890789000 | #F0C8A0 | grin, scared | sits on towel · huddles · claps |
| **E5** | ball player / pier fisherman | shirt 93684471979859 · pants 89518846190037 · hair 74528752688799 | #E1AF87 | grin, scared, shocked | waves (3.2), tosses ball (5.7) · huddles · on pier, covers ears at the bell (38.0) |
| **E6** | ball player / pier walker | shirt 7817471255 · pants 12068155904 · hair 84948868072722 | #6E4B37 | grin, shocked | waves, tosses ball · turns to watch Kai sprint (35.8) · covers ears (38.0) |

Body states: wet look not modelled. Held props: none welded (rope is grabbed by pose only; floaty is Milo's waist accessory).

## D. Assets
| # | Engine name | What | Size (studs) | Material · colour | Animates | CanQuery | Placement | Beats | Source |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Set_Beach001 terrain/sand | beach + ocean | see B | Sand / Terrain water | no | yes | — | all | Studio-built |
| 2 | Props.Pier | wooden pier + handrails | 58 × 7, deck y 8.6 | wood | no | yes | x 548–606, z −380 | 27–29, 34–36, 38–48 | Studio-built (replaced Creator Store dock 120429166951383, which carried hidden scripts) |
| 3 | Props.ShoreBell (Swing/Cup, Rope) | shore bell on post | hinge y 15.2 | bronze / rope | Swing rotates about Z at hinge: 25°·e^(−0.12s)·sin(4.2s) from 37.6 s | — | (550.5, −380) | 27, 35–39, 45, 48 | Studio-built |
| 4 | Props.Tower_Rosa, Tower_Far | lifeguard towers | ~33×18×18 | painted wood | no | — | (630, −410), (630, −500) | 15–20, 25–26, 30–31, 37 | Creator Store 10969289501 |
| 5 | Props.Umbrella_1/2 | beach umbrellas | ~10 | cloth | no | — | (660, −385), (676, −440) | 1–9 | Creator Store 9017391415 |
| 6 | Props.BeachBall | ball | ~1.5 | plastic | arcs between E5/E6 hands (beat 6) | — | (645, 8.8, −372) | 6 | Studio-built |
| 7 | Props.Cooler, towels | beach dressing | — | — | no | — | x 646–664 | 1–9, 27+ | Studio-built |
| 8 | Huts + boardwalk | backdrop | — | painted wood | no | — | x 733–745 | inland shots | Studio-built |
| 9 | Story001FX.Crate | Rosa's seat at night | 2.2×2×2.2 | WoodPlanks 140,100,60 | no | no | (609.3, sand+1, −405) | 19–20, 25–26 | engine |
| 10 | Story001FX.Lantern | lantern + PointLight | 0.8×1.2×0.8 | Neon 255,190,110 | light on at night | no | (611.3, sand+0.6, −407) | 19–20, 25–26 | engine |
| 11 | Milo waist accessory | duck floaty | catalog | — | follows Milo | — | waist | 7–18, 42–48 | catalog 7172656303 (check it reads as a floaty) |
| 12 | Rosa neck accessory | whistle | catalog | — | — | — | neck | all Rosa beats | catalog 28672417 |
| 13 | Glow001 (Highlight per rig) | world-rule outline | — | 255,200,60 | see F | — | each model | all | engine |

- Faces: 6 classic_v1 decals (ids in C), applied as Head `face` decal.
- Textures/decals: none. Captions burned in later by the pipeline (no on-screen text in Studio).
- SFX: synthesised into assets/sfx by pipeline/make_sfx.py (2026-11-17); all beats.json names exist except `scream_child` (beat 13) and `giggle` (beat 7), which are still missing.
- Music: soft swell from 43.9 s, end chime 51.4 s ("anyway").

## E. Animations (Motor6D C0 = live base × offset each frame, Edit mode)
| # | Name | Who | Description | Loop | Beats |
|---|---|---|---|---|---|
| 1 | idle | all on stage (not `still`) | RootJoint lean ±1.5° @1.7 Hz-ish, twist ±3°; neck nod ±2°, drift ±8°; arms ±3° fwd, 4° out | loop | all |
| 2 | still (freeze) | Kai 9, 14, 15; YoungRosa 21 | idle suppressed | hold | 9, 14, 15, 21 |
| 3 | walk | extras, Rosa (backwards tow) | hips ±25° @ 7 rad/s, arms ∓20° | loop | 1, 2, 5, 18 |
| 4 | run | E1, Rosa, Kai, Milo, E1/E2 flashback | hips ±55° @ 15 rad/s, arms ∓44°, torso lean 12° | loop | 3, 15, 16, 24, 34, 35, 42 |
| 5 | swim | Rosa | model pitched −80° at water y+0.25; arms rotate full circles 7 rad/s alternating; flutter kick ±15°; head up 50° | loop | 17, 40 |
| 6 | float | Milo, Kid, E3 | upright, torso centre at water+0.2·scale, bob ±0.15–0.2, leg kick ±10° | loop | 10–18, 21–24, 27–33 |
| 7 | wave (one arm) | E5, E6, Milo, Rosa, E1 | shoulder fwd 165°, out 20±18° @ 11 rad/s | loop | 4, 7, 31 |
| 8 | bothWave | Milo, Kid, E3, YoungRosa | both arms 160°, out 25±20° | loop | 12, 14, 17, 21–23, 28, 32 |
| 9 | lookHands | Kai | arms fwd 60°, in 12°, head down 30° | hold | 1 |
| 10 | turn | Kai, Rosa | yaw lerp (shortest way) over first 30–45% of beat | one-shot | 8, 33, 37 |
| 11 | point | YoungRosa | right arm fwd 90° | hold | 24 |
| 12 | reach | Milo, Kid | arm fwd 110–120° | hold | 13, 29 |
| 13 | huddle | E1–E5 | arms fwd 60°, in 35°, head down 10° | hold | 16 |
| 14 | tow | Rosa / Milo | Rosa arms fwd 70° walking backwards x 598.5→605; Milo seated 2.4 studs seaward, torso coughs 15–25° @ 8 rad/s, arm up | one-shot | 18 |
| 15 | sit / crate | E3, E4, Kid, Rosa | hips fwd 90° (sit drops 2·scale; crate keeps standing height on the 2-stud crate) | hold | 1–9, 19–20, 25–26, 41+ |
| 16 | tremble (hand_tremble) | Rosa | hands in lap (arms fwd 35°, in 18°) + 3° @ 45–53 rad/s jitter | loop | 19, 20, 26 |
| 17 | grab + pullRope | Kai | arms 160° (grab), then 165°−45°·max(0, sin 7t) pulls | loop | 35, 36 |
| 18 | ears | E5, E6 | both arms 170°, out 25° | hold | 36 |
| 19 | whistle | Rosa | right arm fwd 150°, in 35° after 30% of beat | hold | 37 |
| 20 | hug | Kai, Milo | both arms fwd 85°, in 30°; heads tilt 10° / −15° | hold | 42–45 |
| 21 | clap | E1–E4 | arms fwd 80°, out 22−22·|sin 12t| | loop | 41 |
| 22 | arm round | Kai | left arm fwd 15°, out 55° over Milo; Milo head up 20°, turned 25° | hold | 47 |
| 23 | bell swing | Swing model | see D3 | decaying | 35–48 |

## F. VFX
| # | Name | Trigger | Look | Duration | Limits |
|---|---|---|---|---|---|
| 1 | gold outline (rule) | always | Highlight outline 255,200,60, fill off | — | ≤ 11 Highlights (cap 31) |
| 2 | gold_outline_shimmer | beats 1, 2, 4, 6, 39, 42–48 | OutlineTransparency 0.12±0.12 @ 7 rad/s, per-rig phase | beat | — |
| 3 | gold_outline_bright_rosa | 15, 16, 40 | Rosa outline 255,236,150 + gold fill at 0.85 transparency | beat | — |
| 4 | gold_ignite_pulse | YoungRosa 24.9 s, Kai 39.75 s | outline hot, fill transparency 0.3→1, bloom +0.12 | 0.8 s | bloom cap +0.12 |
| 5 | sparkle_burst | same instants | 45 gold sparkles, speed 4–8, drag 3, life 0.5–0.9 | one-shot | once per take |
| 6 | rain | stormy_beach (10–18) | 700/s streaks, speed 70–80, 0.08 size, squash 2.5, 60×60 emitter 16 above camera | storm | — |
| 7 | lightning_flash | beat 10 at 25% | Exposure +0.6, grade brightness +0.04, bloom +0.12 (triangular 0.16 of beat) | ~0.18 s | LESSONS caps |
| 8 | splash | 3, 12, 13, 16, 17, 28, 29, 40 | white-blue droplets 70/s, speed 8–14 up, gravity −40 | while active | — |
| 9 | rip_current_foam | 11, 28 | white flecks 40/s drifting −X 4–6 studs/s, life 1.5–2.2 | while active | — |
| 10 | flashback_vignette | 21–24 | 4 black bars at 45% on the frame edges (camera-local, 1 stud) + sepia grade | flashback | subjects centred |
| 11 | bell_shockwave_ring | beat 36 | Neon disc 255,236,150 facing camera, Ø 2→24, transparency 0.5→1 | 0.6 s | — |
| 12 | speed_lines_subtle | beat 34 | 6 white Neon streaks 2.5 long at frame edges, 55% transparent, rushing past | beat | — |
| 13 | lens_flare | beat 39 | SunRays +0.18 | beat | — |
| 14 | camera shake / Dutch | snapZoom beats + 36 | 2.5° Dutch, FOV ×1.4→1 in 0.16 s, noise shake 0.8 decaying 0.25 s | per shot | — |

## G. Beat-by-beat director table (audio s; snapOut = beats.json "pullOut")
Faces listed only for characters in frame. Rule: A = all gold except Kai; B = flashback, YoungRosa unlit until 24.9; C = Kai gold too.

| # | t start→end | Spoken line | Caption | Shot (mode, FOV) | What each character does | Faces | Rule · props | VFX | SFX | Grade |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 0.00→1.40 | In this beach town, | BEACH TOWN | impactZoom, close Kai d4.8 FOV 46 | Kai looks at hands; E1/E2 walk past behind | Kai shocked, E grin | A | shimmer | whoosh_hit (In) | sunny |
| 2 | 1.40→1.98 | the first time | FIRST TIME | snapOut Kai close → wide (596,20,−388) FOV 46→56 | Kai stands; extras mill | Kai neutral | A · umbrellas | shimmer | waves | sunny |
| 3 | 1.98→3.22 | you're truly brave, | TRULY BRAVE | pushIn medium from (603,10.5,−361) FOV 50 | E1 runs x 610→593 into surf | E1 determined | A | splash | splash | sunny |
| 4 | 3.22→4.86 | your outline glows gold. | GLOWS GOLD | pushIn medium two-shot FOV 52 | E5, E6 wave at camera | grin | A | shimmer | chime_soft | sunny |
| 5 | 4.86→5.68 | Forever. | FOREVER | pushIn medium Kai d6.5 FOV 50 | Kai looks down; E1/E2 walk behind | Kai neutral | A | — | — | sunny |
| 6 | 5.68→6.76 | Everyone glows. | EVERYONE GLOWS | snapOut Kai → high wide (596,24,−404) FOV 46→58 | E5/E6 toss ball; E3/E4 sit; Kai small | grin | A · beach ball | shimmer | crowd_beach | sunny |
| 7 | 6.76→8.50 | Even my little brother, Milo. | EVEN MILO | pushIn medium Milo FOV 50 | Milo waves (floaty on) | Milo grin | A · floaty | — | giggle | sunny |
| 8 | 8.50→9.54 | I'm sixteen, | SIXTEEN | pushIn OTS Kai → Milo FOV 45 | Kai turns to Milo; Milo looks up | Kai scared, Milo grin | A | — | — | sunny |
| 9 | 9.54→10.74 | and I've never lit up. | NEVER LIT | impactZoom close Kai d4.6, Milo glowing at edge | Kai frozen | Kai scared | A | — | bass_hit (never) | sunny |
| 10 | 10.74→11.86 | Then the storm came. | STORM CAME | snapOut sky → wide storm FOV 50→56 | Kai at shoreline; Milo floats near shore | Kai scared, Milo grin | A · floaty | rain, lightning @~11.0 | thunder | stormy |
| 11 | 11.86→12.40 | A rip current | RIP CURRENT | pushIn medium Milo from shore FOV 50 | Milo drifts seaward | Milo scared | A | rain, foam | waves_heavy | stormy |
| 12 | 12.40→13.90 | dragged Milo out. | DRAGGED OUT | pushIn wide-ish from (607,13,−384) FOV 48 | Milo waves both arms | Milo scared | A | rain, splash | splash | stormy |
| 13 | 13.90→15.06 | He screamed my name. | MY NAME | impactZoom close Milo d3.9 FOV 46 | Milo reaches to shore | Milo shocked | A | rain, splash | scream_child (screamed) | stormy |
| 14 | 15.06→16.46 | And I froze. | I FROZE | impactZoom close Kai (glowing huddle behind), cut @55% → OTS to glowing Milo FOV 40 | Kai frozen; Milo waves far out | Kai scared, Milo scared | A | rain | heartbeat | stormy |
| 15 | 16.46→17.50 | Rosa, the brightest glow | ROSA | pushIn medium from shallows FOV 52 | Rosa sprints past frozen Kai | Rosa determined, Kai scared | A · whistle | rain, bright Rosa | footsteps_sand | stormy |
| 16 | 17.50→18.62 | on the beach, | BRIGHTEST | snapOut Rosa close → wide (584,18,−378) FOV 46→58 | Rosa runs into surf; extras huddle | Rosa determined, E scared | A | rain, bright Rosa, splash | waves_heavy | stormy |
| 17 | 18.62→19.40 | swam past me | SWAM PAST | pushIn tracking swim FOV 48 | Rosa crawls x 588→577; Milo waves ahead | Rosa determined | A | rain, splash | swim_splash | stormy |
| 18 | 19.40→20.56 | and saved him. | SAVED HIM | snapOut close Milo → wide FOV 46→56 | Rosa tows Milo ashore; Milo coughs; Kai stands back | Rosa determined, Milo scared, Kai scared | A · floaty | rain | waves_heavy | stormy |
| 19 | 20.56→21.02 | I asked how | I ASKED | pushIn two-shot from (600.5,11.6,−401.5) FOV 50 | Rosa on crate, hands trembling; Kai looks down at her | Rosa scared, Kai neutral | A · crate, lantern | tremble | crickets_waves | night |
| 20 | 21.02→22.14 | she got so bright. | SO BRIGHT? | pushIn close Rosa d4.8 FOV 46 | Rosa looks at sea, trembling | Rosa scared | A · lantern | tremble | — | night |
| 21 | 22.14→23.22 | "I didn't swim out. | DIDN'T SWIM | pushIn medium behind-right of YoungRosa FOV 50 | YoungRosa frozen at waterline; swimmer E3 waves far out | YR scared, E3 scared | B (YR unlit) | vignette | whoosh_rewind | flashback |
| 22 | 23.22→24.44 | I was too scared. | TOO SCARED | pushIn close YoungRosa FOV 46 (glowing E1/E2 behind) | YR steps back 2 studs | YR scared | B | vignette | heartbeat | flashback |
| 23 | 24.44→25.40 | So I screamed for help | SCREAMED HELP | impactZoom close YR FOV 46 | YR waves both arms, yells; **ignites 24.9** | YR determined | B → YR gold | vignette, ignite pulse, sparkles | ignite_shimmer (screamed) | flashback |
| 24 | 25.40→26.72 | until someone came." | SOMEONE CAME | pushIn wide-ish (612,13.5,−421) FOV 50 | YR points at water; E1/E2 run into surf | YR scared, E1/E2 determined | B | vignette | footsteps_sand | flashback |
| 25 | 26.72→27.40 | Her glow came | HER GLOW | pushIn OTS Kai → Rosa FOV 44 | Rosa turns to Kai, soft smile | Rosa proud | A · lantern | — | — | night |
| 26 | 27.40→28.50 | while she was shaking. | WHILE SHAKING | snapOut OTS Rosa → Kai → wide two-shot FOV 44→54 | Rosa's hands tremble; Kai listens | Rosa proud, Kai shocked | A | tremble | — | night |
| 27 | 28.50→29.50 | A week later, | WEEK LATER | snapOut bell close → wide pier FOV 40→56 | E5/E6 on pier; E3/E4 sunbathe; Kid starts drifting | E grin, Kid scared | A · bell, pier | — | seagulls | sunny |
| 28 | 29.50→30.50 | a kid got swept out | SWEPT OUT | pushIn medium Kid from beside pier FOV 46 | Kid waves both arms, drifting | Kid scared | A | splash, foam | splash | sunny |
| 29 | 30.50→31.68 | near the pier. | NEAR PIER | pushIn low over water, pier legs behind FOV 48 | Kid reaches, drifts | Kid shocked | A · pier | splash | waves | sunny |
| 30 | 31.68→32.64 | Rosa was far off, | FAR OFF | snapOut Rosa close → wide with Tower_Far FOV 46→56 | Rosa faces away, head turned down beach | Rosa neutral | A · tower, whistle | — | waves | sunny |
| 31 | 32.64→33.56 | looking away. | LOOKING AWAY | pushIn medium behind Rosa FOV 50 | Rosa waves at tourists E1/E2, back to camera | Rosa grin, E grin | A · tower | — | — | sunny |
| 32 | 33.56→34.76 | I couldn't swim out there. | CAN'T SWIM | pushIn close Kai (glowing sunbathers behind), cut @55% → OTS to glowing Kid FOV 40 | Kai steps back 2 studs | Kai scared, Kid scared | A | — | heartbeat | sunny |
| 33 | 34.76→35.80 | But I could run. | BUT RUN | pushIn close Kai d5 FOV 48 | Kai turns to the pier; E2 beside him | Kai determined, E2 shocked | A · pier | — | heartbeat_fast | sunny |
| 34 | 35.80→36.90 | I sprinted down the pier | SPRINTED | pushIn tracking from ahead FOV 50 | Kai sprints x 606→577; E6 turns to watch | Kai determined, E5/E6 shocked | A · pier | speed lines | footsteps_wood | sunny |
| 35 | 36.90→38.00 | and rang the shore bell. | SHORE BELL | pushIn medium (558.5,12.6,−374.6) FOV 48 | Kai runs to rope, grabs it (arms up); bell starts at 37.6 | Kai determined, E5 shocked | A · bell, rope | — | rope_creak (rang) | sunny |
| 36 | 38.00→38.54 | (bell, no words) | DONG | impactZoom low angle at bell FOV 46 | Kai pulls rope; E5/E6 cover ears | Kai scared, E shocked | A · bell swinging | shockwave ring, shake | bell_clang_loud → bell.wav | sunny |
| 37 | 38.54→39.40 | Rosa turned. | ROSA TURNED | snapOut Rosa close → wide FOV 46→54 | Rosa turns toward bell, whistle to mouth | Rosa shocked | A · whistle | — | whistle_blow | sunny |
| 38 | 39.40→40.40 | I looked down. | LOOKED DOWN | pushIn 3/4 close Kai hands+face FOV 44 | Kai holds rope at chest, looks down; **ignites 39.75** | Kai shocked | A → C | ignite pulse, sparkles | ignite_shimmer_big (down) | sunny |
| 39 | 40.40→41.58 | My hands were gold. | HANDS GOLD | impactZoom close Kai FOV 46 | Kai looks up | Kai proud | C | shimmer, lens flare | bass_hit_warm | sunny |
| 40 | 41.58→42.50 | She swam. | SHE SWAM | pushIn tracking swim FOV 48 | Rosa crawls toward kid | Rosa determined | C | splash, bright Rosa | swim_splash | sunny |
| 41 | 42.50→43.94 | The kid was safe. | SAFE | snapOut Kid close → wide crowd FOV 46→56 | Kid sits on sand; Rosa beside; E1–E4 clap; Kai on pier | Kid grin, Rosa grin, E grin | C | — | crowd_cheer | sunny |
| 42 | 43.94→44.46 | Milo hugged me | MILO HUGGED | pushIn medium side of pier FOV 50 | Milo runs x 611→599.6, hugs Kai; Kai opens arms then hugs | Milo grin, Kai grin | C · floaty | shimmer | music_swell | sunny |
| 43 | 44.46→45.40 | on the pier, | ON PIER | pushIn close hug FOV 44 | hug | grin | C · pier | shimmer | — | sunny |
| 44 | 45.40→46.56 | both of us glowing, | BOTH GLOWING | snapOut hug → wide (613,20,−362) FOV 44→54 | hug | grin | C | shimmer | — | sunny |
| 45 | 46.56→48.22 | the bell still swinging. | STILL SWINGING | snapOut bell → wide pier FOV 40→52 | Kai and Milo stand at x 598 | Kai proud, Milo grin | C · bell swinging | shimmer | bell_ring_fading → bell.wav | sunny→17.5 |
| 46 | 48.22→49.82 | Brave isn't not being scared. | NOT FEARLESS | pushIn close Kai to camera d5 FOV 46; Milo behind-right | Kai looks at camera | Kai proud, Milo grin | C | shimmer | music_soft | sunny |
| 47 | 49.82→50.54 | It's being scared, | BEING SCARED | pushIn medium two-shot FOV 50 | Kai's arm round Milo; Milo looks up | Kai neutral, Milo proud | C · floaty | shimmer | — | sunny |
| 48 | 50.54→52.10 (+0.8 hold) | and doing it anyway. | DO IT ANYWAY | pushIn medium-wide from shore end (612.5,12.6,−380) FOV 50 | Kai stands tall, Milo beside; E5/E6 on pier; bell swings behind | Kai determined, Milo proud, E grin | C · bell, pier, floaty | shimmer | music_end_chime (anyway) | sunny 17.5 |

Mix: pushIn 29 · snapOut 12 · impactZoom 7 (60/25/15 %).

## H. Pre-render QA checklist
- [ ] `setup()` then `preview(n)` for all 48 beats; fix framing; `resetCamera()` after each check and after every take
- [ ] Every beat in G has a camera, an action and a face for each visible character
- [ ] No cloned/bare extras; every face is a classic_v1 decal
- [ ] No prop or character covers a face (bell in beats 35–39, handrails in 28/42/46, crate/lantern at night)
- [ ] Gold outline: Kai unlit until 39.75 s, YoungRosa until 24.9 s, everyone else always lit on stage
- [ ] Camera never under water (y ≥ 6.4) or inside sand/deck/towers
- [ ] Flash caps: grade +0.04, bloom +0.12; faces readable during the lightning
- [ ] Captions 1–3 words, lower third, burned in by the pipeline
- [ ] Every beat has a spoken `line` (beat 36 is the bell beat with no words; its timing is fixed at 38.00 s)
- [ ] Every SFX name exists in assets/sfx (only `scream_child` and `giggle` are missing, see D)
- [ ] Ending holds the last image 0.8 s; no fade, no black hold
- [ ] Beat sheet (`pipeline/qa_sheet.py`) reviewed by render-qa → `rec/qa_p1.md`; repeated frames < 2% on the 30 fps take
- [ ] Console shows `[Story001] beat N t=…` matching column G

## Verifier pass
2026-11-17: PASS (sections A-H complete; C ids match cast_001.luau; faces only classic_v1; mix 29/12/7 verified against G).
- Fixed stale SFX notes in D and H.
- Engine must fix sound-off gaps: beats 27 and 45 open on a bell close with no glowing character, and beat 38 is unlit for its first 0.35 s. Minimal fix is to frame a glowing figure in each. For 27, put E5/E6 on the pier beside the bell. For 45, start on a wider crop with Milo. For 38, put glowing Rosa or Milo at the frame edge, or move the ignite to 39.40.
