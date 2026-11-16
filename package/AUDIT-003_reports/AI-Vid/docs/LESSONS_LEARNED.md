# Lessons Learned (story 007 production, Nov 2026). READ BEFORE PRODUCING

Every rule here came from a real failure. Any AI working in this repo follows them.

## Story & script
- Natural Edge-TTS speech is ~180 words/min, so use **150–175 words per ≤60s part**. Never speed the voice up; split into a series instead.
- Every story needs a clear, earned meaning and a complete ending (series OK; the last part resolves everything). The engagement gate includes a meaning/completeness pass/fail.
- Write the whole series before production.

## Characters & faces (user taste, locked)
- Main characters: Studio `generate_avatar` (`pipelineName "npc"`). Bystanders: dressed `HumanoidDescription` (never colour-only bodies). **Never Blender characters.**
- Faces: ONE art style for the whole series, the AI "v1" style (`assets/faces/STYLE.md`): semi-realistic cartoon, bold lines, soft shading. Not stock smileys, not human-realistic (dynamic FaceControls looked creepy). Don't mix with catalog decals.
- Make only the emotions the beats use: 2 takes each, 4 `generate_texture` jobs in parallel max, pick the cleanest.
- **Skin tone must be identical per character** (`assets/faces/skin_tones.json`). The prompt hex alone drifts, so compare each head against the body and reject drifters.
- Face swap = hide `Head` (Transparency 1) and weld the approved head clone. Swapping only TextureID fails (the mesh differs).
- Grey/untextured characters = textures failed to load (HTTP 503). Refresh every SurfaceAppearance map (set it to "" and back) after every Studio restart, before recording.

