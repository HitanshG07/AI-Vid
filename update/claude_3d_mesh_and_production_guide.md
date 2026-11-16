# Master Claude Code Execution Prompt & Riggable 3D Mesh / Prop Guide (`Story 007 v3` + Universal Studio Kit)

This package contains **every single riggable 3D character mesh (`.obj`/`.mtl`), 3D prop mesh (`.obj`/`.mtl`), high-resolution 2D face decal (`88 PNGs`), Roblox Studio Luau rig/prop builder, Blender 4.x auto-rigger, visual design bible sheet (`5 JPGs`), and the v3-patched `story007_cutscene.luau` + Python pipeline** so you can hand this directly to **Claude Code (Opus 4.6 / Sonnet 4.6)** or run it in Roblox Studio / Blender on your ASUS ROG Strix G16 (`RTX 4060`).

---

## 1. Complete Inventory of Generated Assets in This Package

| Asset Folder | Files Included | How It Is Rigged & Customized |
| :--- | :--- | :--- |
| `reference/design_bible/` | • `01_Cast_Part1_Hero_Mia_And_6_Core_Emotions.jpg`<br>• `02_Cast_Part2_Jace_Grandma_Teacher_LittleHero.jpg`<br>• `03_Cast_Part3_6_School_Bystanders_And_12_Props.jpg`<br>• `04_Vertical_9x16_Framing_Hand_VFX_And_Cliffhanger.jpg`<br>• `05_Visual_QA_DO_vs_DONT_Rules_Board.jpg` | Visual reference sheets locking character proportions, 3-layer eye catchlights, role-coded wardrobe colors, 9:16 safe zones, and DO vs. DON'T rules. |
| `assets/meshes/characters/` | • `Hero_R15_Riggable.obj` + `.mtl`<br>• `LittleHero_R15_Riggable.obj` + `.mtl`<br>• `Mia_R15_Riggable.obj` + `.mtl`<br>• `Jace_R15_Riggable.obj` + `.mtl`<br>• `Teacher_R15_Riggable.obj` + `.mtl`<br>• `Grandma_R15_Riggable.obj` + `.mtl`<br>• `Extra1..6_R15_Riggable.obj` + `.mtl`<br>• `rig_joints_metadata.json`<br>• `parts/*.obj` (`7` standalone limb meshes) | Every `.obj` has **15 separate named R15 limb groups** (`Head`, `UpperTorso`, `LowerTorso`, `LeftUpperArm`, `LeftLowerArm`, `LeftHand`, `RightUpperArm`, `RightLowerArm`, `RightHand`, `LeftUpperLeg`, `LeftLowerLeg`, `LeftFoot`, `RightUpperLeg`, `RightLowerLeg`, `RightFoot`, plus `Hair_*` and `InnerShirtCollar`). `rig_joints_metadata.json` defines exact 3D joint pivot coordinates for instant rigging. |
| `assets/meshes/props/` | • `AcidBottle.obj` + `.mtl`<br>• `WaterBottle.obj` + `.mtl`<br>• `LabBeaker.obj` + `.mtl`<br>• `GlassShard_Needle.obj` + `.mtl`<br>• `CafeteriaMilkCup.obj` + `.mtl`<br>• `Smartphone.obj` + `.mtl`<br>• `YellowPencil.obj` + `.mtl`<br>• `WallClock.obj` + `.mtl`<br>• `WristRewindRing.obj` + `.mtl`<br>• `TestTubeRack.obj` + `.mtl`<br>• `GrandmaArmchair.obj` + `.mtl`<br>• `DorsalAgeVeins_Overlay.obj` + `.mtl` | Multi-group 3D prop meshes. `WallClock.obj` has separate `HourHand`, `MinuteHand`, and `SecondHand` groups centered at `(0,0,0)` for Z-axis rotation; `LabBeaker.obj` has separate `GlassBody`, `GreenLiquid`, and `Crack_1..5` sub-meshes. |
| `assets/faces/generated_pngs/` | `88` high-res `512×512` PNGs across `Hero`, `LittleHero`, `Mia`, `Jace`, `Teacher`, `Grandma`, and `Extra1..6` (`*_decal.png` transparent + `*_head.png` skin-baked) | Every face has **3-layer eyes** (white sclera + iris/pupil + **2 bright white specular catchlight dots**) and exact hex-locked skin tones (`skin_tones.json`). |
| `assets/rigs/` & `engines/` | • `assets/rigs/build_all_riggable_characters.luau`<br>• `engines/roblox/story007_cutscene.luau` (**v3 Patched**)<br>• `engines/roblox/sets/grandma_room.luau`<br>• `engines/blender/import_and_rig_meshes_blender.py` | One-click Luau and Blender Python scripts that build, rig, pose, swap faces, weld props to hands, and animate every character and prop. |

