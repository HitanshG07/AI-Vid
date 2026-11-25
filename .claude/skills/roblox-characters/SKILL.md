---
name: roblox-characters
description: Make, fix and animate authentic-looking Roblox characters in Roblox Studio via the Studio MCP (locked method: classic R6 from a catalog HumanoidDescription plus our own 2D face decals and emotion swaps). Use whenever a story needs characters.
---
# Roblox Characters (AI-Vid)
Any AI can follow this. Studio jobs run ONE at a time (see CORE.md and config.yaml).
**LOCKED METHOD (owner-approved 2026-11-17):** every character, main AND extra, is a classic **R6** avatar built in Studio from a catalog `HumanoidDescription`, with our own flat 2D face decals. Argon, `generate_avatar`, head clones, mesh imports and Blender characters are all retired (they failed the owner's standard). Where this file disagrees with older notes, this file and CORE.md win.

## 1. Build: `CreateHumanoidModelFromDescription` (R6 only)
```lua
local d = Instance.new("HumanoidDescription")
d.Shirt, d.Pants = <catalogShirtId>, <catalogPantsId>
d.HairAccessory = "<hairId>"              -- comma-separated ids allowed
d.HeadColor = Color3.fromRGB(234,184,146) -- same for limbs/torso
local m = game:GetService("Players"):CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R6)
```
- R15 default rigs ignore decal faces (dynamic head), so never R15.
- Find clothing/hair/accessories with `AvatarEditorService:SearchCatalog` (Relevance sort). They render unowned in Studio (0 Robux). Choose detailed classic Shirts/Pants, layered hair and themed accessories that read like the reference shorts (varsity jackets, hoodies, printed tees, swimwear). Never bare default bodies; vary extras so crowds aren't clones.
- Catalog Face items are NOT searchable via `SearchCatalog`; faces come from section 2.
- **Cast flow (V5.3):** story.yaml `cast:` lists name/gender/default_face/pos. `core_engine.luau` builds rigs from it via `Engine.buildRig()` and swaps faces via `Engine.setFace()`. `cast_001.luau` / `cast_002.luau` are reference only for catalog ids and outfit style. `buildRig` adds FLOOR_Y=0.2 automatically (set floors sit at y=0.2; the engine hides the baseplate).
- Build gotchas: anchor ONLY `HumanoidRootPart` (anchoring accessory handles detaches hair); floor-snap by the lowest body part, not the bounding box (accessories skew it).

## 2. Faces: our own flat 2D decals
- Source: `engines/faces/classic_faces.py` draws transparent PNGs into `assets/faces/classic_v1/` (neutral, scared, shocked, grin, determined, proud). Uploaded ids are in `assets/faces/classic_v1/ids.json`.
- Emotion swap (from the story.yaml beat `face`) = set the Head's `face` Decal `Texture` (`Engine.setFace(model, beat.face)`). No head swapping.
- A new emotion = add it to `classic_faces.py`, regenerate, upload, update `ids.json`, log in `assets/INDEX.md`. Never use free Creator Store face decals (mostly opaque white or fake checkerboard backgrounds). If you must read one, a Decal asset id is not its image id: resolve with `game:GetObjects("rbxassetid://<id>")[1].Texture`.
- Superseded (history only): dynamic-head FaceControls, AI-generated per-emotion head clones, ClassicHead welds, `ServerStorage.ApprovedFaces`.

## 3. Save
Cast lives in story.yaml; log any new catalog ids/outfits in `assets/INDEX.md`. Optionally export `.rbxm` to `assets/rigs/`.

## 5. Animation basics (Roblox docs)
- Load on the **`Animator`** (inside the Humanoid), not on the Humanoid itself (deprecated).
- For NPC/cutscene models, play from a server `Script` or drive directly in edit/cutscene code.
- `track:Play(fadeTime, weight, speed)`. Priority order: `Idle < Movement < Action < Action2..4 < Core`. Give overlapping tracks different priorities.
- To animate only the upper body, the animation asset must key only those joints (there's no runtime mask).
- Edit-mode cutscenes (our engine) have no Animator: joints are driven per frame in code (CORE.md section 1). The points below apply only to Animation Editor assets.
- Animation Editor (Creator Hub, Animation Editor page): runs at 30 fps; easing per keyframe is Linear, Constant, CubicV2, Elastic or Bounce with In/Out/InOut. Use **CubicV2**, not the deprecated Cubic. A loop does not blend the last keyframe into the first, so copy the opening keys to the end of looping idles.
Sources consulted: Roblox Creator docs (Animator, HumanoidDescription). Animation notes were cross-checked against github.com/sentinelcore/roblox-skills (unlicensed, so not copied).

## v2 rules (2026-11-19, owner-approved)
- Follow the **catchiness gates** in `CORE.md`: active rule (not a badge), rule visible in frame 1, 3 planted clues, taboo broken by 25s, rule-of-3 attempts, rule-hack climax, action-echo ending, no moral/lecture lines. Avg >= 8.5, none below 8, every gate passes.
- Voice and pacing come from `config.yaml` (Kokoro, 185-195 WPM).
- Every cast entry declares `gender` (boy/girl/man/woman); all clothing, hair and accessories must match it.
- Cutscenes run on `engines/roblox/core_engine.luau` (never edit it); it resets `loco` every frame; no frozen rigs; no wall-clipping or tilted giant-face filler shots.

## Learned on story 002 (2026-11-19)
- In a quick lineup test, anchor ONLY HumanoidRootPart. Anchoring every part before parenting stops accessories (hair) from attaching.
- Look at every catalog item in the viewport: a "womens winter coat" result rendered as a bare-midriff crop top. Never give two extras the same hair, and never dress an extra in the hero's colour.
- Search with gendered terms ("boy puffer jacket", "girl pink pajamas", "men tracksuit", "women jeans") and log the catalog name next to each id in the cast file.
- A creature with no face decal (blank pale head) reads as eyeless with no new asset.

## Learned on story 003 (2026-11-19 & 2026-11-20)
- **No floating nameplates (owner rule):** Always set `hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None`, `hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff`, and `hum.DisplayName = ""` on EVERY rig (main cast AND background crowd) `core_engine.luau` already disables them; verify in the lineup before recording.
- **Season-matched outfits:** Never reuse beachwear (e.g. floral shirts, swimsuits, lifeguard whistles) from summer stories inside winter stories. Verify every rig's outfit against the story's climate in `screen_capture`.
- **Proportional city crowds:** Large city/avenue sets need 8+ varied, gender-locked, nameplate-free background pedestrians placed along sidewalks, shops, and benches so the town feels alive.
- **R6 Motor6D Limb Kinematics:** Local Z is pitch (forward/back swing), local X is roll/abduction. Swapping them causes limbs to flap sideways like wings. Always prefer native R6 AnimationTracks (`r.loco = "walk"` or `"run"`) via `Animator:LoadAnimation` for anatomically correct motion, using procedural offsets only for upper-body gestures (clutching, chopping, hugging).
- **R6 PrimaryPart Consistency:** Always enforce `m.PrimaryPart = m.HumanoidRootPart` in `register(m)` so `r.m:PivotTo()` pivots consistently around the root, avoiding unexpected foot-submergence or head-level displacement.
- **Chest Accessories & Flat Placement:** When pinning items to character chests (e.g. Dad's pocket watch), attach directly to `Torso` with `CF(0, 0.2, -0.56) * CFrame.Angles(0, math.rad(90), 0)` so the accessory sits flat against the chest without decal bleed-through or floating.
- Check walking paths and idle positions against props with clearance for arms and bags (no clipping through lockers/desks).
- On-screen marks/labels (e.g. glowing names): verify who wears the mark, whose name it shows, that it is readable in the portrait crop, and that the pairing is understandable.
- **Translation vs Yaw Direction (No Moonwalking):** When translating characters, ensure the motion vector matches the LookVector (e.g. `lerp(3.0, 7.5, u)` with yaw = 180 to walk forward toward camera +Z, never backwards).
