# 002 — In My Town, Every Footstep Glows With Your Body Heat — PRODUCTION MANIFEST
<!-- r3, 2026-11-19. Matches beats.json revision 3 (56 beats) and narration.txt (182 words). Owner-approved frozen-lake ending replaces old beats 41-51. -->

## A. Story meta
- **Format:** Standalone · ~60 s · 182 words · 30 fps · 1080x1920 · voice `viral_storyteller`
- **World rule:** every footstep leaves a glowing heat print for 60 s: walk = faint orange, run = blazing orange-red, hot socks + stomp = white-hot. Blind Striders hunt the brightest prints. Wheels leave none.
- **Twist:** Theo makes himself the brightest trail with dryer-hot socks, jumps on the print-free night van and kicks the socks onto its roof. The Striders chase the steaming van onto the frozen lake; their own blazing prints melt the ice and they sink. Second turn: the driver hops out and RUNS (the town's one taboo), his blazing prints melt the ice, a grey hand bursts up: gone, only his CB radio crackling on the ice.
- **Core meaning:** sacrifice: Theo's stomp costs him his feet; June repays by carrying him home, slowly (shown, never said).
- **Cliffhanger / ending plan:** standalone, fully resolved. Action echo: June, who broke the rule by running, now walks slowly carrying Theo, her small orange prints glowing behind her. Hard cut on the hand (non-graphic, no grab shown). Fade only in the ≤0.4 s tail after "Slowly."; never a black hold.
- **Freshness combo:** body/biology · sacrifice · small town at night (winter). Differs from every ledger entry at the time (see script.md Combo).
- **Hashtags:** #robloxstory #roblox #shorts #robloxanimation #storytime
- **Verification:** ledger/verification/002.md (PASS, IDEA_BANK row 002)

## B. Sets & lighting

### B1. Main Street, winter night
| Field | Value |
|---|---|
| Set name (exact model name) | `Set_Street002` · NEW builder `engines/roblox/sets/street_002_winter.luau` |
| What it looks like | Small-town Main Street at night after snowfall. Asphalt road (dark grey #2D2F34) under a snow layer, yellow centre stripe faintly showing. Concrete sidewalks with 0.3-stud snow on top. North side: red brick bakery (BuildingN1), grey stone shop (BuildingN2), tan laundromat (BuildingN3) with shop windows lit warm from inside; awnings with snow ridges. South side: brick row house (BuildingS1) with Theo's wooden porch, concrete block (BuildingS2). 4 streetlamps with warm cones of light. The two autumn trees become bare trunks with snow clumps. Snowbanks along both curbs. Mood: cold blue, quiet, every print pops orange. |
| Built position (2026-11-19, scene code) | Coordinates in this table are set-LOCAL. The builder places the set at WORLD origin **(900, 0, 0)** (empty area, clear of other sets): world X = local X + 900, world Z = local Z. Extended east to local X 95 (end cap at 96, extra buildings N4/S3) so the van can drive off. Changes vs the plan: roof snow adds 0.5 (Strider roof floors N1 28.0, N2 32.0, N3 26.0); bakery window moved to local X −46 and laundromat window to X 30 so the doors (−35, 42) don't overlap them; porch steps span local X −30..−25 and the rail X −25..−20 (radio at −21); boot rack moved to (−28.5, 2.2, 16.9) by the front door; **cat starts on the NORTH sidewalk at local (6, 0.7, −9)** so June's blazing trail crosses the road; snowbanks at north X −52/−8/47, south X −48/−14/−4 (bottle)/8 (Theo hides)/22/44; van home world (815, 0.3, −60) behind the west cap. All cutscene marks in `engines/roblox/story002_cutscene.luau` are WORLD coordinates. |
| Origin / extents (studs) | origin 0,0,0 · road X −60..+60, Z −5..+5 · north sidewalk Z −18..−6 · south sidewalk Z +6..+18 · end caps X ±58 · buildings to Y≈31 |
| Key surfaces | road top Y 0.0, snow top Y 0.3 (SnowRoad part 120x0.3x10 at 0,0.15,0, Material Snow #E8EEF5) · sidewalk top Y 0.4 + snow 0.3 → walk floor Y 0.7 · bakery door (−35, 0.7, −17.8), 5x8 · laundromat glass door (42, 0.7, −17.8), 5x8, Glass transparency 0.3 · bakery flat roof top Y 27.5 · porch deck top Y 2.2 |
| Prop placements | **Snowbanks** (NEW, Snow, #F2F6FA): 6x3x3 wedge-rounded parts at Z ±6.2 every 18 studs from X −50, Y 1.2 · **Bakery sign** NEW SurfaceGui "BAKERY" on BuildingN1 at (−35, 11, −17.7) · **Laundromat sign** NEW SurfaceGui "LAUNDROMAT 24H" on BuildingN3 at (42, 11, −17.7) · **dryer_vent** NEW Metal cylinder 1.5 dia x1 at (48, 6, −17.6), steam emitter · **ice_boot_rack** NEW at (−29, 2.2, 14.6) on porch, rot Y 180 · **Theo's porch** NEW: deck 10x1.5x4 Wood #6B4A2F at (−25, 1.45, 15.8), 2 steps 10x0.75x1.2 at Z 13.2 and 12.0, rail 10x0.3x0.3 at (−25, 4.2, 13.9), posts 0.4x2.8x0.4 at X −30/−20 · **CB radio** NEW on rail at (−21, 4.6, 13.9) · **night_van** NEW, path below · **roof_debris** NEW at bakery (−35, 0.7..27.5, −22) |
| Character marks | Theo porch (−26, 2.2, 15.2) facing −Z (toward the road; set yaw so LookVector = (0,0,−1)) · June porch (−23.5, 2.2, 15.2) facing −Z · Extra_Woman walks north sidewalk X −45→−10 at Z −10 · Extra_Man walks X 20→−20 at Z −12 · Jogger runs X 0→−33 at Z −9 then into bakery door · Striders on roofs: S1 (−35, 27.5, −22), S2 (5, 31.5, −22), S3 (42, 25.5, −22) · VanDriver in van cab |
| Van path | night_van drives +X along south lane Z +2.5, Y 0.3: beat 2 X −55→−20 (bg), beat 14 X −40→+40 at 30 studs/s, beat 41 X −10→+10 at 8 studs/s (Theo jumps on at X −5), beats 42–44 X +10→+55; lake beats 44–53 per B3 (van stops at (1032, 0.26, 3)) |
| Grade(s) used | **G.night** (new): Lighting.ClockTime 19.2, Brightness 1, Ambient (40,50,80), OutdoorAmbient (60,72,110), EnvironmentDiffuseScale 0.4; ColorCorrection Tint (200,215,255) Saturation −0.1 Contrast 0.15; Bloom Intensity 1.2 Size 24 Threshold 0.9; Atmosphere Density 0.35 Color (150,170,210) Haze 1.2; Fog none. **G.whitehot** (beats 36–43): same + Bloom Intensity 1.8, Contrast 0.2. **G.lake** (beats 44–53): see B3. **G.home** (beat 54): G.night + Tint (225,220,255), Bloom 1.5. **G.dusk** (beats 55–56): see B5 |
| Time of day / light sources | night, moon key from sun angle ClockTime 19.2 · 4 streetlamps PointLight (255,220,160) Range 22 Brightness 1.8 at X −40/−15/10/35, Z −8.5, Y 10.8 · shop windows: interior SurfaceLight (255,200,140) Brightness 2 · porch bulb PointLight (255,210,150) Range 12 at (−25, 7, 15.5) · every print has its own glow (see F) |
| DOF / focus | DepthOfField FarIntensity 0.35, FocusDistance = distance to the beat's subject, InFocusRadius 12 · close shots of prints: FocusDistance 4, InFocusRadius 3 |
| Ambient sound bed | none in assets/sfx for winter wind; mix scene silent under narration except listed SFX (no new sounds) |
| Rule visibility (sound-off) | every street shot keeps ≥1 print decal in frame; Strider shots always frame the prints they track; van shots show clean snow behind the tyres |

### B2. Laundromat interior
| Field | Value |
|---|---|
| Set name | `Set_Laundromat002` · NEW builder `engines/roblox/sets/laundromat_002.luau` |
| What it looks like | Narrow 24-hour laundromat: white-and-grey checker floor (SmoothPlastic tiles 2x2 #E6E6E6 / #9A9A9A), pale mint walls (#BFE3D2) with a 3-stud blue wainscot (#3B5B8A), row of 6 stacked steel dryers on the north wall with round glass doors glowing amber, centre folding table, plastic chairs, a coin machine, notice board with paper flyers. Glass front door (south wall) shows the snowy street and the blazing prints outside. One dryer (#3, bottom) is open, steam rolling out, a pair of thick red wool socks inside. |
| Built position (2026-11-19, scene code) | Built at WORLD origin **(900, 0, 70)**: world = coords in this table − (200,0,0) + (900,0,70), i.e. interior world X 885..915, Z 60..80. Changes vs the plan: south wall at Z +10.5 (glass door world (900, 4.5, 80.5)); folding table moved to local (208, 3.0, 0) and chairs to X 189/192 so Theo's door→dryer path (X 200) is clear; June hides at local (187, 0.5, −4) by the dryer bank end; 5 bottom + 5 top dryers; street backdrop outside the door (snow pad local Z 11..24 top 0.7, facade Z 24.5). |
| Origin / extents | origin (200, 0, 0) · interior 30 x 14 x 20 (X 185..215, Y 0..14, Z −10..+10) · floor top Y 0.5 |
| Key surfaces | dryers: 6 boxes 4x4x3.5 Metal #C9CDD2 at X 190/195/200/205/210 (5 bottom) + top row Y +4, along Z −8.2, door circles 2.6 dia Glass amber · open dryer #3 at (200, 2.5, −8.2), door hinged 100° open · folding table 10x0.4x4 top Y 3.2 at (200, 3.0, 0) · glass door 5x8 at (200, 4.5, 9.9), Glass #B4D2E6 transparency 0.3, CrackDecal hidden until beat 31 · back door at (214.9, 4.5, 0) leads out (cut to street) |
| Prop placements | hot_socks in dryer #3 drum at (200, 2.3, −8.6) · coin machine 2x5x1.5 at (186.5, 3, 4) · chairs 3x at (195/200/205, 0.5, 4) · notice board 4x3 at (213.9, 7, −4) |
| Character marks | Theo enters (200, 0.5, 8) → dryer (200, 0.5, −5.5) yaw 0 · June crouches behind dryer bank end (188, 0.5, −6) yaw 90 · Strider1 outside glass at (200, 0.7, 12) (built on street plane copy: a 10x0.3x6 snow pad + backdrop at Z 11..17 so the glass shows street) |
| Grade(s) used | **G.laundro** (new): local only (no Lighting change except ClockTime 19.2 kept): 3 ceiling tube lights Neon #FFF6E0 4x0.3x0.6 at Y 13.5, SurfaceLight down (255,240,210) Brightness 2.5 Range 16; dryer windows PointLight (255,170,80) Range 4 |
| Time of day / light sources | night outside (cold blue through the glass), warm fluorescent inside |
| DOF / focus | FocusDistance to Theo; glass-door shots focus on the Strider silhouette, InFocusRadius 6 |
| Ambient sound bed | none (no dryer hum in assets/sfx) |
| Rule visibility | Theo's blazing prints on the tile floor from door to dryer (beats 33–35), June's on the snow pad beyond the glass |

### B3. Frozen lake east of town (beats 44–53) — NEW
| Field | Value |
|---|---|
| Set name | `Set_Lake002` · NEW builder `engines/roblox/sets/lake_002.luau`. All coordinates WORLD. |
| Link to street | the street's east end cap (world X 996) gets a 12-stud gap at Z −1..+11 in `street_002_winter.luau` (story-local builder) so the south lane (Z 2.5) runs on as a snowy road ramp X 996→1000, dropping Y 0.3→0.2 onto the ice |
| What it looks like | a round frozen lake at the end of the van road: flat ice under a thin uneven snow skin (white with blue-grey patches where wind scoured it), a dark pine shoreline ring (Creator Store-free: Studio-built cone trees, Wood trunk + Grass-coloured cones #2E4A3A with snow caps), a low snowbank shore, a leaning wooden "THIN ICE" sign at the road end (SurfaceGui text, half-buried). Night, moonlit, cold blue; the van's headlights rake across the ice. |
| Origin / extents | centre (1030, 0, 0) · ice sheet X 1000..1060, Z −30..+30 · shore snowbank ring 4 studs wide around it, top Y 1.5 · pines at radius 34–40 every ~8 studs, heights 14–22 |
| Key surfaces | ice top Y 0.2 (IceSheet part 60x0.4x60 at (1030, 0.0, 0), Material Ice #BFD8E8, transparency 0) · snow skin SnowSkin 60x0.06x60 at Y 0.23, Material Snow #EEF3F8, transparency 0.25 (ice shows through) · walk floor Y 0.26 · water under holes: Water plane 60x0.2x60 at Y −1.2, Material Glass #0B1A2A transparency 0.1 (black water) |
| Prop placements | **van stop mark** (1032, 0.26, 3) yaw 70° (skidded sideways) · **ice holes** (D19) at Strider sink marks S1 (1018, 0.2, −4), S2 (1022, 0.2, 6), S3 (1026, 0.2, −10); driver hole (1046, 0.2, 8) · **crack decals** (D18) spreading from each hole radius 2–5, plus a web around the van · **cb_radio_ice** (D21) on ice at (1040, 0.29, 6) · **THIN ICE sign** (1001, 0.2, −6) |
| Character marks | Striders enter at X 1000 running +X, stop/sink at S1–S3 marks · VanDriver exits cab door (1031, 0.26, 6) → runs toward east shore along Z 6–8 → vanishes at (1046, 0.26, 8) · Strider1 hand bursts at (1046.5, 0.2, 8.5) |
| Grade | **G.lake**: G.night + Atmosphere Haze 1.6, Bloom Intensity 1.4, ColorCorrection Tint (190,210,255); van headlights SpotLight (255,240,200) Range 40 Angle 50 |
| Time of day / light | night ClockTime 19.2, moon key; van headlights; every print/melt hole carries its own glow (F) |
| DOF | close crack shots FocusDistance 3, InFocusRadius 2 · wides FocusDistance 25, InFocusRadius 15 |
| Rule visibility | Strider and driver prints always in frame (orange-red B prints on the snow skin); steam rises off each print before a crack |
| Safety (non-graphic) | no body under water, no grab, no struggle: hand burst = hard cut; "Gone." shows only the empty hole and the prints ending |

### B4. Theo's living room (beat 54) — NEW
| Field | Value |
|---|---|
| Set name | `Set_Home002` · NEW builder `engines/roblox/sets/home_002.luau`, built at WORLD origin (900, 0, 140) |
| What it looks like | small warm living room: wood-plank floor #7A5536, wallpaper walls #C9A27E with white wainscot, a green couch (8x3x3), a round footstool (2.4 dia x1.6) in front, a window (south wall) showing snow at dusk, a lamp, a rug. Warm, quiet. |
| Extents | room 20x12x16 (X 890..910, Z 132..148), floor top Y 0.5 |
| Marks | couch (900, 0.5, 145) yaw 180 · Theo seated on couch (900, 2.0, 144.5) facing −Z, legs on footstool (900, 0.5, 141.5) · June stands by stool (902.5, 0.5, 141) yaw −90 holding cat |
| Grade | **G.home**: G.night + Tint (225,220,255), Bloom 1.5, lamp PointLight (255,200,140) Range 14 Br 2 |
| Rule visibility | June's faint orange kid prints on the rug-free floor behind her (A) |

### B5. Dusk road home (beats 55–56)
| Field | Value |
|---|---|
| Set name | `Set_Street002` REUSE, south sidewalk, shot looking −X toward Theo's porch |
| Marks | June walks X world 960 → 935 along Z 12 at 2.5 studs/s, Theo piggyback; porch bulb on at (875, 7, 15.5) |
| Grade | **G.dusk**: Lighting.ClockTime 17.6, Brightness 1.6, Ambient (90,80,110), OutdoorAmbient (140,110,130), ColorCorrection Tint (255,215,200) Saturation 0, Contrast 0.1, Bloom 1.4, Atmosphere Color (230,170,150) Density 0.3 |
| Rule visibility | a line of small (scale 0.7) orange A prints behind June, fading oldest first |

## C. Characters

### C1. Theo
| Field | Value |
|---|---|
| Engine name | `Theo` |
| Role | narrator, 13, June's big brother |
| Look | teen, scale 1.0, skin #EABE96, short brown hair, red puffer jacket, grey beanie, blue jeans, chunky white-blue ice boots (until beat 24, then socks/barefoot) |
| Catalog items (R6) | Shirt 12329928029 "red puffer jacket boys gangster" · Pants 134609569320601 "Boy jeans" · Hair 98588731108499 (reuse Kai/Marcus boy hair, per cast_002) · HatAccessory 17500690164 "Beanie". Default face neutral |
| Source | NEW entry `Theo` in `engines/roblox/cast_002.luau` |
| Face set | classic_v1: neutral, scared, shocked, determined, proud |
| Emotions needed | neutral (calm walking, home) · scared (sees the trail, running) · shocked (June runs, still bright, own prints, peeks) · determined (every attempt, climax) · proud (watching June warm her feet) |
| Body states | ice boots on feet (beats 3–23, props welded to legs) → bare feet with red hot_socks (35–42) → bandaged feet (D23) b54–56 |
| What they do | b3 steps, print lights · b4 walks out of frame · b13 sits on porch step pulling on ice boots · b15 stands beside June · b19 lunges, right arm out · b22 freezes, staring · b24 throws both ice boots overhand (right arm) · b26 stares · b27 hurls the bottle (right arm, long throw) · b30 drags June by her wrist (left hand), walking backwards · b33 looks down at his own prints · b34 yanks dryer door open (right hand) · b35 sits on floor pulling socks on · b36 stomps out of back door · b37–39 stomp-runs (run track, exaggerated knee lift) · b40 sprints, glances back · b41 leaps onto van back step, grips rail · b42 kicks socks up onto roof (right leg), rolls off into a snowbank · b54 sits on couch, feet up on footstool, bandaged soles, wiggles toes and winces · b55–56 rides piggyback on June, arms round her shoulders, chin on her shoulder |
| Held props | ice_boots both hands b24 · hot_water_bottle right hand b27 (released at throw frame) · June's wrist left hand b30 · hot_socks both hands b35 |
| Gender | boy |
| Catalog item names (checked to match gender) | boy: "red puffer jacket boys gangster", "Boy jeans", "Beanie" (hair: reuse Kai/Marcus, boy) |

### C2. June
| Field | Value |
|---|---|
| Engine name | `June` |
| Role | Theo's little sister, 7; the person in danger |
| Look | kid, scale 0.7, skin #FFDCBE, black pigtails, pink pajamas (catalog top + Cloud pajama pants), barefoot from beat 19 on (pink slippers before, optional prop) |
| Catalog items (R6) | Shirt 90274186166468 "pink pajamas cutie nightie meow sweet girls" · Pants 14075581338 "Cloud pajama pants for girls" · Hair 140124368601570 "kawaii cute moe baby pigtails black". Default face grin |
| Source | NEW entry `June` in `engines/roblox/cast_002.luau` |
| Face set | classic_v1: grin, shocked, determined, scared |
| Emotions needed | grin (porch, cat scooped, last shot) · neutral (b54) · shocked (sees cat, scream at the glass) · determined (running for the cat, carrying Theo) · scared (bottle throw, dragged, hiding) |
| Body states | barefoot pink feet (default R6 legs coloured skin below pants) |
| What they do | b15 hugs bottle, waves (left arm) · b16 squeezes bottle · b18 points across street (right arm) · b19–20 runs off porch to cat (run track) · b21 scoops up cat · b27 hugs cat · b30 stumbles behind Theo · b31 screams · b34 crouches behind dryers hugging cat · b54 stands by Theo's footstool hugging cat, looking at his feet (neutral) · b55–56 carries Theo piggyback, walking slowly (walk 0.6, slight forward lean 10°, arms hooked back under his knees), determined → grin. Scale note: June 0.7 carries Theo 1.0 — Theo is welded to her back offset (0, 0.6, 0.9), legs bent (hips 80°), so his bandaged feet hang by her hips |
| Held props | hot_water_bottle both arms b15–18 (dropped on porch at b19, Theo picks it up off-screen) · cat both arms b21–34, b54 · Theo (piggyback weld) b55–56 |
| Gender | girl |
| Catalog item names | girl: "pink pajamas cutie nightie meow sweet girls", "Cloud pajama pants for girls", "kawaii cute moe baby pigtails black" |

### C3. Jogger
| Field | Value |
|---|---|
| Engine name | `Jogger` |
| Role | cautionary example (beats 8–11) |
| Look | adult scale 1.08, skin #CD966E, curly black men hair, Mens Tracksuit top, navy tracksuit pants, no headband (cast_002 has no hat) |
| Catalog items | Shirt 2885430411 "Mens Tracksuit" · Pants 140429444258386 "Balenci Men's Tracksuit Pants Navy" · Hair 120646937583722 "Curly Messy Beach Hair Men Black" · no hat |
| Source | NEW entry `Jogger` in cast_002.luau |
| Face set / emotions | grin (sprinting, carefree) · shocked (fleeing the Striders) |
| What they do | b8 sprints west along north sidewalk (run track) · b9 ducks into bakery door · b11 runs out screaming, arms up |
| Held props | none |
| Gender | man |
| Catalog item names | man: "Mens Tracksuit", "Balenci Men's Tracksuit Pants Navy", "Curly Messy Beach Hair Men Black" |

### C4. VanDriver
| Field | Value |
|---|---|
| Engine name | `VanDriver` |
| Role | unaware decoy carrier; sting |
| Look | adult 1.08, skin #B07C5C, black side-part men hair, Billy's Works Shirt (MEN), beige men cargo pants, no cap |
| Catalog items | Shirt 3568313512 "Billy's Works Shirt (MEN)" · Pants 12858384874 "Beige cargo pants for men" · Hair 139671521768286 "Formal Men Mafia Side Part Curl Hair BLACK" · no hat (no cap) |
| Source | NEW entry `VanDriver` in cast_002.luau |
| Face set / emotions | neutral (driving) · shocked (skid, turning to the hand) · grin (whooping, running) |
| What they do | seated in cab (R6 sit pose: hips 90°, both hands on wheel) b2, b14 (elbow on window sill), b41–43 · b44 braces at wheel as the van skids · b48 hops out of the cab door onto the ice, both fists up, whoops · b49–50 sprints for shore (run track 1.3), CB radio drops from belt · b51 turns back mid-run as the hand bursts; HARD CUT · not seen again |
| Held props | cb_radio_ice clipped to belt (Torso weld) b48, unwelded and dropped at b49 |
| Gender | man |
| Catalog item names | man: "Billy's Works Shirt (MEN)", "Beige cargo pants for men", "Formal Men Mafia Side Part Curl Hair BLACK" |

### C5. Strider1 / Strider2 / Strider3
| Field | Value |
|---|---|
| Engine name | `Strider1`, `Strider2`, `Strider3` (one CAST entry `Strider`, built 3x and renamed) |
| Role | blind predators that hunt the brightest prints |
| Look | R6 scaled 1.4 (tall), skin #C8C8CD pale grey on all limbs, bald, long black coat, black trousers; eyeless face; arms posed slightly long-forward (shoulders −15°) to read creature |
| How made from R6 | `M.build("Strider", ...)` → ScaleTo 1.4 · coat: classic Shirt 17181790240 "Black Trench Coat [+]" + Pants 122205461150104 "Black Pants" · extra length: NEW coat-tail Part 2.2x2.6x0.2 SmoothPlastic #141414 welded to Torso back, hanging to knees · eyeless: no face decal at all (see Face set) |
| Catalog items | Shirt 17181790240 "Black Trench Coat [+]" · Pants 122205461150104 "Black Pants" · Hair "" (bald by design) |
| Source | NEW entry `Strider` in cast_002.luau |
| Face set | No face decal at all (blank pale head reads eyeless) — owner-approved choice; not an outside asset. (`FACES.eyeless = ""` in cast_002.luau) |
| Emotions needed | eyeless only (no swaps) |
| What they do | b7 S1 head tilts 25°, sniffs (head bob) · b10 S1 drops through bakery roof · b11 all three stand in rubble, heads sway · b14 S2 crouched on roof, still, does not turn to the van · b23 all three turn heads to the trail · b29 S1 strides over the frozen bottle (walk) · b31 S1 slams claw-hand into glass · b32 S1 presses on glass · b40 all three lope (run track, playback 0.8) · b43–44 all three chase the van onto the lake · b45 S1 freezes mid-stride as ice cracks · b46 all three look down, sway · b47 all three drop straight down through melt holes (tween Y 0.26 → −6 in 0.35 s, arms up), then hidden · b51 S1 right hand + forearm only (separate prop D20) bursts up through the ice |
| Held props | none |
| Gender | man (creature, male-scaled outfit) |
| Catalog item names | man: "Black Trench Coat [+]", "Black Pants"; bald |

### C6. Extra_Woman
| Field | Value |
|---|---|
| Engine name | `Extra_Woman` |
| Role | townsperson demonstrating the rule |
| Look | adult 1.02, skin #E1AF87, brown hair, black comfy sweater, womens jeans, no scarf (no boot item in cast_002: default feet) |
| Catalog items | Shirt 18566797626 "Black Comfy Womens Sweater" · Pants 5498774219 "Womens Jeans" · Hair 129421843016867 "Vintage 50s Women's Brown Hair" · no scarf |
| Source | NEW entry in cast_002.luau |
| Face set / emotions | neutral · scared |
| What they do | b2 walks slow · b5 walks slow (faint prints) · b12 tiptoes, arms out · b17 walks past the laundromat |
| Gender | woman |
| Catalog item names | woman: "Black Comfy Womens Sweater", "Womens Jeans", "Vintage 50s Women's Brown Hair" |

### C7. Extra_Man
| Field | Value |
|---|---|
| Engine name | `Extra_Man` |
| Role | townsperson (walk, then the runner in beat 6) |
| Look | adult 1.08, skin #6E4B37, black side-part men hair, yellow denim parka, camo cargo pants (not a Theo clone) |
| Catalog items | Shirt 4593507067 "424 Yellow Denim Parka" · Pants 3234753288 "Mens Two-Tone Camo Cargo Pants" · Hair 124340390453001 "Side Part Japanese Boy Men Formal Hair Black" |
| Source | NEW entry in cast_002.luau |
| Face set / emotions | neutral · shocked · scared |
| What they do | b1 boot lifts out of frame · b2 walks slow · b6 runs (blazing prints) · b12 tiptoes, arms out |
| Gender | man |
| Catalog item names | man: "424 Yellow Denim Parka", "Mens Two-Tone Camo Cargo Pants", "Side Part Japanese Boy Men Formal Hair Black" |

### C8. Cat (prop, not a rig)
orange cat, NEW Studio-built (see D9). Not a cast entry.

## D. Assets
| # | Engine name | What / description | Size (studs) | Material · colour | Sub-parts that animate | CanQuery | Placement / socket | Used in (beats) | Source |
|---|---|---|---|---|---|---|---|---|---|
| D1 | Print_A/B/C | footprint: flat Part 0.9x0.05x1.6 with foot-shaped Decal (NEW 2D, white footprint PNG tinted via Color3) + Neon backing; A #FF9A3C transp 0.6 no light; B #FF4A1A transp 0.2 + PointLight Range 6 Br 2; C #FFF4E0 transp 0 + PointLight Range 9 Br 4 + steam emitter | 0.9x0.05x1.6 | Neon | Transparency fades 0→1 over 60 s of story time (compressed: 3 s on screen); Light brightness follows | false | spawned at each foot-down frame, Y = floor + 0.03, yaw = walker yaw; kid prints scale 0.7 | all | NEW Studio-built; footprint decal NEW (to generate, flat PNG) |
| D2 | night_van | boxy delivery van: body 7x6x14 SmoothPlastic #2F5D8A, cab windscreen Glass, 4 wheels cylinders 2.4 dia #1A1A1A, "VAN 7" white SurfaceGui both sides + roof, rear back step 4x0.4x1 with grab rail, red Neon tail lights 1x0.6x0.2 x2, headlights SpotLight (255,240,200); roof steam emitter (always on, the "warm roof") | 7x6x14 | SmoothPlastic / Metal | wheels rotate; whole model tweens along path | false | Z 2.5 lane, Y 0.3 | 2, 14, 41–45, 51 | NEW Studio-built |
| D3 | van_cab | cab interior for beat 51: dashboard, wheel, CB unit, VAN 7 sticker | 5x4x4 | Plastic #2A2A2A | wheel jiggle | false | inside D2 front | 51 | NEW |
| D4 | cb_mic | handheld CB mic 0.4x0.7x0.25 black + coiled cord (Beam) | 0.4x0.7x0.25 | Plastic #111111 | none | false | VanDriver RightHand grip weld | 51 | NEW |
| D5 | radio | porch CB radio box 1.6x0.8x1, silver face, red LED Neon 0.15 dia, VAN 7 sticker decal | 1.6x0.8x1 | Metal #B8BCC2 | LED blinks (Transparency 0/1 every 0.15 s) b15 | false | porch rail (−21, 4.6, 13.9) | 15 | NEW |
| D6 | ice_boots | chunky winter boot pair: sole 0.9x0.4x1.5 #DDE6EE + shaft 0.9x1.2x0.9 #5B7FA6, frost decal | 0.9x1.6x1.5 each | SmoothPlastic + Ice | none | false | welded to Theo's legs b3–23; held both hands b24; on rack b13 | 3, 13, 24, 25 | NEW |
| D7 | ice_boot_rack | wooden rack 4x2x1 with 3 boot pairs, frost shimmer | 4x2x1 | Wood #6B4A2F | none | false | (−29, 2.2, 14.6) | 13 | NEW |
| D8 | hot_water_bottle | red rubber bottle 1.1x1.5x0.4 #C0392B with cap, steam wisp emitter; frozen variant: Ice material #CFE6F2 | 1.1x1.5x0.4 | Rubber-look SmoothPlastic | Material swap to Ice b29 | false | June both arms b15–18; Theo RightHand b27; snowbank (−5, 1.2, 6.2) b28–29 | 15–18, 27–29 | NEW |
| D9 | cat | orange cat from Parts: body 1.4x0.8x0.7, head 0.7 cube with ears wedges, tail 0.2x0.2x1 hinged, #E8892B, black dot eyes decal | 1.4x1.1x0.7 | SmoothPlastic | tail sway ±20° | false | sidewalk (12, 0.7, 9) b18–20; June arms b21–49 | 18, 21, 27, 30, 34, 46–49 | NEW (Creator Store cat allowed if script-free; log id) |
| D10 | hot_socks | pair of thick red wool socks #B3202A, steam emitter | 0.6x0.3x1.4 each | Fabric | none | false | dryer drum → Theo hands b35 → Theo feet (welded to legs) b36–42 → van roof (0, 6.4, −3 rel. van) b42–51 | 34–44, 51 | NEW |
| D11 | dryer_bank | 6 dryers + open dryer #3 with hinged door | 4x4x3.5 each | Metal #C9CDD2 + amber Glass | door #3 swings 0→100° b34 | false | B2 | 33–35 | NEW |
| D12 | glass_door | laundromat front door with hidden crack decal (NEW 2D white crack PNG) | 5x8x0.3 | Glass | crack decal Transparency 1→0 b31 | false | B2 (200, 4.5, 9.9) and street (42, 4.7, −17.8) | 17, 30–32 | NEW |
| D13 | roof_debris | 12 brick chunks 1–2 studs + 4 snow slabs | 1–2 | Brick #915037 / Snow | fly out on b10 (physics unanchored, then re-anchor) | false | bakery roof hole (−35, 27.5, −22) | 10–11 | NEW |
| D14 | bread_loaves | 5 loaves 1.2x0.6x0.6 #C68642 | 1.2x0.6x0.6 | SmoothPlastic | none | false | bakery floor in rubble | 11 | NEW |
| D15 | snowbanks | curb snowbanks | 6x3x3 | Snow #F2F6FA | none | true | B1 | street shots | NEW |
| D16 | streetlamps | lamp poles + bulbs | standard lamp layout | Metal / Neon | none | true | B1 | street shots | NEW in `engines/roblox/sets/street_002_winter.luau` |
| D17 | dryer_vent | wall vent with steam | 1.5 dia x1 | Metal | steam | false | (48, 6, −17.6) | 17 | NEW |
| D18 | ice_sheet | IceSheet 60x0.4x60 Ice #BFD8E8 + SnowSkin 60x0.06x60 Snow #EEF3F8 transp 0.25 + Water plane 60x0.2x60 Glass #0B1A2A at Y −1.2 | 60x0.4x60 | Ice / Snow / Glass | SnowSkin patches under prints darken to #6F8796 (wet) b46, b50 | true | B3 centre (1030, 0, 0) | 44–53 | NEW Studio-built (`lake_002.luau`) |
| D19 | ice_crack_decals | 6 flat 0.02-thick Parts 4x4 / 8x8 with NEW 2D white-blue crack PNG (radial web) Decal on top, Transparency 1 until triggered; tween 1→0 and Size ×0.3→×1 over 0.25 s (spreading) | 4x0.02x4 / 8x0.02x8 | SmoothPlastic, Transparency 1, Decal | reveal + grow | false | at Y 0.27 centred on each hole mark (B3) + one 8x8 web under the van | 45–47, 50–52 | NEW (crack PNG: reuse D12 glass crack PNG tinted #CFE6F2 if acceptable, else NEW) |
| D20 | ice_holes | per hole: a black disc (Cylinder 3.2 dia x0.1, Glass #050B12 transp 0.05) at Y 0.22 + ring of 8 broken ice chunks (wedges 0.8–1.4, Ice #D7E8F2) tilted 15–35°, hidden until the sink frame; driver hole 2.6 dia | 3.2 dia | Glass / Ice | appear at sink frame (Transparency 1→0), chunks bob ±0.1 1 Hz | false | S1 (1018,0.2,−4), S2 (1022,0.2,6), S3 (1026,0.2,−10), driver (1046,0.2,8) | 47–53 | NEW |
| D21 | strider_hand | one grey R6-style hand + forearm (Part 1x2.6x1 #C8C8CD, black coat cuff 1.1x0.6x1.1 #141414), fingers splayed (4 small wedges) — NO body | 1x3x1 | SmoothPlastic | tween up Y −2.5 → +1.4 in 0.15 s through the driver hole, ice shards burst | false | (1046.5, 0.2, 8.5) | 51 | NEW Studio-built |
| D22 | cb_radio_ice | handheld CB radio 0.5x0.9x0.3 black, stub antenna 0.1x0.6, red LED Neon 0.12 dia, VAN 7 sticker (SurfaceGui text) | 0.5x0.9x0.3 | Plastic #111111 | LED blinks 0.15 s on/off b53 | false | driver Torso belt weld b48 → dropped at b49 → lies on ice (1040, 0.29, 6), rot X 90 | 48, 49, 53 | NEW (replaces D3/D4 cab + mic, no longer used) |
| D23 | bandaged_feet | per foot: white wrap Part 1.05x0.6x1.05 Fabric #F4F1EA welded over R6 leg bottom + red sole patch 1x0.05x1 #C0392B (burn read, cartoon, no gore) + 2 bandage-strip lines (SurfaceGui frames) | 1.05x0.65x1.05 each | Fabric | none | false | Theo Left/Right Leg bottom, offset (0, −0.7, 0) | 54–56 | NEW |
| D24 | footstool + couch | home props: couch 8x3x3 Fabric #3F6B4A; round footstool 2.4 dia x1.6 Fabric #8A5A3A | — | Fabric | none | true | B4 | 54 | NEW (`home_002.luau`) |
| D25 | thin_ice_sign + pines | wooden sign post 0.4x4 + board 3x1.5 "THIN ICE" (SurfaceGui), leaning 12°; pines = Wood trunk 1x4 + 3 stacked cones #2E4A3A with Snow caps | — | Wood / Grass | none | true | B3 | 44 | NEW |

Retired with the old ending: D3 van_cab and D4 cb_mic (beat 51 comic sting cut). D5 radio (porch) now only appears in b15 (plant).

Also:
- **Face decals:** classic_v1 ids (`assets/faces/classic_v1/ids.json`): neutral 70950815478959, scared 94514852927815, shocked 103057607693548, grin 96253429845051, determined 109687999939498, proud 96477668083717 (REUSE). `eyeless`: no face decal at all (blank pale head reads eyeless) — owner-approved choice; not an outside asset.
- **Textures/decals:** footprint PNG (NEW), glass crack PNG (NEW), VAN 7 logo (SurfaceGui text, no image), BAKERY / LAUNDROMAT 24H signs (SurfaceGui text).
- **SFX (all REUSE `assets/sfx/`):** whoosh_hit, chime_soft, tick, whoosh, bass_hit, drone_smash, stone_thud, ding, ignite_shimmer, heartbeat_fast, hiss_crack, thud, scraping_drag, railing_snap, glass_clink, heartbeat, ignite_shimmer_big, impact_whoosh, music_soft, music_swell, music_end_chime (all present).
- **Music:** music_soft / music_swell / music_end_chime only (ending).

## E. Animations
All rigs use the approved engine `engines/roblox/story001_cutscene.luau` (R6 Animate tracks walk 180426354, idle 180435571; `loco` reset every frame; run = walk track at 1.15–1.4 speed + 4° torso lean). No rig frozen more than one beat.
| # | Name | Who | Description (joints, angles, timing) | Loop / one-shot | Beats |
|---|---|---|---|---|---|
| E1 | idle | all on stage | R6 idle track, speed 1.0 | loop | every beat a rig is not moving |
| E2 | walkSlow | Extras, Theo | walk track speed 0.7, 6 studs/s | loop | 2, 3, 4, 5, 17 |
| E3 | tiptoe | Extras | walk 0.6 + both shoulders out 60° (arms out), torso up | loop | 12 |
| E4 | run | Jogger, Extra_Man, June, Theo, Striders | walk track 1.3, 16 studs/s, torso lean 4°; Striders 0.8 playback with 1.4 scale (long loping stride) | loop | 6, 8, 11, 19–20, 39–40, 45 |
| E5 | stompRun | Theo | run + knee lift (hip −70° on each foot-down), 0.12 s down-slam, print C spawned per slam | loop | 36–38 |
| E6 | point | June | right shoulder 90° forward over 0.25 s, hold | one-shot | 18 |
| E7 | wave / hugBottle | June | left shoulder swing ±30° x2 / both arms −45° across chest | one-shot / hold | 15, 16 |
| E8 | throwOverhand | Theo | right shoulder −160°→+40° in 0.3 s, prop release at 0.2 s | one-shot | 24, 27 |
| E9 | reach | Theo | right shoulder 90° forward, torso lean 10° | one-shot | 19 |
| E10 | dragBack | Theo, June | Theo walks backward (walk −1), left arm extended to June's wrist (weld); June walk with 15° forward stumble | loop | 30 |
| E11 | openDryer | Theo | right arm 70°→0° pull 0.3 s, door hinge tween 0→100° | one-shot | 34 |
| E12 | sitSocks | Theo | sit (hips 90°), both arms down to feet, 2 pulls | one-shot | 35 |
| E13 | jumpOn | Theo | crouch 0.1 s → leap 0.3 s arc (4 studs up) onto van back step, hands weld to rail | one-shot | 41 |
| E14 | kickRoll | Theo | right hip −110° kick, socks tween to roof (0.35 s arc), then fall/roll 1 turn into snowbank | one-shot | 42 |
| E15 | sitBandaged | Theo | sit on couch (hips 90°), legs straight forward onto stool (hips 90°, knees 0), toe wiggle = leg roll ±5° at 2 Hz, wince = head dip 8° once; idle track keeps arms alive | loop | 54 |
| E16 | headTiltSniff | Striders | neck tilt 25° + 3 small head bobs (0.15 s) | one-shot | 7, 43 |
| E17 | dropThrough | Strider1 | fall from Y 34 to 0.7 in 0.4 s, land crouch (hips 40°) | one-shot | 10 |
| E18 | headTurn | Striders | neck yaw 0→70° toward trail in 0.4 s | one-shot | 23 |
| E19 | clawHit / pressGlass | Strider1 | right arm −120°→0° slam into glass 0.15 s; then both hands flat on glass, lean | one-shot / hold | 31, 32 |
| E20 | scoop / hugCat | June | bend 30°, arms down then up to chest, hold | one-shot / hold | 21, 27–34, 54 |
| E21 | piggybackCarry | June + Theo | June walk track 0.6 at 2.5 studs/s, torso lean 10°, both shoulders −30° back (hands under his knees); Theo welded to June's Torso (0, 0.6, 0.9), hips 80°, knees bent, arms 100° forward round her shoulders, idle track on his head/arms so he isn't frozen; his body bobs with her steps | loop | 55, 56 |
| E22 | skidBrace | VanDriver | in seat, both arms locked to wheel, torso lean 15° with the slide | one-shot | 44 |
| E23 | hopOutWhoop | VanDriver | step down from cab 0.3 s, land, both shoulders 170° (fists up), 2 small bounces | one-shot | 48 |
| E24 | driveSit | VanDriver | sit, hands on wheel (elbow on sill in b14) | loop | 2, 14, 41–43 |
| E25 | turnBack | VanDriver | mid-run torso + head yaw 120° toward the hand over 0.2 s, arms flare | one-shot | 51 |
| E26 | catTail | cat | tail hinge sway ±20° 1 Hz | loop | cat beats |
| E27 | van drive / skid | night_van | path tween + wheel spin; b44 skid = yaw 0→70° while sliding 14 studs on ice, decelerating to stop at (1032, 0.26, 3) | continuous | 2, 14, 41–44 |
| E28 | sinkDrop | Striders | arms up 150°, tween straight down Y 0.26 → −6 in 0.35 s, then Transparency 1 (out of shot) | one-shot | 47 |
| E29 | handBurst | strider_hand (D21) | tween Y −2.5 → +1.4 in 0.15 s, fingers splay, hard cut 0.1 s after peak | one-shot | 51 |

## F. VFX
| # | Name | Trigger (beat / word) | Look | Duration | Limits / rules |
|---|---|---|---|---|---|
| F1 | print_glow (A) | every walking foot-down | faint orange print, transp 0.6 | fades over 3 s on screen | max 60 live prints; oldest removed |
| F2 | print_blaze (B) | running foot-down | orange-red, PointLight Range 6 | fades over 4 s | max 40 B prints |
| F3 | print_white_hot (C) | stomp foot-down (b36+) | white, PointLight Range 9 Br 4, steam ParticleEmitter (Rate 6, Size 0.6→1.4, Lifetime 1.2, #FFFFFF transp 0.6) | stays to end of story (b51) | max 30 C prints |
| F4 | print_fade | b4 | A print Transparency 0.6→1 | 1.2 s | — |
| F5 | breath_steam | Strider shots | small white puffs from head front, Rate 3 | loop | — |
| F6 | debris_burst + snow_puff | b10 "Boom." | D13 chunks fly, snow particle burst 40 count | 0.8 s | camera shake ≤0.3 studs, 0.2 s |
| F7 | dust | b11 | grey particles Rate 15 in bakery | 1.4 s | — |
| F8 | frost_shimmer | b13, b29 | blue-white sparkle particles Rate 8 on boots / bottle | beat | — |
| F9 | steam_wisp | bottle, socks, prints | thin steam Rate 4 | while visible | — |
| F10 | steam_plume | van roof (always), dryer vent b17, open dryer b34 | thick steam Rate 15, Size 1→3, rising | continuous | van roof plume must be visible in b2, b14, b41–44, b53 |
| F11 | steam_burst | b25 "Hiss!" | 1-shot 30 particles from print | 0.7 s | — |
| F12 | water_splat | b28 "Splat!" | blue droplets 20 + snow puff | 0.5 s | — |
| F13 | glass_crack | b31 "Crack!" | crack decal reveal + 0.1 s white flash Bloom | 0.1 s flash | flash cap 1 per beat |
| F14 | lens_flare | b37 | Bloom Intensity spike 1.2→2.2→1.8 | 0.6 s | — |
| F15 | radio_led_flash | b53 | CB radio LED blink 0.15 s on/off + tiny red PointLight Range 2 | beat | — |
| F16 | snow_spray | b44 skid | snow/ice particle fan from van tyres, Rate 60, Size 0.4→1, Lifetime 0.6, #FFFFFF | 1.2 s | — |
| F17 | grade switches | b36 (G.whitehot), b44 (G.lake), b54 (G.home), b55 (G.dusk) | as in B | hard cut | — |
| F18 | crack_spread | b45 "Crack!", b46, b50 | D19 decal reveal + grow 0.25 s + 0.08 s white Bloom flash | 0.25 s | flash cap 1 per beat |
| F19 | melt_steam | b46–53 | thick steam column from each B print and under the van, Rate 20, Size 0.8→2.5, Lifetime 1.5, #F0F4F8 transp 0.4; SnowSkin under it tints wet #6F8796 | while visible | — |
| F20 | water_splash | b47 "sank" | per hole: 25 dark-blue droplets + white foam ring puff, 0.5 s; ice chunks pop up 0.4 studs | 0.5 s | no bodies visible under water |
| F21 | ice_shards | b51 "burst" | 14 small Ice wedges fly up/out from the hole, 0.4 s, + snow puff | 0.4 s | hard cut right after; no grab |
| F22 | print_fade (dusk) | b56 | June's kid A prints fade oldest-first along the road | 1.2 s each | — |

## G. Beat-by-beat director table
> Camera: pushIn = slow push-in · pullOut (snapOut) = snap pull-out close→wide · snapZoom (impactZoom) = impact snap-zoom +2.5° Dutch. Counts: pushIn 32 / pullOut 14 / snapZoom 10 of 56 (57/25/18 %). Grade G.night unless stated. Times planned (r3, 182 words, ~60.0 s); voice_subs.py snaps them.

| # | t start→end | Spoken line | Caption | Shot | What each character does | Face swaps | Props state | VFX | SFX | Grade |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 0.0→1.0 | In my town, | MY TOWN | snapZoom, FOV 40→28, close on a print, Extra_Man's boot lifting out top of frame | Extra_Man walks (only boot/leg visible) | Extra_Man neutral | snow | F1 | whoosh_hit "In" | G.night |
| 2 | 1.0→2.0 | every footstep glows | EVERY FOOTSTEP | pullOut FOV 30→60, prints → wide street; van glides past far lane | Extra_Woman, Extra_Man walk slow; VanDriver drives (bg) | neutral both | van X −55→−20 | F1, F10 roof | chime_soft "every" | G.night |
| 3 | 2.0→3.3 | with your body heat | BODY HEAT | pushIn FOV 45→38, medium on Theo's boot | Theo steps | Theo neutral | ice_boots on | F1 | — | G.night |
| 4 | 3.3→4.3 | for sixty seconds. | 60 SECONDS | pushIn, close print | Theo walks out of frame | neutral | — | F4 | tick "sixty" | G.night |
| 5 | 4.3→5.3 | Walk, it's faint. | WALK: FAINT | pushIn medium | Extra_Woman walks slow | neutral | — | F1 | — | G.night |
| 6 | 5.3→6.3 | Run, it blazes. | RUN: BLAZES | snapZoom medium, Dutch 2.5° | Extra_Man runs | Extra_Man → shocked | — | F2 | whoosh "Run" | G.night |
| 7 | 6.3→7.6 | Blind Striders hunt it. | STRIDERS | pullOut close Strider head → wide rooftop, prints below | Strider1 head tilt, sniff | eyeless | — | F2, F5 | bass_hit "Striders" | G.night |
| 8 | 7.6→8.9 | Last week, a jogger | A JOGGER | pushIn tracking | Jogger sprints west | Jogger grin | — | F2 | whoosh "jogger" | G.night |
| 9 | 8.9→10.2 | sprinted to the bakery. | BAKERY | pushIn medium on bakery door | Jogger ducks in | grin | bakery sign | F2 | — | G.night |
| 10 | 10.2→10.6 | Boom. | BOOM | snapZoom on roof, Dutch | Strider1 drops through roof | eyeless | roof_debris flies | F6 | drone_smash "Boom" | G.night |
| 11 | 10.6→11.9 | Striders through the roof. | STRIDERS | pullOut hole → wide bakery | Striders 1–3 stand in rubble; Jogger runs out screaming | Jogger → shocked | debris, bread_loaves | F2, F7 | stone_thud "Striders" | G.night |
| 12 | 11.9→13.2 | So we walk slow, | WALK SLOW | pushIn medium | Extras tiptoe, arms out | both → scared | — | F1 | — | G.night |
| 13 | 13.2→14.2 | in ice boots. | ICE BOOTS | pushIn close rack | Theo pulls on ice boots on porch step | Theo neutral | ice_boot_rack | F8, F1 | ding "ice" | G.night |
| 14 | 14.2→16.1 | Only the night van drives fast. | NIGHT VAN | pullOut close steaming VAN 7 roof → wide van gliding, clean snow behind tyres, Strider2 on roof ignores it | VanDriver drives, elbow out; Strider2 crouched still | VanDriver neutral; eyeless | van X −40→+40 | F10, F1 | whoosh "van" | G.night |
| 15 | 16.1→17.1 | My sister June | SISTER JUNE | pushIn medium porch; CB radio with VAN 7 sticker on rail in frame | June hugs bottle, waves; Theo beside | June grin, Theo neutral | bottle, radio | F1, F9 | chime_soft "sister" | G.night |
| 16 | 17.1→18.4 | hugs a hot-water bottle. | HOT BOTTLE | pushIn close bottle | June squeezes bottle | grin | bottle steaming | F9, F1 | ding "hugs" | G.night |
| 17 | 18.4→20.0 | The laundromat steams all night. | STEAMS ALL NIGHT | pushIn close dryer vent, open dryer glowing through glass door | Extra_Woman walks past | neutral | dryer_vent, glass_door | F10, F1 | ding "laundromat" | G.night |
| 18 | 20.0→21.6 | June saw her cat. | HER CAT | pushIn on June, cat across street | June points | June → shocked | cat on sidewalk, bottle | F1, F26 tail | — | G.night |
| 19 | 21.6→22.3 | She ran. | SHE RAN | snapZoom, Dutch | June bolts off porch; Theo reaches | June → determined; Theo → shocked | bottle dropped on porch | F2 | whoosh_hit "ran" | G.night |
| 20 | 22.3→22.7 | Barefoot. | BAREFOOT | pushIn close bare feet | June runs | determined | — | F2 | — | G.night |
| 21 | 22.7→24.3 | Her prints blazed like fire. | LIKE FIRE | pullOut print → wide trail across road | June scoops cat | June → grin | cat in arms | F2 | ignite_shimmer "blazed" | G.night |
| 22 | 24.3→25.0 | Sixty seconds. | 60 SECONDS | pushIn close Theo | Theo freezes, staring | Theo → scared | — | F2 | tick "Sixty" | G.night |
| 23 | 25.0→26.0 | The Striders turned. | TURNED | pushIn rooftops | Striders 1–3 turn heads | eyeless | — | F2, F5 | heartbeat_fast "Striders" | G.night |
| 24 | 26.0→27.3 | I threw ice boots. | ICE BOOTS | pushIn medium | Theo throws boots | Theo → determined | ice_boots airborne | F2 | whoosh "threw" | G.night |
| 25 | 27.3→27.7 | Hiss! | HISS! | snapZoom on print, Dutch | none visible | — | boot on print | F11, F2 | hiss_crack "Hiss" | G.night |
| 26 | 27.7→28.4 | Still bright. | STILL BRIGHT | pushIn print through steam, Theo behind | Theo stares | Theo → shocked | — | F2 | — | G.night |
| 27 | 28.4→29.7 | I flung her bottle. | THE BOTTLE | pushIn medium | Theo throws bottle; June hugs cat | Theo → determined; June → scared | bottle airborne, cat | F2, F9 | whoosh "flung" | G.night |
| 28 | 29.7→30.1 | Splat! | SPLAT! | snapZoom snowbank, Dutch | none | — | bottle bursts | F12, F2 | thud "Splat" | G.night |
| 29 | 30.1→30.8 | It froze. | IT FROZE | pullOut frosting bottle → wide, Strider steps over | Strider1 walks past bottle | eyeless | bottle → Ice material | F8, F2 | stone_thud "froze" | G.night |
| 30 | 30.8→32.7 | I dragged her into the laundromat. | LAUNDROMAT | pushIn medium at laundromat door | Theo drags June (backwards walk); June stumbles | Theo determined; June scared | glass_door, cat | F2 | scraping_drag "dragged" | G.night |
| 31 | 32.7→33.1 | Crack! | CRACK! | snapZoom on glass door from inside, Dutch | Strider1 claw-hits glass; June screams | June → shocked | crack revealed | F13, F2 | railing_snap "Crack" | G.laundro |
| 32 | 33.1→34.1 | The door split. | DOOR SPLIT | pushIn cracked glass, silhouette | Strider1 presses on glass | eyeless | glass cracked | F2 | glass_clink "door" | G.laundro |
| 33 | 34.1→35.4 | My prints led in. | MY PRINTS | pullOut prints on tile → wide trail to door | Theo looks down | Theo → shocked | — | F2 | heartbeat "prints" | G.laundro |
| 34 | 35.4→37.0 | I yanked the dryer open. | THE DRYER | pushIn medium on dryer #3 | Theo yanks door; June hides behind dryers, hugs cat | Theo → determined; June scared | dryer door 0→100°, socks visible | F10, F1 | whoosh "yanked" | G.laundro |
| 35 | 37.0→38.0 | Hot socks on. | HOT SOCKS | pushIn close feet | Theo sits, pulls socks on | determined | socks on feet | F9, F1 | — | G.laundro |
| 36 | 38.0→39.0 | I stomped. | STOMPED | pushIn low angle at back door | Theo stomps out | determined | socks on feet | F3, snow puff | stone_thud "stomped" | G.whitehot |
| 37 | 39.0→40.0 | Harder than ever. | HARDER | pullOut white print → wide street, June's orange trail dim beside | Theo stomp-runs | determined | — | F3, F1, F14 | ignite_shimmer_big "Harder" | G.whitehot |
| 38 | 40.0→41.3 | My trail blazed white, | BLAZED WHITE | pushIn tracking feet | Theo stomp-runs | determined | socks | F3, F9 | thud "trail" | G.whitehot |
| 39 | 41.3→42.3 | down Main Street, | MAIN STREET | pushIn tracking past shops | Theo sprints | Theo → scared | streetlamps | F3 | heartbeat_fast "Main" | G.whitehot |
| 40 | 42.3→43.3 | every Strider behind. | EVERY STRIDER | pullOut Theo → wide, Striders loping on white trail | Theo sprints; Striders 1–3 chase | scared; eyeless | — | F3, F5 | impact_whoosh "every" | G.whitehot |
| 41 | 43.3→44.5 | I jumped the night van. | NIGHT VAN | pushIn medium on van back step, white prints ending at kerb | Theo leaps on, grips rail; VanDriver drives, unaware | Theo → determined; VanDriver neutral | van world X 890→900 | F3, F10 | thud "jumped" | G.whitehot |
| 42 | 44.5→45.6 | Socks onto the roof. | ONTO THE ROOF | pushIn medium | Theo kicks socks up, rolls into snowbank; van speeds east | determined; neutral | socks → van roof; van X 900→960 | F10, F3 | whoosh "Socks" | G.whitehot |
| 43 | 45.6→46.5 | They chased it | THEY CHASED | pullOut close Strider feet (B prints) → wide: 3 Striders chase van east past the end cap gap | Striders 1–3 lope (E4, 0.8); VanDriver drives (bg) | eyeless | van X 960→996 | F2, F10, F5 | impact_whoosh "chased" | G.whitehot |
| 44 | 46.5→47.7 | onto the frozen lake. | FROZEN LAKE | pullOut close tyre skidding onto ice → wide lake, van slides sideways to stop mid-lake, Striders run onto the ice | VanDriver braces (E22); Striders lope onto ice | VanDriver → shocked; eyeless | van skid X 1000→1032, yaw 0→70°; THIN ICE sign | F16, F10, F2 | scraping_drag "frozen" | G.lake |
| 45 | 47.7→48.1 | Crack! | CRACK! | snapZoom close ice under Strider1's glowing print, Dutch 2.5° | Strider1 freezes mid-stride | eyeless | crack decal S1 revealed | F18, F2 | railing_snap "Crack" | G.lake |
| 46 | 48.1→49.0 | The ice melted. | ICE MELTED | pushIn medium, steam up from every Strider print + under van, ice goes dark/wet | Striders look down, sway | eyeless | cracks S1–S3 + van web grow; SnowSkin wet patches | F19, F18, F2 | hiss_crack "melted" | G.lake |
| 47 | 49.0→50.2 | Every Strider sank. | STRIDERS SANK | pullOut close S2 dropping → wide, all three drop through holes in a row; van on white ice island | Striders sinkDrop (E28), then hidden | eyeless | holes S1–S3 appear | F20, F19 | splash "sank" | G.lake |
| 48 | 50.2→51.3 | The driver jumped out. | DRIVER OUT | pushIn medium on van door | VanDriver hops out, fists up, whoops (E23) | VanDriver → grin | radio on belt | F19, F1 | thud "jumped" | G.lake |
| 49 | 51.3→52.2 | Then he ran. | HE RAN | snapZoom low tracking, Dutch 2.5° | VanDriver sprints for shore (E4), radio drops from belt | grin | radio → ice (1040, 0.29, 6) | F2, F19 | whoosh "ran" | G.lake |
| 50 | 52.2→53.0 | One grey hand | GREY HAND | pushIn close ice behind him: blazing prints steam, ice darkens, crack, bump from below | VanDriver runs (legs top of frame) | grin | crack decal driver hole | F2, F19, F18 | heartbeat_fast "grey" | G.lake |
| 51 | 53.0→54.0 | burst through the ice. | BURST | snapZoom wide-medium, Dutch 2.5°: grey hand bursts up by his last print, ice shards; HARD CUT 0.1 s after peak (non-graphic, no grab) | VanDriver turns back (E25); strider_hand burst (E29) | VanDriver → shocked | strider_hand, driver hole | F21, F2 | whoosh_hit "burst" | G.lake |
| 52 | 54.0→54.5 | Gone. | GONE | pushIn empty ice: his B prints run up to the round hole and stop; black water, steam, nobody | — | — | driver hole | F2, F19 | bass_hit "Gone" | G.lake |
| 53 | 54.5→55.8 | Only his radio crackled. | RADIO | pushIn close CB radio on snowy ice (VAN 7 sticker), LED blinking, prints fading, van far behind steaming | — | — | cb_radio_ice | F15, F4 | tick "radio" | G.lake |
| 54 | 55.8→57.3 | My feet burned for weeks. | WEEKS | pushIn medium living room: Theo on couch, red bandaged feet on footstool; June by stool with cat | Theo sits, wiggles toes, winces (E15); June hugs cat, looks at his feet (idle) | Theo → scared; June → neutral | bandaged_feet, footstool, cat | F1 (June's faint prints) | music_soft "feet" | G.home |
| 55 | 57.3→58.8 | So June carried me home. | CARRIED ME | pullOut close June's determined face, Theo's bandaged feet by her hips → wide dusk road, slow piggyback walk | June carries Theo (E21); Theo arms round her shoulders | June → determined; Theo → proud | bandaged_feet | F1, F5 | music_swell "June" | G.dusk |
| 56 | 58.8→60.0 | Slowly. | SLOWLY | pushIn slow, final wide from behind: June carrying Theo toward porch light, small orange prints glowing behind her, fading one by one | June walks slow carrying Theo; Theo chin on her shoulder | June → grin; Theo proud | bandaged_feet | F1, F22 | resolution_chord "Slowly" | G.dusk |

## H. Pre-render QA checklist
- [ ] Every beat in G has a camera, an action for each visible character, and a face per visible character
- [ ] No cloned or bare extras, no default faces (Extra_Man has its own yellow denim parka in cast_002)
- [ ] No prop covers a face (clearShot); held props welded (bottle, cat, boots, socks, mic)
- [ ] No overlay hovers off a limb; VFX within the flash caps (1 flash per beat)
- [ ] Captions 1–3 words, lower third Y≈82%, never end on a function word
- [ ] Every beat has a `line` whose first word is spoken (56/56 in beats.json)
- [ ] Every `sfx` name exists in `assets/sfx/` (checked r3: adds scraping_drag, splash, resolution_chord — all present)
- [ ] Camera modes 32/14/10 ≈ 57/25/18 %
- [ ] Prints visible in every shot; van shots show no prints behind tyres
- [ ] Lake beats non-graphic: no grab, no body underwater, hard cut on the hand (b51), "Gone." shows only the hole
- [ ] Piggyback (b55–56): Theo welded to June, both rigs animated (no frozen rider)
- [ ] Standalone resolves; fade only in tail after "Slowly."; never black hold
- [ ] Beat sheet (`pipeline/qa_sheet.py`, 57 frames) reviewed by render-qa → `rec/qa_p1.md`; repeated frames <2%
- [ ] Cast builder `engines/roblox/cast_002.luau` written; every face name in G is in ids.json except `eyeless` (no decal, owner-approved)
- [ ] Every rig plays idle/walk each frame (`loco` reset), no rig frozen >1 beat, no wall-clipping, no tilted giant-face filler
- [ ] Gender check: every shirt/pants/hair matches the C entry's gender (render-qa reads section C)

## C addendum (every character)
| Character | Gender | Shirt | Pants | Hair | Accessories |
|---|---|---|---|---|---|
| Theo | boy | 12329928029 "red puffer jacket boys gangster" | 134609569320601 "Boy jeans" | 98588731108499 (reuse Kai/Marcus, boy) | HatAccessory 17500690164 "Beanie" |
| June | girl | 90274186166468 "pink pajamas cutie nightie meow sweet girls" | 14075581338 "Cloud pajama pants for girls" | 140124368601570 "kawaii cute moe baby pigtails black" | none |
| Jogger | man | 2885430411 "Mens Tracksuit" | 140429444258386 "Balenci Men's Tracksuit Pants Navy" | 120646937583722 "Curly Messy Beach Hair Men Black" | none (no headband) |
| VanDriver | man | 3568313512 "Billy's Works Shirt (MEN)" | 12858384874 "Beige cargo pants for men" | 139671521768286 "Formal Men Mafia Side Part Curl Hair BLACK" | none (no cap) |
| Extra_Woman | woman | 18566797626 "Black Comfy Womens Sweater" | 5498774219 "Womens Jeans" | 129421843016867 "Vintage 50s Women's Brown Hair" | none (no scarf) |
| Extra_Man | man | 4593507067 "424 Yellow Denim Parka" | 3234753288 "Mens Two-Tone Camo Cargo Pants" | 124340390453001 "Side Part Japanese Boy Men Formal Hair Black" | none |
| Strider x3 | man | 17181790240 "Black Trench Coat [+]" | 122205461150104 "Black Pants" | none (bald, hair "") | none; coat-tail Part (Studio-built) |
