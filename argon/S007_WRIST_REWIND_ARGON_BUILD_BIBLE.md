# S007 "Wrist Rewind" — ARGON BUILD BIBLE (build every asset from scratch)

> **For:** Argon (asset builder)
> **From:** AI-Vid
> **Date:** 2026-11-16
> **Version:** 1.0
>
> **Goal:** rebuild all of Story 007 from scratch to one consistent, polished "Roblox story" look. If this works, the method becomes the standard for every future story.
> **Story spec this serves:** `stories/007_wrist-rewind/MANIFEST.md` (beat-by-beat director table). This bible defines *what every asset is and looks like*. The manifest defines *when it is used*.

---

## 0. Contents
1. The one rule: characters must look made for a Roblox story
2. Naming & numbering convention
3. Technical delivery spec (applies to every asset)
4. Colour themes & lighting grades
5. Characters (CH-01 … CH-12)
6. Emotion sheets (EM-*)
7. Maps / sets (MP-01 … MP-03)
8. Buildings & architecture pieces (BL-*)
9. Props (PR-*)
10. VFX (FX-*)
11. Animations (AN-*)
12. Audio reference (SFX-*), already made, listed for completeness
13. Story → asset map (which asset appears in which beat)
14. Delivery folder layout & checklist
15. Acceptance test (how we judge it)

---

## 1. THE ONE RULE: characters must look made for a Roblox story
Every character must look like it belongs in a **viral Roblox story short** (the "Roblox story / Brookhaven-style storytelling" look). A viewer must instantly read it as **Roblox**, not as a realistic 3D person, not as a toy block, and not as a different game.

### 1.1 DO
- **Roblox R15 avatar proportions.** The head is slightly big for the body (≈ 1/4.5 of height). Square-ish shoulders, straight limbs, simple mitten or C-shaped hands, chunky rounded shoes.
- **Soft beveled shapes.** Every edge is rounded (bevel ≈ 0.05–0.08 studs). No razor-sharp cubes, but also no realistic muscles.
- **Layered-clothing look.** Clothes are separate shapes with thickness: sweater over a collar, skirt flaring off the hips, jacket edges, sleeve cuffs, folded collars. Fabric is solid colour with light stitch and fold detail baked in the texture.
- **Real 3D hair accessories.** Volume, chunky strands, a fringe or bangs, ponytails, buns. Hair sits ON the head like a Roblox hair accessory and frames the face.
- **2D cartoon faces** (Roblox story style). Big expressive eyes with **3 layers**: white sclera with a dark outline, coloured iris + black pupil, and 2 white catchlights. Simple eyebrows, a small or no nose (a tiny line or none), a simple mouth line or shape, optional soft blush. The face is **flat and painted**, never sculpted.
- **Readable silhouette at phone size.** Each character must be identifiable from 2 metres away on a phone by silhouette + colour (hair shape, outfit colour).
- **One locked skin hex per character** (see §4.1). It must be the same on head, neck, hands and legs.

### 1.2 DON'T
- ✘ No realistic sculpted faces (no 3D nose, nostrils, lips or eyelids). This is the main problem with our current cast.
- ✘ No plain box bodies with arms fused to the torso (the problem with the first kit mesh).
- ✘ No faces mapped to the side of the head, and no hair that hides the face (the problem with Mia_v2).
- ✘ No default Roblox `:|` smiley.
- ✘ No anime proportions (tiny body, huge eyes taking half the head), no chibi.
- ✘ No textures with photo noise or realistic skin pores.

### 1.3 Reference feel (look, don't copy)
- The head-to-body ratio and shapes of a standard Roblox R15 "Rthro Narrow / classic blocky" blend.
- The clothing reads like 2024–2026 Roblox **layered clothing**.
- The faces read like Roblox **story-channel 2D faces**: clean vector cartoon, big glossy eyes.
- Design bible sheets in `reference/design_bible/01–05` (in this repo) show our approved face style and the DO/DON'T board.

---

## 2. Naming & numbering convention
Every asset has an **ID**, a **file name** and an **in-engine name**. All three must match this table.

| Type | ID pattern | File name pattern | In-engine (Studio) name |
|---|---|---|---|
| Character | `S007-CH-01` | `S007_CH01_Hero.fbx` | `Hero` |
| Emotion (face texture) | `S007-EM-01-03` (character 01, emotion 03) | `S007_EM01_03_Hero_Shocked.png` | `Hero_Shocked` |
| Map / set | `S007-MP-01` | `S007_MP01_Set_ChemLab.rbxm` | `Set_ChemLab` |
| Building piece | `S007-BL-01` | `S007_BL01_LabWindowWall.fbx` | `BL_LabWindowWall` |
| Prop | `S007-PR-01` | `S007_PR01_AcidBottle.fbx` | `PR_Acid` |
| VFX | `S007-FX-01` | `S007_FX01_TapRing.rbxm` | `FX_TapRing` |
| Animation | `S007-AN-01` | `S007_AN01_WristTap.rbxm` (KeyframeSequence) | `AN_WristTap` |
| Colour palette | `S007-CL-01` | `S007_CL01_GoldenLab.ase` / `.png` swatch | `—` |

**Rules:**
- IDs are never reused.
- A new version of an asset keeps its ID and gets a version suffix: `S007_PR01_AcidBottle_v2.fbx`.
- Sub-parts inside a model use the exact names listed in each asset entry. Our engine finds them by name.

---