---

## 2. Step-by-Step Instructions: How to Use & Rig the 3D Meshes (`.obj`)

### Option A: Using the Riggable Characters & Props in Roblox Studio (Fastest — Zero Manual Import Needed)
1. **Automatic Luau Rigging (`assets/rigs/build_all_riggable_characters.luau`)**:
   - In Roblox Studio (or via Claude Code `execute_luau`), run `assets/rigs/build_all_riggable_characters.luau`.
   - It automatically builds/upgrades `Hero`, `LittleHero`, `Mia`, `Jace`, `Teacher`, `Grandma`, and `Extra1..6` in `Workspace` with:
     - Full R15 `Motor6D` / `AnimationConstraint` joints driven per-frame by `P(rig, "RightUpperArm", pitch, yaw, roll)` in `story007_cutscene.luau`.
     - **3-Layer Expressive 2D Faces** (`Studio2DFaceGui` with white sclera + dual white catchlights on `Extra1..6`, and `ServerStorage.ApprovedFaces` head-swaps on the main cast).
     - **Flush Dorsal Age Veins (`S7AgeVein`)** welded inside the hand contour (`0.032-stud` cylinders) so `setAge(rig, 0..1)` fades in realistic dark veins without overhanging brown boxes.
2. **Importing Custom `.obj` Meshes into Roblox Studio (`Asset Manager` / `Import 3D`)**:
   - Open Roblox Studio → **View → Asset Manager → Bulk Import** (or **Avatar → Import 3D**).
   - Select any `.obj` file in `assets/meshes/characters/` (e.g., `Hero_R15_Riggable.obj`) or `assets/meshes/props/` (e.g., `AcidBottle.obj`, `LabBeaker.obj`, `WallClock.obj`).
   - Check **"Insert with location"** and **"Keep sub-meshes separate"**. Each named group (`Head`, `UpperTorso`, `LeftHand`, `HourHand`, `MinuteHand`, etc.) imports as an individual `MeshPart` inside a `Model`.
   - To swap a face decal on any `Head` MeshPart in Studio, drop a `Decal` (`Face = Front`) onto `Head` and assign any `*_decal.png` from `assets/faces/generated_pngs/<Character>/`.
3. **Customizing / Changing Characters for Future Stories (`Story 008+`)**:
   - Open `assets/rigs/build_all_riggable_characters.luau` and edit the `CAST_CONFIG` table at the top:
     ```lua
     Hero = {
         skin = rgb(232, 207, 168),
         shirt = 382537702,        -- change catalog Shirt ID
         pants = 382537569,        -- change catalog Pants ID
         hair = "62234425",        -- change catalog HairAccessory ID
         scale = 1.00,             -- 0.62 for kid, 1.0 for teen, 1.08 for adult
         shirtCol = rgb(30, 86, 160),
         pantsCol = rgb(29, 36, 50),
         browCol = rgb(74, 46, 27),
         glasses = nil             -- nil | "round" | "rect"
     }
     ```

### Option B: Using the Riggable `.obj` Meshes in Blender 4.x (`engines/blender/import_and_rig_meshes_blender.py`)
1. Run our Blender auto-rigger from PowerShell or Python:
   ```powershell
   blender -b -P engines/blender/import_and_rig_meshes_blender.py
   ```
2. Inside any Blender Python cutscene script, call:
   ```python
   from import_and_rig_meshes_blender import import_and_rig_character, import_prop, pose_bone_deg, set_character_face_png

   hero_rig = import_and_rig_character("Hero", emotion="Determined", location=(-2.0, 0.0, 0.0))
   mia_rig  = import_and_rig_character("Mia",  emotion="Shocked",    location=(1.5, 0.0, 0.0))
   beaker   = import_prop("LabBeaker", location=(0.0, -1.2, 1.1))

   # Pose any R15 bone in degrees (X=pitch, Y=yaw, Z=roll):
   pose_bone_deg(hero_rig, "LeftUpperArm", rx=40, ry=-20, rz=0)
   pose_bone_deg(hero_rig, "LeftLowerArm", rx=75, ry=0,   rz=0)

   # Swap facial expression on any frame:
   set_character_face_png(mia_rig, "Mia", "Happy")
   ```

---

## 3. Copy-Paste Master Prompt to Give Claude Code for Part 1 & Part 2 Production

Copy and paste the prompt block below directly into **Claude Code** inside your `C:\AI-Vid` directory after extracting `Roblox_Story007_Complete_Riggable_Assets_And_Claude_Kit.zip`:

```text
You are the Lead Showrunner and Technical Director for C:\AI-Vid.
I have just extracted the v3 Complete Riggable Character, Prop & Engine Kit into this repo.

Read these files first before running any command:
1. CLAUDE_3D_MESH_AND_PRODUCTION_GUIDE.md
2. reference/design_bible/ (inspect all 5 visual design bible JPGs: 01 through 05)
3. assets/rigs/build_all_riggable_characters.luau
4. engines/roblox/sets/grandma_room.luau
5. engines/roblox/story007_cutscene.luau
6. pipeline/voice_subs.py, pipeline/make_sfx.py, pipeline/record_take.py, pipeline/finish_video.py, pipeline/qa_sheet.py

Execute the complete v3 production and verification pipeline for Story 007 ("Wrist Rewind" Part 1 and Part 2) in this exact order:

STEP 1 — Voice, Script-Locked Subtitles & SFX (Run in parallel with Studio prep):
- Run `python -I pipeline/voice_subs.py --story-dir stories/007_wrist-rewind/p1 --subs-only` (or full voice generation if voice.mp3 is missing) and repeat for `p2`.
- Run `python -I pipeline/test_voice_subs.py` and verify it prints `ok` (zero dangling prepositions, zero homophone typos, zero 1-word 'LEFT' flashes).
- Run `python -I pipeline/make_sfx.py` so all 12 WAV SFX exist in `assets/sfx/`.

STEP 2 — Roblox Studio Scene, Set, Rigs & v3 Cutscene Engine (Run ONE Studio MCP job at a time):
- Execute `engines/roblox/roblox_look.luau` via `execute_luau` (and confirm `settings().Rendering.EditQualityLevel = Enum.QualityLevel.Level21` so Depth of Field blurs background bystanders).
- Execute `engines/roblox/sets/grandma_room.luau` via `execute_luau` and confirm `workspace.Set_GrandmaRoom.Shelf` exists (dusty-rose walls, red rug, bookshelf — NEVER the old empty beige room).
- Execute `assets/rigs/build_all_riggable_characters.luau` via `execute_luau` so `Hero`, `LittleHero`, `Mia`, `Jace`, `Teacher`, `Grandma`, and `Extra1..6` have flush dorsal age veins (`S7AgeVein`, NEVER overhanging brown boxes) and `Extra1..6` have 3-layer expressive 2D faces (`Studio2DFaceGui`, NEVER default `: ` smileys).
- Load `engines/roblox/story007_cutscene.luau` and run `_G.Story007.test()`. Verify that:
  (a) `PR.Phone` is welded to `Jace.LeftHand` (`PhoneHandWeld`) so it never detaches to his waist at P1 29.2s,
  (b) `clearShot()` uses `WS:Spherecast(p, 0.52, ...)` so zero bottles block Jace at P2 17.2s or Mia at P2 39.8s,
  (c) `PR.Ripple` is a thin 0.05-stud neon cylinder ring (not an opaque ball hiding the hand), and
  (d) `PR.Cup` has a white rim and sits outside `EX[2]`'s hand (`CF(0, -0.68, -0.58)`).

STEP 3 — Foreground 30-FPS Capture & Final Muxing (Part 1 & Part 2):
- Record Part 1 and Part 2 using `pipeline/record_take.py` with Roblox Studio in the foreground and cursor parked at `(900, 12)`.
- Mux the final deliverables directly into the root story folder so the old v1 files are replaced:
  `python -I pipeline/finish_video.py --raw stories/007_wrist-rewind/rec/v3/p1_trim.mp4 --part-dir stories/007_wrist-rewind/p1 --out stories/007_wrist-rewind/007_wrist-rewind_part1.mp4 --beats stories/007_wrist-rewind/beats_p1.json --end 50.05`
  `python -I pipeline/finish_video.py --raw stories/007_wrist-rewind/rec/v3/p2_trim.mp4 --part-dir stories/007_wrist-rewind/p2 --out stories/007_wrist-rewind/007_wrist-rewind_part2.mp4 --beats stories/007_wrist-rewind/beats_p2.json --end 51.55`

STEP 4 — Mandatory 28-Beat Visual QA Gate:
- Run `pipeline/qa_sheet.py` on both final MP4s (`qa_v3_p1.png` and `qa_v3_p2.png`) and inspect every single tile against `reference/design_bible/05_Visual_QA_DO_vs_DONT_Rules_Board.jpg`. Confirm zero floating brown boxes on hands, zero detached phones, zero bottle occlusions, and a bright final frame on both parts.
```
