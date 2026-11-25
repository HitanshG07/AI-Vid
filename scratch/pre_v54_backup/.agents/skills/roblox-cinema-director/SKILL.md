---
name: roblox-cinema-director
description: Directing rules for Roblox story shorts. Covers shot grammar, faces, VFX, subtitles and QA, built on the locked R6 catalog characters, our 2D face decals and the per-story story.yaml. Use when planning or fixing cameras, beats or visual quality.
---

# Roblox Cinema Director

Source of truth: `CORE.md` and `config.yaml`. The story's spec is `stories/<ID>_<slug>/story.yaml` (`cast:` list with name/gender/default_face/pos; beats with face/cam/motion/action/move_to; `set:`).

## Hard bans
- No non-Roblox bodies, no Blender/Argon/mesh-built characters, no R15 default rigs, no default `:|` faces, no cloned or bare extras.
- Faces are only our flat 2D decals (`assets/faces/classic_v1/`: neutral, scared, shocked, grin, determined, proud). Swap by changing the Head `face` Decal Texture; story.yaml face names come from that set (new ones are added to `engines/faces/classic_faces.py`).
- No slideshows or OpenCV boxes. Render in Roblox Studio (Future lighting).
- No dead-center subtitles. Captions are 1–3 words, lower third (Y≈82%, default) or upper third (Y≈15%) per `config.yaml` (captions block), and never end on a function word.
- No robotic TTS. Voice and pacing come from `config.yaml` (Kokoro, 185-195 WPM) via `pipeline/voice_subs.py`.

## Shot grammar
- Hook: a big face or the key action inside the first ~1.2 s.
- Cut or change the camera every 1.2–2 s (3 s max).
- Camera mix: ~60% slow push-in, ~25% snap pull-out, ~15% impact snap-zoom with 2.5° Dutch. Each beat's `cam` names the mode; count them before handing it over.
- Camera code: `CameraType = Scriptable` before setting CFrame, or the default camera scripts overwrite it; FOV clamps to 1–120 (default 70) and extremes are discouraged (Creator Hub, Camera class). Our ranges: ~50 default, 38–45 for inserts (CORE.md). A plain FOV tween is not a dolly zoom; distance must change with FOV.
- Face shots: subject yaw ≤40°, never their back.
- Every camera goes through `clearShot` so no prop or rig covers a face.
- Props sit low in frame, faces high. Use top-down inserts for bench props.
- Part 1 hard-cuts on the person in danger. Only the final part fades.

## VFX
- Use only the lighting presets in `core_engine.luau`, set via `lighting:` in story.yaml.
- Sets: 4 reusable sets `street_day`, `school_yard`, `anime_arena`, `cozy_room` (+ `street_002_winter`); floors sit at y=0.2, the engine hides the baseplate and buildRig adds FLOOR_Y=0.2 automatically.
- Flash caps: brightness +0.04, bloom +0.12, light 2.5 with range 8.
- Power effects are thin rings or particles. Overlays sit flush with the limb.

## QA
- QA sheet = `rec/qa_beats.png` from `run_take.py --draft`; have `render-qa` judge every tile against CORE.md section 1 and `reference/design_bible/`.
- Review the WHOLE action in the 9:16 portrait crop as a sequence, not one screenshot: check each beat reads in order (e.g. A walks toward B, C enters, A stops and looks at them, A leaves) to catch timing and eyeline problems.
- Never record until the user says "record".

## Related skills
- `.claude/skills/roblox-studio-workflow` (third party): Studio MCP hygiene and evidence labels. Its Rojo and play-test steps don't apply to our Edit-mode cutscenes.
- `.claude/skills/roblox-luau` (third party): Luau style for engine code (`task.*`, own every connection).

## v2 rules (2026-11-19, owner-approved)
- Follow the **catchiness gates** in `CORE.md`: active rule (not a badge), rule visible in frame 1, 3 planted clues, taboo broken by 25s, rule-of-3 attempts, rule-hack climax, action-echo ending, no moral/lecture lines. Avg >= 8.5, none below 8, every gate passes.
- Voice and pacing come from `config.yaml` (Kokoro, 185-195 WPM).
- Every cast entry declares `gender` (boy/girl/man/woman); all clothing, hair and accessories must match it.
- Cutscenes run on `engines/roblox/core_engine.luau` (never edit it); it resets `loco` every frame; no frozen rigs; no wall-clipping or tilted giant-face filler shots.
- **Mouse lock (owner rule):** every take is recorded ONLY via `pipeline/record_take.py`, which locks the cursor at the top menu bar (900,12) for the whole take and releases it after; never record any other way, never move or unlock the mouse during a take, and never park it at the bottom/corners (taskbar pops up).

