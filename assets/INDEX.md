# Asset Index — reusable across all stories (reference by path in beats.json)
| Path | Type | Description | How generated (tool + prompt) | Source / License |
|---|---|---|---|---|
| Studio: Workspace.Hero / Mia / Jace / Teacher / Grandma | character (main) | Story 007 cast, R15 | Roblox generate_avatar (npc pipeline) | uploaded to user 1272229789 |
| Studio: ServerStorage.ApprovedFaces (13 heads) | face set | v1-style emotion heads per character (see assets/faces/STYLE.md, skin_tones.json) | generate_texture on head clones | Roblox AI |
| Studio: Set_ChemLab, Set_Hallway | map | school lab + hallway, fixed walls/ceiling/signs | generate_scene + manual fixes | Roblox AI |
| engines/roblox/sets/grandma_room.luau | map builder | classic part-built grandma living room | written by AI (Opus) | own |
| assets/maps/story007.rbxl | place file | all story 007 sets, cast, faces | Studio save | own |
| reference/design_bible/01..05_*.jpg | style refs | cast sheets, extras/props sheet, 9:16 framing, DO/DON'T board | external kit v3 | kit (update/kit_v3) |
| assets/meshes/props/*.obj (12) | prop meshes | AcidBottle, WaterBottle, LabBeaker, GlassShard_Needle, CafeteriaMilkCup, Smartphone, YellowPencil, WallClock, WristRewindRing, TestTubeRack, GrandmaArmchair, DorsalAgeVeins_Overlay. Import via Argon/Studio only | external kit v3 | kit |
| assets/faces/generated_pngs/<Char>/ | face PNGs (88) | 3-layer-eye emotion decals/heads for 007 cast + Extra1..6 | external kit v3 | kit |
| assets/faces/skin_tones.json, STYLE_kit_v3.md | style data | locked skin hex per character | external kit v3 | kit |
| assets/rigs/build_all_riggable_characters_kit_v3.luau, assets/maps/grandma_room_kit_v3.luau | reference scripts | kit builders, NOT wired into engine (reference only) | external kit v3 | kit |
| archive/kit_v3_unused/ | unused | kit character .obj + Blender rigger (banned: no Blender characters) | external kit v3 | kit |
| assets/meshes/props/glb/GrandmaArmchair.glb, TestTubeRack.glb | Blender-converted kit props (named sub-objects + materials kept) | EXPERIMENT: Blender 5.3 headless, engines/blender/exp_convert.py; uploaded; see asset IDs: armchair 115695632301186, rack 129071033550568, head 93488731810333 | EXPERIMENT |
| assets/meshes/heads/Hero_Determined_blenderhead.glb | beveled 1.2-stud head, front UV = Hero_Determined_head.png | EXPERIMENT: engines/blender/exp_convert.py; uploaded; see asset IDs: armchair 115695632301186, rack 129071033550568, head 93488731810333 | EXPERIMENT |
| assets/meshes/characters/Hero_R15_Riggable.glb, Mia_R15_Riggable.glb | kit R15 beveled-box rigs, 18 MeshParts, no joints, MTL Kd in glb | EXPERIMENT: engines/blender/kit_convert.py; asset ids Hero 92178719613717, Mia 100827774792298; Studio imports them GREY (baseColorFactor ignored) | EXPERIMENT |
| assets/meshes/characters/Mia_full.blend/.glb/.obj/.mtl + Mia_atlas.png | Mia with Kd colours + Mia_Happy_head face baked in a single texture atlas (face region on Head front) | EXPERIMENT: engines/blender/mia_atlas.py + mia_full.py; glb asset id 140094093813678; colours+face show in Studio only after moving TextureID into SurfaceAppearance.ColorMap | EXPERIMENT |
