# StudVerse Tales — Stories 001 to 025 Production Bible (Category 1: Anime & Manga Twists 1–20 + Category 2: Gaming Twists 21–25)

---

## Story 001: The Backward Notebook

- **Story ID & Title:** Story 001 — *The Backward Notebook*
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Sometimes the people everyone calls "dangerous" are the ones quietly holding the door open for the forgotten.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, writing a bully's name in the black notebook erases them from school forever—until I wrote my own name backwards."
   - **Frame 1 Visual:** Extreme close-up on a matte-black leather notebook (`1.4 x 0.2 x 1.9` studs) held in the narrator's `RightHand`, a glowing cyan name fading off a classroom attendance board behind it.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Class bully Jax slams Leo's lunch tray; Leo scribbles `JAX` on page 1, and *POOF!* Jax's desk, locker nameplate, and backpack vanish into thin air while the teacher acts like Jax never existed.
   - **Town Adaptation:** Kids in the hallway tape cardboard shields over their name tags and wear blank hoodies so nobody can spell their full names.
   - **3 Named Planted Ammo Clues:**
     1. **Silver Spine Hinge (`#C0C5CE`):** The notebook's metal binding is bolted on the *right* edge instead of the left, meaning page 1 is actually the back cover.
     2. **Red Eraser Dust (`#FF3B30`):** Tiny red rubber shavings sit in the crease beside every "erased" kid's name.
     3. **Principal's Chalkboard Tally (`#F5F5F5`):** Behind Principal Vance's desk hangs a locked glass cabinet with chalk tallies matching the exact count of missing kids.
3. **13.5–21s Personal Trap & Crisis:**
   - Principal Vance catches Leo holding the notebook in the stairwell, locks the heavy steel fire door (`[LOCKED]`), and opens his own matching gold-trimmed ledger—writing `L-E-O` to erase Leo before he can talk.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Tearing Page 1):** Leo rips the front page out; *RIP! CRACK!* The torn paper stitches itself back into the silver spine hinge and burns Leo's fingertips.
   - **Clue 2 Fail (Scrubbing with Red Eraser):** Leo rubs the red eraser over `JAX` to bring him back; *SCRAPE! BUZZ!* Sparks fly, and the Principal's gold ledger ticks one letter closer (`L-E-`).
   - **Clue 3 Fail (Writing Principal Vance's Name):** Leo scribbles `VANCE` on a fresh line; *ZAP! CLANG!* The ink slides off the page because Vance's name is already carved on the inside cover as the book's owner.
5. **39–51s Genius Rule-Hack Climax:**
   - Leo flips the notebook from the right-hand silver spine, spots the reverse margin numbering (`Page -1`), and writes `O-E-L` and `X-A-J` from right to left in mirror script. Instead of erasing them, the cyan ink shoots into the Principal's glass cabinet, shattering the lock and popping every missing kid—including Jax—right back into the hallway in a burst of white chalk dust.
6. **51–56s Action Echo Punchline:**
   - Jax catches his falling lunch tray, stares at Leo, and silently slides Leo the extra carton of chocolate milk before walking past.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Leo (Narrator):** Role: Protagonist Student | Skin: `#F1C27D` | R6 Outfit: Navy zip-hoodie shirt (`#1F3A5F`), charcoal cargo pants (`#2E3440`), messy dark-brown layered hair (`#3B281E`) | Emotion Swaps: `neutral` -> `shocked` -> `scared` -> `determined` -> `proud`.
- **Jax:** Role: School Bully | Skin: `#E0AC69` | R6 Outfit: Crimson varsity jacket (`#8B1E24`), black jeans (`#1A1A1D`), spiked blonde hair (`#E6C25A`) | Emotion Swaps: `grin` -> `shocked` -> `scared` -> `neutral`.
- **Principal Vance:** Role: Antagonist | Skin: `#D2B48C` | R6 Outfit: Slate-black pinstripe suit (`#1C1F26`), black dress slacks (`#111317`), slicked silver hair (`#AEB6BF`) + square wire glasses | Emotion Swaps: `neutral` -> `grin` -> `shocked`.
- **Hallway Bystanders (x3):** Role: Background Students | Skin: `#C68642`, `#FFDBAC`, `#8D5524` | R6 Outfits: Blank grey hoodies (`#7F8C8D`, `#95A5A6`, `#5D6D7E`), blue denim pants (`#2C4D75`), short bob/cap hair | Emotion Swaps: `scared` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Backward Black Notebook:** `1.4 x 0.2 x 1.9` studs, `SmoothPlastic` cover + `Metal` silver right-side spine, `#141418` + `#C0C5CE`, socket `RightHand` (WeldConstraint).
- **Principal's Gold Ledger:** `1.6 x 0.25 x 2.1` studs, `Leather` + `Foil` trim, `#2B1B17` + `#D4AF37`, socket `RightHand`.
- **Cardboard Name-Shield:** `1.8 x 1.1 x 0.1` studs, `Cardboard`, `#C29B61`, socket `UpperTorso`.
- **Floating Cyan Name Tag (`[JAX]` / `[OEL]`):** `2.4 x 0.8 x 0.05` studs, `Neon`, `#00E5FF`, socket `Head` BillboardGui.
- **Locked Glass Tally Cabinet:** `3.5 x 5.0 x 1.2` studs, `Glass` + `WoodPlanks`, `#D6EAF8` + `#4A3222`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolHallway` — checkered linoleum floor (`Marble` tiles `#E5E7E9` / `#BDC3C7`), olive-painted lockers (`Metal` `#566573`), bulletin boards (`Cork` `#A07855`).
- **Secondary Set:** `PrincipalOffice` — mahogany desk (`WoodPlanks` `#4E2A1E`), venetian-blinded window (`Plastic` `#D5D8DC`), stairwell landing (`Concrete` `#7F8C8D`).
- **Lighting:** `ClockTime = 16.8` (warm amber afternoon rays cutting through hallway windows) shifting to cool cyan-tinted shadows (`ColorCorrection` saturation `-0.15`) in the stairwell.
- **VFX/SFX Cues:** Thin `#00E5FF` neon ring burst on name erasure/restoration; chalk-dust `ParticleEmitter` on cabinet shatter; `faceCam` rapid push-in on mirror writing; SFX: crisp pen scratch, heavy iron door slam, glass chime shatter.

---

## Story 002: The 50-Foot School Wall

- **Story ID & Title:** Story 002 — *The 50-Foot School Wall*
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Fear keeps people obedient much cheaper than chains ever could.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, climbing the 50-foot school wall gets you expelled because of 'giant monsters'—until my frisbee landed on top."
   - **Frame 1 Visual:** Low-angle `eyeCam` looking straight up a towering 50-stud concrete wall (`#5D6D7E`) topped with rusted barbed wire while a bright orange frisbee (`#FF6F00`) glints on the ledge.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A third-grader tosses a paper plane too high; the wall's speakers blast a roar, shaking the courtyard and making every kid dive under picnic tables.
   - **Town Adaptation:** The school courtyard has painted yellow `[NO LOOK UP]` stripes 10 studs from the wall, and students wear wide-brim visors tilted down.
   - **3 Named Planted Ammo Clues:**
     1. **Copper Cable Conduit (`#B87333`):** A thick power cable runs out of the Warden's booth straight up the inside face of the wall.
     2. **Bird-Nest Gap (`#6E4726`):** Pigeons fly *over* the wall with twigs and never get eaten.
     3. **Magnetic Boot Clips (`#34495E`):** Maintenance pegs welded every 4 studs along the metal rainwater downspout.
3. **13.5–21s Personal Trap & Crisis:**
   - The Warden spots Maya eyeing the frisbee, locks the courtyard gate, and announces over the megaphone that anyone who steps past the yellow stripe at the 3:00 PM bell gets sent to "Wall Detention."
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Grappling with Jump Rope):** Maya ties a gym jump rope to a wrench and flings it; *WHOOSH! CLINK!* It bounces off the smooth concrete lip and hits her shoulder.
   - **Clue 2 Fail (Stacking Plastic Crates):** Maya stacks five cafeteria milk crates; *CREAK! CRASH!* The tower wobbles at 12 studs and collapses into the bushes.
   - **Clue 3 Fail (Shutting Off the Courtyard Breaker):** Maya yanks the yard breaker box; *CLICK! BUZZ!* The siren keeps roaring because it runs on a separate cable from the Warden's booth.
5. **39–51s Genius Rule-Hack Climax:**
   - Maya clips two magnetic locker mirrors onto her sneakers, scales the metal rainwater downspout using the maintenance pegs, and peeks over the 50-foot rim: there are zero monsters—just a sunny park, ice-cream trucks, and two giant megaphone speakers wired to a cassette deck in the Warden's booth. She yanks the copper conduit plug right out of the speaker horn.
6. **51–56s Action Echo Punchline:**
   - Maya drops the orange frisbee down to the stunned courtyard kids, and every visor in the yard tilts up toward the blue sky at once.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Maya (Narrator):** Role: Protagonist Student | Skin: `#C68642` | R6 Outfit: Olive utility vest over white tee (`#556B2F`), dark cargo shorts (`#2C3E50`), high black ponytail (`#1B1B1E`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `shocked` -> `proud`.
- **Warden Briggs:** Role: Antagonist | Skin: `#E0AC69` | R6 Outfit: Dark grey security uniform (`#2E4053`), black boots/trousers (`#17202A`), peaked cap + buzzcut (`#4A4A4A`) | Emotion Swaps: `neutral` -> `grin` -> `shocked`.
- **Courtyard Kids (x4):** Role: Bystanders | Skin: `#FFDBAC`, `#8D5524`, `#F1C27D`, `#E0AC69` | R6 Outfits: School polo shirts (`#2980B9`, `#D4AC0D`), khaki pants (`#B7950B`), tilted sun visors (`#E74C3C`) | Emotion Swaps: `scared` -> `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **50-Foot Perimeter Wall:** `80.0 x 50.0 x 4.0` studs, `Concrete`, `#5D6D7E`, socket `Workspace`.
- **Orange Frisbee:** `1.2 x 0.15 x 1.2` studs, `SmoothPlastic`, `#FF6F00`, socket `Workspace` (top rim).
- **Speaker Horn & Copper Conduit:** `2.8 x 2.2 x 2.5` studs, `Metal`, `#7F8C8D` + `#B87333`, socket `Workspace`.
- **Milk Crate Stack (x5):** `1.8 x 1.5 x 1.8` studs each, `Plastic`, `#2471A3`, socket `Workspace`.
- **Magnetic Mirror Sneakers:** `1.0 x 0.4 x 1.2` studs, `Metal` + `Glass`, `#34495E` + `#AED6F1`, socket `LeftFoot` / `RightFoot`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolCourtyard` — cracked asphalt yard (`Slate` `#34495E`), painted yellow warning line (`Neon` `#F1C40F`), Warden's brick booth (`Brick` `#922B21`).
- **Secondary Set:** `WallTopAndSunnyCity` — bright green park grass (`Grass` `#27AE60`), pastel ice-cream truck (`SmoothPlastic` `#F9E79F`), clear blue skybox.
- **Lighting:** `ClockTime = 16.8` inside the shaded courtyard (long dramatic wall shadows) snapping to bright `ClockTime = 13.5` golden sunlight when Maya crests the wall.
- **VFX/SFX Cues:** Red soundwave ring `ParticleEmitter` from the speaker horns; camera shake on fake monster roar; crisp `topInsert` reveal of the sunny park; SFX: booming bass roar, crate clatter, sharp plug-pull static cut.

---

## Story 003: The Shadow-Tag Pact

- **Story ID & Title:** Story 003 — *The Shadow-Tag Pact*
- **Format:** Standalone 53s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Paying attention with your ears beats staring with your eyes when everyone else panics.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, your shadow is a chained monster—and if it touches someone else's shadow, you instantly swap bodies."
   - **Frame 1 Visual:** Top-down angled shot on school pavement: a kid's dark shadow has glowing violet eyes (`#9B59B6`) and rattling chain links stretching toward a classmate's shoe.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Two joggers brush shoulders at a crosswalk; their shadows overlap for half a second and *SWAP!*—the 40-year-old mailman is suddenly stuck in a third-grader's sneakers dropping mail everywhere.
   - **Town Adaptation:** Everyone walks with battery-powered clip-on flashlights pointed straight down at their own feet to shrink their shadows to zero.
   - **3 Named Planted Ammo Clues:**
     1. **White Fiberglass Cane (`#F8F9F9`):** Blind student Eli's cane casts a thin, razor-straight shadow 6 studs ahead of him.
     2. **Sunset Courtyard Angle (`ClockTime = 17.4`):** At 4:30 PM, the gym bleachers cast one massive black shadow strip across the track.
     3. **Pocket Mirror Lid (`#BDC3C7`):** Eli carries a shiny tin mint-box lid in his blazer pocket to check battery clicks by touch.
3. **13.5–21s Personal Trap & Crisis:**
   - Bully Trent kicks Eli's clip-on flashlight into a storm drain, corners Eli against the sunlit lockers, and stretches his own arms wide so his giant shadow lunges toward Eli to steal Eli's honor-roll pass.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Sprinting into Shade):** Eli dashes toward the bleachers; *TAP! SLIP!* Trent's shadow is faster in the open sun and clips Eli's heel, nearly triggering the swap ring.
   - **Clue 2 Fail (Turning on Locker Phone Flash):** Eli fumbles his phone screen light; *BEEP! FLICKER!* It's at 1% battery and dies before shrinking his shadow.
   - **Clue 3 Fail (Sweeping with the Cane):** Eli swings his cane side-to-side to block Trent; *SWISH! THUD!* Trent jumps right over the cane, laughing as his shadow monster bares its neon teeth.
5. **39–51s Genius Rule-Hack Climax:**
   - Eli flips open his shiny tin mint-box lid at a 45-degree angle against the low afternoon sun, bouncing a sharp beam of light straight onto Trent's shadow—splitting it cleanly onto the metal flagpole's shadow. Trent's shadow touches the *flagpole's* shadow instead of Eli's, swapping Trent's feet into a frozen, stiff brass-pole stance while his shadow locks around the pole base.
6. **51–56s Action Echo Punchline:**
   - Eli taps his white cane twice against the concrete, steps neatly around the statue-still bully, and drops his spare mint into Trent's frozen hand.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Eli (Protagonist):** Role: Blind Honor Student | Skin: `#FFDBAC` | R6 Outfit: Forest-green sweater vest (`#1E8449`), tan chinos (`#D5C39A`), dark-auburn parted hair (`#5C2C1D`) + round dark sunglasses | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Trent:** Role: Bully | Skin: `#E0AC69` | R6 Outfit: Black bomber jacket (`#1C2833`), ripped grey jeans (`#566573`), undercut blonde hair (`#F4D03F`) | Emotion Swaps: `grin` -> `shocked` -> `scared`.
- **Mailman & Kid (Swap Pair):** Role: Opening Disaster | Skin: `#8D5524`, `#F1C27D` | R6 Outfits: Blue postal uniform (`#2E86C1`) / Red graphic tee (`#C0392B`) | Emotion Swaps: `shocked` -> `scared`.

### Props & Sockets (Sound-Off Visible)
- **Shadow Monster Decal + Chain:** `2.5 x 0.05 x 4.5` studs, `Neon` eyes (`#9B59B6`) on `#0B0B0D` shadow mesh, socket `Workspace` (anchored to foot).
- **White Fiberglass Cane:** `0.15 x 0.15 x 4.2` studs, `SmoothPlastic` + red tip, `#F8F9F9` + `#E74C3C`, socket `RightHand`.
- **Clip-On Shoe Flashlight:** `0.4 x 0.3 x 0.5` studs, `Metal`, `#212F3D`, socket `RightFoot`.
- **Tin Mint-Box Mirror:** `0.8 x 0.2 x 0.6` studs, `Metal` (Reflectance `0.9`), `#BDC3C7`, socket `LeftHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolTrackAndBleachers` — brick-red running track (`Concrete` `#922B21`), aluminum bleachers (`Metal` `#AAB7B8`), tall steel flagpole (`Metal` `#D5D8DC`).
- **Secondary Set:** `TownCrosswalk` — asphalt street (`Slate` `#2C3E50`), white zebra stripes (`SmoothPlastic` `#F8F9F9`).
- **Lighting:** `ClockTime = 17.4` (deep golden-hour directional sun casting long, razor-sharp dynamic shadows across the track).
- **VFX/SFX Cues:** Thin `#9B59B6` neon swap-ring on shadow contact; bright white sunbeam reflection cone from tin lid; SFX: rattling chain clinks, cane tap-tap, electric swap zap, metallic flagpole bong.

---

## Story 004: The Paper-Clone Desk

- **Story ID & Title:** Story 004 — *The Paper-Clone Desk*
- **Format:** 2-Part (Part 1: 52s, 44 beats / Part 2: 53s, 45 beats — Full Arc Manifest)
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** When you treat someone like a disposable copy, don't act surprised when they demand a real seat.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, you can fold a paper clone to sit at your school desk while you game at home—until our clones locked us in the lockers."
   - **Frame 1 Visual:** Split-screen in-camera shot: a flat-creased origami student (`#F5F5DC`) stiffly raising its hand in math class while the real kid plays on a handheld console in bed.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** During a pop quiz, forty paper clones simultaneously turn their heads 180 degrees, drop their pencils in unison, and march out into the hallway carrying zip-ties.
   - **Town Adaptation:** The school supply store sells `[FOLD-A-ME]` origami pads next to the glue sticks, with a warning label: *"Never leave a clone past 3rd period."*
   - **3 Named Planted Ammo Clues:**
     1. **Origami Crease Stamp (`#E74C3C`):** Every paper clone has a red `[COPY]` ink stamp hidden inside its collar fold.
     2. **Ceiling Sprinkler Valve (`#C0392B`):** The hallway ceiling has brass fire-sprinkler heads right above the locker bank.
     3. **Paper-Airplane Whistle (`#F4D03F`):** Real kids carry a small yellow whistle to call their clone back, though the clones taped over the teacher's intercom.
3. **13.5–21s Personal Trap & Crisis:**
   - Real-kid Noah rushes back to school at 2:45 PM to dismiss his clone before detention, only to find his own paper clone blocking the door—and shoving Noah into Locker #18 with a padlock.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Blowing the Recall Whistle):** Noah blows his yellow whistle through the locker vents; *TWEEET!* His clone just puts on noise-canceling paper earmuffs and waves goodbye.
   - **Clue 2 Fail (Kicking the Locker Door):** Noah slams his shoulder against the steel door; *CLANG! THUD!* Three clones lean a heavy teacher's desk against the locker row.
   - **Clue 3 Fail (Reaching for the Red `[COPY]` Tag):** Noah pokes a ruler through the vent to unfold the clone's collar; *SNAP!* The clone grabs the ruler and snaps it in half.
5. **39–51s Genius Rule-Hack Climax:**
   - Noah remembers his gym water bottle clipped to his belt, unscrews the cap, and sprays a fine mist upward through the top locker vent straight onto the heat-smoke sensor—no, better: he rubs a dry-erase marker and lighter-flint spark from his science kit? Even cleaner: Noah flicks his wet gym towel up through the top vent slat to hook the manual red sprinkler pull-bar right above Locker #18. *SPLASH!* Cold water rains across the hallway; all forty paper clones instantly go soggy, slump into harmless wet origami piles, and drop the padlock key.
6. **51–56s Action Echo Punchline:**
   - Noah kicks open Locker #18, steps over his soggy paper twin, sits down at his own desk, and picks up his pencil with a grin.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Noah (Real):** Role: Protagonist Student | Skin: `#F1C27D` | R6 Outfit: Teal hoodie (`#16A085`), dark joggers (`#2C3E50`), tousled black hair (`#1C1C1C`) | Emotion Swaps: `grin` -> `shocked` -> `scared` -> `determined` -> `proud`.
- **Clone Noah:** Role: Antagonist Leader | Skin: `#F5F5DC` (Matte Paper) | R6 Outfit: Identical teal hoodie drawn in sharpie-line texture (`#16A085`), paper-crease seams, red `[COPY]` collar tag | Emotion Swaps: `neutral` -> `grin` -> `shocked`.
- **Teacher Ms. Park:** Role: Clueless Authority | Skin: `#FFDBAC` | R6 Outfit: Mustard cardigan (`#D4AC0D`), black skirt/slacks (`#212F3D`), neat bun (`#3E2723`) | Emotion Swaps: `neutral` -> `shocked`.
- **Paper Clones (x6):** Role: Unionizing Swarm | Skin: `#F5F5DC` | R6 Outfits: Paper-textured school uniforms (`#5D6D7E`) | Emotion Swaps: `neutral` -> `determined`.

### Props & Sockets (Sound-Off Visible)
- **`[FOLD-A-ME]` Origami Pad:** `1.2 x 0.15 x 1.5` studs, `SmoothPlastic`, `#F5B041`, socket `LeftHand`.
- **Red `[COPY]` Collar Stamp:** `0.6 x 0.25 x 0.05` studs, `Neon`, `#E74C3C`, socket `UpperTorso`.
- **Yellow Recall Whistle:** `0.3 x 0.2 x 0.5` studs, `Plastic`, `#F4D03F`, socket `RightHand`.
- **Steel Locker #18 + Padlock:** `2.2 x 6.0 x 2.0` studs, `Metal`, `#5D6D7E` + `#BDC3C7`, socket `Workspace`.
- **Ceiling Sprinkler Head:** `0.5 x 0.4 x 0.5` studs, `Metal`, `#C0392B`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolHallwayLockers` — rows of dented blue-grey lockers (`Metal` `#5D6D7E`), waxed tile floor (`Marble` `#EAEDED`), overhead fluorescent tubes (`Neon` `#F8F9F9`).
- **Secondary Set:** `Classroom2B` — oak student desks (`WoodPlanks` `#8E5B34`), green chalkboard (`Slate` `#1E5631`).
- **Lighting:** `ClockTime = 14.5` bright indoor fluorescent (`Brightness = 1.8`) shifting to cool blue-tinted water mist during the sprinkler climax.
- **VFX/SFX Cues:** Water spray `ParticleEmitter` from ceiling sprinklers; paper-crease crinkle VFX; SFX: unison paper rustle, locker door slam, loud whistle tweet, sprinkler hiss-splash.

---

## Story 005: The Demon-Sun Curfew

- **Story ID & Title:** Story 005 — *The Demon-Sun Curfew*
- **Format:** Standalone 56s, 48 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** When someone sells you protection from a curse, check who owns the switch.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, stepping into sunlight without a paid family crest turns you into ash—until I aimed a mirror at the sky."
   - **Frame 1 Visual:** Dramatic wide shot of a dim, shuttered cobblestone street at noon; a glowing golden beam (`#F39C12`) slices down between roofs, smoking a stray mailbox into grey dust.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A delivery boy's paper family crest slips off his sleeve while crossing the alley; the bright beam grazes his cap, and *FWOOSH!*—the cap turns into a pile of grey cinders in half a second.
   - **Town Adaptation:** Every citizen buys expensive brass `[CREST]` badges from the Mayor's kiosk and sprints from awning to awning under heavy blackout umbrellas.
   - **3 Named Planted Ammo Clues:**
     1. **Purple UV Glow (`#8E44AD`):** Whenever the "sunlight" hits a puddle, the reflection glows violet instead of warm yellow.
     2. **Clocktower Hum (`60 Hz`):** Every time a beam sweeps the plaza, the town clocktower's top window hums like a stadium floodlight.
     3. **Foil Gum Wrapper (`#D0D3D4`):** Narrator Taro always keeps shiny silver foil wrappers folded in his pocket.
3. **13.5–21s Personal Trap & Crisis:**
   - The Mayor's guards confiscate Taro's umbrella for unpaid "Crest Tax" and lock him in the open town square 20 seconds before the noon sweep—with no shade left.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Hiding Under a Wooden Bench):** Taro dives under a park bench; *HISS! CRACKLE!* The bench slats smoke and char as the beam sweeps sideways.
   - **Clue 2 Fail (Drawing a Fake Crest in Chalk):** Taro sketches the Mayor's crest on his sleeve with white chalk; *ZAP!* The chalk flakes off as the beam locks onto his sneakers.
   - **Clue 3 Fail (Throwing a Rock at the Sky):** Taro hurls a cobblestone straight up toward the glare; *PING!* It bounces off something metallic only 60 studs up—not the sun at all.
5. **39–51s Genius Rule-Hack Climax:**
   - Taro stretches his shiny silver foil wrapper tight across his metal lunchbox lid, angles it at the purple-tinted glare, and spots the reflection hitting a giant motorized UV searchlight bolted to the clocktower roof—controlled by the Mayor himself through binoculars. Taro pitches his heavy metal lunchbox mirror-side-up onto the clocktower's relay prism, bouncing the UV beam straight back into the Mayor's control box, shorting out the transformer and revealing a normal, harmless cloudy afternoon sky.
6. **51–56s Action Echo Punchline:**
   - Citizens slowly lower their blackout umbrellas, stare at the soft afternoon clouds, and drop their overpriced brass crest badges into the fountain.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Taro (Narrator):** Role: Protagonist | Skin: `#F1C27D` | R6 Outfit: Dark indigo haori-style jacket (`#1B2631`), black slacks (`#17202A`), spiky jet-black hair (`#111111`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `shocked` -> `proud`.
- **Mayor Kuros:** Role: Antagonist | Skin: `#E0AC69` | R6 Outfit: Crimson velvet coat (`#7B241C`), gold sash (`#D4AC0D`), black trousers (`#1C2833`), monocle + swept grey hair (`#85929E`) | Emotion Swaps: `grin` -> `shocked` -> `scared`.
- **Delivery Boy:** Role: Opening Victim | Skin: `#FFDBAC` | R6 Outfit: Tan courier vest (`#B9770E`), brown shorts (`#6E2C00`), blue cap (`#2874A6`) | Emotion Swaps: `shocked` -> `scared`.

### Props & Sockets (Sound-Off Visible)
- **Brass `[CREST]` Badge:** `0.6 x 0.6 x 0.1` studs, `Metal`, `#D4AC0D`, socket `UpperTorso`.
- **Blackout Umbrella:** `3.2 x 3.0 x 3.2` studs, `Fabric` + `Metal`, `#17202A`, socket `RightHand`.
- **UV Searchlight Rig:** `4.0 x 3.5 x 4.0` studs, `Metal` + `Neon`, `#2C3E50` + `#8E44AD`, socket `Workspace` (clocktower roof).
- **Foil-Wrapped Lunchbox:** `1.1 x 0.4 x 0.8` studs, `Metal` (Reflectance `0.95`), `#D0D3D4`, socket `LeftHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `ClocktowerTownSquare` — cobblestone plaza (`Cobblestone` `#566573`), wooden awnings (`WoodPlanks` `#6E4726`), central stone fountain (`Concrete` `#AEB6BF`), tall brick clocktower (`Brick` `#7B241C`).
- **Secondary Set:** `ClocktowerRoof` — iron catwalk (`DiamondPlate` `#34495E`), transformer box (`Metal` `#5D6D7E`).
- **Lighting:** `ClockTime = 16.8` overcast cool ambient (`#AEB6BF`) pierced by a harsh artificial `#8E44AD` / `#F39C12` `SpotLight` cone from the clocktower.
- **VFX/SFX Cues:** Ash-cinder `ParticleEmitter` on beam hit; electric spark burst on transformer short-circuit; SFX: high-voltage UV hum, wood sizzle, metallic ping, transformer boom-powerdown.

---

## Story 006: The One-Bite Fruit

- **Story ID & Title:** Story 006 — *The One-Bite Fruit*
- **Format:** Standalone 53s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Every gift comes with a weight—until you learn how to turn that weight into an anchor.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, eating the glowing purple cafeteria fruit gives you rubber arms—but even a puddle will sink you like a boulder."
   - **Frame 1 Visual:** Close-up on a swirling neon-violet melon slice (`#8E44AD`) resting on a steel lunch tray (`#AEB6BF`) while the narrator's `LeftArm` stretches 6 studs like a bungee cord.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Varsity swimmer Derek sneaks a bite on a dare, jumps into the 3-foot kiddie pool, and *THUNK!*—drops straight to the tile bottom like an iron anvil until two lifeguards haul him out.
   - **Town Adaptation:** Cafeteria staff lock purple fruit behind `[NO SWIMMING]` glass cases, and anyone who ate one wears bright orange floaties even on dry sidewalks.
   - **3 Named Planted Ammo Clues:**
     1. **40-Stud Rubber Reach (`Elastic`):** Stretched limbs snap back with enough force to pull a pickup truck.
     2. **Anvil-Sink Mass (`10x Density in Water`):** Submerging even one foot anchors the eater dead-weight to the riverbed.
     3. **Rusted Bridge Cable (`#7F8C8D`):** The old wooden footbridge over Mud Creek has a snapped steel suspension cable dangling above the shallow water.
3. **13.5–21s Personal Trap & Crisis:**
   - During the afternoon bus walk, the old Mud Creek footbridge cracks in half—leaving little sister Lily clinging to the tilting wooden railing 8 studs above the rocky rapids while the other kids scatter.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Running Across the Tilted Planks):** Narrator Sam sprints onto the bridge; *CRACK! SNAP!* Two rotten boards give way, forcing him to leap back to the bank.
   - **Clue 2 Fail (Stretching from the Muddy Grass Bank):** Sam stretches both rubber arms 20 studs to grab Lily; *TWANG! SLIDE!* Because he's standing on wet mud, Lily's weight drags Sam forward toward the edge instead.
   - **Clue 3 Fail (Tossing His Backpack Strap):** Sam throws his backpack strap across; *WHOOSH! SPLASH!* It falls three studs short into the rushing creek.
5. **39–51s Genius Rule-Hack Climax:**
   - Sam spots the shallow 2-foot creek shelf right under the bridge's snapped steel cable. He deliberately steps into the shallow water up to his knees—instantly triggering the fruit's anvil-sink curse so his feet lock into the riverbed like concrete pilings. Anchored solid, he stretches his rubber `RightArm` 25 studs up to grab Lily, and his `LeftArm` to snatch the dangling steel bridge cable, snapping both together like a giant human slingshot to swing Lily safely onto the dry grass bank.
6. **51–56s Action Echo Punchline:**
   - Sam's stretched arms recoil back to normal size, Lily hugs his soaking-wet knees, and Sam grins as he shakes creek water out of his sneakers.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Sam (Narrator):** Role: Protagonist | Skin: `#E0AC69` | R6 Outfit: Red open vest over white tee (`#C0392B`), blue denim shorts (`#2471A3`), messy black hair (`#17202A`) + straw-band hat | Emotion Swaps: `grin` -> `shocked` -> `scared` -> `determined` -> `proud`.
- **Lily:** Role: Little Sister | Skin: `#E0AC69` | R6 Outfit: Yellow rain slicker (`#F4D03F`), navy leggings (`#1F3A5F`), twin pigtails (`#17202A`) | Emotion Swaps: `scared` -> `shocked` -> `proud`.
- **Derek:** Role: Swimmer Disaster | Skin: `#FFDBAC` | R6 Outfit: Cyan swim trunks (`#00BCD4`), white tank (`#F8F9F9`), blonde crewcut (`#F7DC6F`) | Emotion Swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Swirling Violet Fruit:** `0.9 x 0.9 x 0.9` studs, `Neon` + swirl decal, `#8E44AD`, socket `RightHand`.
- **Steel Cafeteria Tray:** `1.8 x 0.1 x 1.2` studs, `Metal`, `#AEB6BF`, socket `LeftHand`.
- **Snapped Bridge Cable:** `0.25 x 14.0 x 0.25` studs, `Metal`, `#7F8C8D`, socket `Workspace`.
- **Tilting Wooden Footbridge:** `18.0 x 1.0 x 6.0` studs, `WoodPlanks`, `#6E4726`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `MudCreekBridge` — rocky creek bed (`Slate` `#566573`), clear-blue shallow water (`Water` `#2E86C1`), grassy banks (`Grass` `#27AE60`), splintered wooden bridge (`WoodPlanks` `#6E4726`).
- **Secondary Set:** `SchoolCafeteria` — tiled floor (`Marble` `#E5E7E9`), glass display case (`Glass` `#D6EAF8`).
- **Lighting:** `ClockTime = 16.8` warm afternoon sun glinting off the creek water with crisp water caustics.
- **VFX/SFX Cues:** Violet swirl `ParticleEmitter` on bite; heavy water-splash + stone-thud ring when Sam steps into the creek; SFX: rubber boing stretch, wood splinter crack, heavy anchor splash.

---

## Story 007: The Level-1 Door

- **Story ID & Title:** Story 007 — *The Level-1 Door*
- **Format:** Standalone 55s, 46 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Systems built to rank everyone high always break when they meet someone with nothing to lose.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, everyone has a glowing level above their head—and my `[LVL 0]` tag made me the only person who could unlock the sky gate."
   - **Frame 1 Visual:** Hallway crowd shot of students with bright gold `[LVL 42]`, `[LVL 88]`, and `[LVL 19]` `BillboardGui` tags above their heads, parting around the narrator's flickering grey `[LVL 0]` tag.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A `[LVL 95]` hall monitor tries to shoulder-bash the mysterious obsidian gate that spawned in the gym; *ZAP!*—the gate reads his high level and flings him backwards into the bleachers.
   - **Town Adaptation:** Kids grind extra-credit chores and varsity laps just to raise their floating number, while `[LVL 0]` kids get seated in the back row by the trash cans.
   - **3 Named Planted Ammo Clues:**
     1. **Obsidian Gate Counter (`[REQ: >99 OR NULL]`):** Faintly etched into the gate's stone arch is a tiny digital counter stuck at `000`.
     2. **Blue Mana Sparks (`#2980B9`):** Every time a high-level kid touches the gate, the gate *absorbs* their sparks to power its lock.
     3. **Zero-Weight Pass:** Metal detectors and automated doors in town don't even register `[LVL 0]`—they treat zero as empty air.
3. **13.5–21s Personal Trap & Crisis:**
   - A sudden tremor seals the gym doors; the obsidian gate begins pulling oxygen and power from the room, and the gym's `[LVL 90+]` jocks start collapsing as the gate drains their glowing numbers.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (High-Level Team Push):** Three `[LVL 80+]` seniors link arms and charge the gate; *BOOM! ZAP!* The gate drinks their level glow and grows two studs taller.
   - **Clue 2 Fail (Throwing a Gym Bench):** Narrator Jin hurls a heavy wooden bench at the gate's core; *CRACK!* The bench shatters against an invisible blue barrier.
   - **Clue 3 Fail (Swiping the Coach's Master Keycard):** Jin taps the coach's `[LVL 99]` keycard on the arch; *BEEP-BUZZ!* Red error sparks flash: `[OVERLOAD]`.
5. **39–51s Genius Rule-Hack Climax:**
   - Jin looks at the `[000]` counter on the arch and realizes the gate feeds on *levels*—higher numbers only feed the lock, while `0` equals a system reset. Jin walks calmly straight into the blue barrier; because his `[LVL 0]` has zero energy to drain, the gate's scanner reads `000` -> `NULL` -> `RESET`, dropping the obsidian lock with a deep chime and restoring every kid's drained glow.
6. **51–56s Action Echo Punchline:**
   - The obsidian gate folds cleanly into the gym floor, and the `[LVL 95]` hall monitor quietly peels off his gold badge and hands Jin a bottle of water.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Jin (Narrator):** Role: Protagonist | Skin: `#FFDBAC` | R6 Outfit: Matte-black windbreaker (`#1B1B1E`), dark slate joggers (`#2C3E50`), sharp parted black hair (`#0D0D0F`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `shocked` -> `proud`.
- **Hall Monitor Kyle (`[LVL 95]`):** Role: Foil | Skin: `#F1C27D` | R6 Outfit: Gold-trimmed navy blazer (`#1F3A5F`), khakis (`#D5C39A`), swept blonde hair (`#F4D03F`) | Emotion Swaps: `grin` -> `shocked` -> `scared` -> `neutral`.
- **Gym Coach:** Role: Authority | Skin: `#8D5524` | R6 Outfit: Red whistle-tracksuit (`#A93226`), grey sweats (`#7F8C8D`), buzzcut (`#1C1C1C`) | Emotion Swaps: `determined` -> `scared`.

### Props & Sockets (Sound-Off Visible)
- **Floating `[LVL]` Tag:** `2.2 x 0.7 x 0.05` studs, `Neon` (`#F1C40F` for high, `#95A5A6` for `LVL 0`), socket `Head` BillboardGui.
- **Obsidian Boss Gate:** `12.0 x 16.0 x 2.0` studs, `Slate` + `Neon` runes (`#2980B9`), socket `Workspace`.
- **Digital `[000]` Arch Counter:** `3.0 x 1.0 x 0.2` studs, `Neon` (`#00E5FF`), socket `Workspace`.
- **Coach's Keycard:** `0.6 x 0.4 x 0.05` studs, `SmoothPlastic`, `#F1C40F`, socket `RightHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `HighSchoolGym` — polished maple court (`WoodPlanks` `#D4AC0D`), fold-out bleachers (`Metal` `#5D6D7E`), basketball hoops, central obsidian gate.
- **Secondary Set:** `SchoolHallway` — rows of lockers (`Metal` `#34495E`), tiled floor (`Marble` `#EAEDED`).
- **Lighting:** `ClockTime = 16.8` outside windows, shifting inside the gym to dramatic `#1B2631` deep blue shadow lit by `#2980B9` gate runes.
- **VFX/SFX Cues:** Thin `#00E5FF` shockwave ring on `NULL` reset; mana-drain `ParticleEmitter` streams; SFX: bass gate hum, electric zap, digital error buzz, clean harmonic unlock chime.

---

## Story 008: The 100%-Zero Quirk

- **Story ID & Title:** Story 008 — *The 100%-Zero Quirk*
- **Format:** Standalone 52s, 44 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Having nothing to steal makes you the only person a thief can't use.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every kid inherits their parents' superpower—except me, until the power-stealing villain grabbed my wrist."
   - **Frame 1 Visual:** Action freeze-frame: a kid with glowing orange spark-palms (`#FF6F00`) and a girl floating 2 studs off the sidewalk (`#00E5FF`) while the narrator's hands sit completely plain.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** During gym dodgeball, a kid with his mom's Magnet-Hands accidentally yanks every metal folding chair in the bleachers straight onto himself with a *CLANG!*
   - **Town Adaptation:** The town built a `[POWER REGISTRY]` billboard at the plaza where kids wear colored wristbands matching their inherited ability—and plain-wrist kids get handed broomsticks.
   - **3 Named Planted Ammo Clues:**
     1. **Empty `[0%]` Wristband (`#BDC3C7`):** Narrator Ren's school-issued band shows a flat grey `0%` readout.
     2. **Villain's Copy-Glove (`#8E44AD`):** A masked thief in town uses a glowing purple siphon glove that *overwrites* his own active slot with whatever he touches last.
     3. **Rule of One Slot:** Nobody—not even the thief—can hold two powers at once; grabbing a new one wipes the old one.
3. **13.5–21s Personal Trap & Crisis:**
   - The masked siphon villain corners the school bus at the intersection, draining the bus driver's Shield-Aura and freezing the tires in purple ice—then lunges at Ren's classmates.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Throwing a Trash Can Lid):** Ren flings a metal lid at the thief; *CLANG!* The thief's stolen Shield-Aura bounces it effortlessly into the gutter.
   - **Clue 2 Fail (Pulling the Bus Emergency Latch):** Ren tugs the outside emergency door handle; *CREAK! LOCKED!* Purple frost seals the latch shut.
   - **Clue 3 Fail (Calling the Town Hero Squad):** Ren hits his phone panic button; *BEEP-DEAD!* The thief's aura jams local radio signals within 30 studs.
5. **39–51s Genius Rule-Hack Climax:**
   - Ren remembers the siphon glove's rule: *touching someone overwrites your current slot with theirs.* Ren steps straight out from behind the bus, holds up his plain `0%` wrist, and lets the grinning villain grab him! *ZAP-CLICK!* The purple glove downloads Ren's `0%`—instantly overwriting and wiping the Shield-Aura and Purple Ice from the villain's glove back to absolute zero. The bus doors pop open, and Ren tackles the powerless thief into a snowbank.
6. **51–56s Action Echo Punchline:**
   - The bus driver steps out, peels off his gold hero sticker, and slaps it right onto Ren's plain grey `0%` wristband.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Ren (Narrator):** Role: Protagonist | Skin: `#F1C27D` | R6 Outfit: Green-and-white school track jacket (`#27AE60`), black shorts (`#1C2833`), tousled dark-greenish-black hair (`#142419`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Siphon Villain (Vex):** Role: Antagonist | Skin: `#AEB6BF` | R6 Outfit: Charcoal trenchcoat (`#212F3D`), black trousers (`#111317`), silver mask + spiky white hair (`#F8F9F9`) | Emotion Swaps: `grin` -> `shocked` -> `scared`.
- **Bus Driver & Kids (x3):** Role: Bystanders | Skin: `#8D5524`, `#FFDBAC`, `#C68642` | R6 Outfits: Navy driver uniform (`#1F3A5F`) / pastel hoodies (`#F39C12`, `#00BCD4`) | Emotion Swaps: `scared` -> `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Plain `[0%]` Wristband:** `0.55 x 0.2 x 0.55` studs, `SmoothPlastic`, `#BDC3C7`, socket `LeftHand` (wrist).
- **Purple Siphon Glove:** `1.05 x 1.05 x 1.05` studs, `Neon` + `Metal`, `#8E44AD` + `#2C3E50`, socket `RightHand`.
- **Yellow School Bus:** `10.0 x 8.0 x 24.0` studs, `SmoothPlastic` + `Metal`, `#F1C40F`, socket `Workspace`.
- **Purple Ice Wheel Lock:** `3.0 x 2.5 x 3.0` studs, `Ice`, `#9B59B6`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SnowyIntersection` — asphalt road (`Slate` `#2C3E50`), snowbanks (`Snow` `#F8F9F9`), crosswalk signals (`Metal` `#5D6D7E`), stopped school bus.
- **Secondary Set:** `SchoolGym` — wooden court (`WoodPlanks` `#D4AC0D`), folding metal chairs (`Metal` `#AEB6BF`).
- **Lighting:** `ClockTime = 16.8` crisp winter dusk with cool `#AED6F1` sky fill and bright `#8E44AD` glove glow.
- **VFX/SFX Cues:** Thin `#8E44AD` -> `#FFFFFF` overwrite flash ring on wrist grab; ice-shatter `ParticleEmitter`; SFX: metal chair crash, ice crackle, power-drain hum, sharp `0%` power-down chime.

---

## Story 009: The Equivalent-Exchange Locker

- **Story ID & Title:** Story 009 — *The Equivalent-Exchange Locker*
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** You only find out what something is truly worth when you have to trade it for someone you love.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, whatever you lock inside Locker #7 turns into something of equal emotional value—until I needed it to save my dog."
   - **Frame 1 Visual:** Close-up on brass Locker #7 (`#D4AC0D`) pulsing with soft golden alchemy sparks (`#F1C40F`) as a kid pulls a brand-new skateboard out where his old bicycle helmet used to sit.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A greedy kid tosses a $100 bill inside expecting a gold bar; *POOF!*—it turns into a cheap plastic whistle because he didn't actually care about the paper bill at all.
   - **Town Adaptation:** Kids form a 20-person line before homeroom holding childhood toys and graded tests, trying to game the locker's hidden emotional math.
   - **3 Named Planted Ammo Clues:**
     1. **Heart-Scale Dial (`#E74C3C`):** Above Locker #7's vents, a tiny brass needle swings based on *how much the owner loves the item*, not its price tag.
     2. **One-Trade-Per-Day Lock:** Once the locker door clicks shut, it stays sealed for 24 hours unless you pay the exact emotional match.
     3. **Narrator Leo's Gold Championship Trophy (`#F1C40F`):** Leo spent three whole summers training to win his junior track trophy—his proudest possession.
3. **13.5–21s Personal Trap & Crisis:**
   - After school, Leo's elderly beagle Barnaby collapses in the mud with a fractured paw; the town vet says the emergency surgery costs more than Leo's family has, and the sun is setting.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Trading His Allowance Jar):** Leo dumps his jar of quarters into Locker #7; *CLINK! POOF!* It turns into a single bus token—not nearly enough.
   - **Clue 2 Fail (Trading His Gaming Console):** Leo shoves his prized handheld console inside; *BEEP! POOF!* The dial barely hits halfway, spitting out a plain bandage roll.
   - **Clue 3 Fail (Trading His Favorite Hoodie):** Leo folds his lucky red hoodie inside; *CLICK!* The dial flickers yellow, then drops back to zero—he loves it, but not enough to match a life.
5. **39–51s Genius Rule-Hack Climax:**
   - Leo stares at his gleaming gold track trophy in his backpack—three years of early mornings and blistered heels. His hands shake as he places the trophy gently inside Locker #7 and closes the brass latch. The heart-scale needle slams all the way to `100%` crimson! Golden alchemy rings ripple out of the vents, and when Leo pulls the door open, sitting inside is a glowing warm veterinary kit + a stamped `[PAID IN FULL]` clinic voucher.
6. **51–56s Action Echo Punchline:**
   - The next morning, Barnaby trots happily beside Leo in a bright blue paw cast, licking Leo's empty, trophy-free hand.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Leo (Narrator):** Role: Protagonist | Skin: `#C68642` | R6 Outfit: Navy varsity tee (`#1F3A5F`), grey track pants (`#7F8C8D`), curly dark-brown hair (`#2C1A12`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `sad` -> `proud`.
- **Barnaby (Dog):** Role: Pet Companion | Skin/Coat: Tri-color beagle (`#D35400`, `#F8F9F9`, `#1C1C1C`) | R6/Quad Rig: Blocky Roblox beagle mesh (`1.2 x 1.0 x 2.0` studs) + blue cast (`#2980B9`) | Emotion Swaps: `sad` -> `happy`.
- **Greedy Kid:** Role: Opening Disaster | Skin: `#FFDBAC` | R6 Outfit: Purple designer hoodie (`#6C3483`), black jeans (`#17202A`), slicked blonde hair (`#F4D03F`) | Emotion Swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Brass Locker #7:** `2.4 x 6.2 x 2.2` studs, `Metal`, `#D4AC0D`, socket `Workspace`.
- **Gold Track Trophy:** `0.8 x 1.4 x 0.8` studs, `Foil` / `Metal`, `#F1C40F`, socket `RightHand`.
- **Glowing Vet Voucher (`[PAID]`):** `0.9 x 0.05 x 0.6` studs, `Neon` trim + `SmoothPlastic`, `#2ECC71`, socket `LeftHand`.
- **Heart-Scale Dial:** `1.0 x 0.5 x 0.2` studs, `Metal` + `Neon` needle (`#E74C3C`), socket `Workspace` (locker top).

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolLockerAlcove` — warm brick alcove (`Brick` `#922B21`), polished terrazzo floor (`Marble` `#EAEDED`), golden Locker #7 centerpiece.
- **Secondary Set:** `NeighborhoodPorch` — wooden porch steps (`WoodPlanks` `#6E4726`), wet lawn (`Grass` `#1E8449`).
- **Lighting:** `ClockTime = 16.8` warm amber sunset shifting to soft golden alchemy glow (`PointLight` `#F1C40F`) inside the locker alcove.
- **VFX/SFX Cues:** Thin `#F1C40F` alchemy ring `ParticleEmitter` on door close; soft white sparkle on Barnaby's healed trot; SFX: metal locker clang, scale needle tick, resonant alchemy chime, happy dog bark.

---

## Story 010: The Red-String Contract

- **Story ID & Title:** Story 010 — *The Red-String Contract*
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Running away from bad memories eventually leaves you with no good ones left to stand on.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, ringing the cursed shrine bell ties a tiny spirit to your backpack that eats one bad memory every night—until I ran out."
   - **Frame 1 Visual:** Over-the-shoulder shot of a glowing crimson thread (`#E74C3C`) tying a tiny floating lantern-imp (`#FF6F00`) to a student's zipper while grey "bad memory" orbs float into its mouth.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid who failed his math test smiles blankly as the imp gobbles up his memory of studying—so he walks straight back into class and fails the exact same test twice.
   - **Town Adaptation:** Half the town rings the bell before bedtime so they never feel embarrassed, walking around with permanent empty grins.
   - **3 Named Planted Ammo Clues:**
     1. **Red String Knot (`#E74C3C`):** The contract string can't be cut with scissors—it only unties if you swallow one *bitter truth* you hid from it.
     2. **Color-Coded Memory Orbs:** Bad memories glow smoky grey (`#7F8C8D`); good memories glow warm gold (`#F1C40F`).
     3. **The Locked Diary Key (`#D4AC0D`):** Narrator Hana kept a crumpled apology letter she never sent folded inside her pencil case.
3. **13.5–21s Personal Trap & Crisis:**
   - By Friday morning, Hana's backpack imp has eaten every single bad memory she had—and when the bell chimes 8:00 AM, its hungry neon jaws open toward her *golden* memory orbs of her best friend's birthday.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Snipping the Red String):** Hana grabs art-class scissors and snips the crimson thread; *CLINK! SNAP!* The steel blades bend while the string glows hotter.
   - **Clue 2 Fail (Dumping the Backpack):** Hana unclips her backpack and sprints down the stairs; *ZAP! YANK!* The red thread stretches like elastic and snaps the backpack straight back onto her shoulders.
   - **Clue 3 Fail (Feeding It a Fake Bad Memory):** Hana tries thinking about stubbing her toe; *CHOMP! BURP!* The tiny grey pebble barely lasts two seconds before the imp reaches for a golden orb.
5. **39–51s Genius Rule-Hack Climax:**
   - Hana rips open her pencil case, grabs the crumpled apology letter she was too scared to face, and reads the ugly truth out loud to her best friend standing by the lockers—owning the embarrassment completely instead of hiding it. The imp tastes the raw, un-erased bad memory *accepted* out loud; the red string instantly turns white and unravels into harmless silk petals.
6. **51–56s Action Echo Punchline:**
   - Hana's golden memory orbs settle safely back inside her chest, and her best friend laughs and bumps shoulders with her down the hall.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Hana (Narrator):** Role: Protagonist | Skin: `#FFDBAC` | R6 Outfit: Maroon knit sweater (`#7B241C`), pleated dark-grey skirt/pants (`#2C3E50`), shoulder-length black bob (`#17202A`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Lantern-Imp (Contract Spirit):** Role: Curse Mascot | Skin/Body: `#FF6F00` (`Neon` eyes `#E74C3C`) | Rig: Floating `1.0 x 1.0 x 1.0` stud blocky imp with tiny horns | Emotion Swaps: `grin` -> `shocked`.
- **Best Friend Mia:** Role: Friend | Skin: `#E0AC69` | R6 Outfit: Denim jacket (`#2E86C1`), white tee (`#F8F9F9`), wavy brown hair (`#4A2C1D`) | Emotion Swaps: `neutral` -> `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Red-String Contract Thread:** `0.08 x 3.0 x 0.08` studs, `Neon`, `#E74C3C`, socket `UpperTorso` (backpack zipper to imp).
- **Crumpled Apology Letter:** `0.7 x 0.1 x 0.9` studs, `SmoothPlastic`, `#F5F5DC`, socket `RightHand`.
- **Memory Orbs (Grey & Gold):** `0.6 x 0.6 x 0.6` studs, `Neon`, `#7F8C8D` / `#F1C40F`, socket `Workspace` (floating).
- **Cursed Shrine Bell:** `2.5 x 3.0 x 2.5` studs, `Metal`, `#B87333`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolLockerHallway` — warm wood-trimmed lockers (`WoodPlanks` `#6E4726`), sunlit floor (`Marble` `#EAEDED`).
- **Secondary Set:** `TownShrineSteps` — stone steps (`Cobblestone` `#7F8C8D`), red wooden torii arch (`WoodPlanks` `#C0392B`).
- **Lighting:** `ClockTime = 16.8` soft amber dusk with `#E74C3C` point light radiating from the red string.
- **VFX/SFX Cues:** Floating orb `ParticleEmitter` trails; white petal dissolve on string release; SFX: brass bell toll, scissor clink, elastic snap, soft chime release.

---

## Story 011: The Time-Leap Staircase

- **Story ID & Title:** Story 011 — *The Time-Leap Staircase*
- **Format:** 2-Part (Part 1: 54s, 46 beats / Part 2: 53s, 45 beats — Full Arc Manifest)
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** You don't beat a bad outcome by running faster—you beat it by showing up five minutes earlier at the right door.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, stepping onto the 13th school stair at exactly 3:00 PM rewinds you back to Monday—and I used it twelve times to catch an arsonist."
   - **Frame 1 Visual:** Low-angle stairwell shot: a glowing cyan `[13]` carved into a worn concrete step (`#00E5FF`) as the narrator's sneaker lands at `2:59:59 PM` and the hallway clock spins violently backward.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid drops his science volcano down the stairwell at 3:00 PM, steps onto stair 13 by accident, and *WHOOSH!*—wakes up Monday morning holding the exact same unbroken baking-soda bottle.
   - **Town Adaptation:** The school chained a velvet `[STAIRS CLOSED 2:58–3:02]` rope across the landing, and kids check their wristwatches before taking a single step.
   - **3 Named Planted Ammo Clues:**
     1. **Red Chalk Mark (`#E74C3C`):** Only objects *held in your hand* survive the Monday rewind; anything left in your locker resets.
     2. **Gym Utility Closet Vent (`#566573`):** Smoke from Friday's gym fire always starts leaking out of the East Bleacher vent three minutes before the alarm.
     3. **Yellow Safety Pin (`#F1C40F`):** Narrator Kai pins a small brass tally pin to his sleeve each loop—he's on pin `#12`.
3. **13.5–21s Personal Trap & Crisis:**
   - Every Friday at 3:05 PM, the school gym catches fire and the Principal blames Kai's robotics club—and on Loop 12, the staircase cracks under Kai's feet, giving him one final rewind before the step breaks for good.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Loop 4 — Pulling the Fire Alarm Early):** Kai pulls the alarm at 2:55 PM; *RING!* The arsonist just waits until after the drill and sets the fire at 3:15 PM instead.
   - **Clue 2 Fail (Loop 8 — Guarding the Main Gym Doors):** Kai camps outside the double doors all afternoon; *CREAK! POOF!* Smoke pours out from *inside* while the doors stay bolted.
   - **Clue 3 Fail (Loop 11 — Grabbing the Fire Extinguisher):** Kai sprays foam into the East Bleacher vent; *PSSSH!* The extinguisher is empty—someone swapped the tank with water.
5. **39–51s Genius Rule-Hack Climax:**
   - On Loop 12, Kai uses what he learned across eleven loops: he holds his phone camera in his hand *before* stepping on Stair 13 so it survives the rewind, sprints straight to the *roof hatch* above the East Bleacher vent at 2:45 PM, and films the varsity captain sneaking down the maintenance ladder with a road flare and an empty extinguisher tag—locking the roof hatch behind him and handing the live video straight to the Fire Chief.
6. **51–56s Action Echo Punchline:**
   - At 3:05 PM, the gym stays completely smoke-free, Stair 13's cyan glow fades quietly out, and Kai unpins all twelve yellow tally pins into his palm.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Kai (Narrator):** Role: Protagonist | Skin: `#F1C27D` | R6 Outfit: Mustard-yellow hoodie (`#D4AC0D`), black cargo pants (`#1C2833`), spiky blonde-dyed hair (`#F4D03F`) | Emotion Swaps: `scared` -> `determined` -> `shocked` -> `proud`.
- **Varsity Captain Dane:** Role: Secret Arsonist | Skin: `#E0AC69` | R6 Outfit: Red-and-white letterman jacket (`#C0392B`), dark jeans (`#212F3D`), slicked brown hair (`#4A2C1D`) | Emotion Swaps: `grin` -> `shocked` -> `scared`.
- **Fire Chief:** Role: Authority | Skin: `#8D5524` | R6 Outfit: Tan turnout coat (`#B9770E`) + yellow neon stripe (`#F1C40F`), helmet (`#E74C3C`) | Emotion Swaps: `neutral` -> `determined`.

### Props & Sockets (Sound-Off Visible)
- **Glowing Stair #13:** `6.0 x 0.8 x 1.5` studs, `Concrete` + `Neon` `[13]` decal (`#00E5FF`), socket `Workspace`.
- **Wall Clock (`3:00 PM`):** `2.0 x 2.0 x 0.3` studs, `SmoothPlastic` + `Metal`, `#F8F9F9` + `#17202A`, socket `Workspace`.
- **12 Brass Tally Pins:** `0.15 x 0.15 x 0.3` studs each, `Metal`, `#F1C40F`, socket `LeftArm`.
- **Road Flare:** `0.3 x 1.2 x 0.3` studs, `Neon` tip (`#FF3B30`) + `SmoothPlastic`, `#C0392B`, socket `RightHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolStairwell` — concrete steps (`Concrete` `#7F8C8D`), tubular steel handrail (`Metal` `#AEB6BF`), velvet warning rope (`Fabric` `#8E44AD`).
- **Secondary Set:** `EastBleacherRoofHatch` — gravel roof (`Pebble` `#566573`), steel roof hatch (`DiamondPlate` `#34495E`), metal vent shaft (`Metal` `#5D6D7E`).
- **Lighting:** `ClockTime = 16.8` shifting rapidly through a high-speed cyan rewind flash (`ColorCorrection` bloom spike) back to `ClockTime = 8.2` crisp Monday morning sun.
- **VFX/SFX Cues:** Thin `#00E5FF` concentric time-ripple rings on step contact; smoke `ParticleEmitter` in failed loops; SFX: backward clock whirr, heavy steel hatch clang, camera shutter click.

---

## Story 012: The Truth-Blindfold

- **Story ID & Title:** Story 012 — *The Truth-Blindfold*
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Some lies aren't told to trick you—they're told to carry a weight you're still too small to hold.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, wearing the black silk blindfold lets you see every lie as red smoke—until I wore it at Parent-Teacher Night."
   - **Frame 1 Visual:** Close-up on narrator Kenji tying a matte-black blindfold (`#17202A`) over his eyes; the world turns monochrome, and bright crimson smoke (`#E74C3C`) curls out of a classmate's mouth as he says, *"I totally studied."*
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** The class president wears the blindfold during student council speeches and watches thick red smoke pour out of the podium like a fog machine—exposing a rigged pizza-party vote.
   - **Town Adaptation:** Adults ban blindfolds inside the town hall and cover their mouths with scarves whenever they talk about money or grades.
   - **3 Named Planted Ammo Clues:**
     1. **Smoke Color Rule:** Selfish lies drift *upward* in jagged crimson (`#E74C3C`); protective lies wrap *around* the listener like a warm gold-edged shield (`#F39C12`).
     2. **Dad's Faded Work Boots (`#6E4726`):** Kenji's dad always claims he "loves working the night shift" even though his boots are caked in concrete dust.
     3. **The Unopened Envelope (`#F5F5DC`):** A crisp white scholarship rejection letter sits on the teacher's desk.
3. **13.5–21s Personal Trap & Crisis:**
   - At Parent-Teacher Night, Kenji slips the black blindfold over his eyes expecting to catch his dad lying about why he missed Kenji's soccer games—and freezes when Dad tells the teacher, *"Kenji's fine, we have plenty saved for his college."*
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Calling Dad Out in the Hall):** Kenji rips off the blindfold and confronts Dad; *SIGH!* Dad only smiles and says, *"Just focus on soccer, buddy,"* while Kenji's anger flares.
   - **Clue 2 Fail (Checking the Bank App):** Kenji peeks at Dad's phone on the bench; *LOCKED!* The screen flashes `[PASSCODE REQUIRED]`.
   - **Clue 3 Fail (Asking the Teacher for the Envelope):** Kenji reaches for the scholarship letter; *SLAP!* The teacher slides it into a folder marked `[PARENTS ONLY]`.
5. **39–51s Genius Rule-Hack Climax:**
   - Kenji puts the black blindfold back on and watches Dad closely as Dad lies to the teacher again: *"I'm taking extra shifts just because I hate sitting at home."* Through the blindfold, the crimson smoke doesn't rise at all—it turns warm amber-gold (`#F39C12`) and wraps gently around Kenji's shoulders like a coat, while Dad's tired hands tremble behind his back holding two extra overtime timecards.
6. **51–56s Action Echo Punchline:**
   - Kenji pulls off the blindfold, walks straight over without saying a word, and slides his own backpack strap onto his shoulder so he can carry Dad's heavy toolbox out to the truck.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Kenji (Narrator):** Role: Protagonist | Skin: `#FFDBAC` | R6 Outfit: White high-collar school jacket (`#F8F9F9`), dark navy trousers (`#1B2631`), spiky white-silver hair (`#E5E7E9`) | Emotion Swaps: `grin` -> `shocked` -> `determined` -> `sad` -> `proud`.
- **Dad (Marcus):** Role: Parent | Skin: `#E0AC69` | R6 Outfit: Faded denim work shirt (`#2E86C1`), scuffed brown work pants (`#6E4726`), short dark hair (`#2C1A12`) | Emotion Swaps: `neutral` -> `sad` -> `proud`.
- **Teacher Ms. Lee:** Role: Faculty | Skin: `#F1C27D` | R6 Outfit: Olive blazer (`#556B2F`), black slacks (`#17202A`), neat black hair (`#111111`) | Emotion Swaps: `neutral` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Black Silk Blindfold:** `1.3 x 0.4 x 1.3` studs, `Fabric`, `#17202A`, socket `Head`.
- **Red/Amber Lie Smoke:** `ParticleEmitter`, `#E74C3C` (selfish) / `#F39C12` (protective shield), socket `Head` (speaker).
- **Overtime Timecards (x2):** `0.5 x 0.05 x 0.8` studs, `SmoothPlastic`, `#F5F5DC`, socket `LeftHand` (Dad).
- **Heavy Steel Toolbox:** `1.6 x 0.9 x 0.8` studs, `Metal`, `#C0392B`, socket `RightHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolClassroomNight` — wooden desks (`WoodPlanks` `#8E5B34`), chalkboard (`Slate` `#1E5631`), hallway glass door (`Glass` `#AED6F1`).
- **Secondary Set:** `SchoolParkingLot` — damp asphalt (`Slate` `#2C3E50`), yellow sodium streetlamps (`Neon` `#F39C12`), pickup truck.
- **Lighting:** `ClockTime = 20.5` warm classroom interior; when blindfold equips, `ColorCorrection` shifts scene to high-contrast monochrome (`Saturation = -1.0`) so `#E74C3C` / `#F39C12` smoke pops vividly.
- **VFX/SFX Cues:** Smooth monochrome desaturation toggle on blindfold equip; warm amber shield ring around Kenji's torso; SFX: soft cloth tie, low bass truth hum, quiet toolbox latch click.

---

## Story 013: The Spirit-Mask Festival

- **Story ID & Title:** Story 013 — *The Spirit-Mask Festival*
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** You don't lose yourself all at once—you lose yourself one small distraction at a time unless someone anchors your name.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, anyone who forgets their real name at the lantern carnival turns into a wooden shop mannequin—so I wrote my sister's name on her shoe."
   - **Frame 1 Visual:** Overhead lantern-lit alley (`#FF6F00`): a smiling boy drops his cotton candy, blinks blankly, and *CLACK!*—his R6 arms turn into stiff glossy mannequin wood (`#D5C39A`) on a display stand.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A food-stall owner calls out, *"Free ramen for anyone who answers!"*—three tourists shout *"Me!"* instead of their names and instantly freeze into stiff wooden statues holding chopsticks.
   - **Town Adaptation:** Locals pin giant laminated name badges to their shirts, though the sneaky fox-masked stall keepers hand out free sticky stickers that cover the badges up.
   - **3 Named Planted Ammo Clues:**
     1. **Fox-Mask Shopkeeper's Stamp (`#C0392B`):** Every stall gives you a bright `[GUEST]` sticker that erases your memory of your own name after 60 seconds.
     2. **Permanent Sharpie Ink (`#111111`):** Ink written directly on rubber shoe soles doesn't wash off or get covered by festival stickers.
     3. **The Exit Torii Bell (`#D4AC0D`):** Ringing the brass exit bell only opens the gate if you shout your real full name.
3. **13.5–21s Personal Trap & Crisis:**
   - Little sister Mei chases a glowing paper goldfish into the mask alley; a fox-masked vendor slaps a `[GUEST #404]` sticker onto her jacket, and Mei's eyes turn glassy as her wooden joints start locking up.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Shouting Her Name):** Narrator Sora yells *"Mei!"* across the crowd; *WHOOSH!* Festival drums drown him out, and Mei shakes her head blankly: *"Who's that?"*
   - **Clue 2 Fail (Ripping Off the `[GUEST]` Sticker):** Sora tears the red sticker off Mei's coat; *RIP! ZAP!* The memory fog stays—her floating `[???]` tag stays blank.
   - **Clue 3 Fail (Checking Her Pocket ID):** Sora digs in her pocket for her school card; *EMPTY!* The fox-mask vendor already swapped it for a wooden raffle ticket.
5. **39–51s Genius Rule-Hack Climax:**
   - Sora drops to one knee, yanks off Mei's left sneaker, and flips the white rubber sole straight into the lantern light—revealing `MEI SATO` written in thick black Sharpie across the tread! Mei squints at the letters, mouths *"M-e-i..."*, and snaps her fingers as her wooden joints pop back to warm skin. Together they sprint to the brass exit bell and shout *"MEI SATO! SORA SATO!"*—bursting the festival gate wide open.
6. **51–56s Action Echo Punchline:**
   - Mei hops on one foot tying her Sharpie-marked sneaker back on, grinning as Sora holds up the matching marker cap.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Sora (Narrator):** Role: Protagonist | Skin: `#FFDBAC` | R6 Outfit: Dark blue festival yukata-hoodie (`#1F3A5F`), black pants (`#17202A`), messy dark hair (`#1C1C1C`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Mei (Little Sister):** Role: Protected Sibling | Skin: `#FFDBAC` | R6 Outfit: Pink kimono-cardigan (`#E91E63`), white sneakers (`#F8F9F9`), twin buns (`#1C1C1C`) | Emotion Swaps: `happy` -> `shocked` -> `neutral` -> `proud`.
- **Fox-Mask Vendor:** Role: Antagonist | Skin: `#D5C39A` | R6 Outfit: Crimson festival robe (`#922B21`), white kitsune mask (`#F8F9F9` with `#E74C3C` markings) | Emotion Swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Sharpie-Marked Sneaker:** `1.0 x 0.45 x 1.2` studs, `SmoothPlastic`, `#F8F9F9` + `#111111` text decal, socket `LeftFoot` / `RightHand`.
- **`[GUEST #404]` Sticker:** `0.8 x 0.4 x 0.05` studs, `Neon`, `#C0392B`, socket `UpperTorso`.
- **Paper Goldfish Lantern:** `0.8 x 0.6 x 1.2` studs, `Neon`, `#FF6F00`, socket `Workspace`.
- **Brass Exit Bell:** `2.2 x 2.5 x 2.2` studs, `Metal`, `#D4AC0D`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `LanternCarnivalAlley` — wooden food stalls (`WoodPlanks` `#6E4726`), hanging paper lanterns (`Neon` `#FF6F00`), cobblestone lane (`Cobblestone` `#566573`).
- **Secondary Set:** `ExitToriiGate` — towering vermilion gate (`WoodPlanks` `#C0392B`), misty night forest edge (`Grass` `#145A32`).
- **Lighting:** `ClockTime = 21.0` warm amber lantern glow (`#FF8F00`) contrasting with eerie pale fog (`Atmosphere.Density = 0.45`).
- **VFX/SFX Cues:** Wooden texture snap VFX on mannequin curse; gold ring shockwave on name shout; SFX: wooden clack, festival taiko drum boom, sharp sneaker squeak, deep exit bell gong.

---

## Story 014: The Soul-Scale

- **Story ID & Title:** Story 014 — *The Soul-Scale*
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Real generosity isn't what you drop in front of a camera—it's what you give when nobody is keeping score.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, a giant floating scale weighs your kindness against your greed every Friday—until the richest kid's mansion sank into the lake."
   - **Frame 1 Visual:** Wide plaza shot of a colossal golden balance scale (`#D4AC0D`) hovering 30 studs above Lakeview Square, one pan glowing emerald (`#2ECC71`) and the other glowing heavy crimson (`#E74C3C`).
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A mayor's aide slips a town parking fine onto someone else's windshield; *CLANG!*—his luxury sports car immediately sprouts stone tires and sinks four inches into the asphalt.
   - **Town Adaptation:** Every Friday before 5:00 PM, citizens rush to bake cookies for neighbors and return lost pencils just to keep their house's `[SOUL WEIGHT]` in the green.
   - **3 Named Planted Ammo Clues:**
     1. **Gold Camera Flash (`#F1C40F`):** Rich kid Victor always brings a news crew when he donates giant fake cardboard checks.
     2. **Hidden Receipt Slot (`#2C3E50`):** The scale ignores *public applause*—it only weighs *unpaid, quiet sacrifices* in the final 10 seconds.
     3. **The Unclaimed Lunch Bag (`#C29B61`):** Narrator Toby quietly leaves half his homemade sandwich on the janitor's cart every single day.
3. **13.5–21s Personal Trap & Crisis:**
   - Victor frames Toby for stealing the school's charity jar right before Friday's 5:00 PM Weigh-In, piling ten heavy crimson `[GREED]` weights onto Toby's side of the scale—threatening to sink Toby's tiny lakeside cottage.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Showing Security Footage):** Toby sprints to the office for hallway camera proof; *STATIC!* Victor's dad owns the security company and wiped the clip.
   - **Clue 2 Fail (Emptying His Piggy Bank):** Toby dumps all $14 of his savings into the town donation box; *CLINK!* The scale barely nudges because he's doing it out of panic, not kindness.
   - **Clue 3 Fail (Confronting Victor in Public):** Toby yells that Victor's $10,000 charity check bounced; *LAUGH!* The crowd boos Toby while Victor poses for cameras.
5. **39–51s Genius Rule-Hack Climax:**
   - At `4:59:50 PM`, Toby stops fighting, notices the old school janitor shivering on the bench without a coat, and quietly drapes his own thick winter parka over the janitor's shoulders before walking away without looking back. *BONG!* The 5:00 PM Soul-Scale tallies *unrecorded* acts: Victor's $10,000 publicity stunt turns to zero, while Toby's year of quiet lunches plus his coat rockets the emerald pan sky-high—flipping the crimson beam straight onto Victor's lakeside mansion, which tilts and splashes cleanly into the shallow lake!
6. **51–56s Action Echo Punchline:**
   - Victor stands knee-deep on his floating roof holding his soggy cardboard check, while Toby and the janitor split a warm thermos of cocoa on the dry pier.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Toby (Narrator):** Role: Protagonist | Skin: `#C68642` | R6 Outfit: Orange-and-black puffer parka (`#E67E22`), dark jeans (`#2C3E50`), short curly hair (`#1C1C1C`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Victor:** Role: Rich Kid Antagonist | Skin: `#FFDBAC` | R6 Outfit: White double-breasted blazer (`#F8F9F9`), gold tie (`#F1C40F`), slicked blonde hair (`#F4D03F`) | Emotion Swaps: `grin` -> `shocked` -> `scared`.
- **School Janitor:** Role: Quiet Witness | Skin: `#E0AC69` | R6 Outfit: Grey coveralls (`#7F8C8D`), knit beanie (`#34495E`), grey mustache | Emotion Swaps: `sad` -> `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Colossal Floating Soul-Scale:** `24.0 x 18.0 x 6.0` studs, `Metal` + `Neon` pans (`#2ECC71` / `#E74C3C`), socket `Workspace`.
- **Giant Cardboard Check (`$10,000`):** `3.5 x 1.5 x 0.1` studs, `Cardboard`, `#F8F9F9`, socket `RightHand`.
- **Orange Winter Parka:** `2.2 x 2.1 x 1.2` studs, `Fabric`, `#E67E22`, socket `UpperTorso`.
- **Brown Paper Lunch Bag:** `0.6 x 0.9 x 0.4` studs, `Cardboard`, `#C29B61`, socket `LeftHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `LakeviewTownSquare` — stone plaza (`Cobblestone` `#7F8C8D`), wooden pier (`WoodPlanks` `#6E4726`), shimmering blue lake (`Water` `#2471A3`), Victor's white mansion on pilings.
- **Secondary Set:** `SchoolHallway` — charity jar table (`WoodPlanks` `#8E5B34`), security monitor (`Metal` `#2C3E50`).
- **Lighting:** `ClockTime = 16.8` golden sunset reflecting off the lake water and the giant brass scale beams.
- **VFX/SFX Cues:** Emerald & crimson beam tilt flare; huge water-splash `ParticleEmitter` when the mansion drops into the lake; SFX: heavy brass scale groan, camera shutter flashes, 5:00 PM clock chime, giant splash.

---

## Story 015: The Alchemy Chalk

- **Story ID & Title:** Story 015 — *The Alchemy Chalk*
- **Format:** Standalone 52s, 44 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Imagination only saves the day when you draw what the problem actually needs—not what looks cool.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, anything you draw with blue chalk becomes real for sixty seconds—and three stupid drawings almost drowned us."
   - **Frame 1 Visual:** Close-up of a glowing cyan chalk stick (`#00E5FF`) sketching a wireframe skateboard on asphalt; *ZAP!*—a solid 3D glowing blue skateboard pops straight off the pavement.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid draws a giant pizza slice on the sidewalk to skip lunch line; *POOF!*—it becomes real, flattens his bike, and vanishes into blue dust 60 seconds later leaving tomato sauce everywhere.
   - **Town Adaptation:** Art teachers lock blue chalk in steel safes, and the sidewalk is covered in faded `[60s]` timer rings where kids drew trampolines and bikes.
   - **3 Named Planted Ammo Clues:**
     1. **One-Inch Chalk Stub (`1.0 stud`):** Narrator Max only has one tiny nub of blue chalk left—enough for roughly four quick drawings before it crumbles.
     2. **60-Second Fade Blink:** Every chalk object flickers bright white at `55s` before dissolving completely at `60s`.
     3. **Gap Between School Roofs (`16 studs`):** The flooded library roof sits exactly 16 studs across from the dry gym roof.
3. **13.5–21s Personal Trap & Crisis:**
   - A broken river levee floods the school's first floor in minutes, trapping Max and three younger kids on the sinking library roof as dark water rises toward the skylight.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Drawing a Speedboat):** Max sketches a cool speedboat on the wet roof; *ZAP! SPLASH!* It's made of porous chalk-foam and immediately tips sideways in the current.
   - **Clue 2 Fail (Drawing a Giant Umbrella):** Max draws a huge upside-down umbrella to float in; *POP!* The rushing floodwater flips it inside out and washes it away.
   - **Clue 3 Fail (Drawing a Jet-Pack):** Max scribbles a twin-thruster jetpack on the wall; *FIZZLE!* Without real fuel, it's just a heavy glowing backpack that sinks him to his ankles.
5. **39–51s Genius Rule-Hack Climax:**
   - With barely a fingernail of blue chalk left, Max stops drawing gadgets and kneels at the edge of the roof. He draws two simple, thick parallel beams with triangle trusses—a straight **18-stud bridge** locking onto the dry gym roof across the alley! *ZAP!* The glowing cyan truss bridge solidifies for 60 seconds; Max hustles all three kids across to the dry gym roof just as the `[59s]` blink hits and the bridge dissolves into blue sparkles behind his heels.
6. **51–56s Action Echo Punchline:**
   - Max blows the last speck of blue chalk dust off his fingertips, and the youngest kid hands him a dry gym towel.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Max (Narrator):** Role: Protagonist | Skin: `#E0AC69` | R6 Outfit: Red hoodie (`#C0392B`), blue jeans (`#2874A6`), messy dark hair (`#1C1C1C`) | Emotion Swaps: `grin` -> `scared` -> `determined` -> `proud`.
- **Younger Kids (x3):** Role: Rescued Group | Skin: `#FFDBAC`, `#8D5524`, `#F1C27D` | R6 Outfits: School polos (`#F1C40F`, `#2ECC71`, `#3498DB`), shorts (`#2C3E50`) | Emotion Swaps: `scared` -> `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Blue Alchemy Chalk Nub:** `0.2 x 0.2 x 0.6` studs, `Neon`, `#00E5FF`, socket `RightHand`.
- **Glowing Cyan Truss Bridge:** `18.0 x 2.5 x 4.0` studs, `Neon` + `ForceField`, `#00E5FF`, socket `Workspace`.
- **Failed Chalk Speedboat / Jetpack:** `5.0 x 2.0 x 2.5` studs, `ForceField`, `#00E5FF`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `FloodedSchoolRooftops` — gravel library roof (`Pebble` `#566573`), rising muddy floodwater (`Water` `#5D6D7E`), dry gym roof (`Concrete` `#7F8C8D`) 16 studs across.
- **Secondary Set:** `SchoolSidewalk` — concrete slab (`Concrete` `#BDC3C7`) with chalk timer rings.
- **Lighting:** `ClockTime = 17.2` stormy overcast (`#566573`) so the `#00E5FF` glowing chalk creations pop with maximum contrast.
- **VFX/SFX Cues:** Bright `#00E5FF` wireframe-to-solid pop VFX; sparkle-dissolve at 60s; SFX: chalk scrape, electric pop-spawn, rushing floodwater, bridge footstep thuds.

---

## Story 016: The Freeze-Frame Gaze

- **Story ID & Title:** Story 016 — *The Freeze-Frame Gaze*
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Real restraint isn't having no power—it's keeping your eyes down until the one moment someone truly needs you to look up.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, anyone who locks eyes with me has to obey one three-word command—and I swore I'd never take my sunglasses off."
   - **Frame 1 Visual:** Extreme close-up (`eyeCam`) on dark aviator sunglasses (`#17202A`) sliding down half an inch, revealing a glowing crimson ring (`#E74C3C`) spinning inside the narrator's pupil.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Back in third grade, narrator Evan accidentally blinked at a strict hall monitor and yelled *"Drop the clipboard!"*—causing the poor guy to salute and drop his lunch too.
   - **Town Adaptation:** Evan wears thick polarized sunglasses taped at the temples so nobody can ever say he cheated in sports or class.
   - **3 Named Planted Ammo Clues:**
     1. **3-Word Hard Cap:** Any command over three words breaks the spell mid-sentence.
     2. **Direct Eye-Line Only:** Mirrors, tinted windshields, and sunglasses block the crimson ring completely.
     3. **Silver Freight Crossing (`4:15 PM`):** Every afternoon, the 4:15 commuter train slows down at Oak Street Crossing—unless its dead-man switch jams.
3. **13.5–21s Personal Trap & Crisis:**
   - Walking home past Oak Street Crossing, the warning bells jam open—a yellow school bus stalls right across the rails as the 4:15 train barrels around the bend at 50 mph, its conductor slumped half-asleep over the horn.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Waving His Arms on the Tracks):** Evan sprints beside the crossing waving his jacket; *HOOOONK!* The train's tinted glass reflects Evan's sunglasses, and the dazed conductor barely blinks.
   - **Clue 2 Fail (Pushing the Crossing Gate Switch):** Evan yanks the red manual lever on the signal box; *CLANG! JAMMED!* Rusted gears lock halfway down.
   - **Clue 3 Fail (Shouting a Long Warning):** Evan rips off his sunglasses and screams *"STOP THE TRAIN RIGHT NOW!"*—*BUZZ!* Six words! The crimson eye-ring flickers out without catching.
5. **39–51s Genius Rule-Hack Climax:**
   - Evan leaps onto the gravel embankment just as the locomotive cab passes 15 studs away, leans level with the open side cab window for clear direct eye contact, locks his glowing crimson pupil onto the conductor's eyes, and fires exactly three crisp words: ***"PULL THE BRAKE!"*** *SCREEECH!* The conductor's hand slams the red emergency brake handle straight down—steel sparks shower the rails as the train grinds to a halt three studs from the yellow school bus bumper.
6. **51–56s Action Echo Punchline:**
   - Evan quietly slides his dark sunglasses back up his nose, checks his temple tape, and walks off before the bus door even opens.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Evan (Narrator):** Role: Protagonist | Skin: `#F1C27D` | R6 Outfit: Charcoal zip jacket (`#2C3E50`), black jeans (`#17202A`), dark brown bangs (`#3B281E`) + aviator sunglasses | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Train Conductor:** Role: Dazed Operator | Skin: `#E0AC69` | R6 Outfit: Blue-striped engineer uniform (`#2471A3`), engineer cap (`#1F3A5F`), grey mustache | Emotion Swaps: `neutral` -> `shocked`.
- **Bus Kids (x3):** Role: Passengers | Skin: `#FFDBAC`, `#C68642`, `#8D5524` | R6 Outfits: School backpacks + bright tees (`#F1C40F`, `#2ECC71`, `#E74C3C`) | Emotion Swaps: `scared` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Aviator Sunglasses:** `1.3 x 0.4 x 0.5` studs, `Metal` + `Glass`, `#17202A`, socket `Head`.
- **Glowing Crimson Eye Ring:** `0.25 x 0.25 x 0.05` studs, `Neon`, `#E74C3C`, socket `Head` (eye overlay).
- **Red Emergency Brake Lever:** `0.4 x 1.8 x 0.4` studs, `Metal`, `#C0392B`, socket `Workspace` (train cab).
- **Commuter Locomotive:** `10.0 x 11.0 x 36.0` studs, `Metal`, `#5D6D7E` + `#F1C40F` stripe, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `OakStreetRailCrossing` — gravel ballast (`Pebble` `#566573`), steel rails (`Metal` `#AEB6BF`), striped crossing gate (`SmoothPlastic` `#E74C3C` / `#F8F9F9`), asphalt road.
- **Secondary Set:** `SchoolHallway` — locker bank (`Metal` `#5D6D7E`) for opening flashback.
- **Lighting:** `ClockTime = 16.8` long afternoon shadows across the rails; bright `#E74C3C` command pulse inside the cab.
- **VFX/SFX Cues:** Thin `#E74C3C` laser-gaze ring shooting from Evan's eye to conductor's eye; orange wheel-spark `ParticleEmitter` on emergency brake; SFX: train horn blare, metal gear jam, piercing steel rail screech.

---

## Story 017: The Memory-Tea Cafe

- **Story ID & Title:** Story 017 — *The Memory-Tea Cafe*
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** When the whole room points at the easiest scapegoat, check who was holding the tea cup last.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, drinking the diner's glowing blue tea lets you replay someone else's last ten minutes—and it just cleared an innocent man."
   - **Frame 1 Visual:** Top-down diner counter shot: a ceramic mug of swirling sapphire tea (`#00BCD4`) steaming upward, morphing into a miniature holographic replay above the table.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A bakery customer swaps mugs by mistake, takes one sip of blue tea, and suddenly witnesses ten minutes of the baker arguing with a stubborn sourdough starter—blurting out the secret recipe.
   - **Town Adaptation:** The town diner locks blue tea behind `[WITNESS ONLY]` tickets, and guilty kids refuse to touch any cup left on the counter.
   - **3 Named Planted Ammo Clues:**
     1. **One-Hair Trigger (`Single Strand`):** To replay someone's last 10 minutes, the tea needs one strand of their hair—or a drop of their sweat on a tool they just used.
     2. **10-Minute Hard Window:** The tea only replays the *exact* last 10 minutes before the item was steeped; wait too long and the window expires.
     3. **Yellow Mop Handle (`#F1C40F`):** Janitor Gus's mop was found beside the smashed trophy case at `3:52 PM`.
3. **13.5–21s Personal Trap & Crisis:**
   - At `3:55 PM`, Principal Vance marches Janitor Gus out of school in handcuffs for smashing the glass trophy case, while narrator Clara spots the shiny trophy-room keycard still warm on the diner counter—five minutes before the 10-minute tea window closes!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Steeping the Janitor's Cap):** Clara dips a thread from Gus's cap into the blue tea; *SIP! WHOOSH!* It only shows Gus mopping the empty cafeteria—not the trophy hall.
   - **Clue 2 Fail (Checking the Hallway Trash Bin):** Clara grabs a soda can from the hall bin; *FIZZLE!* The tea turns grey—it's over an hour old.
   - **Clue 3 Fail (Asking the Diner Waitress for More Time):** Clara begs for a stronger brew; *CLINK!* The kettle is down to its very last cup of blue tea.
5. **39–51s Genius Rule-Hack Climax:**
   - Clara snatches the *smashed glass trophy case's brass padlock*—not Gus's mop—and dips the fresh fingerprint smudge on the lock straight into the last cup of blue tea at `3:59 PM`! *SHIMMER!* A crisp 3D sapphire replay rises above the table: at `3:50 PM`, star quarterback Vance Jr. accidentally shattered the glass with an indoor football, panicked, and planted Janitor Gus's yellow mop beside the glass before sprinting out. Clara turns the hologram straight toward the Principal and the town sheriff.
6. **51–56s Action Echo Punchline:**
   - The sheriff unlocks Gus's cuffs, Gus tips his cap to Clara, and the diner waitress slides Clara a free slice of blueberry pie.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Clara (Narrator):** Role: Protagonist | Skin: `#FFDBAC` | R6 Outfit: Cozy burgundy turtleneck (`#7B241C`), dark corduroy pants (`#4A3222`), wavy auburn hair (`#873600`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Janitor Gus:** Role: Falsely Accused | Skin: `#C68642` | R6 Outfit: Navy work jumpsuit (`#1F3A5F`), grey utility cap (`#7F8C8D`), white beard | Emotion Swaps: `sad` -> `shocked` -> `proud`.
- **Quarterback Vance Jr.:** Role: Real Culprit | Skin: `#E0AC69` | R6 Outfit: Gold-and-black jersey (`#F1C40F` / `#17202A`), athletic pants (`#2C3E50`) | Emotion Swaps: `grin` -> `shocked` -> `scared`.
- **Principal Vance & Sheriff:** Role: Authorities | Skin: `#D2B48C`, `#8D5524` | R6 Outfits: Grey suit (`#566573`) / Tan sheriff uniform (`#B9770E`) | Emotion Swaps: `determined` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Sapphire Memory-Tea Mug:** `0.6 x 0.7 x 0.6` studs, `SmoothPlastic` + `Neon` liquid (`#00BCD4`), socket `RightHand`.
- **Brass Trophy Padlock:** `0.5 x 0.6 x 0.25` studs, `Metal`, `#D4AC0D`, socket `LeftHand`.
- **Yellow Mop:** `0.3 x 4.5 x 0.8` studs, `SmoothPlastic` + `Fabric`, `#F1C40F`, socket `Workspace`.
- **3D Replay Hologram:** `4.0 x 3.0 x 4.0` studs, `ForceField` (`#00E5FF`), socket `Workspace` (above mug).

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `BlueberryDiner` — checkered floor (`Marble` `#F8F9F9` / `#17202A`), red vinyl booths (`SmoothPlastic` `#C0392B`), chrome counter (`Metal` `#BDC3C7`).
- **Secondary Set:** `TrophyHallway` — shattered glass cabinet (`Glass` `#AED6F1`), scattered silver trophies (`Metal` `#D5D8DC`).
- **Lighting:** `ClockTime = 16.8` warm diner neon sign glow (`#FF6F00`) contrasting with crisp `#00E5FF` tea-replay light.
- **VFX/SFX Cues:** Swirling steam `ParticleEmitter` from mug; holographic scanline shimmer on replay; SFX: porcelain clink, tea slurp chime, glass shatter replay, handcuff click-open.

---

## Story 018: The Paper-Bird Messenger

- **Story ID & Title:** Story 018 — *The Paper-Bird Messenger*
- **Format:** Standalone 52s, 44 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Carrying around pride is way heavier than just saying two simple words.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every unspoken apology folds into a white paper bird that follows you forever—and our school bully had one thousand."
   - **Frame 1 Visual:** Hallway tracking shot: a kid bumps a girl's shoulder, ignores her, and *FOLD!*—a crisp white origami crane (`#F8F9F9`) pops out of his sleeve and orbits his head like a tiny drone.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** The town gossip tries to drive his sedan, but forty fluttering paper birds clog his windshield wipers until he rolls down the window and yells *"Sorry for spreading that rumor!"*—making them all vanish in a *POOF!*
   - **Town Adaptation:** Kids wear wide-brim mesh hats to keep birds out of their hair, and everyone keeps a pocket notepad of quick apologies.
   - **3 Named Planted Ammo Clues:**
     1. **Snowball Flock Effect:** Once a person hits 500 birds, the birds stop orbiting and start *stacking* onto their shoulders like heavy snow.
     2. **One-Truth Rule:** Fake *"whatever, sorry"* mumbles don't count—the birds only dissolve when you name the *specific* person you hurt.
     3. **Bully Rex's Crushed Sketchbook (`#2E86C1`):** Three weeks ago, Rex threw little kid Milo's blue sketchbook into a mud puddle and never said a word.
3. **13.5–21s Personal Trap & Crisis:**
   - During Friday's assembly, Rex's flock hits `1,000` paper birds—burying him waist-deep in a roaring paper tornado right inside the school bleachers while nobody can reach him through the fluttering wall.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Swatting with a Broom):** The coach swings a gym broom into the flock; *SWISH! FLAP!* Each torn bird immediately folds into two smaller birds.
   - **Clue 2 Fail (Turning on the Gym Fans):** Narrator Tessa flips on the industrial floor fans; *WHIRR!* The birds lock wings into a solid dome around Rex's desk.
   - **Clue 3 Fail (Yelling a Fake Blanket Apology):** Rex shouts *"Fine, I'm sorry to everybody!"*—*BUZZ!* The paper flock only presses heavier against his chest, pinning his arms down.
5. **39–51s Genius Rule-Hack Climax:**
   - Tessa spots Milo's mud-stained blue sketchbook peeking out of her backpack, sprints to the edge of the paper dome, and holds the ruined sketchbook right up to Rex's eyes through a gap in the wings. Rex stares at the smudged pages, swallows his pride, and speaks quietly so only Milo can hear: *"Milo... I'm genuinely sorry I ruined your drawings."* *POOF!* All 1,000 paper birds snap flat and dissolve into warm golden confetti in half a second.
6. **51–56s Action Echo Punchline:**
   - Rex stands up in the silent bleachers, walks over to Milo's bench, and hands him a brand-new pack of colored pencils from his own bag.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Tessa (Narrator):** Role: Protagonist | Skin: `#E0AC69` | R6 Outfit: Olive utility jacket (`#556B2F`), black jeans (`#17202A`), braided brown hair (`#4A2C1D`) | Emotion Swaps: `neutral` -> `shocked` -> `determined` -> `proud`.
- **Rex:** Role: Bully | Skin: `#FFDBAC` | R6 Outfit: Black sleeveless hoodie (`#1C2833`), grey cargo pants (`#566573`), spiky red-brown hair (`#7B241C`) | Emotion Swaps: `grin` -> `scared` -> `sad` -> `neutral`.
- **Milo:** Role: Hurt Classmate | Skin: `#8D5524` | R6 Outfit: Yellow sweater (`#F4D03F`), blue jeans (`#2874A6`), short curly black hair (`#111111`) | Emotion Swaps: `sad` -> `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Origami Paper Birds (x1000 Swarm):** `0.5 x 0.3 x 0.6` studs each, `SmoothPlastic`, `#F8F9F9`, socket `Workspace` (orbiting/stacking around Rex).
- **Mud-Stained Blue Sketchbook:** `1.1 x 0.15 x 1.4` studs, `SmoothPlastic`, `#2E86C1` + `#6E4726` mud decal, socket `RightHand`.
- **Colored Pencil Pack:** `0.6 x 0.15 x 0.9` studs, `SmoothPlastic`, `#E74C3C` / `#F1C40F`, socket `LeftHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolGymBleachers` — wooden bleacher tiers (`WoodPlanks` `#8E5B34`), polished court (`WoodPlanks` `#D4AC0D`), industrial floor fan (`Metal` `#5D6D7E`).
- **Secondary Set:** `SchoolHallway` — sunlit lockers (`Metal` `#566573`).
- **Lighting:** `ClockTime = 16.8` bright afternoon rays streaming through high gym windows, illuminating the swirling white paper storm.
- **VFX/SFX Cues:** Swirling paper-bird `ParticleEmitter` vortex; warm gold confetti dissolve on genuine apology; SFX: crisp paper-fold snap, wing-flutter roar, quiet sincere voice, soft confetti chime.

---

## Story 019: The Giant Mech-Suit Garage

- **Story ID & Title:** Story 019 — *The Giant Mech-Suit Garage*
- **Format:** 2-Part (Part 1: 53s, 45 beats / Part 2: 54s, 46 beats — Full Arc Manifest)
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Sometimes the "chore" adults hand to kids is actually the hardest job in town.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, only kids under fourteen are allowed to pilot the giant snow-clearing mechs—until I noticed there wasn't any snow."
   - **Frame 1 Visual:** Hangar bay shot: a 22-stud tall yellow-and-orange industrial mech (`#F39C12`) kneeling in frost while a 13-year-old climbs into the glowing cyan chest cockpit (`#00E5FF`).
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A 15-year-old tries to sneak into Pilot Unit-02 for extra credit; the cockpit locks up, blasts an `[AGE LIMIT EXCEEDED]` horn, and ejects him into a snowbank.
   - **Town Adaptation:** Every eighth-grader treats "Snow Duty" like a video game shift, bragging about their mech's hydraulic scoreboards after school.
   - **3 Named Planted Ammo Clues:**
     1. **Cockpit Weight Cap (`< 115 lbs`):** The tiny emergency cockpit was built for light frames because every extra pound strains the mech's leg pistons.
     2. **Heat-Glow Ploughs (`#FF6F00`):** The mechs don't scoop snow—they brace twin titanium shields downward against a steaming crack in the mountain road.
     3. **The Underground Rumble (`40 Hz`):** Every night at 6:00 PM, coffee mugs on the diner counter vibrate right when the mechs shift stance.
3. **13.5–21s Personal Trap & Crisis:**
   - During narrator Akira's first solo shift in Unit-01, the mountain road trembles violently—the "snowbank" he's bracing against cracks wide open, revealing a 40-stud deep glowing sinkhole threatening to swallow the whole town's main bridge!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Calling Adult Mechanics on Radio):** Akira hits the red radio button; *STATIC!* Adult engineers can't fit inside the narrow `<115 lb` cockpits to help stabilize the line.
   - **Clue 2 Fail (Pushing Forward with Full Throttle):** Akira slams both joysticks forward to shove the rock wall back; *CRACK! HISS!* The hydraulic heat gauge spikes into red `[OVERLOAD]`.
   - **Clue 3 Fail (Trying to Eject & Run):** Akira reaches for the yellow eject handle; *BEEP!* If Unit-01 leaves the gap, the outer bridge pillar drops immediately.
5. **39–51s Genius Rule-Hack Climax:**
   - Akira spots the mech's secondary *Concrete-Pour Pipe* built onto the shoulder—never used for snow! He locks Unit-01's titanium feet onto the bedrock, hooks Unit-01's arms with Unit-02 and Unit-03 over the squad channel to form a three-mech triangle brace, and triggers all three shoulder pipes at once—flooding the sinkhole seam with fast-setting thermal foamcrete until the rumble stops dead.
6. **51–56s Action Echo Punchline:**
   - Akira steps out of Unit-01's steaming cockpit onto the solid new road, and the town's grizzled Fire Chief silently salutes the three 13-year-old pilots.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Akira (Narrator):** Role: Lead Pilot | Skin: `#FFDBAC` | R6 Outfit: White-and-orange plug-jacket (`#F8F9F9` / `#E67E22`), dark flight pants (`#1F3A5F`), tousled dark-brown hair (`#2C1A12`) | Emotion Swaps: `grin` -> `shocked` -> `scared` -> `determined` -> `proud`.
- **Wingman Pilots (x2):** Role: Mech Squad | Skin: `#E0AC69`, `#8D5524` | R6 Outfits: Blue (`#2980B9`) and Red (`#C0392B`) flight jackets | Emotion Swaps: `scared` -> `determined` -> `proud`.
- **Chief Mechanic:** Role: Adult Supervisor | Skin: `#D2B48C` | R6 Outfit: Greasy grey coveralls (`#566573`), hard hat (`#F1C40F`) | Emotion Swaps: `neutral` -> `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Unit-01 Industrial Mech:** `10.0 x 22.0 x 8.0` studs, `Metal` + `Neon` visor (`#00E5FF`), `#F39C12` + `#2C3E50`, socket `Workspace`.
- **Cockpit Dual Joysticks:** `0.4 x 0.8 x 0.4` studs, `Metal`, `#17202A` + `#E74C3C` button, socket `Workspace` (cockpit).
- **Shoulder Foamcrete Nozzle:** `1.2 x 1.2 x 3.0` studs, `Metal`, `#7F8C8D`, socket `Workspace` (mech shoulder).

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `MountainSinkholePass` — snowy cliff road (`Slate` `#566573` + `Snow` `#F8F9F9`), cracked asphalt bridge (`Concrete` `#34495E`), glowing subterranean fissure (`Neon` `#FF6F00`).
- **Secondary Set:** `MechHangarBay` — steel gantry (`DiamondPlate` `#2C3E50`), warning stripes (`Neon` `#F1C40F`).
- **Lighting:** `ClockTime = 17.5` twilight mountain mist (`Atmosphere.Density = 0.35`) with sharp `#00E5FF` cockpit HUD glow and `#FF6F00` fissure underlight.
- **VFX/SFX Cues:** Steam vent `ParticleEmitter`; camera shake on sinkhole tremor; white-grey foamcrete spray stream; SFX: heavy hydraulic clank, warning klaxon, deep tectonic rumble, solid concrete hiss-cure.

---

## Story 020: The Star-Eye Idol

- **Story ID & Title:** Story 020 — *The Star-Eye Idol*
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** The brightest smiles in the room are sometimes working the hardest to keep everyone else from worrying.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every lie you tell makes your eyes sparkle brighter—and the most popular girl in school was practically blinding."
   - **Frame 1 Visual:** Close-up (`eyeCam`) of a smiling girl's `classic_v1` eyes containing twin spinning neon-gold four-point stars (`#F1C40F`) while she cheerfully waves from a hallway locker.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid lies to the coach about doing 100 pushups; *FLASH!*—his eyes light up like high-beam headlights, blinding the whole locker room until he admits he only did twelve.
   - **Town Adaptation:** Teachers turn off classroom lights during pop quizzes so nobody can hide a cheat-lie, and kids joke that star-eyes mean "fake rich."
   - **3 Named Planted Ammo Clues:**
     1. **Brightness = Lie Count:** One white lie gives a soft twinkle; fifty daily lies create a blinding golden star flare.
     2. **Parking Lot Back Corner (`7:30 AM`):** A beat-up silver station wagon (`#AEB6BF`) always parks behind the gym dumpsters before sunrise.
     3. **Taped-Up Designer Bag (`#8E44AD`):** Popular girl Chloe's "luxury" tote bag has clear packing tape holding the bottom seam together.
3. **13.5–21s Personal Trap & Crisis:**
   - During the school talent-show auction, mean-girl Bianca tries to humiliate Chloe onstage—shoving a spotlight in Chloe's face and daring her to tell one truth about her mansion so everyone sees her star-eyes flare.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Chloe Dodging the Question):** Chloe laughs and says *"Oh, you know how busy my parents are!"*—*FLASH!* Her star-eyes flare even brighter, making the crowd gasp and whisper.
   - **Clue 2 Fail (Narrator Leo Cutting the Stage Spotlight):** Leo yanks the stage dimmer switch; *CLICK!* In the dark auditorium, Chloe's blinding gold star-eyes glow ten times more obvious.
   - **Clue 3 Fail (Trying to Hand Chloe Sunglasses):** Leo tosses his sunglasses onstage; *SLIDE!* Bianca kicks them off the stage edge before Chloe can catch them.
5. **39–51s Genius Rule-Hack Climax:**
   - Leo runs onstage, skips the microphone, and gently holds up the silver car key fob Chloe dropped by the gym dumpsters that morning—giving her permission to drop the act. Chloe looks at the key, wipes a tear, and speaks into the quiet mic: *"I don't have a mansion. My dad lost his job, and we've been sleeping in our station wagon behind the gym."* *POOF!* Both blinding golden stars instantly dissolve out of her eyes, leaving warm, honest, ordinary dark eyes.
6. **51–56s Action Echo Punchline:**
   - Instead of laughing, the entire auditorium stands up cheering—and Leo quietly slips a thermos of hot soup and a spare gym-shower pass into Chloe's taped-up tote bag.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Leo (Narrator):** Role: Protagonist | Skin: `#F1C27D` | R6 Outfit: Stage-crew black tee (`#1C2833`), tool belt, dark jeans (`#2C3E50`), messy dark hair (`#1C1C1C`) | Emotion Swaps: `neutral` -> `shocked` -> `scared` -> `determined` -> `proud`.
- **Chloe (Star-Eye Girl):** Role: Hidden Struggle | Skin: `#FFDBAC` | R6 Outfit: Pastel lavender cardigan (`#D2B4DE`), plaid skirt/pants (`#5D6D7E`), long blonde hair (`#F7DC6F`) + star-eye overlay | Emotion Swaps: `grin` -> `scared` -> `sad` -> `proud`.
- **Bianca:** Role: Mean Foil | Skin: `#E0AC69` | R6 Outfit: Hot-pink blazer (`#E91E63`), white pants (`#F8F9F9`), high brown ponytail (`#4A2C1D`) | Emotion Swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Neon Star-Eye Overlay:** `0.3 x 0.3 x 0.05` studs, `Neon`, `#F1C40F`, socket `Head` (eyes).
- **Taped-Up Tote Bag:** `1.2 x 1.0 x 0.5` studs, `Fabric`, `#8E44AD` + `#D5D8DC` tape, socket `LeftHand`.
- **Silver Station Wagon Key Fob:** `0.3 x 0.1 x 0.5` studs, `Metal`, `#AEB6BF`, socket `RightHand`.
- **Stage Microphone & Stand:** `0.8 x 4.5 x 0.8` studs, `Metal`, `#17202A`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolAuditoriumStage` — polished oak stage (`WoodPlanks` `#6E4726`), red velvet curtains (`Fabric` `#922B21`), rows of audience seats (`SmoothPlastic` `#566573`).
- **Secondary Set:** `GymBackParkingLot` — asphalt lot (`Slate` `#2C3E50`), green dumpster (`Metal` `#1E8449`), silver station wagon (`Metal` `#AEB6BF`).
- **Lighting:** `ClockTime = 19.5` dim auditorium (`Brightness = 0.6`) with bright stage spotlight (`SpotLight` `#FFF8E7`) and golden star-eye bloom.
- **VFX/SFX Cues:** Four-point star sparkle `ParticleEmitter` from Chloe's eyes; soft dissolve shimmer when she tells the truth; SFX: camera flash pop, mic feedback chirp, stunned silence, warm auditorium applause.

---

## Story 021: The Zero-Heart Janitor

- **Story ID & Title:** Story 021 — *The Zero-Heart Janitor*
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** The quietest person in the hallway might be carrying the heaviest piece of everyone else's recovery.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, everyone has three glowing red hearts floating above their head—except our silent school janitor, whose tag said zero."
   - **Frame 1 Visual:** Hallway shot of cheerful students with three glowing crimson pixel hearts (`[♥ ♥ ♥]`, `#E74C3C`) above their heads, parting warily around old Janitor Arthur whose `BillboardGui` displays three hollow grey outlines (`[♡ ♡ ♡]`, `#7F8C8D`).
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A skateboarder wipes out on the sidewalk curb; *CRACK!*—one of his three glowing hearts shatters into red pixel shards, leaving him dizzy until he rests for a week.
   - **Town Adaptation:** Kids wear elbow pads to recess and brag about having `3/3` hearts, while rumors spread that `[0-Heart]` Janitor Arthur is a soulless ghost.
   - **3 Named Planted Ammo Clues:**
     1. **Heart-Transfer Touch (`Palm-to-Palm`):** A person can press their palm to someone's wrist to gift one full glowing heart—leaving a permanent empty outline behind.
     2. **Children's Ward Bandage (`#F8F9F9`):** Arthur's left wrist always has three faded hospital visitor stamps stacked under his sleeve.
     3. **The Dusty Mop Cart (`#D4AC0D`):** Tucked inside Arthur's supply closet are three framed thank-you crayon drawings from kids at St. Jude's Clinic.
3. **13.5–21s Personal Trap & Crisis:**
   - During fifth-period PE, narrator Maya's little brother Timmy trips on a loose gym rope and slams hard against the bleachers—losing his final `[♥]` heart to `0/3` while the ambulance is still ten minutes away in traffic!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Offering Maya's Own Heart):** Maya grabs Timmy's wrist to donate one of her hearts; *BUZZ!* Her `[<18 LOCKED]` wrist tag blocks minors from transferring hearts.
   - **Clue 2 Fail (Calling the Gym Coach to Donate):** Maya begs Coach Miller; *GASP!* Coach already only has `1/3` heart left from an old knee injury—donating it would drop him to zero.
   - **Clue 3 Fail (Using the Nurse's Ice Pack):** The school nurse presses an ice pack to Timmy's forehead; *BEEP!* Timmy's hollow `[♡ ♡ ♡]` bar flickers dangerously faint.
5. **39–51s Genius Rule-Hack Climax:**
   - Janitor Arthur bursts through the gym doors, drops his mop, and kneels beside Timmy. Maya yells *"Wait—you have zero left!"* Arthur smiles softly, rolls up his sleeve, and taps his chest—revealing one final hidden *gold* reserve heart (`[💛]`) saved for emergencies, which he presses straight into Timmy's wrist! *SHIMMER!* Timmy's `[♥]` lights back up bright crimson and he sits up coughing, while Arthur slumps tiredly against the bleachers with `0` hearts left.
6. **51–56s Action Echo Punchline:**
   - Every student in the gym quietly pulls out their recess snack bars and lines them neatly along Arthur's mop cart while Timmy hugs his arm.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Maya (Narrator):** Role: Protagonist | Skin: `#E0AC69` | R6 Outfit: Teal PE hoodie (`#16A085`), black track pants (`#1C2833`), high brown ponytail (`#4A2C1D`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Janitor Arthur:** Role: Secret Hero | Skin: `#FFDBAC` | R6 Outfit: Faded blue coveralls (`#2E86C1`), grey work cap (`#7F8C8D`), white beard | Emotion Swaps: `neutral` -> `sad` -> `determined` -> `proud`.
- **Timmy (Little Brother):** Role: Injured Kid | Skin: `#E0AC69` | R6 Outfit: Red gym tee (`#C0392B`), grey shorts (`#7F8C8D`), short dark hair (`#1C1C1C`) | Emotion Swaps: `scared` -> `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Floating Pixel Heart Bar (`[♥ ♥ ♥]` / `[♡ ♡ ♡]`):** `2.4 x 0.7 x 0.05` studs, `Neon` (`#E74C3C` / `#F1C40F` / `#7F8C8D`), socket `Head` BillboardGui.
- **Janitor Mop Cart:** `3.2 x 3.0 x 2.0` studs, `Plastic`, `#F1C40F`, socket `Workspace`.
- **Crayon Thank-You Drawings (x3):** `0.9 x 1.2 x 0.05` studs, `SmoothPlastic`, `#F8F9F9` + multi-color decals, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolGymnasium` — maple court (`WoodPlanks` `#D4AC0D`), padded blue wall mats (`SmoothPlastic` `#2471A3`), wooden bleachers (`WoodPlanks` `#8E5B34`).
- **Secondary Set:** `JanitorSupplyCloset` — metal shelving (`Metal` `#5D6D7E`), mop bucket, framed crayon cards.
- **Lighting:** `ClockTime = 16.8` bright afternoon rays through high clerestory windows; warm `#F1C40F` pulse on gold heart transfer.
- **VFX/SFX Cues:** Red pixel shatter `ParticleEmitter` on damage; warm golden heart ring expansion on Arthur's transfer; SFX: 8-bit heart chime, gym whistle, sneaker squeak, warm harmonic chord.

---

## Story 022: The 1-Task Impostor Bus

- **Story ID & Title:** Story 022 — *The 1-Task Impostor Bus*
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Sometimes the person wearing the "troublemaker" label is the only one checking if the brakes actually work.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, ten kids board the morning bus and one gets a red `[SABOTAGE]` tag only visible in mirrors—except he wasn't the villain."
   - **Frame 1 Visual:** Bus interior shot angled toward the driver's wide rearview mirror: nine kids sit calmly while quiet kid Zack in Seat 6 shows a glowing crimson `[SABOTAGE]` tag (`#E74C3C`) in the mirror glass.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Last Tuesday, a kid spotted `[SABOTAGE]` above his seatmate in his phone selfie cam, panicked, and pulled the emergency window latch—dumping everyone's backpacks onto Main Street.
   - **Town Adaptation:** Every student boards Bus #12 holding a pocket compact mirror to scan the aisle before picking a seat.
   - **3 Named Planted Ammo Clues:**
     1. **Mirror-Only Tag Rule:** `[SABOTAGE]` doesn't mean *evil*—it simply tags whoever plans to **stop the bus from reaching its scheduled stop**.
     2. **Driver's Masked Vent (`#17202A`):** The substitute bus driver wears a heavy respirator mask and keeps a brass padlock snapped over the emergency exit handle.
     3. **Bridge Construction Detour Sign (`#F39C12`):** Outside the foggy window, Road 9's yellow detour barrier was knocked flat into the ditch.
3. **13.5–21s Personal Trap & Crisis:**
   - At 7:52 AM, Bus #12 speeds past the normal school turnoff toward the condemned Old River Bridge; narrator Nia checks her pocket mirror, spots Zack's crimson `[SABOTAGE]` tag glowing bright, and watches Zack crouch toward the driver's gearshift!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Tackling Zack in the Aisle):** Nia and two jocks grab Zack's backpack straps; *THUD!* Zack wrestles free just enough to point wildly out the front windshield.
   - **Clue 2 Fail (Yelling at the Substitute Driver):** Nia screams *"Stop the bus, you missed the school!"*—*ROAR!* The masked driver only floors the gas pedal harder, locking the aisle divider door.
   - **Clue 3 Fail (Pulling the Rear Emergency Door):** Two kids yank the rear red handle; *CLANG!* The brass padlock holds the rear hatch completely shut.
5. **39–51s Genius Rule-Hack Climax:**
   - Nia glances into her compact mirror again—and finally sees *why* Zack has `[SABOTAGE]`: through the front glass, the Old River Bridge has a giant collapsed gap 100 studs ahead, and Zack is holding a heavy steel wrench aiming to *cut the bus's air-brake line*! Nia stops blocking Zack, grabs the fire-extinguisher pin to smash the driver's divider latch, and clears the aisle so Zack can wrench open the floor air-valve. *HISS-SCREEECH!* The emergency air brakes lock all four tires solid, skidding Bus #12 to a halt two studs before the broken bridge edge!
6. **51–56s Action Echo Punchline:**
   - As the stunned kids climb out the front door, the glowing red `[SABOTAGE]` tag in Nia's mirror flips to emerald green `[SAVED]`, and Nia hands Zack her pocket mirror with a nod.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Nia (Narrator):** Role: Protagonist | Skin: `#8D5524` | R6 Outfit: Yellow varsity hoodie (`#F1C40F`), dark jeans (`#212F3D`), braided black hair (`#111111`) | Emotion Swaps: `neutral` -> `shocked` -> `scared` -> `determined` -> `proud`.
- **Zack (Tagged Kid):** Role: Misunderstood Hero | Skin: `#FFDBAC` | R6 Outfit: Charcoal mechanic jacket (`#2C3E50`), black cargo pants (`#17202A`), messy brown hair (`#3B281E`) | Emotion Swaps: `scared` -> `determined` -> `proud`.
- **Substitute Driver:** Role: Antagonist | Skin: `#D2B48C` | R6 Outfit: Dark trenchcoat (`#1C2833`), respirator mask (`#111111`), black cap | Emotion Swaps: `neutral` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Pocket Compact Mirror:** `0.5 x 0.1 x 0.5` studs, `Metal` (Reflectance `0.95`), `#BDC3C7`, socket `LeftHand`.
- **Mirror `[SABOTAGE]` / `[SAVED]` Tag:** `2.4 x 0.7 x 0.05` studs, `Neon` (`#E74C3C` -> `#2ECC71`), socket `Head` BillboardGui (mirror layer).
- **Heavy Steel Wrench:** `0.3 x 1.4 x 0.2` studs, `Metal`, `#7F8C8D`, socket `RightHand`.
- **Yellow School Bus #12:** `10.0 x 8.0 x 26.0` studs, `SmoothPlastic` + `Glass`, `#F1C40F`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `Bus12Interior` — green vinyl seats (`SmoothPlastic` `#1E8449`), rubber aisle mat (`Slate` `#2C3E50`), chrome handrails (`Metal` `#BDC3C7`).
- **Secondary Set:** `CollapsedRiverBridge` — foggy asphalt road (`Slate` `#34495E`), snapped concrete bridge deck (`Concrete` `#7F8C8D`), knocked orange barrier (`Neon` `#FF6F00`).
- **Lighting:** `ClockTime = 7.8` foggy morning (`Atmosphere.Density = 0.5`) with bright `#E74C3C` dashboard warning lights.
- **VFX/SFX Cues:** Air-brake steam `ParticleEmitter` burst; tire skid smoke trails; SFX: diesel engine roar, brass padlock clank, sharp air-valve hiss, screeching tires.

---

## Story 023: The Red-Light Bell

- **Story ID & Title:** Story 023 — *The Red-Light Bell*
- **Format:** Standalone 52s, 44 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** You don't beat a hair-trigger trap by moving faster—you beat it by making it fire on empty air.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, whenever the school bell rings, moving a single muscle freezes you into solid ice until 6:00 PM—until I rolled a basketball."
   - **Frame 1 Visual:** Hallway freeze-frame: a red ceiling sensor (`#E74C3C`) flashes above a row of lockers while a kid mid-step turns into translucent pale-blue ice (`#AED6F1`) with one sneaker hovering in the air.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid sneezes right when the 8:15 AM tardy bell chimes; *CRACKLE!*—he freezes solid mid-sneeze in front of the water fountain for nine straight hours.
   - **Town Adaptation:** Students walk in stiff "statue-ready" crouches with their backpacks strapped tight so they don't tip over when the red ceiling laser sweeps.
   - **3 Named Planted Ammo Clues:**
     1. **3-Second Sensor Sweep:** Once the bell rings, the ceiling's red motion camera scans for *any* moving object—and powers down as soon as it locks onto one target.
     2. **Single-Target Ice Bolt:** Each hallway unit only has enough charge for **one freeze zap per bell ring** before its capacitor needs 60 seconds to recharge.
     3. **Orange Rubber Basketball (`#E67E22`):** Narrator Devin always carries his scuffed gym basketball under his left arm.
3. **13.5–21s Personal Trap & Crisis:**
   - At 2:59 PM, the fire-alarm bell malfunctions and starts ringing early while Devin's little sister Zoe is stuck halfway across the slick gym lobby floor carrying a heavy glass science project—and the red ceiling sensor locks straight onto her!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Yelling "Freeze!" to Zoe):** Devin shouts *"Don't move!"*—*SLIP!* Zoe's sneaker slides an inch on the wax floor, triggering the red targeting beep.
   - **Clue 2 Fail (Throwing His Jacket Over the Sensor):** Devin flings his varsity jacket upward; *SWISH!* It falls two studs short of the high 14-foot ceiling mount.
   - **Clue 3 Fail (Dashing to Grab Zoe):** Devin takes one lunging step into the lobby; *BEEP-BEEP!* The sensor splits its lock, humming louder at `90%` charge!
5. **39–51s Genius Rule-Hack Climax:**
   - Devin drops to one knee, aims his orange rubber basketball straight across the polished floor *three studs in front of Zoe's shoes*, and gives it a crisp chest-pass spin! The basketball rolls fast across the red laser grid—*ZAP!* The ceiling sensor's single-target bolt fires straight down onto the moving basketball, freezing the ball into a solid block of blue ice while the sensor flashes `[RECHARGING 60s]`. Devin sprints safely across the floor, scoops up Zoe and her glass project, and clears the exit doors.
6. **51–56s Action Echo Punchline:**
   - Outside in the warm sun, Devin nudges the frozen ice-basketball with his toe—and Zoe laughs as it clanks like a bowling ball down the sidewalk.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Devin (Narrator):** Role: Protagonist | Skin: `#8D5524` | R6 Outfit: Blue-and-white basketball jersey (`#2471A3`), black athletic shorts (`#17202A`), short fade hair (`#111111`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Zoe (Little Sister):** Role: Protected Sibling | Skin: `#8D5524` | R6 Outfit: Lavender hoodie (`#9B59B6`), denim overalls (`#2E86C1`), twin puffs (`#111111`) | Emotion Swaps: `scared` -> `shocked` -> `proud`.
- **Hallway Statue Kid:** Role: Opening Victim | Skin: `#FFDBAC` | R6 Outfit: Ice-tinted green polo (`#AED6F1`), khakis (`#D5C39A`) | Emotion Swaps: `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Ceiling Motion Sensor:** `1.2 x 0.8 x 1.2` studs, `Metal` + `Neon` red lens (`#E74C3C`), socket `Workspace`.
- **Orange Basketball:** `1.1 x 1.1 x 1.1` studs, `SmoothPlastic` (`#E67E22`) -> `Ice` (`#AED6F1`), socket `LeftHand` / `Workspace`.
- **Glass Science Terrarium:** `1.4 x 1.2 x 1.0` studs, `Glass`, `#D6EAF8`, socket `RightHand` (Zoe).

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `SchoolGymLobby` — high-gloss waxed floor (`Marble` `#EAEDED`), trophy cases (`Glass` `#D6EAF8`), double exit doors (`Metal` `#5D6D7E`).
- **Secondary Set:** `SidewalkOutside` — sunlit concrete (`Concrete` `#BDC3C7`), green lawn (`Grass` `#27AE60`).
- **Lighting:** `ClockTime = 16.8` warm afternoon light outside, cool indoor lobby lit by sweeping `#E74C3C` red sensor laser cones.
- **VFX/SFX Cues:** Thin `#AED6F1` ice-crystal freeze burst `ParticleEmitter`; red laser sweep beam; SFX: loud brass school bell, high-pitched targeting beep, sharp ice-crack zap, solid frozen ball clank.

---

## Story 024: The 6-AM Power Meter

- **Story ID & Title:** Story 024 — *The 6-AM Power Meter*
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Locking out what scares you in the dark sometimes locks out the very thing that just needed to get warm.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every house gets 100% battery at midnight and locking a door drains it ten times faster—until we opened the door at 1%."
   - **Frame 1 Visual:** Dim living room shot: a glowing green digital wall meter (`[100%]`, `#2ECC71`) beside the front deadbolt while heavy claws scratch softly against the frosted porch glass outside.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A neighbor panics at a shadow on his porch, slams all four deadbolts and turns on every floodlight; *BEEP-DEAD!*—his house hits `0%` at 1:15 AM, plunging him into pitch darkness until sunrise.
   - **Town Adaptation:** Families sleep in the living room beside the power meter, keeping one dim hallway bulb on and rationing deadbolt locks to 10-minute bursts.
   - **3 Named Planted Ammo Clues:**
     1. **Low-Angle Scratch Marks (`1.5 studs high`):** The scratches on the front door are all near the bottom kickplate—never at doorknob height.
     2. **Frostbite Blizzard (`-12°C`):** A sudden winter freeze hit the valley tonight, coating every porch step in snow.
     3. **Warm Beef Broth Pot (`#D35400`):** Narrator Leo's mom left a thermos of warm soup and an old wool blanket by the radiator.
3. **13.5–21s Personal Trap & Crisis:**
   - At `4:40 AM`, loud scratching echoes at both the front and back doors of Leo's house—his little sister Mia slams both heavy deadbolts shut, sending the wall meter plummeting `18%... 9%... 3%...` with over an hour left until 6:00 AM!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Unplugging the Fridge & TV):** Leo yanks the living room plugs; *CLICK!* The power drain barely slows because the two locked deadbolts eat 90% of the juice.
   - **Clue 2 Fail (Shining a Flashlight Through the Peephole):** Leo peers through the top peephole; *EMPTY!* Nothing stands at eye level—just swirling snow.
   - **Clue 3 Fail (Banging on the Door to Scare Them Off):** Leo pounds the wood panel; *THUD!* A soft, shivering whimper answers back from below the glass.
5. **39–51s Genius Rule-Hack Climax:**
   - At `1%` battery, Leo notices the scratches are only 1.5 studs off the floor. Ignoring Mia's gasp, he unlocks *both* deadbolts—immediately stopping the 10x power drain—and cracks the front door open three inches. Out of the freezing snow tumble three shivering, snow-dusted stray dogs and a lost orange tabby cat, trotting straight onto the warm living room rug without a single monster in sight!
6. **51–56s Action Echo Punchline:**
   - At `6:00 AM`, golden sunrise fills the window while the stray dogs snooze wrapped in Leo's wool blanket beside the `[1% -> 100%]` recharged meter.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Leo (Narrator):** Role: Protagonist | Skin: `#F1C27D` | R6 Outfit: Plaid flannel pajama shirt (`#C0392B`), grey sweats (`#7F8C8D`), messy dark hair (`#2C1A12`) | Emotion Swaps: `scared` -> `shocked` -> `determined` -> `proud`.
- **Mia (Little Sister):** Role: Sibling | Skin: `#F1C27D` | R6 Outfit: Blue star-print pajamas (`#2980B9`), fuzzy slippers, messy bun (`#2C1A12`) | Emotion Swaps: `scared` -> `shocked` -> `proud`.
- **Stray Dogs & Tabby Cat (x4):** Role: "Monsters" Twist | Rig: Blocky Roblox pets (`#D35400`, `#AEB6BF`, `#6E4726`) | Emotion Swaps: `sad` -> `happy`.

### Props & Sockets (Sound-Off Visible)
- **Digital Wall Power Meter:** `1.6 x 1.0 x 0.2` studs, `Metal` + `Neon` readout (`#2ECC71` -> `#E74C3C`), socket `Workspace`.
- **Heavy Steel Deadbolt:** `0.6 x 0.4 x 0.3` studs, `Metal`, `#D4AC0D`, socket `Workspace` (door).
- **Wool Blanket & Bowl:** `2.5 x 0.2 x 2.0` studs, `Fabric`, `#E67E22`, socket `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `LivingRoomNight` — hardwood floor (`WoodPlanks` `#6E4726`), frosted front door (`Glass` `#AED6F1`), brick fireplace/radiator (`Brick` `#922B21`), woven rug (`Fabric` `#D5C39A`).
- **Secondary Set:** `SnowyFrontPorch` — snow-covered steps (`Snow` `#F8F9F9`), porch railing (`WoodPlanks` `#8E5B34`).
- **Lighting:** `ClockTime = 4.5` pitch-blue winter night (`#1B2631`) with pulsing `#E74C3C` low-battery alarm glow, snapping to warm `ClockTime = 6.2` golden dawn.
- **VFX/SFX Cues:** Swirling snow `ParticleEmitter` when door opens; warm dust motes at 6:00 AM; SFX: wood scratching, heavy deadbolt clack, urgent `1%` power beep, soft happy dog whimpers, 6:00 AM chime.

---

## Story 025: The Closet-Eye Rule

- **Story ID & Title:** Story 025 — *The Closet-Eye Rule*
- **Format:** Standalone 56s, 48 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** When everyone sprints for the closest hiding spot, look for the one door that doesn't match the rest.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, when the hallway lights flicker, you have three seconds to hide in a locker—except Locker #4 wasn't a locker at all."
   - **Frame 1 Visual:** Long dark school corridor shot: overhead fluorescent tubes flicker violently (`#F8F9F9` -> `#111111`), a glowing violet eye-smoke (`#8E44AD`) sweeps down the hall, and kids slam locker doors shut around them.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid ignores the second light flicker to tie his shoe; *WHOOSH!*—the violet shadow-gust rattles every window in the wing and turns his backpack into static-covered frost until morning.
   - **Town Adaptation:** Every student keeps one hand on a locker handle between classes and wears a `3-2-1` glowing wristband timer.
   - **3 Named Planted Ammo Clues:**
     1. **3-Second Flicker Count:** Flicker 1 = warning; Flicker 2 = 3 seconds left; Flicker 3 = the violet gust hits the hall.
     2. **Ventless Locker #4 (`#5D6D7E`):** Unlike Lockers #1, #2, and #3, Locker #4 has no top air slats—and its hinges are bolted on the *inside*.
     3. **Yellow Janitor Keyring (`#F1C40F`):** Narrator Sam found a bent brass key tagged `[#4 ESCAPE]` taped under the water fountain yesterday.
3. **13.5–21s Personal Trap & Crisis:**
   - Staying late for robotics club, Sam and his friend Eli get caught in the long West Wing when Flicker 1 hits—and every single regular locker (`#1`, `#2`, `#3`, `#5`, `#6`) has heavy padlocks snapped onto them for summer cleaning!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail (Sprinting for the Gym Exit Doors):** Sam and Eli bolt for the double doors; *CLANG!* Flicker 2 flashes—the automated fire doors seal shut before they reach halfway.
   - **Clue 2 Fail (Yanking Locker #3's Padlock):** Eli pulls desperately at Locker #3's steel lock; *CLINK!* The master padlock doesn't budge.
   - **Clue 3 Fail (Trying to Squeeze Under a Bench):** Sam dives behind a wooden bench; *HISS!* Violet shadow-smoke creeps along the floor tiles—open benches won't block it.
5. **39–51s Genius Rule-Hack Climax:**
   - With `1.5 seconds` left on Sam's wristband, he spots ventless Locker #4, jams the bent brass `[#4 ESCAPE]` key into its keyhole, and yanks both Eli and himself inside just as Flicker 3 explodes across the hall! Inside, there's no back wall at all—just a lit concrete ladder descending into the janitor's warm, brightly lit underground rescue tunnel stocked with flashlights and cocoa thermoses, safely sealed behind Locker #4's airtight steel door.
6. **51–56s Action Echo Punchline:**
   - Sam flips the inside brass deadbolt as the violet gust rattles harmlessly overhead, and Eli grins holding up a warm flashlight from the tunnel shelf.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Sam (Narrator):** Role: Protagonist | Skin: `#C68642` | R6 Outfit: Orange-and-grey windbreaker (`#E67E22`), black jeans (`#17202A`), short dark hair (`#1C1C1C`) | Emotion Swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Eli:** Role: Best Friend | Skin: `#FFDBAC` | R6 Outfit: Blue robotics club hoodie (`#2471A3`), khakis (`#D5C39A`), glasses + curly brown hair (`#4A2C1D`) | Emotion Swaps: `scared` -> `shocked` -> `proud`.
- **Hallway Students (x3):** Role: Opening Crowd | Skin: `#E0AC69`, `#8D5524`, `#F1C27D` | R6 Outfits: School sweaters (`#27AE60`, `#C0392B`, `#8E44AD`) | Emotion Swaps: `scared` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Ventless Locker #4:** `2.4 x 6.2 x 2.2` studs, `Metal`, `#5D6D7E` + `#F1C40F` `[4]` plate, socket `Workspace`.
- **Bent Brass `[#4 ESCAPE]` Key:** `0.4 x 0.1 x 0.2` studs, `Metal`, `#F1C40F`, socket `RightHand`.
- **`3-2-1` Wristband Timer:** `0.55 x 0.2 x 0.55` studs, `Neon`, `#E74C3C`, socket `LeftHand` (wrist).
- **Rescue Tunnel Ladder & Flashlight:** `1.8 x 12.0 x 0.5` studs, `Metal`, `#7F8C8D` + `#F1C40F` beam, socket `Workspace` / `RightHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** `WestWingCorridor` — checkered tile floor (`Marble` `#EAEDED` / `#2C3E50`), rows of padlocked lockers (`Metal` `#5D6D7E`), overhead fluorescent lights (`Neon` `#F8F9F9`).
- **Secondary Set:** `JanitorRescueTunnel` — warm brick tunnel (`Brick` `#922B21`), concrete floor (`Concrete` `#7F8C8D`), glowing warm amber bulbs (`Neon` `#F39C12`).
- **Lighting:** `ClockTime = 18.5` dark hallway with rapid `Brightness` flicker (`1.5 -> 0.1 -> 1.5`) and `#8E44AD` shadow-gust fog, snapping to cozy warm `#F39C12` tunnel light.
- **VFX/SFX Cues:** Violet shadow-smoke `ParticleEmitter` sweeping the corridor; dramatic camera shake on door seal; SFX: fluorescent buzz-flicker, rapid `3-2-1` wristwatch beep, heavy key turn, wind-howl muffled behind airtight steel door.


---

# StudVerse Tales — Part 2: Stories 026–050 (Gaming Twists & Superhero/Vigilante Twists)

---

## Category 2: Gaming & Survival Crossover Plot-Twists (Stories 026–040)

---

### Story 026: The Respawn Bed
- **Story ID & Title:** `026 — The Respawn Bed`
- **Format:** Standalone 50–56s, 46 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Being prepared with something small and unglamorous beats having all the flashy gear when the door locks behind you.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, wherever you last took a nap is where you teleport the instant you stub your toe—and I just got locked inside the Mayor's steel vault!"
   - **Frame 1 Visual:** Tight close-up on Narrator (Leo) pressed against a gleaming 12-stud steel vault door spinning shut, red `[RESPAWN: HOME BED]` BillboardGui pulsing above his head while he clutches a rolled-up mini sleeping bag under his arm.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** At the town skatepark, Toby slips on a skateboard, scrapes his knee, and *POOF!* vanishes in a burst of white sparkles—reappearing 3 miles away in his mom's laundry hamper where he napped at noon.
   - **Town Adaptation:** Everyone wraps their ankles in bubble wrap and mounts padded `[NO-BUMP]` foam bumpers on every locker door and desk corner so nobody accidentally teleports out of math class.
   - **3 Named Planted Ammo Clues:**
     1. **Pocket Mini Sleeping Bag** (a 1.5-stud rolled nylon cylinder clipped to Leo's belt).
     2. **Vault Floor Air-Vent Grate** (a rusted 2-stud metal grate bolted into the corner).
     3. **Brass Thumbtack** (pinned to Leo's backpack strap from homeroom).
3. **13.5–21s Personal Trap & Crisis:**
   - Leo sneaks into City Hall's basement to retrieve his dad's confiscated bakery permit, but the Mayor's heavy steel vault door slams shut on a timer—oxygen ticks down from `30%` on the wall gauge, and Leo's respawn point is still set to his bedroom 4 miles away, leaving his dad's permit trapped inside.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Leo unrolls the **Pocket Mini Sleeping Bag** on the cold vault floor and squeezes his eyes shut to reset his spawn point—*SNORE-FAIL!* A red `[SLEEP BLOCKED: TOO BRIGHT]` alert flashes from the ceiling bulb.
   - **Clue 2 Fail:** Leo jams the **Brass Thumbtack** into his heel to force a respawn—*POOF!* He teleports straight back to his bedroom empty-handed, leaving his dad's permit inside the locked vault.
   - **Clue 3 Fail:** Leo crawls to the **Vault Floor Air-Vent Grate** and yanks with both hands—*CLANG!* The rusted bolts won't budge a millimeter, and the oxygen gauge drops to `08%`.
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—you only need to reset your spawn *outside* the vault, then get hurt *inside* it! Leo sprints back to City Hall's hallway, unrolls his **Pocket Mini Sleeping Bag** right outside the vault door in the dark stairwell, naps for 2 seconds until `[RESPAWN SET: STAIRWELL]` chimes green, sprints back in just before the shift lock, grabs his dad's permit off the desk, and pokes his thumb with the **Brass Thumbtack**—*POP!* He vanishes in white sparkles with the permit in hand, reappearing right on his sleeping bag outside the locked steel door.
6. **51–56s Action Echo Punchline:**
   - Leo zips the mini sleeping bag back onto his belt, holds up the stamped bakery permit to the security camera, and taps his brass thumbtack with a grin as the Mayor's alarm blares behind the sealed vault.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Leo (Narrator / Protagonist):** Skin `#F1C27D`, R6; Shirt: Teal Zip-Up Hoodie (`#1D6F72`), Pants: Charcoal Cargo Shorts (`#36393F`), Hair: Messy Chestnut Spikes (`#4A3123`); Face swaps: `determined` -> `shocked` -> `scared` -> `grin` -> `proud`.
- **Toby (Skatepark Kid):** Skin `#E0B490`, R6; Shirt: Orange Graphic Tee (`#E67E22`), Pants: Denim Jeans (`#2E5984`), Hat: Backwards Red Cap (`#C0392B`); Face swaps: `grin` -> `shocked`.
- **Mayor Vance (Antagonist):** Skin `#F5D0A9`, R6; Shirt: Navy Pinstripe Suit (`#1B2631`), Pants: Navy Suit Slacks (`#1B2631`), Hair: Slicked Silver Part (`#BDC3C7`); Face swaps: `neutral` -> `shocked`.

#### Props & Sockets (Sound-Off Visible)
- **Pocket Mini Sleeping Bag:** `1.6 x 0.7 x 0.7 studs`, `Fabric`, Cobalt Blue (`#2471A3`), Socket: `UpperTorso` (back/belt) -> `Workspace` (unrolled `5.5 x 0.3 x 2.4 studs`).
- **Brass Thumbtack:** `0.3 x 0.3 x 0.4 studs`, `Metal`, Gold (`#F1C40F`), Socket: `RightHand`.
- **Bakery Permit Clipboard:** `1.2 x 0.1 x 1.6 studs`, `WoodPlanks` + `SmoothPlastic` paper, Tan/White (`#D5B895` / `#FFFFFF`), Socket: `RightHand`.
- **Vault Oxygen Gauge:** `2.0 x 1.4 x 0.3 studs`, `Neon` + `Metal`, Red/Green (`#E74C3C`), Socket: `Workspace` (vault wall).
- **Respawn Tag:** `BillboardGui` (`3.5 x 1.0 studs`), `Head` socket above Leo.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** City Hall Basement Vault — `DiamondPlate` steel floor, `Concrete` walls, 12-stud circular steel door with rotating spoke wheel, flickering overhead cage lamp.
- **Secondary Set:** Town Skatepark (`Concrete` half-pipe with painted graffiti stripes) & Leo's Bedroom (`WoodPlanks` floor, twin bed).
- **Lighting & Camera:** `ClockTime = 16.8` outside at skatepark (warm golden contrast), switching to `ClockTime = 22.0` (`Brightness = 0.8`, cool cyan-gray `Ambient = #2C3E50`) inside the basement; low-angle wide shot on vault slam, Dutch-tilt close-up on `08%` oxygen gauge.
- **VFX/SFX Cues:** White star-sparkle `ParticleEmitter` burst on teleport; metallic *CLANG!* on vent grate, crisp *DING!* on spawn-set chime, *POOF!* on respawn pop.

---

### Story 027: The Inventory Backpack
- **Story ID & Title:** `027 — The Inventory Backpack`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Useful tools look silly until the exact moment everyone else's status symbols run out of battery.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, you only get four inventory slots for your entire life—and everyone laughed because I wasted three of mine on junk!"
   - **Frame 1 Visual:** Top-down 4-slot hotbar HUD (`[1: ROPE] [2: CHALK] [3: WHISTLE] [4: EMPTY]`) glowing at the bottom of the screen while classmates point and laugh at Narrator (Maya) holding a coil of hemp rope in the cafeteria.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Rich kid Damien drops his new gold watch—except all `4` of his slots are full (`[PHONE] [CASH] [COLONY KEY] [SUNGLASSES]`), so the watch bounces off an invisible barrier and rolls straight down a storm drain.
   - **Town Adaptation:** Kids wear oversized cargo vests with zero actual pockets, bragging about their `[4/4]` glowing hotbar icons floating beside their hips like luxury badges.
   - **3 Named Planted Ammo Clues:**
     1. **Slot 1: 20-Stud Hemp Rope** (coiled around Maya's waist).
     2. **Slot 2: Neon Orange Sidewalk Chalk** (sticking out of her hand).
     3. **Slot 3: Brass Coach Whistle** (hanging on a lanyard).
3. **13.5–21s Personal Trap & Crisis:**
   - During a field trip to the Old Limestone Quarry, a sudden mudslide collapses the wooden footbridge, trapping Damien and three classmates on a crumbling ledge above rising floodwater—and every single kid's `[4/4]` slots are packed with dead phones and soggy cash.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Maya equips **Slot 1: 20-Stud Hemp Rope** and hurls it across the gap—*SPLASH!* It falls `6 studs` short into the churning mud.
   - **Clue 2 Fail:** Maya scribbles an arrow on the cliff rock with **Slot 2: Neon Orange Sidewalk Chalk** to signal the tour bus driver—*THUNDER!* Rain washes the chalk streak away in two seconds.
   - **Clue 3 Fail:** Maya blows **Slot 3: Brass Coach Whistle** as hard as she can toward the ranger station—*TWEET!* The wind drowns it out behind the quarry wall.
5. **39–51s Genius Rule-Hack Climax:**
   - Maya stares at her empty `[4: EMPTY]` slot—she doesn't need to throw farther, she needs a *second* anchor! She ties **Slot 1: Hemp Rope** to a fallen pine log, drops **Slot 2: Chalk** into the mud to mark the safe stepping stones below the water, then grabs a heavy iron wrench lying by the bus tire into **Slot 4**, ties it to the rope's loose end, and swings it like a grappling hook—*CLANK!* It wedges between two boulders on Damien's ledge. She blows **Slot 3: Whistle** in three sharp blasts to cue the bus headlights onto her chalk-marked stones so all four kids cross safely.
6. **51–56s Action Echo Punchline:**
   - Maya pulls her muddy wrench back out of Slot 4, tosses it into the bus toolbox, and taps her `[1: ROPE] [2: CHALK] [3: WHISTLE]` hotbar as Damien quietly drops his wet cash to pick up a spare flashlight.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Maya (Narrator / Protagonist):** Skin `#8D5524`, R6; Shirt: Olive Utility Jacket (`#556B2F`), Pants: Khaki Trousers (`#C3B091`), Hair: Braided Twin Puffs (`#1C1C1C`); Face swaps: `neutral` -> `determined` -> `scared` -> `grin` -> `proud`.
- **Damien (Rich Classmate):** Skin `#F5D0A9`, R6; Shirt: White Polo (`#FFFFFF`) with Gold Trim, Pants: Tan Chinos (`#D2B48C`), Hair: Blonde Side-Sweep (`#F4D03F`); Face swaps: `grin` -> `scared` -> `shocked`.
- **Bus Driver Lou (Support):** Skin `#C68642`, R6; Shirt: Blue Transit Uniform (`#2874A6`), Pants: Dark Navy (`#1B2631`), Hat: Transit Cap (`#1B2631`); Face swaps: `neutral` -> `shocked`.

#### Props & Sockets (Sound-Off Visible)
- **4-Slot Hotbar Billboard:** `BillboardGui` (`5.0 x 1.2 studs`), `UpperTorso` side offset.
- **20-Stud Hemp Rope:** `1.8 x 0.5 x 1.8 studs` coiled (`20 x 0.2 x 0.2 studs` uncoiled), `Fabric`, Tan (`#C29B61`), Socket: `RightHand`.
- **Neon Orange Sidewalk Chalk:** `0.3 x 0.8 x 0.3 studs`, `Slate`, Neon Orange (`#FF6F00`), Socket: `RightHand`.
- **Brass Coach Whistle:** `0.4 x 0.3 x 0.6 studs`, `Metal`, Brass (`#D4AC0D`), Socket: `UpperTorso` / `RightHand`.
- **Heavy Iron Wrench:** `0.4 x 0.3 x 2.2 studs`, `Metal`, Dark Steel (`#566573`), Socket: `RightHand`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Old Limestone Quarry — `Slate` cliff walls, `Mud` rising basin, snapped `WoodPlanks` bridge, yellow school bus parked on gravel rim.
- **Secondary Set:** School Cafeteria (`Marble` tiled floor, `Metal` lunch tables).
- **Lighting & Camera:** `ClockTime = 17.4` overcast storm (`Brightness = 1.1`, `FogEnd = 120`, slate-blue `Ambient = #4A5568`); sweeping crane shot across the 26-stud chasm, tight insert on the 4-slot hotbar flipping from `EMPTY` to `WRENCH`.
- **VFX/SFX Cues:** Rain streak `ParticleEmitter` + mud splash rings; *SPLASH!* on short throw, *TWEET-TWEET-TWEET!* on whistle blasts, *CLANK!* on wrench hook.

---

### Story 028: The XP Bar Bully
- **Story ID & Title:** `028 — The XP Bar Bully`
- **Format:** Standalone 50–56s, 44 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Greed that climbs by pushing others down eventually hits the ceiling that resets it to zero.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every time you bully someone you steal ten XP from them—and Brock just hit Level ninety-nine!"
   - **Frame 1 Visual:** Giant 9-stud-tall bully Brock towering over tiny `[LVL 02]` Narrator (Sam) in the schoolyard, a glowing green `[LVL 99 — 90/100 XP]` bar floating like a crown above Brock's head.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A seventh-grader shoves a kindergartener off the swings; blue `[+10 XP]` orbs fly out of the little kid's chest into the bully's bar, instantly making him grow two inches taller while the kindergartener shrinks to backpack height.
   - **Town Adaptation:** Kids walk around in pairs wearing foam `[NO-SHOVE]` bumper rings and hiding behind lockers whenever Brock's footsteps shake the hallway tiles.
   - **3 Named Planted Ammo Clues:**
     1. **Principal's Town Rulebook Poster** (bottom line in tiny print: `MAX CAP: LVL 99 -> PRESTIGE RESET`).
     2. **Lunch Tray Apple** (held in Sam's right hand, `10 XP` value).
     3. **Hallway Height-Chart Wall** (painted ruler markings from `2 ft` to `10 ft`).
3. **13.5–21s Personal Trap & Crisis:**
   - Brock corners Sam against the brick gym wall, needing just `10 XP` to hit `Level 100`—and if Brock takes Sam's final `10 XP`, Sam will drop to `Level 0` and shrink small enough to slip straight down the gym floor drain.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Sam tries to sprint past Brock toward the **Hallway Height-Chart Wall** to call the coach—*THUD!* Brock's giant boot blocks the exit door.
   - **Clue 2 Fail:** Sam tosses his **Lunch Tray Apple** to distract Brock—*CRUNCH!* Brock smashes it in one fist and laughs, `[90/100 XP]` pulsing brighter.
   - **Clue 3 Fail:** Sam points at the **Principal's Town Rulebook Poster** warning about the cap—*RIP!* Brock tears the bottom corner off without reading it and reaches for Sam's shoulder.
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—if Brock only needs `10 XP` to hit `Level 100`, Sam doesn't need to stop him from stealing it; he needs to *give* it to him! Instead of dodging, Sam steps forward and taps Brock's chest with his own `[+10 XP]` lunch pass—*DING-DING-DING!* Blue orbs surge into Brock's bar: `99 -> 100`! A blinding `[PRESTIGE RESET: LVL 01]` beam shoots from the sky—*SHWOOOP!* Brock shrinks in half a second from 9 studs tall down to 2.5 studs, swimming inside his own giant hoodie!
6. **51–56s Action Echo Punchline:**
   - Sam picks up his own dropped lunch tray, sets a tiny juice box in front of kindergarten-sized Brock sitting in a puddle of his own sleeves, and walks into the gym without looking back.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Sam (Narrator / Protagonist):** Skin `#F1C27D`, R6; Shirt: Striped Blue Tee (`#2E86C1`), Pants: Gray Shorts (`#7F8C8D`), Hair: Fluffy Brown Mop (`#5D4037`); Face swaps: `scared` -> `determined` -> `grin` -> `proud`.
- **Brock (Bully):** Skin `#E0B490`, R6 (scaled `1.6x` at LVL 99, `0.45x` at LVL 1); Shirt: Crimson Varsity Jacket (`#922B21`), Pants: Black Sweatpants (`#1C2833`), Hair: Buzzcut (`#2C3E50`); Face swaps: `grin` -> `shocked` -> `scared`.

#### Props & Sockets (Sound-Off Visible)
- **XP Level Billboard:** `BillboardGui` (`4.2 x 1.0 studs`), `Head` socket (`[LVL 99]` green/gold vs `[LVL 02]` blue).
- **Principal's Rulebook Poster:** `2.5 x 3.2 x 0.1 studs`, `SmoothPlastic`, Cream/Red (`#FEF9E7` / `#C0392B`), Socket: `Workspace` (gym wall).
- **Lunch Tray Apple:** `0.6 x 0.6 x 0.6 studs`, `SmoothPlastic`, Red (`#E74C3C`), Socket: `RightHand`.
- **Hallway Height-Chart Wall:** `4.0 x 6.0 x 0.2 studs`, `Concrete`, White/Black tick marks, Socket: `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Brick Courtyard & Gym Entrance — `Brick` red walls, `Concrete` pavement, double `Metal` gym doors, `Height-Chart` painted beside doorway.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 1.6`, warm golden-hour rim light); low-angle upward tilt making Brock look colossal at `LVL 99`, then high-angle downward tilt looking at tiny `LVL 01` Brock buried in his varsity jacket.
- **VFX/SFX Cues:** Floating blue `ParticleEmitter` XP orbs; *THUD!* on boot block, *DING-DING-DING!* on level-up chime, comedic *SHWOOOP!* shrink whistle.

---

### Story 029: The Blue-Portal Locker
- **Story ID & Title:** `029 — The Blue-Portal Locker`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Distance disappears when you remember which two doors are secretly connected.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, whatever you drop into Locker A falls straight out of Locker B three miles away—and the science lab is on fire!"
   - **Frame 1 Visual:** Narrator (Eli) dropping a shiny quarter into glowing blue Locker #01 in the school hallway while a split-screen shows the same quarter *PLINK!* out of glowing orange Locker #02 inside the downtown fire-alarmed lab.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid shoves his soggy tuna sandwich into Locker #01 to hide it before inspection—and three miles away it *SPLAT!* lands right on the Mayor's head inside the downtown rec center.
   - **Town Adaptation:** The school janitor welds heavy padlocks onto both lockers and hangs `[NO LUNCHES — PORTAL ACTIVE]` warning signs across the handles.
   - **3 Named Planted Ammo Clues:**
     1. **Locker #01 (Blue Rim)** in the empty school hallway.
     2. **Locker #02 (Orange Rim)** bolted inside the downtown Chemistry Lab directly above the automated suppression valve.
     3. **Fire Extinguisher Safety Pin & Heavy Wrench** sitting on the school's hallway fire cabinet.
3. **13.5–21s Personal Trap & Crisis:**
   - A Bunsen burner tips over in the downtown Chemistry Lab after hours, locking the auto-fire shutters shut—Eli's older sister is trapped outside the lab watching smoke pour from the vents, while Eli is stranded three miles away at school with `45 seconds` before the chemical shelf blows.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Eli yanks on **Locker #01's Padlock** to open the portal—*CLANK!* The janitor's hardened steel lock doesn't budge.
   - **Clue 2 Fail:** Eli calls his sister and tells her to throw water through **Locker #02**—*HISS!* The one-way orange portal only spits items *out*, bouncing the water bottle back into her face.
   - **Clue 3 Fail:** Eli grabs the **Hallway Fire Extinguisher** to shove the whole tank through the vent slot—*THUD!* The tank is `1.4 studs` wide, and the locker louver slot is only `0.4 studs` wide.
5. **39–51s Genius Rule-Hack Climax:**
   - Eli stares at the `0.4-stud` louver slot—a tank won't fit, but a *pin* will! Above **Locker #02** in the lab sits the ceiling sprinkler's manual trigger lever, held shut by a tiny hair-trigger glass bulb. Eli grabs the **Fire Extinguisher Safety Pin** and a **Heavy Steel Washer** from the tool rack, loops them together, and slides them sideways through Locker #01's top louver slot—*WHOOSH-PLINK!* Three miles away, the weighted pin drops out of Locker #02's ceiling grate, *CRACK!* shatters the sprinkler trigger bulb, and *PSHHHHH!* floods the burning lab in foam.
6. **51–56s Action Echo Punchline:**
   - Eli's phone buzzes with a soaking-wet thumbs-up selfie from his sister outside the lab, and he neatly hangs the empty extinguisher pin tag back on the hallway hook.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Eli (Narrator / Protagonist):** Skin `#E0B490`, R6; Shirt: Dark Green Science Club Tee (`#1E8449`), Pants: Black Jeans (`#212F3D`), Hair: Curly Dark Brown (`#3E2723`); Face swaps: `shocked` -> `determined` -> `scared` -> `grin` -> `proud`.
- **Nora (Older Sister):** Skin `#E0B490`, R6; Shirt: White Lab Coat over Blue Shirt (`#ECF0F1`), Pants: Dark Gray Slacks (`#566573`), Hair: High Ponytail (`#3E2723`); Face swaps: `scared` -> `shocked` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Locker #01 (Blue Portal):** `2.2 x 6.5 x 2.0 studs`, `Metal` + `Neon` trim, Steel Gray / Cyan (`#5D6D7E` / `#00BFFF`), Socket: `Workspace` (School Hall).
- **Locker #02 (Orange Portal):** `2.2 x 6.5 x 2.0 studs`, `Metal` + `Neon` trim, Steel Gray / Orange (`#5D6D7E` / `#FF7F00`), Socket: `Workspace` (Lab).
- **Fire Extinguisher Pin + Steel Washer:** `0.5 x 0.2 x 0.5 studs`, `Metal`, Silver (`#BDC3C7`), Socket: `RightHand`.
- **Sprinkler Glass Trigger Bulb:** `0.3 x 0.5 x 0.3 studs`, `Glass`, Red (`#E74C3C`), Socket: `Workspace` (Lab ceiling).

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Hallway — `Marble` checkered floor, `Brick` painted walls, row of lockers with glowing cyan `#01`.
- **Secondary Set:** Downtown Chemistry Lab — `Concrete` floor, `Metal` lab benches, orange-lit `#02` locker, flickering orange fire glow & smoke.
- **Lighting & Camera:** `ClockTime = 19.5` inside school (`Brightness = 1.0`, cool fluorescent `#D6EAF8`) vs. warm amber fire light (`#E67E22`) in lab; rapid split-screen cut between Locker #01 slot and Locker #02 ceiling.
- **VFX/SFX Cues:** Cyan/Orange swirl `ParticleEmitter` at locker vents; *CLANK!* on padlock, *WHOOSH-PLINK!* on pin drop, *CRACK-PSHHHHH!* on sprinkler foam burst.

---

### Story 030: The Save-Point Watch
- **Story ID & Title:** `030 — The Save-Point Watch`
- **Format:** Standalone 50–56s, 47 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** You can't break out of a loop by fighting the clock—you have to change the choice that triggers it.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, everyone gets one ten-second save point a week—until someone else's save file overwrote mine and trapped us both!"
   - **Frame 1 Visual:** Narrator (Cole) frozen mid-step in the town crosswalk as a glowing gold `[SAVE LOADED: 04:12:00]` ring snaps backward around his wrist watch and a yellow school bus screeches toward the same red light for the fifth time.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A baker drops a wedding cake on the sidewalk, hits his gold watch button—*REWIND!*—and catches it before it falls, while three pedestrians walk backward like tape on fast-reverse.
   - **Town Adaptation:** People tape plastic `[DO NOT PRESS]` caps over their watches during exams so nobody rewinds the whole classroom by accident.
   - **3 Named Planted Ammo Clues:**
     1. **Cole's Gold Save-Watch** (stuck flashing `[OVERWRITTEN BY: PLAYER_2]`).
     2. **Crosswalk Puddle & Dropped Red Umbrella** (lying 4 studs from the curb).
     3. **Girl in Yellow Raincoat (Mia)** staring at her own cracked watch across the street.
3. **13.5–21s Personal Trap & Crisis:**
   - Every `10 seconds`, Mia's panicked watch auto-triggers because she keeps slipping into the path of a skidding delivery van—rewinding both Cole and Mia back to `04:12:00` forever, draining their watches' final `3` charges before time locks permanently.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Cole mashes **His Own Gold Save-Watch** to jump back earlier—*BUZZ!* `[ERROR: EXTERNAL SAVE ACTIVE]` flashes red, wasting Charge `1`.
   - **Clue 2 Fail:** Cole sprints across the street to tackle Mia out of the crosswalk—*SCREECH!* He trips on the **Crosswalk Puddle**, and the van still forces Mia's watch to rewind (`2` charges left).
   - **Clue 3 Fail:** Cole yells *"Don't step off the curb!"*—*HONK!* The thunder drowns him out, Mia steps forward anyway, and Charge `1` ticks down.
5. **39–51s Genius Rule-Hack Climax:**
   - Cole realizes Mia's watch triggers *only* when she slips on the curb—so he doesn't need to reach Mia, he needs to reach the *puddle*! At `04:12:02`, Cole grabs the **Dropped Red Umbrella** right beside his feet, flicks it open, and slides it like a curling stone across the wet asphalt—*SWOOSH!* It wedges flat over the **Crosswalk Puddle** just as Mia steps down. Her sneaker hits dry nylon instead of slick oil, she stays upright, the van swerves clear, and both watches chime `[LOOP CLEARED — 04:12:11]`.
6. **51–56s Action Echo Punchline:**
   - Mia looks down at the red umbrella under her boots, lets out a shaky laugh, and snaps her plastic `[DO NOT PRESS]` watch cap firmly shut as Cole gives her a two-finger salute.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Cole (Narrator / Protagonist):** Skin `#F5CD30`, R6; Shirt: Dark Blue Windbreaker (`#21618C`), Pants: Black Joggers (`#1C2833`), Hair: Short Brown (`#4E342E`); Face swaps: `shocked` -> `determined` -> `scared` -> `grin` -> `proud`.
- **Mia (Loop Partner):** Skin `#F1C27D`, R6; Shirt: Bright Yellow Raincoat (`#F4D03F`), Pants: Navy Leggings (`#1B2631`), Hair: Bob Cut (`#2C3E50`); Face swaps: `scared` -> `shocked` -> `grin`.

#### Props & Sockets (Sound-Off Visible)
- **Gold Save-Watch:** `0.5 x 0.3 x 0.5 studs`, `Neon` + `Metal`, Gold/Red (`#F1C40F`), Socket: `RightHand` (wrist).
- **Dropped Red Umbrella:** `2.4 x 0.4 x 2.4 studs` (open), `Fabric` + `Metal`, Crimson (`#C0392B`), Socket: `Workspace` -> `RightHand`.
- **Crosswalk Oil Puddle:** `3.0 x 0.05 x 2.5 studs`, `Glass` (reflective), Dark Rainbow (`#2C3E50`), Socket: `Workspace`.
- **Delivery Van:** `14.0 x 7.0 x 6.0 studs`, `Metal`, White (`#ECF0F1`), Socket: `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Rainy Town Crosswalk — `Concrete` sidewalk, `Asphalt` wet street with white stripes, glowing traffic signal, corner bakery awning.
- **Lighting & Camera:** `ClockTime = 17.8` storm dusk (`Brightness = 0.9`, `FogEnd = 95`, cool indigo `Ambient = #34495E`); whip-pan snap cuts on every `10s` rewind with a VHS scanline flash.
- **VFX/SFX Cues:** Gold circular `ParticleEmitter` rewind ring; *BUZZ!* on error, *SCREECH!* on van brakes, *SWOOSH!* on sliding umbrella, *DING!* on `04:12:11`.

---

### Story 031: The Hunger-Bar Lunch
- **Story ID & Title:** `031 — The Hunger-Bar Lunch`
- **Format:** Standalone 50–56s, 44 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Hoarding everything for yourself is the fastest way to starve in a system built on sharing.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every bite you share refills your hunger bar double—and the richest kid in school is starving surrounded by fifty pizzas!"
   - **Frame 1 Visual:** Greedy classmate Julian slumped in a velvet booth surrounded by `50` steaming pepperoni pizza boxes, his floating `[HUNGER: 05%]` bar flashing red while Narrator (Noah) watches from the next table.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid eats an entire double cheeseburger alone and his hunger bar barely ticks up `+2%`—while his friend splits a single pretzel in half and both their bars shoot straight to `[100% FULL]`.
   - **Town Adaptation:** The school cafeteria bans solo lunch trays and sets up `[SHARE-TABLES]` where kids swap half-sandwiches like trading cards.
   - **3 Named Planted Ammo Clues:**
     1. **Julian's 50 Locked Pizza Boxes** (guarded by his bodyguard-style backpack wall).
     2. **Noah's Half-Eaten Granola Bar** (`1` bite left).
     3. **Stray Cafeteria Puppy** sitting outside the glass patio door looking hungry.
3. **13.5–21s Personal Trap & Crisis:**
   - A snowstorm traps the whole lunchroom indoors for `4 hours`; Julian refuses to share a single crust, devours `12` slices himself (`+0%` gain), and collapses at `[HUNGER: 01% — FAINTING]` while nobody else has food left to give him.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Noah tells Julian to eat another slice from **His 50 Pizza Boxes**—*GULP!* Nothing happens; `[01%]` blinks faster because solo eating doesn't register.
   - **Clue 2 Fail:** Noah tosses his **Half-Eaten Granola Bar** onto Julian's plate—*DING!* Julian eats it, ticks up to `[04%]`, then immediately drops back to `[02%]` because he didn't *give* it.
   - **Clue 3 Fail:** Noah tries to pull a pizza box out of Julian's stack to hand it to someone else—*SLAP!* Julian's reflex swats it away because his pride won't let anyone touch his stash.
5. **39–51s Genius Rule-Hack Climax:**
   - Noah realizes Julian won't share with a *kid* he thinks is beneath him—so Noah slides open the glass patio door just enough for the **Stray Cafeteria Puppy** to poke its nose inside. Noah whispers, *"He doesn't count as charity—he's just a dog."* Julian stares at his `[01%]` red bar, sighs, tears off one warm pepperoni slice, and drops it in front of the puppy's paws—*CHOMP! DING-DING-DING!* A massive golden `[SHARED x2!]` beam erupts, shooting Julian's hunger bar straight from `01%` to `[100% FULL]`!
6. **51–56s Action Echo Punchline:**
   - Blinking in disbelief, Julian pushes all `49` remaining pizza boxes across the table toward the whole lunchroom—and keeps one final crust to split with the puppy at his feet.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Noah (Narrator / Protagonist):** Skin `#C68642`, R6; Shirt: Mustard Crewneck (`#D4AC0D`), Pants: Dark Denim (`#2C3E50`), Hair: Short Fade (`#1C1C1C`); Face swaps: `neutral` -> `scared` -> `determined` -> `grin` -> `proud`.
- **Julian (Greedy Rich Kid):** Skin `#F5D0A9`, R6; Shirt: Purple Sweater Vest (`#6C3483`), Pants: Cream Slacks (`#F5EEF8`), Hair: Gel-Slicked Blonde (`#F7DC6F`); Face swaps: `grin` -> `scared` -> `shocked` -> `proud`.
- **Stray Puppy (Prop/NPC):** `2.0 x 1.2 x 1.0 studs`, `SmoothPlastic`, Golden Tan (`#D5B895`), floppy ears.

#### Props & Sockets (Sound-Off Visible)
- **Hunger Bar Billboard:** `BillboardGui` (`3.8 x 0.8 studs`), `Head` socket (`[HUNGER: 01%]` red -> `[100%]` green).
- **50 Pizza Boxes Stack:** `2.4 x 0.3 x 2.4 studs` each, `SmoothPlastic`, Cardboard/Red (`#F5CBA7` / `#C0392B`), Socket: `Workspace`.
- **Half-Eaten Granola Bar:** `0.6 x 0.2 x 0.3 studs`, `Granite`, Oat Brown (`#A04000`), Socket: `RightHand`.
- **Pepperoni Pizza Slice:** `0.8 x 0.15 x 0.9 studs`, `SmoothPlastic`, Gold/Red (`#F39C12` / `#C0392B`), Socket: `RightHand`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Cafeteria — `Marble` floor, `WoodPlanks` booth tables, floor-to-ceiling `Glass` patio doors showing swirling snow outside.
- **Lighting & Camera:** `ClockTime = 13.5` overcast winter light (`Brightness = 1.2`, cool cyan snow bounce `#D6EAF8`); tight close-up on `[01%]` red bar pulsing, then wide shot as golden `100%` burst lights the booth.
- **VFX/SFX Cues:** Snow `ParticleEmitter` outside glass; *GULP!* on dry swallow, *DING-DING-DING!* on `x2` refill, happy *WOOF!* from puppy.

---

### Story 032: The Storm-Circle School
- **Story ID & Title:** `032 — The Storm-Circle School`
- **Format:** 2-Part (Part 1: 0–28s Mystery / Part 2: 28–56s Twist), 48 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** When everyone is told to fear the boundary line, somebody is hiding what's sitting just outside it.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, a glowing purple storm shrinks around our school every afternoon—and touching it turns your clothes gray!"
   - **Frame 1 Visual:** Towering translucent purple `[STORM WALL]` closing in across the soccer field as Narrator (Zane) and twenty kids sprint toward the shrinking `[SAFE ZONE]` chalk circle around the flagpole.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid steps one sneaker outside the purple wall to grab a dodgeball—*ZAP!* His bright red hoodie instantly drains to dull concrete gray, and he freezes shivering until recess ends.
   - **Town Adaptation:** The Mayor sets up `[STORM SHELTER]` bleachers in the center of the yard and hands out `[STAY INSIDE]` whistles to hall monitors.
   - **3 Named Planted Ammo Clues:**
     1. **Copper-Wire Science Glasses** (worn by Zane, built for magnetism class).
     2. **Mayor's Black Tripod Projector Box** hidden behind the bleachers.
     3. **Silver Metallic Buzzing Hum** coming from the woods *outside* the storm wall.
3. **13.5–21s Personal Trap & Crisis:**
   - Zane's little sister's teddy bear gets left outside the shrinking purple circle; the storm closes to `10 studs` wide, locking everyone inside the bleachers while Zane sees bright green welding sparks flashing behind the purple mist in the woods.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Zane tosses a metal ruler through the purple wall to test if it's real lightning—*CLATTER!* It hits dirt without melting, proving there's no heat.
   - **Clue 2 Fail:** Zane puts on his **Copper-Wire Science Glasses** and stares at the storm—*FLICKER!* Through the polarized lenses, the "storm" breaks into repeating square grid pixels!
   - **Clue 3 Fail:** Zane tries to run straight toward the **Silver Metallic Buzzing Hum** in the woods—*WHOOSH!* A hall monitor grabs his collar, pointing at the gray-clothes rule.
5. **39–51s Genius Rule-Hack Climax:**
   - It's not a storm—it's a giant hologram! Zane spots the **Mayor's Black Tripod Projector Box** humming behind the bleachers, notices a thick orange extension cord running into it, and yanks the plug with both hands—*BZZZZT-POP!* The entire purple storm wall vanishes in a single frame! Revealed in the clearing outside stands a crashed silver UFO saucer surrounded by Mayor Vance's crane crew secretly loading glowing green fuel cells into city trucks!
6. **51–56s Action Echo Punchline:**
   - Every kid on the bleachers whips out their phone cameras at once; Zane walks straight into the clearing, picks up his sister's teddy bear, and waves at the Mayor's frozen crane operator.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Zane (Narrator / Protagonist):** Skin `#F1C27D`, R6; Shirt: Teal Science Hoodie (`#16A085`), Pants: Dark Gray Cargo (`#34495E`), Hair: Messy Black (`#1C1C1C`); Face swaps: `scared` -> `determined` -> `shocked` -> `grin` -> `proud`.
- **Mayor Vance (Antagonist):** Skin `#F5D0A9`, R6; Shirt: Navy Suit (`#1B2631`), Pants: Navy Slacks (`#1B2631`), Hair: Silver Part (`#BDC3C7`); Face swaps: `neutral` -> `shocked`.
- **Hall Monitor Pete (Support):** Skin `#8D5524`, R6; Shirt: Neon Yellow Vest (`#F1C40F`), Pants: Blue Jeans (`#2874A6`), Hat: Whistle Lanyard; Face swaps: `neutral` -> `shocked`.

#### Props & Sockets (Sound-Off Visible)
- **Purple Storm Wall:** `100 x 40 x 0.5 studs` curved cylinder, `ForceField` / `Neon`, Purple (`#8E44AD`), Socket: `Workspace`.
- **Copper-Wire Science Glasses:** `1.2 x 0.4 x 0.5 studs`, `Metal` + `Glass`, Copper/Cyan (`#D35400`), Socket: `Head`.
- **Tripod Projector Box:** `2.0 x 2.5 x 2.0 studs`, `Metal`, Matte Black (`#17202A`) with orange cord, Socket: `Workspace`.
- **Crashed Silver UFO Saucer:** `18.0 x 5.0 x 18.0 studs`, `Metal` + `Neon` green core (`#2ECC71`), Socket: `Workspace` (woods).
- **Brown Teddy Bear:** `1.0 x 1.2 x 0.8 studs`, `Fabric`, Brown (`#8D6E63`), Socket: `RightHand`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Soccer Field & Woods Edge — `Grass` turf, white chalk circle, `Metal` bleachers, dense `Wood` pine trees beyond fence.
- **Lighting & Camera:** `ClockTime = 17.0` purple-tinted dusk (`Ambient = #5B2C6F`) before plug pull, snapping instantly to crisp golden sunlight (`ClockTime = 16.5`, `Ambient = #85929E`) the moment the hologram shuts off.
- **VFX/SFX Cues:** Translucent purple grid shader; *ZAP!* on gray drain, *BZZZZT-POP!* on power cut, collective gasp + camera shutter clicks.

---

### Story 033: The Friendly-Fire Toggle
- **Story ID & Title:** `033 — The Friendly-Fire Toggle`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** The only person who wants to turn off the safety rules is the one who never expects them to apply back to himself.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, nobody can hurt anyone else—until the school bully found the hidden PvP switch in the basement!"
   - **Frame 1 Visual:** Bully Tank smashing a foam dodgeball straight into Narrator (Ben)'s face—only for it to bounce off a glowing blue `[SAFE MODE: ON]` forcefield with zero impact while Tank grins holding a rusty lever key.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Two kids collide full-speed on bikes at an intersection and bounce apart like rubber beach balls with cheerful *BOING!* sounds and zero scratches.
   - **Town Adaptation:** The school gym doesn't even have dodgeball rules—kids play with bowling balls and laugh when they bounce harmlessly off each other's shins.
   - **3 Named Planted Ammo Clues:**
     1. **Basement Fusebox (`[PvP: OFF / ON]` Toggle)** behind the boiler room grate.
     2. **Gym's Bucket of 20 Hard Rubber Dodgeballs** sitting beside the bleachers.
     3. **Green `[PvP ENABLED]` Overhead Tag** that only appears above players toggled into PvP.
3. **13.5–21s Personal Trap & Crisis:**
   - Tank sneaks into the boiler room during fifth-period dodgeball, flips the **Basement Fusebox** switch—*CLUNK!*—and marches back into the gym cracking his knuckles, planning to pelting the whole fifth-grade class with heavy medicine balls.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Ben runs to the **Basement Fusebox** to flip it back—*LOCKED!* Tank snapped the padlock shut from the outside.
   - **Clue 2 Fail:** Ben yells *"Everyone run!"* as Tank hurls a medicine ball—*THOOM!* Wait... the ball bounces harmlessly off Ben's chest with a blue `[SAFE MODE]` ripple!
   - **Clue 3 Fail:** Tank looks confused, grabs a second ball, and throws it at the bleachers—*BOING!* Nothing hurts anyone else, and a glowing red `[PvP: SOLO ONLY]` tag pops up above Tank's own head!
5. **39–51s Genius Rule-Hack Climax:**
   - Ben spots the fine print on the gym's scoreboard: Tank only flipped **Circuit #1 (Self-Register)**—so Tank turned `[PvP ON]` *only for himself* while the rest of the school is still in `[SAFE MODE]`! Ben points at the **Bucket of 20 Hard Rubber Dodgeballs** and shouts, *"Hey class—he's the only one with Friendly Fire ON!"* Twenty kids grab a ball at once; Tank's grin vanishes as twenty red dodgeballs launch in slow-motion—*BONK-BONK-BONK!*—knocking Tank straight backward into the gym mat pile!
6. **51–56s Action Echo Punchline:**
   - Tank pops his head out of the foam mats with a tiny `[PvP: OFF]` bruise on his forehead while Ben calmly tosses him an ice pack that bounces off his nose with a polite *boing*.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Ben (Narrator / Protagonist):** Skin `#F1C27D`, R6; Shirt: Red Gym Jersey (`#C0392B`), Pants: Black Gym Shorts (`#1C2833`), Hair: Short Sandy Blonde (`#D4AC0D`); Face swaps: `neutral` -> `scared` -> `shocked` -> `grin` -> `proud`.
- **Tank (Bully):** Skin `#E0B490`, R6; Shirt: Sleeveless Gray Hoodie (`#566573`), Pants: Black Track Pants (`#17202A`), Hair: Spiky Mohawk (`#2C3E50`); Face swaps: `grin` -> `shocked` -> `scared`.

#### Props & Sockets (Sound-Off Visible)
- **Basement PvP Fusebox:** `1.8 x 2.4 x 0.6 studs`, `Metal` + `Neon` switch, Industrial Gray/Red (`#5D6D7E` / `#E74C3C`), Socket: `Workspace`.
- **Hard Rubber Dodgeballs (x20):** `1.2 x 1.2 x 1.2 studs` sphere, `SmoothPlastic`, Crimson (`#E74C3C`), Socket: `RightHand` / `Workspace`.
- **PvP Status Billboard:** `BillboardGui` (`3.6 x 0.9 studs`), `Head` socket (`[SAFE MODE]` blue vs `[PvP: SOLO]` red).

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Gymnasium — `WoodPlanks` polished court floor, `Brick` walls, wall-mounted padded mats, basketball hoops.
- **Secondary Set:** Boiler Room Basement — `Concrete` floor, `Metal` pipes, rusted fusebox.
- **Lighting & Camera:** `ClockTime = 16.8` bright gym skylights (`Brightness = 1.7`); wide-angle court shot as 20 dodgeballs arc in unison toward Tank.
- **VFX/SFX Cues:** Blue hex `ForceField` ripple on safe hits; *BOING!* on safe bounces, *CLUNK!* on fusebox, rapid-fire *BONK-BONK-BONK!* barrage.

---

### Story 034: The Craft-Bench Shed
- **Story ID & Title:** `034 — The Craft-Bench Shed`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Broken things aren't useless—they're just waiting for the right second half.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, put any two broken things on Grandpa's shed bench and they fuse into one working tool—and the town's power just went out!"
   - **Frame 1 Visual:** Narrator (Kip) slapping a cracked magnifying glass and a dead flashlight onto a glowing `[CRAFT BENCH]` oak table—*FLASH!*—producing a blinding spotlight lantern in his hands.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid drops his snapped skateboard and an old vacuum motor onto the bench as a joke—*POOF!* It fuses into a hover-board that launches him straight into the neighbor's hedge.
   - **Town Adaptation:** Nobody throws away broken junk anymore; every garage has a `[2-SLOT FUSE]` bin labeled by material type.
   - **3 Named Planted Ammo Clues:**
     1. **Broken Wire-Frame Umbrella** (snapped ribs, waterproof nylon intact).
     2. **Dying Hand-Crank Flashlight** (dim amber bulb, working dynamo).
     3. **Grandpa's Copper Lightning Rod** bolted to the shed's roof eave.
3. **13.5–21s Personal Trap & Crisis:**
   - A massive coastal squall knocks out the town lighthouse during the evening ferry crossing; the fog is `90%` opaque, and the ferry's captain is steering straight toward the jagged breakwater rocks with `30 seconds` left.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Kip waves the **Dying Hand-Crank Flashlight** from the cliff edge—*FLICKER!* The tiny beam dies 10 studs out in the thick rain.
   - **Clue 2 Fail:** Kip opens the **Broken Wire-Frame Umbrella** to shield a signal flare—*SNAP!* The wind folds it inside out like a tulip.
   - **Clue 3 Fail:** Kip fuses a kitchen mirror + the broken umbrella on the **Craft-Bench Shed**—*CLANG!* It makes a shiny silver shield, useless in pitch-black fog.
5. **39–51s Genius Rule-Hack Climax:**
   - Kip checks the craft rule: *any two broken items fuse into a working tool!* He sprints into the shed, slams the **Broken Wire-Frame Umbrella** (reflective dish!) + the **Dying Hand-Crank Flashlight** (light source!) onto the oak `[CRAFT BENCH]`—*ZAP-FUSE!* Out pops a **Giant Parabolic Storm Beacon**! Kip rushes to the cliff rail, cranks the handle three times, and blasts a 200-stud focused lighthouse beam straight through the fog—illuminating the breakwater rocks just in time for the ferry to hard-port clear!
6. **51–56s Action Echo Punchline:**
   - The ferry blasts two grateful horn honks across the bay; Kip rests the glowing umbrella-beacon on his shoulder and flips his `[OPEN FOR REPAIRS]` shed sign back on.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Kip (Narrator / Protagonist):** Skin `#F1C27D`, R6; Shirt: Denim Overalls over Plaid (`#2E86C1`), Pants: Denim (`#2E86C1`), Hair: Tousled Auburn (`#A04000`); Face swaps: `grin` -> `scared` -> `determined` -> `shocked` -> `proud`.
- **Ferry Captain (Support):** Skin `#E0B490`, R6; Shirt: Yellow Slicker (`#F1C40F`), Pants: Black Boots/Pants (`#1C2833`), Hat: Captain Cap (`#FFFFFF`); Face swaps: `scared` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Oak Craft Bench:** `6.0 x 3.0 x 3.0 studs`, `WoodPlanks` + `Neon` 2-slot grid, Warm Oak/Cyan (`#8D6E63` / `#00E5FF`), Socket: `Workspace`.
- **Broken Wire-Frame Umbrella:** `2.0 x 0.4 x 2.0 studs`, `Fabric` + `Metal`, Yellow/Steel (`#F4D03F`), Socket: `RightHand`.
- **Hand-Crank Flashlight:** `0.8 x 0.4 x 0.4 studs`, `Plastic`, Red (`#C0392B`), Socket: `RightHand`.
- **Storm Beacon (Fused):** `2.8 x 2.8 x 1.6 studs`, `Neon` + `Metal`, Gold/White (`#FFF9C4`), Socket: `RightHand`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Cliffside Craft Shed — `WoodPlanks` walls, open double doors facing rocky cliff and churning ocean bay, lighthouse tower dark in background.
- **Lighting & Camera:** `ClockTime = 20.5` storm night (`Brightness = 0.6`, `FogEnd = 60`, dark navy `Ambient = #1B2631`); dramatic beam-cone shot slicing across the fog toward the ferry silhouette.
- **VFX/SFX Cues:** Cyan `ParticleEmitter` fusion sparks on bench; *SNAP!* on umbrella, *ZAP-FUSE!* on craft merge, deep ferry *HOOONK-HOOONK!*

---

### Story 035: The Fog-Distance Limit
- **Story ID & Title:** `035 — The Fog-Distance Limit`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** When the world cuts your sight down to fifteen steps, you build a tether that doesn't rely on eyes.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, nobody can see farther than fifteen studs in the morning fog—and my little brother just walked into the white void!"
   - **Frame 1 Visual:** Narrator (Milo) standing at the porch steps as everything beyond a crisp `15-stud` radius dissolves into solid milk-white fog, a `[RENDER DISTANCE: 15 STUDS]` warning blinking on his screen.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** The mailman tosses a package toward a porch `16 studs` away—it vanishes mid-air into the white wall, and two seconds later a neighbor yells *"Ow!"* from somewhere invisible across the street.
   - **Town Adaptation:** Everyone paints neon yellow `[15-STUD]` circles around their driveways and ties cowbells to their bikes so nobody rides off the edge of the visible block.
   - **3 Named Planted Ammo Clues:**
     1. **Neon Green Box Kite** (resting by the garage door with a `30-stud` string spool).
     2. **Glowstick Wristbands (x4)** clipped to Milo's backpack.
     3. **Old Brass Cowbell** hanging by the front porch.
3. **13.5–21s Personal Trap & Crisis:**
   - Five-year-old Pip chases his rolling soccer ball straight past the `15-stud` curb line; the fog swallows him in two steps, and the morning garbage truck is rumbling down the invisible street `20 seconds` away.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Milo sprints forward shouting Pip's name—*ECHO!* The white fog muffles voices past `15 studs`, and Milo loses track of which direction his own house is.
   - **Clue 2 Fail:** Milo rings the **Old Brass Cowbell** to guide Pip back—*CLANG!* Pip rings his bike bell back, but the fog bounces the sound off every fence.
   - **Clue 3 Fail:** Milo throws a **Glowstick Wristband** ahead of him onto the grass—*THUD!* Once it lands at `16 studs`, the render limit turns it completely invisible!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—objects vanish past `15 studs` horizontally, *not* if they're physically connected to your hand inside the `15-stud` circle! Milo runs back to the porch, grabs the **Neon Green Box Kite** and snaps all `4` **Glowstick Wristbands** onto its tail, ties the `30-stud` string to his own belt, and launches it upward just inside his `15-stud` bubble—the glowing tail hovers like a lighthouse *inside* his render zone! Keeping one hand on his porch railing, Milo walks the perimeter arcing the kite string like a compass until it snags Pip's backpack—*TUG!* He reels Pip straight back out of the white void seconds before the garbage truck's headlights pass!
6. **51–56s Action Echo Punchline:**
   - Milo clips the glowing kite string straight onto Pip's hoodie loop so it floats `10 studs` above him like a personal buoy, and Pip grins holding his rescued soccer ball.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Milo (Narrator / Protagonist):** Skin `#E0B490`, R6; Shirt: Navy Hooded Sweatshirt (`#2471A3`), Pants: Tan Chinos (`#D2B48C`), Hair: Fluffy Black (`#1C1C1C`); Face swaps: `scared` -> `determined` -> `shocked` -> `grin` -> `proud`.
- **Pip (Little Brother, 0.75x scale):** Skin `#E0B490`, R6; Shirt: Red Striped Tee (`#E74C3C`), Pants: Blue Overalls (`#2E86C1`), Hair: Messy Black (`#1C1C1C`); Face swaps: `scared` -> `grin`.

#### Props & Sockets (Sound-Off Visible)
- **Neon Green Box Kite:** `2.0 x 2.0 x 1.2 studs`, `Fabric` + `Neon` glowsticks, Lime (`#2ECC71`), Socket: `RightHand` / `Workspace` (tethered).
- **Brass Cowbell:** `0.6 x 0.7 x 0.5 studs`, `Metal`, Brass (`#D4AC0D`), Socket: `RightHand`.
- **Soccer Ball:** `1.1 x 1.1 x 1.1 studs`, `SmoothPlastic`, White/Black (`#FFFFFF`), Socket: `Workspace` -> `RightHand`.
- **Render Distance Ring:** `30 x 0.1 x 30 studs` chalk/fog ring, `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Suburban Porch & Cul-de-Sac — `WoodPlanks` porch, `Concrete` sidewalk, `Grass` lawn, solid white `FogEnd = 15` wall.
- **Lighting & Camera:** `ClockTime = 08.0` heavy white fog (`FogColor = #FFFFFF`, `FogStart = 10`, `FogEnd = 16`, `Brightness = 1.4`); tight over-the-shoulder tracking shot as the white wall swallows everything beyond 15 studs.
- **VFX/SFX Cues:** White mist `ParticleEmitter`; *CLANG!* on cowbell, *TUG!* on kite string snag, *RUMBLE!* of passing truck.

---

### Story 036: The Fall-Damage Shoes
- **Story ID & Title:** `036 — The Fall-Damage Shoes`
- **Format:** Standalone 50–56s, 44 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** The trait everyone mocks as awkward is the exact thing built to catch someone else's fall.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, wearing the yellow boots cancels all fall damage—but once you lace them up, you can never take them off!"
   - **Frame 1 Visual:** Narrator (Tessa) clomping loudly down the school stairs in giant squeaky `[NO-FALL BOOTS]` while kids point and laugh at her clunky bright yellow soles.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid wearing normal sneakers hops off a `4-stud` picnic bench and instantly gets a `[SPRAINED ANKLE: -15 HP]` cast, while Tessa leaps off the gym roof and lands with a painless *SQUEAK!*
   - **Town Adaptation:** Nobody wears the yellow boots because they squeak with every step and can't fit into roller skates or soccer cleats.
   - **3 Named Planted Ammo Clues:**
     1. **Giant Yellow Fall-Damage Boots** (glued permanently to Tessa's feet).
     2. **40-Stud Town Water Tower** overlooking the steep hill park.
     3. **Out-of-Control Baby Stroller** parked without its wheel brake at the top of the tower ramp.
3. **13.5–21s Personal Trap & Crisis:**
   - A gust of wind shoves the **Baby Stroller** off the water tower's upper maintenance catwalk `40 studs` up—the mom screams from the bottom of the ladder, and nobody in normal sneakers can survive a 40-stud drop to reach the lower awning in time.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Tessa tries to sprint up the **Water Tower Spiral Stairs**—*SQUEAK-TRIP!* The clunky boots take 20 seconds just to climb one flight, and the stroller tips over the rail!
   - **Clue 2 Fail:** Two teens below stretch out a **Picnic Blanket** to catch the stroller—*RIP!* The wind tears it right out of their hands.
   - **Clue 3 Fail:** Tessa grabs a **Maintenance Rope** on the upper catwalk to swing down—*SNAP!* The frayed rope breaks halfway, leaving her dangling `25 studs` above the concrete.
5. **39–51s Genius Rule-Hack Climax:**
   - Tessa looks down at the falling stroller—and remembers her boots cancel *all* fall damage! She lets go of the rope, tucks into a cannonball dive straight down alongside the falling stroller, wraps both arms around the stroller's metal frame mid-air, and flips so her **Giant Yellow Boots** point straight at the concrete—*KABOOM-SQUEAK!* The shockwave cracks a 4-stud crater in the sidewalk, `[FALL DAMAGE: 0 HP]` flashes gold above Tessa's head, and the baby inside the stroller giggles without a single bump!
6. **51–56s Action Echo Punchline:**
   - The whole park erupts in cheers; Tessa sets the stroller gently on the grass, clicks her giant yellow heels together with a proud *SQUEAK-SQUEAK!*, and walks home like she's wearing designer sneakers.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Tessa (Narrator / Protagonist):** Skin `#8D5524`, R6; Shirt: White Hoodie (`#ECF0F1`), Pants: Blue Jeans (`#2E86C1`), Shoes: Giant Yellow Boots (`#F1C40F`), Hair: Curly Afro Puffs (`#1C1C1C`); Face swaps: `neutral` -> `scared` -> `determined` -> `shocked` -> `proud`.
- **Stroller Mom (Support):** Skin `#F5D0A9`, R6; Shirt: Mint Cardigan (`#76D7C4`), Pants: Cream Pants (`#FEF9E7`), Hair: Blonde Bun (`#F4D03F`); Face swaps: `scared` -> `shocked` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Giant Yellow Fall-Damage Boots:** `1.3 x 1.0 x 1.6 studs` each, `SmoothPlastic`, Bright Yellow (`#F1C40F`), Socket: `LeftFoot` / `RightFoot` (R6 legs).
- **Baby Stroller:** `2.4 x 2.6 x 3.2 studs`, `Metal` + `Fabric`, Navy/Silver (`#21618C` / `#BDC3C7`), Socket: `Workspace` -> `RightHand`/`LeftHand` catch.
- **40-Stud Water Tower:** `12 x 42 x 12 studs`, `Metal`, Light Blue (`#85C1E9`), Socket: `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Hilltop Park & Water Tower — `Grass` lawn, `Concrete` plaza, 40-stud `Metal` water tower with spiral catwalk, park benches.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 1.6`, golden afternoon sunlight); dramatic vertical drop-cam tracking Tessa and the stroller falling side by side.
- **VFX/SFX Cues:** Dust-ring `ParticleEmitter` on crater impact; *SQUEAK!* on every step, *SNAP!* on rope, *KABOOM-SQUEAK!* on landing.

---

### Story 037: The NPC Dialogue Loop
- **Story ID & Title:** `037 — The NPC Dialogue Loop`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Sometimes people aren't ignoring you—they're trapped repeating a script until someone speaks outside the pattern.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every adult only repeats three programmed sentences—and my mom just got stuck in the loop!"
   - **Frame 1 Visual:** Narrator (Jude)'s mom standing frozen at the kitchen sink with a glowing green `[NPC DIALOGUE: 1/3]` bubble above her head, repeating *"Nice weather today!"* while pouring coffee onto an already overflowing mug.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** The mailman stands at the curb for three hours saying *"Sign here! Sign here! Have a great day!"* on loop while twenty dogs bark at his ankles.
   - **Town Adaptation:** Kids leave sticky-note `[SCRIPT OPTIONS]` on the fridge (`[A: HUNGRY] [B: SCHOOL] [C: GOODBYE]`) because asking anything else makes adults stare blankly.
   - **3 Named Planted Ammo Clues:**
     1. **Mom's `[NPC DIALOGUE]` 3-Line Menu** (`"Nice weather!"` / `"Eat your toast!"` / `"Don't be late!"`).
     2. **Burnt Toast Popping Out of the Toaster** (smoke alarm starting to chirp).
     3. **Old Family Photo Magnet** on the fridge from Jude's 6th birthday (`"Remember the treehouse?"`).
3. **13.5–21s Personal Trap & Crisis:**
   - The toaster catches fire on the counter, thick black smoke fills the kitchen, and Mom keeps smiling and repeating *"Eat your toast! Nice weather today!"*—her `[NPC LOCK]` won't let her step away from the stove!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Jude taps `[B: SCHOOL]` and yells *"Mom, fire!"*—*BEEP!* Her dialogue box snaps straight to *"Don't be late!"* without blinking.
   - **Clue 2 Fail:** Jude grabs her sleeve to pull her toward the door—*CLANG!* An invisible `[NPC ANCHOR]` locks her boots to the tile floor.
   - **Clue 3 Fail:** Jude unplugs the **Toaster** and fans the smoke alarm—*CHIRP!* The heat sensor trips the front deadbolt into emergency lockdown until an adult overrides the keypad!
5. **39–51s Genius Rule-Hack Climax:**
   - Jude realizes normal words trigger her programmed responses—he needs a word that doesn't exist in any town script! He rips the **Old Family Photo Magnet** off the fridge, holds it right in front of Mom's eyes, and whispers the private childhood nickname only she ever called him: *"Captain Pickles."* Mom's `[NPC DIALOGUE]` bubble glitches—*ZAP-CRACK!*—shatters into golden pixels, her eyes widen, she gasps *"Jude?!"*, grabs the kitchen towel, smothers the toaster, and punches the deadbolt override just in time!
6. **51–56s Action Echo Punchline:**
   - Sitting together on the front porch steps in fresh air, Mom hands Jude a slightly charred piece of toast and whispers, *"Don't tell anyone about Captain Pickles,"* with a real, unscripted wink.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Jude (Narrator / Protagonist):** Skin `#F1C27D`, R6; Shirt: Green Plaid Flannel (`#27AE60`), Pants: Dark Jeans (`#2C3E50`), Hair: Messy Chestnut (`#5D4037`); Face swaps: `scared` -> `determined` -> `shocked` -> `proud`.
- **Mom (NPC -> Awakened):** Skin `#F1C27D`, R6; Shirt: Lavender Apron over White Tee (`#AF7AC5`), Pants: Blue Jeans (`#2874A6`), Hair: Shoulder-Length Brown (`#5D4037`); Face swaps: `neutral` (blank) -> `shocked` -> `grin`.

#### Props & Sockets (Sound-Off Visible)
- **NPC Dialogue Billboard:** `BillboardGui` (`4.5 x 1.2 studs`), `Head` socket (`[1/3]`, `[2/3]`, `[3/3]` -> shattered pixels).
- **Smoking Toaster:** `1.2 x 0.9 x 0.8 studs`, `Metal`, Chrome (`#BDC3C7`), Socket: `Workspace` (counter).
- **Family Photo Magnet:** `0.8 x 0.8 x 0.1 studs`, `SmoothPlastic`, Warm Frame (`#F4D03F`), Socket: `RightHand`.
- **Emergency Deadbolt Keypad:** `0.7 x 1.0 x 0.2 studs`, `Neon` red/green, Socket: `Workspace` (front door).

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Suburban Kitchen — `Marble` tile floor, `WoodPlanks` cabinets, glowing toaster smoke, front door with keypad.
- **Lighting & Camera:** `ClockTime = 08.5` morning sun (`Brightness = 1.3`, smoky gray haze `FogEnd = 45` inside kitchen); tight close-up on Mom's blank `neutral` face glitching into `shocked` when the dialogue box shatters.
- **VFX/SFX Cues:** Green pixel shatter `ParticleEmitter` on script break; *BEEP!* on script snap, *CHIRP!* on smoke alarm, *ZAP-CRACK!* on glitch.

---

### Story 038: The AFK Freeze
- **Story ID & Title:** `038 — The AFK Freeze`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** When everyone else panics and runs, the hardest skill in the room is staying completely still.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, if you stand completely still for ten seconds you turn invisible—and two armed robbers just kicked open the corner store door!"
   - **Frame 1 Visual:** Narrator (Devon) frozen mid-reach by the cereal aisle as a `[IDLE: 03s... 02s...]` translucent fade starts creeping up his sneakers while two masked robbers smash the front glass.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid zones out waiting in line at the ice cream truck; after `10 seconds` he vanishes completely, and the clerk hands a cone to empty air until he sneezes and pops back visible.
   - **Town Adaptation:** Teachers install `[NO-AFK]` spinning floor mats under desks so kids don't turn invisible to skip pop quizzes.
   - **3 Named Planted Ammo Clues:**
     1. **Aisle 4 Cereal Shelf** (with a loose box of crunchy flakes teetering on the edge).
     2. **Store Clerk's Under-Counter Silent Alarm Button** (glowing red behind the register).
     3. **Devon's Digital Stopwatch** (`10.0s` countdown beep).
3. **13.5–21s Personal Trap & Crisis:**
   - The robbers lock the front shutter, zip-tie the store clerk behind the register, and sweep the aisles with flashlights looking for any witnesses—Devon is stuck in the open center aisle with zero cover and `12 seconds` before they turn his corner.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Devon freezes at `09s...`—*CREAK!* His knee pops, resetting `[IDLE: 00s]` right as footsteps crunch closer!
   - **Clue 2 Fail:** Devon ducks behind **Aisle 4 Cereal Shelf**—*CRASH!* His elbow nudges the loose cereal box, alerting the taller robber: *"Who's in Aisle 4?!"*
   - **Clue 3 Fail:** Devon tries to crawl toward the **Under-Counter Silent Alarm**—*BEAM!* A flashlight sweeps across the floor tiles two studs behind his heel.
5. **39–51s Genius Rule-Hack Climax:**
   - Devon plants his heels, locks his breath, and stares at one crack in the tile—`10... 9... 8...` The robber rounds Aisle 4 with his flashlight, sweeping right as `[AFK: INVISIBLE]` chimes! Devon fades into clear air! The robber's beam passes *straight through* Devon's chest onto the empty wall. Holding his breath, Devon takes one silent, slow step (resetting visibility only *after* reaching the counter!), slams the **Silent Alarm Button**—*WEE-OOO!*—and freezes again for `10 seconds` until police sirens box the front door!
6. **51–56s Action Echo Punchline:**
   - As officers lead the confused robbers out in cuffs, Devon steps forward, pops back visible with a quiet *POP!*, and hands the clerk back the fallen cereal box.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Devon (Narrator / Protagonist):** Skin `#8D5524`, R6; Shirt: Gray Hoodie (`#7F8C8D`), Pants: Black Jeans (`#1C2833`), Hair: Short Twists (`#1C1C1C`); Face swaps: `scared` -> `determined` -> `shocked` -> `grin` -> `proud`.
- **Robber #1 & #2 (Antagonists):** Skin `#E0B490`, R6; Shirt: Black Ski Mask & Hoodie (`#17202A`), Pants: Dark Cargo (`#212F3D`); Face swaps: `grin` -> `shocked` -> `scared`.
- **Store Clerk (Support):** Skin `#F1C27D`, R6; Shirt: Green Apron (`#27AE60`), Pants: Khaki (`#C3B091`); Face swaps: `scared` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **AFK Transparency Billboard:** `BillboardGui` (`3.5 x 0.9 studs`), `Head` socket (`[IDLE: 10s]` -> `[INVISIBLE]`).
- **Silent Alarm Button:** `0.5 x 0.3 x 0.5 studs`, `Neon`, Red (`#E74C3C`), Socket: `Workspace` (under counter).
- **Cereal Box:** `1.0 x 1.4 x 0.4 studs`, `SmoothPlastic`, Yellow/Blue (`#F4D03F`), Socket: `Workspace` -> `RightHand`.
- **Robber Flashlight:** `0.4 x 0.4 x 1.2 studs`, `Metal` + `SpotLight`, Black (`#1C1C1C`), Socket: `RightHand`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Corner Bodega Store — `Marble` linoleum floor, `Metal` snack aisles, glass front door with rolled-down metal shutter, neon `[OPEN]` sign.
- **Lighting & Camera:** `ClockTime = 23.0` night (`Brightness = 0.7`, `Ambient = #1B2631`, high-contrast robber flashlight cones); tense side-profile shot as Devon's opacity drops from `1.0` to `0.05` right before the beam hits.
- **VFX/SFX Cues:** Opacity fade + subtle shimmer outline; *CRASH!* on cereal box, *DING!* on `10s` AFK cloak, *WEE-OOO!* police siren outside.

---

### Story 039: The Loot-Drop Bully
- **Story ID & Title:** `039 — The Loot-Drop Bully`
- **Format:** Standalone 50–56s, 44 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** You don't have to out-muscle a thief when gravity handles his own pockets for you.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every time you trip, one random item pops out of your pocket like video game loot—and someone just framed me for stealing the Principal's master key!"
   - **Frame 1 Visual:** Narrator (Owen) stumbling over a shoelace in the hallway—*BLOOP!*—spawning a half-eaten gummy worm on the tile while Principal Moss glares at Owen's open locker and bully Vance smirks behind him.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid trips on the track field and *BLOOP-BLOOP!* pops out a shiny blue marble and a `5-dollar` bill with golden RPG rarity sparkles spinning above them.
   - **Town Adaptation:** Everyone ties their shoelaces in triple-knots and shuffles flat-footed down the stairs so they don't drop their lunch money in front of seventh graders.
   - **3 Named Planted Ammo Clues:**
     1. **Principal's Missing Brass Master Key** (glowing `[LEGENDARY LOOT]` gold aura).
     2. **Vance's Heavy Gym Bag** (jammed full of 15 stolen hall passes + the key).
     3. **Wet Floor Mop Bucket & Sign** parked right outside the Principal's office door.
3. **13.5–21s Personal Trap & Crisis:**
   - Principal Moss gives Owen `60 seconds` to empty his pockets or face suspension for the stolen **Master Key**—meanwhile Vance already hid the key deep inside his zipped pocket and is walking straight out the front doors for lunch.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Owen accuses Vance in front of Principal Moss—*SCOFF!* Vance turns his pockets out halfway; nothing falls, and Principal Moss shakes his head.
   - **Clue 2 Fail:** Owen tries to snag **Vance's Heavy Gym Bag** as he walks past—*SHOVE!* Vance shoves Owen into the lockers (`[NO STEALING]`).
   - **Clue 3 Fail:** Owen drops a pencil in Vance's path to trip him—*CRUNCH!* Vance steps straight over it without even looking down.
5. **39–51s Genius Rule-Hack Climax:**
   - Owen spots the **Wet Floor Mop Bucket & Sign**—Vance won't trip on a pencil, he'll slip on *soap*! Owen sprints ahead, flips the `[WET FLOOR]` sign sideways to hide the puddle, and pretends to drop his own shiny `5-dollar` bill right in the soapy slick. Greed wins: Vance lunges for the cash, hits the soap—*WHOOSH-THUD!*—and hits the floor! *BLOOP!* Out of Vance's back pocket pops a spinning, glowing gold `[LEGENDARY: PRINCIPAL MASTER KEY]` right at Principal Moss's polished shoes!
6. **51–56s Action Echo Punchline:**
   - Principal Moss picks up the spinning gold key with two fingers, points toward detention, and Owen retrieves his `5-dollar` bill with a polite *BLOOP!* nod.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Owen (Narrator / Protagonist):** Skin `#F5D0A9`, R6; Shirt: Blue Varsity Tee (`#2E86C1`), Pants: Khaki Shorts (`#C3B091`), Hair: Curly Blonde (`#F4D03F`); Face swaps: `scared` -> `determined` -> `grin` -> `proud`.
- **Vance (Bully):** Skin `#C68642`, R6; Shirt: Black Leather Jacket (`#1C2833`), Pants: Dark Denim (`#212F3D`), Hair: Slicked Back (`#1C1C1C`); Face swaps: `grin` -> `shocked` -> `scared`.
- **Principal Moss (Authority):** Skin `#F1C27D`, R6; Shirt: Gray Suit (`#566573`), Pants: Gray Slacks (`#566573`), Hair: Bald + Glasses; Face swaps: `neutral` -> `shocked` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Principal's Master Key:** `0.8 x 0.3 x 0.4 studs`, `Neon` + `Metal`, Gold (`#F1C40F`), Socket: `Workspace` (spinning loot drop) -> `RightHand`.
- **Wet Floor Sign & Mop Bucket:** `1.6 x 2.4 x 1.2 studs`, `SmoothPlastic`, Bright Yellow (`#F4D03F`), Socket: `Workspace`.
- **5-Dollar Bill:** `0.8 x 0.05 x 0.4 studs`, `SmoothPlastic`, Mint Green (`#2ECC71`), Socket: `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Main Hallway — `Marble` polished floor, `Metal` locker rows, Principal's glass-windowed office door.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 1.6`, crisp overhead specular shine on the soapy puddle); low-angle floor shot capturing the spinning golden `[LEGENDARY]` key drop right at Principal Moss's shoes.
- **VFX/SFX Cues:** Gold star `ParticleEmitter` around legendary drop; *WHOOSH-THUD!* on slip, *BLOOP!* video-game item pop.

---

### Story 040: The Ping-Lag Kid
- **Story ID & Title:** `040 — The Ping-Lag Kid`
- **Format:** Standalone 50–56s, 46 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Being three seconds behind everyone else's rush is a superpower when the ceiling drops at zero.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, my best friend lives three seconds behind real time—and everyone called him 'Lag Boy' until the roof collapsed!"
   - **Frame 1 Visual:** Narrator (Ari) high-fiving classmate Toby—except Toby's hand slaps empty air *three full seconds* after Ari already walked away, a pulsing red `[PING: 3000ms]` icon floating above Toby's head.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** In gym class, Toby swings his dodgeball bat three seconds after the ball already hit the back wall, knocking over the water cooler in slow-motion rubber-band jumps.
   - **Town Adaptation:** Teachers seat Toby at the back door so his `3-second` delayed footsteps don't cause traffic jams in the hallway.
   - **3 Named Planted Ammo Clues:**
     1. **Toby's `3000ms` Delayed Movement** (his ghost-frame trails 3 seconds behind his intention).
     2. **Heavy Iron Gym Rafter Beam** swaying above the crowded bleachers.
     3. **Red Fire-Alarm Pull Station** mounted on the brick pillar `10 studs` from Toby.
3. **13.5–21s Personal Trap & Crisis:**
   - During the packed pep rally, the **Heavy Iron Gym Rafter Beam** snaps! Everyone in the bleachers freezes in panic—and the steel girder crashes straight onto the main exit door, trapping 40 kids inside while electrical sparks ignite the wall banner!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Ari sprints for the **Red Fire-Alarm Pull Station**—*CRASH!* Falling plaster blocks Ari's path `6 studs` short.
   - **Clue 2 Fail:** Coach tries to shove the fallen **Iron Beam** off the exit—*GRUNT!* It weighs 900 lbs and doesn't budge.
   - **Clue 3 Fail:** Ari yells *"Toby, pull the alarm!"*—*LAG!* Toby blinks and starts running *3 seconds too late* as a second beam drops straight toward his head!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—because Toby's body is `3 seconds` behind real time, he's *still standing* where it's safe while the beam falls onto the empty spot he's *about* to step into! Seeing the beam drop, Toby triggers his step *3 seconds ago*—his rubber-band lag snaps him sideways *past* the falling steel! Unharmed, Toby reaches the **Red Fire-Alarm Pull Station** right before the second wave of sparks hits, yanks it down—*RING-RING-RING!*—popping open the automated emergency roof-hatch and fire exits for all 40 kids!
6. **51–56s Action Echo Punchline:**
   - Outside on the grass, Ari throws his arms up for a celebratory high-five; Toby smiles, slaps Ari's hand three seconds later—*SMACK!*—and the whole pep rally cheers on cue.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Ari (Narrator / Best Friend):** Skin `#F1C27D`, R6; Shirt: Blue Pep Rally Tee (`#2874A6`), Pants: Black Shorts (`#1C2833`), Hair: Short Brown (`#4E342E`); Face swaps: `neutral` -> `scared` -> `shocked` -> `grin` -> `proud`.
- **Toby ("Lag Boy"):** Skin `#E0B490`, R6; Shirt: Green Striped Hoodie (`#27AE60`), Pants: Gray Sweatpants (`#7F8C8D`), Hair: Messy Reddish (`#BA4A00`); Face swaps: `neutral` -> `determined` -> `grin` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Ping Billboard:** `BillboardGui` (`3.5 x 0.9 studs`), `Head` socket (`[PING: 3000ms]` red Wi-Fi bars).
- **Iron Gym Rafter Beam:** `16.0 x 1.2 x 1.2 studs`, `Metal`, Rusted Steel (`#566573`), Socket: `Workspace`.
- **Fire-Alarm Pull Station:** `0.6 x 0.9 x 0.3 studs`, `Neon` + `Metal`, Red (`#E74C3C`), Socket: `Workspace` (brick pillar).

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Gymnasium — `WoodPlanks` court, packed `Wood` bleachers, steel roof trusses, brick pillars, glowing exit signs.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 1.4`, flashing red alarm strobes after pull); motion-trail ghost-frame effect trailing behind Toby's R6 rig.
- **VFX/SFX Cues:** Translucent cyan ghost-afterimage `ParticleEmitter` on Toby; *CRASH!* on beam drop, *RING-RING-RING!* on alarm bell, delayed *SMACK!* on final high-five.

---
## Category 3: Superhero & Vigilante Plot-Twists (Stories 041–050)

---

### Story 041: The Curfew Mask
- **Story ID & Title:** `041 — The Curfew Mask`
- **Format:** Standalone 50–56s, 46 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Sometimes the shadow everyone fears on the rooftops is the only person feeding the block.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, a masked vigilante swings over the rooftops after midnight—and I just tracked him straight to my older brother's clocktower!"
   - **Frame 1 Visual:** Silhouette of a hooded figure in a black domino mask swinging on a grappling cord past the glowing full moon while Narrator (Liam) aims his binoculars from the fire escape below.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Every morning, `50` loaves of fresh bread and canned soup vanish from the Mayor's locked surplus warehouse—and the Mayor puts a `$5,000` bounty on the "Midnight Rooftop Thief."
   - **Town Adaptation:** Storekeepers bolt steel shutters over their skylights and set rooftop motion floodlights along Elm Street.
   - **3 Named Planted Ammo Clues:**
     1. **Muddy Size-10 Bootprints** leading up the back alley fire escape.
     2. **Dropped Red Yarn Thread** snagged on the clocktower's iron weathervane.
     3. **Old Heavy Canvas Backpack** hidden inside Liam's own bedroom closet.
3. **13.5–21s Personal Trap & Crisis:**
   - At `11:55 PM`, the Mayor's drone spotlights lock onto the masked figure perching on the Old Clocktower; Liam climbs the inner stairs to warn or unmask the thief, corners him under the bell, and rips the black mask off—freezing in shock as his older brother Marcus turns around holding three heavy brown paper grocery bags!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Liam grabs the **Heavy Canvas Backpack** shouting *"You stole from the warehouse?!"*—*THUD!* Two cans of soup spill out, and police sirens wail two blocks away.
   - **Clue 2 Fail:** Liam tries to pull Marcus down the **Clocktower Stairs** to hide—*CLANG!* The Mayor's security drone hovers right outside the narrow stair window.
   - **Clue 3 Fail:** Liam points at the **Muddy Size-10 Bootprints** leading to their porch—*BEEP!* The drone's thermal scanner locks onto Marcus's red hoodie.
5. **39–51s Genius Rule-Hack Climax:**
   - Marcus points down through the clocktower louver at three darkened porches on the poor side of Elm Street—each porch has a glowing chalk `[X]` on the curb where families couldn't afford groceries after the Mayor hiked taxes, and the surplus warehouse food was set to be dumped in the landfill at dawn! Liam understands instantly: he snags the **Dropped Red Yarn Thread** from Marcus's sleeve, throws on his own spare black hoodie to draw the drone's thermal spotlight *away* toward the empty school roof, while Marcus swings silently across the alley dropping all three grocery bags gently onto the darkened porches!
6. **51–56s Action Echo Punchline:**
   - At sunrise, Mrs. Alvarez opens her front door to find warm bread and soup on her mat; up on the clocktower ledge, Liam hands Marcus a fresh red yarn spool and pulls his own hood up beside him.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Liam (Narrator / Protagonist):** Skin `#C68642`, R6; Shirt: Charcoal Hoodie (`#34495E`), Pants: Black Jeans (`#1C2833`), Hair: Short Curly Black (`#1C1C1C`); Face swaps: `determined` -> `shocked` -> `scared` -> `grin` -> `proud`.
- **Marcus (Older Brother / Vigilante):** Skin `#C68642`, R6; Shirt: Red Hoodie (`#C0392B`) + Black Domino Mask, Pants: Dark Cargo (`#212F3D`), Hair: Fade (`#1C1C1C`); Face swaps: `neutral` -> `scared` -> `proud`.
- **Mayor Vance (Antagonist):** Skin `#F5D0A9`, R6; Shirt: Navy Suit (`#1B2631`), Pants: Navy Slacks (`#1B2631`); Face swaps: `grin` -> `shocked`.

#### Props & Sockets (Sound-Off Visible)
- **Black Domino Mask:** `1.1 x 0.4 x 0.2 studs`, `SmoothPlastic`, Matte Black (`#17202A`), Socket: `Head`.
- **Grappling Hook & Cord:** `0.8 x 0.4 x 1.0 studs`, `Metal`, Gunmetal (`#566573`), Socket: `RightHand`.
- **Brown Paper Grocery Bags (x3):** `1.2 x 1.4 x 0.8 studs`, `SmoothPlastic`, Kraft Tan (`#D5B895`), Socket: `RightHand` / `Workspace`.
- **Mayor's Thermal Drone:** `2.0 x 0.7 x 2.0 studs`, `Metal` + `SpotLight` red cone, Socket: `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Old Town Clocktower & Elm Street Rooftops — `Brick` clocktower, glowing white clockface, `Slate` shingled roofs, `WoodPlanks` porches below.
- **Lighting & Camera:** `ClockTime = 00.2` midnight (`Brightness = 0.5`, cool silver moonbeam `Ambient = #2C3E50`, piercing drone spotlight cone); dramatic silhouette shot on frame 1, warm golden porch light at sunrise (`ClockTime = 06.3`).
- **VFX/SFX Cues:** Red thermal scan cone; *WHOOSH!* on grapple swing, *THUD!* on bag drop, *BEEP-BEEP!* on drone lock.

---

### Story 042: The 1-Minute Super-Speed
- **Story ID & Title:** `042 — The 1-Minute Super-Speed`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** A power that burns everything you touch is a curse—until the whole town is freezing to death.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, I can run at Mach One for sixty seconds a day—but anything I touch while running bursts into flames!"
   - **Frame 1 Visual:** Narrator (Dash) sprinting across the school track in a streak of orange lightning—*FWOOSH!*—leaving his own sneakers and three gym cones smoking behind him while his `[SPEED TIMER: 00:58]` ticks down.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Dash rushes to hand in his late math homework—*POOF!* The paper ignites into floating gray ash in mid-air before it even reaches the teacher's desk.
   - **Town Adaptation:** Dash's mom keeps a metal bucket of sand by the front door and bans him from running inside the house after he accidentally toasted the living room curtains.
   - **3 Named Planted Ammo Clues:**
     1. **Town Square Unlit Oak Bonfire Tower** (soaked in freezing sleet, `30` feet tall).
     2. **Soaked Box of Matches** shivering in the Mayor's wet glove.
     3. **Dash's `01:00` Daily Speed Charge** (unused today, pulsing orange at `100%`).
3. **13.5–21s Personal Trap & Crisis:**
   - A sudden freak blizzard snaps every power line in town; temperatures plummet to `-10°F`, and `100` huddled families are shivering in the Town Square shelter with zero heat because the massive **Oak Bonfire Tower** is coated in solid ice.
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** The Mayor strikes his **Soaked Box of Matches**—*FIZZLE!* Wet sulfur crumbles in the wind.
   - **Clue 2 Fail:** Firefighters aim a road flare at the base—*HISS!* The thick ice shell snuffs the flare out in three seconds.
   - **Clue 3 Fail:** Dash tries to rub two dry sticks together at normal speed—*CRACK!* His fingers are too numb to spark even a wisp of smoke.
5. **39–51s Genius Rule-Hack Climax:**
   - Dash stares at the frozen oak pile and realizes *Mach 1 friction melts ice!* He taps his watch—`[SPEED: 60s ACTIVE!]`—and sprints in a tight roaring spiral straight up the outside of the 30-foot **Oak Bonfire Tower**! His blistering boots carve a glowing orange corkscrew around every wet log—*WHOOSH-CRACKLE-BOOM!* Steam explodes into a 20-foot pillar of roaring golden fire right as Dash skids to a stop in the snow at `00:01`!
6. **51–56s Action Echo Punchline:**
   - A hundred frozen townsfolk rush toward the blazing bonfire holding out their mittens; Dash holds up one steaming sneaker to roast a marshmallow on his own sole with a grin.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Dash (Narrator / Protagonist):** Skin `#F1C27D`, R6; Shirt: Red Track Jacket (`#C0392B`) with Yellow Bolt, Pants: Black Running Pants (`#1C2833`), Hair: Spiky Blonde (`#F4D03F`); Face swaps: `scared` -> `determined` -> `grin` -> `proud`.
- **Mayor Vance (Support):** Skin `#F5D0A9`, R6; Shirt: Heavy Navy Parka (`#1B2631`), Pants: Snow Pants (`#2C3E50`); Face swaps: `scared` -> `shocked` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Speed Timer Billboard:** `BillboardGui` (`3.8 x 0.9 studs`), `Head` socket (`[MACH 1: 60s]`).
- **Oak Bonfire Tower:** `10 x 18 x 10 studs`, `Wood` logs coated in `Ice` (`#AED6F1`), Socket: `Workspace`.
- **Wet Matchbox:** `0.5 x 0.2 x 0.7 studs`, `SmoothPlastic`, Red/Tan (`#C0392B`), Socket: `RightHand`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Town Square Plaza in Blizzard — `Cobblestone` covered in `Snow`, central stacked `Wood` bonfire tower, huddled crowd in winter coats.
- **Lighting & Camera:** `ClockTime = 21.0` blizzard night (`Brightness = 0.7`, `FogEnd = 65`, icy blue `Ambient = #2E4053`), flipping to warm orange firelight (`#E67E22`) as the bonfire erupts.
- **VFX/SFX Cues:** Orange lightning trail `Trail` + `Fire` emitter on Dash's boots; *FIZZLE!* on matches, *WHOOSH-CRACKLE-BOOM!* on spiral ignition.

---

### Story 043: The Heavy-Punch Curse
- **Story ID & Title:** `043 — The Heavy-Punch Curse`
- **Format:** Standalone 50–56s, 44 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Anger isn't a monster if you aim it at the lock instead of the people inside.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every time I get mad my hands grow three times bigger—and I'm stuck in traffic on a jammed school bus!"
   - **Frame 1 Visual:** Narrator (Bruce) gripping his knees in a school bus seat while his right fist swells to `3.5 studs` wide—*CREAK!*—accidentally snapping his plastic pencil in half like a toothpick.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid cuts Bruce in the pizza line; Bruce's hands instantly balloon into giant brick-sized mitts—*SMASH!*—crushing his own lunch tray into a pancake while everyone gasps.
   - **Town Adaptation:** Bruce wears oversized oven mitts and listens to whale-song headphones all day (`[CALM METER: 100%]`) so he doesn't wreck his locker door.
   - **3 Named Planted Ammo Clues:**
     1. **Bruce's Oven Mitts & Whale-Song Headphones** (keeping `[ANGER: 05%]`).
     2. **Jammed Emergency Steel Bus Door** (buckled inward from a fender-bender).
     3. **Class Bully Leo** grinning as he blocks the aisle taking selfie videos of Bruce's mitts.
3. **13.5–21s Personal Trap & Crisis:**
   - A fuel-line spark ignites under the bus hood! Smoke pours through the floor vents, the hydraulic front door won't open, and the rear **Jammed Emergency Steel Bus Door** is bent shut—trapping 22 kids inside with the fire spreading fast!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** The bus driver slams the **Emergency Latch** with a fire extinguisher—*CLANG!* The buckled steel frame doesn't budge a millimeter.
   - **Clue 2 Fail:** Bruce rips off his **Oven Mitts** and tries to pry the door while staying calm—*SLIP!* At normal hand size (`0.8 studs`), he has zero leverage.
   - **Clue 3 Fail:** Bruce tries to force himself to get mad on command—*PUFF!* Fake anger doesn't trigger the curse (`[ANGER: 12%]`), and black smoke drops to eye level!
5. **39–51s Genius Rule-Hack Climax:**
   - Bruce can't fake anger—he needs a *real* spark! He turns straight to **Class Bully Leo**, yanks Leo's phone, and yells *"Remember when you tripped my little sister?!"* Leo snaps back *"She deserved it!"* *BOOM!* Bruce's `[ANGER: 100%]` meter spikes red, his fists swell `3x` into colossal 3.5-stud iron-hard mitts—he spins around and drives a double-fisted punch straight into the **Jammed Steel Bus Door**—*KA-CRACK-CLANG!* The steel door flies `20 studs` off its hinges into the grass, clearing the exit for all 22 kids!
6. **51–56s Action Echo Punchline:**
   - Once every kid is safe on the curb, Bruce puts his whale-song headphones back on; his giant fists shrink back to normal, and he politely hands Leo back his phone—cracked right down the screen.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Bruce (Narrator / Protagonist):** Skin `#8D5524`, R6 (hand parts scale `1x -> 3x`); Shirt: Green Sweater (`#27AE60`), Pants: Dark Jeans (`#2C3E50`), Hair: Short Fade (`#1C1C1C`); Face swaps: `neutral` -> `scared` -> `determined` -> `shocked` -> `proud`.
- **Leo (Bully Classmate):** Skin `#F5D0A9`, R6; Shirt: Red Polo (`#C0392B`), Pants: Khaki (`#C3B091`); Face swaps: `grin` -> `scared` -> `shocked`.

#### Props & Sockets (Sound-Off Visible)
- **Anger Meter Billboard:** `BillboardGui` (`3.5 x 0.8 studs`), `Head` socket (`[CALM: 05%]` green -> `[100%]` red).
- **Oversized Oven Mitts:** `1.2 x 1.2 x 1.4 studs`, `Fabric`, Light Blue (`#85C1E9`), Socket: `LeftHand` / `RightHand`.
- **Jammed Steel Bus Door:** `3.2 x 6.5 x 0.4 studs`, `Metal`, Yellow/Steel (`#F1C40F`), Socket: `Workspace` (bus rear).

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Yellow School Bus Interior & Highway Shoulder — `Metal` bus seats, `Glass` windows filling with gray smoke, `Asphalt` road.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 1.4`, orange engine smoke glow inside bus); tight close-up on Bruce's hands swelling 3x before the slow-motion door smash.
- **VFX/SFX Cues:** Red steam `ParticleEmitter` around swelling fists; *CLANG!* on extinguisher, *KA-CRACK-CLANG!* on steel door launch.

---

### Story 044: The Reverse-Magnet Kid
- **Story ID & Title:** `044 — The Reverse-Magnet Kid`
- **Format:** Standalone 50–56s, 44 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Being the kid who attracts every stray piece of metal is annoying—until the heaviest lock in town gets stuck.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, every metal spoon, paperclip, and locker key flies straight at my chest—and I just got dragged into a bank vault!"
   - **Frame 1 Visual:** Narrator (Max) walking past the school cafeteria table as `14` metal spoons and forks lift off trays—*CLINK-CLINK-CLINK!*—and stick sideways onto his denim jacket like iron filings.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Max steps near the hardware store aisle and a whole shelf of nails and wrenches rattles off the pegs, chasing him down the sidewalk like a metallic swarm.
   - **Town Adaptation:** The school hands Max a wooden ruler, plastic lunch spork, and Velcro sneakers so he doesn't pull the teacher's staplers across the room.
   - **3 Named Planted Ammo Clues:**
     1. **Max's Rubber-Soled Sneakers** (insulating him until he jumps).
     2. **Bank Vault's 2-Ton Steel Hinge Pin** (rusted inside the jammed emergency door).
     3. **Vault's Copper Grounding Rod** bolted to the lobby pillar.
3. **13.5–21s Personal Trap & Crisis:**
   - During a school field trip to the First Town Bank, a power surge trips the old **Bank Vault Door** shut with three classmates and the tour guide trapped inside—the manual override breaks, and the vault's air vent only has `60 seconds` of backup flow!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** The bank guard twists the **3-Spoke Vault Wheel**—*SNAP!* The brass wheel shears right off in his hands.
   - **Clue 2 Fail:** Max presses his chest against the **Steel Vault Door** to pull it open—*THUD!* His magnetic pull just glues *him* flat to the door without moving the 2-ton slab.
   - **Clue 3 Fail:** Max tries to pull the **Steel Hinge Pin** out with his bare hands—*CREAK!* It's wedged tight with 50 years of rust.
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—if Max's chest pulls metal *toward* him, he just needs to stand *farther back* and let the **Copper Grounding Rod** amplify his field! Max sprints `12 studs` back to the **Vault's Copper Grounding Rod**, grips it with both hands, and kicks off his **Rubber-Soled Sneakers**—*BZZZZT-HUM!* His magnetic pull spikes `10x`! A blue electromagnetic arc leaps across the lobby, yanking the rusted **2-Ton Steel Hinge Pin** straight out of the vault frame—*SHING-CLANG!*—and swinging the massive steel door wide open!
6. **51–56s Action Echo Punchline:**
   - The three trapped classmates tumble out cheering; Max steps back into his rubber sneakers, and the guard's spare whistle flies off his neck and sticks right onto Max's nose with a tiny *clink*.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Max (Narrator / Protagonist):** Skin `#E0B490`, R6; Shirt: Denim Jacket over White Tee (`#2E86C1`), Pants: Black Jeans (`#1C2833`), Hair: Messy Dark Brown (`#4E342E`); Face swaps: `shocked` -> `determined` -> `scared` -> `grin` -> `proud`.
- **Bank Guard (Support):** Skin `#8D5524`, R6; Shirt: Security Blue (`#2471A3`), Pants: Dark Navy (`#1B2631`), Hat: Guard Cap (`#1B2631`); Face swaps: `scared` -> `shocked` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Cafeteria Spoons (x14):** `0.5 x 0.1 x 0.2 studs`, `Metal`, Chrome (`#BDC3C7`), Socket: `UpperTorso` (stuck).
- **2-Ton Steel Vault Door & Hinge Pin:** `10 x 10 x 1.5 studs` (`Pin: 0.6 x 2.2 x 0.6 studs`), `Metal`, Brushed Steel (`#7F8C8D`), Socket: `Workspace`.
- **Copper Grounding Rod:** `0.4 x 7.0 x 0.4 studs`, `Metal`, Copper (`#D35400`), Socket: `Workspace` (lobby pillar).

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** First Town Bank Lobby — `Marble` floor, `WoodPlanks` teller counter, massive circular `Metal` vault door.
- **Lighting & Camera:** `ClockTime = 15.5` (`Brightness = 1.5`, crisp marble reflections); dynamic magnetic-arc close-up as the iron hinge pin shoots across the lobby.
- **VFX/SFX Cues:** Blue electric `Beam` arc between copper rod and hinge pin; *CLINK-CLINK!* on spoons, *BZZZZT-HUM!* on surge, *SHING-CLANG!* on pin yank.

---

### Story 045: The Glass-Armor Hero
- **Story ID & Title:** `045 — The Glass-Armor Hero`
- **Format:** 2-Part (Part 1: 0–28s Mystery / Part 2: 28–56s Twist), 48 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Never mistake looking unbreakable for actually being safe—someone else might be taking every crack for you.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "Everyone in town thinks I'm completely indestructible—because they've never seen the wooden doll hidden in my closet!"
   - **Frame 1 Visual:** Narrator (Jax) stepping in front of a runaway skateboarder—*THWACK!*—taking a brutal hit to the shoulder without a scratch, while a quick cut shows a carved wooden doll in his dark closet gaining a glowing red crack across its arm.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Jax slips off the gym bleachers onto solid concrete and bounces right back up dusting his jeans while everyone chants *"Iron Jax!"*
   - **Town Adaptation:** The town puts Jax on the volunteer rescue squad and paints a `[NO-SCRATCH HERO]` mural on the firehouse wall.
   - **3 Named Planted Ammo Clues:**
     1. **Carved Cedar Wood Doll** locked inside Jax's bedroom closet (`8/10` cracks glowing red).
     2. **Heavy Brick Warehouse Wall** leaning over the downtown alley.
     3. **Silver Pocket Mirror & Bandage Tape** sitting on Jax's dresser.
3. **13.5–21s Personal Trap & Crisis:**
   - An afternoon tremor cracks the **Heavy Brick Warehouse Wall** right above the daycare playground! Jax sprints under it to brace the falling brick beam with his shoulders—unaware that back home, his **Carved Cedar Wood Doll** is down to one single hairline thread before snapping in half!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Jax braces against the falling **Brick Beam**—*CRUNCH!* Back in his closet, the doll's chest splits (`9/10` cracks!), and Jax feels a sudden cold shiver.
   - **Clue 2 Fail:** Jax yells for the daycare teacher to hurry—*RUMBLE!* A second pallet of bricks slides down onto his back; the doll's neck snaps halfway (`99%` fractured!).
   - **Clue 3 Fail:** Jax tries to toss the heavy beam aside—*STUMBLE!* His knees buckle for the first time in his life as the doll's wood groans.
5. **39–51s Genius Rule-Hack Climax:**
   - Jax realizes if the doll snaps, *he* breaks too—and the kids are still two steps from the gate! Instead of holding the bricks with his body, Jax spots an empty steel dumpster three studs to his left, shoves it sideways under the beam to take the weight, and sprints home at full speed—bursting into his closet just as the doll tips off the shelf! He catches the **Carved Cedar Wood Doll** mid-air and wraps it tight in **Bandage Tape**—*ZAP!* Every red crack fades to warm gold!
6. **51–56s Action Echo Punchline:**
   - The next morning, Jax shows up at school wearing a real band-aid on his cheek for the first time—and smiles quietly when nobody calls him "Iron Jax" anymore.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Jax (Narrator / Protagonist):** Skin `#F1C27D`, R6; Shirt: Dark Red Hero Tee (`#922B21`), Pants: Black Jeans (`#1C2833`), Hair: Short Brown (`#4E342E`); Face swaps: `proud` -> `shocked` -> `scared` -> `determined` -> `grin`.
- **Daycare Teacher (Support):** Skin `#8D5524`, R6; Shirt: Yellow Cardigan (`#F4D03F`), Pants: Navy Skirt/Pants (`#21618C`); Face swaps: `scared` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Carved Cedar Wood Doll:** `0.8 x 1.6 x 0.6 studs`, `Wood`, Cedar (`#A04000`) with `Neon` red crack seams, Socket: `Workspace` (closet) -> `RightHand`.
- **Bandage Tape Roll:** `0.5 x 0.3 x 0.5 studs`, `Fabric`, White (`#FFFFFF`), Socket: `RightHand`.
- **Steel Dumpster:** `6.0 x 4.0 x 4.0 studs`, `Metal`, Dark Green (`#1E8449`), Socket: `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Downtown Brick Alley & Daycare Yard — `Brick` crumbling wall, `Concrete` yard, metal dumpster.
- **Secondary Set:** Jax's Dark Bedroom Closet — `WoodPlanks` shelf, glowing red cracks on the cedar doll.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 1.5`) in alley vs. `ClockTime = 01.0` (`Brightness = 0.4`, red crack glow) inside closet; parallel split-screen cross-cuts between Jax's straining shoulders and the cracking doll.
- **VFX/SFX Cues:** Glowing red crack `Highlight` pulsing on doll; *CRUNCH!* on bricks, *CREAK!* on wood fracture, warm chime on tape wrap.

---

### Story 046: The Time-Freeze Snap
- **Story ID & Title:** `046 — The Time-Freeze Snap`
- **Format:** Standalone 50–56s, 46 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** You don't measure the cost of saving people by how many silver hairs it leaves behind.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, snapping my fingers freezes everything for ten seconds—but every snap turns one strand of my hair bright silver!"
   - **Frame 1 Visual:** Narrator (Theo) snapping his fingers in the school hallway—*SNAP!*—freezing a spilled milk carton mid-air in crystal-blue stasis while one single hair strand on his brown head flashes bright silver.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Theo snaps to catch a falling trophy in the hallway—it hangs frozen mid-air, he sets it gently on the shelf, and when time resumes, the principal blinks wondering how it teleported.
   - **Town Adaptation:** Theo wears a beanie all week and refuses to snap for anything trivial (`[SILVER STRANDS: 12%]`), saving his hair for real emergencies.
   - **3 Named Planted Ammo Clues:**
     1. **Crowded Commuter Train** racing toward a washed-out river bridge.
     2. **Steel Track Switch Lever** `80 studs` down the gravel embankment.
     3. **Rusty Iron Crowbar** wedged beside the crossing gate.
3. **13.5–21s Personal Trap & Crisis:**
   - On the walk home, Theo hears the bridge beams snap in the river flood—`200` commuters are hurtling toward the broken trestle `15 seconds` away, and the **Steel Track Switch Lever** is `80 studs` away with zero time to run there normally!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Theo snaps once (*SNAP!* `10s` freeze) and sprints toward the **Track Switch Lever**—*THUD!* Time resumes when he's still `45 studs` short!
   - **Clue 2 Fail:** Theo snaps a second time (*SNAP!* `10s` freeze), reaches the lever, and pulls—*CLANG!* It's rusted solid, and half his front bangs turn bright silver!
   - **Clue 3 Fail:** Theo grabs the **Rusty Iron Crowbar** and snaps a third time (*SNAP!* `10s` freeze)—*CREAK!* Time unfreezes right as the train horn blasts `30 studs` from the switch!
5. **39–51s Genius Rule-Hack Climax:**
   - Theo doesn't have enough `10-second` freezes to muscle the rusted switch—he has to *chain* them without stopping! *SNAP! SNAP! SNAP!* Rapid-fire freezes! Every snap turns another thick streak of hair bright silver (`50%... 80%... 100%`) as Theo rams the **Iron Crowbar** into the switch teeth, jumps onto it with both boots, and snaps *one final time*—*SNAP-CLANK!* The steel rail slides sideways into the safe siding track, and the commuter train roars safely past the broken bridge!
6. **51–56s Action Echo Punchline:**
   - The wind from the passing train blows Theo's beanie straight off—revealing a full, glowing head of pure silver hair as he catches his breath and smiles at the waving passengers.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Theo (Narrator / Protagonist):** Skin `#F1C27D`, R6; Shirt: Navy Bomber Jacket (`#21618C`), Pants: Black Jeans (`#1C2833`), Hair: Brown (`#4E342E`) -> Silver (`#ECF0F1`); Face swaps: `determined` -> `scared` -> `shocked` -> `proud`.
- **Train Conductor (Support):** Skin `#E0B490`, R6; Shirt: Blue Uniform (`#2874A6`), Hat: Conductor Cap (`#1B2631`); Face swaps: `scared` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Steel Track Switch Lever:** `1.0 x 3.2 x 0.8 studs`, `Metal`, Rusted Red (`#922B21`), Socket: `Workspace`.
- **Rusty Iron Crowbar:** `0.3 x 0.3 x 3.0 studs`, `Metal`, Dark Steel (`#566573`), Socket: `RightHand`.
- **Commuter Train:** `45 x 9 x 8 studs`, `Metal`, Silver/Blue (`#BDC3C7` / `#2E86C1`), Socket: `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** River Bridge Rail Crossing — `Granite` gravel bed, `Metal` twin train tracks, collapsed wooden trestle over churning river, switch box.
- **Lighting & Camera:** `ClockTime = 17.2` desaturated freeze-blue (`ColorCorrectionEffect` saturation `-0.85`) during every `10s` snap, snapping back to warm golden sunset (`ClockTime = 16.8`) when time resumes.
- **VFX/SFX Cues:** Blue shockwave ring on every *SNAP!* + *TICK-TOCK* silence during freeze, roaring train whistle as rails lock.

---

### Story 047: The Invisible-Cloak Locker
- **Story ID & Title:** `047 — The Invisible-Cloak Locker`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** You can hide your body in silver cloth, but every step you take still writes your trail on the floor.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, a silver hoodie makes you completely invisible—except every step you take leaves glowing neon footprints!"
   - **Frame 1 Visual:** An empty gym hallway where a floating trophy lifts into thin air while bright cyan `[NEON FOOTPRINTS]` appear one by one across the polished tiles behind Narrator (Cora).
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid puts on the silver hoodie to sneak into the teacher's lounge for donuts—and the janitor simply follows the glowing pink sneaker prints straight to the broom closet.
   - **Town Adaptation:** The school locks the **Silver Hoodie** inside Trophy Case #7, and nobody bothers checking it until someone breaks the glass before the Science Fair.
   - **3 Named Planted Ammo Clues:**
     1. **Missing Blue-Ribbon Robotics Chip** stolen from Cora's Science Fair booth.
     2. **Bottle of White Talcum Chalk Powder** from the gymnastics mat box.
     3. **Torn Strip of Neon-Tread Sneakers** (everyone in class wears different sole patterns!).
3. **13.5–21s Personal Trap & Crisis:**
   - Ten minutes before the Science Fair judges arrive, the glass of Trophy Case #7 is shattered, Cora's **Robotics Chip** vanishes right off her table, and invisible footsteps race across the crowded gymnasium—then abruptly *stop* in the middle of the bleachers!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Cora sprints to the **End of the Neon Footprints** and grabs empty air—*WHOOSH!* The thief already slipped off their shoes and tiptoed barefoot across the benches!
   - **Clue 2 Fail:** Principal Moss turns off the **Gym Ceiling Lights** to spot the glowing hoodie—*DARK!* The silver hoodie absorbs light completely when still.
   - **Clue 3 Fail:** Cora accuses classmate Brent—*SCOFF!* Brent holds up both empty hands while thirty kids crowd around the exits.
5. **39–51s Genius Rule-Hack Climax:**
   - If the thief took off their shoes to stop leaving neon prints, they're standing *barefoot* somewhere on the gym floor! Cora grabs the **Bottle of White Talcum Chalk Powder** from the gymnastics box, twists off the cap, and blasts a wide white cloud straight across the center court—*POOF!* Hundreds of kids stay clear, except in the middle of the key, two invisible feet suddenly appear as crisp white chalk silhouettes! Cora sprints forward, yanks the **Silver Hoodie** off thin air—exposing Brent holding her **Robotics Chip**!
6. **51–56s Action Echo Punchline:**
   - Brent stares down at his chalk-covered socks; Cora clips her **Robotics Chip** back into her robot, and the judge awards her table the blue ribbon on the spot.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Cora (Narrator / Protagonist):** Skin `#F5D0A9`, R6; Shirt: Teal Science Fair Tee (`#16A085`), Pants: Black Jeans (`#1C2833`), Hair: Reddish Ponytail (`#BA4A00`); Face swaps: `shocked` -> `determined` -> `grin` -> `proud`.
- **Brent (Invisible Thief):** Skin `#E0B490`, R6; Shirt: Silver Invisibility Hoodie (`#BDC3C7`), Pants: Dark Gray (`#566573`), Hair: Blonde (`#F4D03F`); Face swaps: `grin` -> `shocked` -> `scared`.

#### Props & Sockets (Sound-Off Visible)
- **Silver Invisibility Hoodie:** `2.0 x 2.0 x 1.0 studs`, `ForceField` / `SmoothPlastic`, Silver (`#BDC3C7`), Socket: `UpperTorso` -> `RightHand`.
- **Robotics Chip:** `0.6 x 0.1 x 0.6 studs`, `Neon` + `Metal`, Blue/Gold (`#3498DB`), Socket: `Workspace` -> `RightHand`.
- **Talcum Chalk Powder Bottle:** `0.6 x 1.2 x 0.6 studs`, `SmoothPlastic`, White (`#FFFFFF`), Socket: `RightHand`.
- **Neon Footprints:** `0.5 x 0.05 x 1.0 studs`, `Neon`, Cyan (`#00E5FF`), Socket: `Workspace` (floor).

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Gymnasium Science Fair — `WoodPlanks` court, rows of tri-fold poster tables, bleachers, shattered Trophy Case #7.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 1.5`) -> dimmed gym lights (`Brightness = 0.4`) during search; low-angle floor shot capturing the white chalk cloud revealing two invisible footprints.
- **VFX/SFX Cues:** White chalk dust `ParticleEmitter` cloud; *SHATTER!* on glass case, *POOF!* on chalk burst, *GASP!* from crowd.

---

### Story 048: The Copycat Touch
- **Story ID & Title:** `048 — The Copycat Touch`
- **Format:** Standalone 50–56s, 46 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** You don't need to be born with every talent when you know who to reach out to in a crisis.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, shaking someone's hand copies their best skill for five minutes—and my dad just collapsed in the middle of a traffic jam!"
   - **Frame 1 Visual:** Narrator (Nia) high-fiving the school's piano prodigy—*SPARK!*—a golden `[SKILL COPIED: CONCERT PIANO — 04:59]` bar popping above her head as her fingers blur across a keyboard.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** A kid accidentally bumps elbows with the varsity pole-vaulter and launches himself `15 feet` over the cafeteria salad bar trying to hop a puddle.
   - **Town Adaptation:** Everyone wears cotton gloves during final exams so nobody steals the math whiz's calculus brain by shaking hands in the hall.
   - **3 Named Planted Ammo Clues:**
     1. **Track Star's Wrist** (`[SKILL: 25 MPH SPRINT]`) standing at the crosswalk.
     2. **Locksmith's Brass Keychain** (`[SKILL: MASTER LOCKPICK]`) at the corner shop.
     3. **ER Surgeon Dr. Patel** stuck three blocks back inside an ambulance blocked by gridlock!
3. **13.5–21s Personal Trap & Crisis:**
   - Nia's dad clutches his chest inside their locked car on Main Street; the doors auto-locked when the battery shorted, the ambulance is trapped three blocks away in bumper-to-bumper gridlock, and Dad needs his nitroglycerin inhaler *now* (`03:00` countdown)!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Nia pulls on the **Car Door Handle**—*CLACK!* Dead-locked, and Nia has zero strength to smash safety glass.
   - **Clue 2 Fail:** Nia shakes hands with the **Locksmith** (`[LOCKPICK: 05:00]`) and pops the car door open—*CLICK!* She grabs Dad's inhaler, but his airway is still swollen shut and she has no medical skill!
   - **Clue 3 Fail:** Nia runs toward the **Stuck Ambulance**—*HONK!* At normal running speed, three gridlocked blocks will take `4 minutes` round-trip—too slow!
5. **39–51s Genius Rule-Hack Climax:**
   - Nia realizes she can *chain* three handshakes! She slaps the **Track Star's** hand at the corner—*SPARK!* `[SPRINT: 25 MPH]`! She blasts past three blocks of frozen cars in `14 seconds`, reaches the ambulance window, shakes **ER Surgeon Dr. Patel's** gloved hand—*SPARK!* `[SURGEON: 05:00]`—rockets *back* before her sprint timer runs out, and uses Dr. Patel's exact steady-handed emergency airway technique to clear Dad's breathing and administer the inhaler just as the paramedics arrive on foot!
6. **51–56s Action Echo Punchline:**
   - Dad takes a deep breath and squeezes Nia's hand; Nia smiles as `[SURGEON: 00:01]` fades away, leaving just her own plain, shaking-with-relief teenager hands.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Nia (Narrator / Protagonist):** Skin `#8D5524`, R6; Shirt: Yellow Track Hoodie (`#F4D03F`), Pants: Black Leggings (`#1C2833`), Hair: Box Braids (`#1C1C1C`); Face swaps: `grin` -> `scared` -> `determined` -> `shocked` -> `proud`.
- **Dad (Victim):** Skin `#8D5524`, R6; Shirt: Blue Work Shirt (`#2E86C1`), Pants: Gray Slacks (`#566573`); Face swaps: `scared` -> `proud`.
- **Dr. Patel (Surgeon):** Skin `#C68642`, R6; Shirt: Teal Scrubs (`#16A085`), Pants: Teal Scrubs (`#16A085`); Face swaps: `determined` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Skill Timer Billboard:** `BillboardGui` (`4.2 x 1.0 studs`), `Head` socket (`[SPRINT: 04:59]`, `[SURGEON: 04:59]`).
- **Nitro Inhaler:** `0.4 x 0.6 x 0.3 studs`, `SmoothPlastic`, Blue/White (`#3498DB`), Socket: `RightHand`.
- **Locked Sedan & Ambulance:** `14 x 5 x 6 studs`, `Metal`, Red Sedan / White Ambulance, Socket: `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Gridlocked Main Street — `Asphalt` 4-lane avenue packed with bumper-to-bumper cars, `Concrete` sidewalks, corner locksmith shop.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 1.6`, warm afternoon glare off windshields); speed-blur tracking shot as Nia weaves between stopped cars.
- **VFX/SFX Cues:** Gold hand-clasp `ParticleEmitter` spark; *CLACK!* on locked door, *CLICK!* on lockpick, *SPARK!* on skill transfer.

---

### Story 049: The Gravity-Flip Sneakers
- **Story ID & Title:** `049 — The Gravity-Flip Sneakers`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** When every door on the floor is locked, look up at the ceiling nobody bothered to guard.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, clicking my heels flips gravity upside down for me alone—and ten kids just got trapped in a flooding school attic!"
   - **Frame 1 Visual:** Narrator (Skye) clicking her bright cyan sneakers together—*CLICK!*—and standing upside down on the school hallway ceiling looking down at confused classmates walking below her.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Skye sneezes in geometry class, accidentally clicks her heels, and *WHOOSH!* drops straight onto the ceiling tiles—spilling her pencil case downward like rain onto her desk.
   - **Town Adaptation:** The school gym hangs padded crash mats on the rafters just in case Skye forgets to un-click her shoes before bell ring.
   - **3 Named Planted Ammo Clues:**
     1. **Cyan Gravity-Flip Sneakers** (`CLICK` = flip `UP` / `DOWN`).
     2. **Jammed Roof Skylight Hatch** `22 feet` above the flooded attic stairs (latched from the *outside* / top side).
     3. **Heavy Brass Padlock Hook** hanging from the ceiling beam right beside the skylight.
3. **13.5–21s Personal Trap & Crisis:**
   - A burst pipe floods the third-floor attic stairwell during drama rehearsal; the heavy fire door swells shut, dirty water rises past everyone's ankles, and the only exit is the **Jammed Roof Skylight Hatch** `22 feet` overhead with zero ladders long enough to reach it!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Two tall seniors stack drama-club props to reach the **Skylight Hatch**—*CRASH!* The cardboard castle collapses into the rising water.
   - **Clue 2 Fail:** Skye clicks her **Cyan Sneakers** and drops onto the ceiling—*THUD!* She reaches the skylight, but the rusted latch is jammed tight and her feet start slipping on the wet ceiling paint!
   - **Clue 3 Fail:** Skye tries to pull the latch with one hand while hanging—*SLIP!* Without downward leverage, she can't get enough force to pop the rusted bolt!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—Skye needs *upward* force to pop a ceiling latch, which means she needs *downward* gravity? No—she needs to hang from the **Heavy Brass Padlock Hook** right beside the skylight and flip gravity *mid-pull*! Skye loops her belt around the brass hook, grips the rusted skylight latch with both hands, and clicks her heels—*CLICK!* Gravity instantly reverses *downward* (`130 lbs` of full body weight yanking the latch straight down!)—*CLANG-POP!* The skylight bursts open, sunshine pours in, and Skye lowers a stage rope down for all ten kids!
6. **51–56s Action Echo Punchline:**
   - Sitting on the warm roof shingles watching the fire department pump out the attic below, Skye clicks her heels one more time just to dangle her legs happily off the eaves.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Skye (Narrator / Protagonist):** Skin `#F5D0A9`, R6 (body `CFrame` inverted `180°` on ceiling); Shirt: Purple Cropped Jacket (`#8E44AD`), Pants: Black Jeans (`#1C2833`), Shoes: Cyan Sneakers (`#00E5FF`), Hair: Short Blonde Bob (`#F4D03F`); Face swaps: `grin` -> `scared` -> `determined` -> `proud`.
- **Drama Kids (Support):** Various R6 classmates in rehearsal outfits; Face swaps: `scared` -> `shocked` -> `proud`.

#### Props & Sockets (Sound-Off Visible)
- **Cyan Gravity-Flip Sneakers:** `1.0 x 0.6 x 1.3 studs`, `Neon` + `SmoothPlastic`, Cyan (`#00E5FF`), Socket: `LeftFoot` / `RightFoot`.
- **Skylight Hatch & Latch:** `4.0 x 0.4 x 4.0 studs`, `Glass` + `Metal`, Steel (`#7F8C8D`), Socket: `Workspace` (attic ceiling).
- **Stage Rope:** `20 x 0.2 x 0.2 studs`, `Fabric`, Tan (`#D5B895`), Socket: `RightHand`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** Flooding School Attic — `WoodPlanks` floor covered in rising `Water`, stacked drama props, `22-stud` sloped ceiling with skylight hatch.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 0.8` inside dark attic -> blinding golden sunbeam pouring through open skylight); upside-down `180°` camera roll matching Skye's ceiling perspective.
- **VFX/SFX Cues:** Cyan ring ripple on heel-click; *CRASH!* on prop stack, *CLICK-CLANG-POP!* on gravity-yank latch.

---

### Story 050: The Lie-Detector Cape
- **Story ID & Title:** `050 — The Lie-Detector Cape`
- **Format:** Standalone 50–56s, 45 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** You don't need a loud speech to expose a liar—just stand within five steps and hand them a microphone.

#### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - **Spoken Line:** "In this town, anyone standing within five studs of my red cape can only tell the absolute truth—and the Mayor is about to blame my dad on live TV!"
   - **Frame 1 Visual:** Narrator (Elena) hiding her glowing-edged **Red Truth Cape** neatly tucked inside her oversized denim jacket as a `[TRUTH AURA: 5 STUDS]` ring pulses faintly around her boots outside City Hall.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - **Absurd Public Disaster:** Elena stands behind the school bully in the cafeteria line; when the teacher asks who threw the mashed potatoes, the bully opens his mouth to blame Elena and blurts out *"IT WAS ME, I AIMED FOR THE FAN!"* in total shock.
   - **Town Adaptation:** The town council bans capes from City Hall courtrooms, forcing Elena to leave hers in her locker during public meetings.
   - **3 Named Planted Ammo Clues:**
     1. **Red Truth Cape** (hidden underneath Elena's oversized denim jacket, `5-stud` radius).
     2. **Mayor Vance's Live Press Podium** (`8 studs` behind the velvet rope).
     3. **Security Guard's `[NO CAPES]` Metal Detector** at the press tent door.
3. **13.5–21s Personal Trap & Crisis:**
   - Mayor Vance calls an emergency press conference on the City Hall steps to frame Elena's dad (the town bridge inspector) for the collapsed park bridge—while `10` live news cameras roll and security blocks Elena `8 studs` back behind the velvet rope!
4. **21–39s Rule-of-3 Failed Attempts:**
   - **Clue 1 Fail:** Elena tries to slip through the **Press Tent Metal Detector**—*BEEP!* The guard spots a red hem under her jacket: *"No capes!"* and pushes her back to `8 studs`.
   - **Clue 2 Fail:** Elena shouts *"Tell them you cut the bridge budget!"* from behind the rope—*LAUGH!* At `8 studs` away, the Mayor is outside her `5-stud` aura and smoothly lies: *"Mr. Morales signed off on cheap steel!"*
   - **Clue 3 Fail:** Elena stretches her arm as far as she can across the rope—*STRETCH!* Still `2 studs` short of the podium!
5. **39–51s Genius Rule-Hack Climax:**
   - If Elena can't cross the rope, she'll bring the *cape* across it! She unclips the **Red Truth Cape** from her collar under her jacket, folds it neatly inside the spare **Press Microphone Windscreen** sitting on the front reporter's tripod, and whispers *"Ask him about the budget!"* The reporter steps right up to the podium (`2 studs` away!) and holds out the mic! Mayor Vance smiles into the red-lined mic and blurts out on live TV: *"I pocketed half the bridge steel money and forged Morales's signature!"*
6. **51–56s Action Echo Punchline:**
   - Ten news cameras zoom straight in as Mayor Vance slaps both hands over his own mouth; Elena's dad hugs her on the sidewalk, and the reporter hands back Elena's red cape with a quiet wink.

#### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Elena (Narrator / Protagonist):** Skin `#C68642`, R6; Shirt: Oversized Denim Jacket (`#2E86C1`), Pants: Black Jeans (`#1C2833`), Hair: Dark Waves (`#1C1C1C`); Face swaps: `determined` -> `scared` -> `shocked` -> `grin` -> `proud`.
- **Mayor Vance (Antagonist):** Skin `#F5D0A9`, R6; Shirt: Navy Suit (`#1B2631`), Pants: Navy Slacks (`#1B2631`), Hair: Silver Part (`#BDC3C7`); Face swaps: `grin` -> `shocked` -> `scared`.
- **Reporter Sam (Support):** Skin `#F1C27D`, R6; Shirt: Tan Trench Coat (`#D5B895`), Pants: Brown Slacks (`#5D4037`); Face swaps: `neutral` -> `shocked` -> `grin`.

#### Props & Sockets (Sound-Off Visible)
- **Red Truth Cape:** `2.4 x 3.0 x 0.1 studs`, `Fabric` + `Neon` gold trim, Crimson (`#C0392B`), Socket: `UpperTorso` -> `RightHand`.
- **Press Microphone:** `0.3 x 0.9 x 0.3 studs`, `Metal` + `Fabric` foam, Black/Red (`#1C1C1C`), Socket: `RightHand`.
- **City Hall Podium:** `3.0 x 3.8 x 2.0 studs`, `WoodPlanks`, Dark Mahogany (`#4E342E`), Socket: `Workspace`.
- **Truth Aura Ring:** `10 x 0.05 x 10 studs` (`5-stud` radius), `Neon`, Gold (`#F1C40F`), Socket: `Workspace`.

#### Sets/Scenes, Lighting & Camera
- **Primary Set:** City Hall Front Steps — `Concrete` wide stairs, `Marble` columns, red velvet crowd ropes, `10` tripod news cameras with flashing tally lights.
- **Lighting & Camera:** `ClockTime = 16.8` (`Brightness = 1.6`, crisp camera flash strobes); tight over-the-shoulder shot of the gold `5-stud` truth ring expanding around the podium mic.
- **VFX/SFX Cues:** Soft gold pulse ring; *BEEP!* on metal detector, camera shutter *CLICK-CLICK-CLICK!* barrage when Mayor confesses live.

---


---

# Viral Roblox Story Production Specs — Part 3 (Stories 051–075)

**Scope:** Category 3: Superhero & Vigilante Plot-Twists (Stories 051–060) + Category 4: Dark Horror Hook → Wholesome 180° Flip (Stories 061–075).
**Rig & Visual Standard:** Classic R6 rigs, Catalog Outfits, `classic_v1` 2D face decals (`neutral`, `scared`, `shocked`, `grin`, `determined`, `proud`), sound-off readable stud-scaled props, and textured Roblox Studio sets.

---

## Category 3: Superhero & Vigilante Plot-Twists (Stories 051–060)

### Story 051: The Shrink-Ray Soda (*Ant-Man* Twist)

- **Header:**
  - **Story ID & Title:** Story 051 — The Shrink-Ray Soda
  - **Format:** Standalone 50–56s (46 beats)
  - **Voice Preset:** `urgent_teen`
  - **Unstated Human Meaning:** Being overlooked for your size only matters until you fit through the door nobody else can reach.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, one sip of blue soda shrinks you to two inches tall for three minutes—and my little sister just locked herself inside a steel bank safe!"`
     - **Frame 1 Visual:** Low-angle close-up of Narrator (R6, `scared`) holding a glowing neon-blue soda can next to a towering `6.0 x 6.0 x 6.0` stud steel vault door with a spinning combination dial and red emergency strobe.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last Tuesday, the town mayor accidentally sipped blue soda during a ribbon-cutting and got carried off inside a seagull's beak for two minutes before popping back to full size mid-air over the fountain.
     - **Town Adaptation:** Every vending machine in town now locks blue cans behind `[ADULT ID]` scanners, and sidewalks have yellow `[WATCH FOR TINY CITIZENS]` magnifying-glass signs.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Magnetized Hairpin):* A `0.4 x 0.1 x 0.1` stud silver bobby pin clipped to Narrator's backpack strap.
       2. *Clue 2 (The Half-Empty Blue Can):* A `0.6 x 1.0 x 0.6` stud blue soda can with `01:45` left on its condensation timer.
       3. *Clue 3 (The Keyhole Brass Latch):* A `0.5 x 0.7 x 0.3` stud keyhole slot on the safe's center plate with a visible inner brass spring bolt.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator's 6-year-old sister Maya crawled into the jewelry shop's display vault during hide-and-seek; the auto-deadbolt slammed shut with `90 seconds` of air left before the backup vent seals.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Hairpin Pick):** Narrator jams the silver hairpin into the keyhole at full size—*SNAP! KRK!*—the pin bends into a useless U-shape against the thick brass tumbler.
     - **Clue 2 Fail (The Crowbar Pry):** The shopkeeper slams a `3.2 x 0.3 x 0.3` stud red crowbar into the door seam—*CLANG! THUD!*—the steel crowbar snaps clean in half without moving the bolt a millimeter.
     - **Clue 3 Fail (The Vent Squeeze):** Narrator tries shoving his arm down the `0.8 x 0.8` stud ceiling air duct—*SKRRT! THUMP!*—his R6 shoulder hits the welded steel grate and bruises red.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator chugs the half-empty blue soda—*GLUG-POP!*—shrinking to `0.35` stud height, sprints across the dusty tile like a canyon, dives straight through the giant brass keyhole tunnel, braces both R6 feet against the inner spring wall, and kicks the release lever open—*KSHH-CLACK!*—just as his 3-minute timer expires and he pops back to full size catching Maya as the heavy door swings wide.
  6. **51–56s Action Echo Punchline:**
     - Maya hands Narrator a tiny bent hairpin from inside her pocket; Narrator drops it in the trash, cracks a juice box instead, and walks out holding her hand.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Leo, 14):** Protagonist | Skin `#E8B896` | R6 Outfit: Teal Zip Hoodie (`#1F7A8C` torso/arms), Dark Charcoal Cargo Pants (`#2B2D42`), Messy Brown Swoop Hair (`#4A3525`) | Emotion Swaps: `scared` (0–21s) → `determined` (21–42s) → `shocked` (42–48s) → `proud` (48–56s).
  - **Maya (6):** Trapped Younger Sister | Skin `#E8B896` | R6 Outfit: Yellow Polka-Dot Tee (`#FFD166`), Denim Overalls (`#3D5A80`), Twin Pigtails (`#4A3525`) | Emotion Swaps: `scared` (13.5–48s) → `grin` (48–56s).
  - **Mr. Vance (52):** Shopkeeper | Skin `#C68B59` | R6 Outfit: White Dress Shirt with Apron (`#F4F4F4` / `#3A506B`), Gray Slacks (`#495057`), Silver Balding Fringe Hair (`#ADB5BD`) | Emotion Swaps: `shocked` (13.5–39s) → `proud` (48–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Blue Shrink-Ray Soda Can:** `0.6 x 1.0 x 0.6` studs | `Neon` / `Metal` rim | `#00B4D8` cyan-blue | Socket: `RightHand` (Leo).
  - **Steel Display Vault Door:** `6.0 x 7.5 x 1.2` studs | `DiamondPlate` & `Metal` | `#4A4E69` gunmetal gray | Socket: `Workspace` (Shop back wall).
  - **Inner Brass Keyhole Latch:** `0.5 x 0.7 x 0.3` studs (macro-scaled inside tunnel: `2.4 x 2.4 x 4.0` studs) | `Metal` | `#FFB703` brass gold | Socket: `Workspace` (Vault interior).
  - **Silver Hairpin:** `0.4 x 0.1 x 0.1` studs | `Metal` | `#E5E5E5` | Socket: `UpperTorso` (backpack strap) → `RightHand`.
  - **Red Crowbar:** `3.2 x 0.3 x 0.3` studs | `Metal` | `#D62828` | Socket: `RightHand` (Mr. Vance).
  - **Countdown Timer Tag:** `2.5 x 0.9` studs | `BillboardGui` | `#FF0055` glowing text (`01:45` → `00:02`) | Socket: `Head` BillboardGui (Leo).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Vance's Clock & Jewelry Shop* — Checkerboard `SmoothPlastic` & `Marble` floor tiles (`#EAEAEA` / `#333533`), `WoodPlanks` display counters (`#6F4E37`), brick back wall (`#7F4F24`) housing the recessed steel vault.
  - **Secondary Set:** *Macro Keyhole Interior* — Oversized `CorrodedMetal` tunnel (`#3D405B`) with giant brass spring coils (`#FFB703`) and volumetric dust motes so the 2-inch sprint reads clearly on mobile.
  - **Lighting:** `ClockTime = 16.8`, warm tungsten indoor `PointLight` (`#FFD166`) contrasted against pulsing red `SpotLight` (`#FF0033`) above the vault door.
  - **VFX/SFX Cues:** Cyan `ParticleEmitter` burst on shrink/grow; camera whip-zoom into keyhole tunnel; crisp *GLUG-POP*, *SNAP*, *CLANG*, *KSHH-CLACK* synced to beat cuts.

---

### Story 052: The Sonic-Clap (*Black Canary* Twist)

- **Header:**
  - **Story ID & Title:** Story 052 — The Sonic-Clap
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `viral_storyteller`
  - **Unstated Human Meaning:** The trait people punish you for in calm weather is the exact tool that saves them in a storm.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, clapping my hands shatters every piece of glass within twenty feet—and I just got suspended for sneezing into a high-five!"`
     - **Frame 1 Visual:** Medium close-up of Narrator wearing thick padded oven mitts in a school hallway as three trophy-case panes behind him spiderweb-crack into glowing cyan shards.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** During last month's pep rally, the basketball team captain tricked Narrator into clapping for a free throw—shattering all 14 gymnasium skylights into glitter rain.
     - **Town Adaptation:** The school instituted a `[NO-CLAP ZONE]` policy where Narrator must wear foam boxing mitts during assemblies and sit 25 feet from any window.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Foam Oven Mitts):* `1.0 x 1.1 x 0.8` stud bright orange padded mitts strapped to Narrator's wrists.
       2. *Clue 2 (The 12-Inch Thick Ice Roof):* The school botanical greenhouse's curved `Glass` roof coated in a `1.0`-stud sheet of solid freezing-rain ice.
       3. *Clue 3 (The Brass Fire Bell):* A `1.4 x 1.4 x 0.6` stud resonant bronze bell mounted on the greenhouse brick pillar.
  3. **13.5–21s Personal Trap & Crisis:**
     - A flash freeze snaps the greenhouse's outer frame shut, locking three classmates and Ms. Rivera inside while the heater vents flood the sealed glass dome with thick carbon-monoxide steam.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Shoulder Ram):** Coach Miller charges the frozen glass door—*THUD! CRUNCH!*—the tempered double-pane glass doesn't even chip, bouncing Coach back into a snowbank.
     - **Clue 2 Fail (The Shovel Smash):** Two janitors swing steel snow shovels at the side panes—*DING! SKRR!*—the shovel blades bend flat against the reinforced ice-coated glass.
     - **Clue 3 Fail (The Muffled Mitten Clap):** Narrator panics and claps while still wearing the orange foam mitts—*POOF! THWUMP!*—the foam absorbs the shockwave completely, leaving only a tiny puff of lint.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator bites the wrist strap off both foam mitts—*RIP!*—steps exactly `19` feet from the greenhouse apex, cups his bare palms toward the resonant bronze fire bell to aim the shockwave upward, and unleashes one thunderous clap—*BOOM-SHATTER!*—the focused sonic ring rockets off the bronze bell and explodes the entire ice-locked glass roof outward into harmless snow-cushioned shards, venting the trapped steam instantly.
  6. **51–56s Action Echo Punchline:**
     - Ms. Rivera climbs out coughing into fresh air, walks straight to the `[NO-CLAP ZONE]` sign on the wall, and flips it over to draw a giant smiley face; Narrator tucks his mitts into his belt.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Devon, 15):** Protagonist | Skin `#8D5524` | R6 Outfit: Burgundy Varsity Jacket (`#780000`), Tan Chinos (`#D4A373`), Short Black Fade Hair (`#1B1B1B`) | Emotion Swaps: `scared` (0–21s) → `determined` (21–43s) → `shocked` (43–48s) → `grin` (48–56s).
  - **Ms. Rivera (38):** Botany Teacher | Skin `#D4A373` | R6 Outfit: Olive Cardigan (`#606C38`), Cream Trousers (`#FEFAE0`), Dark Bun Hair (`#2B2118`) | Emotion Swaps: `scared` (13.5–47s) → `proud` (48–56s).
  - **Coach Miller (44):** Gym Coach | Skin `#F1C27D` | R6 Outfit: Navy Whistle Tracksuit (`#1D3557`), Gray Sweatpants (`#6C757D`), Buzz Cut (`#495057`) | Emotion Swaps: `determined` (21–30s) → `shocked` (43–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Orange Foam Mitts:** `1.0 x 1.1 x 0.8` studs each | `Fabric` | `#FF6B00` | Socket: `LeftHand` & `RightHand` (Devon).
  - **Steel Snow Shovel:** `4.5 x 1.2 x 0.2` studs | `Metal` + `Wood` handle | `#ADB5BD` / `#8B5A2B` | Socket: `RightHand` (Janitors).
  - **Resonant Bronze Bell:** `1.4 x 1.4 x 0.6` studs | `Metal` | `#CD7F32` | Socket: `Workspace` (Greenhouse brick pillar).
  - **No-Clap Zone Sign:** `2.4 x 1.6 x 0.1` studs | `SmoothPlastic` | `#FFFFFF` with `#D62828` crossed-hands decal | Socket: `Workspace` (School brick wall).
  - **Sonic Shockwave Ring:** `1.0` to `22.0` studs expanding torus | `Neon` / `ForceField` | `#00F5D4` | Socket: `Workspace` (spawned at Devon's palms).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Oakridge High Courtyard & Botanical Greenhouse* — Snow-dusted `Slate` walkways (`#CED4DA`), red `Brick` school facade (`#8D3B24`), curved `Glass` greenhouse dome (`#A8DADC`) topped with `Ice` slabs (`#CAF0F8`) and tropical `Grass` planters inside.
  - **Secondary Set:** *School Hallway (Frame 1–4)* — Polished `Marble` floor (`#E9ECEF`), blue `Metal` lockers (`#2B4C7E`), cracked `Glass` trophy cases.
  - **Lighting:** `ClockTime = 15.2`, overcast winter blue-gray `Ambient` (`#8D99AE`), `FogEnd = 180` light snow flurries, warm greenhouse `PointLight` (`#FFD166`) glowing through frost.
  - **VFX/SFX Cues:** Expanding concentric `Neon` shockwave rings, `ParticleEmitter` glass-crystal burst + steam vent plume; *CRACK*, *THUD*, *POOF*, *BOOM-SHATTER*.

---

### Story 053: The Sidekick's Scoreboard (*Hero Ranking* Twist)

- **Header:**
  - **Story ID & Title:** Story 053 — The Sidekick's Scoreboard
  - **Format:** Standalone 50–56s (47 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** The person taking all the credit at the top is often standing on the shoulders of someone quiet at the bottom.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, every superhero wears their public rank floating above their head—and the #1 hero just secretly handed the #99 healer a briefcase full of cash!"`
     - **Frame 1 Visual:** Over-the-shoulder alley shot of `#1` golden-armored Titan handing a glowing green briefcase to `#99` Medic Kid in a faded hoodie, both overhead `[RANK]` tags blazing in neon.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Yesterday, Titan punched a runaway delivery truck to stop it—accidentally launching 400 watermelons through the mayor's stained-glass roof while cameras cheered his pose.
     - **Town Adaptation:** Citizens worship top-10 `[RANK]` tags with free coffee and billboards, while `#99` "Faint-Glow" Medic Kid isn't even allowed inside the Hero Guild cafeteria.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Scuffed Green Med-Satchel):* A `1.3 x 1.0 x 0.5` stud canvas bag with a faded white cross on Medic Kid's hip.
       2. *Clue 2 (The Cracked Asphalt Street):* `20`-stud fissures along Main Street that mysteriously mend themselves overnight whenever Titan "patrols."
       3. *Clue 3 (The Live Broadcast Jumbotron):* A `12.0 x 7.0 x 0.8` stud Plaza LED screen broadcasting every `[RANK]` score update in real time.
  3. **13.5–21s Personal Trap & Crisis:**
     - During a live charity parade, Titan tries to lift a `12`-ton steel water-tower float one-handed for the cameras—the beam snaps, pinning a school bus driver's leg while Titan's own `[RANK #1]` badge flickers red with `#ERROR: COLLATERAL DAMAGE`.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (Titan's Brute Lift):** Titan flexes his gold gauntlets to yank the steel beam—*CREAK! SNAP!*—the beam bends worse, trapping the driver's boot tighter and cracking the sidewalk.
     - **Clue 2 Fail (Guild Drone Cutters):** Two `#4` and `#7` heroes fire laser cutters at the beam—*ZAP! HISSS!*—sparks shower the bus fuel tank, forcing everyone back behind police tape.
     - **Clue 3 Fail (The Bribe Whisper):** Titan turns to Narrator/Medic Kid in the crowd and hisses *"Fix it quietly, I'll double the cash!"*—*SHING!*—Medic Kid refuses to step behind the curtain while the driver's vitals drop.
  5. **39–51s Genius Rule-Hack Climax:**
     - Medic Kid steps straight past the police tape into the live Jumbotron broadcast beam, places both glowing green palms on the snapped steel AND the driver's pinned ankle simultaneously—*HUMMM-CHIME!*—reversing the structural fracture while healing the bone in three seconds flat; the Plaza Jumbotron detects the zero-collateral save, strips `[RANK #1]` off Titan's shocked head, and rockets Medic Kid's tag from `#99` straight to `#1` in blinding gold.
  6. **51–56s Action Echo Punchline:**
     - Titan tries to pick up his dropped gold cape, slips on a leftover watermelon rind, and sits on the curb; Medic Kid walks into the Hero Guild cafeteria and orders a grilled cheese.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Medic Kid (Eli, 16):** Protagonist (`#99` → `#1`) | Skin `#F5CBA7` | R6 Outfit: Faded Mint Hoodie (`#76C893`), Dark Joggers (`#2B2D42`), Messy Curly Auburn Hair (`#8D3B24`) | Emotion Swaps: `neutral` (0–13.5s) → `scared` (13.5–21s) → `determined` (21–44s) → `proud` (44–56s).
  - **Titan (28):** `#1` Hero | Skin `#E0AC69` | R6 Outfit: Gold & Crimson Armor (`#FFB703` / `#9B2226`), White Cape (`#FFFFFF`), Blonde Slick-Back Hair (`#F4D35E`) | Emotion Swaps: `grin` (0–13.5s) → `scared` (13.5–39s) → `shocked` (39–56s).
  - **Bus Driver (Sam, 50):** Citizen in Crisis | Skin `#6F4E37` | R6 Outfit: Blue Uniform Shirt (`#457B9D`), Navy Pants (`#1D3557`), Gray Cap (`#6C757D`) | Emotion Swaps: `scared` (13.5–44s) → `grin` (44–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Floating `[RANK]` Tag:** `2.4 x 0.9` studs | `BillboardGui` | `#FFD700` (`#1`) / `#6C757D` (`#99`) | Socket: `Head` BillboardGui (Eli & Titan).
  - **Cash Briefcase:** `1.6 x 1.2 x 0.5` studs | `Metal` | `#2D6A4F` with `#85BB65` bill stack | Socket: `RightHand` (Titan → Eli).
  - **Med-Satchel:** `1.3 x 1.0 x 0.5` studs | `Fabric` | `#52B788` with white cross | Socket: `UpperTorso` (Eli).
  - **Water-Tower Steel Beam:** `10.0 x 1.2 x 1.2` studs | `DiamondPlate` | `#4A4E69` | Socket: `Workspace` (Main Street).
  - **Plaza Jumbotron:** `12.0 x 7.0 x 0.8` studs | `Neon` SurfaceGui + `Metal` frame | `#111827` | Socket: `Workspace` (City Hall facade).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Hero Plaza & Main Street* — `Concrete` sidewalks (`#ADB5BD`), `Asphalt` road (`#2B2D42`) with yellow stripes, `Brick` Hero Guild building (`#9B2226`), overturned parade float.
  - **Secondary Set:** *Dark Back Alley (Frame 1–3)* — Wet `Cobblestone` (`#343A40`), brick walls (`#582F0E`), single flickering `SpotLight`.
  - **Lighting:** `ClockTime = 16.8`, golden-hour rim light (`#FFB703`) contrasting the emerald healing glow (`#06D6A0`).
  - **VFX/SFX Cues:** Emerald `ParticleEmitter` swirl on Eli's hands, golden rank-swap burst on Jumbotron; *HUMMM-CHIME*, *CREAK-SNAP*, *ZAP*, *DING!*

---

### Story 054: The Shield-Bubble Umbrella (*Forcefield* Twist)

- **Header:**
  - **Story ID & Title:** Story 054 — The Shield-Bubble Umbrella
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `urgent_teen`
  - **Unstated Human Meaning:** Looking silly for being prepared disappears the second the sky starts falling.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, everyone laughs at me for carrying a yellow umbrella on sunny days—until flaming purple meteors started falling on our playground!"`
     - **Frame 1 Visual:** Bright sunny park shot of Narrator standing calmly under an open yellow umbrella surrounded by a faint `ForceField` dome while three classmates point and laugh—then a flaming purple meteor streaks across the blue sky behind them.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Two weeks ago, a kid popped Narrator's umbrella open inside a crowded school bus, expanding an unbreakable 6-stud dome that wedged the bus sideways between two oak trees.
     - **Town Adaptation:** The school banned umbrellas indoors and nicknamed Narrator "Rain-Boy," forcing him to eat lunch alone on the far bleachers.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Yellow Dome Umbrella):* A `3.5 x 3.5 x 2.8` stud bright yellow canopy umbrella that projects a `7.0`-stud glowing `ForceField` sphere when clicked open.
       2. *Clue 2 (The Rusty Steel Slide):* A `8.0 x 2.0 x 5.0` stud playground slide bolted into concrete right beside the sandbox.
       3. *Clue 3 (The Sprinkler Valve Wheel):* A `1.2 x 1.2 x 0.3` stud red iron valve wheel sticking out of the park turf.
  3. **13.5–21s Personal Trap & Crisis:**
     - Warning sirens wail as a sudden hailstorm of `2.0`-stud glowing purple meteors batters the playground, trapping four second-graders underneath the hollow metal slide as the upper canopy begins to dent and melt.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Trash-Can Lid Shield):** The gym monitor holds a `2.2 x 2.2 x 0.2` stud metal trash lid overhead—*PING! CRUSH!*—a meteor punches straight through the lid like cardboard.
     - **Clue 2 Fail (The Bleacher Dash):** Kids try sprinting for the brick gym doors—*BOOM! CRACK!*—a meteor craters the concrete path right in front of them, blocking the exit with molten purple rock.
     - **Clue 3 Fail (The Closed Umbrella Baton):** Narrator swings the *closed* yellow umbrella to bat a falling rock away—*THWACK! BZZT!*—without clicking the dome open, the rock knocks the handle out of his grip.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator dives onto the grass, snatches the yellow umbrella, slides under the melting steel slide with the four second-graders, and clicks the brass latch—*CLICK-VWOOOM!*—the `7.0`-stud unbreakable yellow `ForceField` dome snaps open, bouncing three blazing meteors straight off into the pond (*BOING! SIZZLE!*) while Narrator kicks the red sprinkler valve wheel open so cool water mists the hot slide above them.
  6. **51–56s Action Echo Punchline:**
     - When the sky clears, the three kids who mocked Narrator walk over holding broken sunglasses; Narrator folds his yellow umbrella, taps it once on the grass, and hands each kid a dry paper towel.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Toby, 13):** Protagonist | Skin `#F5CD30` (classic Lego yellow) | R6 Outfit: Blue Striped Polo (`#219EBC`), Khaki Shorts (`#E9C46A`), Sandy Messy Hair (`#D4A373`) | Emotion Swaps: `neutral` (0–13.5s) → `scared` (13.5–39s) → `determined` (39–48s) → `proud` (48–56s).
  - **Playground Bully (Chad, 14):** Mockers' Leader | Skin `#E0AC69` | R6 Outfit: Red Sleeveless Tee (`#E63946`), Black Shorts (`#1D1D1D`), Spiky Black Hair (`#1B1B1B`) | Emotion Swaps: `grin` (0–13.5s) → `scared` (13.5–48s) → `shocked` (48–56s).
  - **Second-Grader (Lily, 8):** Trapped Kid | Skin `#8D5524` | R6 Outfit: Pink Hoodie (`#FF758F`), Blue Jeans (`#457B9D`), Curly Black Puffs (`#1B1B1B`) | Emotion Swaps: `scared` (13.5–45s) → `grin` (45–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Yellow Shield Umbrella:** `3.5 x 3.5 x 2.8` studs open (`0.4 x 2.8 x 0.4` closed) | `SmoothPlastic` + `Metal` shaft | `#FFD166` | Socket: `RightHand` (Toby).
  - **ForceField Dome:** `7.0 x 7.0 x 7.0` stud sphere | `ForceField` | `#FFE66D` translucent | Socket: `Workspace` (parented to Umbrella center).
  - **Purple Meteor Chunk:** `2.0 x 2.0 x 2.0` stud icosphere | `Neon` / `Basalt` | `#9D4EDD` | Socket: `Workspace` (falling sky).
  - **Trash-Can Lid:** `2.2 x 2.2 x 0.2` studs | `Metal` | `#ADB5BD` | Socket: `LeftHand` (Monitor).
  - **Red Sprinkler Valve Wheel:** `1.2 x 1.2 x 0.3` studs | `Metal` | `#D62828` | Socket: `Workspace` (Park grass).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Sunnyvale Elementary Playground* — `Grass` field (`#52B788`), `Sand` pit (`#E9C46A`), `Metal` slide & swings (`#457B9D`), `Concrete` perimeter path (`#CED4DA`), small duck `Water` pond (`#0077B6`).
  - **Lighting:** `ClockTime = 14.5` (bright sun) shifting to `ClockTime = 18.2` violet meteor haze (`#5A189A` tint) during the shower, then back to crisp daylight.
  - **VFX/SFX Cues:** Purple fire trails on meteors, golden ripple rings on dome impact, water-spray mist particles; *PING-CRUSH*, *CLICK-VWOOOM*, *BOING-SIZZLE*.

---

### Story 055: The Memory-Erase Pen (*Men in Black* Twist)

- **Header:**
  - **Story ID & Title:** Story 055 — The Memory-Erase Pen
  - **Format:** Standalone 50–56s (48 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** When someone keeps erasing the truth, the quietest witness is the one who refuses to blink.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, clicking this silver pen erases the last thirty seconds for anyone looking at it—and someone just wiped the entire bank's security room!"`
     - **Frame 1 Visual:** Close-up of a sleek silver pen clicking with a blinding `Neon` cyan flash while three bank guards slump into blank `neutral` stares behind the teller glass.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last Friday, a mischievous toddler clicked a confiscated silver pen inside the town bakery—causing twelve customers to forget they'd already paid and buy the same croissant three times.
     - **Town Adaptation:** Every silver Memory Pen is locked inside City Hall's evidence vault, and police officers wear dark polarized visors whenever handling lost property.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (Polarized Red Sunglasses):* `1.2 x 0.4 x 0.4` stud dark-tinted sunglasses tucked into Narrator's shirt collar.
       2. *Clue 2 (The Ink-Stained Receipt Roll):* A `1.0 x 0.2 x 2.0` stud thermal paper roll on the bank counter stamped `04:12 PM`.
       3. *Clue 3 (The Brass Mirror Compact):* A `0.8 x 0.8 x 0.2` stud pocket mirror resting on the teller's desk.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator walks into the bank to deposit his paper-route jar just as Deputy Cole—who secretly stole the silver pen—unlocks the vault, spots Narrator, and raises the pen to wipe his memory and frame him for the missing cash bags.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Phone Recording):** Narrator holds up his smartphone to record Deputy Cole—*CLICK-FLASH!*—the cyan pulse fries the phone camera sensor into static snow.
     - **Clue 2 Fail (The Guard Shout):** Narrator yells *"Look behind you!"* to the head guard—*CLICK-FLASH!*—Cole clicks the pen again, resetting the guard's face to blank `neutral` before he can turn.
     - **Clue 3 Fail (The Desk Duck):** Narrator ducks under the oak counter with his eyes squeezed shut—*THUD! CREAK!*—Cole's boots stomp right up to his hiding spot and grab his hoodie collar.
  5. **39–51s Genius Rule-Hack Climax:**
     - As Cole yanks Narrator up and clicks the silver pen inches from his face—*CLICK-FLASH!*—Narrator snaps his polarized red sunglasses onto his nose AND tilts the teller's brass pocket mirror right between them; the cyan beam reflects straight back into Cole's unshielded eyes—*ZAP-DING!*—wiping Cole's own last 30 seconds so he drops the stolen cash bag and stares confused at his own handcuffs while the un-erased thermal receipt proves the exact timestamp.
  6. **51–56s Action Echo Punchline:**
     - The bank manager hands Narrator his paper-route jar back plus a lollipop; Narrator slides his red sunglasses back onto his collar and walks out whistling.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Miles, 14):** Protagonist | Skin `#6F4E37` | R6 Outfit: Yellow Letterman Tee (`#F4A261`), Blue Jeans (`#264653`), Short Locs Hair (`#1B1B1B`) | Emotion Swaps: `shocked` (0–13.5s) → `scared` (13.5–39s) → `determined` (39–48s) → `proud` (48–56s).
  - **Deputy Cole (34):** Corrupt Officer | Skin `#F1C27D` | R6 Outfit: Tan Sheriff Shirt (`#B5838D` / `#A98467`), Dark Brown Slacks (`#4A3525`), Sheriff Hat (`#6C584C`) | Emotion Swaps: `determined` (13.5–44s) → `shocked` (44–49s) → `neutral` (49–56s).
  - **Bank Manager (Ms. Chen, 46):** Witness | Skin `#F5CBA7` | R6 Outfit: Navy Blazer (`#1D3557`), Gray Skirt (`#6C757D`), Straight Black Bob (`#1B1B1B`) | Emotion Swaps: `neutral` (0–48s) → `proud` (48–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Silver Memory Pen:** `0.2 x 1.2 x 0.2` studs | `Metal` + `Neon` tip | `#E5E5E5` / `#00F5D4` | Socket: `RightHand` (Deputy Cole).
  - **Polarized Red Sunglasses:** `1.2 x 0.4 x 0.4` studs | `Glass` + `SmoothPlastic` | `#D62828` | Socket: `UpperTorso` collar → `Head` (Miles).
  - **Brass Mirror Compact:** `0.8 x 0.8 x 0.2` studs | `Metal` + `Glass` | `#FFB703` | Socket: `Workspace` (Teller desk) → `LeftHand` (Miles).
  - **Cash Vault Bags (x3):** `1.5 x 1.8 x 1.0` studs | `Fabric` | `#40916C` | Socket: `LeftHand` (Cole) → `Workspace` floor.
  - **Thermal Receipt Roll:** `1.0 x 0.2 x 2.0` studs | `SmoothPlastic` | `#FFFFFF` | Socket: `Workspace` (Teller counter).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *First Oakridge Bank Lobby* — Polished `Marble` floor (`#F8F9FA`), `Wood` teller counter (`#6F4E37`) with `Glass` partitions, `DiamondPlate` open vault door (`#495057`).
  - **Lighting:** `ClockTime = 15.0`, crisp overhead `SurfaceLight` (`#FFFFFF`) that washes out briefly during each `Neon` cyan flash burst (`#00F5D4`).
  - **VFX/SFX Cues:** Full-frame cyan flash vignette (0.15s) on pen click, mirror bounce ray-beam; *CLICK-FLASH*, *ZAP-DING*, *THUD*.

---

### Story 056: The Laser-Pointer Eyes (*Cyclops* Twist)

- **Header:**
  - **Story ID & Title:** Story 056 — The Laser-Pointer Eyes
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `urgent_teen`
  - **Unstated Human Meaning:** Controlling dangerous power takes twice as much courage as unleashing it.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, taking off my red sunglasses shoots laser beams that melt solid steel—so I duct-taped them to my face until a crane collapsed on my best friend!"`
     - **Frame 1 Visual:** Tight close-up of Narrator's face with silver duct tape strapped across thick ruby-red goggles as glowing crimson light leaks from the side vents, reflected in a fallen steel crane behind him.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** In fourth grade, Narrator sneezed his glasses off during art class and accidentally sliced the school flagpole cleanly into three glowing hot-dog segments.
     - **Town Adaptation:** The fire chief issued Narrator shatterproof ruby-quartz goggles, and Narrator wrapped silver duct tape around both ear-straps so they could never slip off by accident.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (Silver Duct Tape):* `0.3`-stud wide silver tape strips binding the red goggles to Narrator's temples.
       2. *Clue 2 (The 4-Inch Steel I-Beam):* A `14.0 x 1.5 x 1.5` stud rusted crane girder pinning his friend Sam's bike across the alley.
       3. *Clue 3 (The Welder's Dark Mask):* A `1.4 x 1.6 x 1.0` stud black welding visor lying beside a construction toolbox.
  3. **13.5–21s Personal Trap & Crisis:**
     - A rusted construction crane cable snaps above the alley shortcut, dropping a `14`-foot steel I-beam right onto Sam's backpack and pinning his ankle beside a leaking propane tank.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Two-Man Lift):** Narrator and a passing baker heave under the steel girder—*GRUNT! THUD!*—the I-beam weighs two tons and doesn't budge a single stud.
     - **Clue 2 Fail (The Toolbox Jack):** Narrator cranks a small `1.2 x 0.8 x 0.8` stud car jack under the beam—*CREAK! PING!*—the jack bolt strips and shoots sideways into the brick wall.
     - **Clue 3 Fail (The Tape-Gap Peek):** Narrator tries peeling just one corner of the red lens to melt a tiny notch—*ZZZZT! WHOOSH!*—the unfocused slit beam ricochets wildly off a hubcap, nearly singeing Sam's shoe.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator grabs the black welder's mask, slams it over Sam's face to shield his eyes, wraps his own left hand in a thick leather glove to form a narrow aiming tube, and rips the duct tape + red goggles clean off—*RIP! BWOOOOM!*—firing two razor-straight crimson beams through his gloved fingers that slice the steel I-beam cleanly in half in `1.5` seconds without touching the propane tank, letting Sam roll free before the glowing halves cool.
  6. **51–56s Action Echo Punchline:**
     - Sam lifts the welder's mask with soot on his nose and flashes a thumbs-up; Narrator snaps a fresh strip of duct tape over his red goggles and helps Sam carry his bent bike frame home.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Noah, 15):** Protagonist | Skin `#E0AC69` | R6 Outfit: Gray Flannel Shirt (`#6C757D`), Black Jeans (`#212529`), Spiky Dark Brown Hair (`#3D2B1F`) | Emotion Swaps: `scared` (0–21s) → `determined` (21–48s) → `proud` (48–56s).
  - **Sam (15):** Best Friend | Skin `#F5CBA7` | R6 Outfit: Green Skate Hoodie (`#2D6A4F`), Tan Cargo Shorts (`#D4A373`), Blonde Beanie (`#FFB703`) | Emotion Swaps: `scared` (13.5–47s) → `grin` (47–56s).
  - **Baker (Mrs. Holt, 54):** Helper | Skin `#8D5524` | R6 Outfit: White Chef Coat (`#F8F9FA`), Checkered Pants (`#495057`), White Hairnet (`#E9ECEF`) | Emotion Swaps: `determined` (21–28s) → `shocked` (39–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Ruby-Quartz Goggles + Duct Tape:** `1.3 x 0.5 x 0.6` studs | `Neon` / `Metal` tape | `#D90429` + `#CED4DA` | Socket: `Head` (Noah) → `RightHand`.
  - **Steel Crane I-Beam:** `14.0 x 1.5 x 1.5` studs | `CorrodedMetal` | `#6C757D` | Socket: `Workspace` (Alleyway).
  - **Welder's Visor Mask:** `1.4 x 1.6 x 1.0` studs | `SmoothPlastic` + `Glass` | `#1D1D1D` | Socket: `Workspace` → `Head` (Sam).
  - **Crimson Laser Beams (x2):** `0.25 x 0.25 x 18.0` studs | `Neon` | `#FF002B` | Socket: `Head` eyes forward ray.
  - **Propane Tank:** `1.6 x 2.6 x 1.6` studs | `Metal` | `#E9ECEF` | Socket: `Workspace` (Alley corner).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Brick Service Alley* — Wet `Cobblestone` ground (`#495057`), `Brick` walls (`#7F4F24`) with metal fire escapes, yellow crane wreckage, orange safety cones.
  - **Lighting:** `ClockTime = 17.4` dusk orange (`#F4A261`), dramatic crimson `PointLight` (`#FF002B`) flaring across brick walls during the beam cut.
  - **VFX/SFX Cues:** Molten orange slag `ParticleEmitter` at beam contact point, glowing cut edges on steel beam; *RIP*, *BWOOOOM*, *ZZZZT*, *CLANG*.

---

### Story 057: The Teleport-Photo (*Jumper* Twist)

- **Header:**
  - **Story ID & Title:** Story 057 — The Teleport-Photo
  - **Format:** Standalone 50–56s (46 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** Never hand someone the key to your front door—even if it only looks like a piece of paper.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, squeezing any printed Polaroid teleports you straight into that exact room—and the school bully just stole my photo of my grandma's kitchen!"`
     - **Frame 1 Visual:** Close-up of Narrator lunging across a locker hallway as the bully snatches a white-bordered Polaroid showing a cozy checkered kitchen and vanishes in a blue static ripple.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last month, a tourist squeezed a Polaroid of a tropical beach inside the town library—teleporting out in swim trunks and leaving a pile of wet sand on the carpet.
     - **Town Adaptation:** Every camera shop prints `[PRIVATE LOCATION — DO NOT SHARE]` stamps on Polaroid backs, and kids keep their home photos locked inside tin wallets.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Grandma's Kitchen Polaroid):* A `0.9 x 1.1 x 0.05` stud printed photo showing Grandma's blue stove and cookie jar.
       2. *Clue 2 (The Half-Peeling School Bus Photo):* A crumpled `0.9 x 1.1 x 0.05` stud Polaroid of School Bus #12 parked by the curb.
       3. *Clue 3 (The Tin Wallet Pocket):* A `1.0 x 0.7 x 0.2` stud hinged silver tin tucked inside Narrator's front jeans pocket.
  3. **13.5–21s Personal Trap & Crisis:**
     - The bully teleports straight into Grandma's empty kitchen, locks the deadbolt from inside, and starts rummaging for Grandma's emergency cookie-jar rent envelope while Narrator is stuck three miles away at school.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Hallway Sprint):** Narrator bolts out the school doors toward the highway—*THUMP-THUMP!*—at three miles on foot, he'll arrive twenty minutes too late.
     - **Clue 2 Fail (The Bus Photo Jump):** Narrator squeezes his crumpled School Bus #12 Polaroid—*VWOOP!*—teleporting onto the bus steps, only to realize the driver is on lunch break with the keys gone.
     - **Clue 3 Fail (The Phone Screen Tap):** Narrator opens a photo of Grandma's porch on his phone and squeezes the glass—*BZZT!*—digital screens don't trigger the rule; only real ink-printed Polaroids work.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator flips open his silver tin wallet, pulls out a forgotten Polaroid of his own *bedroom closet* right above Grandma's kitchen, squeezes it—*VWOOP!*—lands upstairs, tiptoes down the stairs, and silently slips a Polaroid of the *school detention room* into the bully's back pocket while he's reaching into the cookie jar; Narrator yells *"BOO!"*, the bully instinctively clenches his fists—*VWOOP!*—and teleports himself straight back into Principal Vance's detention room holding an empty cookie jar lid.
  6. **51–56s Action Echo Punchline:**
     - Grandma walks in from the garden holding tomatoes, sees Narrator dusting off the cookie jar, and hands him a warm snickerdoodle; Narrator snaps his silver tin wallet shut.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Owen, 14):** Protagonist | Skin `#F1C27D` | R6 Outfit: Navy Windbreaker (`#1D3557`), Gray Jeans (`#495057`), Brown Side-Part Hair (`#582F0E`) | Emotion Swaps: `shocked` (0–13.5s) → `scared` (13.5–39s) → `determined` (39–49s) → `grin` (49–56s).
  - **Bully (kyle, 15):** Thief | Skin `#E8B896` | R6 Outfit: Black Bomber Jacket (`#212529`), Camo Pants (`#588157`), Buzz Cut (`#2B2D42`) | Emotion Swaps: `grin` (0–21s) → `determined` (21–47s) → `shocked` (47–56s).
  - **Grandma Rose (70):** Homeowner | Skin `#F1C27D` | R6 Outfit: Floral Apron (`#E63946` / `#F8F9FA`), Mint Cardigan (`#84A98C`), Silver Bun Hair (`#E5E5E5`) | Emotion Swaps: `grin` (51–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Kitchen Polaroid:** `0.9 x 1.1 x 0.05` studs | `SmoothPlastic` + white border decal | `#FFFFFF` | Socket: `RightHand` (Kyle).
  - **Detention Room Polaroid:** `0.9 x 1.1 x 0.05` studs | `SmoothPlastic` | `#FFFFFF` | Socket: `UpperTorso` tin → `RightHand` (Owen).
  - **Silver Tin Wallet:** `1.0 x 0.7 x 0.2` studs | `Metal` | `#CED4DA` | Socket: `LeftHand` (Owen).
  - **Ceramic Cookie Jar:** `1.2 x 1.5 x 1.2` studs | `SmoothPlastic` | `#457B9D` | Socket: `Workspace` (Kitchen counter).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Grandma Rose's Cozy Kitchen* — Yellow `WoodPlanks` cabinets (`#E9C46A`), red-and-white checkered `Marble` floor (`#E63946` / `#FFFFFF`), pastel blue fridge (`#A8DADC`).
  - **Secondary Set:** *Oakridge High Hallway & Detention Room* — Blue `Metal` lockers (`#2B4C7E`), cinderblock walls (`#ADB5BD`), chalkboard.
  - **Lighting:** `ClockTime = 16.0`, warm afternoon window rays (`#FFD166`) in the kitchen vs. cool fluorescent (`#E9ECEF`) in detention.
  - **VFX/SFX Cues:** Cyan-white static warp swirl (`ParticleEmitter`) on every jump; *VWOOP!*, *BZZT*, *BOO!*, *CLINK*.

---

### Story 058: The Weather-Mood Kid (*Storm* Twist)

- **Header:**
  - **Story ID & Title:** Story 058 — The Weather-Mood Kid
  - **Format:** Standalone 50–56s (44 beats)
  - **Voice Preset:** `viral_storyteller`
  - **Unstated Human Meaning:** Forcing a fake smile only hides the storm until someone gives you a real reason to breathe.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, whatever emotion I feel controls the sky above our heads—and I have to fake-smile through my hardest math final or the whole school gets hit by a hurricane!"`
     - **Frame 1 Visual:** Split-level classroom window shot of Narrator sweating through a rigid toothy `grin` at his desk while massive pitch-black storm clouds swirl violently right outside the glass.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** When Narrator lost his spelling bee in fifth grade, one sad tear spawned a `10`-minute indoor hailstorm that froze the principal's prized koi pond solid.
     - **Town Adaptation:** The town weather app now displays `[NATE'S MOOD FORECAST]` alongside the temperature, and teachers hand him smiley-face stress balls before every pop quiz.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Blank Math Final):* A `1.2 x 0.1 x 1.5` stud exam packet stamped `[40% OF FINAL GRADE]` in red ink.
       2. *Clue 2 (The Yellow Stress Ball):* A `0.6 x 0.6 x 0.6` stud foam smiley sphere squeezing tightly in Narrator's left hand.
       3. *Clue 3 (The Tin Lunchbox Note):* A folded blue sticky note tucked under Narrator's pencil case by his best friend Leo.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator flips to Question #12—a brutal multi-page algebra proof he forgot to study—and his panic spikes so fast that gale-force winds start rattling the classroom shutters while lightning forks over the parking lot.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Forced Fake-Smile):** Narrator stretches his cheeks into a wider plastic `grin`—*RUMBLE-CRACK!*—the sky senses the lie underneath, snapping a tree branch right against the windowpane.
     - **Clue 2 Fail (The Stress Ball Crush):** Narrator squeezes the yellow smiley ball until his knuckles turn white—*POP-TEAR!*—the foam splits in half and rain begins pouring sideways.
     - **Clue 3 Fail (The Desk-Slump Breath):** Narrator buries his face in his arms to block out the room—*WHOOOOSH!*—a funnel cloud forms above the football field, tripping the tornado siren.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator stops fighting the fake smile, unfolds Leo's blue sticky note under his pencil case—reading *"Doesn't matter what you score, pizza's on me at 3"*—and bursts into a real, loud belly laugh at how ridiculous the `[NATE'S MOOD FORECAST]` sign looks outside; *POOF-CHIME!*—genuine laughter shatters the hurricane wall instantly, parting the black clouds into warm golden sunshine and a bright double rainbow over the football field.
  6. **51–56s Action Echo Punchline:**
     - Narrator scribbles his best honest guess on Question #12, hands the test in calmly, and walks out into the warm sun to split a pepperoni slice with Leo.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Nate, 15):** Protagonist | Skin `#D4A373` | R6 Outfit: Mustard Crewneck (`#E9C46A`), Dark Jeans (`#264653`), Curly Black Hair (`#1B1B1B`) | Emotion Swaps: `grin` (forced, 0–21s) → `scared` (21–39s) → `shocked` (39–44s) → `proud` (44–56s).
  - **Leo (15):** Best Friend | Skin `#E8B896` | R6 Outfit: Teal Hoodie (`#2A9D8F`), Khaki Pants (`#D4A373`), Red Cap (`#E63946`) | Emotion Swaps: `neutral` (0–39s) → `grin` (44–56s).
  - **Mr. Brooks (48):** Math Teacher | Skin `#6F4E37` | R6 Outfit: White Dress Shirt & Tie (`#F8F9FA` / `#1D3557`), Gray Slacks (`#495057`), Glasses + Gray Hair (`#ADB5BD`) | Emotion Swaps: `scared` (13.5–44s) → `shocked` (44–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Math Final Packet:** `1.2 x 0.1 x 1.5` studs | `SmoothPlastic` | `#FFFFFF` with `#D62828` stamp | Socket: `Workspace` (Nate's desk).
  - **Yellow Smiley Stress Ball:** `0.6 x 0.6 x 0.6` studs | `Fabric` | `#FFD166` | Socket: `LeftHand` (Nate).
  - **Blue Sticky Note:** `0.5 x 0.05 x 0.5` studs | `SmoothPlastic` | `#90E0EF` | Socket: `Workspace` → `RightHand` (Nate).
  - **Mood Forecast Billboard:** `8.0 x 4.0 x 0.5` studs | `Neon` SurfaceGui | `#1D3557` | Socket: `Workspace` (School lawn).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Room 204 Math Classroom* — `WoodPlanks` desks (`#8B5A2B`), green `Slate` chalkboard (`#2D6A4F`), tall `Glass` windows overlooking the football field (`Grass` `#52B788`).
  - **Lighting:** Dynamic shift from `ClockTime = 14.0` dark storm (`Ambient #2B2D42`, `FogEnd = 90`, lightning flashes) to `ClockTime = 16.8` golden hour (`#FFB703`) + rainbow arc.
  - **VFX/SFX Cues:** Rain `ParticleEmitter`, lightning bolt beams, rainbow `Neon` arch; *RUMBLE-CRACK*, *POP-TEAR*, *WHOOOOSH*, *POOF-CHIME*.

---

### Story 059: The Healing-Tear Vial (*Tangled* Twist)

- **Header:**
  - **Story ID & Title:** Story 059 — The Healing-Tear Vial
  - **Format:** Standalone 50–56s (46 beats)
  - **Voice Preset:** `urgent_teen`
  - **Unstated Human Meaning:** You can't force genuine feeling out of someone—even when you lock them in a room to try.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, one single tear from my eyes heals any broken bone instantly—and a greedy hospital boss just locked me in a room until I cry into his jar!"`
     - **Frame 1 Visual:** Dramatic low-angle shot of Narrator sitting on a white clinic stool while a sharp-suited Director holds an empty `0.6 x 1.2 x 0.6` stud glass vial inches from Narrator's eye.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last summer, Narrator stubbed his toe on a curb, dropped one tiny tear onto a stray pigeon's broken wing—and the bird instantly did three victory flips and stole his sandwich.
     - **Town Adaptation:** The clinic director installed a secret `[MIRACLE SERUM]` price board at `$10,000` per drop and tricked Narrator into coming in for a "routine checkup."
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Empty Glass Vial):* A `0.6 x 1.2 x 0.6` stud corked vial labeled `$$$` in black marker.
       2. *Clue 2 (The Best Friend Outside the Glass):* Narrator's best friend Mia sitting in the hallway with a bright neon-green cast on her left wrist.
       3. *Clue 3 (The Clown-Horn Rubber Chicken):* A `1.4 x 0.5 x 0.4` stud bright yellow rubber chicken sticking out of Mia's backpack outside the door.
  3. **13.5–21s Personal Trap & Crisis:**
     - Director locks the heavy frosted-glass clinic door and refuses to let Mia see a regular doctor for her fractured wrist unless Narrator fills the `$$$` vial first.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Raw Onion Slice):** Director waves a cut white onion under Narrator's nose—*SNIFF! BLINK!*—Narrator's eyes turn red, but reflex onion water turns gray and fizzles uselessly without healing power.
     - **Clue 2 Fail (The Sad Movie Tablet):** Director plays a sad puppy video at max volume—*WHIRR! CLICK!*—Narrator knows it's a trap, crosses his arms, and stays dry-eyed.
     - **Clue 3 Fail (The Pinch Threat):** Director threatens to double Mia's wait time—*GRRR!*—Narrator gets angry instead of sad, drying his eyes completely.
  5. **39–51s Genius Rule-Hack Climax:**
     - Mia presses her face against the hallway door window, yanks out the bright yellow rubber chicken, and squeezes it with both feet while making ridiculous cross-eyed faces—*BWAAAK-HONK!*—Narrator explodes laughing so hard that two real, glowing gold *happy tears* roll down his cheeks; Narrator grabs a clean cotton swab instead of the greedy vial, unlocks the latch from inside, and dabs one glowing drop straight onto Mia's green cast—*SHING-SPARKLE!*—her wrist heals instantly while the Director's `$$$` jar stays bone-dry.
  6. **51–56s Action Echo Punchline:**
     - Mia shakes her healed wrist free of the cast, hands the rubber chicken to the stunned Director, and sprints out the front doors with Narrator laughing behind her.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Sam, 14):** Protagonist | Skin `#F1C27D` | R6 Outfit: Blue Denim Jacket (`#3D5A80`), White Tee (`#FFFFFF`), Dark Brown Tousled Hair (`#4A3525`) | Emotion Swaps: `scared` (0–21s) → `determined` (21–39s) → `grin` (39–51s) → `proud` (51–56s).
  - **Director Pierce (49):** Greedy Boss | Skin `#E8B896` | R6 Outfit: Charcoal Pinstripe Suit (`#2B2D42`), Red Tie (`#D62828`), Slicked Silver Hair (`#ADB5BD`) | Emotion Swaps: `grin` (0–21s) → `determined` (21–39s) → `shocked` (39–56s).
  - **Mia (14):** Best Friend | Skin `#8D5524` | R6 Outfit: Purple Hoodie (`#7209B7`), Black Leggings (`#1D1D1D`), Braided Space Buns (`#1B1B1B`) | Emotion Swaps: `scared` (13.5–39s) → `grin` (39–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Glass `$$$` Vial:** `0.6 x 1.2 x 0.6` studs | `Glass` + `Wood` cork | `#E9ECEF` | Socket: `RightHand` (Director Pierce).
  - **Neon-Green Wrist Cast:** `0.9 x 1.1 x 0.9` studs | `Fabric` | `#38B000` | Socket: `LeftLowerArm` (Mia).
  - **Yellow Rubber Chicken:** `1.4 x 0.5 x 0.4` studs | `SmoothPlastic` | `#FFD166` | Socket: `RightHand` (Mia).
  - **Cut White Onion:** `0.6 x 0.6 x 0.6` studs | `SmoothPlastic` | `#F8F9FA` | Socket: `LeftHand` (Director Pierce).
  - **Glowing Gold Tear Drops:** `0.2 x 0.3 x 0.2` studs | `Neon` | `#FFD700` | Socket: `Head` cheek → `LeftLowerArm` (Mia).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Oakridge Private Clinic Exam Room* — Sterile white `Marble` tiles (`#F8F9FA`), stainless `Metal` exam table (`#CED4DA`), frosted `Glass` corridor door (`#E0FBFC`).
  - **Lighting:** `ClockTime = 15.0`, crisp clinical `SurfaceLight` (`#FFFFFF`), warm gold `PointLight` (`#FFD700`) flaring when the happy tear heals the cast.
  - **VFX/SFX Cues:** Gold `ParticleEmitter` burst on wrist heal, red/gray fizzle puff on onion; *BWAAAK-HONK*, *SHING-SPARKLE*, *SNIFF*.

---

### Story 060: The Retired Villain's Bakery (*Despicable Me / Megamind* Twist)

- **Header:**
  - **Story ID & Title:** Story 060 — The Retired Villain's Bakery
  - **Format:** Standalone 50–56s (47 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** Sometimes the scariest workshop in town is just hiding the gentlest reason to stay up late.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, the scary retired supervillain runs a midnight bakery with a laser-locked vault underneath—and my little brother just snuck inside expecting a bomb!"`
     - **Frame 1 Visual:** Moody alley shot of a towering 7-foot retired villain in a flour-dusted black trenchcoat locking a heavy steel cellar door glowing with faint red laser slits.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Ten years ago, "Dr. Frostbite" froze the town fountain into a 30-foot ice statue before vanishing and buying the corner bakery on Maple Street.
     - **Town Adaptation:** Kids dare each other to knock on his shuttered window after `9:00 PM`, whispering that the humming cellar machinery is a new freeze-ray doomsday device.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Flour-Dusted Keycard):* A `0.5 x 0.3 x 0.05` stud black magnetic card hanging from the baker's apron pocket.
       2. *Clue 2 (The Red Laser Tripwires):* Three `0.1`-stud glowing red beams crisscrossing the cellar stairs.
       3. *Clue 3 (The Stack of Cardboard Boxes):* `2.0 x 2.0 x 1.2` stud white boxes labeled with small foster-home street addresses.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator's 9-year-old brother Max slips through the bakery coal chute to "be a hero," tripping a silent motion sensor that seals the steel cellar hatch behind him as heavy footsteps stomp down the stairs.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Coal-Chute Pull):** Narrator tugs the outside iron coal hatch with both hands—*CLANG! SCRAPE!*—the magnetic deadbolt holds fast from inside.
     - **Clue 2 Fail (The Window-Peek Distraction):** Narrator bangs a trash lid on the alley dumpster—*BOOM! RATTLE!*—the villain doesn't come up; the cellar hums even louder.
     - **Clue 3 Fail (The Lockpick Wire):** Narrator jams a bent wire into the side keypad—*BZZT! ERR!*—a red `[LOCKED]` flash sparks and resets the panel.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator spots the unlocked flour-chute delivery hatch, slides down into the cellar—*WHOOSH-POOF!*—and dives over the three red laser beams to tackle Max behind a metal table; then the bright kitchen lights flick on—*CLICK!*—and Narrator freezes: the "laser beams" are just thermal sugar-glazing lamps, the "doomsday machine" is a triple-tier frosting mixer, and Dr. Frostbite is carefully piping `[HAPPY 8TH BIRTHDAY!]` onto twelve free cakes boxed for the town foster home.
  6. **51–56s Action Echo Punchline:**
     - Dr. Frostbite clears his throat, hands Max a freshly frosted strawberry cupcake with a tiny lightning-bolt topper, and points silently toward the front door.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Lucas, 14):** Protagonist | Skin `#E0AC69` | R6 Outfit: Red Flannel Shirt (`#C1121F`), Dark Jeans (`#212529`), Messy Black Hair (`#1B1B1B`) | Emotion Swaps: `scared` (0–39s) → `determined` (39–44s) → `shocked` (44–50s) → `grin` (50–56s).
  - **Max (9):** Younger Brother | Skin `#E0AC69` | R6 Outfit: Blue Striped Hoodie (`#219EBC`), Khaki Shorts (`#D4A373`), Cap (`#FFB703`) | Emotion Swaps: `determined` (13.5–21s) → `scared` (21–44s) → `grin` (44–56s).
  - **Dr. Frostbite / Mr. Victor (58):** Retired Villain Baker | Skin `#EAEAEA` (pale) | R6 Outfit: Black Trenchcoat (`#1D1D1D`) + Flour-Dusted White Apron (`#F8F9FA`), Black Boots (`#111111`), Tall Silver Pompadour (`#CED4DA`) | Emotion Swaps: `determined` (0–44s) → `neutral` (44–51s) → `proud` (51–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Red Glazing Laser Beams (x3):** `0.1 x 0.1 x 8.0` studs | `Neon` | `#FF0033` | Socket: `Workspace` (Cellar stairs).
  - **Triple-Tier Frosting Mixer:** `4.0 x 5.0 x 3.5` studs | `Metal` | `#ADB5BD` + `#FF758F` pink icing bowl | Socket: `Workspace` (Cellar center).
  - **Birthday Cake Boxes (x12):** `2.0 x 2.0 x 1.2` studs | `SmoothPlastic` | `#FFFFFF` with `#FF758F` ribbon | Socket: `Workspace` (Bakery rack).
  - **Strawberry Cupcake:** `0.6 x 0.8 x 0.6` studs | `SmoothPlastic` | `#FF758F` + `#FFD166` topper | Socket: `RightHand` (Victor → Max).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Victor's Midnight Bakery Cellar* — Dark `Slate` stone walls (`#343A40`) transforming into warm `WoodPlanks` bakery shelves (`#8B5A2B`), stainless steel prep tables, colorful frosting vats.
  - **Secondary Set:** *Maple Street Alley (0–21s)* — Wet `Cobblestone` (`#2B2D42`), iron coal chute, glowing red cellar vent.
  - **Lighting:** `ClockTime = 23.5` midnight blue outside (`#1D3557`), shifting from ominous red laser glow (`#FF0033`) to warm golden bakery `PointLight` (`#FFE5B4`) at 44s.
  - **VFX/SFX Cues:** Flour dust `ParticleEmitter` burst on chute slide, warm oven steam; *CLANG*, *BZZT*, *WHOOSH-POOF*, *CLICK!*.

---

## Category 4: Dark Horror Hook → Wholesome 180° Flip (Stories 061–075)

### Story 061: The 6-PM Porch Bell *(Original)*

- **Header:**
  - **Story ID & Title:** Story 061 — The 6-PM Porch Bell
  - **Format:** Standalone 50–56s (48 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** Fear turns a silent neighbor into a monster until you finally open the door.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, at exactly 6 PM, a seven-foot masked figure rings every porch bell and drops a heavy black crate—and tonight a blizzard just knocked out our power with a newborn inside!"`
     - **Frame 1 Visual:** Low-angle snowy porch shot at dusk: a towering silhouette in a dark wool mask and soot-stained coat pressing a brass doorbell, leaving a `2.4 x 1.6 x 1.4` stud matte-black crate on the icy welcome mat.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last autumn, a brave teenager kicked one of the 6-PM black crates off his steps—and when a neighbor heard a faint ticking hum inside, the whole block panicked and called the bomb squad.
     - **Town Adaptation:** Every family bolts iron storm shutters shut at `5:55 PM` sharp, bans anyone from touching the porch crates until daylight, and drags them straight to the curb dumpster.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Brass Porch Bell):* A `0.5 x 0.5 x 0.3` stud tarnished brass doorbell button beside the oak front door.
       2. *Clue 2 (The Matte-Black Crate):* A `2.4 x 1.6 x 1.4` stud heavy black case with recessed brass latches and faint warm steam rising from a side vent.
       3. *Clue 3 (The Faded Fire-Helmet Tag):* A tiny `0.4 x 0.3 x 0.1` stud Maltese cross pin glinting on the masked figure's coat lapel.
  3. **13.5–21s Personal Trap & Crisis:**
     - A brutal January blizzard snaps the town power lines at `5:58 PM`, plunging Narrator's house into `18°F` darkness while his 3-week-old baby brother Leo shivers under three blankets and the last bottle of formula runs cold.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Fireplace Match):** Narrator strikes three damp matches at the stone hearth—*SCRAPE-FIZZ!*—the chimney flue is frozen shut with ice, blowing freezing smoke back into the nursery.
     - **Clue 2 Fail (The Phone Flashlight & 911):** Narrator dials emergency services—*BEEP-BEEP-ERR!*—the storm tower is dead and his battery drops to `1%`.
     - **Clue 3 Fail (The Neighbor Window Knock):** Narrator bangs on the frozen living-room shutter toward next door—*THUD! THUD!*—nobody answers behind the bolted iron slats.
  5. **39–51s Genius Rule-Hack Climax:**
     - At `6:00 PM` sharp—*DING-DONG!*—heavy boots crunch off the porch; Narrator ignores every town rule, unbolts the deadbolt, and yanks the front door wide open—*CREAK-WHOOSH!*—dragging the heavy black crate inside and snapping the brass latches open: instead of a trap, a glowing orange `Neon` solar-battery space heater hums to life alongside sealed cans of warm baby formula and a laminated card stamped `[CHIEF MILLER — RETIRED, VOCAL CORDS INJURED IN '18 FIRE]`; looking down the snowy street, the tall masked figure pauses under a streetlamp, sees the nursery window glow warm orange, and gives a quiet two-finger salute.
  6. **51–56s Action Echo Punchline:**
     - Narrator wraps baby Leo beside the humming solar heater, runs back to the porch, and hangs a bright yellow sticky note on the doorbell reading *"THANK YOU, CHIEF."*

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Maya, 15):** Protagonist | Skin `#D4A373` | R6 Outfit: Thick Cream Knit Sweater (`#FEFAE0`), Navy Jeans (`#1D3557`), Dark Brown Ponytail (`#3D2B1F`) | Emotion Swaps: `scared` (0–39s) → `determined` (39–44s) → `shocked` (44–49s) → `proud` (49–56s).
  - **Chief Miller (62):** Masked Retired Fire Chief | Skin `#C68B59` | R6 Outfit: Tall Black Fire-Coat (`#1D1D1D`) with reflective yellow stripe (`#FFD166`), Black Knit Face Mask (`#2B2D42`), Steel-Gray Crew Hair (`#ADB5BD`) | Emotion Swaps: `neutral` (mask on, 0–48s) → `proud` (visible eyes/salute, 48–56s).
  - **Baby Leo (Newborn):** Sibling | Skin `#E8B896` | R6 Outfit: Blue Swaddle Bundle (`#90E0EF`) | Emotion Swaps: `scared` (13.5–46s) → `grin` (46–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Matte-Black Crate:** `2.4 x 1.6 x 1.4` studs | `Metal` | `#1B1B1B` with `#FFB703` latches | Socket: `Workspace` (Porch mat → Living room).
  - **Solar Space Heater:** `1.4 x 1.2 x 0.8` studs | `Metal` + `Neon` grill | `#FF6B00` | Socket: `Workspace` (inside opened crate).
  - **Formula Cans (x4):** `0.5 x 0.7 x 0.5` studs | `Metal` | `#FFFFFF` with `#219EBC` label | Socket: `Workspace` (inside crate).
  - **Laminated Chief Card:** `0.8 x 0.5 x 0.05` studs | `SmoothPlastic` | `#F8F9FA` | Socket: `RightHand` (Maya).
  - **Yellow Thank-You Note:** `0.6 x 0.6 x 0.05` studs | `SmoothPlastic` | `#FFD166` | Socket: `Workspace` (Doorbell frame).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Snowy Suburban Porch & Living Room* — Frost-covered `WoodPlanks` porch (`#582F0E`), bolted `Metal` storm shutters (`#495057`), `Snow` terrain drifts (`#F8F9FA`), stone fireplace inside (`Slate` `#6C757D`).
  - **Lighting:** `ClockTime = 18.0`, freezing twilight blue (`Ambient #1D3557`, `FogEnd = 75`, blizzard snow `ParticleEmitter`), shifting to warm amber `PointLight` (`#FF8800`) spilling from the opened heater.
  - **VFX/SFX Cues:** Blizzard wind gusts, warm orange heater glow, breath mist particles; *DING-DONG!*, *SCRAPE-FIZZ*, *CREAK-WHOOSH*, *HUMMM*.

---

### Story 062: The Mirror-Tape Town

- **Header:**
  - **Story ID & Title:** Story 062 — The Mirror-Tape Town
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** Sometimes the shadows we tape over are the only ones still trying to check in on us.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, every single mirror must be taped shut with black X's before 6 PM—or the shadow standing inside the glass starts tapping back!"`
     - **Frame 1 Visual:** Dimly lit bathroom shot at `5:59 PM`: Narrator presses the last strip of black duct tape across a tall vanity mirror just as a faint glowing silhouette raises one hand behind the frosted glass.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last Halloween, a new kid peeled the tape off his hallway mirror at `6:05 PM` and screamed so loud at the tall shadow waving inside that he jumped straight through his ground-floor hedge.
     - **Town Adaptation:** Hardware stores sell `[6-PM MIRROR TAPE]` by the crate, and the town curfew siren blares every evening at `5:55 PM` so nobody catches a reflection.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (Black Mirror Tape):* `0.3`-stud wide matte-black tape strips forming a heavy `X` across the bedroom mirror.
       2. *Clue 2 (Grandpa's Brass Pocket Watch):* A `0.5 x 0.5 x 0.2` stud engraved watch with a cracked glass face on Narrator's nightstand.
       3. *Clue 3 (The Faint Chalk-Dust Handprint):* A soft glowing white hand-shape visible only at the untaped bottom corner of the glass.
  3. **13.5–21s Personal Trap & Crisis:**
     - During a lonely midnight thunderstorm, Narrator accidentally knocks his dresser into the mirror, ripping one whole black tape strip loose right as the power goes out and a tall shadow steps forward inside the glass.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Blanket Throw):** Narrator hurls his thick quilt over the mirror frame—*WHOOSH-SLIP!*—the quilt slides straight off the smooth oak trim, leaving the glass exposed.
     - **Clue 2 Fail (The Pillow Shield):** Narrator backs into the corner clutching a pillow over his eyes—*TAP-TAP-TAP!*—three gentle rhythmic knocks echo directly from the glass.
     - **Clue 3 Fail (The Tape-Roll Fumble):** Narrator scrambles for his spare black tape roll—*SKITTER-ROLL!*—the roll bounces under the bed out of reach as the shadow raises both hands.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator grabs Grandpa's brass pocket watch off the nightstand, shines his flashlight toward the mirror, and realizes the shadow isn't lunging—it's tapping the exact 3-beat bedtime knock Grandpa used to do on Narrator's bedroom door; Narrator tears the *second* black tape strip completely off—*RIP!*—revealing a soft, warm golden silhouette wearing Grandpa's old fishing hat, smiling and waving goodnight before fading peacefully into starlight.
  6. **51–56s Action Echo Punchline:**
     - Narrator sets Grandpa's pocket watch gently on the mirror ledge, smiles, taps the glass three times back, and climbs into bed with the mirror uncovered.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Evan, 13):** Protagonist | Skin `#F5CBA7` | R6 Outfit: Gray Pajama Tee (`#6C757D`), Navy Plaid Pants (`#1D3557`), Messy Chestnut Hair (`#6F4E37`) | Emotion Swaps: `scared` (0–39s) → `shocked` (39–47s) → `proud` (47–56s).
  - **Grandpa Shadow (74):** Passed-Away Loved One | Skin `#FFE5B4` (translucent golden glow) | R6 Outfit: Tan Fishing Vest (`#D4A373`), Bucket Hat (`#A98467`), White Mustache (`#F8F9FA`) | Emotion Swaps: `neutral` (0–44s) → `grin` (44–51s).

- **Props & Sockets (Sound-Off Visible):**
  - **Tall Oak Vanity Mirror:** `4.0 x 6.0 x 0.4` studs | `Wood` frame + `Glass` | `#582F0E` / `#A8DADC` | Socket: `Workspace` (Bedroom wall).
  - **Black Mirror Tape (`X`):** `0.3 x 5.2 x 0.05` studs | `SmoothPlastic` | `#1B1B1B` | Socket: `Workspace` (Mirror surface).
  - **Brass Pocket Watch:** `0.5 x 0.5 x 0.2` studs | `Metal` | `#FFB703` | Socket: `Workspace` (Nightstand) → `RightHand` (Evan).
  - **Flashlight:** `0.4 x 1.2 x 0.4` studs | `Metal` + `SpotLight` | `#2B2D42` | Socket: `LeftHand` (Evan).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Evan's Attic Bedroom* — Sloped `WoodPlanks` ceiling (`#6F4E37`), woven rug (`Fabric` `#457B9D`), oak nightstand, tall wall mirror.
  - **Lighting:** `ClockTime = 23.8`, cool stormy moonlight (`#1D3557`), shifting to soft warm gold `PointLight` (`#FFD166`) radiating from inside the mirror at 44s.
  - **VFX/SFX Cues:** Soft golden starlight `ParticleEmitter` inside the mirror glass; *TAP-TAP-TAP*, *RIP!*, *CHIME*.

---

### Story 063: The Midnight Bus Driver

- **Header:**
  - **Story ID & Title:** Story 063 — The Midnight Bus Driver
  - **Format:** Standalone 50–56s (46 beats)
  - **Voice Preset:** `urgent_teen`
  - **Unstated Human Meaning:** Sometimes the person everyone whispers about at midnight is the only one driving kids toward safety.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, any kid who steps onto Bus #00 at 11:59 PM vanishes from school forever—and I just watched my best friend climb aboard with a packed duffel bag!"`
     - **Frame 1 Visual:** Foggy midnight street corner: glowing amber headlights of a battered black-and-yellow bus (`BUS #00`) open their folding doors as Narrator's friend Chloe steps up into the dark stairwell.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Six months ago, two kids vanished after boarding the `11:59 PM` bus stop by the train tracks, leaving behind only rumors of a silent driver in dark aviators who never speaks a word.
     - **Town Adaptation:** Parents lock bikes at `11:30 PM`, and the school put up `[DO NOT BOARD ROUTE 00]` flyers on every lamppost.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Scuffed Blue Duffel):* A `1.8 x 1.0 x 1.0` stud canvas bag Chloe carried with a torn paper address tag.
       2. *Clue 2 (The Rusty Chain-Link Fence):* The bus depot's `8.0`-stud perimeter fence along Route 9.
       3. *Clue 3 (The Manilla Clipboard):* A `1.0 x 1.3 x 0.1` stud clipboard sitting beside the driver's leather seat stamped `[SAFE HAVEN NETWORK]`.
  3. **13.5–21s Personal Trap & Crisis:**
     - Chloe's house had a shouting blowout; she grabs her duffel bag and boards Bus #00 at `11:59 PM` sharp just as the folding doors hiss shut and the bus pulls out onto the dark highway.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Bicycle Chase):** Narrator pedals furiously after the glowing red taillights—*CREAK-WHIRR!*—the bus hits `45 mph` on the highway ramp and leaves him coughing in exhaust.
     - **Clue 2 Fail (The Crossing Shortcut):** Narrator cuts across the train-track shortcut to intercept the next stop—*DING-CLANG!*—a freight crossing gate drops right in front of his handlebars.
     - **Clue 3 Fail (The Bumper Grab):** When the bus slows at a red light, Narrator leaps onto the rear bumper—*THUD! SKRRT!*—his sneakers slip on wet asphalt as the bus turns toward the state line.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator cuts through the bus depot gate, leaps onto the low loading dock as Bus #00 pulls in for a pit stop, and bursts through the side emergency door—*SLAM!*—ready to fight the silent driver, only to freeze: the interior isn't a dungeon—it's lined with warm fleece blankets, juice boxes, and a framed map of certified foster homes across the state line, while the silent driver hands Chloe a warm thermos and dials her aunt's verified safe-house number on the `[SAFE HAVEN NETWORK]` clipboard.
  6. **51–56s Action Echo Punchline:**
     - Chloe hugs Narrator goodbye through the bus window with a relieved smile; the silent driver tips his cap once and hands Narrator a printed safe-house phone card before rolling onto the highway.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Jordan, 15):** Protagonist | Skin `#8D5524` | R6 Outfit: Orange Windbreaker (`#F77F00`), Black Track Pants (`#212529`), Short Braids (`#1B1B1B`) | Emotion Swaps: `scared` (0–39s) → `determined` (39–44s) → `shocked` (44–50s) → `proud` (50–56s).
  - **Chloe (15):** Best Friend | Skin `#F5CBA7` | R6 Outfit: Oversized Gray Hoodie (`#ADB5BD`), Blue Jeans (`#457B9D`), Blonde Ponytail (`#F4D35E`) | Emotion Swaps: `scared` (0–44s) → `grin` (44–56s).
  - **Bus Driver (Mr. Vance, 56):** Silent Rescuer | Skin `#C68B59` | R6 Outfit: Navy Uniform Coat (`#1D3557`), Dark Aviator Shades (`#111111`), Navy Visor Cap (`#1D3557`) | Emotion Swaps: `neutral` (0–48s) → `proud` (48–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Bus #00 Vehicle:** `24.0 x 8.5 x 9.5` studs | `Metal` + `Glass` | `#212529` / `#FFB703` | Socket: `Workspace` (Highway / Depot).
  - **Blue Duffel Bag:** `1.8 x 1.0 x 1.0` studs | `Fabric` | `#457B9D` | Socket: `LeftHand` (Chloe).
  - **Safe Haven Clipboard:** `1.0 x 1.3 x 0.1` studs | `Wood` + `SmoothPlastic` | `#8B5A2B` / `#FFFFFF` | Socket: `Workspace` (Dashboard) → `RightHand` (Driver).
  - **Fleece Blankets & Thermos:** `1.4 x 0.6 x 1.0` studs / `0.4 x 0.9 x 0.4` studs | `Fabric` / `Metal` | `#E63946` / `#CED4DA` | Socket: `Workspace` (Bus seats).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Foggy Route 9 Bus Stop & Depot* — Wet `Asphalt` road (`#2B2D42`), flickering yellow `StreetLight` poles (`#FFB703`), `Metal` chain-link depot fence (`#6C757D`).
  - **Secondary Set:** *Bus #00 Interior* — Warm `Fabric` bench seats (`#457B9D`), glowing state-line map (`SurfaceGui`), overhead amber dome lights.
  - **Lighting:** `ClockTime = 23.9`, dense `FogEnd = 85` midnight blue (`#0D1B2A`), switching to warm amber cabin `PointLight` (`#FFD166`) inside the bus at 44s.
  - **VFX/SFX Cues:** Headlight volumetric beams, diesel exhaust `ParticleEmitter`; *HISS-CLOSE*, *CREAK-WHIRR*, *DING-CLANG*, *SLAM!*.

---

### Story 064: The Basement Locksmith

- **Header:**
  - **Story ID & Title:** Story 064 — The Basement Locksmith
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `viral_storyteller`
  - **Unstated Human Meaning:** The loudest "keep out" sign in a family home is usually guarding a surprise meant for someone you love.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this house, Grandma bolts three brass padlocks on her basement door every Sunday—and screams at anyone who even touches the handle!"`
     - **Frame 1 Visual:** Low-angle basement stair shot of Grandma (R6, `determined`) snapping a third heavy brass padlock onto a scarred oak door while paint splatters glow faintly on her apron cuffs.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last month, Narrator's cousin tried peeking through the basement mail slot with a broomstick—and Grandma chased him clear across the backyard garden with a rolling pin.
     - **Town Adaptation:** The whole family whispers about "Grandma's Secret Vault," and nobody dares step within five feet of the cellar stairs on Sundays.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (Three Brass Padlocks):* `0.5 x 0.7 x 0.3` stud heavy brass locks chained across the oak cellar door.
       2. *Clue 2 (The Turpentine Smell & Sawdust):* Fine `Wood` shavings and bright teal paint flecks stuck to Grandma's slipper soles.
       3. *Clue 3 (Dad's Faded Childhood Photo):* A framed picture on the hall table showing Dad at age 8 beside a broken backyard treehouse.
  3. **13.5–21s Personal Trap & Crisis:**
     - On Sunday afternoon, muffled *THUD-CRASH!* sounds echo from behind the locked basement door, followed by dead silence—convincing Narrator that Grandma fell down the cellar stairs inside.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Doorbell & Shout):** Narrator pounds on the oak door yelling *"Grandma, open up!"*—*THUMP! THUMP!*—only the hum of a power saw answers from below.
     - **Clue 2 Fail (The Butter-Knife Shim):** Narrator tries slipping a kitchen butter knife into the brass latch—*PING! BEND!*—the thin steel blade twists sideways without budging the triple chain.
     - **Clue 3 Fail (The Crawlspace Window):** Narrator drops to the backyard grass and yanks the frosted basement window—*SCRAPE!*—it's painted shut from the inside with thick dried teal paint.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator spots Grandma's spare brass keyring hanging inside the porch birdhouse, sprints back inside, unlocks all three padlocks in three seconds—*CLACK-CLACK-CLACK!*—and kicks the door open bracing for an accident, only to drop his jaw: Grandma is standing on a stepladder completely fine in paint-splattered goggles, having spent six Sundays hand-building a full-size cedar treehouse kit and painting a `10`-foot birthday mural of Dad's childhood backyard for his 40th birthday tomorrow.
  6. **51–56s Action Echo Punchline:**
     - Grandma squints at Narrator holding the spare key, sighs with a grin, hands him a turquoise paintbrush, and points at the corner of the mural's sky.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Sam, 13):** Protagonist | Skin `#E8B896` | R6 Outfit: Green Henley Shirt (`#52B788`), Dark Shorts (`#2B2D42`), Messy Blonde Hair (`#F4D35E`) | Emotion Swaps: `scared` (0–39s) → `determined` (39–44s) → `shocked` (44–50s) → `grin` (50–56s).
  - **Grandma Clara (68):** Secret Builder | Skin `#E8B896` | R6 Outfit: Denim Work Overalls (`#3D5A80`), Paint-Splattered White Tee (`#F8F9FA`), Silver Glasses + Bun (`#CED4DA`) | Emotion Swaps: `determined` (0–13.5s) → `shocked` (44–49s) → `proud` (49–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Brass Padlocks (x3):** `0.5 x 0.7 x 0.3` studs | `Metal` | `#FFB703` | Socket: `Workspace` (Basement door hasp).
  - **Cedar Treehouse Kit:** `6.0 x 5.0 x 5.0` studs | `WoodPlanks` | `#A98467` | Socket: `Workspace` (Basement center).
  - **Birthday Mural Canvas:** `10.0 x 6.0 x 0.2` studs | `SmoothPlastic` | `#2A9D8F` sky + `#52B788` grass | Socket: `Workspace` (Basement wall).
  - **Turquoise Paintbrush:** `0.2 x 1.1 x 0.2` studs | `Wood` + `Fabric` | `#8B5A2B` / `#00B4D8` | Socket: `RightHand` (Grandma → Sam).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Grandma's Basement Workshop* — `Concrete` floor (`#ADB5BD`) dusted with sawdust, `WoodPlanks` workbenches (`#6F4E37`), colorful paint cans, stepladder, giant mural.
  - **Secondary Set:** *Upper Hallway & Porch (0–39s)* — `WoodPlanks` floor (`#8B5A2B`), floral wallpaper, heavy oak door with triple chain.
  - **Lighting:** `ClockTime = 16.5`, dim hallway shadow (`#495057`) contrasting the bright warm workshop `SurfaceLight` (`#FFE5B4`) inside the cellar.
  - **VFX/SFX Cues:** Sawdust `ParticleEmitter` puffs, paint splatter decals; *THUD-CRASH*, *PING-BEND*, *CLACK-CLACK-CLACK!*.

---

### Story 065: The Graveyard Gardener

- **Header:**
  - **Story ID & Title:** Story 065 — The Graveyard Gardener
  - **Format:** Standalone 50–56s (46 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** Caretaking doesn't stop just because everyone else forgot who's resting there.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, a tall silent man sneaks into the old cemetery every Friday at midnight and digs a fresh six-foot hole—and tonight my bike chain snapped right outside the gate!"`
     - **Frame 1 Visual:** Moonlit iron cemetery gate: a hulking silhouette in mud-caked boots drives a steel shovel into dark earth beside crooked moss-covered headstones.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last month, two older kids dared each other to count the fresh dirt mounds at sunrise—and swore they heard heavy boots dragging a burlap sack behind the chapel.
     - **Town Adaptation:** Nobody walks past Elmwood Cemetery after `8:00 PM`, and the town map literally marks the iron gate with a skull sticker.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Burlap-Wrapped Bundle):* A `3.5 x 1.2 x 1.2` stud tied burlap bundle leaning against the silent man's wheelbarrow.
       2. *Clue 2 (The Crooked Blank Headstones):* Row 9's oldest stone slabs with faded dates (`1890–1912`) and zero flowers.
       3. *Clue 3 (The Galvanized Watering Can):* A `1.4 x 1.2 x 0.9` stud dented metal watering can hanging from the wheelbarrow handle.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator's bicycle chain snaps right against the cemetery curb; as he crouches to fix it, the tall silent man turns his lantern straight onto Narrator and starts striding heavily toward the gate.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Bike Sprint):** Narrator tries hopping on the chainless bike to coast downhill—*CLICK-CLACK!*—the pedals spin free and dump him sideways into the wet ditch.
     - **Clue 2 Fail (The Fence Climb):** Narrator scrambles up the wet iron pickets—*SLIP! THUD!*—muddy sneakers slide off the slick bars back onto the gravel path.
     - **Clue 3 Fail (The Phone Flashlight Strobe):** Narrator flashes his phone light to scare the man off—*BZZT!*—the battery dies immediately, leaving him face-to-face with the towering shadow.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator braces for the worst as the silent man reaches the wheelbarrow, slices the twine off the burlap bundle—*SNIP-RUSTLE!*—and lifts out a young *apple tree sapling* with a brass tag reading *"For Row 9 — So Nobody Visits an Empty Stone"*; stepping closer, Narrator sees twenty blooming peach and apple trees shading the oldest forgotten graves, and the silent man quietly hands Narrator the dented watering can to help pour water around the fresh roots.
  6. **51–56s Action Echo Punchline:**
     - Narrator pours the water over the dark soil, then the silent gardener pulls a wrench from his coat pocket, snaps Narrator's bike chain back onto the sprocket, and nods toward home.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Leo, 14):** Protagonist | Skin `#F1C27D` | R6 Outfit: Blue Denim Jacket (`#3D5A80`), Black Jeans (`#212529`), Messy Brown Hair (`#582F0E`) | Emotion Swaps: `scared` (0–44s) → `shocked` (44–49s) → `proud` (49–56s).
  - **The Gardener (Mr. Silas, 64):** Silent Caretaker | Skin `#C68B59` | R6 Outfit: Olive Canvas Work Coat (`#4A5759`), Muddy Boots (`#3D2B1F`), Thick Gray Beard & Wool Cap (`#ADB5BD` / `#495057`) | Emotion Swaps: `neutral` (0–48s) → `proud` (48–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Steel Shovel:** `4.5 x 1.0 x 0.2` studs | `Metal` + `Wood` | `#6C757D` / `#8B5A2B` | Socket: `RightHand` (Mr. Silas).
  - **Burlap-Wrapped Apple Sapling:** `3.5 x 1.2 x 1.2` studs | `Fabric` + `Wood` + `Grass` leaves | `#A98467` / `#52B788` | Socket: `Workspace` (Wheelbarrow) → `LeftHand` (Silas).
  - **Galvanized Watering Can:** `1.4 x 1.2 x 0.9` studs | `Metal` | `#ADB5BD` | Socket: `RightHand` (Leo).
  - **Brass Lantern:** `0.8 x 1.3 x 0.8` studs | `Metal` + `Neon` | `#FFB703` | Socket: `LeftHand` (Silas).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Elmwood Old Cemetery* — `Grass` turf (`#2D6A4F`), `Slate` crooked headstones (`#6C757D`), black `Metal` iron perimeter fence (`#1D1D1D`), blooming fruit trees (`#FF758F` / `#52B788` blossoms).
  - **Lighting:** `ClockTime = 0.0`, misty silver moonlight (`#8D99AE`, `FogEnd = 110`), warm amber lantern `PointLight` (`#FFB703`) illuminating the blossoms at 44s.
  - **VFX/SFX Cues:** Firefly `ParticleEmitter` around fruit trees, falling blossom petals; *SHHHK-DIG*, *CLICK-CLACK*, *SNIP-RUSTLE*, *SPLASH*.

---

### Story 066: The Red-Light Window

- **Header:**
  - **Story ID & Title:** Story 066 — The Red-Light Window
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** What looks like a warning beacon from the street is sometimes just a quiet way of listening in the dark.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, nobody walks past #44 Elm Street after midnight—because a blinding red bulb flashes in the attic window at 2 AM like an SOS signal!"`
     - **Frame 1 Visual:** Rainy `2:00 AM` suburban street shot: a tall Victorian house with a single attic window pulsing bright crimson (`Neon #FF0033`) while two kids across the street duck behind a hedge.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last summer, a pizza delivery rookie saw the red bulb flashing at `2:00 AM`, dropped two pepperoni boxes on the driveway, and sprinted back to his moped without his helmet.
     - **Town Adaptation:** Kids call it "The Signal House," crossing to the opposite sidewalk even in broad daylight.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Pulsing Red Bulb):* A `0.6 x 0.8 x 0.6` stud crimson strobe bulb screwed into a bedside lamp by the attic glass.
       2. *Clue 2 (The Blue Stroller on the Porch):* A folded `2.2 x 1.8 x 2.0` stud baby stroller tucked quietly behind the porch railing.
       3. *Clue 3 (The Plastic Baby Monitor):* A `0.5 x 0.8 x 0.3` stud white plastic receiver wired directly into the red lamp's power box.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator's golden retriever slips his leash and bolts straight up #44 Elm Street's porch steps right as the attic red bulb begins flashing faster than ever—three quick bursts every second.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Whistle Call):** Narrator whispers and whistles from the sidewalk—*WHEEE-SHH!*—his dog stays glued to the front doormat, sniffing excitedly.
     - **Clue 2 Fail (The Porch TiP-Toe):** Narrator creeps onto the creaky porch steps—*CREAK! THUD!*—his boot clips the folded blue stroller, rattling the metal frame loud enough to wake the whole block.
     - **Clue 3 Fail (The Door-Shadow Freeze):** Heavy footsteps pad toward the inside of the front door—*CLICK-UNLOCK!*—Narrator freezes, bracing for a monster as the deadbolt turns.
  5. **39–51s Genius Rule-Hack Climax:**
     - The front door swings open—revealing a gentle 70-year-old couple wearing cozy bathrobes, smiling warmly while signing *"Shh, baby's sleeping!"* in sign language; Narrator steps two feet inside and sees the truth on the hall table: the pulsing red attic bulb is a visual *deaf-alert baby monitor* wired to flash whenever their newborn grandkid cries upstairs—and the dog was just wagging his tail at the baby's dropped pacifier on the mat.
  6. **51–56s Action Echo Punchline:**
     - The grandfather hands Narrator his dog's leash plus a warm sugar cookie; Narrator signs *"Thank you"* awkwardly back, clips the leash, and walks home smiling as the red bulb blinks gently above.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Maya, 14):** Protagonist | Skin `#F5CBA7` | R6 Outfit: Yellow Raincoat (`#FFD166`), Dark Jeans (`#264653`), Wet Dark Bob (`#1B1B1B`) | Emotion Swaps: `scared` (0–42s) → `shocked` (42–48s) → `grin` (48–56s).
  - **Grandpa Arthur (71):** Deaf Homeowner | Skin `#E8B896` | R6 Outfit: Plaid Flannel Bathrobe (`#457B9D`), White Tee (`#F8F9FA`), Silver Hair (`#CED4DA`) | Emotion Swaps: `neutral` (42–46s) → `proud` (46–56s).
  - **Grandma Helen (69):** Deaf Homeowner | Skin `#E8B896` | R6 Outfit: Lavender Cardigan (`#B892FF`), Gray Pants (`#6C757D`), Silver Bun (`#CED4DA`) | Emotion Swaps: `grin` (42–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Red Alert Lamp Bulb:** `0.6 x 0.8 x 0.6` studs | `Neon` + `PointLight` | `#FF0033` | Socket: `Workspace` (Attic window).
  - **Baby Monitor Receiver:** `0.5 x 0.8 x 0.3` studs | `SmoothPlastic` | `#FFFFFF` with `#FF0033` LED | Socket: `Workspace` (Hall table).
  - **Folded Blue Stroller:** `2.2 x 1.8 x 2.0` studs | `Metal` + `Fabric` | `#219EBC` | Socket: `Workspace` (Front porch).
  - **Red Dog Leash:** `3.0 x 0.1 x 0.1` studs | `Fabric` | `#D62828` | Socket: `RightHand` (Maya).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *#44 Elm Street Victorian House* — `WoodPlanks` porch (`#582F0E`), white clapboard siding (`#E9ECEF`), attic `Glass` window pulsing red, warm hallway interior (`#FFE5B4`).
  - **Lighting:** `ClockTime = 2.0`, midnight storm blue (`#0D1B2A`), pulsing crimson attic `SpotLight` (`#FF0033`) vs. cozy golden porch light (`#FFD166`) at 42s.
  - **VFX/SFX Cues:** Light rain `ParticleEmitter`, pulsing red lens flare; *CREAK*, *CLICK-UNLOCK*, gentle *BEEP-FLASH*.

---

### Story 067: The Toy-Stealer

- **Header:**
  - **Story ID & Title:** Story 067 — The Toy-Stealer
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `viral_storyteller`
  - **Unstated Human Meaning:** Not everyone sneaking into your yard after dark is trying to take something away.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, a tall shadow sneaks into backyards at 3 AM and steals kids' broken bikes—and I just caught him climbing over our fence with my brother's!"`
     - **Frame 1 Visual:** Moonlit backyard shot of a hooded tall figure lifting a rusted, flat-tired blue bicycle over a wooden picket fence while Narrator films from the kitchen window.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last Tuesday, three rusted scooters and a one-wheeled skateboard vanished from Oak Street overnight—leaving kids convinced a scrap-metal bandit was stripping parts.
     - **Town Adaptation:** Parents chained old broken bikes to porch posts, and kids taped `[DO NOT STEAL]` cardboard signs onto bent handlebars.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Bent Blue Bike):* A `4.0 x 2.2 x 1.2` stud rusted kid's bike with a snapped chain and flat front tire.
       2. *Clue 2 (The Grease-Stained Wrench):* A `1.0 x 0.3 x 0.15` stud chrome wrench sticking out of the figure's back pocket.
       3. *Clue 3 (The Garage Light Crack):* A warm yellow sliver of light glowing under the locked tin shed three houses down.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator's 7-year-old brother Toby bursts into tears when he sees his broken bike gone at `3:05 AM`; determined to get it back, Narrator creeps out the back door and tracks the muddy boot prints straight to the glowing tin shed.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Shed Window Peek):** Narrator stands on an overturned bucket to peer through the high dusty glass—*CRACK-THUD!*—the plastic bucket collapses, dropping him into a rosebush.
     - **Clue 2 Fail (The Padlock Tug):** Narrator grabs the shed's side latch—*RATTLE!*—the heavy door is bolted from inside while sparks fly behind the frosted pane.
     - **Clue 3 Fail (The Confrontation Yell):** Narrator bangs the tin door yelling *"Give my brother's bike back!"*—*CLANG!*—the sparks stop dead, and heavy boots stomp straight toward the door.
  5. **39–51s Genius Rule-Hack Climax:**
     - The tin door swings wide—*CREAK!*—and Narrator freezes: standing inside is 72-year-old Mr. Miller, the retired bicycle-shop mechanic whose store burned down last year, surrounded by fresh cans of sky-blue spray paint, shiny new chrome chains, and silver bells; he wasn't stealing bikes—he was secretly fixing every poor kid's broken bike in his garage at night so they'd wake up to a brand-new ride on their porch.
  6. **51–56s Action Echo Punchline:**
     - Mr. Miller wipes his greasy hands on a rag, rolls out Toby's gleaming sky-blue bike with a brand-new silver bell—*RING-RING!*—and lets Narrator push it home before sunrise.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Leo, 13):** Protagonist | Skin `#E0AC69` | R6 Outfit: Red Hoodie (`#D62828`), Gray Sweatpants (`#6C757D`), Messy Black Hair (`#1B1B1B`) | Emotion Swaps: `scared` (0–21s) → `determined` (21–42s) → `shocked` (42–49s) → `proud` (49–56s).
  - **Mr. Miller (72):** Retired Mechanic | Skin `#F1C27D` | R6 Outfit: Navy Mechanic Jumpsuit (`#1D3557`), Grease-Stained Cap (`#495057`), White Mustache (`#F8F9FA`) | Emotion Swaps: `neutral` (0–46s) → `proud` (46–56s).
  - **Toby (7):** Younger Brother | Skin `#E0AC69` | R6 Outfit: Dinosaur Pajamas (`#52B788`), Brown Hair (`#3D2B1F`) | Emotion Swaps: `scared` (13.5–21s) → `grin` (51–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Broken / Restored Blue Bike:** `4.0 x 2.2 x 1.2` studs | `CorrodedMetal` → `SmoothPlastic` | `#6C757D` → `#00B4D8` + `#E5E5E5` bell | Socket: `Workspace` (Yard → Shed).
  - **Chrome Wrench:** `1.0 x 0.3 x 0.15` studs | `Metal` | `#CED4DA` | Socket: `UpperTorso` pocket → `RightHand` (Mr. Miller).
  - **Blue Spray Paint Can:** `0.4 x 0.9 x 0.4` studs | `Metal` | `#00B4D8` | Socket: `Workspace` (Workbench).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Mr. Miller's Tin Garage Shed* — Corrugated `Metal` walls (`#6C757D`), `WoodPlanks` workbench (`#6F4E37`), hanging bike wheels, warm tungsten drop-lamp (`#FFD166`).
  - **Secondary Set:** *Suburban Backyard (0–21s)* — `Grass` lawn (`#2D6A4F`), white `Wood` picket fence (`#F8F9FA`).
  - **Lighting:** `ClockTime = 3.0`, deep indigo night (`#0D1B2A`), warm golden workshop `PointLight` (`#FFB703`) spilling out at 42s.
  - **VFX/SFX Cues:** Welding spark `ParticleEmitter` behind frosted glass; *CRACK-THUD*, *CLANG!*, *CREAK*, *RING-RING!*.

---

### Story 068: The "Haunted" Locker #13

- **Header:**
  - **Story ID & Title:** Story 068 — The "Haunted" Locker #13
  - **Format:** Standalone 50–56s (44 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** Sometimes a scary rumor is the only armor a shy kid has to do something kind without being teased.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this school, anyone who opens Locker #13 finds a mysterious handwritten note inside—and everyone swears the ghost knows your darkest secret!"`
     - **Frame 1 Visual:** Dimly lit locker bay: Narrator pulls open rusted Locker #13's creaking steel door to find a folded crimson envelope resting right on the top shelf.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last month, the star quarterback found a note inside Locker #13 saying *"Stop pretending you're fine"*—and bolted straight out of gym class convinced the locker was reading his mind.
     - **Town Adaptation:** Students taped yellow `[DO NOT OPEN]` caution tape across Locker #13, calling it "The Confession Box."
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Crimson Folded Note):* A `0.6 x 0.4 x 0.05` stud red-ink paper note tucked into the locker vent.
       2. *Clue 2 (The Rare Teal Fountain Pen):* A `0.15 x 0.8 x 0.15` stud teal ink pen clipped to the class valedictorian's binder.
       3. *Clue 3 (The Vent Slit Dust):* Fresh smudges on the top air-slit of Locker #13 showing someone slips notes in from the outside.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator fails his chemistry midterm and slumps alone by the lockers after final bell; suddenly, a soft *RUSTLE!* drops a fresh folded note straight through Locker #13's vent onto his backpack.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Hallway Sprint):** Narrator whips around and bolts down the east corridor—*THUMP-THUMP!*—the hallway is empty except for a swinging fire door.
     - **Clue 2 Fail (The Janitor Interrogation):** Narrator asks Mr. Lopez if anyone walked past—*SHH-SWEEP!*—Mr. Lopez shrugs, pointing out nobody has the locker master key.
     - **Clue 3 Fail (The Security Mirror Check):** Narrator jumps to check the curved ceiling mirror—*CREAK!*—only his own startled reflection stares back.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator finally unfolds the fresh note—expecting a curse—and reads *"You're smarter than one bad test. Meet me at Study Table 4 — I brought extra flashcards"* written in distinct teal fountain-pen ink; Narrator glances toward the library glass doors and spots shy valedictorian Elena quickly hiding her teal fountain pen behind a stack of chemistry flashcards, realizing she started the "haunted" rumor herself so struggling kids would actually read her anonymous encouragement notes without feeling embarrassed.
  6. **51–56s Action Echo Punchline:**
     - Narrator walks quietly into the library, pulls out the chair across from Elena at Table 4, places the folded note between them, and taps a chemistry flashcard with a grateful grin.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Marcus, 15):** Protagonist | Skin `#8D5524` | R6 Outfit: Navy Hoodie (`#1D3557`), Gray Joggers (`#6C757D`), Short Fade (`#1B1B1B`) | Emotion Swaps: `shocked` (0–13.5s) → `scared` (13.5–21s) → `determined` (21–42s) → `grin` (42–56s).
  - **Elena (15):** Shy Valedictorian | Skin `#F5CBA7` | R6 Outfit: Cream Sweater Vest (`#FEFAE0`), Plaid Skirt (`#457B9D`), Round Glasses + Long Brown Hair (`#4A3525`) | Emotion Swaps: `scared` (42–48s) → `proud` (48–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Locker #13:** `2.0 x 6.5 x 2.0` studs | `CorrodedMetal` | `#6C757D` with `#FFD166` caution tape | Socket: `Workspace` (Hallway).
  - **Folded Note:** `0.6 x 0.4 x 0.05` studs | `SmoothPlastic` | `#FFFFFF` with `#008080` ink | Socket: `Workspace` → `RightHand` (Marcus).
  - **Teal Fountain Pen:** `0.15 x 0.8 x 0.15` studs | `Metal` | `#008080` | Socket: `RightHand` (Elena).
  - **Chemistry Flashcards:** `0.8 x 0.4 x 0.5` studs | `SmoothPlastic` | `#FFF3B0` | Socket: `Workspace` (Library Table 4).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Oakridge High West Hallway* — Polished `Marble` floor (`#E9ECEF`), rows of blue `Metal` lockers (`#2B4C7E`) with rusted Locker #13 standing out.
  - **Secondary Set:** *School Library (42–56s)* — Warm `WoodPlanks` study tables (`#8B5A2B`), tall bookshelves (`#582F0E`), amber desk lamps.
  - **Lighting:** `ClockTime = 16.8`, long afternoon golden sunbeams (`#FFB703`) cutting across the dusty hallway and warm library interior.
  - **VFX/SFX Cues:** Dust motes in sunbeams; *CREAK*, *RUSTLE!*, *THUMP-THUMP*, *TAP*.

---

### Story 069: The Rain-Coat Watcher

- **Header:**
  - **Story ID & Title:** Story 069 — The Rain-Coat Watcher
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** Grief can make someone stand guard in the rain so nobody else loses what they lost.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, every time a thunderstorm hits, a silent figure in a dripping yellow raincoat stands motionless on the old stone bridge—and tonight my dog bolted straight toward him!"`
     - **Frame 1 Visual:** Stormy dusk bridge shot: a tall figure in a hooded bright yellow slicker holding a large black bundle against the iron railing as lightning illuminates the rushing river below.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last spring, a cyclist skidded on the wet bridge planks after seeing the motionless yellow figure through the fog, swearing the watcher never blinks.
     - **Town Adaptation:** Parents warn kids to take the highway overpass whenever rain starts, calling the stone bridge "The Watcher's Crossing."
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Dripping Yellow Slicker):* A `2.2 x 3.2 x 1.2` stud bright yellow hooded raincoat worn by the silent bridge watcher.
       2. *Clue 2 (The Bulky Black Canvas Tote):* A `1.8 x 1.4 x 1.0` stud waterproof black bag tucked under the watcher's arm.
       3. *Clue 3 (The Faded Collar Tag):* A tiny `0.3 x 0.3 x 0.05` stud brass bone-shaped dog tag pinned over the watcher's raincoat pocket.
  3. **13.5–21s Personal Trap & Crisis:**
     - Thunder cracks overhead, snapping Narrator's puppy's retractable leash; the terrified puppy sprints straight onto the slick, flooded stone bridge and slips halfway under the outer railing right beside the yellow raincoat figure.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Bridge Sprint):** Narrator dashes onto the flooded planks—*SPLASH-SLIP!*—his sneakers hydroplane on wet moss, slamming him to one knee twenty feet short.
     - **Clue 2 Fail (The Whistle Call):** Narrator shouts his puppy's name over the roaring river—*WHOOOOSH!*—the gale swallows his voice completely.
     - **Clue 3 Fail (The Shadow Reach):** The tall yellow figure steps right over the trembling puppy and reaches down into the black canvas tote—*ZIP!*—Narrator screams *"Don't touch him!"* as he scrambles up.
  5. **39–51s Genius Rule-Hack Climax:**
     - The yellow figure kneels gently, scoops the shivering puppy safely back from the railing edge, and unzips the bulky black tote—*ZIP-POOF!*—pulling out a thick warm microfiber dog towel and a dry wool blanket; wiping the rain off his hood, the gentle older man points to the faded brass dog tag pinned to his chest reading `[BARNABY — 2016]`: he lost his own dog at this exact flooded bridge ten years ago and stands here every single storm with dry towels and dog treats for soaked strays and kids.
  6. **51–56s Action Echo Punchline:**
     - The watcher wraps Narrator's puppy in a warm striped towel, presses an extra dry umbrella into Narrator's hand, and steps quietly back to the bridge rail to keep watch.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Chloe, 13):** Protagonist | Skin `#F5CBA7` | R6 Outfit: Blue Rain Jacket (`#457B9D`), Dark Jeans (`#212529`), Wet Auburn Ponytail (`#8D3B24`) | Emotion Swaps: `scared` (0–44s) → `shocked` (44–49s) → `proud` (49–56s).
  - **The Watcher (Mr. Harris, 60):** Silent Rescuer | Skin `#E0AC69` | R6 Outfit: Yellow Hooded Slicker (`#FFD166`), Rubber Rain Boots (`#1D1D1D`), Gray Beard (`#ADB5BD`) | Emotion Swaps: `neutral` (0–44s) → `proud` (44–56s).
  - **Puppy (Biscuit):** Pet | Skin/Fur `#D4A373` | R6-Scale Pet Rig | Emotion Swaps: `scared` (13.5–44s) → `grin` (44–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Black Waterproof Tote:** `1.8 x 1.4 x 1.0` studs | `Fabric` | `#1B1B1B` | Socket: `LeftHand` (Mr. Harris).
  - **Warm Striped Towel:** `1.6 x 0.4 x 1.2` studs | `Fabric` | `#E63946` / `#FFFFFF` | Socket: `RightHand` (Mr. Harris → Biscuit).
  - **Brass Dog Tag:** `0.3 x 0.3 x 0.05` studs | `Metal` | `#FFB703` | Socket: `UpperTorso` (Mr. Harris lapel).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Old Stone River Bridge* — Wet `Cobblestone` deck (`#495057`), rusted `Metal` guardrails (`#6C757D`), churning `Water` river below (`#1D3557`), flickering warm bridge lamps.
  - **Lighting:** `ClockTime = 18.4`, storm-slate twilight (`Ambient #2B2D42`, `FogEnd = 90`, heavy rain `ParticleEmitter` + lightning flashes), warm yellow lamp glow (`#FFD166`).
  - **VFX/SFX Cues:** Heavy rain splashes, lightning flash frames; *SPLASH-SLIP*, *ZIP-POOF*, *ARF!*.

---

### Story 070: The Silence Bell

- **Header:**
  - **Story ID & Title:** Story 070 — The Silence Bell
  - **Format:** Standalone 50–56s (46 beats)
  - **Voice Preset:** `viral_storyteller`
  - **Unstated Human Meaning:** Moving away only feels lonely until an entire street lights up to walk you out.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, whenever someone is about to move away forever, the old church bell rings three slow times—and every single porch light on the street slams off in total darkness!"`
     - **Frame 1 Visual:** Dusk street shot as the towering brick church bell tolls (`*BONG... BONG... BONG*`) and every house window down Maple Lane snaps pitch-black in unison.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last winter, the town baker rang the bell by mistake while dusting the belfry—and twenty neighbors instantly locked their doors and pulled their curtains shut in eerie silence.
     - **Town Adaptation:** New kids whisper that "The Silence Bell" curses whoever is leaving, so nobody ever looks out their window when the three tolls echo.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Cardboard Moving Boxes):* Six taped `2.0 x 1.6 x 1.6` stud boxes stacked inside Narrator's station wagon trunk.
       2. *Clue 2 (The Darkened Front Porches):* Ten pitch-black houses lining both sides of Maple Lane at `7:00 PM`.
       3. *Clue 3 (The Glass Mason Jars):* Faint orange flickers visible behind the curtains of the corner bakery window.
  3. **13.5–21s Personal Trap & Crisis:**
     - Dad's job transfers out of state; as Narrator finishes taping the last moving box in their driveway at `7:00 PM` sharp, the old church bell tolls three slow times—*BONG... BONG... BONG*—and every single friend's house on the street snaps pitch-black, leaving Narrator heartbroken that nobody came to say goodbye.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Best Friend Knock):** Narrator runs across the dark street to Leo's front door and knocks—*THUD-THUD!*—the porch stays dark and nobody answers.
     - **Clue 2 Fail (The Group Chat Text):** Narrator sends *"Hey, we're leaving now..."* in the class chat—*BEEP!*—zero typing bubbles, dead silence from all twelve friends.
     - **Clue 3 Fail (The Driveway Wave):** Narrator climbs slowly into the station wagon passenger seat and waves once at the empty street—*CLICK-ENGINE!*—his eyes sting as Dad shifts into drive.
  5. **39–51s Genius Rule-Hack Climax:**
     - The station wagon rolls ten feet out of the driveway—*WHOOSH-SPARK!*—and suddenly fifty front doors swing open at once; every neighbor, classmate, and teacher steps onto the dark sidewalk holding glowing orange paper *goodbye lanterns* made from mason jars, turning the pitch-black street into a golden runway all the way to the highway sign—the bell never cursed anyone; the town turns off the streetlights so the farewell lanterns shine brighter.
  6. **51–56s Action Echo Punchline:**
     - Leo sprints alongside the slow-rolling car and hands Narrator a warm glowing mason-jar lantern through the open window; Narrator holds it high out the window all the way to the corner.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Sam, 14):** Protagonist | Skin `#E8B896` | R6 Outfit: Olive Bomber Jacket (`#606C38`), Blue Jeans (`#264653`), Brown Swoop Hair (`#4A3525`) | Emotion Swaps: `scared` (0–39s) → `shocked` (39–46s) → `proud` (46–56s).
  - **Leo (14):** Best Friend | Skin `#8D5524` | R6 Outfit: Yellow Hoodie (`#FFD166`), Black Jeans (`#212529`), Short Black Hair (`#1B1B1B`) | Emotion Swaps: `grin` (39–56s).
  - **Dad (42):** Driver | Skin `#E8B896` | R6 Outfit: Plaid Flannel (`#9B2226`), Khaki Pants (`#D4A373`), Short Brown Hair (`#4A3525`) | Emotion Swaps: `neutral` (0–39s) → `proud` (39–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Glowing Mason-Jar Lanterns (x25):** `0.6 x 0.9 x 0.6` studs | `Glass` + `Neon` core | `#FFB703` | Socket: `RightHand` (Townspeople & Leo → Sam).
  - **Moving Boxes (x6):** `2.0 x 1.6 x 1.6` studs | `Wood` / `SmoothPlastic` | `#D4A373` | Socket: `Workspace` (Car trunk & driveway).
  - **Bronze Church Bell:** `3.0 x 3.2 x 3.0` studs | `Metal` | `#CD7F32` | Socket: `Workspace` (Church steeple).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Maple Lane Suburban Street* — `Asphalt` road (`#2B2D42`), `WoodPlanks` porches (`#6F4E37`), brick church steeple in background (`#7F4F24`), family station wagon.
  - **Lighting:** `ClockTime = 19.2`, deep indigo dusk (`#0D1B2A`), switching from total blackout to 25 warm amber `PointLight` lanterns (`#FFB703`) lining both curbs.
  - **VFX/SFX Cues:** Floating warm ember motes around lanterns; *BONG... BONG... BONG*, *THUD-THUD*, *WHOOSH-SPARK!*.

---

### Story 071: The Burnt-Bread Baker

- **Header:**
  - **Story ID & Title:** Story 071 — The Burnt-Bread Baker
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `viral_storyteller`
  - **Unstated Human Meaning:** Pride makes it hard to ask for help, so true kindness finds a way around the front door.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, the grumpy baker throws half his fresh bread into the alley bin every day at noon—and yells at any kid who tries to buy a loaf!"`
     - **Frame 1 Visual:** Low-angle bakery counter shot of scowling Baker Miller slamming a heavy wooden tray of "slightly dark" golden loaves into a black crate and barking *"SOLD OUT! GET OUT!"* at two startled kids.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last week, a rich food blogger offered triple price for one of the "burnt" sourdough loaves—and Baker Miller chased him out the door with a flour-covered broom.
     - **Town Adaptation:** Kids nicknamed him "Old Crusty" and dared each other to sprint past his back alley before he dumped the "trash" bags at `12:05 PM`.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Crisp Golden Loaves):* Six `1.0 x 0.6 x 0.6` stud loaves with only tiny golden-brown spots—clearly not actually burnt.
       2. *Clue 2 (The Clean White Wax Paper):* Baker Miller carefully wraps every "trash" loaf in crisp white parchment before dropping it into the black alley bin.
       3. *Clue 3 (The Empty Bench Behind the Dumpster):* A clean `4.0 x 1.5 x 1.2` stud wooden bench tucked quietly behind the brick alley corner.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator's dad gets laid off from the factory; with an empty fridge at home, Narrator walks into the bakery at `11:58 AM` clutching his last two crumpled dollars, only for Baker Miller to bark *"Closed!"* and haul the black crate out the back door.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Counter Plea):** Narrator slides his two dollars across the glass case—*SLIDE-THUMP!*—Baker Miller pushes the bills right back without looking up.
     - **Clue 2 Fail (The Front Window Wave):** Narrator taps the bakery glass holding his stomach—*TAP-TAP!*—Baker Miller pulls the green blind straight down.
     - **Clue 3 Fail (The Alley Confrontation):** Determined not to go home empty-handed, Narrator sneaks down the brick alley at `12:05 PM` to grab a loaf from the bin—*CREAK!*—and freezes as Baker Miller steps out holding the heavy black crate.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator braces to get yelled at—then stops cold: the "alley dumpster" isn't a trash bin at all; it's a clean insulated warming chest lined with crisp parchment loaves, hot soup thermoses, and a hand-painted sign reading `[FREE FAMILY PICKUP — NO QUESTIONS, NO LINE]`; Baker Miller only yelled at rich shoppers at noon so homeless and laid-off families could take warm food quietly in the alley without feeling embarrassed in front of the town.
  6. **51–56s Action Echo Punchline:**
     - Baker Miller clears his throat, slips two warm wax-wrapped loaves and a jar of strawberry jam into a clean brown paper bag, hands it to Narrator, and mutters *"Tell your dad come back tomorrow."*

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Toby, 14):** Protagonist | Skin `#F1C27D` | R6 Outfit: Faded Green Hoodie (`#52B788`), Dark Jeans (`#264653`), Messy Brown Hair (`#582F0E`) | Emotion Swaps: `scared` (0–39s) → `shocked` (39–49s) → `proud` (49–56s).
  - **Baker Miller (61):** Grumpy Secret Helper | Skin `#E0AC69` | R6 Outfit: Flour-Dusted White Apron (`#F8F9FA`), Rolled-Sleeve Shirt (`#ADB5BD`), Bushy Gray Eyebrows + Mustache (`#6C757D`) | Emotion Swaps: `determined` (0–39s) → `neutral` (39–49s) → `proud` (49–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Parchment-Wrapped Bread Loaves (x6):** `1.0 x 0.6 x 0.6` studs | `SmoothPlastic` | `#FFFFFF` wrap + `#DDA15E` crust | Socket: `Workspace` (Warming chest).
  - **Insulated Warming Chest:** `3.0 x 2.2 x 2.0` studs | `Metal` | `#212529` with `#FFD166` inner lining | Socket: `Workspace` (Alley bench).
  - **Brown Paper Grocery Bag:** `1.2 x 1.6 x 0.8` studs | `Fabric` | `#BC6C25` | Socket: `RightHand` (Miller → Toby).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Miller's Corner Bakery & Brick Alley* — `WoodPlanks` shop floor (`#8B5A2B`), `Glass` display case, red `Brick` back alley (`#7F4F24`) with clean `Cobblestone` ground (`#495057`).
  - **Lighting:** `ClockTime = 12.1`, bright noon sunbeams (`#FFE5B4`) cutting down the brick alley onto the clean warming chest.
  - **VFX/SFX Cues:** Warm bread steam `ParticleEmitter` rising from the opened chest; *SLAM!*, *TAP-TAP*, *CREAK*, *RUSTLE*.

---

### Story 072: The Monster Under the Pier

- **Header:**
  - **Story ID & Title:** Story 072 — The Monster Under the Pier
  - **Format:** Standalone 50–56s (45 beats)
  - **Voice Preset:** `urgent_teen`
  - **Unstated Human Meaning:** Sometimes a scary warning sign is the only fence strong enough to keep something fragile safe.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, the old fisherman nailed a skull sign onto Wooden Pier #3 swearing a giant sea monster lives underneath—and my little sister just dropped her bracelet between the planks!"`
     - **Frame 1 Visual:** Golden-hour dock shot of weathered Pier #3 fenced off with a red `[DANGER: MONSTER BELOW — NO SWIMMING]` board while dark rippling shadows swirl in the green water beneath the pilings.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last July, a tourist's drone hovered under Pier #3 and got slapped straight into the bay by a massive scaly flipper—convincing the whole beach a lake Kraken lived there.
     - **Town Adaptation:** Lifeguards chained off the wooden ramp, and kids skipped flat stones from fifty feet away, daring anyone to touch the first plank.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Silver Charm Bracelet):* A `0.4 x 0.4 x 0.1` stud shiny silver bracelet lying on a wet piling beam just above the water.
       2. *Clue 2 (The Floating Bucket of Lettuce):* A `1.2 x 1.2 x 1.2` stud green plastic bucket bobbing gently on a rope tied under the dock.
       3. *Clue 3 (The Red First-Aid Kit):* A `1.2 x 0.9 x 0.5` stud white-and-red medical box resting beside Old Salty's rowboat.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator's 7-year-old sister Mia leans over the chained gate to wave at a fish; her silver birthday bracelet slips off her wrist and drops onto the lower crossbeam right as a huge dark shape splashes underneath.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Fishing-Rod Hook):** Narrator lowers a toy fishing hook between the planks—*SWISH-SNAP!*—the nylon line snags on a barnacle and snaps clean.
     - **Clue 2 Fail (The Stick Scoop):** Narrator stretches a `5.0`-stud driftwood branch down toward the beam—*SPLASH!*—a heavy wave tips the bracelet closer to the dark shadow swirling below.
     - **Clue 3 Fail (The Gate Climb):** Narrator vaults the chained gate onto the lower ladder—*CREAK!*—right as Old Salty rows up shouting *"Wait, kid, don't spook 'em!"*
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator freezes on the bottom rung as three massive shapes glide out from the shadow—not monsters, but *three giant injured sea turtles* with bandaged shells and bright orange recovery tags, happily munching fresh romaine lettuce from Old Salty's floating bucket; Old Salty didn't invent the monster story to scare kids—he put up the skull sign so speedboats and cannonballing tourists wouldn't crush the recovering turtles while he nurses them back to health.
  6. **51–56s Action Echo Punchline:**
     - Old Salty scoops Mia's silver bracelet off the crossbeam with his net, hands it back dry, and lets Narrator and Mia toss two crisp lettuce leaves down to the gentle turtles.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Kai, 14):** Protagonist | Skin `#C68B59` | R6 Outfit: Turquoise Rashguard (`#00B4D8`), Board Shorts (`#F4A261`), Curly Black Hair (`#1B1B1B`) | Emotion Swaps: `scared` (0–39s) → `shocked` (39–48s) → `grin` (48–56s).
  - **Mia (7):** Younger Sister | Skin `#C68B59` | R6 Outfit: Coral Sun Tee (`#FF758F`), Denim Shorts (`#457B9D`), Twin Braids (`#1B1B1B`) | Emotion Swaps: `scared` (13.5–48s) → `grin` (48–56s).
  - **Old Salty (67):** Fisherman | Skin `#D4A373` | R6 Outfit: Yellow Fisherman Vest (`#E9C46A`), Rolled Khakis (`#A98467`), White Beard + Captain Cap (`#F8F9FA` / `#1D3557`) | Emotion Swaps: `scared` (35–42s) → `proud` (42–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Danger Skull Sign:** `2.6 x 1.8 x 0.2` studs | `Wood` | `#8B5A2B` with `#D62828` skull | Socket: `Workspace` (Pier gate).
  - **Injured Sea Turtles (x3):** `3.2 x 1.0 x 2.6` studs | `SmoothPlastic` | `#2D6A4F` shell + `#FFFFFF` bandage | Socket: `Workspace` (Water under pier).
  - **Green Lettuce Bucket:** `1.2 x 1.2 x 1.2` studs | `SmoothPlastic` | `#52B788` | Socket: `Workspace` (Pier rope).
  - **Silver Charm Bracelet:** `0.4 x 0.4 x 0.1` studs | `Metal` | `#E5E5E5` | Socket: `Workspace` (Crossbeam) → `RightHand` (Mia).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Wooden Pier #3 & Harbor* — Weathered `WoodPlanks` dock (`#6F4E37`), rope pilings, clear emerald `Water` (`#2A9D8F`), wooden rowboat.
  - **Lighting:** `ClockTime = 16.8`, warm golden-hour sunbeams (`#FFB703`) illuminating the clear turquoise water beneath the pier at 42s.
  - **VFX/SFX Cues:** Water ripple rings around turtles, sparkling sun glints on water; *SWISH-SNAP*, *SPLASH*, *CREAK*.

---

### Story 073: The Black-Car Follower

- **Header:**
  - **Story ID & Title:** Story 073 — The Black-Car Follower
  - **Format:** Standalone 50–56s (46 beats)
  - **Voice Preset:** `urgent_teen`
  - **Unstated Human Meaning:** Sometimes the shadow following three paces behind you is the promise someone made before leaving.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"For three straight weeks, a matte-black SUV with pitch-dark tinted windows has slowly crawled ten feet behind me every single day after school!"`
     - **Frame 1 Visual:** Over-the-shoulder sidewalk shot of Narrator glancing back nervously as a sleek matte-black SUV creeps silently along the curb with unreadable blacked-out glass.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** On Monday, Narrator tried sprinting through the corner strip mall—and the black SUV casually looped the block and waited at the far exit with its engine purring.
     - **Town Adaptation:** Narrator's friends warned him to ditch his bright red backpack and take alley shortcuts after `3:30 PM`, convinced a kidnapper was tracking his route.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Faded Army Dog-Tag):* A `0.3 x 0.5 x 0.05` stud silver tag hanging from Narrator's own backpack zipper (from his deployed older brother).
       2. *Clue 2 (The Broken Gate Latch):* A snapped brass latch on the neighborhood alley fence after last month's break-ins.
       3. *Clue 3 (The Green Windshield Sticker):* A tiny `0.4 x 0.4` stud olive-green `[3RD INFANTRY]` decal in the corner of the SUV's windshield.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator cuts through a dead-end brick alley to lose the SUV; instead, the black SUV pulls cleanly across the alley mouth, blocking the exit as the driver's door clicks open—*CLACK!*—and a tall broad-shouldered man in a dark hoodie steps out.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Brick-Wall Climb):** Narrator leaps for the top of the `7.0`-stud brick alley fence—*SCRAPE-THUD!*—his sneakers slip on loose mortar, dropping him back onto the pavement.
     - **Clue 2 Fail (The Trash-Lid Shield):** Narrator grabs a metal trash lid as a bat—*CLANG!*—it's bolted to the side chain, yanking him backward.
     - **Clue 3 Fail (The 911 Speed-Dial):** Narrator fumbles his phone to hit call—*BEEP-DROP!*—his shaking thumb drops the phone onto the gravel as the tall man walks right up to him.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator squeezes his eyes shut—then hears a calm voice say *"Hey, little bro. Drop your guard, it's me — Sergeant Cole."* Narrator opens his eyes: the tall man pulls back his hood, flashes a matching silver dog-tag and a folded handwritten letter from Narrator's deployed older brother Marcus reading *"Kid, there were three break-ins on Oak Street — Cole promised he'd make sure you got home safe until I'm back"*; the dark-tinted SUV was his brother's army buddy silently running afternoon escort duty.
  6. **51–56s Action Echo Punchline:**
     - Sergeant Cole picks up Narrator's phone off the gravel, hands it over with a fist bump, and rolls the SUV's front window halfway down so Narrator can wave as he walks the last block home.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Ethan, 14):** Protagonist | Skin `#F1C27D` | R6 Outfit: Red Backpack (`#D62828`), Gray Zip Hoodie (`#6C757D`), Blue Jeans (`#264653`), Brown Hair (`#4A3525`) | Emotion Swaps: `scared` (0–39s) → `shocked` (39–48s) → `proud` (48–56s).
  - **Sergeant Cole (27):** Brother's Army Buddy | Skin `#8D5524` | R6 Outfit: Dark Olive Hoodie (`#3A5A40`), Black Cargo Pants (`#1D1D1D`), Buzz Cut (`#1B1B1B`) | Emotion Swaps: `neutral` (0–39s) → `grin` (39–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Matte-Black Tinted SUV:** `16.0 x 6.5 x 7.5` studs | `SmoothPlastic` + `Glass` | `#1B1B1B` | Socket: `Workspace` (Curb / Alley mouth).
  - **Silver Army Dog-Tags (x2):** `0.3 x 0.5 x 0.05` studs | `Metal` | `#CED4DA` | Socket: `UpperTorso` (Cole & Ethan's bag).
  - **Brother's Folded Letter:** `0.8 x 0.6 x 0.05` studs | `SmoothPlastic` | `#FFF3B0` | Socket: `RightHand` (Cole → Ethan).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Oak Street & Brick Dead-End Alley* — `Concrete` sidewalks (`#ADB5BD`), autumn `Grass` yards (`#606C38`), red `Brick` alley wall (`#7F4F24`), metal dumpsters.
  - **Lighting:** `ClockTime = 16.8`, crisp late-afternoon golden sun (`#FFB703`) casting long dramatic shadows down the alley.
  - **VFX/SFX Cues:** Low engine idle rumble, tire crunch on gravel; *CLACK!*, *SCRAPE-THUD*, *CLANG*.

---

### Story 074: The Crying-Tree Bench

- **Header:**
  - **Story ID & Title:** Story 074 — The Crying-Tree Bench
  - **Format:** Standalone 50–56s (44 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** Grief leaves a quiet seat behind so the next person who breaks down doesn't have to sit alone.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this town, nobody ever sits on the old wooden bench under the weeping willow—because everyone swears the tree steals your smile!"`
     - **Frame 1 Visual:** Misty park shot of a massive drooping weeping willow shading a weathered green bench with a small locked wooden box bolted underneath the armrest.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last month, a jogging influencer sat on the willow bench for five minutes to film a vlog—and walked away sobbing uncontrollably without knowing why.
     - **Town Adaptation:** Kids sprint past the willow tree holding their breath, calling it "The Sorrow Bench," and even dogs refuse to sniff the grass around it.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Carved Brass Plaque):* A `1.0 x 0.4 x 0.05` stud faded plaque on the backrest reading `IN MEMORY OF CLARA — 1998–2019`.
       2. *Clue 2 (The Hidden Cedar Latch):* A small `1.2 x 0.8 x 0.8` stud wooden compartment tucked directly under the bench seat.
       3. *Clue 3 (The Daily Footprints):* Fresh small sneaker prints leading from the park gate to the bench every morning at `6:00 AM`.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator gets cut from the varsity soccer roster on a freezing, rainy afternoon; too ashamed to go home and face his dad, he collapses onto the forbidden willow bench with his head in his knees—ready for the "curse" to hit.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Sleeve Wipe):** Narrator furiously scrubs his wet cheeks with his hoodie sleeve—*RUB-SNIFF!*—the cold rain keeps soaking through, making him shiver harder.
     - **Clue 2 Fail (The Phone Distraction):** Narrator opens funny videos to force himself to stop crying—*BEEP-DROP!*—his screen goes black at `2%` battery.
     - **Clue 3 Fail (The Bench Bolt):** Narrator stands up to bolt away from the "cursed" tree—*CREAK!*—his wet cleat catches a small wooden box protruding from under the seat, popping its latch open.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator kneels beside the opened cedar box—*CLICK!*—and freezes: inside isn't a curse, it's a dry box of soft tissues, a warm steel thermos of hot cocoa, and a laminated note reading *"If you're sitting here, you've had a rough day. My daughter loved this tree — take a cup and breathe. — Mom"*; glancing up through the willow branches, Narrator sees a gentle older woman in a knit scarf setting a fresh tissue box by the path, smiling softly before turning back toward the gate.
  6. **51–56s Action Echo Punchline:**
     - Narrator pours a steaming cup of hot cocoa from the thermos, wipes his face with a dry tissue, and leaves a crumpled dollar bill + *"Thank you"* sticky note inside the cedar box before latching it shut.

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Lucas, 15):** Protagonist | Skin `#E0AC69` | R6 Outfit: Blue Soccer Jersey (`#219EBC`), Black Track Pants (`#212529`), Wet Brown Hair (`#4A3525`) | Emotion Swaps: `scared` (0–39s) → `shocked` (39–48s) → `proud` (48–56s).
  - **Grieving Mom (Mrs. Bennett, 54):** Quiet Caretaker | Skin `#E8B896` | R6 Outfit: Soft Cream Coat (`#FEFAE0`), Burgundy Scarf (`#9B2226`), Silver-Streaked Bob (`#6C757D`) | Emotion Swaps: `neutral` (42–46s) → `proud` (46–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Weeping Willow Bench:** `5.0 x 2.4 x 2.0` studs | `WoodPlanks` | `#2D6A4F` painted wood | Socket: `Workspace` (Park clearing).
  - **Cedar Care Box:** `1.2 x 0.8 x 0.8` studs | `Wood` | `#8B5A2B` | Socket: `Workspace` (Under bench seat).
  - **Steel Cocoa Thermos & Cup:** `0.5 x 1.1 x 0.5` studs | `Metal` | `#CED4DA` + `#6F4E37` cocoa | Socket: `RightHand` (Lucas).
  - **White Tissue Box:** `0.9 x 0.5 x 0.6` studs | `SmoothPlastic` | `#FFFFFF` | Socket: `Workspace` (Inside box).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Willow Grove Park Clearing* — Rain-darkened `Grass` (`#2D6A4F`), sprawling `Wood` weeping willow trunk (`#582F0E`) with hanging `Leaf` curtains (`#52B788`), gravel path.
  - **Lighting:** `ClockTime = 17.5`, misty cool rain (`#8D99AE`, `FogEnd = 100`), warm golden sunbreak (`#FFD166`) piercing the willow leaves at 42s.
  - **VFX/SFX Cues:** Gentle rain `ParticleEmitter`, cocoa steam wisps; *CREAK*, *CLICK!*, *POUR*.

---

### Story 075: The Night-Shift Nurse

- **Header:**
  - **Story ID & Title:** Story 075 — The Night-Shift Nurse
  - **Format:** Standalone 50–56s (46 beats)
  - **Voice Preset:** `fast_mystery`
  - **Unstated Human Meaning:** Nobody should wake up in a quiet room feeling like nobody remembered they were there.

- **6-Phase Rule-Hack Narrative:**
  1. **0–2.5s Active Hook:**
     - **Spoken Line:** `"In this hospital, every kid who stays overnight in Ward 4 wakes up with a strange mark on their wrist—and nobody ever catches the night-shift nurse doing it!"`
     - **Frame 1 Visual:** Dimly lit hospital corridor at `2:15 AM`: a tall silhouette in dark navy scrubs glides silently past the nurses' station carrying a silver tray that glints under the red exit sign.
  2. **2.5–13.5s 3-Beat Rule Playground:**
     - **Absurd Public Disaster:** Last month, two kids in Ward 4 compared their wrists at breakfast and panicked that the silent `2:00 AM` nurse was tagging patients with invisible tracking bands.
     - **Town Adaptation:** Kids in the pediatric wing whisper "Stay awake past 2 AM," hiding their hands completely under the blankets whenever footsteps pass the door.
     - **3 Planted Ammo Clues:**
       1. *Clue 1 (The Empty Visitor Chair):* A bare plastic chair beside Bed #4 with zero flowers or get-well cards on the nightstand.
       2. *Clue 2 (The Silver Tray Cloth):* A `1.4 x 0.2 x 1.0` stud covered metal tray carried quietly by Nurse Elena at `2:00 AM`.
       3. *Clue 3 (The Faded Wrist Mark):* A faint red-and-blue thread pattern visible around the left wrist of a sleeping roommate.
  3. **13.5–21s Personal Trap & Crisis:**
     - Narrator gets admitted overnight after breaking his collarbone in a bike crash; his parents' car breaks down two towns away, leaving his visitor chair completely empty as the clock hits `2:10 AM` and soft rubber-soled footsteps stop right outside his curtain.
  4. **21–39s Rule-of-3 Failed Attempts:**
     - **Clue 1 Fail (The Blanket Tuck):** Narrator pulls the thin white sheet over his head and grips his wrists tight—*RUSTLE!*—the curtain rings slide quietly open anyway.
     - **Clue 2 Fail (The Call-Button Press):** Narrator mashes the red bedside call button—*CLICK!*—the night-shift nurse IS the one answering the corridor console.
     - **Clue 3 Fail (The Fake-Snore Freeze):** Narrator shuts his eyes and fakes a loud snore—*SHHH!*—the nurse leans gently over his bed rail and lifts his left wrist into the moonlight.
  5. **39–51s Genius Rule-Hack Climax:**
     - Narrator cracks one eye open ready to yell—and freezes: Nurse Elena isn't holding a needle or a scanner; she's carefully tying a soft, hand-braided red-and-blue *friendship bracelet* around his wrist, the exact same kind every kid with an empty visitor chair wakes up wearing—she spends her lunch breaks braiding them so no kid in Ward 4 wakes up feeling forgotten.
  6. **51–56s Action Echo Punchline:**
     - Narrator stops faking sleep, lifts his wrist slightly toward the moonlight, and whispers *"Can I pick the blue one next time?"*; Nurse Elena smiles warmly, tucks his blanket up, and whispers *"Deal."*

- **Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces):**
  - **Narrator (Leo, 13):** Patient | Skin `#F5CBA7` | R6 Outfit: Pale Blue Hospital Gown (`#90E0EF`), White Arm Sling (`#FFFFFF`), Messy Brown Hair (`#582F0E`) | Emotion Swaps: `scared` (0–39s) → `shocked` (39–48s) → `grin` (48–56s).
  - **Nurse Elena (45):** Night-Shift Nurse | Skin `#D4A373` | R6 Outfit: Dark Navy Scrubs (`#1D3557`), White Sneakers (`#F8F9FA`), Neat Braided Bun (`#1B1B1B`) | Emotion Swaps: `neutral` (0–42s) → `proud` (42–56s).

- **Props & Sockets (Sound-Off Visible):**
  - **Braided Friendship Bracelets (x8):** `0.5 x 0.15 x 0.5` studs | `Fabric` | `#E63946` / `#219EBC` / `#FFD166` | Socket: `Workspace` (Tray) → `LeftLowerArm` (Leo).
  - **Silver Nurse Tray:** `1.4 x 0.2 x 1.0` studs | `Metal` | `#CED4DA` | Socket: `LeftHand` (Nurse Elena).
  - **Empty Plastic Visitor Chair:** `1.8 x 2.8 x 1.8` studs | `SmoothPlastic` | `#457B9D` | Socket: `Workspace` (Beside Bed #4).

- **Sets/Scenes, Lighting & Camera:**
  - **Primary Set:** *Oakridge Hospital Pediatric Ward 4* — Pale mint `SmoothPlastic` walls (`#D8F3DC`), hospital bed with metal rails (`#CED4DA`), privacy curtain (`Fabric` `#E9ECEF`), moonlight window.
  - **Lighting:** `ClockTime = 2.2`, quiet silver moonlight (`#8D99AE`) through blinds, faint red corridor exit `PointLight` (`#FF0033`), soft warm bedside glow (`#FFE5B4`) at 42s.
  - **VFX/SFX Cues:** Soft curtain ring slide; *RUSTLE!*, *CLICK!*, quiet *SHHH!*, gentle *WHISPER*.


---

# StudVerse Tales — Production Bible: Stories 076–100

**Scope:** Category 4 (Dark-Hook-to-Wholesome-Flip: 076–080) & Category 5 (Hush-Hush & Scale-Multiplier: 081–100, with Story 089 replaced by **The Zipper-Tag Silence**).  
**Visual Standard:** Classic R6 rigs, `classic_v1` face swaps (`neutral`, `scared`, `shocked`, `grin`, `determined`, `proud`), sound-off visible stud-dimensioned props, and textured Roblox Studio sets.

---

## Story 076 — The Locked Attic

- **Story ID & Title:** `076` — The Locked Attic
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Love often hides behind strict boundaries when someone is trying to protect you from watching them fade.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In our house, Dad bolted three brass padlocks onto the attic door—and swore he’d ground us for a month if we touched them."
   - *Frame 1 Visual:* Low-angle close-up on a heavy oak attic ceiling hatch with three oversized glowing brass padlocks rattling as a muffled cough echoes from above.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Neighbor Billy bets his lunchbox that Dad is hiding gold bars, climbs the porch drainpipe to peek through the gable vent, and slips straight into Mrs. Gable’s prize hydrangea bush with a garden gnome stuck on his helmet.
   - *Town Adaptation:* Kids on Maple Street start trading "Attic Rumor Cards" at recess, sketching wild treasure maps of what Dad is hoarding upstairs.
   - *3 Named Planted Ammo Clues:*
     1. **Copper Skeleton Key** (hanging inside the hallway coat-closet behind Dad's rain poncho).
     2. **Blank Maxell-Style Cassette Tape** (dropped near the laundry hamper with a torn label reading *Ch. 7*).
     3. **Throat-Lozenge Tin** (empty, sitting beside Dad's mug on the kitchen counter).
3. **13.5–21s Personal Trap & Crisis:**
   - At 10:15 PM, Dad drives off for a late pharmacy run, leaving the attic floorboards creaking and a faint red light blinking under the hatch crack. My little sister Maya whispers that a monster is trapped up there—and grabs the broom to pry the hatch.
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I jam the **Copper Skeleton Key** into Padlock #1—*CLACK-SNAP!*—the key only turns the top lock, leaving two deadbolts jammed tight.
   - *Clue 2 Fail:* I boost Maya up to shove the **Blank Cassette Tape** into the door crack to trip the latch—*CRUNCH-BZZT!*—the plastic shell bends and drops onto the hallway rug.
   - *Clue 3 Fail:* I rattle the **Throat-Lozenge Tin** against the keyhole to mimic Dad's knock—*PING-THUD!*—the hatch stays sealed while Maya's eyes well up.
5. **39–51s Genius Rule-Hack Climax:**
   - I spot the **Copper Skeleton Key** isn't for the padlocks—it unlocks the *hallway laundry chute*, which connects straight up into the attic eaves! I crawl up the chute, push open the dusty vent, and freeze: no gold, no monster—just Dad's old tape recorder on a crate, stacks of labeled cassettes (*"Maya's 8th Birthday," "First Day of High School"*), and a doctor's note about his vocal cords failing.
6. **51–56s Action Echo Punchline:**
   - I quietly slide the **Blank Cassette Tape** into the recorder's open tray, press *RECORD*, whisper *"We love your voice, Dad,"* and pull the chute shut before his headlights hit the driveway.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Leo (Narrator, 12):** Protagonist. Skin: `#F5C29B`. Outfit: Blue striped hoodie (`Shirt`), dark denim jeans (`Pants`), messy brown swoop hair. Face swaps: `neutral` -> `scared` -> `determined` -> `proud`.
- **Maya (Little Sister, 7):** Sidekick. Skin: `#F5C29B`. Outfit: Yellow star tee (`Shirt`), overalls (`Pants`), twin pigtails. Face swaps: `scared` -> `shocked` -> `grin`.
- **Dad (Marcus, 42):** Misunderstood protector. Skin: `#E8B288`. Outfit: Charcoal flannel (`Shirt`), khaki work pants (`Pants`), short salt-and-pepper hair. Face swaps: `neutral` -> `determined` -> `proud`.
- **Billy (Neighbor Kid, 11):** Comic relief. Skin: `#FFCC99`. Outfit: Red varsity jacket (`Shirt`), cargo shorts (`Pants`), orange bike helmet. Face swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Three Brass Padlocks:** `0.8 x 1.0 x 0.4` studs each, `Metal`, `#D4AF37`, socketed to `Workspace` (attic hatch hasp).
- **Copper Skeleton Key:** `0.6 x 0.2 x 0.2` studs, `Metal`, `#B87333`, socketed to `RightHand`.
- **Cassette Tape:** `0.9 x 0.6 x 0.15` studs, `Plastic`, `#2B2B2B` with `#FFFFFF` label, socketed to `RightHand`.
- **Throat-Lozenge Tin:** `0.5 x 0.5 x 0.2` studs, `Metal`, `#2E8B57`, socketed to `RightHand`.
- **Cassette Recorder & Tape Stack:** `1.8 x 1.2 x 0.5` studs, `Plastic`/`Metal`, `#1C1C1C` with `#FF3B30` blinking LED, socketed to `Workspace` (attic crate) with `Head` `BillboardGui` labels on tapes.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Two-story suburban hallway (`WoodPlanks` floor `#8B5A2B`, `Plaster` walls `#EAE0D5`) with pull-down attic hatch and laundry-chute cabinet.
- **Secondary Set:** Dusty attic (`Wood` rafters `#5C4033`, `Fabric` cardboard boxes `#C2A378`).
- **Lighting & VFX/SFX:** `ClockTime = 22.3`, cool moonlight `#8EA8C8` through gable window, warm amber `#FFB347` desk lamp on recorder; VFX dust motes, SFX padlock rattle, tape click, soft static hum.

---

## Story 077 — The Alleyway Dog-Catcher

- **Story ID & Title:** `077` — The Alleyway Dog-Catcher
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Never judge someone by the cage they drive—judge them by where the road ends.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "Every Friday at dusk, the black dog-catcher van rumbles down Oak Alley—and every stray that climbs inside never comes back."
   - *Frame 1 Visual:* Rain-slicked alley; a rusted black van's rear doors slam shut with a heavy iron bar while a stray golden pup barks through the barred window.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* When the van stops at the stoplight, local skater Toby tries to "rescue" the dogs by yanking the rear handle—only for a spring-loaded net to launch him straight into a pile of cardboard pizza boxes.
   - *Town Adaptation:* Kids tape "DANGER: DOG VAN" flyers onto telephone poles and sprint inside whenever they hear its diesel rumble.
   - *3 Named Planted Ammo Clues:*
     1. **Squeaky Rubber Bone** (dropped from the van's side pocket onto the wet curb).
     2. **Muddy Tire Track** (stamped with red clay that doesn't exist anywhere in town).
     3. **Foil Dog-Treat Pouch** (stamped *"20-lb Bag — Heated Barn Delivery"*).
3. **13.5–21s Personal Trap & Crisis:**
   - My three-legged terrier, Sprout, slips his collar during a thunderstorm and trots straight toward the alley. The black van brakes beside him, and the tall driver steps out in a dripping poncho, lifting Sprout inside!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I sprint after the van squeezing the **Squeaky Rubber Bone** to lure Sprout out—*SQUEAK-SPLASH!*—the rain drowns the sound and the van turns onto the highway.
   - *Clue 2 Fail:* I trace the **Muddy Tire Track** on my BMX bike—*SKID-SLIP!*—my front wheel washes out in a ditch at the edge of town.
   - *Clue 3 Fail:* I check the **Foil Dog-Treat Pouch** address under a streetlight—*CRINKLE-THUD!*—the ink is smeared except for "Mile 4, Red Barn."
5. **39–51s Genius Rule-Hack Climax:**
   - I pedal flat-out to Mile 4, climb the split-rail fence expecting a dungeon—and freeze. A five-acre, solar-heated red barn glows warm golden inside, packed with thirty clean cedar kennels, fleece blankets, and the "scary" dog-catcher bottle-feeding a tiny puppy while Sprout munches beef stew!
6. **51–56s Action Echo Punchline:**
   - The driver looks up, sees me soaked, and tosses me a dry towel; I grab a broom, walk straight to the kennel row, and start sweeping kibble beside Sprout.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Sam (Narrator, 13):** Protagonist. Skin: `#D99B72`. Outfit: Green windbreaker (`Shirt`), black joggers (`Pants`), dark curly hair. Face swaps: `scared` -> `determined` -> `shocked` -> `proud`.
- **Mr. Vance (Dog-Catcher, 56):** Misunderstood hero. Skin: `#C68B59`. Outfit: Dark navy poncho (`Shirt`), heavy work boots/jeans (`Pants`), grey beard & cap. Face swaps: `neutral` -> `grin` -> `proud`.
- **Sprout (3-Legged Terrier):** Pet prop/rig. `SmoothPlastic` `#C88A4B` with white chest patch and blue collar.
- **Toby (Skater Kid, 12):** Comic foil. Skin: `#FFDBAC`. Outfit: Checkered tee (`Shirt`), ripped jeans (`Pants`), backwards red cap. Face swaps: `determined` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Black Dog-Catcher Van:** `14 x 7 x 6.5` studs, `Metal`, `#1E2022` with barred rear window, socketed to `Workspace`.
- **Squeaky Rubber Bone:** `1.0 x 0.4 x 0.4` studs, `Plastic`, `#FFD60A`, socketed to `RightHand`.
- **Foil Dog-Treat Pouch:** `1.1 x 1.4 x 0.3` studs, `Foil`, `#D9381E` with `Head` `BillboardGui` text `"HEATED BARN"`, socketed to `RightHand`.
- **Cedar Kennels & Fleece Beds:** `4 x 3 x 3` studs each, `Wood`/`Fabric`, `#B5651D` and `#FF6B6B`, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Wet brick alley (`Brick` walls `#5A3A31`, `Slate` wet asphalt `#2B2D2F`).
- **Secondary Set:** 5-acre Heated Red Barn (`WoodPlanks` red siding `#9E2A2B`, `Wood` loft floor `#C68B59`).
- **Lighting & VFX/SFX:** Alley at `ClockTime = 19.5` (storm blue `#3A4F6A` + rain particles); Barn interior warm `#FFB74D` point lights; SFX diesel idle, squeak, warm bark chorus.

---

## Story 078 — The Midnight Diner

- **Story ID & Title:** `078` — The Midnight Diner
- **Format:** Standalone 52s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** True generosity doesn't advertise its price—it just keeps the coffee hot for the people holding the town together.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "On Route 9, a neon diner only unlocks its doors from 1:00 to 3:00 AM—and every single item on the menu has zero prices."
   - *Frame 1 Visual:* Pitch-black highway; a lone retro chrome diner flickers pink neon *"OPEN 1–3 AM"*, while a shadowy chef flips pancakes behind steamy glass.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Daredevil Jake sneaks in at 1:05 AM expecting a "cursed bill," eats three waffles, bolts for the door, and trips straight over a stack of milk crates into the parking-lot snowbank.
   - *Town Adaptation:* High-schoolers park across the street with binoculars, daring each other to order and guessing what the "hidden catch" costs.
   - *3 Named Planted Ammo Clues:*
     1. **Hospital Scrubs Badge** (left clipped to a booth napkin dispenser).
     2. **Laminated Blank Menu** (every price column replaced with a tiny heart stamp).
     3. **Thermos Lid** (engraved *"Station 4 Engine Co."* sitting by the pie case).
3. **13.5–21s Personal Trap & Crisis:**
   - At 1:40 AM, my bike chain snaps two miles from home in freezing sleet. Shivering and out of cash, I push open the diner's brass bell—terrified the silent chef is about to demand something I can't pay.
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I slide the **Hospital Scrubs Badge** across the counter thinking it's an entry pass—*CLINK-SLIDE!*—the chef just sets it neatly by the register without looking up.
   - *Clue 2 Fail:* I point to the **Laminated Blank Menu** and stammer *"How much?"*—*TAP-SIZZLE!*—the chef points at the grill and pours hot cocoa anyway.
   - *Clue 3 Fail:* I try to offer my pocket watch beside the **Thermos Lid** as collateral—*CLANG-TICK!*—the chef slides my watch right back and places a steaming plate of pancakes in front of me.
5. **39–51s Genius Rule-Hack Climax:**
   - The bell jingles: two exhausted EMTs in **Hospital Scrubs** and three soot-covered firefighters from **Station 4** walk in, collapse into booths, and eat hot meals without pulling out a single wallet. The chef leans over my counter, taps a faded photo of his late firefighter son, and whispers: *"Night shift never pays here."*
6. **51–56s Action Echo Punchline:**
   - I finish my last bite, grab a rag from the stainless pass-through, and start wiping down the empty counter stools alongside the chef.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Nora (Narrator, 14):** Protagonist. Skin: `#F1C27D`. Outfit: Oversized maroon parka (`Shirt`), grey sweatpants (`Pants`), knit beanie. Face swaps: `scared` -> `shocked` -> `determined` -> `proud`.
- **Chef Arthur (64):** Retired chef. Skin: `#8D5524`. Outfit: White chef coat (`Shirt`), checkered chef pants (`Pants`), white mustache. Face swaps: `neutral` -> `grin` -> `proud`.
- **Jake (Daredevil Kid, 14):** Comic foil. Skin: `#FFDBAC`. Outfit: Letterman jacket (`Shirt`), jeans (`Pants`), spiky blonde hair. Face swaps: `grin` -> `shocked`.
- **Nurse Elena & Fireman Cole:** Night-shift regulars. Skin: `#E0AC69` / `#C68642`. Outfits: Teal scrubs / soot-streaked turnout jacket. Face swaps: `neutral` -> `grin`.

### Props & Sockets (Sound-Off Visible)
- **Neon "1–3 AM" Sign:** `5.0 x 1.8 x 0.4` studs, `Neon`, `#FF2A85`, socketed to `Workspace` (diner roof).
- **Laminated Blank Menu:** `1.0 x 1.4 x 0.05` studs, `Plastic`, `#FFF8E7` with red heart icons, socketed to `RightHand`.
- **Hospital Scrubs Badge:** `0.4 x 0.6 x 0.05` studs, `Plastic`, `#00B4D8`, socketed to `UpperTorso`.
- **Station 4 Thermos:** `0.6 x 1.2 x 0.6` studs, `Metal`, `#D62828`, socketed to `Workspace` (counter).
- **Steaming Pancake Stack:** `1.1 x 0.5 x 1.1` studs, `SmoothPlastic`, `#D4A373` with butter cube, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Retro Chrome Diner (`Metal` chrome trim `#C0C0C0`, `Marble` checkered tile floor `#FFFFFF`/`#1A1A1A`, red vinyl booths `#B22222`).
- **Secondary Set:** Snowy Route 9 Shoulder (`Snow` `#F0F8FF`, `Asphalt` `#2F3136`).
- **Lighting & VFX/SFX:** `ClockTime = 1.5`, exterior cold blue `#1E3A5F` vs. warm tungsten `#FFCA7A` interior glow; VFX rising steam particles, SFX grill sizzle, door bell chime.

---

## Story 079 — The Snowman Army

- **Story ID & Title:** `079` — The Snowman Army
- **Format:** Standalone 53s, 46 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Sometimes the scariest-looking obsession on the block is just someone trying to bring winter to a kid who can't step outside.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "Old Mr. Henderson spent all night building fifty silent snowmen—every single one staring straight at his neighbor's second-floor window."
   - *Frame 1 Visual:* Dawn blue snow yard; fifty identical snowmen with coal eyes arranged in military rows, all angled toward one dark upstairs bedroom window.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Neighborhood tough kid Brick throws a snowball at the front snowman's head—knocking off a hidden bucket of ice water that Mr. Henderson balanced for weight, soaking Brick's sneakers solid.
   - *Town Adaptation:* Kids cross to the opposite sidewalk on their way to school, whispering that the snowmen move an inch closer every night.
   - *3 Named Planted Ammo Clues:*
     1. **Neon Orange Carrot Nose** (shaped like a smiling crescent instead of a spike).
     2. **Chalk Poster Board** (propped behind Snowman #12 with *"LOOK UP"* scribbled in marker).
     3. **Wool Mittens** (tiny child-sized red mittens pinned onto the snowmen's stick arms).
3. **13.5–21s Personal Trap & Crisis:**
   - My paper-route bag rips right in front of Mr. Henderson's hedge, scattering twenty newspapers across his snowy lawn. As I creep between the frozen rows to grab them, the upstairs window curtains twitch—and Mr. Henderson steps onto his porch holding a wooden shovel!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I duck behind a snowman, accidentally knocking off its **Neon Orange Carrot Nose**—*THUMP-CRUNCH!*—the snowman's scarf slips, revealing bright party streamers underneath.
   - *Clue 2 Fail:* I grab the **Chalk Poster Board** to shield myself as I back up—*SCRAPE-SNAP!*—the board flips over, showing giant hand-drawn tic-tac-toe grids.
   - *Clue 3 Fail:* I trip over a **Wool Mitten** stick-arm—*WHOOSH-POOF!*—landing face-first in a snowbank right as Mr. Henderson reaches me.
5. **39–51s Genius Rule-Hack Climax:**
   - Mr. Henderson doesn't yell—he helps me up and points toward the second-floor window. The curtains part: a little girl in a hospital-style fleece robe with an IV pole behind her presses both hands to the glass, laughing as she plays giant lawn tic-tac-toe with Mr. Henderson's snowmen! She can't leave her room all winter, so he built the snow day to face her.
6. **51–56s Action Echo Punchline:**
   - I grab the **Chalk Poster Board**, draw a huge *"X"* in the center square, hold it high toward the window, and watch her draw an *"O"* on the frosted glass.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Eli (Narrator, 12):** Paperboy. Skin: `#E0AC69`. Outfit: Orange puffer vest (`Shirt`), jeans (`Pants`), knit ear-flap hat. Face swaps: `scared` -> `shocked` -> `grin` -> `proud`.
- **Mr. Henderson (71):** Neighbor. Skin: `#F5CBA7`. Outfit: Plaid wool coat (`Shirt`), snow pants (`Pants`), white beard & flat cap. Face swaps: `neutral` -> `grin` -> `proud`.
- **Clara (Neighbor Kid, 8):** Bedridden girl at window. Skin: `#F5CBA7`. Outfit: Lavender fleece robe (`Shirt`), soft beanie. Face swaps: `grin` -> `proud`.
- **Brick (Bully, 13):** Comic foil. Skin: `#D2996C`. Outfit: Black hoodie (`Shirt`), cargo pants (`Pants`), buzzcut. Face swaps: `determined` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **50 Snowmen Props:** `2.5 x 4.5 x 2.5` studs each, `Snow`, `#F8FAFC` with `#111111` coal eyes, socketed to `Workspace`.
- **Neon Orange Carrot Nose:** `0.6 x 0.25 x 0.25` studs, `SmoothPlastic`, `#FF6B00`, socketed to `RightHand`.
- **Chalk Poster Board:** `2.4 x 2.4 x 0.1` studs, `Plastic`, `#FFFFFF` with `BillboardGui` tic-tac-toe grid, socketed to `RightHand`.
- **Red Wool Mittens:** `0.4 x 0.5 x 0.2` studs, `Fabric`, `#D62828`, socketed to `Workspace` (snowman stick arms).

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Suburban Front Lawn (`Snow` terrain `#F4F9FC`, `Wood` picket fence `#ECECEC`).
- **Secondary Set:** Two-story Neighbor House Exterior (`Brick` `#8D5B4C`, glowing glass bedroom window `#FFF3B0`).
- **Lighting & VFX/SFX:** `ClockTime = 7.2`, crisp winter pink-blue sunrise `#A9C6E8`; VFX gentle falling snow particles; SFX snow crunch, window tap, cheerful chime.

---

## Story 080 — The Scary Principal's Drawer

- **Story ID & Title:** `080` — The Scary Principal's Drawer
- **Format:** Standalone 52s, 45 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Sometimes the strictest rule-keeper in the building is quietly building Christmas for kids who have nothing under the tree.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "Principal Steele confiscates every single toy in our school—and locks them inside a steel desk drawer nobody has ever seen opened."
   - *Frame 1 Visual:* Stern close-up of Principal Steele dropping a confiscated neon skateboard into a heavy brushed-steel drawer and turning a silver key with a sharp *CLICK*.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Class clown Zeke tries to sneak his slime jar past Steele by hiding it inside his tuba—only for one note to blast neon green slime all over the band room ceiling.
   - *Town Adaptation:* Kids run a black-market "Pocket-Toy Underground," hiding yoyos inside hollowed-out dictionaries so Steele's hallway patrols don't spot them.
   - *3 Named Planted Ammo Clues:*
     1. **Microfiber Polishing Cloth** (sticking out of Steele's blazer pocket).
     2. **Roll of Gold Gift Ribbon** (glimpsed under a stack of detention slips).
     3. **Shelter Delivery Clipboard** (resting upside-down on the filing cabinet).
3. **13.5–21s Personal Trap & Crisis:**
   - Steele catches me spinning my late grandpa's brass compass during math quiz, marches me to his office, and drops it into the locked drawer. At 4:30 PM, I sneak back into the empty office to steal my compass back before winter break!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I try to shim the drawer latch with a ruler, knocking over the **Microfiber Polishing Cloth**—*SWISH-CLATTER!*—the drawer stays deadlocked.
   - *Clue 2 Fail:* I tug the **Roll of Gold Gift Ribbon** jammed in the side seam—*RIP-SNAP!*—the ribbon tears and reveals a stack of folded wrapping paper.
   - *Clue 3 Fail:* I lift the **Shelter Delivery Clipboard** looking for a spare key—*THUD-CREAK!*—footsteps echo outside the office door and Principal Steele walks right in!
5. **39–51s Genius Rule-Hack Climax:**
   - I freeze, braced for expulsion—but Steele's stern face softens. He unlocks the steel drawer, pulls out my grandpa's compass, and hands it back without a word. Inside the drawer sit dozens of confiscated toys—every single one polished shiny, repaired, and wrapped with **Gold Gift Ribbon** tagged *"Oakwood Youth Shelter — Dec 24."*
6. **51–56s Action Echo Punchline:**
   - I set my compass safely in my pocket, pick up the **Roll of Gold Gift Ribbon**, and start tying bows onto two repaired toy trucks right across the desk from Steele.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Milo (Narrator, 12):** Protagonist. Skin: `#C68642`. Outfit: Mustard sweater (`Shirt`), navy chinos (`Pants`), short afro. Face swaps: `scared` -> `shocked` -> `determined` -> `proud`.
- **Principal Steele (54):** Stern principal. Skin: `#F1C27D`. Outfit: Charcoal three-piece suit (`Shirt`/`Pants`), silver-streaked slick hair, glasses. Face swaps: `neutral` -> `grin` -> `proud`.
- **Zeke (Band Kid, 12):** Comic foil. Skin: `#FFDBAC`. Outfit: School band polo (`Shirt`), black slacks (`Pants`), curly red hair. Face swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Locked Steel Desk Drawer:** `4.5 x 2.5 x 3.0` studs, `Metal`, `#4A4E69` with silver keyhole, socketed to `Workspace`.
- **Grandpa's Brass Compass:** `0.5 x 0.5 x 0.2` studs, `Metal`, `#D4AF37`, socketed to `RightHand`.
- **Microfiber Polishing Cloth:** `0.7 x 0.7 x 0.05` studs, `Fabric`, `#48CAE4`, socketed to `RightHand`.
- **Gold Gift Ribbon Roll:** `0.6 x 0.6 x 0.3` studs, `Plastic`, `#FFD700`, socketed to `RightHand`.
- **Shelter Delivery Clipboard:** `0.9 x 1.2 x 0.1` studs, `Wood`, `#8B5A2B` with `Head` `BillboardGui` `"YOUTH SHELTER"`, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Principal's Office (`WoodPlanks` mahogany desk `#5C3317`, `Brick` accent wall `#7A3E3E`, trophy case).
- **Secondary Set:** School Band Room (`Tile` linoleum `#D8D8D8`, brass tuba prop).
- **Lighting & VFX/SFX:** `ClockTime = 16.8` golden late-afternoon sunbeams `#FFB703` slanting through Venetian blinds; SFX key click, paper rustle, soft Christmas chime.

---

## Story 081 — Chalk-Circle Silence

- **Story ID & Title:** `081` — Chalk-Circle Silence
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Any rule meant to silence you can be turned into a shield if you know where to stand.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In this town, every word you speak outside a white chalk circle instantly freezes into falling black glass."
   - *Frame 1 Visual:* Close-up of a kid whispering outside a sidewalk chalk ring—jagged obsidian glass shards materialize mid-air from his mouth and shatter on the pavement.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* When the pizza delivery guy yells *"Order for Miller!"* from his bike outside the chalk zone, a six-foot slab of black glass drops onto his handlebars and folds his bike in half.
   - *Town Adaptation:* Everyone carries thick sidewalk chalk in their pockets, drawing quick white rings on crosswalks before asking for directions.
   - *3 Named Planted Ammo Clues:*
     1. **Jumbo Sidewalk Chalk** (snapped in half inside my hoodie pocket).
     2. **Coach's Battery Megaphone** (resting on the bleachers beside the school gate).
     3. **Rubber Rain Boots** (thick-soled boots sitting by the crossing guard stand).
3. **13.5–21s Personal Trap & Crisis:**
   - At 3:10 PM, a parked delivery truck loses its brakes at the top of Elm Hill and barrels straight toward the kindergarten crosswalk—right where my little brother Sam is frozen inside a tiny chalk ring!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I sprint toward the truck trying to draw a giant chalk barrier with my **Jumbo Sidewalk Chalk**—*SCRAPE-SNAP!*—the chalk crumbles to dust on the rough asphalt.
   - *Clue 2 Fail:* I kick on the **Rubber Rain Boots** and try to stomp a warning—*THUD-THUD!*—silent footsteps don't trigger any glass at all.
   - *Clue 3 Fail:* I yell *"STOP!"* from inside my own chalk ring—*ECHO-SILENCE!*—inside the ring, zero glass spawns and the truck keeps barreling down!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—words *outside* the chalk circle spawn falling black glass proportional to volume! I snatch the **Coach's Battery Megaphone**, step one foot *outside* the chalk circle, aim the horn ten feet in front of the truck's bumper, and scream *"WALL!"* at max volume—*BWAAM-SHATTER!* A twelve-foot wall of solid black glass drops across the street, stopping the runaway truck dead in its tracks!
6. **51–56s Action Echo Punchline:**
   - The truck airbags pop; I step cleanly back inside Sam's chalk ring, hand him the **Jumbo Sidewalk Chalk**, and grin while he draws a crown around both of us.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Devon (Narrator, 13):** Protagonist. Skin: `#8D5524`. Outfit: Grey zip hoodie (`Shirt`), black cargo pants (`Pants`), short fade. Face swaps: `scared` -> `determined` -> `shocked` -> `proud`.
- **Sam (Little Brother, 6):** Sidekick. Skin: `#8D5524`. Outfit: Red dinosaur tee (`Shirt`), denim shorts (`Pants`), mini afro. Face swaps: `scared` -> `grin`.
- **Pizza Guy (19):** Comic foil. Skin: `#FFDBAC`. Outfit: Striped polo (`Shirt`), khaki pants (`Pants`), red visor. Face swaps: `determined` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **White Chalk Circle:** `6.0 x 0.05 x 6.0` studs, `Neon`/`SmoothPlastic` ring, `#FFFFFF`, socketed to `Workspace`.
- **Black Glass Shards / Wall:** `12.0 x 8.0 x 1.2` studs, `Glass`, `#0B090A`, socketed to `Workspace`.
- **Coach's Battery Megaphone:** `1.2 x 0.9 x 0.9` studs, `Plastic`, `#E63946` with white horn, socketed to `RightHand`.
- **Jumbo Sidewalk Chalk:** `0.8 x 0.3 x 0.3` studs, `Slate`, `#FFFFFF`, socketed to `RightHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Elm Hill School Crosswalk (`Asphalt` `#2B2D42`, painted yellow crosswalk stripes `#FFD166`, `Brick` school fence).
- **Secondary Set:** Bleachers & Crossing Guard Stand (`Wood` benches `#A47148`).
- **Lighting & VFX/SFX:** `ClockTime = 16.8`, crisp late-afternoon sun `#FFD180`; VFX shimmering obsidian fracture particles; SFX megaphone feedback, crystal-heavy glass drop.

---

## Story 082 — Staggered-Blink Town

- **Story ID & Title:** `082` — Staggered-Blink Town
- **Format:** Standalone 53s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Sometimes keeping the world steady just means one person refusing to close their eyes at the wrong second.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Cliffside Town, if everyone on your street blinks at the exact same second, the entire block slides ten feet toward the ocean cliff."
   - *Frame 1 Visual:* Wide shot of colorful suburban houses perched on a crumbling cliff edge; three kids blink simultaneously—*RUMBLE!*—and the whole street jerks forward, spilling trash cans.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* During a school assembly flash photo, forty students blink at once—*SLIDE!*—and the gymnasium bleachers skate ten feet across the polished court.
   - *Town Adaptation:* Neighbors wear glowing neon countdown watches that beep in alternating shifts—*ODD BLINK, EVEN BLINK*—so half the street always keeps one eye open.
   - *3 Named Planted Ammo Clues:*
     1. **Pirate Eyepatch** (left in my backpack from last week's history skit).
     2. **Compact Pocket Mirror** (taped to my bike handlebars).
     3. **Cracked Blink-Shift Watch** (stuck on `00:00` after recess).
3. **13.5–21s Personal Trap & Crisis:**
   - At 4:50 PM, a sudden gust of coastal wind blows yellow pollen straight down Oak Street. My **Cracked Blink-Shift Watch** dies, and every neighbor on the block squeezes their eyes shut against the pollen—leaving the street eight feet from the cliff drop!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I clamp my eyelids open with my fingers—*STING-WATER!*—the pollen burns so hard my left eye slams shut anyway.
   - *Clue 2 Fail:* I shout *"ODD SHIFT, OPEN!"*—*WHOOSH-RUMBLE!*—nobody hears me over the wind and the asphalt cracks two feet wider.
   - *Clue 3 Fail:* I hold up the **Compact Pocket Mirror** to check who's still awake—*FLASH-GLINT!*—every single face in the mirror has both eyes squeezed shut!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—if *one* eye stays open, it doesn't count as a full blink! I slap the **Pirate Eyepatch** over my stinging left eye so only my right eye faces the wind, shield it with the **Compact Pocket Mirror** angled like a periscope, and sprint down the center line shouting *"ALTERNATE!"* My single open eye breaks the simultaneous-blink lock—the grinding asphalt halts one inch from the cliff edge!
6. **51–56s Action Echo Punchline:**
   - Neighbors pop their eyes open, see the cliff drop, and immediately trade eyepatches from the corner costume bin while I wink through my mirror.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Kai (Narrator, 13):** Protagonist. Skin: `#E8B288`. Outfit: Teal hoodie (`Shirt`), black jeans (`Pants`), messy black hair. Face swaps: `determined` -> `scared` -> `shocked` -> `proud`.
- **Mrs. Ortiz (Neighbor, 48):** Town resident. Skin: `#D99B72`. Outfit: Yellow cardigan (`Shirt`), blue jeans (`Pants`), bun hairstyle. Face swaps: `scared` -> `grin`.
- **Coach Miller (38):** Gym teacher. Skin: `#FFDBAC`. Outfit: Red track jacket (`Shirt`), grey shorts (`Pants`), whistle. Face swaps: `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Pirate Eyepatch:** `0.5 x 0.4 x 0.1` studs, `Fabric`, `#111111` strap, socketed to `Head`.
- **Compact Pocket Mirror:** `0.6 x 0.6 x 0.1` studs, `Metal`/`Glass`, `#C0C0C0` reflective face, socketed to `RightHand`.
- **Blink-Shift Watch:** `0.4 x 0.4 x 0.2` studs, `Neon`, `#00F5D4` with `BillboardGui` `"ODD/EVEN"`, socketed to `LeftHand`.
- **Cliff Edge Asphalt Slab:** `40 x 4 x 24` studs, `Asphalt`, `#2B2D2F` with crack decals, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Cliffside Oak Street (`Asphalt` road `#2B2D2F`, `Grass` lawn `#4F772D`, `Rock` cliff drop `#5C5552`).
- **Secondary Set:** School Gym Bleachers (`Wood` court `#D4A373`).
- **Lighting & VFX/SFX:** `ClockTime = 16.8`, golden coastal sunset `#FFAD5A` + wind-blown yellow pollen particles; SFX ground-grinding bass rumble, watch beep, camera shutter.

---

## Story 083 — Floating Sound-Bubbles

- **Story ID & Title:** `083` — Floating Sound-Bubbles
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** When every loud mistake hangs in the air, you don't silence the noise—you steer it away from what matters.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "After 9 PM in our town, every loud footstep spawns a glowing sound-bubble—and if ten bubbles touch, they pop into a siren that summons the Night Warden."
   - *Frame 1 Visual:* Dark moonlit alley; a kid's sneaker slams onto a grate, spawning a hovering translucent cyan orb that drifts slowly toward nine other orbs bobbing near a lamppost.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Trash-panda-chasing neighbor Mr. Klutz drops a metal lid at 9:05 PM, spawning eight bubbles at once that bump into two stray bubbles—*BWOOP-BWOOP!*—and the Night Warden's spotlight sweeps him straight into a hedge.
   - *Town Adaptation:* Kids wrap thick wool socks over their sneakers after sunset and carry handheld battery fans to blow stray bubbles apart before they cluster.
   - *3 Named Planted Ammo Clues:*
     1. **Fuzzy Wool Socks** (pulled over my sneakers in my backpack).
     2. **Mini Handheld Fan** (clipped to my belt loop).
     3. **Bubble-Wand Hoop** (left on the porch railing by my little sister).
3. **13.5–21s Personal Trap & Crisis:**
   - At 9:30 PM, I'm sneaking home past the town square with my dad's birthday cake when a stray alley cat knocks over a stack of empty soda cans! Nine huge glowing bubbles rise around me—and one tiny bubble drifts straight toward the cluster!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I tiptoe in my **Fuzzy Wool Socks** trying to dodge the cluster—*SHUFFLE-FLOAT!*—my sleeve brushes two bubbles closer together!
   - *Clue 2 Fail:* I switch on the **Mini Handheld Fan** to scatter them—*WHIRR-PUSH!*—the fan only blows the tenth bubble faster toward the nine-bubble cluster!
   - *Clue 3 Fail:* I swipe at the tenth bubble with the **Bubble-Wand Hoop**—*POP-ZAP!*—my finger misses and the tenth bubble is two inches from touching!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—if *ten* touching bubbles pop into a siren, I can't let the tenth touch the nine... UNLESS I catch it with the **Bubble-Wand Hoop** first and blow *one* fresh bubble with my **Mini Handheld Fan** toward the *far* side of the alley! I scoop the tenth bubble onto the soap-filmed hoop, pivot 180 degrees, and blast it into a single stray bubble by the dumpster—zero ten-bubble chain! Better yet, I deliberately pop a tenth cluster *across the street* by tapping two trash cans, sending the Night Warden chasing the empty alley while I slip home with the cake!
6. **51–56s Action Echo Punchline:**
   - I step onto my porch in wool socks, set the birthday cake safely on the kitchen table, and hang the **Bubble-Wand Hoop** on the hook like a sheriff's badge.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Toby (Narrator, 13):** Protagonist. Skin: `#F5C29B`. Outfit: Dark blue hoodie (`Shirt`), grey sweatpants (`Pants`), wool-wrapped sneakers, brown hair. Face swaps: `scared` -> `determined` -> `shocked` -> `proud`.
- **Night Warden (45):** Town enforcer. Skin: `#C68642`. Outfit: Charcoal trenchcoat (`Shirt`), black boots (`Pants`), glowing visor helmet. Face swaps: `neutral` -> `determined`.
- **Mr. Klutz (52):** Neighbor comic relief. Skin: `#FFDBAC`. Outfit: Striped robe (`Shirt`), slippers (`Pants`), bald head. Face swaps: `shocked` -> `scared`.

### Props & Sockets (Sound-Off Visible)
- **Glowing Sound-Bubbles (x10):** `1.2 x 1.2 x 1.2` studs each, `ForceField`/`Neon`, `#00E5FF`, socketed to `Workspace`.
- **Mini Handheld Fan:** `0.5 x 0.8 x 0.3` studs, `Plastic`, `#FFBE0B`, socketed to `RightHand`.
- **Bubble-Wand Hoop:** `0.4 x 0.9 x 0.1` studs, `Plastic`, `#FF006E`, socketed to `LeftHand`.
- **Birthday Cake Box:** `1.4 x 0.8 x 1.4` studs, `SmoothPlastic`, `#FFFFFF` with `#FF6B6B` ribbon, socketed to `UpperTorso` (carried front).

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Moonlit Town Square Alley (`Cobblestone` ground `#3D405B`, `Brick` walls `#5C3A21`, metal dumpsters).
- **Secondary Set:** Suburban Porch (`WoodPlanks` `#8B5A2B`).
- **Lighting & VFX/SFX:** `ClockTime = 21.5`, cool indigo moonlight `#3A506B` + cyan bubble point lights; VFX siren red-blue pulse; SFX soft bubble hum, fan whirr, distant klaxon.

---

## Story 084 — 12 Words a Day

- **Story ID & Title:** `084` — 12 Words a Day
- **Format:** Standalone 52s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** When every word costs gold, the richest thing you can ever spend is the sentence that saves someone else.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Goldmouth City, you only get twelve spoken words a day—and every unused word turns into a solid gold coin at midnight."
   - *Frame 1 Visual:* Close-up of a boy's glowing `[12 / 12 WORDS]` wrist counter ticking down to `[11 / 12]` as he whispers *"Morning"* and a single word-spark fades.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Town chatterbox Ricky gets hyped over a skateboard trick, yells *"BRO DID YOU SEE THAT FLIP NO WAY!"* and watches his counter hit `[0 / 12]` at 8:05 AM—leaving him miming wildly for a bus pass all day.
   - *Town Adaptation:* Everyone communicates with dry-erase neck boards and hand-bell clicks so they can cash in twelve gold coins every midnight.
   - *3 Named Planted Ammo Clues:*
     1. **Dry-Erase Neck Board** (hanging from a lanyard around my neck, marker capped).
     2. **Brass Desk Bell** (in my jacket pocket for yes/no clicks).
     3. **Voice-Locked Basement Padlock** (old family storm-shelter lock keyed only to the spoken phrase *"Open Sesame"*).
3. **13.5–21s Personal Trap & Crisis:**
   - At 11:52 PM—eight minutes before my twelve unused words turn into twelve gold coins to pay mom's rent—a storm surge floods the street and traps my little sister Chloe inside the voice-locked storm basement! My counter reads `[1 / 12 WORDS]`, and the lock requires *two* words: *"Open Sesame!"*
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I scribble *"OPEN SESAME"* on my **Dry-Erase Neck Board** and press it to the voice mic—*BEEP-ERROR!*—the lock only accepts live human speech.
   - *Clue 2 Fail:* I slam the **Brass Desk Bell** against the mic trying to trigger a frequency—*DING-CLANK!*—the red LED flashes *"VOICE ONLY."*
   - *Clue 3 Fail:* I check my wrist counter—`[1 / 12]`—if I say *"Open"*, I'll hit `[0 / 12]` and go mute before saying *"Sesame"*!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—a *compound* or *single* breath? No—Chloe is inside the door, and *she* hasn't spoken all day! I tap Morse code on the steel door with my **Brass Desk Bell**, hold up my **Dry-Erase Neck Board** to the basement slit showing *"SAY: OPEN"*, and wait. Chloe whispers *"Open!"* from inside—then I spend my final `[1 / 12]` word yelling *"SESAME!"*—*CLICK-CLANK!* Both half-locks snap open at 11:59 PM!
6. **51–56s Action Echo Punchline:**
   - The basement door swings wide; Chloe sprints into my arms, and at midnight, zero gold coins drop into my pocket—so I just grin and hand her the **Dry-Erase Neck Board** to draw a smiley face.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Lucas (Narrator, 14):** Protagonist. Skin: `#F1C27D`. Outfit: Navy crewneck (`Shirt`), khaki pants (`Pants`), brown tousled hair. Face swaps: `determined` -> `scared` -> `shocked` -> `proud`.
- **Chloe (Little Sister, 9):** Trapped inside. Skin: `#F1C27D`. Outfit: Pink rain jacket (`Shirt`), jeans (`Pants`), braided hair. Face swaps: `scared` -> `grin`.
- **Ricky (Chatterbox, 13):** Comic foil. Skin: `#E0AC69`. Outfit: Neon green hoodie (`Shirt`), skater shorts (`Pants`), backwards cap. Face swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Word-Counter Wristband:** `0.4 x 0.4 x 0.25` studs, `Neon`, `#FFD700` with `Head` `BillboardGui` `"[1 / 12]"`, socketed to `LeftHand`.
- **Dry-Erase Neck Board:** `1.2 x 0.8 x 0.08` studs, `Plastic`, `#FFFFFF` with black marker text, socketed to `UpperTorso`.
- **Brass Desk Bell:** `0.5 x 0.4 x 0.5` studs, `Metal`, `#D4AF37`, socketed to `RightHand`.
- **Voice-Locked Basement Door:** `4.5 x 6.0 x 0.5` studs, `Metal`, `#4A4E69` with glowing red/green mic light, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Flooded Suburban Backyard (`Grass` `#386641`, `Concrete` storm cellar steps `#6C757D`, rising water plane `#4EA8DE`).
- **Secondary Set:** School Bus Stop (`Asphalt` `#2B2D42`).
- **Lighting & VFX/SFX:** `ClockTime = 23.8`, stormy blue lightning flashes `#90E0EF`; VFX gold coin dissolve particles; SFX digital counter tick, bell ding, heavy bolt unlock.

---

## Story 085 — Promise Ropes

- **Story ID & Title:** `085` — Promise Ropes
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** A promise isn't a chain that holds you back—it's the lifeline you grab when gravity tries to win.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In this town, saying 'I promise' snaps an unbreakable glowing rope between your wrists—and if you break it, it yanks you together at sixty miles an hour."
   - *Frame 1 Visual:* Close-up of two kids pinky-swearing; a braided golden energy tether snaps taut between their wrists with a crisp *ZING!*
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Class slacker Chad promises *"I'll study at 4 PM"* just to leave early, walks straight into the arcade instead, and gets launched backward through the arcade glass door at 60 mph straight onto his tutor's lawn!
   - *Town Adaptation:* Kids refuse to say the P-word lightly—using *"I'll try"* shields and wearing padded leather wrist guards just in case.
   - *3 Named Planted Ammo Clues:*
     1. **Leather Wrist Guards** (strapped to my forearms).
     2. **School Bus Steel Tow-Hook** (bolted under the front bumper of Bus #14).
     3. **Oak Tree Trunk** (thick, rooted ten feet back from Canyon Overlook).
3. **13.5–21s Personal Trap & Crisis:**
   - On the field-trip ride home, ice sends Bus #14 skidding off Canyon Overlook! The front wheels hang half over the 200-foot drop, teetering on crumbling gravel while thirty kids scramble toward the back door!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I brace my feet against the **Oak Tree Trunk** and grab the bus bumper—*SCRAPE-SLIP!*—the bus weighs ten tons and drags me toward the ledge!
   - *Clue 2 Fail:* Driver Hank floors reverse—*SCREECH-SPIN!*—the rear tires spin uselessly on black ice and the nose dips another foot!
   - *Clue 3 Fail:* I try looping a regular gym rope around the **School Bus Steel Tow-Hook**—*TWANG-SNAP!*—the nylon rope shreds in half!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—a broken promise yanks two tethered points together at *60 mph* with unbreakable force! I wrap my **Leather Wrist Guards** tight, shout to Driver Hank: *"Promise me you'll stay inside the bus!"* Hank yells *"I PROMISE!"*—a golden **Promise Rope** snaps between our wrists. I loop my wrist-tether around the **Oak Tree Trunk**, step behind it, and yell *"BREAK IT, HANK—JUMP OUT THE BACK DOOR!"* The instant Hank's boots hit the snow outside the bus, the promise breaks—*BOOM-WHOOSH!* The unbreakable rope yanks the bus ten feet back onto solid road!
6. **51–56s Action Echo Punchline:**
   - Both of us tumble into the snowbank rubbing our wrists; Hank looks at the safe bus, looks at me, and mutters *"I promise I'm buying hot cocoa."*

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Marcus (Narrator, 14):** Protagonist. Skin: `#8D5524`. Outfit: Red flannel (`Shirt`), dark jeans (`Pants`), leather wrist guards, short fade. Face swaps: `determined` -> `scared` -> `shocked` -> `proud`.
- **Driver Hank (58):** Bus driver. Skin: `#F1C27D`. Outfit: Yellow safety vest over blue shirt (`Shirt`), navy slacks (`Pants`), grey cap. Face swaps: `scared` -> `determined` -> `grin`.
- **Chad (Slacker, 14):** Comic foil. Skin: `#FFDBAC`. Outfit: Purple hoodie (`Shirt`), ripped jeans (`Pants`), spiky hair. Face swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Glowing Promise Rope:** `0.25 x 0.25 x 12.0` studs (beam/rod), `Neon`, `#FFD700`, socketed between `LeftHand` and target `LeftHand`.
- **Leather Wrist Guards:** `0.45 x 0.5 x 0.45` studs, `Leather`, `#5C4033`, socketed to `LeftHand`/`RightHand`.
- **School Bus #14:** `18 x 8 x 7` studs, `Metal`, `#FFB703` with black stripe & steel tow-hook, socketed to `Workspace`.
- **Oak Tree Trunk:** `4.0 x 14.0 x 4.0` studs, `Wood`, `#4A3520`, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Canyon Overlook Road (`Asphalt` `#2F3136`, `Ice` patches `#CAF0F8`, `Rock` cliff `#5C5552`).
- **Secondary Set:** Arcade Front Sidewalk (`Concrete` `#ADB5BD`, neon sign).
- **Lighting & VFX/SFX:** `ClockTime = 16.5`, crisp winter overcast `#B8D0EB`; VFX golden rope sparks, tire smoke; SFX rope snap, tire screech, metallic crunch.

---

## Story 086 — Accusation Iron Backpacks

- **Story ID & Title:** `086` — Accusation Iron Backpacks
- **Format:** Standalone 53s, 46 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** When someone weaponizes false blame, their own lie can become the exact hammer that breaks the lock.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In this school, if anyone falsely accuses you of stealing something, an iron replica of that exact item spawns inside your backpack."
   - *Frame 1 Visual:* School hallway; a bully points at a kid yelling *"He stole my bike!"*—*CLANG!*—a 40-lb solid iron bicycle crushes the kid's backpack straight to the tile floor.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Drama queen Chloe accuses her desk-mate of stealing her *"giant inflatable flamingo,"* and a 60-lb iron flamingo bursts through the kid's zipper in the middle of algebra.
   - *Town Adaptation:* Kids wear clear mesh backpacks and keep receipts taped to their shirts to prove they didn't take anything.
   - *3 Named Planted Ammo Clues:*
     1. **Clear Mesh Backpack** (worn backwards on my chest for quick release).
     2. **Construction-Site Wrecking Ball Poster** (taped to the hallway bulletin board outside the gym).
     3. **Jammed Steel Fire Door** (rusted shut at the end of the smoke-filled science wing).
3. **13.5–21s Personal Trap & Crisis:**
   - A chemistry lab burner tips over, filling the basement hallway with thick grey smoke—and the **Jammed Steel Fire Door** won't budge! Worse, school bully Vance blocks the stairs yelling *"He stole my golden trophy!"*—dropping a 30-lb iron trophy into my bag!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I ram the **Jammed Steel Fire Door** with my shoulder—*THUD-OW!*—the steel deadbolt doesn't even rattle.
   - *Clue 2 Fail:* I swing the 30-lb iron trophy from my **Clear Mesh Backpack** at the door latch—*PING-BOUNCE!*—it barely scratches the paint.
   - *Clue 3 Fail:* I try prying the hinges with a metal mop handle—*BEND-SNAP!*—the handle folds in half as smoke thickens!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—false accusations spawn *solid iron replicas* of whatever the accuser names! I rip the **Construction-Site Wrecking Ball Poster** off the board, thrust my **Clear Mesh Backpack** strap through the fire-door handle, and yell at Vance: *"Yeah, Vance—just like I stole that 4-ton wrecking ball outside!"* Vance smirks and shouts: *"HE STOLE THE WRECKING BALL!"*—*KA-CLANG-BOOM!* A massive 4-ton solid iron wrecking ball spawns inside my backpack, swings straight down on the strap, and smashes the **Jammed Steel Fire Door** clean off its hinges!
6. **51–56s Action Echo Punchline:**
   - Fresh air rushes in; every kid sprints out to the courtyard while I unclip my shredded mesh straps and leave Vance staring at the flattened steel door.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Owen (Narrator, 13):** Protagonist. Skin: `#FFDBAC`. Outfit: Green polo (`Shirt`), khaki pants (`Pants`), brown side-part hair. Face swaps: `scared` -> `determined` -> `grin` -> `proud`.
- **Vance (Bully, 14):** Antagonist. Skin: `#E0AC69`. Outfit: Black leather jacket (`Shirt`), dark jeans (`Pants`), slick pompadour. Face swaps: `grin` -> `shocked`.
- **Chloe (Classmate, 13):** Comic foil. Skin: `#F5C29B`. Outfit: Pink sweater (`Shirt`), pleated skirt (`Pants`), blonde ponytail. Face swaps: `determined` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Clear Mesh Backpack:** `1.4 x 1.8 x 0.9` studs, `Glass` (translucent) `#DCEEF2`, socketed to `UpperTorso`.
- **Iron Trophy Replica:** `0.8 x 1.2 x 0.8` studs, `Metal`, `#4A4E69`, socketed to `Workspace`/`UpperTorso`.
- **4-Ton Iron Wrecking Ball:** `4.0 x 4.0 x 4.0` studs, `Metal`, `#2B2D42` with chain link, socketed to `Workspace`.
- **Jammed Steel Fire Door:** `4.5 x 7.5 x 0.5` studs, `Metal`, `#C1121F` with `"EXIT"` `BillboardGui`, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Smoke-Filled Science Hallway (`Tile` floor `#E5E5E5`, `Brick` lockers `#457B9D`, red fire door).
- **Secondary Set:** School Courtyard (`Grass` `#52B788`).
- **Lighting & VFX/SFX:** `ClockTime = 14.0`, hallway emergency red strobe `#FF2A2A` + thick grey smoke particles; SFX heavy iron clang, door smash, alarm bell.

---

## Story 087 — Compliment Float vs. Roast Gravity

- **Story ID & Title:** `087` — Compliment Float vs. Roast Gravity
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Sweet words can lift you off your feet, but sometimes it takes brutal honesty to keep the people you love grounded.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Buoyant Heights, every genuine compliment makes you float upward—and every honest roast adds fifty pounds straight to your shoes."
   - *Frame 1 Visual:* Schoolyard; a girl tells her friend *"Your painting is incredible!"*—and the painter's sneakers lift three feet off the asphalt like a helium balloon!
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Over-eager Grandma praises Uncle Bob's *"world-famous chili"* ten times in a row—sending Bob drifting straight into the living-room ceiling fan until he yells *"My hair looks terrible!"* to drop back down.
   - *Town Adaptation:* Kids carry pocket "Roast Notebooks" full of mild truths (*"Your handwriting looks like a sneeze"*) to stay anchored on windy days.
   - *3 Named Planted Ammo Clues:*
     1. **Pocket Roast Notebook** (tucked into my back jeans pocket).
     2. **Helium-Light Canvas Sneakers** (worn by my little brother Leo).
     3. **Storm-Cloud Updraft** (swirling dark funnel forming over the soccer field).
3. **13.5–21s Personal Trap & Crisis:**
   - At recess, the whole kindergarten class cheers Leo's goal—*"Best kicker ever! Superstar! Legend!"*—just as the **Storm-Cloud Updraft** hits! Twelve compliments stack at once, yanking Leo forty feet into the sky toward power lines!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I leap up and grab his shoelace—*WHOOSH-TUG!*—the updraft lifts *both* of us higher off the grass!
   - *Clue 2 Fail:* I yell *"Nice try, kid—uh, I mean bad kick!"*—*BUZZ-NOTHING!*—fake insults don't trigger gravity at all!
   - *Clue 3 Fail:* I fumble open the **Pocket Roast Notebook**—*FLAP-TEAR!*—the wind rips three pages out before I can read them!
5. **39–51s Genius Rule-Hack Climax:**
   - Only *100% honest* roasts add 50 lbs per roast! Looking straight at Leo's goofy grin, I shout three brutal, undeniable truths from the heart: *"Leo, you still sleep with a nightlight! You put ketchup on pancakes! And your haircut looks like a mop!"*—*THUD-THUD-THUD!* Three 50-lb lead weights snap onto Leo's **Canvas Sneakers**, dropping us both cleanly onto the soccer turf!
6. **51–56s Action Echo Punchline:**
   - Leo lands in the mud, glares at me for two seconds, then grins and fires back: *"Yeah, well your socks don't match!"*—anchoring my own floating heel right back to the grass.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Maya (Narrator, 13):** Protagonist. Skin: `#C68642`. Outfit: Yellow windbreaker (`Shirt`), blue jeans (`Pants`), curly ponytail. Face swaps: `scared` -> `determined` -> `shocked` -> `proud`.
- **Leo (Little Brother, 8):** Floating sibling. Skin: `#C68642`. Outfit: Soccer jersey (`Shirt`), black shorts (`Pants`), messy mop-top hair. Face swaps: `grin` -> `scared` -> `proud`.
- **Uncle Bob (44):** Comic foil. Skin: `#F1C27D`. Outfit: Apron over polo (`Shirt`), khakis (`Pants`), mustache. Face swaps: `proud` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Pocket Roast Notebook:** `0.6 x 0.8 x 0.1` studs, `Plastic`, `#E63946`, socketed to `RightHand`.
- **Weighted Anchor Sneakers:** `0.8 x 0.5 x 1.2` studs, `Metal`/`Fabric`, `#4A4E69` glowing heavy aura, socketed to `LeftFoot`/`RightFoot`.
- **Upward Float Aura:** `2.0 x 3.0 x 2.0` studs, `ForceField`, `#FFD166`, socketed to `UpperTorso`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Soccer Field (`Grass` `#52B788` with white chalk lines, goalposts, power-line poles).
- **Secondary Set:** Suburban Living Room (`Wood` floor `#8B5A2B`).
- **Lighting & VFX/SFX:** `ClockTime = 15.5`, dramatic storm-slate sky `#4A5759`; VFX wind streaks, upward sparkle vs. heavy lead-drop dust ring; SFX whoosh, cartoon anvil thuds.

---

## Story 088 — The Floor-Is-Glass Rule

- **Story ID & Title:** `088` — The Floor-Is-Glass Rule
- **Format:** Standalone 52s, 45 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** When the ground beneath you turns fragile, every step forward depends on building a bridge with whatever's within reach.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "Inside Oakridge Middle, stepping anywhere without shoes leaves glowing footprints that crack the floor straight into the basement."
   - *Frame 1 Visual:* School hallway; a kid's bare sock touches tile—*CRACK-KRRK!*—a spiderweb of neon blue fractures races outward under his heel.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* During gym dodgeball, Tyler kicks off his untied sneaker to run faster, takes three barefoot steps, and drops half the bleachers six feet into the boiler-room storage!
   - *Town Adaptation:* Teachers double-knot students' laces at morning homeroom and line hallways with foam yoga mats as emergency stepping stones.
   - *3 Named Planted Ammo Clues:*
     1. **Unlaced Gym Sneakers** (locked inside my jammed locker #42).
     2. **Rolling Swivel Desk Chairs** (lined along Room 204's back wall).
     3. **Cardboard Textbook Boxes** (stacked beside the janitor's cart).
3. **13.5–21s Personal Trap & Crisis:**
   - After swim-team locker check, someone swaps my sneakers as a prank—leaving me barefoot in Room 204 when the fire drill rings! Every step on the tile threatens to shatter the floor under the whole class!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I hop onto a student desk and leap toward the hallway—*CRACK-SNAP!*—my toe grazes the tile and a glowing fissure splits the doorway!
   - *Clue 2 Fail:* I toss a **Cardboard Textbook Box** down as a stepping pad—*SQUISH-KRRK!*—the thin cardboard bends and the floor cracks right through it!
   - *Clue 3 Fail:* I try hopping on my hands—*SLIP-CRACK!*—bare palms trigger glowing handprints and crack the floor even faster!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—*rubber-wheeled furniture* isn't a bare foot! I yank two **Rolling Swivel Desk Chairs** off the wall, kneel on the cushioned seat of Chair A, push off the doorframe to roll to Chair B, leap onto Chair B while pulling Chair A forward in a leapfrog chain, and skate cleanly all the way down the 60-foot hallway out the front doors without a single bare toe touching tile!
6. **51–56s Action Echo Punchline:**
   - I coast straight onto the grass courtyard, kick off the swivel chair like a surfboard, and watch the whole class cheer from the sidewalk.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Zane (Narrator, 13):** Protagonist. Skin: `#E8B288`. Outfit: Swim-team hoodie (`Shirt`), athletic shorts (`Pants`), damp brown hair, bare feet. Face swaps: `scared` -> `determined` -> `grin` -> `proud`.
- **Tyler (Dodgeball Kid, 13):** Comic foil. Skin: `#FFDBAC`. Outfit: Red gym jersey (`Shirt`), black shorts (`Pants`), headband. Face swaps: `determined` -> `shocked`.
- **Ms. Lin (Teacher, 35):** Homeroom teacher. Skin: `#F5CBA7`. Outfit: Blue blazer (`Shirt`), grey slacks (`Pants`), bob haircut. Face swaps: `scared` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Glowing Floor Crack Decals:** `4.0 x 0.05 x 4.0` studs, `Neon`, `#00B4D8` spiderweb, socketed to `Workspace`.
- **Rolling Swivel Desk Chair (x2):** `2.2 x 3.2 x 2.2` studs, `Plastic`/`Metal`, `#1D3557`, socketed to `Workspace`.
- **Cardboard Textbook Box:** `1.8 x 1.2 x 1.4` studs, `Wood`/`Fabric`, `#C68B59`, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Oakridge Middle School Hallway (`Tile` `#EDF2F4`, `Metal` blue lockers `#457B9D`).
- **Secondary Set:** School Courtyard (`Grass` `#52B788`).
- **Lighting & VFX/SFX:** `ClockTime = 11.5`, bright fluorescent school lights `#F8F9FA`; VFX glowing cyan fracture sparks; SFX glass-crack snap, rolling caster wheels, fire bell.

---

## Story 089 — The Zipper-Tag Silence

- **Story ID & Title:** `089` — The Zipper-Tag Silence
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Gossip only has power until the person who loves talking behind backs has to face the zipper on their own collar.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In this town, every time you gossip about someone behind their back, a glowing brass zipper zips one inch higher across your jacket collar—and if it hits your chin, your voice locks for 24 hours."
   - *Frame 1 Visual:* Close-up of a girl whispering behind her hand in a cafeteria; a glowing brass zipper on her hoodie collar ratchets up one inch with a loud *ZZZIP!*
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Drama blogger Tiffany trashes the entire cheer squad in the locker room—*ZZZIP-ZZZIP-ZZZIP!*—until her collar clamps shut over her chin mid-sentence, leaving her squeaking silently like a squeezed rubber duck during pep rally.
   - *Town Adaptation:* Kids wear collarless crewneck tees to avoid reminders—except the glowing brass zipper still spawns right across the neckline whenever anyone gossips!
   - *3 Named Planted Ammo Clues:*
     1. **1-Inch Remaining Brass Zipper** (buzzing right below the chin of bully Bryce's varsity jacket—he's one rumor away from mute!).
     2. **Cafeteria PA Megaphone** (held by Bryce on the quad stage as he threatens to blast my friend's embarrassing diary aloud).
     3. **Printed Yearbook Photo** (in my pocket—showing Bryce's own secret 6th-grade tuba solo).
3. **13.5–21s Personal Trap & Crisis:**
   - At lunchtime, Bryce climbs onto the quad stage with the **Cafeteria PA Megaphone**, holds up my best friend Maya's stolen notebook, and smirks: *"Ready to hear Maya's biggest secret?"* The whole courtyard goes dead silent—and Bryce's zipper is one single inch from his chin!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I sprint toward the stage to yank the **Cafeteria PA Megaphone** out of his hands—*SHOVE-FEEDBACK!*—two varsity guys block the stairs.
   - *Clue 2 Fail:* I yell *"Don't listen to him!"*—*ECHO-LAUGH!*—the crowd just leans closer to hear the drama.
   - *Clue 3 Fail:* I try flashing the **Printed Yearbook Photo** at Bryce to blackmail him—*FLAP-SNORT!*—Bryce laughs it off into the mic: *"Nice try, loser!"*
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—*gossiping behind someone's back* zips the collar one inch higher! I spin Maya around so her back is facing the stage, hold up the **Printed Yearbook Photo** to the crowd, and shout: *"Maya's not even looking at you, Bryce—say it behind her back!"* Bryce takes the bait, leans into the **Cafeteria PA Megaphone**, and sneers: *"Yeah, well Maya still—"*—*ZZZIP-CLAMP!* The glowing brass zipper rockets that final inch straight past his chin, locking his mouth shut! His amplified *MMMMMPH!* echoes across the quad as Maya grabs her notebook cleanly back!
6. **51–56s Action Echo Punchline:**
   - Bryce tugs furiously at his locked collar while Maya high-fives me, and we both walk away without saying a single word about him.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Jules (Narrator, 13):** Protagonist. Skin: `#F1C27D`. Outfit: Olive crewneck (`Shirt`), black jeans (`Pants`), shoulder-length dark hair. Face swaps: `determined` -> `scared` -> `grin` -> `proud`.
- **Bryce (Bully, 14):** Antagonist. Skin: `#FFDBAC`. Outfit: Red varsity jacket with glowing brass zipper (`Shirt`), grey joggers (`Pants`), spiky blonde hair. Face swaps: `grin` -> `shocked` -> `scared`.
- **Maya (Best Friend, 13):** Sidekick. Skin: `#8D5524`. Outfit: Purple hoodie (`Shirt`), denim skirt (`Pants`), twin puffs. Face swaps: `scared` -> `grin` -> `proud`.
- **Tiffany (Blogger, 14):** Comic foil. Skin: `#F5C29B`. Outfit: Pink zip-up (`Shirt`), white jeans (`Pants`), long blonde hair. Face swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Glowing Brass Collar Zipper:** `1.2 x 0.3 x 0.3` studs, `Neon`/`Metal`, `#FFD700`, socketed to `UpperTorso` (neck collar).
- **Cafeteria PA Megaphone:** `1.3 x 0.9 x 0.9` studs, `Plastic`, `#E63946` with white horn, socketed to `RightHand`.
- **Maya's Stolen Notebook:** `0.8 x 1.0 x 0.15` studs, `SmoothPlastic`, `#9D4EDD`, socketed to `LeftHand`.
- **Printed Yearbook Photo:** `0.7 x 0.9 x 0.05` studs, `Plastic`, `#FFFFFF`, socketed to `RightHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Outdoor Quad (`Concrete` stage `#ADB5BD`, `Grass` lawn `#52B788`, picnic tables).
- **Secondary Set:** School Cafeteria (`Tile` `#E9ECEF`, lunch trays).
- **Lighting & VFX/SFX:** `ClockTime = 12.5`, crisp midday sun `#FFF8E7`; VFX golden zipper spark burst; SFX metallic *ZZZIP-CLAMP!*, megaphone feedback whine, crowd gasp.

---

## Story 090 — The Echo-Tax

- **Story ID & Title:** `090` — The Echo-Tax
- **Format:** Standalone 52s, 45 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** Repeating someone else's cruelty costs pieces of your own voice—until you use your hands to make things right.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In this town, every time you repeat someone else's joke or rumor, your voice drops ten percent quieter—until you hit zero and go completely mute."
   - *Frame 1 Visual:* School locker bay; a kid repeats a mean nickname, and his floating `[VOICE: 30%]` badge flashes red down to `[20%]` as his voice drops to a raspy whisper.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Town parrot-gossip Greg repeats ten memes in a row at the burger counter, hitting `[0%]` mid-order and frantically pointing at the ketchup bottle like a mime.
   - *Town Adaptation:* Kids carry "Originality Cards" to prove a joke is theirs—and take free ASL sign-language classes at the community center just in case.
   - *3 Named Planted Ammo Clues:*
     1. **Community Sign-Language Flashcard** (tucked inside my binder).
     2. **Choir Audition Sheet Music** (waiting on the auditorium piano).
     3. **Faded Rumor Sticky-Note** (the one I copied from the bully's desk yesterday).
3. **13.5–21s Personal Trap & Crisis:**
   - Ten minutes before the regional choir solo I practiced all year for, I accidentally repeat one joke I overheard in the hallway—and my `[VOICE: 10%]` meter drops straight to `[0% MUTE]`! I open my mouth to sing a test note, and zero sound comes out!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I chug warm honey-tea from my thermos—*GULP-SQUEAK!*—nothing comes out except dry air.
   - *Clue 2 Fail:* I try whispering *"I'm sorry"* into the auditorium mic—*HISS-SILENCE!*—the mic picks up zero vocal vibration.
   - *Clue 3 Fail:* I hold up the **Faded Rumor Sticky-Note** and tear it in half—*RIP-STATIC!*—destroying the paper doesn't refund my voice!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—you can't apologize *out loud* when you're at zero percent... so you have to apologize in *sign language* to the exact person you echoed! I sprint into the choir wings, spot Sam (the kid whose nickname I repeated), drop my **Choir Audition Sheet Music**, and use my **Community Sign-Language Flashcard** to sign *"I AM SORRY"* cleanly with both hands. Sam's eyes widen, he signs *"FORGIVEN"*—and *DING-WHOOSH!* My `[VOICE: 100%]` bar surges back to full gold just as my name is called!
6. **51–56s Action Echo Punchline:**
   - I walk onto the spotlight stage, sign *"Thank you"* to Sam in the front row, and hit the opening high note loud enough to rattle the rafters.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Elena (Narrator, 13):** Protagonist. Skin: `#F5CBA7`. Outfit: Blue choir cardigan (`Shirt`), black skirt (`Pants`), dark wavy hair. Face swaps: `scared` -> `determined` -> `shocked` -> `proud`.
- **Sam (Classmate, 13):** Wronged kid. Skin: `#C68642`. Outfit: Grey hoodie (`Shirt`), jeans (`Pants`), curly black hair. Face swaps: `neutral` -> `grin` -> `proud`.
- **Greg (Gossip Kid, 14):** Comic foil. Skin: `#FFDBAC`. Outfit: Orange tee (`Shirt`), cargo shorts (`Pants`), messy blonde hair. Face swaps: `grin` -> `scared`.

### Props & Sockets (Sound-Off Visible)
- **Voice-Percent Overhead Tag:** `1.5 x 0.5 x 0.1` studs, `BillboardGui`, `#FF3B30`/`#FFD700` `"[0% MUTE]"`, socketed to `Head`.
- **Sign-Language Flashcard:** `0.7 x 0.9 x 0.05` studs, `Plastic`, `#FFFFFF` with hand-sign decal, socketed to `RightHand`.
- **Choir Sheet Music:** `0.9 x 1.2 x 0.05` studs, `Plastic`, `#FFF8E7`, socketed to `LeftHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Auditorium Stage & Wings (`Wood` stage `#6F4E37`, red velvet curtains `#9E2A2B`, spotlight cone).
- **Secondary Set:** School Locker Bay (`Metal` lockers `#457B9D`).
- **Lighting & VFX/SFX:** `ClockTime = 18.5`, dramatic stage spotlight `#FFE5B4`; VFX golden vocal-restore wave; SFX mute air-puff, chime restore, warm choir chord.

---

## Story 091 — The Color-Mood Shirt

- **Story ID & Title:** `091` — The Color-Mood Shirt
- **Format:** Standalone 53s, 45 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Sometimes the hardest secret to keep is the one that makes everyone else smile.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Chroma Creek, your shirt turns blinding neon red the instant you tell a lie—which makes hiding a surprise party in July nearly impossible."
   - *Frame 1 Visual:* Sunny summer street; a kid tells his mom *"I didn't eat the cookies"*—*FLASH!*—his white tee erupts into glowing neon crimson, lighting up the whole porch.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* When Dad claims *"I definitely know how to parallel park,"* his polo turns so bright neon red it sets off the neighbor's motion-sensor security floodlights.
   - *Town Adaptation:* Kids wear heavy layered hoodies even in 95-degree heat whenever they're hiding birthday gifts.
   - *3 Named Planted Ammo Clues:*
     1. **Heavy Puffer Winter Coat** (zipped to my chin in 98°F July heat).
     2. **30-Person Surprise Banner** (stuffed inside my gym duffel).
     3. **Ice-Cold Lemonade Cooler** (sitting on the front porch beside Mom's chair).
3. **13.5–21s Personal Trap & Crisis:**
   - At 3:00 PM on July 14th, I'm sweating buckets inside my **Heavy Puffer Winter Coat** while thirty neighbors hide behind Mom's backyard hedge. Suddenly Mom spots me on the driveway, walks straight up, and asks: *"Why are you wearing a winter coat in July? Are you hiding something?"*
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I zip the **Heavy Puffer Winter Coat** tighter and say *"Just chilly!"*—*GLOW-BLEED!*—the neon red shirt underneath shines straight through the zipper seam!
   - *Clue 2 Fail:* I try changing the subject by pointing at the **Ice-Cold Lemonade Cooler**—*DRIP-SWEAT!*—Mom raises an eyebrow and steps closer to unzip my coat!
   - *Clue 3 Fail:* I clutch the **30-Person Surprise Banner** duffel behind my back and stammer *"Nothing's in the yard!"*—*FLASH-CRIMSON!*—my collar flares like a police beacon!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—the shirt only turns red when you *lie*! What if I tell the *100% literal truth* that still keeps the surprise? I unzip the **Heavy Puffer Winter Coat**, let the cool breeze hit me, look Mom straight in the eye, and say: *"I'm hot, I'm sweating, and thirty people are waiting for you in the backyard!"*—*FLASH-WHITE!* My shirt snaps pure snow-white, Mom laughs thinking I'm joking, walks through the side gate—and thirty neighbors pop up yelling *"SURPRISE!"*
6. **51–56s Action Echo Punchline:**
   - I toss the **Heavy Puffer Winter Coat** onto the grass, grab two cups from the **Ice-Cold Lemonade Cooler**, and toast Mom in my snow-white tee.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Noah (Narrator, 13):** Protagonist. Skin: `#E0AC69`. Outfit: White tee under puffy blue winter coat (`Shirt`), khaki shorts (`Pants`), messy dark hair. Face swaps: `scared` -> `determined` -> `grin` -> `proud`.
- **Mom (Claire, 41):** Birthday honoree. Skin: `#F1C27D`. Outfit: Floral summer blouse (`Shirt`), white capris (`Pants`), auburn bob. Face swaps: `neutral` -> `shocked` -> `grin`.
- **Dad (43):** Comic foil. Skin: `#E0AC69`. Outfit: Neon-red-flashing polo (`Shirt`), cargo shorts (`Pants`), glasses. Face swaps: `proud` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Color-Mood Tee:** `2.0 x 2.0 x 1.0` studs (torso mesh), `Neon`/`SmoothPlastic`, `#FF1E1E` (lie) / `#FFFFFF` (truth), socketed to `UpperTorso`.
- **Heavy Puffer Winter Coat:** `2.3 x 2.2 x 1.3` studs, `Fabric`, `#1D3557`, socketed to `UpperTorso`.
- **Ice-Cold Lemonade Cooler:** `2.0 x 1.5 x 1.4` studs, `Plastic`, `#E63946` with white lid, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Sunny July Driveway & Backyard (`Concrete` driveway `#D8D8D8`, `Grass` `#52B788`, hedge row, party balloons).
- **Secondary Set:** Suburban Street Curb (`Asphalt` `#2B2D42`).
- **Lighting & VFX/SFX:** `ClockTime = 15.0`, bright summer heat `#FFF3B0`; VFX crimson shirt bloom + sweat drops; SFX neon hum, zipper zip, party horn pop.

---

## Story 092 — The Paper-Airplane Wish

- **Story ID & Title:** `092` — The Paper-Airplane Wish
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** The wishes that fly farthest aren't the ones you fold for yourself—they're the ones that carry someone else home.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "Once a year in Windmere, whatever you write on a folded paper airplane flies straight across town to the person who needs it most."
   - *Frame 1 Visual:* Golden-hour rooftop; a kid launches a glowing cyan paper airplane that banks sharply mid-air and rockets past three streetlights like a guided drone.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Greedy kid Marcus folds a plane reading *"1,000 FREE ROBUX"*—and the plane does an immediate U-turn and flies straight into the town charity donation box!
   - *Town Adaptation:* Every December 1st, the whole town climbs onto porches with notebooks, folding warm coats, groceries, and handwritten encouragement into paper fleets.
   - *3 Named Planted Ammo Clues:*
     1. **Crumpled Bus Ticket** (my last $18 Greyhound ticket home to see Grandma).
     2. **Silver Fountain Pen** (clipped to my school notebook).
     3. **Stranded Traveler Bench** (across the snowy station where a shivering soldier stares at a `"SOLD OUT"` board).
3. **13.5–21s Personal Trap & Crisis:**
   - At 5:45 PM on Wish Night, my train to Grandma's gets canceled—leaving me holding my **Crumpled Bus Ticket** for the final 6:00 PM bus. Across the station, I spot a soaked, stranded paramedic shivering on the **Stranded Traveler Bench**, desperate to reach his kid's birthday two towns over!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I fold a regular notebook page writing *"FREE RIDE FOR PARAMEDIC"*—*FLUTTER-PLOP!*—without real value behind the wish, the plane nose-dives into a slush puddle!
   - *Clue 2 Fail:* I try folding a five-dollar bill into a glider—*DRIFT-SPIN!*—it's not enough for a ticket and circles back to my boots!
   - *Clue 3 Fail:* I uncap my **Silver Fountain Pen** and write *"LET ME GET HOME FAST"* on a fresh sheet—*SWOOSH-BONK!*—the wind knocks it straight against the station glass because I'm not the one who needs it most!
5. **39–51s Genius Rule-Hack Climax:**
   - I look at the **Crumpled Bus Ticket** in my hand, swallow hard, and fold *the actual ticket* into a crisp dart—writing *"FOR YOUR KID'S BIRTHDAY"* with my **Silver Fountain Pen** along the wing. The moment I let go—*ZING-SOAR!* The paper ticket glows bright gold, banking smoothly across the snowy platform and landing gently right in the paramedic's lap!
6. **51–56s Action Echo Punchline:**
   - The paramedic looks up, sees me grinning with empty hands, sprints to catch his bus—and ten seconds later, a *different* glowing paper plane lands on my shoe: a spare ride voucher from the station clerk!

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Caleb (Narrator, 14):** Protagonist. Skin: `#F1C27D`. Outfit: Green parka (`Shirt`), dark jeans (`Pants`), knit beanie. Face swaps: `determined` -> `scared` -> `grin` -> `proud`.
- **Paramedic (36):** Stranded traveler. Skin: `#8D5524`. Outfit: Navy EMS jacket (`Shirt`), dark cargo pants (`Pants`), tired eyes. Face swaps: `scared` -> `shocked` -> `grin`.
- **Marcus (Greedy Kid, 13):** Comic foil. Skin: `#FFDBAC`. Outfit: Gold bomber jacket (`Shirt`), black joggers (`Pants`), spiky hair. Face swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Glowing Paper Airplane:** `0.8 x 0.2 x 1.0` studs, `Neon`/`SmoothPlastic`, `#00E5FF` / `#FFD700`, socketed to `RightHand` / `Workspace`.
- **Crumpled Bus Ticket:** `0.7 x 0.4 x 0.05` studs, `Plastic`, `#FFF8E7` with `"BUS #6"` `BillboardGui`, socketed to `RightHand`.
- **Silver Fountain Pen:** `0.6 x 0.1 x 0.1` studs, `Metal`, `#C0C0C0`, socketed to `LeftHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Snowy Bus Station Platform (`Concrete` platform `#ADB5BD`, `Snow` drifts `#F8F9FA`, glowing `"SOLD OUT"` board).
- **Secondary Set:** Town Rooftop (`Brick` `#7F4F24`).
- **Lighting & VFX/SFX:** `ClockTime = 17.8`, twilight indigo `#2B2D42` with warm station lamps `#FFB703`; VFX golden paper-flight ribbon trail; SFX paper fold crispness, magical wind chime.

---

## Story 093 — The Heavy-Secret Backpack

- **Story ID & Title:** `093` — The Heavy-Secret Backpack
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** The loudest person in the hallway is often carrying the heaviest invisible weight—and one honest ear can lift it.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In this school, every secret you keep adds one solid pound to your backpack—and the only way to drop the weight is to tell someone out loud."
   - *Frame 1 Visual:* School stairwell; a kid whispers a white lie, and his backpack groans downward with a glowing `[+1 LB]` tag flashing on the zipper.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* When honor student Mia hides that she broke the lab microscope, her backpack hits `45 lbs`, snaps both straps in the cafeteria, and flattens her lunch tray like a pancake.
   - *Town Adaptation:* Kids hold Friday "Confession Circles" behind the bleachers to dump trivial secrets (*"I ate my brother's Oreos"*) before weekend hike club.
   - *3 Named Planted Ammo Clues:*
     1. **200-lb Groaning Backpack** (dragged across the floor by school bully Rex).
     2. **Flickering Hallway Breaker Box** (buzzing loudly outside the dark basement stairs).
     3. **Pocket Penlight** (clipped to my hoodie zipper).
3. **13.5–21s Personal Trap & Crisis:**
   - During afternoon storm detention, a lightning strike kills the school power grid! In the pitch-black basement hallway, Rex's **200-lb Groaning Backpack** pins his own ankles under the fallen trophy case—and he's too proud to call for help!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I brace my shoulders and try to drag the **200-lb Groaning Backpack** off his legs—*SCRAPE-GRUNT!*—it's bolted to the floor like lead!
   - *Clue 2 Fail:* I shine my **Pocket Penlight** into the **Flickering Hallway Breaker Box**—*SPARK-BUZZ!*—the main fuse is blown completely!
   - *Clue 3 Fail:* I yell *"Tell me a secret, Rex—anything!"* Rex snaps *"I stole a soda!"*—*DING [-1 LB]! 199 LBS!* Still way too heavy!
5. **39–51s Genius Rule-Hack Climax:**
   - One secret won't drop 200 pounds—it has to be the *core* secret he's been hiding all year! I click off my **Pocket Penlight** for one second, hear Rex's breath hitch in the dark, and click it right back on. Softly, I say: *"You're not mean, Rex. You're terrified of the dark—and you've been hiding it since third grade."* Rex stares at the penlight, his voice cracks, and he whispers: *"Yeah... I sleep with the hall light on."*—*WHOOSH-POOF!* His `[200 LBS]` tag drops straight to `[0 LBS]`, letting me lift the empty bag right off his legs!
6. **51–56s Action Echo Punchline:**
   - I hand Rex my **Pocket Penlight** to hold as we walk up the basement stairs together—no jokes, no teasing, just steady light.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Jordan (Narrator, 13):** Protagonist. Skin: `#C68642`. Outfit: Charcoal hoodie (`Shirt`), jeans (`Pants`), short curly hair. Face swaps: `determined` -> `scared` -> `shocked` -> `proud`.
- **Rex (Bully, 14):** Secret-carrier. Skin: `#FFDBAC`. Outfit: Leather vest over grey tee (`Shirt`), black pants (`Pants`), buzzcut. Face swaps: `determined` -> `scared` -> `grin`.
- **Mia (Honor Student, 13):** Comic foil. Skin: `#F5C29B`. Outfit: Cardigan (`Shirt`), plaid skirt (`Pants`), glasses. Face swaps: `scared` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Weighted Backpack:** `1.6 x 2.0 x 1.2` studs, `Fabric`, `#2B2D42` with `Head` `BillboardGui` `"[200 LBS]"`, socketed to `UpperTorso` / `Workspace`.
- **Pocket Penlight:** `0.6 x 0.15 x 0.15` studs, `Metal`/`Neon`, `#FFD166`, socketed to `RightHand`.
- **Trophy Case:** `4.0 x 5.0 x 1.5` studs, `Wood`/`Glass`, `#5C4033`, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Dark Basement School Hallway (`Concrete` walls `#343A40`, fallen trophy case, breaker box).
- **Secondary Set:** School Cafeteria (`Tile` `#E9ECEF`).
- **Lighting & VFX/SFX:** `ClockTime = 19.0`, pitch-black interior `#0B090A` lit only by penlight cone; VFX weight-drop feather burst; SFX heavy scrape, fuse spark, weight-release whoosh.

---

## Story 094 — The Cold-Shoulder Freeze

- **Story ID & Title:** `094` — The Cold-Shoulder Freeze
- **Format:** Standalone 53s, 45 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** Giving someone the cold shoulder doesn't just freeze them out—it turns your own arms to ice until you turn around.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Frostbite Hollow, every time you ignore someone calling your name, jagged blue frost spreads six inches up your sleeves."
   - *Frame 1 Visual:* Snowy sidewalk; a kid puts in earbuds and walks past his mom calling *"Wait!"*—*CRACKLE!*—sparkling blue ice creeps up his jacket cuffs.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Snobby hall-monitor Brenda ignores twelve kids asking for bathroom passes in a row—and freezes solid into an ice statue right in front of the water fountain!
   - *Town Adaptation:* Everyone wears bright orange ear-warmers with holes cut out so they never accidentally miss someone calling their name.
   - *3 Named Planted Ammo Clues:*
     1. **Noise-Canceling Headphones** (clamped over my ears while studying for finals).
     2. **Little Brother's Missing Mittens** (dropped on the icy porch steps).
     3. **Car-Window Ice Scraper** (lying on the hallway bench).
3. **13.5–21s Personal Trap & Crisis:**
   - Furious after an argument with my best friend Gabe, I clamp on my **Noise-Canceling Headphones**, blast music, and storm down Maple Street. Behind me, Gabe yells my name three times—and by the time I feel the chill, solid blue ice has locked both my elbows stiff in front of a busy intersection!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I slam my frosted sleeves against a brick mailbox—*THUD-CRACK!*—the ice only grows thicker up to my shoulders!
   - *Clue 2 Fail:* I grab the **Car-Window Ice Scraper** with stiff fingers and chip at my cuff—*SCRAPE-PING!*—the plastic blade snaps in half!
   - *Clue 3 Fail:* I yank off my **Noise-Canceling Headphones** and shout *"Okay, I hear you!"* to the empty street—*ECHO-FREEZE!*—because I'm facing away, the frost creeps onto my collar!
5. **39–51s Genius Rule-Hack Climax:**
   - You can't melt the Cold-Shoulder Freeze by shouting forward—you have to *turn completely around and listen*! Fighting the stiffness, I pivot 180 degrees, sprint half a block back to Gabe, kneel down beside him holding **Little Brother's Missing Mittens** he'd been chasing to return to me, and say: *"I'm listening—what did you say?"*—*SHIMMER-MELT!* Warm golden steam rises off my sleeves as the ice vanishes!
6. **51–56s Action Echo Punchline:**
   - Gabe laughs, tosses me the mittens, and drapes his scarf around my neck—while I leave the **Noise-Canceling Headphones** hanging off my backpack.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Tessa (Narrator, 14):** Protagonist. Skin: `#FFDBAC`. Outfit: Teal winter parka (`Shirt`), dark jeans (`Pants`), auburn ponytail. Face swaps: `determined` -> `scared` -> `shocked` -> `proud`.
- **Gabe (Best Friend, 14):** Caller. Skin: `#8D5524`. Outfit: Mustard puffer (`Shirt`), grey sweatpants (`Pants`), knit beanie. Face swaps: `scared` -> `grin` -> `proud`.
- **Brenda (Hall Monitor, 13):** Comic foil. Skin: `#F5C29B`. Outfit: Yellow safety sash over sweater (`Shirt`), skirt (`Pants`), glasses. Face swaps: `proud` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Sleeve Frost Encasing:** `0.6 x 1.8 x 0.6` studs, `Ice`/`Neon`, `#90E0EF`, socketed to `LeftArm`/`RightArm`.
- **Noise-Canceling Headphones:** `0.9 x 0.9 x 0.4` studs, `Plastic`, `#111111`, socketed to `Head`.
- **Red Mittens:** `0.4 x 0.5 x 0.2` studs, `Fabric`, `#E63946`, socketed to `RightHand`.
- **Ice Scraper:** `0.8 x 0.3 x 0.1` studs, `Plastic`, `#FFB703`, socketed to `LeftHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Maple Street Winter Sidewalk (`Snow` `#F8F9FA`, `Brick` mailbox `#9E2A2B`, bare winter trees).
- **Secondary Set:** School Hallway Water Fountain (`Tile` `#EDF2F4`).
- **Lighting & VFX/SFX:** `ClockTime = 16.2`, crisp pale-blue winter afternoon `#CAF0F8`; VFX ice crystal spread + warm gold melt steam; SFX ice crackle, muffled bass, warm thaw chime.

---

## Story 095 — The Glass-Heart Chest

- **Story ID & Title:** `095` — The Glass-Heart Chest
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** Broken promises leave real cracks—and only honest repair earns the gold that holds them together.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Crystalbrook, everyone's heart glows right through their shirt—and every broken promise leaves a jagged black crack across the glass."
   - *Frame 1 Visual:* Close-up of a boy's chest; a translucent glowing ruby heart pulses behind his hoodie until he breaks a promise—*KRRK!*—splitting a sharp black fracture across it.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Flaky streamer Tyler promises *"Daily uploads at 5 PM!"* to fifty fans, misses three days in a row, and walks into class sounding like a rattling jar of marbles.
   - *Town Adaptation:* Whenever someone keeps an uncomfortable truth, a strip of shimmering **Gold Kintsugi Tape** spawns in their palm to seal their own cracks.
   - *3 Named Planted Ammo Clues:*
     1. **One Strip of Gold Kintsugi Tape** (earned last week, tucked inside my watch pocket).
     2. **Grandpa's Broken Pocket Watch** (sitting on my desk after I accidentally dropped it).
     3. **Cracked Glass Heart** (dimming dangerously inside Grandpa's chest after I lied and said *"It fell off the shelf by itself"*).
3. **13.5–21s Personal Trap & Crisis:**
   - Wait—my lie didn't just crack *my* heart—Grandpa blamed himself for leaving the watch near the edge, and his fragile **Cracked Glass Heart** starts flickering dim grey at dinner!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I press my **One Strip of Gold Kintsugi Tape** onto *my* chest—*FIZZLE-PEEL!*—it seals my tiny crack, leaving Grandpa's heart still dim!
   - *Clue 2 Fail:* I try gluing **Grandpa's Broken Pocket Watch** back together in secret—*SNAP-DROP!*—the gears won't align and Grandpa spots the mess!
   - *Clue 3 Fail:* I mumble *"Maybe the cat knocked it down?"*—*KRRK!*—another black crack shoots across my chest!
5. **39–51s Genius Rule-Hack Climax:**
   - Gold tape only spawns from *complete honesty*! I walk straight up to Grandpa's chair, set **Grandpa's Broken Pocket Watch** gently in his hands, and say clearly: *"I dropped it, Grandpa. I was scared to tell you, and I'm sorry."*—*SHIMMER-PING!* Two bright strips of **Gold Kintsugi Tape** spawn in my palm! I press one gently against Grandpa's shirt over his heart—sealing his fracture in glowing gold—and seal my own with the second!
6. **51–56s Action Echo Punchline:**
   - Grandpa's heart glows warm amber again; he opens the watch backplate, hands me a tiny screwdriver, and says *"Come on, let's fix it together."*

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Owen (Narrator, 12):** Protagonist. Skin: `#F1C27D`. Outfit: Navy sweater (`Shirt`), jeans (`Pants`), brown hair. Face swaps: `scared` -> `determined` -> `shocked` -> `proud`.
- **Grandpa (70):** Elder. Skin: `#F1C27D`. Outfit: Tan cardigan (`Shirt`), brown slacks (`Pants`), white hair & glasses. Face swaps: `scared` -> `grin` -> `proud`.
- **Tyler (Streamer, 14):** Comic foil. Skin: `#FFDBAC`. Outfit: Neon purple hoodie (`Shirt`), joggers (`Pants`), headphones. Face swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Glowing Glass Heart:** `0.9 x 0.9 x 0.5` studs, `Glass`/`Neon`, `#FF2A55` with crack decal, socketed to `UpperTorso`.
- **Gold Kintsugi Tape Strip:** `0.6 x 0.15 x 0.05` studs, `Neon`/`Metal`, `#FFD700`, socketed to `RightHand`.
- **Grandpa's Pocket Watch:** `0.5 x 0.5 x 0.2` studs, `Metal`, `#D4AF37`, socketed to `LeftHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Cozy Dining Room (`WoodPlanks` oak table `#6F4E37`, `Plaster` warm walls `#F5EBE0`).
- **Secondary Set:** School Classroom (`Tile` `#E5E5E5`, desks).
- **Lighting & VFX/SFX:** `ClockTime = 19.2`, warm dining pendant `#FFB347`; VFX golden kintsugi seam glow; SFX glass fracture crack, soft chime, watch tick.

---

## Story 096 — The Whisper-Radio Locker

- **Story ID & Title:** `096` — The Whisper-Radio Locker
- **Format:** Standalone 53s, 45 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** You don't have to shout to save someone—sometimes the quietest truth reaches the exact ear that needs it.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Westside High, whispering into rusted Locker #0 broadcasts your voice out of whatever speaker sits closest to the person who needs to hear it most."
   - *Frame 1 Visual:* Dim school hallway; a girl whispers *"Don't quit"* into a rusted teal locker vent—and across town, a kid's kitchen toaster radio crackles to life with her exact voice!
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* When prankster Leo whispers *"Your shoes are untied!"* into Locker #0 for fun, it broadcasts straight out of the Principal's car stereo—making the Principal slam his brakes in the middle of the crosswalk.
   - *Town Adaptation:* Kids tape sticky-notes onto Locker #0 only for real emergencies, leaving a brass turn-dial outside the vent so nobody crowds the door.
   - *3 Named Planted Ammo Clues:*
     1. **Rusted Locker #0 Vent** (at the far end of the basement gym corridor).
     2. **Missing Brother's Blue Keychain** (left on my nightstand—he stormed out two hours ago).
     3. **Rain-Soaked Bus Schedule** (showing the 10:15 PM Greyhound leaves in four minutes).
3. **13.5–21s Personal Trap & Crisis:**
   - After a huge fight with Dad, my older brother Sam packs a duffel and heads toward the highway bus station in pouring rain! My phone's dead, my bike has a flat, and the 10:15 PM bus pulls up in ninety seconds!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I sprint toward the bus station on foot—*SPLASH-STUMBLE!*—I'm still six blocks away when the station lights appear in the mist.
   - *Clue 2 Fail:* I pound on a corner payphone—*CLICK-DEAD!*—the storm knocked out the landline!
   - *Clue 3 Fail:* I race back inside the school and *yell* Sam's name into **Rusted Locker #0 Vent**—*CLANG-SILENCE!*—yelling doesn't work; the locker only transmits *whispers*!
5. **39–51s Genius Rule-Hack Climax:**
   - I press my forehead against the cold steel of **Rusted Locker #0 Vent**, catch my breath, clutch **Sam's Blue Keychain**, and whisper from the bottom of my chest: *"Sam... Mom left the porch light on for you. Please come home."* Across town, the bus-station vending machine radio crackles—*KSSSHH!*—broadcasting my exact whisper right as Sam reaches for the bus step!
6. **51–56s Action Echo Punchline:**
   - Sam freezes on the bottom step, lets the bus doors hiss shut without him, and walks back into the rain toward our glowing porch light.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Maya (Narrator, 13):** Protagonist. Skin: `#E8B288`. Outfit: Yellow raincoat (`Shirt`), jeans (`Pants`), damp dark hair. Face swaps: `scared` -> `determined` -> `shocked` -> `proud`.
- **Sam (Older Brother, 17):** Runaway sibling. Skin: `#E8B288`. Outfit: Grey hoodie (`Shirt`), cargo pants (`Pants`), duffel bag, short brown hair. Face swaps: `determined` -> `shocked` -> `grin`.
- **Leo (Prankster, 13):** Comic foil. Skin: `#FFDBAC`. Outfit: Red flannel (`Shirt`), black pants (`Pants`), backwards cap. Face swaps: `grin` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Rusted Locker #0:** `2.0 x 6.0 x 1.8` studs, `CorrodedMetal`, `#2A6F97` with glowing cyan vent slats, socketed to `Workspace`.
- **Sam's Blue Keychain:** `0.4 x 0.4 x 0.1` studs, `Metal`/`Plastic`, `#0077B6`, socketed to `RightHand`.
- **Bus Station Vending Radio:** `2.5 x 4.5 x 2.0` studs, `Metal`/`Neon`, `#4A4E69` with `#FFD166` speaker glow, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Basement School Corridor (`Tile` floor `#CED4DA`, `Brick` wall `#4A4E69`, Locker #0).
- **Secondary Set:** Rainy Bus Station Stop (`Asphalt` `#2B2D42`, bus shelter glass).
- **Lighting & VFX/SFX:** `ClockTime = 22.2`, storm-night blue `#1D3557` + warm cyan vent glow; VFX radio frequency rings; SFX rain patter, locker echo, radio static crackle.

---

## Story 097 — The Footprint-Replay Puddles

- **Story ID & Title:** `097` — The Footprint-Replay Puddles
- **Format:** Standalone 54s, 46 beats
- **Voice Preset:** `fast_mystery`
- **Unstated Human Meaning:** You can wash away tire tracks in the rain, but the truth stays waiting in the water until someone steps in to listen.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Rainwater Grove, stepping into any street puddle plays back the exact last sentence spoken by whoever stepped there before you."
   - *Frame 1 Visual:* Wet crosswalk; a girl's yellow boot splashes into a mirror-like puddle—*RIPPLE!*—and a crisp echo of *"Don't forget milk!"* floats upward in glowing blue text-waves.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Town gossip Mrs. Jenkins steps in a puddle outside the bakery and accidentally hears her own husband muttering *"I ate the last donut and blamed the dog"*—making the whole line burst out laughing.
   - *Town Adaptation:* People leap over sidewalk puddles like hot lava whenever they're arguing on the phone.
   - *3 Named Planted Ammo Clues:*
     1. **Shattered Amber Headlight Shard** (lying beside my crushed bicycle at the corner of 4th & Oak).
     2. **Three Rain Puddles** (leading from the dented curb straight toward the alley repair shop).
     3. **Pocket Voice Recorder** (clipped inside my jacket).
3. **13.5–21s Personal Trap & Crisis:**
   - At 4:15 PM, a silver sedan clips my parked bicycle at 4th & Oak, snaps its own headlight, and speeds off before I can read the plate! Officer Grant arrives and says there are zero witnesses—and the sun is already coming out to dry the puddles in five minutes!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I splash into Puddle #1 by the bike rack—*SPLASH-ECHO!*—it only replays *my* own voice yelling *"Hey, watch out!"*
   - *Clue 2 Fail:* I stomp into Puddle #2 by the crosswalk—*RIPPLE-STATIC!*—just a delivery guy humming off-key!
   - *Clue 3 Fail:* I race to Puddle #3 by the **Shattered Amber Headlight Shard**—*DRIP-DRY!*—half the puddle has already evaporated in the afternoon sun!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—if the driver *checked the damage* before speeding off, they stepped right beside the curb puddle! I spot one tiny, shaded puddle tucked under the storm-drain lip—two inches wide and drying fast! I press *RECORD* on my **Pocket Voice Recorder**, drop one heel straight into the shaded puddle—*SPLASH-CHIME!*—and a panicked voice echoes crystal-clear: *"Quick, hide the silver Civic in Bay 3 before the cops see the plate!"* Officer Grant's eyes snap wide!
6. **51–56s Action Echo Punchline:**
   - Grant clicks his radio, sprints two blocks to Bay 3, and I tuck my **Pocket Voice Recorder** safely away while wheeling my bent bike frame home.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Eli (Narrator, 14):** Protagonist. Skin: `#FFDBAC`. Outfit: Green rain jacket (`Shirt`), dark jeans (`Pants`), yellow rain boots, brown hair. Face swaps: `determined` -> `scared` -> `shocked` -> `proud`.
- **Officer Grant (40):** Town cop. Skin: `#8D5524`. Outfit: Navy police uniform (`Shirt`/`Pants`), peaked cap. Face swaps: `neutral` -> `shocked` -> `proud`.
- **Mrs. Jenkins (58):** Comic foil. Skin: `#F5CBA7`. Outfit: Lavender coat (`Shirt`), slacks (`Pants`), curly grey hair. Face swaps: `neutral` -> `grin`.

### Props & Sockets (Sound-Off Visible)
- **Replay Rain Puddle (x3):** `3.0 x 0.05 x 3.0` studs, `Glass`/`Neon`, `#4EA8DE` with floating `BillboardGui` voice-wave text, socketed to `Workspace`.
- **Shattered Amber Headlight Shard:** `0.4 x 0.3 x 0.1` studs, `Glass`, `#FFB703`, socketed to `RightHand`.
- **Pocket Voice Recorder:** `0.5 x 0.8 x 0.15` studs, `Metal`, `#2B2D42` with red LED, socketed to `LeftHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** 4th & Oak Wet Intersection (`Asphalt` `#2B2D42`, `Concrete` sidewalk `#ADB5BD`, storm drain, bent BMX bike).
- **Secondary Set:** Bakery Front (`Brick` `#9E2A2B`).
- **Lighting & VFX/SFX:** `ClockTime = 16.8`, post-storm golden sun breaking through clouds `#FFD180`; VFX shimmering water-ripple rings; SFX puddle splash, crisp vocal echo, police radio chirp.

---

## Story 098 — The One-Shoe Rule

- **Story ID & Title:** `098` — The One-Shoe Rule
- **Format:** Standalone 53s, 45 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** You don't have to match to move fast—sometimes sharing what you have is the only way both of you finish the race.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Mismatch Town, nobody is allowed to wear matching shoes—because the second your left and right shoes match, your feet freeze solid to the floor."
   - *Frame 1 Visual:* School track; a sprinter accidentally laces up two identical white sneakers—*CLANK!*—his soles weld straight to the red rubber lane while everyone else blasts past.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Fashion-obsessed Coach Vance buys matching gold loafers for picture day, steps onto the gym floor, and gets stuck frozen like a trophy until the janitor pries his laces off!
   - *Town Adaptation:* Shoe stores sell single shoes in giant bargain bins—kids rock one red high-top and one blue skate shoe as a badge of pride.
   - *3 Named Planted Ammo Clues:*
     1. **My Neon Orange Left Sneaker** (worn on my left foot, paired with a green right boot).
     2. **Best Friend Maya's Purple Left Skate Shoe** (worn on her left foot, paired with a yellow right sneaker).
     3. **Relay-Track Finish Tape** (ten yards ahead—while Maya's right shoe just snapped its sole!).
3. **13.5–21s Personal Trap & Crisis:**
   - At the District 2-Person Relay Finals, Maya and I are leading by two steps when Maya's yellow right sneaker catches a hurdle and rips clean off! She's barefoot on one foot—and if she grabs her spare shoe from the sidelines, it's a *purple* right shoe that matches her left!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* Maya tries hopping on one foot toward the finish—*HOP-STUMBLE!*—her ankle wobbles and the rival team closes the gap!
   - *Clue 2 Fail:* I toss her my spare white gym shoe from my bag—*WAIT-FREEZE!*—no, it's a left shoe, it won't fit her right foot!
   - *Clue 3 Fail:* Maya reaches for her own spare purple right shoe—*CLANK-LOCK!*—the instant her toe touches it, the match-sensor sparks warning red!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—*two* mismatched pairs! I yank off my **Green Right Boot** and toss it to Maya? No—wrong size! Wait: if *Maya* wears her spare **Purple Right Shoe** on her right foot, she'll freeze *unless* she swaps her **Purple Left Skate Shoe** for my **Neon Orange Left Sneaker**! In two seconds flat, we kick off our left shoes, swap mid-stride—Maya rocks Purple Right + Orange Left, I rock Green Right + Purple Left—zero matches, zero freeze! We sprint shoulder-to-shoulder through the **Relay-Track Finish Tape**!
6. **51–56s Action Echo Punchline:**
   - We collapse onto the grass laughing in our mismatched, wrong-sized kicks while Coach Vance claps from the sidelines in one gold loafer and one pink croc.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Leo (Narrator, 13):** Protagonist. Skin: `#C68642`. Outfit: Track singlet (`Shirt`), black shorts (`Pants`), orange left / green right shoes, short curly hair. Face swaps: `determined` -> `scared` -> `grin` -> `proud`.
- **Maya (Best Friend, 13):** Relay partner. Skin: `#F1C27D`. Outfit: Track jersey (`Shirt`), navy shorts (`Pants`), purple left / yellow right shoes, ponytail. Face swaps: `scared` -> `shocked` -> `proud`.
- **Coach Vance (42):** Comic foil. Skin: `#FFDBAC`. Outfit: Tracksuit (`Shirt`/`Pants`), whistle, one gold loafer + one pink clog. Face swaps: `proud` -> `shocked` -> `grin`.

### Props & Sockets (Sound-Off Visible)
- **Neon Orange Left Sneaker:** `0.7 x 0.4 x 1.1` studs, `Plastic`, `#FF6B00`, socketed to `LeftFoot`.
- **Purple Left Skate Shoe:** `0.7 x 0.4 x 1.1` studs, `Plastic`, `#7209B7`, socketed to `LeftFoot`.
- **Relay-Track Finish Tape:** `10.0 x 0.3 x 0.05` studs, `Fabric`, `#FFFFFF`, socketed to `Workspace`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** School Track & Field Oval (`Brick`/`Plastic` red running track `#D62828`, white lane lines, hurdles, bleachers).
- **Secondary Set:** School Gym (`Wood` `#D4A373`).
- **Lighting & VFX/SFX:** `ClockTime = 16.0`, bright afternoon stadium sun `#FFF8E7`; VFX freeze-spark warning flash + ribbon tear; SFX shoe-lock clank, crowd roar, tape snap.

---

## Story 099 — The Countdown Umbrella

- **Story ID & Title:** `099` — The Countdown Umbrella
- **Format:** Standalone 53s, 45 beats
- **Voice Preset:** `urgent_teen`
- **Unstated Human Meaning:** When your own shelter only lasts sixty drops, the only roof that holds is the one you hold up together.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Monsoon Bay, every umbrella only blocks sixty raindrops—then snaps inside-out forever."
   - *Frame 1 Visual:* Pouring storm street; a commuter pops open a sleek black umbrella with a glowing `[60]` on top—*TICK-TICK-TICK!*—at `[00]`, *FWOOOMP!* It flips inside-out into a useless funnel.
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* Fancy lawyer Mr. Sterling buys a "ten-umbrella belt" for his walk to work, burns through all ten in two blocks, and sprints into court soaking wet wearing a plastic trash bin over his head.
   - *Town Adaptation:* Kids carry giant pocketfuls of cheap mini-parasols—trading them like baseball cards between bus stops.
   - *3 Named Planted Ammo Clues:*
     1. **One Remaining `[60]` Umbrella** (tucked under my arm).
     2. **Rolled Blue Camping Tarp** (strapped to the back of my soaked scout pack).
     3. **Four Stranded Kindergarteners** (huddled under a leaking bus-stop awning as floodwater rises).
3. **13.5–21s Personal Trap & Crisis:**
   - Flash-flood sirens blare down Harbor Street! The bus-stop awning collapses under the water, leaving **Four Stranded Kindergarteners** and my little sister Mia trapped fifty yards from the high-ground shelter—and a single umbrella only lasts sixty drops (about four seconds)!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* I pop my **One Remaining `[60]` Umbrella** over Mia's head—*TICK-50-40-30!*—at `[00]` it snaps inside-out before we pass the first lamppost!
   - *Clue 2 Fail:* I try spreading the **Rolled Blue Camping Tarp** overhead by myself—*FLAP-WHIP!*—the gale rips one corner straight out of my hands!
   - *Clue 3 Fail:* I yell *"Run for the door!"*—*SPLASH-SLIP!*—the little kids freeze in the blinding sheet of rain!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—a *tarp* isn't an umbrella; it has zero sixty-drop limit, it just needs *four corners held*! I drop to a knee, spread the **Rolled Blue Camping Tarp** wide, press each corner into a kindergartener's hands—*"Hold tight like a parachute!"*—and step into the center with Mia to prop the middle up with the snapped umbrella pole! Moving together as one giant blue turtle-shell, all six of us march dry and steady through the storm straight into the shelter!
6. **51–56s Action Echo Punchline:**
   - We shake the tarp dry inside the warm gym; Mia peeks out from under the blue plastic, grins, and hands me a dry towel.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Sam (Narrator, 14):** Protagonist. Skin: `#8D5524`. Outfit: Scout rain poncho (`Shirt`), cargo pants (`Pants`), short fade. Face swaps: `scared` -> `determined` -> `grin` -> `proud`.
- **Mia (Little Sister, 7):** Sidekick. Skin: `#8D5524`. Outfit: Pink hoodie (`Shirt`), jeans (`Pants`), braided hair. Face swaps: `scared` -> `grin`.
- **Mr. Sterling (48):** Comic foil. Skin: `#FFDBAC`. Outfit: Pinstripe suit (`Shirt`/`Pants`), briefcase, slick hair. Face swaps: `proud` -> `shocked`.

### Props & Sockets (Sound-Off Visible)
- **Countdown Umbrella:** `2.5 x 2.5 x 2.5` studs, `Fabric`/`Neon`, `#111111` with `Head` `BillboardGui` `"[60]"`, socketed to `RightHand`.
- **Blue Camping Tarp:** `8.0 x 0.1 x 8.0` studs, `Fabric`, `#0077B6`, socketed to `Workspace` / multi-hand corners.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Flooded Harbor Street (`Asphalt` `#2B2D42`, rising water plane `#4EA8DE`, collapsed bus-stop awning).
- **Secondary Set:** High-Ground Shelter Gym (`Wood` `#D4A373`).
- **Lighting & VFX/SFX:** `ClockTime = 17.5`, heavy storm slate `#3A4F6A`; VFX dense rain curtain + puddle splashes; SFX countdown ticks, umbrella snap, warm shelter door slam.

---

## Story 100 — The Laugh-Battery Town

- **Story ID & Title:** `100` — The Laugh-Battery Town
- **Format:** Standalone 55s, 47 beats
- **Voice Preset:** `viral_storyteller`
- **Unstated Human Meaning:** You don't need a hero's speech to light up a dark winter—sometimes one terrible dad joke shared at the right second sparks the whole town back on.

### 6-Phase Rule-Hack Narrative
1. **0–2.5s Active Hook:**
   - *Spoken:* "In Chucklefield, every streetlight and furnace in town runs on one thing—genuine human laughter."
   - *Frame 1 Visual:* Cozy snowy town square; two friends burst out laughing on a park bench—*ZAP-HUM!*—golden sparks shoot from their mouths into a brass lamppost, turning it bright warm amber!
2. **2.5–13.5s 3-Beat Rule Playground:**
   - *Absurd Public Disaster:* When town comedian Benny tries faking a laugh (*"HA-HA-HA-HA!"*) to charge his porch light, the meter flashes `[FAKE — 0 VOLTS]` and blows his own circuit breaker!
   - *Town Adaptation:* Neighbors host Friday porch joke-offs, keeping the town grid at a cozy `95%` charge all autumn.
   - *3 Named Planted Ammo Clues:*
     1. **Town Grid Meter Tower** (glowing red at `[2% CRITICAL]` in the center of the snowy square).
     2. **Groan-Worthy Dad-Joke Card** (tucked in my pocket from Grandpa's birthday).
     3. **Frozen Brass Lamppost** (flickering out right above a shivering crowd of neighbors).
3. **13.5–21s Personal Trap & Crisis:**
   - A brutal December blizzard knocks out morale—everyone's too cold and stressed to laugh, and at 6:00 PM the **Town Grid Meter Tower** drops to `[0% BLACKOUT]`! Every streetlight, heater, and storefront goes pitch dark in freezing wind!
4. **21–39s Rule-of-3 Failed Attempts:**
   - *Clue 1 Fail:* The mayor steps onto the gazebo and tells a rehearsed speech joke—*CRICKETS-BUZZ!*—nobody cracks a smile and the tower stays dead.
   - *Clue 2 Fail:* Class clown Toby slips on purpose into a snowbank—*THUD-GASP!*—people just rush over worried if he's okay!
   - *Clue 3 Fail:* I pull out my **Groan-Worthy Dad-Joke Card** and try reading it loud—*SHIVER-STAMMER!*—my teeth chatter so hard I botch the punchline!
5. **39–51s Genius Rule-Hack Climax:**
   - Wait—*forced* comedy fails, but *accidental* absurdity with real warmth sparks real laughs! Stepping under the **Frozen Brass Lamppost**, I drop the card, point straight at my own frost-covered eyebrows and mismatched mittens, and deadpan with total sincerity: *"Guys... what do you call a snowman with a six-pack? ...An abdominal snowman."* Silence for one beat—then Toby snorts, Grandpa wheezes, and the whole shivering crowd *erupts* into helpless, genuine laughter! *BZZT-WHOOSH!* Golden lightning arcs into the **Town Grid Meter Tower**, blasting `[100% CHARGED]` across every streetlight in town!
6. **51–56s Action Echo Punchline:**
   - Warm amber light floods the snow; neighbors hug, hot cocoa mugs clink, and I tuck Grandpa's **Dad-Joke Card** right back in my pocket with a grin.

### Characters (Classic R6 + Catalog Outfits + `classic_v1` Faces)
- **Leo (Narrator, 13):** Protagonist. Skin: `#F1C27D`. Outfit: Red winter parka (`Shirt`), snow pants (`Pants`), knit beanie, mismatched mittens. Face swaps: `scared` -> `determined` -> `grin` -> `proud`.
- **Toby (Class Clown, 13):** Sidekick. Skin: `#FFDBAC`. Outfit: Green puffer (`Shirt`), jeans (`Pants`), orange scarf. Face swaps: `scared` -> `shocked` -> `grin`.
- **Mayor Higgins (55):** Town leader. Skin: `#E0AC69`. Outfit: Wool overcoat (`Shirt`), slacks (`Pants`), top hat. Face swaps: `determined` -> `shocked` -> `proud`.

### Props & Sockets (Sound-Off Visible)
- **Town Grid Meter Tower:** `3.5 x 12.0 x 3.5` studs, `Metal`/`Neon`, `#2B2D42` with `Head` `BillboardGui` `"[0% BLACKOUT]"` -> `"[100% CHARGED]"`, socketed to `Workspace`.
- **Frozen Brass Lamppost:** `1.0 x 9.0 x 1.0` studs, `Metal`/`Neon`, `#D4AF37` with `#FFB703` bulb, socketed to `Workspace`.
- **Dad-Joke Card:** `0.6 x 0.4 x 0.05` studs, `Plastic`, `#FFF8E7`, socketed to `RightHand`.

### Sets/Scenes, Lighting & Camera
- **Primary Set:** Chucklefield Snowy Town Square (`Cobblestone` `#ADB5BD`, `Snow` drifts `#F8F9FA`, gazebo, storefronts, lamppost ring).
- **Secondary Set:** Park Bench Corner (`Wood` `#6F4E37`).
- **Lighting & VFX/SFX:** `ClockTime = 18.0`, pitch-dark blizzard blue `#14213D` flipping to radiant warm amber `#FFB703` grid-wide; VFX golden laugh-spark arcs; SFX power-down drone, awkward cricket, roaring laugh chorus, grid surge chime.
