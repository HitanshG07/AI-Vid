# Deep Research on Viral Roblox Story Workflows (`jsxsI2BAyWY` + 4 Top Channels) & Master Upgrade Plan (`Roblox Studio` vs. `Blender 4.x`)

## 1. Breakdown of the 5 Viral AI Roblox Story Workflows Analyzed

We analyzed the full transcripts, pipelines, and visual rules of the video you shared alongside the 4 other leading AI Roblox Story workflow breakdowns published this week:
1. **Jack Bennett** — [*FREE AI Makes VIRAL Roblox "In This Town" Shorts (No Claude Pro)*](https://www.youtube.com/watch?v=jsxsI2BAyWY) (`10.1K` views, published Nov 12, 2026)
2. **Simply Azan** — [*How to Make Viral "In This Town" Roblox Shorts Using Claude*](http://www.youtube.com/watch?v=qGhhl_mp5Pk) (`56.6K` views, published Nov 11, 2026)
3. **Flashloop Twins** — [*How to Make Viral Roblox "In This Town" 3D Animations in One Prompt*](http://www.youtube.com/watch?v=IJT0jXZidkY) (`115.7K` views, published Nov 11, 2026)
4. **Saajwal Gigabyte** — [*How to Make Viral Roblox ‘In This Town’ 3D Animations With Claude Only*](http://www.youtube.com/watch?v=QESMCxQQDNo) (`31.9K` views, published Nov 13, 2026)
5. **fwjelaa** — [*How to Make 'In This World' Roblox Shorts with AI (FREE Skill)*](http://www.youtube.com/watch?v=OeJweDDKgQg) (`12.7K` views, published Nov 14, 2026)
6. **Viral Short Benchmarks**: [Flupzzy](https://www.youtube.com/shorts/47J1l3p1Abc) (`4.64M` views), [craftee_films (*The SWORD*)](https://www.instagram.com/reel/DfvPMO-BQIW/?exln=NjdmenI0cnppYmhl), [craftee_films (*Never Turn Around*)](https://www.instagram.com/reel/DfEbVWLhKIl/?xtok=MXFwODcxNGk0cjk1eg==) (`1.2M` likes), [zaylento (*Bunker Part 1*)](https://www.instagram.com/reel/DfMIcVjK4W_/?rpxt=MWNnZmI1eWMzMWpuYw==) (`242.8K` likes), [noctaru.story](https://www.instagram.com/reel/DfnxkK4APF2/?cplk=MTVoM2hpeDF2a2VpbA==), and [gneef.original](https://www.instagram.com/reel/DfF7knjBd48/?obrf=MW9zem9ydjV1Mndp) (`325.5K` likes).

### Side-by-Side Comparison: What Top Viral Creators Do vs. Our Current `AI-Vid` Package

| Production Pillar | What `jsxsI2BAyWY` (Jack Bennett) & `qGhhl_mp5Pk` (Simply Azan) Revealed | What Our Current `AI-Vid` Repo Does | Concrete Gap & Upgrade to Add Now |
| :--- | :--- | :--- | :--- |
| **1. Rendering Engine (`Blender 4.x` vs. `Roblox Studio`)** | • [Jack Bennett](https://www.youtube.com/watch?v=jsxsI2BAyWY) & [Flashloop Twins](http://www.youtube.com/watch?v=IJT0jXZidkY) build and render the entire short **headlessly in Blender (`bpy` EEVEE)** in ~5 minutes on a laptop—native `1080×1920`, zero screen-capture window hijacking, direct `.obj` loading, and a **12-second 3-picture-per-shot check loop**.<br>• [Simply Azan](http://www.youtube.com/watch?v=qGhhl_mp5Pk) & [fwjelaa](http://www.youtube.com/watch?v=OeJweDDKgQg) use **Roblox Studio MCP**, rotating the camera `90°` sideways and screen-recording. | Currently locks everything to **Roblox Studio `gdigrab` screen capture** and bans Blender characters completely in `AGENTS.md` because an early test used raw un-beveled Blender cubes. | **Enable Dual-Engine Hybrid Architecture**: Allow **Blender 4.x EEVEE (`bpy`)** whenever using exported Roblox Studio `.obj` rigs or our beveled R15 `.obj` meshes + `.obj` props (`AcidBottle.obj`, `TestTubeRack.obj`, `GrandmaArmchair.obj`), while keeping Roblox Studio MCP for native catalog avatar builds. |
| **2. Face Acting & UV Head Swap System** | [Jack Bennett](https://www.youtube.com/watch?v=jsxsI2BAyWY) generates a **sheet of 16 2D face PNGs** (*"because in this style the face does all the acting and has to change right on the beat"*) mapped cleanly to a dedicated face plane on a standard `1.2×1.2` Roblox head. | Main cast uses `generate_avatar` MeshPart heads where the face AND hair share a single baked UV texture—so when Claude put our 2D face PNG on `Hero`, the PNG bled onto the hair and showed the old face underneath! | **Fix Main Cast Head Architecture**: Either (a) keep `ApprovedFaces` MeshPart clones for the existing Story 007 main cast, OR (b) for new characters (and in Blender), use a **clean beveled Roblox Head mesh with a separate Hair accessory** so 2D face PNGs swap on the exact beat with zero hair bleed! |
| **3. Cut Pace & Camera Dynamics (`1.2s` Cuts + Snap-Zooms + Dutch Tilts)** | • [Jack Bennett](https://www.youtube.com/watch?v=jsxsI2BAyWY): **`17 shots in 20s` (`1.18s` per shot)**—a new camera angle on almost every phrase.<br>• [Simply Azan](http://www.youtube.com/watch?v=qGhhl_mp5Pk): **`133 shots in 120s` (`0.9s–1.2s` per shot)**; mixes slow push-ins, **close-to-wide snap pull-outs**, **hard snap-zooms on key words**, and **`2°–4°` Dutch tilts on 50% of shots**. | `story007_cutscene.luau` has 27 beats in 50s (with `cut2()` on ~8 beats = ~35 shots, `1.4s` avg), and uses the **same uniform `+4%/s` slow push-in** on every single shot. | Add **3 camera motion modes** to the cutscene engine:<br>1. `pushIn` (default slow 4%/s push)<br>2. `snapOut` (start tight on face/prop for `0.25s`, ease out to medium)<br>3. `impactZoom` (fast `FOV 44° → 35°` punch + `2.5°` Dutch tilt on reveal/impact words). |
| **4. Visual Palette, Surface Textures & Low-Sun Shadows** | • [Jack Bennett](https://www.youtube.com/watch?v=jsxsI2BAyWY): *"The look is darker than you'd expect, with Roblox-sized heads, dark clothes, and texture on every surface—my first version had big heads and bright pastel colors and looked like a kids' show."*<br>• [Simply Azan](http://www.youtube.com/watch?v=qGhhl_mp5Pk): **Low sun angle casting long dark shadows** + warm pale sky. | Classroom walls in `Set_ChemLab` are flat untextured cream/beige (`SmoothPlastic`), which looks slightly flat/pastel in wide shots (`B1[11]`, `B1[22]`). | Add **textured wall wainscoting/brick (`Material = Brick / WoodPlanks`)**, lower `Lighting.ClockTime` to **`16.8` (`4:48 PM`)** so long directional window shadows cross the lab floor and desks, and use darker, richer wardrobe tones. |
| **5. "Sound-Off Rule" (World Rule Visible in Every Shot)** | [Simply Azan](http://www.youtube.com/watch?v=qGhhl_mp5Pk) & [noctaru.story](https://www.instagram.com/reel/DfnxkK4APF2/?cplk=MTVoM2hpeDF2a2VpbA==): *"If the rule is a number above your head, the number is above everyone's head in every single shot, so someone scrolling on mute understands immediately."* | In `007_wrist-rewind`, the wrist mechanic is only visible during close-up tap shots (`B1[1]`, `B1[3]`, `B2[2]`). | Add a persistent **glowing cyan wrist tally band / holographic `BillboardGui` counter (`TAPS: 0` / `TAPS: 4`)** visible on characters' wrists so muted scrollers immediately see the rule in action. |
| **6. Voiceover Naturalness** | • [Jack Bennett](https://www.youtube.com/watch?v=jsxsI2BAyWY): Uses `Edge-TTS` for free testing, then upgrades to human/premium TTS.<br>• [Simply Azan](http://www.youtube.com/watch?v=qGhhl_mp5Pk): Uses **Google AI Studio Speech (Gemini TTS)** for free—which sounds significantly more natural and expressive than `Edge-TTS`! | Uses `Edge-TTS` (`en-US-AndrewNeural` at `+8%`). | Add a **Google AI Studio Speech (`gemini-2.5-flash-preview-tts`) / Kokoro-82M** option in `pipeline/voice_subs.py` alongside `Edge-TTS` for richer emotional inflection at ₹0 cost. |

---

## 2. Why Blender 4.x (`bpy`) vs. Roblox Studio Shouldn't Be a Blind Ban — The Honest Technical Comparison

In your repo's `AGENTS.md`, Claude previously wrote *"Never build characters in Blender (rejected: doesn't look like Roblox)"* because an early test built characters out of raw un-beveled Blender cubes.

Here is the real engineering truth proven by [Jack Bennett (`jsxsI2BAyWY`)](https://www.youtube.com/watch?v=jsxsI2BAyWY) and [Flashloop Twins (`IJT0jXZidkY`)](http://www.youtube.com/watch?v=IJT0jXZidkY):

| Capability | Roblox Studio MCP (`gdigrab` Capture) | Blender 4.x EEVEE (`bpy` Headless GPU Render on RTX 4060) | Winner |
| :--- | :--- | :--- | :--- |
| **Authentic Roblox Character Look** | Native `HumanoidDescription` / `generate_avatar` R15 rigs | **100% Identical** when you export the R15 character `.obj` from Roblox Studio once (or use our beveled R15 `.obj` + 3D hair meshes + `512×512` 3-layer face PNGs) | **Tie** (once exported/rigged) |
| **2D Face Decal Swapping (`88` Kit PNGs)** | Fails on `generate_avatar` heads because hair & face share one baked UV map; requires slow `generate_texture` AI head clones | **100% Instant & Flawless**: Dedicated front face UV quad swaps any `512×512` `*_decal.png` on the exact frame with **zero hair bleed** | **Blender 4.x** |
| **Importing `.obj` Props (`Armchair`, `TestTubeRack`, `Beaker`)** | Cannot import `.obj` via Luau script in Edit Mode without manual UI import or Open Cloud `.glb` upload | **1 Line of Python**: `bpy.ops.wm.obj_import(filepath="...")` loads any `.obj` prop in `0.05s` | **Blender 4.x** |
| **Rendering & Screen Usage** | Must bring Studio window to foreground (`gdigrab`), park mouse cursor, and **cannot touch your laptop for 2 minutes**; blocked by MCP permission prompts | **100% Headless Background Render** (`blender -b -P script.py -a`): uses your RTX 4060 at native `1080×1920` while you use your laptop freely | **Blender 4.x** |
| **Resolution & Aspect Ratio** | Landscape window rotated `90°` (`ROLL`), cropped `849×1509`, upscaled `1.27×` to `1080×1920` (loses 20% pixels) | **True Native `1080×1920` Vertical Camera** (zero crop, zero upscale softness, zero clipped wall posters) | **Blender 4.x** |
| **Pre-Render QA Speed** | Must play and screen-record the entire 52s cutscene in real time (`52s` per part) to generate a QA sheet | Renders a **28-beat check-picture sheet in ~12 seconds** ([Jack Bennett `jsxsI2BAyWY`](https://www.youtube.com/watch?v=jsxsI2BAyWY)) before rendering video | **Blender 4.x** |

### The Optimal Rule for `AI-Vid` Going Forward (Dual-Engine Policy):
1. **Finish Story 007 (`Part 1` & `Part 2`) in Roblox Studio Right Now**: Since Story 007's v3 fixes, sets, main cast faces, and 6 extras are already staged in Roblox Studio and only waiting for the `mcp__Roblox_Studio__execute_luau` permission + `"record"` command, finish recording Story 007 in Studio right now (`~3 minutes`).
2. **Lift the Blanket Blender Ban & Enable the Blender 4.x EEVEE Pipeline (`engines/blender/`) Alongside Argon/Studio**:
   - Export your Roblox Studio R15 base rigs + 3D hair accessories once to `assets/meshes/characters/` (or use the 31 `.obj` meshes + 88 face PNGs already in the kit).
   - Allow Claude to use **Blender 4.x EEVEE (`bpy`)** whenever a story needs direct `.obj` props (`GrandmaArmchair.obj`, `TestTubeRack.obj`), instant 2D face-sheet PNG swapping (`Hero_*_decal.png` without hair bleed), native `1080×1920` headless background rendering, or the 12-second beat check-picture loop from [Jack Bennett (`jsxsI2BAyWY`)](https://www.youtube.com/watch?v=jsxsI2BAyWY)!

---

## 3. Exact Copy-Paste Response to Send to Claude Code Right Now

Copy and paste the block below directly into **Claude Code** to:
1. Unblock and record **Story 007 Part 1 and Part 2** right now (skipping the redundant armchair/test-tube rack `.obj` conversion since the scene already has them),
2. Update your repo rules (`AGENTS.md` and `ARGON_PIPELINE.md`) with the new **Blender vs. Roblox Studio Dual-Engine Rule** and the **5 Viral Upgrades** from our YouTube research (`jsxsI2BAyWY` and `qGhhl_mp5Pk`):

```text
Great analysis on the main cast UV heads. Keep the main cast's current `ApprovedFaces` heads (since their hair is baked into the head UV) and keep the kit's 3-layer faces on the 6 extras. You do NOT need to convert the armchair or test-tube rack `.obj` files for Story 007 since `Set_GrandmaRoom` and `Set_ChemLab` already have them.

Now execute these two tasks in order:

### TASK 1 — RECORD STORY 007 PART 1 & PART 2 NOW AND BUILD AUDIT-004
1. Also make sure `PR.Phone` is welded to `Jace.LeftHand` (`WeldConstraint`) in `engines/roblox/story007_cutscene.luau` so the phone never detaches to his waist during `PivotTo` on selfie beats (`P1 29.2s`).
2. I have enabled/approved `mcp__Roblox_Studio__execute_luau`. **Record** now:
   - Run Part 1 and Part 2 capture at locked 30 fps (`pipeline/record_take.py`).
   - Run `pipeline/finish_video.py` with `--beats beats_p1.json --end 50.05` and `--beats beats_p2.json --end 51.55` to overwrite the root finals (`stories/007_wrist-rewind/007_wrist-rewind_part1.mp4` and `007_wrist-rewind_part2.mp4`).
   - Run `pipeline/qa_sheet.py` on both replaced finals (`rec/v3/qa_p1.png`, `rec/v3/qa_p2.png`), verify every beat tile passes (zero brown hand-boxes, zero detached phones, zero bottle occlusions, rebuilt Grandma room, blurred extras, bright Part 2 ending), and package `audits/AUDIT-004_2026-11-16_story007-v3_part*.zip`.

### TASK 2 — UPDATE `AGENTS.md`, `ARGON_PIPELINE.md`, AND `docs/LESSONS_LEARNED.md` WITH OUR NEW VIRAL RESEARCH & BLENDER DUAL-ENGINE RULES
Update the repo rulebooks to incorporate these 6 rules proven by top viral Roblox story workflows (`jsxsI2BAyWY`, `qGhhl_mp5Pk`, `Flupzzy`, `craftee_films`, `zaylento`):

1. **Dual-Engine Policy (Roblox Studio MCP + Blender 4.x EEVEE Allowed):**
   - Lift the blanket ban on Blender. What is banned is *un-beveled raw primitive cubes that don't look like Roblox*.
   - **Blender 4.x EEVEE (`bpy`) IS APPROVED AND ENCOURAGED** whenever using authentic Roblox R6/R15 `.obj` rigs (exported from Roblox Studio or `archive/kit_v3/meshes/` with separate `Head` and `Hair` meshes so our 88 2D face PNGs swap with zero UV hair bleed) and `.obj` props (`REUSE_LIBRARY/props/*.obj`).
   - **When to prefer Blender 4.x over Roblox Studio:** Whenever a story needs (a) headless background GPU rendering at native `1080x1920` without hijacking the screen via `gdigrab` or losing 20% resolution to the `90°` landscape roll crop, (b) direct `.obj` prop imports without Open Cloud `.glb` uploads, (c) instant 2D face-sheet PNG swapping on separate head/hair meshes, or (d) a 12-second low-res beat check-picture pass before full rendering.
   - **How to fix main-cast face decals in Studio for Story 008+:** When creating new characters in Argon/Studio, keep the `Head` (`1.2x1.2x1.2` beveled head) separate from the `HairAccessory` (do not bake hair into the head UV map) so 2D 3-layer face PNGs (`REUSE_LIBRARY/faces/`) can be swapped directly on `Head` with zero hair bleed.

2. **Sound-Off World Rule Indicator (Every Shot):**
   - Whenever a story's world rule involves a number, timer, counter, or physical mark, make that indicator visible on characters in medium and wide shots too (e.g., floating `BillboardGui` counter or glowing wrist tally) so viewers watching on mute understand the rule in 1 second.

3. **3-Mode Dynamic Camera Movement + Dutch Tilts (`1.2s` Avg Cut Pace):**
   - Never use the same linear push-in on every shot. Across a story's beats, mix:
     • **60% Slow Push-Ins** (`4%/s` toward the face),
     • **25% Close-to-Wide Snap Pull-Outs** (start tight on the face/prop for `0.25s`, then ease back to reveal the scene),
     • **15% Hard Impact Snap-Zooms + `2.5°` Dutch Tilt** (`CFrame.Angles(0, 0, math.rad(2.5))`) timed to key reveal/danger words.

4. **Low-Sun Long Shadows & Textured Surfaces (Anti-Toddler-Show Look):**
   - Avoid flat untextured pastel walls. Use textured surfaces (`Brick`, `WoodPlanks`, `Slate`, wainscoting) and set golden-hour `Lighting.ClockTime = 16.8` (`4:48 PM`) so long directional shadows stretch across the floor and desks.

5. **3 Early Micro-Setups That Pay Off in the Twist:**
   - Every script and `MANIFEST.md` must plant 2–3 quick visual examples/jokes of how people live under the rule in the first 10 seconds, and bring at least one of those setups back as the mechanism of the final twist.

6. **2-Minute Graybox / 12-Second Beat Check-Picture Gate Before Full Capture:**
   - Always render 1 check picture per beat (or run `qa_sheet.py` on a fast preview pass) to verify camera sightlines and prop placement before running the final full-quality render.
```