## Sets (must look like a real Roblox game)
- AI-generated sets often come in **10 studs under the baseplate**: raise them so the bottom is at y≈0.05.
- Audit every set for **missing walls, ceilings, gaps and doors to nowhere**, and look out of the windows (no grey grid: lawn plus blocky trees).
- Realistic AI meshes (e.g. the old grandma room) get rebuilt from classic Parts.
- Material/texture clean-ups strip chalkboard and sign text, so re-add the text as SurfaceGuis.
- SurfaceGui text: use `SizingMode = FixedSize` with a CanvasSize (PixelsPerStud didn't render), and pick the Face whose world normal points at the room (generated parts are rotated). `screen_capture` may not show SurfaceGuis, so verify in the real viewport via a gdigrab frame.
- Benches must suit 6-stud kids: countertop ≈ waist height (~3.6). Raycasts for surfaces must start **below the ceiling**.
- Builder scripts must be idempotent and contain every fix (e.g. the grandma ceiling), because re-running a builder wipes manual edits.

## Cutscene code
- Edit mode: no Animator. Drive AnimationConstraint attachments per frame. Load big Luau files through the localhost HTTP plus ModuleScript loader (`_G.loadEngine`).
- `Lighting.Technology` can't be set from plugin scripts (wrap it in pcall).
- **Shot rules** (from QA, 13/27 shots failed at first):
  - No macro closer than ~2.5–3 studs from hands/props; FOV 38–45 for inserts. Hand shots show hand + sleeve/face context.
  - Never put the camera inside geometry or outside a room; stay ≥1 stud from walls/ceilings, and above bench tops on bench shots.
  - Never put glass or props in front of a face.
  - Faces fill 25–35% of the frame height on emotional beats, with an expression on every emotional line.
  - Idle motion on every character, a pose change on each cut, eased camera moves, a slow push-in, subtle handheld drift.
  - Cuts every 1.2–2s (3s max). Strongest image in the first 1.5s.
  - Tap/VFX grade spikes must stay subtle (they blew the hook to white).
  - Keep the subject in the central 85% of the 9:16 frame and out of the bottom 18% (subtitles) and the right edge (platform UI).

## Recording (the hardest-won lessons)
- **Bring Studio to the FOREGROUND during takes** (`WScript.Shell.AppActivate`). In the background Windows throttles Studio to ~15–20 rendered fps, which gave 47% repeated frames (judder). In the foreground: 0%.
- Record a **locked 30fps** (the reference shorts are 30fps): `gdigrab -framerate 30 -draw_mouse 0`, recording the viewport region only.
- Vertical trick: roll the camera +90°, record the landscape viewport, then `transpose=2`. Native width = viewport HEIGHT, so trim Studio's chrome (collapse the ribbon, close the command bar, collapse the side panels) to get ≥968 px. Then centre-crop to 9:16 and scale to 1080x1920.
- Park the mouse cursor before each take in the EMPTY MENU-BAR area at the top of the Studio window (e.g. screen x≈900, y≈12, right of "Help"), outside the 3D viewport so it causes no hover outlines. NEVER the bottom/corner: it pops up the Windows taskbar.
- Nobody touches Studio during a take (that caused freezes). Clear the Selection first (outlines show up in the video).
- **Accept a take only if:** near-identical consecutive frames <2% (tblend+signalstats), no freeze except the intended end hold, and every beat frame passes the visual check.
- Finish with `pipeline/finish_video.py` (rotate, crop, scale, shift subs by the lead-in, mux voice).

## QA loop (works)
- Dry run, then one true-9:16 frame per beat as a contact sheet, then Sonnet render-qa fixes the cameras, then re-run. Repeat until every beat passes. Compare against a downloaded reference (`reference/ref_pack/`) before calling it done.

## Delivery (from the external QA audit, verified)
- **Never end on black.** Cut at the last spoken word (+~0.3s) on the final image: `finish_video.py --end <s>`. Black tails make viewers swipe before the loop.
- **Script-locked subtitles.** Whisper mishears homophones/numbers ("FOR TAPS" vs "FOUR TAPS"). `voice_subs.py` passes the script as `initial_prompt` and `script_lock()` takes each word's spelling from the script when word counts match. Check numbers in the subs before publishing.
- Audio is normalised in `finish_video.py` (loudnorm, ≈-16 LUFS measured).
- Verify every external QA claim against the EXACT timestamp it cites, never against a coarse sheet. We once dismissed the "Hero's arm across Mia's neck at P2 0:38.5" claim because the 10-frame sheet skipped that shot. It was real.
- **Sound design is mandatory.** Every beat's `sfx` in beats_*.json gets mixed. Generate the library with `python pipeline/make_sfx.py` (assets/sfx/*.wav), then pass `--beats beats_pN.json` to `finish_video.py`. Each cue is snapped to the moment its line is actually spoken. A dry TTS-only track is a fail.

## External audit AUDIT-001 fixes (story 007 v2, now the defaults)
- **Bystanders:** dressed `HumanoidDescription` rigs from `assets/rigs/bystanders_school.luau`, built from free Roblox catalog items found via `AvatarEditorService:SearchCatalog` with MaxPrice 0. **Never clone main characters as extras** (the result was a "clone classroom").
- **Occlusion guard:** `clearShot()` in the cutscene raycasts from the camera to the face AND the chest. If a prop, another character, or a small set piece blocks either line, it moves the camera up or sideways. Props must have `CanQuery = true` for this to work.
- On faceCam beats, never turn the subject's back to the camera; cap the turn at about 40°. Keep at least 3 studs between two characters in the same shot, and put the camera on the subject's far side from the other person.
- **Flash/VFX limits:** ColorCorrection brightness +0.04 at most, bloom +0.12, flash PointLight brightness 2.5 with range 8. Stacking all three blew Jace's face out to white.
- **Prop contrast:** a white prop never goes against white (the milk now goes in a red cup). Shards use Neon/glint, not grey SmoothPlastic.
- **Aging must be visible:** add dark crease bands on the hands that fade in with age, not just a skin tint.
- **Part 1 endings:** stay on the person in danger, using a split-depth shot (hand/trigger in the foreground, victim behind). No fade, no black hold; hard cut on the last image. Only the series finale may fade.
- **Captions:** `script_lock` aligns the script to Whisper with difflib, so a word-count mismatch still fixes homophones. A card never ends on to/for/his/the/a/and; that word moves to the next card. Use `voice_subs.py --subs-only` to rebuild captions without re-recording the TTS.
- **QA sheet:** `pipeline/qa_sheet.py` puts one frame at the midpoint of every beat, plus an END frame. Uniform 4/10-frame sheets are banned.
- **Recording:** `pipeline/record_take.py` brings Studio to the foreground, parks the cursor and records with gdigrab. Black the grade first, then use `--trim` to cut at the first non-black frame.