## Learned on story 002 (2026-11-19)
- Creatures and villains must read at night: give each a highlight outline plus a small torso PointLight, and frame them big against the sky or snow.
- Props on snow: frozen or icy props need a saturated Neon colour (cyan), or they vanish into the white.
- Close-ups only for an emotion moment. Story 002 QA rejected "giant face" filler, cameras inside walls and coats, and subjects in the bottom caption zone. Keep subjects in the middle third of the 9:16 frame.
- Show the narrated action ON its word (e.g. "She ran." = June mid-run). Twists need their key image on screen (the grey hand), not only in narration.
- An ending needs a twist AND a conclusion. Owner feedback on 002: after the climax, add a short warm closing beat that echoes the world rule (the whole town walks slowly, only June runs).

## Learned on story 003 (2026-11-19 & 2026-11-20)
- **Living city scale:** Avoid cramped courtyard walls; build proper multi-story city avenues (160+ studs) with storefront doors, awnings, warm windows, benches, vehicles, skyline towers, and proportional background crowds.
- **Bloom & snow glare guard:** Disable or cap `BloomEffect`/`SunRaysEffect` and set `ExposureCompensation = -0.32..-0.35` on snow sets so white outfits, faces, and snow never blow out.
- **Duplicate set cleanup:** Always loop `Workspace:GetChildren()` and destroy ALL prior instances of `Set_<Name>` before rebuilding so an older smaller set never overlaps a newer larger set.
- **Tragic + Fun pacing & dramatic VFX:** Pair real emotional stakes and punchy inline character dialogue with comedic world/karmic beats, backed by expanding Neon shockwave rings (`VfxRing`), shatter/powder bursts (`PowderCloud`), ramped snow emitters, and 4-grade storm-to-cyan-to-amber lighting shifts.
- **Kinematic Grounding & Catwalk Anchors:** In interior chambers (vaults, bunkers), always build a dedicated solid floor slab (`CatwalkFloor`) at the exact door threshold height and ground characters directly on it (`pivot Y = floorY + scale * 2.42`), eliminating floating rigs.
- **Frosted Viewport Visibility:** For observation windows, set `Material = Enum.Material.Ice`, `Transparency = 0.40`, and dim interior point lights to `< 0.6` brightness so interior characters remain textured and expressive without turning into blown-out white silhouettes.
- **Occlusion-Free Two-Shots:** Never pitch shoulders forward > 30° toward the camera at close range (< 5 studs), which blocks the lens with forearm sleeves. Maintain eye-level balanced medium two-shots ($Z \approx 5.5$ studs, FOV 48–52) with arms resting naturally at sides.
- **Zero Macro Face Filler:** Pull cameras back to waist-up portrait framing ($Z \approx -17.5$ to $-18.5$, FOV 50–52) showing the torso, chest props (watches, badges), held items, and architectural background rather than giant face fill.
- **Vendor Stand Clearances:** Market stands and counters must be offset $\ge 4.5$ studs from street fixtures (lamp posts, benches) with vendors positioned strictly behind the counter facing +Z and chopping boards/props at waist height ($Y \approx 3.2$).
- **Strict Caption & Sign Invariant:** Zero em dashes (`—`) or double hyphens across scripts, ASS subtitle files, and 3D in-game signs (`"FROST VAULT: DOOR 19"`).
- **Thumbnail Invariant:** 1080x1920 real engine frame, Arial Black, white plus exactly ONE accent color (`#00F0FF`).
- **Catwalk / Set Protrusion into Cameras (The Blue Bar):** Interior platforms or floors (e.g. `CatwalkFloor`) inside enclosed buildings or vaults must have their bounding boxes clamped strictly inside the chamber (never extending past door thresholds into the street or plaza).
- **Multi-Character Staging (No Collinear Radial Alignment):** Placing characters in single file along the camera sightline creates giant foreground head occlusions. Stage characters side-by-side across the camera's FOV (e.g. Vendor at X = -30.5, Maya at X = -28.2, Leo at X = -25.6), pulled back to waist-level medium scale (camera at Z = 17.5, FOV 50).
- **Roblox Studio Persistence & Cloud Saves:** Laptop reboots or Studio restarts wipe uncommitted in-memory states. Always execute `save_place` to save cloud version history after building or updating a set/cast, write an auto-initializer to `Workspace.Script`, and mirror live code to disk.
- **Continuous Background Audio Bed (owner rule 2026-11-20):** Every reel must use `assets/sfx/roblox-story-bg.mp3` as the background music bed (`--bgm roblox-story-bg.mp3 --bgm-gain 0.14`, looped seamlessly in `pipeline/finish_video.py`). Never use synthesized static sounds or noise beds (`music_soft.wav`, ambient noise, waves, hiss).
- **Two-Part Series Splitting & Suspense Hook (owner rule 2026-11-20):** When dividing long reels into two parts: Part 1 hard-cuts on the endangered character at peak danger, followed by an outro spoken hook (Kokoro `am_adam`: "Watch Part 2 to see how he saved her") with an animated LowerThird CTA card holding the final frame. Part 2 resumes immediately on the crisis, pays off all planted props (e.g. Dad's pocket watch ticking again), and delivers the action-echo ending. Create matching cohesive thumbnails for both parts sharing the hook header.
