# Report for Argon: test of the kit character mesh in Roblox Studio (Mia)
Date: 2026-11-16 · Project: AI-Vid (Roblox story shorts, 1080x1920) · Tested: `Mia_R15_Riggable.obj` + `.mtl` from your v3 kit

## 1. What we did
1. Opened your Mia mesh in Blender 5.3, kept the 15 R15 part names and the hair.
2. Put your face (`Mia_Happy_head.png`) into the model, UV-mapped on the front of the Head.
3. Exported to .glb, uploaded it to Roblox (Open Cloud Assets API) and inserted it into Studio.
4. Placed it next to our current Mia, an avatar made with Roblox's own avatar generator (screenshot: `kit_mia_vs_current_mia.jpg`; **left = your mesh, right = current Mia**).

## 2. Result: not usable yet (our current Mia looks clearly better)
| Area | Your mesh | What we need |
|---|---|---|
| Arms | fused into the torso as one wide slab, no shoulders or gaps | separate upper arm, lower arm and hand, with a clear gap from the torso |
| Hands | none visible / a square block | small rounded hands, with a slight finger shape or a mitten |
| Torso | flat box, white stripe | shaped sweater with a collar (white collar points), sleeves and a slight taper |
| Skirt | missing: legs are one dark box | a pleated skirt that flares out, with legs visible below |
| Legs / shoes | one block | two separate legs, with shaped white sneakers |
| Head | sharp cube | beveled, rounded classic Roblox head (the cylinder-ish 1.2 head), not a sharp cube |
| Hair | flat cap on top | volume: a fringe/bangs, a ponytail that sits behind the head, strands |
| Proportions | reads as a boxy boy | clearly a teen girl: narrower shoulders, the hair, the skirt |
| Face | clean 2D face, good style ✔ | keep this style (3-layer eyes, catchlights) |
| Colours | correct in the .mtl ✔ | keep them, but deliver them as a texture (see 3) |
| Rig | no joints or bones | include joints (see 3) |

Detail level: the whole body is about 108 faces. Our current characters are far more detailed. **Target ~3,000–10,000 triangles per character**, with bevels and soft shapes.

## 3. Technical requirements (so the model works in Studio first time)
1. **Format:** `.fbx` (preferred) or `.glb`. Roblox can't upload `.obj`. Keep a `.obj` copy for our archive if you like.
2. **Colours must be a TEXTURE, not material colours.** Roblox ignores material base colours (everything imported grey). Bake every colour and the face into **one texture atlas PNG** (1024² or 2048²) with UVs. We proved this works.
3. **Rig:** a Roblox R15 skeleton with the 15 standard part names (`Head`, `UpperTorso`, `LowerTorso`, `LeftUpperArm`, `LeftLowerArm`, `LeftHand`, `RightUpperArm`, `RightLowerArm`, `RightHand`, `LeftUpperLeg`, `LeftLowerLeg`, `LeftFoot`, `RightUpperLeg`, `RightLowerLeg`, `RightFoot`). Each part is a separate mesh with its pivot at the joint, so Studio's Avatar Importer can rig it. Better still, export rigged with bones that match R15 names.
4. **Scale:** about 5.5–6 studs tall (1 stud ≈ 0.28 m), facing **−Z**, feet at Y = 0.
5. **Faces:** the face is a **separate front decal area** on the head UV, so we can swap emotions (Determined, Happy, Shocked, Worried, Crying, Smirk, Sad, Straining) without changing the skin. One skin hex per character (see `skin_tones.json`).
6. **Hair and accessories:** separate meshes (`Hair_*`) welded to the Head.
7. **Naming:** model name = character name (`Mia`, `Hero`, `Jace`, `Teacher`, `Grandma`, `LittleHero`, `Extra1..6`).

## 4. Please send next
- **Mia v2** to the spec above first, as one test character. We'll test it the same way (side by side with the current Mia). If it matches or beats the current Mia, do the rest of the cast.
- Props: fine as they are, but also bake their colours into a texture (the armchair imported flat cream).

## 5. Files in this package
- `ARGON_REPORT_character_mesh_test.md`: this report
- `kit_mia_vs_current_mia.jpg`: the side-by-side in Studio (left = your mesh, right = current)

- `Mia_atlas.png`: the texture atlas we baked from your colours and face (an example of the format we need)
