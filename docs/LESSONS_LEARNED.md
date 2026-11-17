# Lessons Learned (story 007 production, Nov 2026). READ BEFORE PRODUCING

Every rule here came from a real failure. Any AI working in this repo follows them.

## Story & script
- Natural Edge-TTS speech is ~180 words/min, so use **150–175 words per ≤60s part**. Never speed the voice up; split into a series instead.
- Every story needs a clear, earned meaning and a complete ending (series OK; the last part resolves everything). The engagement gate includes a meaning/completeness pass/fail.
- Write the whole series before production.

## Characters & faces: LOCKED METHOD (2026-11-17, owner-approved after a side-by-side test in Studio)
Classic R6 + real catalog clothing/hair + our own flat 2D decal faces. Full method: AGENTS.md "Asset process". This SUPERSEDES the "user taste, locked" block below.
- **Findings:**
  1. R15 default rigs ignore decal faces (dynamic head), so use R6.
  2. Free Creator Store face decals are mostly unusable (opaque white or fake checkerboard backgrounds). Draw our own: `engines/faces/classic_faces.py` -> `assets/faces/classic_v1/` (`ids.json` has the uploaded ids). New emotions go into that script.
  3. Anchor ONLY `HumanoidRootPart`. Anchoring accessory handles detaches the hair.
  4. Floor-snap by the lowest body part, not the bounding box (accessories skew it).
  5. A Creator Store Decal asset id is not its image id. Resolve with `game:GetObjects("rbxassetid://<id>")[1].Texture`.
  6. Catalog Face items are not searchable via `SearchCatalog`.
- **Clothing/hair** come from `AvatarEditorService:SearchCatalog` (Relevance sort), 0 Robux because Studio renders them unowned. Pick detailed classic Shirts/Pants and layered hair that read like the reference shorts. Never bare default bodies.
- **Per-story cast builder:** `engines/roblox/cast_<ID>.luau` (see `cast_011.luau`): `build(name, x, floorY, z, yaw, parent)` and `setFace(model, emotion)`.
- **Argon/Gemini no longer builds characters, props or sets**; every Argon/mesh/`generate_avatar`/Blender character attempt failed the owner's standard. Sets use Roblox-native Parts, Terrain and free Creator Store models (inspect for scripts, log source).
- **After EVERY recording take, reset the Studio camera** (roll 0, FOV 70, by swapping in a FRESH editor camera (free right-mouse look; changing CameraType alone can leave it locked)) before doing anything else.

## Characters & faces (user taste, locked): SUPERSEDED 2026-11-17 by the locked method above (kept as history; skin-tone identity still applies)
- Main characters: Studio `generate_avatar` (`pipelineName "npc"`). Bystanders: dressed `HumanoidDescription` (never colour-only bodies). **Never Blender characters.**
- Faces: ONE art style for the whole series, the AI "v1" style (`assets/faces/STYLE.md`): semi-realistic cartoon, bold lines, soft shading. Not stock smileys, not human-realistic (dynamic FaceControls looked creepy). Don't mix with catalog decals.
- Make only the emotions the beats use: 2 takes each, 4 `generate_texture` jobs in parallel max, pick the cleanest.
- **Skin tone must be identical per character** (`assets/faces/skin_tones.json`). The prompt hex alone drifts, so compare each head against the body and reject drifters.
- Face swap = hide `Head` (Transparency 1) and weld the approved head clone. Swapping only TextureID fails (the mesh differs).
- Grey/untextured characters = textures failed to load (HTTP 503). Refresh every SurfaceAppearance map (set it to "" and back) after every Studio restart, before recording.

