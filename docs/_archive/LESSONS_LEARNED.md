# Lessons Learned (early productions, Nov 2026). READ BEFORE PRODUCING

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
- **Per-story cast builder:** `engines/roblox/cast_<ID>.luau` (see `cast_001.luau`): `build(name, x, floorY, z, yaw, parent)` and `setFace(model, emotion)`.
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
  `ffmpeg -i rec/pN.mp4 -vf "tblend=all_mode=difference,signalstats,metadata=print:key=lavfi.signalstats.YAVG:file=rec/pN_yavg.txt" -f null -` then count frames with YAVG < 0.5 (starting threshold; calibrate once on an accepted take). Paste the ratio into the QA note.
- **R6 catalog rigs pivot on the HEAD** (`CreateHumanoidModelFromDescription` sets PrimaryPart = Head). Any tilt (swimming, lying, falling) rotates the body around the head: place the head where it must be (swim: just above the water, yaw flipped 180°, pitch +100°; chest-deep float: head 1.15×scale above water). Tilting "forward" with a negative pitch flips the body legs-up.
- **Water must be deep and fairly opaque for swim shots:** a gentle sand slope leaves inches of water near shore (swimmers lie on sand), and WaterTransparency 0.6 shows submerged limbs as if on top. Use a steep shore (≥4 studs deep within 1–2 studs of the waterline; `Terrain:ReplaceMaterial` Sand→Water) and WaterTransparency ≈ 0.12.
- **White-hair flash at a cut-in = unloaded texture.** Characters not drawn for a while lose their (legacy SpecialMesh) hair/clothing textures and render white for ~0.4 s when they cut into a close-up. Fix that works: run `engines/roblox/texture_keepers.luau` right before every take — tiny copies of the cast drawn in a 3×3-px ViewportFrame at the far-left viewport edge (removed by the 9:16 crop). Opaque 3D copies at the frame edge showed in the video; 97%-transparent copies did not keep textures loaded. (Rosa's 16.8 s flash in story 001 persisted with keepers and with a different hair item — a separate, still-unknown cause.)
- **Bright glowing VFX discs read as a blown-out sun** (story 001's bell shockwave ring). Keep VFX thin/translucent or drop them.
- Takes are deterministic and word-synced: fixing one shot can be done by **splicing the same seconds from another take on exact shot cuts** (`ffmpeg ... select='gt(scene,0.25)'` to find the cut frames) — check the cast looks identical in both takes.
- **Real R6 animations work in Edit mode**: `Animator:LoadAnimation` + `track:Play()` + `animator:StepAnimations(dt)` every frame (walk 180426354, idle 180435571). Use them for walk/run/idle; procedural limb swings looked stiff (owner, take 1 of story 001).
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

## External audit AUDIT-001 fixes (early story v2, now the defaults)
- **Bystanders:** dressed `HumanoidDescription` rigs built by the story's cast builder (pattern: `engines/roblox/cast_001.luau`), using free Roblox catalog items found via `AvatarEditorService:SearchCatalog` with MaxPrice 0. **Never clone main characters as extras** (the result was a "clone classroom").
- **Occlusion guard:** `clearShot()` in the cutscene raycasts from the camera to the face AND the chest. If a prop, another character, or a small set piece blocks either line, it moves the camera up or sideways. Props must have `CanQuery = true` for this to work.
- On faceCam beats, never turn the subject's back to the camera; cap the turn at about 40°. Keep at least 3 studs between two characters in the same shot, and put the camera on the subject's far side from the other person.
- **Flash/VFX limits:** ColorCorrection brightness +0.04 at most, bloom +0.12, flash PointLight brightness 2.5 with range 8. Stacking all three blew Jace's face out to white.
- **Prop contrast:** a white prop never goes against white (the milk now goes in a red cup). Shards use Neon/glint, not grey SmoothPlastic.
- **Aging must be visible:** add dark crease bands on the hands that fade in with age, not just a skin tint.
- **Part 1 endings:** stay on the person in danger, using a split-depth shot (hand/trigger in the foreground, victim behind). No fade, no black hold; hard cut on the last image. Only the series finale may fade.
- **Captions:** `script_lock` aligns the script to Whisper with difflib, so a word-count mismatch still fixes homophones. A card never ends on to/for/his/the/a/and; that word moves to the next card. Use `voice_subs.py --subs-only` to rebuild captions without re-recording the TTS.
- **QA sheet:** `pipeline/qa_sheet.py` puts one frame at the midpoint of every beat, plus an END frame. Uniform 4/10-frame sheets are banned.
- **Recording:** `pipeline/record_take.py` brings Studio to the foreground, parks the cursor and records with gdigrab. Black the grade first, then use `--trim` to cut at the first non-black frame.

## Static, messy takes (2026-11-19)
Another AI rewrote the cutscene engine instead of reusing 001. It never reset `loco` each frame, so rigs stayed stuck in walk/idle state, and it framed shots as wall-clipping, tilted giant-face close-ups. Rule: start from the approved engine and show bodies acting.

## Voice pace (measured 2026-11-19, story 002)
viral_storyteller (ChristopherNeural +18%) measured 184 WPM after pause compression, not the 230 the audit claimed: 203 words ran 66.7 s. Rule is now ~165–180 words per 60 s part. Always check voice.mp3 duration before Studio work.

## Cast test builds (2026-11-19, story 002)
- In a quick lineup test, anchor ONLY HumanoidRootPart before parenting; anchoring every part first stops accessories (hair) attaching.
- Check every catalog item visually: a "womens winter coat" result rendered as a bare-midriff crop top. Avoid duplicate hair across extras and same-colour outfits next to the hero.
- Short punchy sentences add pauses: 176 words still ran 62.2 s at +18%. Fix by raising the rate (story 002 used --rate +24%, 59.7 s) before cutting more words; record the rate in script.md.

## Story 002 Studio previews (2026-11-19)
- Studio MCP can run `loadstring`: store the cutscene text in a StringValue (ServerStorage.S13Src) and patch it with plain-text replaces, so one fix does not need a 77 KB resend.
- preview(n) must step the R6 tracks (S.dt > 0, ~12 steps) or every rig renders as a T-pose; place() must also reset Motor6D C0 or a leftover gesture leaves a rig lying flat after a mark change.
- Old story DOF/Atmosphere left in Lighting white out the whole frame; disable them before previews. Stacked bloom + white-hot print lights wash the street to white (cap C prints at br 1.2 / range 6, whitehot bloom 0.9).
- Cameras written for ground-level close-ups put the lens inside porches, vans and Striders; frame bodies from 9-10 studs back and 4+ studs up, and check every beat in the viewport.
- Local-time snow (Material.Snow) reads white at night; tint it blue-grey and make the A (walk) prints orange at tr 0.25 so the glow reads in the dark.
- Never leave a preview-only camera change (e.g. roll 0 for landscape screenshots) in the live engine: story 002 take 1 recorded unrolled, so finishing transpose=2 turned it sideways. Keep previews on a separate flag; play() always rolls +90.
- Never leave a preview-only camera roll in the live engine: play() must always use ROLL 90 (recorded take 1 came out sideways); preview() uses S.noroll for landscape screenshots only.
- Strider (all-black coat) vanishes at night: give it a Highlight outline (Occluded) plus a torso PointLight, and frame from below/level so the head and shoulders read against the sky.
- A white prop on snow does not read (frozen bottle, boots): use a saturated frost colour (cyan) and switch it at the impact beat, not a beat later.
- Always mirror the live engine to disk (ServerStorage.S13Src -> engines/roblox/story002_cutscene.luau) at the end of every work block; the Studio copy is the only copy until you do.
- Seated R6 rigs: limb() hip swing flips the legs sideways when facing the camera; use P(r,"RH",0,0,90)/P(r,"LH",0,0,-90) (Z-axis) for legs straight forward on a stool.
- Bandaged feet only read if the camera is low and to the side of the footstool; a high shot hides them behind the stool.
- Piggyback: place Theo's pivot at June's Torso * CF(0,1.5,1.1) and shoot from in front of June so both faces read.
- Dark-coat Striders on a white lake read best from 8-10 studs up at 3/4 angle; close-ups show only black legs.
- Finishing offset (story 002): actions were staged to start on the first word, so they visibly landed ~0.8 s after the voice. Delay narration with finish_video --lead ~1.1 (engine LEAD 0.3) and check one action frame against words.json before full QA.
- The grey hand must be scaled up (Model:ScaleTo 2.2) and rise from the beat BEFORE "burst" (B50), held through B51, or the key image never lands on camera; give the driver his own mark left of it.
- Neon material + cyan colour is the only way a frozen bottle reads on snow at night.
- Caption chunker splits phrases ("MY TRAIL BLAZED / WHITE.", "BRINGING ME HOT / SOCKS."). Until voice_subs.py chunking is fixed, scan subs.ass for 1-word cards after a 3-word card and re-split by hand before the final burn.

## Story 003 (2026-11-20): Kinematics, Staging & Geometry Invariants
- **Catwalk / Set Protrusion into Cameras (The Blue Bar):** Interior platforms or floors (e.g. CatwalkFloor) inside enclosed buildings or vaults must have their bounding boxes clamped strictly inside the chamber (never extending past door thresholds into the street or plaza). In Story 003, a 12-stud deep catwalk centered at Z = -28.5 extended 5.5 studs forward into the open plaza, placing a giant diamond-plate slab 0.7 studs in front of the camera lens across Beats 6, 7, 9, 17, 18, 19, and 20. Always check bounding box coordinates against door planes (cw.Position.Z + cw.Size.Z / 2 <= Door.Z).
- **Translation vs Yaw Direction (Moonwalking Backwards):** When translating characters, ensure the motion vector matches the LookVector. Translating from Z = 12.0 to 7.5 moves along -Z; with yaw = 180 (facing +Z toward camera), the character visibly moonwalks backwards. To walk forward toward the camera, translate from lower Z to higher Z (e.g. lerp(3.0, 7.5, u) with yaw = 180).
- **R6 Motor6D Limb Kinematics:** In R6 default rigs, forward/backward pitch of shoulders and hips rotates about the joint's local Z-axis (s * fwd * SGN.fwd), while outward abduction rotates about the local X-axis (-(out or 0) * SGN.out). Swapping them causes limbs to flap sideways like wings rather than swinging along the walk/run trajectory. Always prefer using the real Roblox R6 AnimationTracks (r.loco = 'walk' or 'run') via Animator:LoadAnimation() which provides anatomically perfect motion, and reserve procedural angles for upper-body gestures (clutching, chopping, hugging).
- **Market Stand & Cart Pivot Offset:** Never call model:PivotTo() in per-beat step functions without a verified PrimaryPart. Doing so with unanchored or multi-part models can apply cumulative rotations (e.g. turning a market cart 90 degrees sideways so the counter slices right through the vendor). Anchor carts statically in the world once during setup, position the vendor behind the counter (Z = 3.9), and position the customer to the side (X = 19.2, Z = 7.8) with a 3/4 camera angle (X = 25.5, Z = 9.0) so both are visible without occlusion.
- **Multi-Character Staging (No Collinear Radial Alignment):** Placing characters in single file along the camera sightline creates giant foreground head occlusions (e.g. Leo's head filling the entire lower screen and tilting upwards, blocking Maya and the Cocoa Cart). Stage characters side-by-side across the camera's FOV (e.g. Vendor at X = -30.5, Maya at X = -28.2, Leo at X = -25.6), pulled back to waist-level medium scale (camera at Z = 17.5, FOV 50).
- **R6 PrimaryPart Consistency:** Always enforce m.PrimaryPart = m.HumanoidRootPart in register(m) so r.m:PivotTo() pivots consistently around the root, avoiding unexpected foot-submergence or head-level displacement.
- **Zero Em Dashes:** Strict rule across all stories: never include em dashes or double hyphens in narration text, script.md, beats.json, subs.ass, or captions, and never on 3D in-world signage (e.g. `"FROST VAULT: DOOR 19"`).
- **Catwalk Interior Grounding:** For characters placed inside elevated structures or vaults, build an explicit `CatwalkFloor` slab at threshold height and compute root pivot from character scale (`Y = floorY + scale * 2.42`), preventing floating rigs.
- **Frosted Window Visibility & Dimmed Interiors:** When viewing characters through glass or ice observation windows, use `Material = Enum.Material.Ice`, `Transparency = 0.40`, and dim interior point lights to `< 0.6` brightness so clothing textures and facial decal expressions remain crisp rather than blowing out into flat white.
- **Occlusion-Free Two-Shots:** Never pitch arms/shoulders forward > 30° toward the lens at close range (< 5 studs). Keep arms naturally lowered to sides and pull camera back to $Z \approx 5.5$ studs (FOV 48–52) for clean balanced two-shots.
- **Eliminate Macro Face Filler:** Pull medium hero shots back to $Z \approx -17.5$ to $-18.5$ with FOV 50–52 to show waist-up character framing, held items, chest accessories, and architectural background context.
- **Strict Thumbnail Color Invariant:** 1080x1920 real frame, Arial Black typography, using white plus exactly ONE accent color (`#00F0FF` cyan).
- **Background Audio Bed & Zero Static Sound (owner rule 2026-11-20):** Every reel must use `assets/sfx/roblox-story-bg.mp3` as the background music bed (`--bgm roblox-story-bg.mp3 --bgm-gain 0.14`, looped seamlessly). Never use synthesized static sounds or noise beds (`music_soft.wav`, ambient noise, waves, hiss), which degrade into annoying static hiss over narration on phone speakers.
- **Two-Part Series Splitting & Outro Hook (owner rule 2026-11-20):** When dividing stories into multi-part reels:
  - Part 1 hard-cuts at peak crisis/danger (e.g. character locked inside a freezing chamber as sirens blare).
  - Add a narrated outro hook (Kokoro `am_adam` at speed 1.15) e.g. *"Watch Part 2 to see how he saved her"*, holding the final frame with high-contrast animated LowerThird CTA (`WATCH PART 2` in cyan `#00FFFF`, `TO SEE HOW HE SAVED HER` in white).
  - Part 2 starts immediately on the crisis aftermath (panicked crowd, counterfeit keys disintegrating), pays off all planted props (e.g. Dad's pocket watch ticking again), and delivers the action-echo resolution.
  - Generate matching cohesive thumbnails for both parts (`thumbnail_part1.jpg` and `thumbnail_part2.jpg`) sharing the hook header and distinguishing Part 1 vs Part 2.
- **Studio Cloud Persistence (owner rule 2026-11-20):** Laptop reboots or Studio restarts wipe local DataModel memory. Always execute `save_place` to save cloud version history after building or updating sets/casts, write an auto-initializer to `Workspace.Script`, and mirror live code to disk.
