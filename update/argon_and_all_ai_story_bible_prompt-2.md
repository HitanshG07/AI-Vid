# Exact Reply to Paste into Claude Code (Rebuild Both Part 1 & Part 2 Using All Given Assets + Record Now)

Copy and paste the block below directly into **Claude Code** as your reply:

```text
Do NOT leave the current story un-recorded or on the old v2 cutscene script. I am explicitly authorizing you to REBUILD AND RECORD the entire story (both Part 1 and Part 2) right now using all of our given assets (`REUSE_LIBRARY/props/`, `REUSE_LIBRARY/faces/`, `assets/rigs/build_all_riggable_characters.luau`, and `engines/roblox/sets/grandma_room.luau`) and replace the root final MP4s.

Execute these exact steps in order:

1. WRITE THE WORKED MANIFEST (`stories/007_wrist-rewind/MANIFEST.md`):
   - Fill out `stories/007_wrist-rewind/MANIFEST.md` completely (Sections A through H of `production_manifest_template.md`) so Story 007 serves as the complete worked reference manifest noted in your template header.

2. APPLY ALL GIVEN ASSETS & V3 FIXES INTO ROBLOX STUDIO AND `engines/roblox/story007_cutscene.luau`:
   - Do NOT keep the old v2 `story007_cutscene.luau` defects. Merge the kit's v3 engine fixes into `engines/roblox/story007_cutscene.luau` (keeping your 30 fps capture rule and pure Roblox Studio character rule):
     a) **Characters & Faces (`REUSE_LIBRARY/faces/` + `build_all_riggable_characters.luau`)**: Apply the 3-layer eye faces (white sclera + iris/pupil + 2 white catchlights) to `Extra1..6` and the main cast so zero bystanders use the plain default `:|` face.
     b) **Hand Aging (`DorsalAgeVeins_Overlay` / `S7AgeVein`)**: Remove the overhanging `hp.Size * 1.06` rectangular brown slabs in `ageRig()`. Replace them with the 3 flush `0.032`-stud dorsal vein cylinders (`Size = Vector3.new(0.28, 0.032, 0.032)` at `CF((k-2)*0.075, 0.02, -0.14)`) tucked inside the back of `LeftHand` and `RightHand` so nothing hovers outside the hand in `08_after_aged_hands.png` or `END`.
     c) **Welded Held Props (`Smartphone`, `CafeteriaMilkCup`, `YellowPencil`)**: Weld `PR.Phone` (`Anchored = false, Massless = true, CanQuery = false`) directly to `Jace.LeftHand` using a `WeldConstraint` (`PhoneHandWeld`) instead of calling `PR.Phone:PivotTo(partCF(Ja, "LeftHand") * PHONE_OFF)` after `Ja.m:PivotTo(...)`, so the phone never detaches to his waist at P1 29.2s.
     d) **Milk Cup Outside Hand (`CafeteriaMilkCup`)**: Add the white rim (`Rim`) to `PR.Cup`, enlarge to `h=0.85, d=0.58`, and offset `F.milk` to `partCF(EX[2], "RightHand") * CF(0, -0.68, -0.58)` so the cup sits clearly outside `EX[2]`'s blocky hand instead of being swallowed inside the arm at P1 8.5s.
     e) **Thin Ring Ripple & Needle Glass Shards (`WristRewindRing` & `GlassShard_Needle`)**: Change `PR.Ripple` from an opaque `1.6`-stud `Ball` to a thin `0.05`-stud `Cylinder` ring (`Size = Vector3.new(0.05, d, d)`, `Transparency = lerp(0.55, 1, k)`) with smaller `0.14` particles so wrist taps are never hidden inside a blue snowball. Make all 12 `SH[i]` shards elongated needle wedges (`Size = Vector3.new(0.05, 0.07, 0.45)`, alternating `Neon` and `Glass`).
     f) **SphereCast Occlusion Guard (`clearShot`)**: Upgrade `WS:Raycast` inside `clearShot()` to `WS:Spherecast(p, 0.52, (aim - p) * 0.92, prm)` so off-center bench bottles/beakers at P1 12.5s (`B6`), P1 29.2s (`B15`), P2 8.0s (`B6`), P2 17.2s (`B11`), and P2 39.8s (`B22` Mia smile shot) are detected and cleared.
     g) **Grandma's Room & Studio DOF (`grandma_room.luau` + `EditQualityLevel`)**: Execute `engines/roblox/sets/grandma_room.luau` in Studio before recording so `Set_GrandmaRoom` has the dusty-rose walls, wainscot, red rug, and bookshelf (verify `workspace.Set_GrandmaRoom.Shelf` exists), tint Grandma's cardigan plum-lavender (`rgb(142, 99, 141)`), cap `PR.Fill` brightness at `0.8`, and run `settings().Rendering.EditQualityLevel = Enum.QualityLevel.Level21` so `DepthOfFieldEffect` blurs background extras.
     h) **Bright Part 2 Finale (`B2[28]`)**: Do not dim `grade.Brightness` to `-1` during the final spoken line (`50.14s–51.55s`); keep the final frame (`"They were saved for her."`) warm and bright.

3. RECORD, MUX & REPLACE THE PUBLISHED FINALS (BOTH PART 1 AND PART 2):
   - You have explicit permission to **record** now.
   - Bring Roblox Studio to the foreground, park the cursor at `(900, 12)`, and record both Part 1 and Part 2 at locked 30 fps via `pipeline/record_take.py`.
   - Run `pipeline/finish_video.py` with `--beats beats_p1.json` (`--end 50.05`) and `--beats beats_p2.json` (`--end 51.55`) and write the outputs directly to:
     • `stories/007_wrist-rewind/007_wrist-rewind_part1.mp4`
     • `stories/007_wrist-rewind/007_wrist-rewind_part2.mp4`
     (replacing the old v1 root MP4s).

4. RUN THE 28-BEAT QA SHEET & PACKAGE `AUDIT-004`:
   - Generate the new beat sheets (`pipeline/qa_sheet.py`) for both replaced root finals (`rec/v3/qa_p1.png` and `rec/v3/qa_p2.png`).
   - Verify every tile against `reference/design_bible/05_Visual_QA_DO_vs_DONT_Rules_Board.jpg` (zero brown hand-boxes, zero detached phones, zero bottle occlusions on Jace or Mia, rebuilt Grandma room visible, blurred background extras, and bright endings).
   - Package the replaced finals, `MANIFEST.md`, updated code, and v3 QA beat sheets into `audits/AUDIT-004_2026-11-16_story007-v3_part*.zip`.
```