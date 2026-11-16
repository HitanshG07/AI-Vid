---
name: roblox-characters
description: Make, fix and animate authentic-looking Roblox characters in Roblox Studio via the Studio MCP (main characters via generate_avatar, bystanders via dressed HumanoidDescription), including classic 2D face decals and emotion swaps. Use whenever a story needs characters.
---
# Roblox Characters (AI-Vid)
Any AI can follow this. Studio jobs run ONE at a time (see AGENTS.md).

## 1. Main / named characters: `generate_avatar`
- Prompt pattern: `classic Roblox avatar, blocky body, <hair>, <outfit colours>, <age/role>, clean and polished`. Use `pipelineName: "npc"` (clothing baked in) and keep the dynamic head (`dynamicHead: true`) so expressions can be animated via FaceControls (see section 2).
- It takes minutes and often returns "Request timeout" while still finishing. **Check Workspace before retrying**, never fire a duplicate.
- Rename the model to the character name right away (`Hero`, `Mia`...).

## 2. Faces: expressive and slightly realistic, changing with the story
**User preference (2026-11-15):** NOT the generic default smiley, and NOT fully human. Faces should be stylised but a bit realistic (like craftee_films / zaylento characters) and must **change expression with the narration** (shocked, crying, determined...) on every emotional beat.
- Preferred: keep `generate_avatar` dynamic heads and drive expressions with the head's `FaceControls` per beat (e.g. `JawDrop`, `EyesLookUp`, `LeftLipCornerPuller`). Map each beats.json `face` name to a FaceControls preset stored in `assets/faces/expressions.json`.
- **Tested 2026-11-15 on Mia:** FaceControls deform the MOUTH and cheeks well (Happy = clear smile; good for talking/lip movement). Eyes and brows are painted into the texture and DON'T move, so Shocked/Crying/Angry barely read. Valid FACS names include JawDrop, Funneler, Pucker, LeftLipCornerPuller, LeftCheekRaiser, LeftDimpler, LeftLowerLipDepressor, ChinRaiser, LeftEyeClosed, LeftInnerBrowRaiser, LeftOuterBrowRaiser, LeftBrowLowerer, EyesLookUp/Down (Right* mirrors exist). There's no LeftUpperLidRaiser/UpperLipRaiser. Presets live in ServerStorage.FacePresets.
- **Chosen method (2026-11-15): per-emotion head clones.** Clone the character's `Head` MeshPart (keep only the SurfaceAppearance), then `generate_texture` it with: `stylized cartoon Roblox character face, <age/gender>, skin colour exactly <HEX>, <hair> at top edges, <EMOTION>: <eyes/brows/mouth details>, clean bold lines, soft cel shading, expressive animated-movie style, not realistic`. Make ONLY the emotions the story's beats use. Up to 4 generate_texture calls in parallel work in one Studio (about 1 in 4 fails, so retry those).
- **SKIN TONE MUST STAY IDENTICAL per character** (user rule). Record each character's skin hex in `assets/faces/skin_tones.json` (Hero = #E8CFA8). The text prompt alone does NOT reliably hold skin colour: outputs drift tan/pink/blush. Compare every new head next to the body and reject drifters.
- **Reference image (hintImage):** the format that works is `{"mimeType":"image/jpeg","data":"<base64 jpeg, ~256px>"}` (plain asset ids and urls fail). Tested 2026-11-15: it did NOT hold the identity. The result came out washed-out white skin, blonde hair and the wrong expression. Not reliable yet.
- Fallback: a custom stylised face decal set per character (one PNG per emotion in `assets/faces/<character>/`), never the stock smiley.

### Classic-head swap (only when a head looks wrong)
If a generated head looks human (it has `FaceControls` / a `SurfaceAppearance` face on a MeshPart `Head`):
1. Back the model up to `ServerStorage` first.
2. Set the mesh `Head.Transparency = 1`.
3. Add a `Part` "ClassicHead" with `SpecialMesh` `MeshType = Head`, `Scale ≈ 1.25` × head size, skin colour, welded to the head.
4. Add `Decal` "face" on the Front face. Default smile: `rbxasset://textures/face.png`. Store emotion faces in `assets/faces/` and log them in `assets/INDEX.md`.
5. **Known catch:** hair on generated npc avatars is often baked into the head mesh, so hiding the head hides the hair. Then add a catalog hair `Accessory` (via HumanoidDescription `HairAccessory` + `ApplyDescription`, or `insert_asset` of a free hair) or regenerate with `dynamicHead: false`.
6. Screenshot (`screen_capture`) and check it before saving to `assets/`.

## 3. Bystanders / extras: HumanoidDescription script (fast, ~1s, no upload)
```lua
local d = Instance.new("HumanoidDescription")
d.Shirt, d.Pants, d.Face = <catalogShirtId>, <catalogPantsId>, <faceId>
d.HairAccessory = "<hairId>"           -- comma-separated ids allowed
d.HeadColor = Color3.fromRGB(234,184,146) -- same for limbs/torso
local m = game:GetService("Players"):CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R15)
```
Must be **fully dressed** (hair + shirt + pants + face) and varied. Bare colour-only bodies look generic and were rejected. Save each extra as `assets/rigs/<name>.luau` (the description values) so it can be rebuilt anywhere.

## 4. Emotion face swaps (from beats.json `face`)
`model.ClassicHead.face.Texture = FACES[beat.face]` where `FACES` maps `Happy/Shocked/Worried/Straining/Crying/Determined/Sad/Smirk` → asset ids from `assets/faces/`.

## 5. Animation basics (Roblox docs)
- Load on the **`Animator`** (inside the Humanoid), not on the Humanoid itself (deprecated).
- For NPC/cutscene models, play from a server `Script` or drive directly in edit/cutscene code.
- `track:Play(fadeTime, weight, speed)`. Priority order: `Idle < Movement < Action < Action2..4 < Core`. Give overlapping tracks different priorities.
- To animate only the upper body, the animation asset must key only those joints (there's no runtime mask).

## 6. Save
Export final characters as `.rbxm` to `assets/rigs/` (or keep the generating script). Log path, how made, prompt and source in `assets/INDEX.md`.

Sources consulted: Roblox Creator docs (Animator, HumanoidDescription). Animation notes were cross-checked against github.com/sentinelcore/roblox-skills (unlicensed, so not copied).
