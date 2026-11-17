---
name: roblox-characters
description: Make, fix and animate authentic-looking Roblox characters in Roblox Studio via the Studio MCP (locked method: classic R6 from a catalog HumanoidDescription plus our own 2D face decals and emotion swaps). Use whenever a story needs characters.
---
# Roblox Characters (AI-Vid)
Any AI can follow this. Studio jobs run ONE at a time (see AGENTS.md).
**LOCKED METHOD (owner-approved 2026-11-17):** every character, main AND extra, is a classic **R6** avatar built in Studio from a catalog `HumanoidDescription`, with our own flat 2D face decals. Argon, `generate_avatar`, head clones, mesh imports and Blender characters are all retired (they failed the owner's standard). Where this file disagrees with older notes, this file and AGENTS.md "Asset process" win.

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
- Per-story **cast builder** = a Luau module like `engines/roblox/cast_011.luau`: a CAST table (catalog ids + skin + default face), `build(name, x, floorY, z, yaw, parent)` and `setFace(model, emotion)`. Write `engines/roblox/cast_<ID>.luau` from MANIFEST section C.
- Build gotchas: anchor ONLY `HumanoidRootPart` (anchoring accessory handles detaches hair); floor-snap by the lowest body part, not the bounding box (accessories skew it).

## 2. Faces: our own flat 2D decals
- Source: `engines/faces/classic_faces.py` draws transparent PNGs into `assets/faces/classic_v1/` (neutral, scared, shocked, grin, determined, proud). Uploaded ids are in `assets/faces/classic_v1/ids.json`.
- Emotion swap (from beats.json `face`) = set the Head's `face` Decal `Texture` (`setFace(model, beat.face)`). No head swapping.
- A new emotion = add it to `classic_faces.py`, regenerate, upload, update `ids.json`, log in `assets/INDEX.md`. Never use free Creator Store face decals (mostly opaque white or fake checkerboard backgrounds). If you must read one, a Decal asset id is not its image id: resolve with `game:GetObjects("rbxassetid://<id>")[1].Texture`.
- Superseded (history only): dynamic-head FaceControls, AI-generated per-emotion head clones, ClassicHead welds, `ServerStorage.ApprovedFaces`.

## 3. Save
Keep the cast builder in `engines/roblox/` and log it in `assets/INDEX.md`. Optionally export `.rbxm` to `assets/rigs/`.

## 5. Animation basics (Roblox docs)
- Load on the **`Animator`** (inside the Humanoid), not on the Humanoid itself (deprecated).
- For NPC/cutscene models, play from a server `Script` or drive directly in edit/cutscene code.
- `track:Play(fadeTime, weight, speed)`. Priority order: `Idle < Movement < Action < Action2..4 < Core`. Give overlapping tracks different priorities.
- To animate only the upper body, the animation asset must key only those joints (there's no runtime mask).
- Edit-mode cutscenes (our engine) have no Animator: joints are driven per frame in code (LESSONS "Cutscene code"). The points below apply only to Animation Editor assets.
- Animation Editor (Creator Hub, Animation Editor page): runs at 30 fps; easing per keyframe is Linear, Constant, CubicV2, Elastic or Bounce with In/Out/InOut. Use **CubicV2**, not the deprecated Cubic. A loop does not blend the last keyframe into the first, so copy the opening keys to the end of looping idles.
Sources consulted: Roblox Creator docs (Animator, HumanoidDescription). Animation notes were cross-checked against github.com/sentinelcore/roblox-skills (unlicensed, so not copied).