## 3. Technical delivery spec (every asset)
| Item | Requirement |
|---|---|
| Format | **`.fbx`** (preferred) or **`.glb`**, one file per asset. Also keep the source (`.blend` or equivalent). Roblox cannot import `.obj`. |
| Units / scale | 1 stud = 0.28 m. Characters are **5.5–6.0 studs tall** (teen), kid 3.7, adult 6.3. Feet at Y = 0. |
| Facing | Front faces **−Z**. The face on characters is on the **−Z side of the head**, centred. |
| Colour | **Texture-based.** Bake all colour into a texture atlas (base colour PNG, 2048² for characters, 1024² for props). Material colour alone imports grey in Roblox. Use PBR: BaseColor, plus optional Normal and Roughness (Roblox SurfaceAppearance). |
| Triangles | Teen/adult character 6k–12k. Kid 5k–9k. Hero props 500–3k. Small props 100–800. Set pieces as needed (keep each mesh < 20k, Roblox's per-mesh limit). |
| Rig (characters) | **Roblox R15 skeleton**: the 15 parts below, each a separate mesh **or** one skinned mesh with R15 bone names, so Studio's 3D Importer / Avatar setup rigs it with Motor6Ds. Pivot at each joint. |
| R15 part names | `Head, UpperTorso, LowerTorso, LeftUpperArm, LeftLowerArm, LeftHand, RightUpperArm, RightLowerArm, RightHand, LeftUpperLeg, LeftLowerLeg, LeftFoot, RightUpperLeg, RightLowerLeg, RightFoot` |
| Accessories | Hair, glasses, collars, skirts and jackets are separate meshes named `Acc_<Name>` (e.g. `Acc_HairPonytail`), attached to the right part with an attachment point (`HatAttachment`, `HairAttachment`, `WaistCenterAttachment`). |
| Faces | The face is **not baked into the head mesh texture**. The head's front (−Z) has its own UV island (a square, 512² area of the atlas) so we can swap emotion textures (§6). Deliver each emotion as a separate PNG with a transparent background (face only) **and** a skin-filled version. |
| Props | `CanQuery`-friendly simple collision. A root part named `Root`. A `GripAttachment` where a hand holds it. Animated sub-parts named as listed. |
| Pose | Characters in an **A-pose** (arms ~25° down from horizontal) with a clear gap between the arms and the torso. |
| Test before sending | Import into Roblox Studio with the 3D Importer and check that the colours show, the face is on the front, it's upright and facing −Z, and the rig moves. Send a screenshot with each delivery. |

---

## 4. Colour themes & lighting grades
### 4.1 Locked skin tones (never change)
| Character | Skin hex | Notes |
|---|---|---|
| CH-01 Hero / CH-07 LittleHero | `#E8CFA8` | warm light |
| CH-02 Mia | `#EBCBB2` | rosy light |
| CH-03 Jace | `#F2CFA4` | golden light |
| CH-04 Teacher | `#EFD5B8` | neutral light |
| CH-05 Grandma | `#F3D9C8` | pale, soft |
| CH-08…12 Extras | pick from `#F3D9C8 #E8CFA8 #C99A6B #A87250 #7A4E2D`, so the extras are **varied** | one per extra, list it in the delivery |

### 4.2 Scene palettes
| ID | Name | Used in | Key colours (hex) | Mood |
|---|---|---|---|---|
| S007-CL-01 | **Golden Lab** | MP-01 present day | walls `#E9DCC6`, wainscot wood `#8A5A36`, bench tops black `#22252B`, bench body `#6E7B86`, chalkboard `#2F4A3A`, floor tile `#C9C2B5`/`#A39C8F`, sun `#FFD9A0` | warm, late afternoon, safe |
| S007-CL-02 | **Rewind Cyan** | any rewind/tap beat | overlay `#A8C8FF`, ring `#50AAFF`, streaks `#78C3FF` | cold, magical, time bending |
| S007-CL-03 | **Sepia Memory** | MP-03 grandma flashbacks | walls dusty rose `#C9A0A0`, wainscot `#7A5240`, rug red `#8E2E2E`, lamp `#FFDCAA` | nostalgic, sad |
| S007-CL-04 | **Hall Cool** | MP-02 hallway montage | lockers `#3E6E9E`, walls `#DDE3E8`, floor `#B8B2A6` | everyday school |
| S007-CL-05 | **Danger** | acid/crack beats | acid green `#82E68C`, glow `#B4FF9A`, smoke `#E1F5E1`, crack neon `#EBFFEB` | threat |

### 4.3 Lighting grades (engine presets, for reference so assets look right under them)
| Grade | Look | Settings |
|---|---|---|
| `G.n` present | warm golden hour, long shadows | `ClockTime = 16.8`, tint `#FFF4E6`, contrast +0.08, sun rays, Future lighting, DOF on background |
| `G.r` rewind | cool cyan | tint `#AAC8FF`, saturation −0.3, contrast +0.15 |
| `G.s` memory | sepia | tint `#FFDCA5`, saturation −0.8, fill light ≤ 0.8 |

Assets must read clearly under all three grades. Avoid colours that vanish in sepia, like pure mid-grey on grey.

---

## 5. Characters
Each entry gives: ID, role, height, skin, full outfit with hex, hair, accessories, silhouette key, personality in pose, emotions needed, body states and what they physically do.

### S007-CH-01 · **Hero** (`Hero`): narrator, 15, the saver
| Field | Spec |
|---|---|
| Role | Main character and narrator. Quiet, careful, kind. Has never used a single tap. |
| Height / build | 5.8 studs, slim teen, slightly narrow shoulders |
| Skin | `#E8CFA8` |
| Hair | `Acc_HairSwoop`: medium-length brown `#4A2E1B` swoop fringe falling to the right eyebrow, short back and sides, 4–5 chunky strand clumps, subtle highlight `#6B4428` |
| Top | `Acc_LabCoat`: open white lab coat `#F4F6F8` to mid-thigh, rolled-cuff sleeves with **long sleeves that can be pulled over the hands** (needed P2 30.3s; make the sleeve end a separate part `SleeveEndL/R` we can scale down over the hand), 2 front pockets, light fold lines. Under it a **blue crew-neck tee** `#1E56A0` |
| Bottom | dark navy chinos `#1D2432`, slight crease |
| Shoes | white chunky sneakers `#F0F2F5` with grey sole `#B9BEC6` |
| Accessories | safety goggles `Acc_GogglesUp` resting on the forehead above the fringe (clear lens `#CFEFFF` 40% transparency, strap `#2B2B2B`) |
| Silhouette key | white coat + brown swoop + goggles on the head |
| Pose default | relaxed, hands at the sides, slight forward lean (shy) |
| Emotions | EM-01-01 Determined, -02 Happy, -03 Shocked, -04 Worried, -05 Straining, -06 Crying, -07 Sad |
| Body states | **Hand aging 0 → 1** in 4 steps (0.25 per tap): see FX-07 Age Veins. Hands go from smooth `#E8CFA8` to slightly darker `#CDB08A` with 3 thin vein/crease lines on the back of each hand and knuckle creases |
| Does (story) | taps his left wrist with his right index finger; makes a fist; lowers his head; eyes the bottles; trembles; yells with arms out; grabs Jace's arm; gets shoved and staggers; cries at his wrinkled hands; watches; swaps 2 bottles with both hands; pulls his sleeves over his hands; holds a pencil and smiles |

### S007-CH-02 · **Mia** (`Mia`): classmate in danger, kind
| Field | Spec |
|---|---|
| Role | Sits beside Jace. Once lent Hero a pencil when nobody talked to him. Nearly hurt by the cracking beaker. |
| Height / build | 5.6 studs, slim teen girl, narrower shoulders than Hero |
| Skin | `#EBCBB2` |
| Hair | `Acc_HairPonytailBangs`: black-brown `#1E1612`, **straight blunt bangs** just above the eyebrows (**must not cover the eyes**), side locks to the jaw, **high arched ponytail** (4 segments, swings) tied with a yellow scrunchie `#F2C230`. Shine streak `#3A2C24` |
| Top | mustard-yellow knit sweater `#D69A2D` with ribbed cuffs and hem (slightly darker `#B8811F`), **white pointed collar** `#FFFFFF` showing at the neck (2 collar points), sleeves to the wrists |
| Bottom | **black pleated skirt** `#1A1A1F`, 12–18 pleats, flares out from the hips, above the knee |
| Legs | skin-tone legs, white crew socks `#F5F5F5` |
| Shoes | white sneakers `#F7F7F7`, pink lace accent `#F2A3B5` |
| Accessories | safety goggles around her neck `Acc_GogglesNeck` (optional, nice detail) |
| Silhouette key | ponytail arc + yellow sweater + flared black skirt |
| Pose default | upright, hands loosely together in front |
| Emotions | EM-02-01 Happy, -02 Shocked, -03 Worried, -04 Smiling (soft, warm closed-mouth smile), -05 Laughing (P2 48s) |
| Does | turns her head toward Jace; slides a pencil along the bench; leans in toward the beaker; freezes in shock as glass shards fly at her; asks "why now?"; smiles; slides the pencil again; laughs |

### S007-CH-03 · **Jace** (`Jace`): show-off, 30-year-old hands
| Field | Spec |
|---|---|
| Role | Selfie-obsessed. Uses taps on bad selfies, so his hands look 30. Pours the acid. |
| Height / build | 6.0 studs, sporty teen, broader shoulders |
| Skin | `#F2CFA4` |
| Hair | `Acc_HairSpikedQuiff`: bleached-blond `#E3C16F` tall spiky quiff with darker roots `#8A6A3A`, shaved sides |
| Top | open **red varsity bomber** `#C8312F` with white sleeves `#F2F2F2`, ribbed collar and cuffs striped `#1E1E1E/#F2F2F2`, a big "J" patch `#F2D04B` on the chest; under it a black tee `#1B1B1E` |
| Bottom | ripped light-blue jeans `#7FA6CF`, knee rips showing white threads |
| Shoes | high-top red and white sneakers `#C8312F/#FFFFFF` |
| Accessories | `Acc_Chain`: thin gold chain `#D9B44A`; **his phone is always in his LeftHand** (PR-06); optional sunglasses pushed up in his hair `#111` |
| Body state | **aged hands at 0.75–0.85 permanently**: visibly older than his face (darker `#D2A97C`, veins, knuckle creases). This must read on a phone screen |
| Silhouette key | blond spikes + red bomber + phone in hand |
| Emotions | EM-03-01 Smirk (default, one corner up, eyebrow raised), -02 Happy (grin at selfie), -03 Shocked, -04 Worried |
| Does | holds up his phone for selfies and poses (head tilt, peace sign optional); shows his old hands; grabs the red bottle; pours (tilts 95°); shoves Hero with his left arm; turns ~150° away to pose; checks his selfie; taps his wrist for a selfie redo |

### S007-CH-04 · **Teacher** (`Teacher`): Ms. Alvarez, chemistry teacher
| Field | Spec |
|---|---|
| Role | Writes on the chalkboard with her back turned. Never notices anything. |
| Height / build | 6.3 studs, adult woman |
| Skin | `#EFD5B8` |
| Hair | `Acc_HairBunPencil`: dark auburn `#6B2E1F` neat low bun with a pencil stuck through it, two loose face strands |
| Outfit | white lab coat `#F4F6F8` over a teal blouse `#2E8B8B`, charcoal pencil skirt `#3A3D44` to the knee, dark tights `#2A2A2E`, low black heels `#151515` |
| Accessories | thin rectangular glasses `Acc_GlassesRect` (frame `#3A2A20`); chalk in her right hand (white `#FAFAFA` stick, 0.08×0.08×0.3) |
| Emotions | EM-04-01 Happy (teacher smile), -02 Determined (writing focus), -03 Shocked (optional) |
| Does | writes on the board with her right arm raised (loop), back to class |

### S007-CH-05 · **Grandma** (`Grandma`): spent her taps on herself
| Field | Spec |
|---|---|
| Role | Hero's grandmother in flashbacks. Fully aged, shaking hands. |
| Height / build | 5.6 studs, slightly stooped, soft round shoulders |
| Skin | `#F3D9C8`, with gentle smile lines painted on the face texture |
| Hair | `Acc_HairGreyBun`: silver-white `#D9D9DE` curly short bob with a small bun, soft wave clumps |
| Outfit | **plum-lavender cardigan** `#8E638D` with 4 round buttons `#E8E0D0`, over a cream blouse `#F1E7D6` with a lace collar; long dusty-blue skirt `#6E7FA0` to the ankles; brown slippers `#6A4A35` |
| Accessories | round wire glasses `Acc_GlassesRound` (`#B8A070`) on a beaded chain; a knitted shawl over the shoulders (optional, `#C9A0A0`) |
| Body state | **hands fully aged** (darker `#D8B8A0`, many fine lines, slight age spots `#B88A70`); hands tremble (animation) |
| Emotions | EM-05-01 Sad, -02 Crying, -03 Happy (soft) |
| Does | sits in an armchair; taps her wrist repeatedly; her shaking hand drops away from little Hero's hand; trembles |

### S007-CH-06 · *(reserved, unused)*

### S007-CH-07 · **LittleHero** (`LittleHero`): Hero aged ~6 (flashback)
| Field | Spec |
|---|---|
| Height | 3.7 studs (kid scale), bigger head ratio (≈ 1/3.8) |
| Skin / hair | same as Hero: `#E8CFA8`, brown `#4A2E1B` messy short mop with a cowlick |
| Outfit | striped tee `#F2C230`/`#1E56A0` horizontal stripes, red shorts `#C8312F`, white velcro sneakers |
| Emotions | EM-07-01 Crying (big tears, wobbly mouth), -02 Happy, -03 Sad |
| Does | reaches up for Grandma's hand; cries when it drops |

### S007-CH-08…12 · **Extras** (`Extra1`…`Extra6`): students (6 rigs; IDs CH-08 to CH-13)
All are fully dressed, **all different**, never clones. Same Roblox story style. Teen height 5.5–5.9.

| ID | Engine name | Skin | Hair | Outfit | Role in story | Emotions |
|---|---|---|---|---|---|---|
| CH-08 | `Extra1` | `#C99A6B` | short black twists `#151110` | green hoodie `#3E8E5A`, grey joggers `#8C9096`, black sneakers | drops his phone and rewinds it (P1 6.7s); turns away from Hero (P1 25.9s) | Neutral, Happy, Shocked |
| CH-09 | `Extra2` | `#F3D9C8` | ginger braid `#C2552B` | denim jacket `#4F6E99` over a white tee, black leggings, white sneakers | spills milk and rewinds it (P1 6.7s); turns away (P1 25.9s) | Neutral, Happy, Shocked |
| CH-10 | `Extra3` | `#A87250` | curly afro puff `#2A1A12` | orange sweater `#E07A2E`, khaki trousers `#B9A27A`, brown boots | taps and **ages** in the rule demo (P1 4.5s) | Neutral, Shocked |
| CH-11 | `Extra4` | `#E8CFA8` | blond bob `#E3C16F` | lilac cardigan `#A889C9`, plaid skirt `#5A4A6E`, black flats | background at a lab bench | Neutral, Happy |
| CH-12 | `Extra5` | `#7A4E2D` | buzz cut `#120D0A` | navy school blazer `#22325A`, grey trousers, black shoes | walks into class (P1 21s) | Neutral |
| CH-13 | `Extra6` | `#EBCBB2` | long brown waves `#5A3A25` | pink hoodie `#E58FAE`, white jeans `#EDEDED`, white sneakers | walks into class (P1 21s) | Neutral, Happy |

---

## 6. Emotion sheets (faces)
**Style for all faces:**
- 512×512 PNG.
- Thick dark outline `#2A1E1A` (≈ 6 px) on the eyes.
- White sclera `#FFFFFF`. Iris coloured per character. Black pupil.
- **2 white catchlights**: a big one at top-left, a small one at bottom-right.
- Simple brows (character hair colour).
- Tiny or no nose (a single soft curve, 2 px, 30% opacity).
- Mouth as a simple flat shape with a dark outline. An inner mouth `#7A2E2E` and teeth `#FFFFFF` only when open.
- Optional blush `#F4A3A3` at 30%.

Every emotion uses the **same eye positions and face layout** per character; only the brows, eyelids, pupils and mouth change. That way swaps don't "jump".

| Iris colours | Hero `#5A3A22` brown · Mia `#3B2A20` dark brown · Jace `#3E7CC0` blue · Teacher `#4E7A4E` green · Grandma `#7A7A88` grey-blue · LittleHero = Hero |
|---|---|

### 6.1 Emotion definitions (apply per character)
| Emotion | Brows | Eyes | Mouth | Extras |
|---|---|---|---|---|
| **Determined** | angled down toward the centre, firm | slightly narrowed (upper lid covers 15%), pupils centred | straight line, slight frown at the corners | — |
| **Happy** | relaxed, arched | open, a little squint from smiling | open smile, top teeth showing | blush on |
| **Smiling** (soft) | relaxed | gentle, lower lids raised | closed curved smile | light blush |
| **Laughing** | raised | closed happy arcs (∩ shape) | big open laugh | blush on |
| **Shocked** | high, raised arches | **wide**, small pupils, white visible all round | small "O" open mouth | — |
| **Worried** | inner ends raised (\ /) | open, pupils looking slightly up | small wavy frown | — |
| **Straining** | furrowed hard, inner ends down | squeezed, half shut | gritted teeth, wide flat rectangle | sweat drop `#A8D8FF` at the temple |
| **Crying** | inner ends raised | shut or half-shut, glossy | wobbly open frown | **tear streams** `#9ED3FF` from both eyes, rosy cheeks |
| **Sad** | inner ends raised, soft | half-lidded, looking down | small downturned line | — |
| **Smirk** | one brow raised (left) | half-lidded, confident | one corner up (right), closed | — |
| **Neutral** | flat | open, relaxed | small flat line | — |

### 6.2 Required emotion files (IDs)
| Character | Emotion files |
|---|---|
| CH-01 Hero | EM-01-01 Determined · 01-02 Happy · 01-03 Shocked · 01-04 Worried · 01-05 Straining · 01-06 Crying · 01-07 Sad |
| CH-02 Mia | EM-02-01 Happy · 02-02 Shocked · 02-03 Worried · 02-04 Smiling · 02-05 Laughing |
| CH-03 Jace | EM-03-01 Smirk · 03-02 Happy · 03-03 Shocked · 03-04 Worried |
| CH-04 Teacher | EM-04-01 Happy · 04-02 Determined · 04-03 Shocked |
| CH-05 Grandma | EM-05-01 Sad · 05-02 Crying · 05-03 Happy |
| CH-07 LittleHero | EM-07-01 Crying · 07-02 Happy · 07-03 Sad |
| CH-08…13 Extras | EM-08…13-01 Neutral · -02 Happy · -03 Shocked |

---

## 7. Maps / sets
Each set is a complete, closed room (walls, floor, ceiling) built in Roblox studs, delivered as an `.rbxm` model (or `.fbx` pieces + a layout JSON). Keep the **coordinates** below, because the engine places characters at these marks.

### S007-MP-01 · **Set_ChemLab** (school chemistry lab), palette CL-01
| Field | Spec |
|---|---|
| Size | 48 × 16 (high) × 44 studs. Origin centre floor at (0, 0, −398) |
| Feel | warm late-afternoon high-school chem lab; tidy, lived-in |
| Floor | 2×2-stud vinyl checker tiles `#C9C2B5`/`#A39C8F`, slight gloss (roughness 0.4) |
| Walls | painted plaster `#E9DCC6` over **wood wainscot** `#8A5A36` up to 3.5 studs, with a chair rail `#6E4328` |
| Ceiling | white acoustic tiles `#F2F2EE` with 6 long fluorescent panel lights (soft, `#FFF6E5`, off or dim; the sun is the key light) |
| Back wall (−Z, z≈−420) | **chalkboard** BL-03, 20×6 studs, `#2F4A3A`, wooden frame `#6E4328`, chalk tray; formulas written in chalk (`2H₂ + O₂ → 2H₂O`, a molecule sketch); **wall clock** PR-09 at (12, 14, −419.4) |
| Left wall (−X) | **3 tall windows** BL-01 with warm sunbeams (volumetric), blinds half up `#EDE6D8`, a plant pot on the sill |
| Right wall (+X) | glassware shelves BL-05 (beakers, flasks, labelled jars), a periodic table poster `#F5F0E6`, a safety poster, an eyewash station |
| Front (+Z) | door BL-04 with a window strip, a coat hook row |
| Benches | 6 lab benches BL-02 in 3 rows × 2 (centres x = ±15, z = −406 / −397 / −388), **top height 4.4 studs** (teen waist), black resin top `#22252B` 20×3.6, grey cabinet body `#6E7B86` with silver handles, a gas tap and sink on each |
| **Main bench (story)** | row z = −395.4 (ZP), x from −22 to −8. Marks: Hero x = −20 · Jace x = −15.5 · Mia x = −11.5 (all behind the bench facing +Z) |
| Props on the main bench | Water bottle PR-02 at (−16.4, TOP, ZP) · Acid bottle PR-01 at (−15.6, TOP, ZP) · Beaker PR-03 at (−14.0, TOP, ZP) · Pencil PR-08 at (−12.6, TOP+0.08, ZP+0.5) · Test tube rack PR-10 at (−10.5, TOP, ZP−0.6) |
| Other benches | each has 1–3 small props (beaker, flask, notebook PR-13, goggles), varied |
| Lighting | sun from the left windows at `ClockTime 16.8`, long shadows across the benches; warm bounce |
| Sound bed | quiet room tone (we add it) |
| Rule visibility | the clock is visible in wides; aged hands are visible in hand shots (sound-off rule) |

### S007-MP-02 · **Set_Hallway** (school corridor), palette CL-04
| Field | Spec |
|---|---|
| Size | 12 wide × 12 high × 60 long, centred at (100, 0, −400) |
| Floor | polished terrazzo `#B8B2A6` with a darker border stripe `#8E877B` |
| Walls | `#DDE3E8` upper, **blue lockers** BL-06 `#3E6E9E` (2-high, with vents and dials) along both sides; a notice board with paper flyers; a trophy case |
| Ceiling | panel lights, an exit sign `#2E9E4E` |
| Marks | Extra1 (98.5, −404) · Extra2 (101.5, −399) · Extra3 (100, −396) |
| Props | dropped phone PR-07, milk cup PR-05, backpacks PR-14 on the floor by the lockers |

### S007-MP-03 · **Set_GrandmaRoom** (grandma's living room), palette CL-03
| Field | Spec |
|---|---|
| Size | 20 × 11 × 20, centred at (195, 0, −400) |
| Walls | dusty-rose wallpaper `#C9A0A0` with a faint floral pattern, **wood wainscot** `#7A5240` |
| Floor | dark wood planks `#5E4030` with a **red patterned rug** `#8E2E2E` (border `#D8B070`) |
| Furniture | **Armchair** PR-11 (Grandma's seat) at the window; a side table with a lace doily, teacup PR-15 and a lamp (warm `#FFDCAA`); a **bookshelf** `Shelf` at (188.9, 3.5, −394) full of books; framed family photos; a knitting basket with yarn `#8E638D` |
| Window | net curtains, soft light |
| Marks | Grandma seated (armchair, pivot dropped 0.6) · LittleHero at (198.3, −406.2), yaw −90 |
| Lighting | warm lamp + fill ≤ 0.8 (sepia grade on top) |

---

## 8. Buildings & architecture pieces (reusable kit)
| ID | Name | Size (studs) | Look / colours | Notes |
|---|---|---|---|---|
| BL-01 | `BL_LabWindowWall` | 14 × 12 × 1 | white frames `#F2F2EE`, 3 tall panes, blinds `#EDE6D8` | glass slightly transparent, for sun rays |
| BL-02 | `BL_LabBench` | 20 × 4.4 × 3.6 | black resin top `#22252B`, grey cabinets `#6E7B86`, chrome tap and sink | top must be flat at exactly 4.4 |
| BL-03 | `BL_Chalkboard` | 20 × 6 × 0.3 | `#2F4A3A`, wood frame `#6E4328`, chalk dust texture | separate `ChalkText` decal layer |
| BL-04 | `BL_DoorClassroom` | 4 × 8 × 0.4 | wood `#8A5A36`, window strip, silver handle | `Hinge` attachment |
| BL-05 | `BL_GlassShelf` | 8 × 7 × 1.5 | wood shelves, glassware set | glass at 50% transparency |
| BL-06 | `BL_LockerBank` | 6 × 7 × 2 (3 lockers) | blue `#3E6E9E`, vents, dials, number plates | — |
| BL-07 | `BL_Wainscot` | modular 4 × 3.5 | wood `#8A5A36` / `#7A5240` | used in the lab and grandma's room |
| BL-08 | `BL_SchoolExterior` *(optional, for a future establishing shot)* | 80 × 30 × 40 | red brick `#A4523A`, white trim, clock tower, warm windows at sunset | not in the current cut |

---

## 9. Props
Every prop has: `Root` part, `CanQuery = true`, sub-part names exactly as listed, colours baked in a texture, and `GripAttachment` if it's held.

| ID | Engine name | Description | Size (studs) | Colours / material | Sub-parts (exact names) | Held? | Used |
|---|---|---|---|---|---|---|---|
| PR-01 | `PR_Acid` | **Acid bottle**: lab reagent bottle, **identical shape to PR-02** | 0.5 Ø × 1.2 h | clear glass (tint `#E6F0F0`, 40% transparent), green liquid `#82E68C`, **red label** `#D23A32` with a white skull/"ACID" text, black cap `#1B1B1B` | `Glass`, `Liquid`, `Label`, `Cap`, `Mouth` (attachment at the pour lip) | Jace RightHand | P1 30–50, P2 0–9, 16 |
| PR-02 | `PR_Water` | **Water bottle**: same mesh as PR-01 | same | clear glass, clear liquid `#DDEFFF`, **no label** (plain) | same as PR-01 (no Label) | swapped by Hero, poured by Jace | P1 30, P2 14, 23.8, 25.8 |
| PR-03 | `PR_Beaker` | 600 ml lab beaker with a pouring spout | 1.0 Ø × 1.4 h | glass, white measuring lines, rim `#FFFFFF` | `Glass`, `Liquid` (scalable, green), `Rim`, `Crack_1…5` (thin neon lines on the +X face, hidden until the crack beat) | — | P1 38–50, P2 0–9 |
| PR-04 | `PR_Shard` ×12 | glass needle shards | 0.05 × 0.07 × 0.45 each | alternating clear glass and glowing mint `#96FFDC` | single mesh, 3 shape variants | — | P1 44–50, P2 0–3 |
| PR-05 | `PR_MilkCup` | school milk cup, red with a white rim | 0.58 Ø × 0.85 h | red `#D72D2D`, white rim `#FFFFFF`, milk `#FFFFF5` | `Cup`, `Rim`, `Milk` | Extra2 RightHand | P1 6.7 |
| PR-06 | `PR_Phone` | Jace's phone: modern, rounded, gold case | 0.4 × 0.8 × 0.06 | case `#D9B44A`, screen `#101418` (selfie UI glow `#4AA3FF` when on), lens bump | `Body`, `Screen`, `Flash` (with PointLight) | Jace **LeftHand** (always) | everywhere |
| PR-07 | `PR_Phone2` | dropped phone (Extra1) | same as PR-06 | blue case `#3E6E9E` | same | Extra1 RightHand | P1 6.7 |
| PR-08 | `PR_Pencil` | yellow HB pencil | 0.14 × 0.14 × 1.3 | yellow `#F5C828`, pink eraser `#F08CA0`, silver ferrule `#C0C0C8`, wood tip `#E8C9A0`, graphite `#333` | `Wood`, `Eraser`, `Ferrule`, `Tip` | Mia → Hero RightHand | P1 24.8, P2 40.7–51 |
| PR-09 | `CLK` | wall clock | 2.8 Ø × 0.3 | black rim `#1E1E1E`, white face `#FAFAFA`, black numerals | `Rim`, `Face`, `HourHand`, `MinuteHand`, `SecondHand` (pivots at the centre for spinning) | — | P1 3.1, P2 37 |
| PR-10 | `PR_TubeRack` | test tube rack with 5 tubes | 1.8 × 1.0 × 0.55 | wood `#9A6A40`, tubes glass with coloured liquids (`#E05A5A`, `#5AA0E0`, `#E0C05A`, …) | `Base`, `TopRail`, `Tube_1…5` | — | set dressing |
| PR-11 | `PR_Armchair` | Grandma's wingback armchair | 3.6 × 4.2 × 3.4 | **sage-green velvet** `#7F9A7A`, dark wood legs `#4A3020`, gold cushion `#D8B070` | `Base`, `Seat`, `Back`, `ArmL`, `ArmR`, `Cushion` | — | MP-03 |
| PR-12 | `PR_Goggles` | safety goggles | 0.9 × 0.35 × 0.4 | clear lens `#CFEFFF`, black strap | `Lens`, `Strap` | on heads/benches | dressing |
| PR-13 | `PR_Notebook` | school notebook | 1.0 × 0.08 × 1.4 | covers in assorted colours | `Cover`, `Pages` | — | dressing |
| PR-14 | `PR_Backpack` | backpack | 1.4 × 1.8 × 0.8 | assorted colours | — | — | hallway dressing |
| PR-15 | `PR_Teacup` | floral teacup + saucer | 0.4 × 0.3 | white china with rose pattern | `Cup`, `Saucer` | — | MP-03 |

---

## 10. VFX
Delivered as Roblox-ready models (`ParticleEmitter`, `Beam`, `Neon` parts) **or** as a spec our engine reproduces. Every effect must **never hide a face or the hand**. Flash caps: screen brightness +0.04, bloom +0.12, light ≤ 2.5 with range 8.

| ID | Name | Trigger | Look | Duration | Rules |
|---|---|---|---|---|---|
| FX-01 | `FX_TapRing` | every wrist tap | thin neon ring `#50AAFF`, 0.05 thick, expands 0.3 → 1.6 Ø around the wrist, fades 55% → 100% transparent; plus 26 tiny sparkles (0.14) bursting outward | 0.3 s | ring only, no filled ball |
| FX-02 | `FX_RewindStreaks` | rewind moments | 8 neon streaks `#78C3FF` spiralling **backwards** around a centre point (radius 1.6) | the beat | — |
| FX-03 | `FX_GradeShift` | tap → rewind | screen tint to Rewind Cyan (CL-02), slight chromatic shimmer | 0.2 s in | grade only |
| FX-04 | `FX_PourStream` | pour beats | liquid stream cylinder, acid green neon `#C8F08C` or pale water `#DDEFFF`, slight wobble | 0.5–1 s | from bottle `Mouth` to beaker top |
| FX-05 | `FX_AcidSmoke` | acid in beaker | 4 soft pale puffs `#E1F5E1` rising and expanding | until rewind | beside Mia, never over her face |
| FX-06 | `FX_BeakerCrack` | P1 40.3s | 5 neon crack lines `#EBFFEB` growing across the beaker, liquid glows `#B4FF9A` | 1.7 s | cracks face +X (toward Mia) |
| FX-07 | `FX_AgeVeins` | each tap (Hero), always (Jace, Grandma) | 3 thin dark lines `#6B4A3A` + knuckle creases, flush with the back of the hand; skin tint darkens 0 → 1 | instant on a tap | must sit **inside** the hand surface (decal or 0.03-stud inset), never a box |
| FX-08 | `FX_Shards` | P1 44.3–50, P2 0–2.5 | 12 PR-04 needles burst from the beaker toward Mia's face, **freeze** mid-air at 72–80% of the way | — | they come from the side; the face stays visible |
| FX-09 | `FX_PhoneFlash` | selfies | phone flash light `#FFFFFF` + a quick screen pop | 0.15 s | within the flash caps |
| FX-10 | `FX_CamShake` | taps, crack, shove | camera jitter 0.3–1.5 | the beat | engine |
| FX-11 | `FX_BloomWarm` | P2 ending 38–51s | warm bloom swell `#FFE6C0` | — | gentle |
| FX-12 | `FX_ClockSpin` | rewind / "ten seconds" | clock hands spin backwards fast (−900°/s), then one tick | the beat | uses PR-09 sub-parts |
| FX-13 | `FX_MilkRewind` | P1 6.7s | spilled milk puddle + stream flow **back up** into the cup | 1.5 s | — |
| FX-14 | `FX_SunRays` | always in MP-01 | volumetric god-rays through the windows, dust motes | loop | — |

---

## 11. Animations (R15; deliver as KeyframeSequences or as described poses)
All animations use the R15 joint names. Our engine can also drive the joints itself, so the **pose descriptions** (angles) are the minimum we need.

| ID | Name | Who | Description | Type |
|---|---|---|---|---|
| AN-01 | `AN_WristTap` | Hero, Grandma, Extra3, Jace | left forearm raised across the chest (LeftUpperArm −60° pitch, LeftLowerArm 90°), right index finger hovers above the left wrist, then taps down (0.07 s spike) | one-shot / loop |
| AN-02 | `AN_FingerTremble` | Hero | AN-01 hover with the right hand trembling (±2.5° at 40 Hz) | loop |
| AN-03 | `AN_Selfie` | Jace | left arm raised forward, phone at face height, head tilt 12°, slight hip shift; optional peace sign with the right hand | hold |
| AN-04 | `AN_Reach` | all | arm extends forward to bench height | one-shot |
| AN-05 | `AN_HoldPour` | Jace | bottle in RightHand, wrist tilt 0 → 95° | hold |
| AN-06 | `AN_LeanIn` | Mia | upper torso leans 15° toward the beaker, head turned 20° | hold |
| AN-07 | `AN_Shove` | Jace / Hero | Jace's left arm thrusts (85°); Hero's torso jolts back 14° and he steps back | one-shot |
| AN-08 | `AN_Fist` | Hero | hand closes into a fist | one-shot |
| AN-09 | `AN_Walk` | Extra5/6 | classic Roblox walk (leg swing ±30°, arm swing) | loop |
| AN-10 | `AN_SleevePull` | Hero | arms bend, hands retract into the sleeves (`SleeveEnd` scales over the hands) | one-shot |
| AN-11 | `AN_ChalkWrite` | Teacher | right arm raised to the board, small writing circles | loop |
| AN-12 | `AN_GrandmaShake` | Grandma | seated, right hand shaking (±4° at 33–38 Hz), drops from 55° to 15° | loop / one-shot |
| AN-13 | `AN_KidReach` | LittleHero | reaches up with the left arm | hold |
| AN-14 | `AN_Laugh` | Mia | head and torso bob (±6° at 9 Hz) | loop |
| AN-15 | `AN_Idle` | all | breathing (torso ±1°) + a blink every 3–5 s (eyes-closed face frame) | loop |
| AN-16 | `AN_BottleSwap` | Hero | both hands lift both bottles and cross them in a small arc (0.6 stud lift) | one-shot |

---

## 12. Audio reference (already made; for completeness)
| ID | File | Use |
|---|---|---|
| SFX-01 | `assets/sfx/whoosh.wav` | hook, cut |
| SFX-02 | `rewind_zip.wav` | every tap/rewind |
| SFX-03 | `skin_creak.wav` | aging |
| SFX-04 | `shutter.wav` | selfies |
| SFX-05 | `ding.wav` | pencil |
| SFX-06 | `tick.wav` | tension |
| SFX-07 | `piano_note.wav` | grandma / ending |
| SFX-08 | `bell.wav` | class starts |
| SFX-09 | `glass_clink.wav` | bottles |
| SFX-10 | `pour.wav` | pour |
| SFX-11 | `hiss_crack.wav` | acid / crack |
| SFX-12 | `thud.wav` | shove |

---

## 13. Story → asset map
Times are seconds from the first word. The full camera and action detail is in `stories/007_wrist-rewind/MANIFEST.md`, section G.

### Part 1 (50.05 s)
| # | Time | Line | Set | Characters (emotion) | Props | VFX / anim |
|---|---|---|---|---|---|---|
| 1 | 0.00 | In my world, tapping your wrist rewinds any mistake | MP-01 | CH-01 (Determined → Shocked) | — | AN-01, FX-01, FX-03 |
| 2 | 3.14 | by ten seconds. | MP-01 | — | PR-09 | FX-12, FX-02 |
| 3 | 4.48 | But your hands age one year every time. | MP-02 | CH-10 (Shocked) | — | AN-01, FX-01, FX-07 |
| 4 | 6.68 | Kids rewind dropped phones and spilled milk. | MP-02 | CH-08, CH-09 (Happy) | PR-07, PR-05 | FX-13, FX-02 |
| 5 | 9.66 | Jace rewinds bad selfies | MP-01 | CH-03 (Smirk) | PR-06 | AN-03, FX-09 |
| 6 | 11.30 | he has thirty-year-old hands. | MP-01 | CH-03 (hands) | — | FX-07 |
| 7 | 13.18 | Mine are fifteen. Zero taps. | MP-01 | CH-01 (Worried), CH-03 | — | — |
| 8 | 15.26 | My grandma spent her taps on herself, | MP-03 | CH-05 (Sad) | PR-11 | AN-01, FX-01 |
| 9 | 17.40 | her hands shook too hard to hold mine. | MP-03 | CH-05, CH-07 (Crying) | PR-11 | AN-12, AN-13 |
| 10 | 19.84 | So I saved mine. | MP-01 | CH-01 (Determined) | — | AN-08 |
| 11 | 20.96 | Then chemistry class, last period. | MP-01 wide | CH-04, CH-12, CH-13 | all bench props | AN-09, AN-11, FX-14 |
| 12 | 23.34 | Mia sits beside Jace. | MP-01 | CH-02 (Happy) | — | — |
| 13 | 24.78 | She once lent me a pencil | MP-01 | CH-02, CH-01 (Happy) | PR-08 | AN-04 |
| 14 | 25.92 | when nobody else would talk to me. | MP-01 | CH-01 (Sad), CH-08, CH-09 turn away | — | — |
| 15 | 27.38 | Jace was showing off for his phone, as always. | MP-01 | CH-03 (Smirk) | PR-06 | AN-03, FX-09 |
| 16 | 30.44 | Two bottles, same shape, side by side. | MP-01 | CH-01 (Worried) | PR-01, PR-02 | — |
| 17 | 33.06 | Red label is acid. Plain one is water. | MP-01 | — | PR-01, PR-02 | highlight |
| 18 | 35.78 | He grabbed the red one. | MP-01 | CH-03 (Smirk) | PR-01 | AN-04, AN-05 |
| 19 | 37.22 | Mia leaned in to watch. | MP-01 | CH-02 (Happy) | — | AN-06 |
| 20 | 38.46 | He poured. The beaker hissed. | MP-01 | CH-02 (Shocked) | PR-01, PR-03 | AN-05, FX-04, FX-05 |
| 21 | 40.34 | The glass cracked, bulging toward her face. | MP-01 | CH-02 (Shocked) | PR-03 | FX-06, FX-10 |
| 22 | 43.20 | Nobody else saw it. | MP-01 wide | CH-04 (back turned) | — | AN-11 |
| 23 | 44.34 | My finger hovered over my wrist. | MP-01 | CH-01 (Worried) | PR-04 | AN-02, FX-08 |
| 24 | 46.34 | Fifteen years of saving. | MP-01 | CH-01 (Straining) | PR-04 | AN-02 |
| 25 | 47.82 | One tap breaks it. | MP-03 | CH-05 (Sad) hands | — | AN-12 |
| 26 | 48.96 | Do I spend it | MP-01 | CH-02 (Shocked) | PR-04 | FX-08 |
| 27 | 49.56 | on her? | MP-01 | CH-02 (Shocked), shards frozen | PR-04 | FX-08 · **hard cut** |

### Part 2 (51.55 s)
| # | Time | Line | Set | Characters (emotion) | Props | VFX / anim |
|---|---|---|---|---|---|---|
| 1 | 0.00 | Fifteen years of saving. | MP-01 | CH-01 (Straining) | PR-01, PR-03, PR-04 | AN-02, FX-05 |
| 2 | 1.62 | One tap. | MP-01 | CH-01 hand | — | AN-01, FX-01, FX-07 (0.25) |
| 3 | 2.54 | Ten seconds back, before the pour. | MP-01 | CH-01 (Determined), CH-03, CH-02 | PR-01, PR-03 | FX-02 (shards and crack reverse) |
| 4 | 4.56 | I yelled. He poured anyway. | MP-01 | CH-01 (Shocked) | PR-01 | AN-05, FX-04 |
| 5 | 6.66 | Tap. | MP-01 | CH-01 | — | AN-01, FX-01, FX-07 (0.5) |
| 6 | 7.12 | I grabbed his arm. | MP-01 | CH-01 (Determined), CH-03 (Shocked) | — | AN-04 |
| 7 | 8.28 | He shoved me, and poured. | MP-01 | CH-03 (Smirk), CH-01 | PR-01 | AN-07, FX-04, FX-10 |
| 8 | 9.90 | Tap. My knuckles started to wrinkle. | MP-01 | CH-01 (Crying) | — | AN-01, FX-07 (0.75) |
| 9 | 12.00 | So I stopped fighting and started watching. | MP-01 | CH-01 (Determined) | — | — |
| 10 | 14.22 | Water bottle, left of the acid. | MP-01 | — | PR-02 | highlight |
| 11 | 16.14 | He pours with his right hand. | MP-01 | CH-03 | PR-01 | AN-04 |
| 12 | 17.72 | At second seven, he turns to pose for his phone. | MP-01 | CH-03 (Smirk) | PR-06 | AN-03, FX-09 |
| 13 | 20.72 | Tap. Last loop. | MP-01 | CH-01 (Straining) | — | AN-01, FX-07 (1.0) |
| 14 | 22.08 | I waited. He turned. | MP-01 | CH-01 (Determined), CH-03 | — | — |
| 15 | 23.76 | Flash. I swapped the bottles. | MP-01 | CH-01 hands | PR-01, PR-02 | AN-16, FX-09 |
| 16 | 25.84 | He poured water. Nothing happened. | MP-01 | CH-03 | PR-02, PR-03 | FX-04 (water) |
| 17 | 27.40 | Jace checked his selfie, never the beaker. | MP-01 | CH-03 (Happy), CH-01 (Happy) | PR-06 | FX-09 |
| 18 | 30.26 | I pulled my sleeves over my hands. | MP-01 | CH-01 (Sad) | — | AN-10 |
| 19 | 32.30 | Mia saw them anyway. You never tap. Why now? | MP-01 | CH-02 (Worried), CH-01 (Sad) | — | — |
| 20 | 35.14 | Four taps. Four years. | MP-01 | CH-01 hands | — | AN-01 ×4, FX-01, FX-07 |
| 21 | 36.98 | For ten seconds. | MP-01 | — | PR-09 | FX-12 (one tick) |
| 22 | 38.22 | Mia smiled at me, her face perfect, | MP-01 | CH-02 (Smiling) | — | FX-11 |
| 23 | 40.70 | and lent me a pencil again. | MP-01 | CH-02, CH-01 (Happy) | PR-08 | AN-04 |
| 24 | 42.32 | Jace spends his years on selfies. | MP-01 | CH-03 (Smirk) | PR-06 | AN-01, AN-03, FX-07 |
| 25 | 44.48 | Grandma spent hers on her own mistakes. | MP-03 | CH-05 (Sad) | PR-11 | AN-12 |
| 26 | 46.72 | I spent mine on someone else. | MP-01 | CH-01 (Happy) | PR-08 in hand | FX-11 |
| 27 | 48.28 | A few years of my hands for her whole face. | MP-01 | CH-01 (Happy), CH-02 (Laughing) | PR-08 | AN-14 |
| 28 | 50.14 | They were saved for her. | MP-01 | CH-01 (Happy), CH-02, CH-03 | — | FX-11, stays bright |

---

## 14. Delivery folder layout & checklist
```
argon_delivery_S007/
  characters/   S007_CH01_Hero.fbx … S007_CH13_Extra6.fbx  (+ .blend source, + *_atlas.png)
  faces/        S007_EM01_01_Hero_Determined.png … (face-only transparent + skin-filled versions)
  maps/         S007_MP01_Set_ChemLab.rbxm, S007_MP02_Set_Hallway.rbxm, S007_MP03_Set_GrandmaRoom.rbxm
  buildings/    S007_BL01_LabWindowWall.fbx …
  props/        S007_PR01_AcidBottle.fbx … S007_PR15_Teacup.fbx
  vfx/          S007_FX01_TapRing.rbxm …  (or FX_SPEC.md if spec-only)
  anims/        S007_AN01_WristTap.rbxm …
  palettes/     S007_CL01_GoldenLab.png …
  screenshots/  one Studio screenshot per character (front + side) and per set
  DELIVERY.md   list of every file + ID + triangle count + any deviation from this bible
```
**Checklist (Argon, before sending):**
- [ ] Every ID in this bible is delivered, or listed in DELIVERY.md with the reason it isn't.
- [ ] Characters pass §1 (Roblox story look). Faces are on the front, flat 2D with 3-layer eyes.
- [ ] Imported in Studio: colours show (texture-based), upright, facing −Z, R15 rig moves.
- [ ] Skin hex matches §4.1 on head, hands and legs.
- [ ] Names match §2 exactly (files, models, sub-parts).
- [ ] Emotion PNGs line up (same eye positions per character).
- [ ] Sets match the coordinates and marks in §7.

## 15. Acceptance test (how we will judge it)
We import each asset and put it **side by side with our current version** in Studio (same method as ARGON-002 and ARGON-003). An asset passes if:
1. It reads as Roblox-story at phone size (§1).
2. It is equal to or better than the current asset in detail and polish.
3. It works in our engine: names, rig, attachments and colours all correct.

**Pilot order:** CH-02 Mia → CH-01 Hero → PR-01/02/03 → MP-01. If the pilot passes, do everything else. If the full set passes, **this bible format becomes the standard for every new story** (S008+).
