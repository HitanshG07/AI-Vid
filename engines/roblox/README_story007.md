# Story 007 "Wrist Rewind" in Roblox Studio (Edit mode)
1. Look: run `engines/roblox/roblox_look.luau` once via execute_luau (Future lighting, sky, Atmosphere, Bloom, `Grade`, `DOF`).
2. Grandma room: run `engines/roblox/sets/grandma_room.luau` (destroys `Set_GrandmaRoom`, rebuilds it from classic Parts).
3. Cutscene: run `engines/roblox/story007_cutscene.luau`, then `_G.Story007.test()`. If LeftHand moved < 1 stud, run `_G.Story007.setMode("transform")` and test again.
4. Record: start the screen recorder, then `task.spawn(_G.Story007.play, 1)` (49.7s voice + 0.3s lead + 0.4s tail). Same for part 2 (51.6s).
5. Between takes: `_G.Story007.reset()`. The first run creates LittleHero, Extra1..6 and the `Story007Props` folder.
6. Frames are rolled +90 deg: rotate the recording -90 deg (or 90 deg clockwise) to get 9:16.
- Limits: joint axes are guessed (+X pitch = forward). Gestures may need sign/angle tweaks in `arm()`/`tapPose()`.
- Bench height is detected by raycast. If it is above WAIST (3.6), grey risers are added and the kids stand on them.
- Faces only change where ServerStorage.ApprovedFaces has that head. Others stay neutral. Extras are recoloured clones and always neutral.
- Hand ageing tints SurfaceAppearance.Color. Sleeves can't stretch, so "pulls sleeves over hands" tucks the hands down instead.