## Sets (must look like a real Roblox game)
- (2026-11-17: sets are now built from native Parts/Terrain/Creator Store models; the AI-generated-set notes below are history, the audit rules still apply.)
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
- **Accept a take only if:** near-identical consecutive frames <2% (tblend+signalstats), no freeze except the intended end hold, and every beat frame passes the visual check. Measure on the **trimmed 30 fps take** (`rec/pN.mp4`), not the final: any fps upsampling in finishing duplicates frames by design. Command:
  `ffmpeg -i rec/pN.mp4 -vf "tblend=all_mode=difference,signalstats,metadata=print:key=lavfi.signalstats.YAVG:file=rec/pN_yavg.txt" -f null -` then count frames with YAVG < 0.5 (starting threshold; calibrate once on the accepted story 007 take). Paste the ratio into the QA note.
- **R6 catalog rigs pivot on the HEAD** (`CreateHumanoidModelFromDescription` sets PrimaryPart = Head). Any tilt (swimming, lying, falling) rotates the body around the head: place the head where it must be (swim: just above the water, yaw flipped 180°, pitch +100°; chest-deep float: head 1.15×scale above water). Tilting "forward" with a negative pitch flips the body legs-up.
- **Water must be deep and fairly opaque for swim shots:** a gentle sand slope leaves inches of water near shore (swimmers lie on sand), and WaterTransparency 0.6 shows submerged limbs as if on top. Use a steep shore (≥4 studs deep within 1–2 studs of the waterline; `Terrain:ReplaceMaterial` Sand→Water) and WaterTransparency ≈ 0.12.
- **White-hair flash at a cut-in = unloaded texture.** Characters not drawn for a while lose their (legacy SpecialMesh) hair/clothing textures and render white for ~0.4 s when they cut into a close-up. Fix that works: run `engines/roblox/texture_keepers.luau` right before every take — tiny copies of the cast drawn in a 3×3-px ViewportFrame at the far-left viewport edge (removed by the 9:16 crop). Opaque 3D copies at the frame edge showed in the video; 97%-transparent copies did not keep textures loaded. (Rosa's 16.8 s flash in story 011 persisted with keepers and with a different hair item — a separate, still-unknown cause.)
- **Bright glowing VFX discs read as a blown-out sun** (story 011's bell shockwave ring). Keep VFX thin/translucent or drop them.
- Takes are deterministic and word-synced: fixing one shot can be done by **splicing the same seconds from another take on exact shot cuts** (`ffmpeg ... select='gt(scene,0.25)'` to find the cut frames) — check the cast looks identical in both takes.
- **Real R6 animations work in Edit mode**: `Animator:LoadAnimation` + `track:Play()` + `animator:StepAnimations(dt)` every frame (walk 180426354, idle 180435571). Use them for walk/run/idle; procedural limb swings looked stiff (owner, take 1 of story 011).
- `record_take.py` locks the mouse at the top menu bar (ClipCursor 1×1 px at 900,12) for the whole take and always releases it afterwards, so the cursor can never drift into the viewport (owner rule 2026-11-17).
- Roblox's own Video Captures feature is beta and records only ~30 s (Creator Hub, 2026-11), so gdigrab stays the capture route.
- Finish with `pipeline/finish_video.py` (rotate, crop, scale, shift subs by the lead-in, mux voice).

## QA loop (works)
- Dry run, then one true-9:16 frame per beat as a contact sheet, then Sonnet render-qa fixes the cameras, then re-run. Repeat until every beat passes. Compare against a downloaded reference (`reference/ref_pack/`) before calling it done.

## Delivery (from the external QA audit, verified)
- **Never end on black.** Cut at the last spoken word (+~0.3s) on the final image: `finish_video.py --end <s>`. Black tails make viewers swipe before the loop.
- **Script-locked subtitles.** Whisper mishears homophones/numbers ("FOR TAPS" vs "FOUR TAPS"). `voice_subs.py` passes the script as `initial_prompt` and `script_lock()` takes each word's spelling from the script when word counts match. Check numbers in the subs before publishing.
- Audio is normalised in `finish_video.py` (`loudnorm=I=-14:TP=-1.5`; an earlier note said ≈-16, the code is the truth).
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
