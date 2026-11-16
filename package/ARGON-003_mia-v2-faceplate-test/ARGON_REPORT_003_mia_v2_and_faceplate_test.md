# ARGON-003: Studio test of Mia_v2.glb and the faceplate fix (2026-11-16)
For: Argon. Please audit this and send back one clean method.

## Screenshots (in this folder)
| File | What it shows |
|---|---|
| `Mia_v2_glb_vs_Faceplate_vs_Current.jpg` | **Left:** current Mia (Studio generate_avatar). **Middle:** current Mia + faceplate. **Right:** Mia_v2.glb. All viewed from the front (−Z). |
| `Mia_v2_glb_side.jpg` | Mia_v2 seen from the other side: the face sits on the **side** of the head |
| `Mia_faceplate_close.jpg` | Close-up of the faceplate on current Mia |

## Test 2A: `Mia_v2.glb` (asset 90862987438852)
Import: Open Cloud upload → InsertService:LoadAsset → 15 MeshParts. The colours only render after moving each `TextureID` into a `SurfaceAppearance.ColorMap` (otherwise black). That's the same as in ARGON-002.

| Item | Result |
|---|---|
| Body: separate arms, A-pose gap, C-hands | ✔ big improvement over the v1 kit |
| Sweater + collar points | ✔ |
| Flared skirt | ✔ (pleats faint) |
| Separate legs + sneakers | ✔ |
| Colours via atlas | ✔ (after the SurfaceAppearance fix) |
| **Face** | ✘ **Printed on the side of the head (the +X side), not the front.** From the front the head is blank skin. The UV/atlas face region is mapped to the wrong side. |
| **Hair** | ✘ A solid black block/helmet with no visible bangs. The ponytail reads as a flat slab and covers the side face. |
| Orientation | Body front is −Z ✔, but the face is not on the front |
| Rig | No joints (MeshParts only). Needs Motor6D/bones for animation |

## Test 2B: `fix_main_cast_faces.luau` (faceplate on current Mia)
| Item | Result |
|---|---|
| As shipped (SpecialMesh Head, scale 1.05, 1.05, 0.45, placed at Head.CFrame × (0, −0.07·Y, −0.43·Z)) | ✘ Rendered as a **thin vertical sliver**. The generate_avatar Head's local axes aren't front = −Z, so the plate faces sideways. Also `_G.RigBuilder.attachFaceToPart` doesn't exist in our repo, so no face appears |
| Our manual fix (flat 0.95×0.8×0.05 part, world-aligned to the face, raycast to sit 0.03 in front of the face surface, Decal = Mia_Happy_decal) | Partly works: it hides the 3D nose/lips and shows the 2D face with no hair bleed. ✘ But it's a **flat square** sticking out from the curved head |

## Verdict
The current Mia still looks best overall. Neither option is ready.

## What we need back (one clean method)
1. **For the .glb route:**
   - Put the face on the **front (−Z) of the Head**, centred under the bangs.
   - Make the hair a real fringe plus ponytail (not a block).
   - Include an R15 rig (bones or Motor6D-ready pivots).
   - Ideally deliver it so the colours work without the SurfaceAppearance step: PBR baseColor texture → test in Studio's 3D Importer.
2. **For the faceplate route:**
   - Give a **curved** plate mesh (.glb), shaped to the generate_avatar head front.
   - Size and orient it using the head's **actual front direction** (detect it with a raycast or the face attachment, not the local −Z).
   - Include the face as a texture on the plate (no `_G.RigBuilder` dependency).
3. Say which route you recommend. We'll test it the same way (side by side with current Mia).

## Related
- `ARGON-002_character-mesh-test/` (v1 kit test)
- `assets/meshes/characters_v2_highpoly/` (the meshes tested)
- `engines/roblox/fix_main_cast_faces.luau` (the script tested)
