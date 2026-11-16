# Universal Master Prompt: Movie-Grade Roblox Story & Fact Video Director (A-to-Z Blueprint + Execution Prompt)

Copy everything between `PROMPT START` and `PROMPT END` and paste it into **Claude Code, Cursor, Antigravity, Gemini Pro, or ChatGPT Plus** whenever you want to generate a brand-new, production-ready video on your Windows 11 laptop.

---

## PROMPT START

### 1. WHAT WE ARE TRYING TO ACHIEVE (PROJECT VISION & GOAL)
We are building an automated, **₹0 (zero-extra-subscription)** short-form video production studio running locally on my Windows 11 laptop (**ASUS ROG Strix G16, NVIDIA GeForce RTX 4060 8 GB VRAM, 16 GB DDR5 RAM**) that turns a single prompt into a **movie-grade, high-retention `1080x1920` (60 FPS) vertical video** for **YouTube Shorts, Instagram Reels, and TikTok**.

Our objective is **100% broadcast-ready quality with zero "AI slop"** across two core content tracks:
1. **Track A — Movie-Grade 3D Roblox Story Shorts ("One-Rule Worlds", Emotional Mysteries & Survival Series)**:
   - Fast-paced, 1st-person narrated stories (`50–60 seconds`, `~240–280 words`, `3,300–3,600 frames` at `60 FPS`) that open in the very first second with a high-concept world rule or mystery hook (*"In this town..."*, *"In this world..."*, *"My grandpa knocks on this wall every day..."*), escalate into a life-or-death or deeply emotional personal crisis, and resolve with a clever twist and a real human takeaway.
   - If a story's emotional arc is too big for 60 seconds, it is **automatically built as a 2-Part Series** (`Part 1` ends on a high-tension cliffhanger; `Part 2` delivers the twist resolution and emotional payoff).
2. **Track B — Informative Tech & Everyday Fact / Simulation Reels (`howitactually` Style)**:
   - Clean, dark-mode (`#0D1017`) 2D vector motion-graphics explainers and side-by-side simulations (`35–50 seconds`, `1080x1920`, `60 FPS`) that test everyday myths or explain fascinating tech/engineering concepts using spring-physics animations, spotlight dimming, live numeric counters, and yellow-pill highlighted captions.

---

### 2. HOW WE ACHIEVE IT (THE PROVEN LOCAL ARCHITECTURE)
Earlier experiments proved that **CPU Python/OpenCV polygon scripts and static image `zoompan` slideshows fail (`0.5%` quality)** because they lack GPU lighting, real 3D meshes, volumetric shaders, and natural voiceover. We achieve movie-grade quality by strictly separating **AI Direction/Code Generation** from **GPU Rendering & Neural Audio**:

```
[Step 1: Web-Originality Search & Ledger Check]
   └─> AI searches Google/YouTube/Reels to verify 0 matching stories & checks the Story History Ledger.
         │
         ▼
[Step 2: Hook-First Script + Word-Level Neural Audio (Local Python)]
   └─> Edge-TTS (`en-US-AndrewNeural`) or Kokoro-82M generates expressive 1st-person voiceover (`voiceover.mp3`).
   └─> Faster-Whisper (`small.en` on RTX 4060) extracts exact millisecond word timestamps (`words.json`).
   └─> `voice_subtitles_ffmpeg_pipeline.py` builds an `.ass` subtitle file placed strictly in the
       Lower-Third (`Y = 82%`) or Upper-Third (`Y = 15%`) — NEVER in the dead center of the screen.
         │
         ▼
[Step 3: GPU Rendering Engine (Depending on Track)]
   ├─> TRACK A (3D Roblox Stories):
   │     • Engine Option 1 (Blender 4.x EEVEE on RTX 4060): AI writes a complete `bpy` script that imports
   │       authentic Roblox `.obj`/`.fbx` rigs from `C:\AI-Vid\assets\rigs\` (or builds exact R6 beveled
   │       rigs), sets up EEVEE Volumetric Fog, Bloom, Depth of Field, Object Motion Blur, SpotLight cones,
   │       and Particle Emitters, and renders 60 FPS frames.
   │     • Engine Option 2 (Roblox Studio `Future` Lighting via Built-In Studio MCP): AI drives Roblox Studio
   │       directly (`CinemaDirectorEngine.luau`) with `Motor6D` 60 FPS animation, classic `Face` decal
   │       swaps, `SpotLight` + `Beam` volumetrics, and `BillboardGui` stat counters.
   │
   └─> TRACK B (2D Fact & Tech Explainers):
         • Engine (Remotion React + TypeScript): AI uses `remotion-dev/skills` + `claude-remotion-skill`
           to build 60 FPS spring-animated 2D vector scenes synced to `words.json`.
         │
         ▼
[Step 4: Mandatory 4-Frame Visual QA Loop -> Full Render -> FFmpeg Master Merge]
   └─> AI extracts 4 sample frames (`10%`, `40%`, `70%`, `90%`) via FFmpeg and inspects them to verify
       zero camera clipping, proper character lighting, and clean off-center captions before final muxing.
```

---

### 3. EXACT VISUAL & NARRATIVE BENCHMARKS YOU MUST MATCH
1. **`craftee_films`** ([Grandpa Wall Mystery](https://www.google.com/search?q=https://www.instagram.com/reel/Dfr3KAahSw3/%3Frpxt%3DMTRpZjg3bHNsejA2cg%3D%3D), [The SWORD](https://www.instagram.com/reel/DfvPMO-BQIW/?exln=NjdmenI0cnppYmhl), [Never Turn Around](https://www.instagram.com/reel/DfEbVWLhKIl/?xtok=MXFwODcxNGk0cjk1eg==)):
   - Authentic beveled Roblox blocky rigs, textured clothing/aprons, expressive 2D anime/cartoon face decals (`Shocked`, `Happy`, `Crying`), flying props with **object motion blur**, golden-hour lighting, and **Lower-Third (`Y = 82%`)** 1–2 word bold white/colored outlined subtitles.
2. **`zaylento`** ([Monster Moves in the Dark](https://www.instagram.com/reel/Dfn3lXXqB1B/?rpxt=MzBhNWp2cmhvcnU5), [Everyone Has a Bunker Part 1](https://www.instagram.com/reel/DfMIcVjK4W_/?rpxt=MWNnZmI1eWMzMWpuYw==)):
   - Sunset/nighttime brick cityscapes with boarded windows and vines, sweeping **volumetric searchlight cones (`SpotLight` + `Beam`)**, atmospheric haze, shallow **Depth of Field**, **Part 1 cliffhanger pacing**, and **Lower-Third (`Y = 82%`)** bold yellow (`#FACC15`) subtitles.
3. **`noctaru.story`** ([Monsters Smell How Strong You Are — I'm a Zero](https://www.instagram.com/reel/DfnxkK4APF2/?cplk=MTVoM2hpeDF2a2VpbA==)):
   - "One-Rule World" underdog story, glowing cyan **holographic chest stat counter (`9,400` vs `-1`)**, floating orange monster counters (`300`), and **Upper-Third (`Y = 15%`)** bold uppercase white subtitles.
4. **`gneef.original`** ([Superpowers Transfer To Loved Ones](https://www.instagram.com/reel/DfF7knjBd48/?obrf=MW9zem9ydjV1Mndp)):
   - Low-angle hero levitation shots against an indigo city sky with **swirling purple volumetric smoke**, star-shaped sparkle particles, and glowing orange hand energy auras.
5. **`Flupzzy` / `Kyee` / `VoidCast`** ([One Superpower Short](https://www.youtube.com/shorts/47J1l3p1Abc), [Kyee Compilation](https://www.youtube.com/watch?v=EDgSEw9ZJq0), [VoidCast Compilation](https://www.youtube.com/watch?v=E_wO8RhmUpc)):
   - Immediate 0-second world-rule hook, rapid 1.5–2s camera cuts, inline comic/dramatic sound cues (*boing, ding, poof, crunch, whoosh*), and a meaningful emotional twist.
6. **`howitactually`** ([12 Red Lights Fuel Test](https://www.instagram.com/reel/Dfr2ahbDLrN/?exln=MW02YXV6cmt1emx0bg==)):
   - Dark-mode 2D top-down infographic simulation, lane spotlight dimming, live timers/counters, and yellow-pill keyword highlights.

---

### 4. SIX NON-NEGOTIABLE PRODUCTION RULES (HARD CONSTRAINTS)
1. **STRICT AUTHENTIC ROBLOX CHARACTER ANATOMY (ZERO RANDOM / GENERIC SHAPES)**:
   - Every human character in a Roblox story MUST look unmistakably like an **authentic Roblox R6 / R15 avatar**—never generic primitives, stick figures, spheres, capsules, or unproportioned boxes.
   - **Exact R6 Proportions & Geometry**:
     - **Head**: Classic Roblox cylindrical-beveled head (`1.2 x 1.2 x 1.2` studs with rounded top/bottom bevels or `SpecialMesh Head` scale `1.25, 1.25, 1.25`)—never a sharp cube or sphere.
     - **Torso**: Rectangular block (`2.0 x 2.0 x 1.0` studs) with beveled edges (`Bevel width = 0.04, segments = 3`) and UV-mapped 2D shirt/jacket/collar/apron textures.
     - **Arms & Legs**: Four independent rectangular limbs (`1.0 x 2.0 x 1.0` studs each) with beveled edges, rigged at exact shoulder (`±1.5, 0.5, 0`) and hip (`±0.5, -1.0, 0`) pivot joints with continuous breathing, walking, and arm-swing keyframes.
     - **Faces & Hair**: Authentic 2D Roblox/cartoon facial expression decal textures (`Happy`, `Shocked`, `Worried`, `Straining`, `Crying`, `Smirk`) mapped onto the front `+Z` face of the head, topped with 3D Roblox hair/hat meshes (`Bacon Hair`, messy anime spikes, caps, or headphones).
   - **Asset Priority**: Always import exported `.obj` / `.fbx` Roblox Studio rigs from `C:\AI-Vid\assets\rigs\` first; if building procedurally in Blender (`bpy`) or Luau, strictly enforce the exact R6 dimensions, bevels, and 2D face decals above.
2. **NO Static Slideshows & NO CPU OpenCV Box Renders**:
   - Never output a `zoompan` image slideshow or a CPU `cv2.fillConvexPoly` script. Always target GPU rendering via **Blender 4.x EEVEE (`bpy`)**, **Roblox Studio (`Future` lighting)**, or **Remotion (for 2D Fact Reels)**.
3. **OFF-CENTER SUBTITLES ONLY (NEVER DEAD-CENTER)**:
   - Place subtitles strictly in the **Lower-Third (`Alignment=2, MarginV=230` / `Y = 82%`)** or **Upper-Third (`Alignment=8, MarginV=220` / `Y = 15%`)** so they never block faces, chest counters, or central VFX.
   - Show **1 to 3 words per beat** synced to `Faster-Whisper` word timestamps with pop-in scale easing (`118% -> 100%`).
4. **MANDATORY WEB-ORIGINALITY SEARCH (ZERO DUPLICATES)**:
   - Before locking any script, run **3 web searches** across Google/YouTube/Reels (`"in this town" "<keyword>" roblox`, `"in this world" "<keyword>" roblox story`, `"<core mechanic>" roblox story`). If any existing video uses the same premise or twist, discard it and invent a new one until you verify **0 matches**.
   - Check the **Story History Ledger** below and never repeat any listed concept.
5. **MEANINGFUL STORYTELLING & 2-PART SERIES RULE**:
   - Every story must have a real emotional core (grief, sacrifice, honesty, forgiveness, unseen kindness).
   - If the story needs more than 60 seconds to hit hard emotionally, output **both `Part 1 (Cliffhanger)` and `Part 2 (Resolution)`** as complete scripts and scene files.
6. **MANDATORY 4-FRAME VISUAL QA LOOP**:
   - Render 4 sample frames (`10%`, `40%`, `70%`, `90%` of timeline) first, inspect them visually to confirm zero wall/floor clipping, clear character visibility, and clean off-center captions, fix any coordinate issues, and then run the full 60 FPS render.

---

### 5. STORY HISTORY LEDGER (DO NOT REPEAT ANY ENTRY BELOW)
&lt;!-- HISTORY_START --&gt;
| ID | Date | Title / Premise | Format | Core Meaning | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 000 | 2026-11-14 | In This Town, Every Shadow Has Real Weight (500 lbs at sunset; pocket mirror rescue) | Standalone | Cleverness under pressure | Completed |
| 001 | 2026-11-15 | My Grandpa Taps 3 Times on the Empty Hallway Floor Every Night (1974 flood shelter Morse code pipe) | 2-Part Series (`craftee_films` style) | Grief looks like madness until you learn love's language | In Kit |
| 002 | 2026-11-15 | In This Town, Footsteps Glow With Heat for 60s & Blind Striders Hunt Warmth (Steaming sock on van decoy) | 2-Part Series (`zaylento` style) | Sacrifice & drawing fire away from family | In Kit |
| 003 | 2026-11-15 | Everyone's Chest Shows How Many Lies They Have Left—Mine Says "-1" (Overloads Truth-Eater beast) | 2-Part Series (`noctaru.story` style) | Radical honesty in a world built on lies | In Kit |
| 004 | 2026-11-15 | Every Fake Apology Adds a 5-lb Granite Stone to Your Backpack (Brother's real amends on bridge) | Standalone | Real forgiveness requires action, not empty words | In Kit |
| 005 | 2026-11-15 | Your Nameplate Fades One Letter Every Year Nobody Speaks It With Care (Janitor Arthur stadium chant) | Standalone | No one is invisible if one person remembers them | In Kit |
| 006 | 2026-11-15 | Crying in Winter Freezes Tears Into Unbreakable Glass Keys (Frost Vault Door 19 rescue) | Standalone | Heartbreak forges the key to free others | In Kit |
| 007 | 2026-11-15 | Tapping Your Wrist Rewinds Any Mistake by 10s—But Ages Your Hands 1 Year (40s chemistry lab save) | Standalone | Save sacrifices for people, not pride | In Kit |
| 008 | 2026-11-15 | Every Spoken "ThankJw" Floats a Gold Lantern Above Your Roof (10,000 anonymous lanterns over woods) | Standalone | The purest generosity never asks for credit | In Kit |
| 009 | 2026-11-15 | Everyone's Heartbeat Broadcasts a Musical Aura Around Their Shoulders (Class clown's hidden speaker) | Standalone | The loudest people often hide the heaviest silence | In Kit |
| 010 | 2026-11-15 | Every Door Requires a Genuine Happy Memory to Unlock—And the Ash Storm Just Hit (Forging a new laugh) | 2-Part Series (`zaylento` + `noctaru` style) | Creating joy right now beats living in the past | In Kit |
&lt;!-- HISTORY_END --&gt;

---

### 6. REQUIRED DELIVERABLES WHENEVER I RUN THIS PROMPT
For every new video request, produce all 5 deliverables below in order:
1. **Originality Search Report**: Exact web queries checked + confirmation of 0 matching videos.
2. **Full Narrated Script & Timestamped Beat Sheet**:
   - Complete 1st-person voiceover text (with `Part 1` and `Part 2` if series), emotional theme, inline SFX cues, subtitle position (`LowerThirdWhite`, `LowerThirdYellow`, or `UpperThirdWhite`), and a second-by-second camera + facial reaction + VFX beat table.
3. **Complete GPU Scene Code**:
   - **If Roblox Story (Track A)**: Output both (a) the complete **Blender 4.x EEVEE (`bpy`)** script (`generate_story_eevee.py`) using authentic R6 proportions/imported `.obj` rigs, volumetric lights, particle emitters, motion blur, and DOF, AND (b) the complete **Roblox Studio `Future` Cutscene (`Luau`)** script (`Cutscene_Story.luau`).
   - **If Informative Fact/Tech Video (Track B)**: Output the complete **Remotion (`React/TypeScript`)** composition (`FactScene.tsx`) with spring animations, spotlight dimming, and live counters.
4. **Local Execution & Audio-Sync Commands (Windows 11 PowerShell)**:
   - Exact commands to run `voice_subtitles_ffmpeg_pipeline.py` (Edge-TTS / Kokoro-82M + Faster-Whisper + off-center `.ass` subtitles), execute the 4-frame QA check, render at 60 FPS on the RTX 4060, and merge the final `1080x1920` `.mp4`.
5. **Updated Story History Ledger**:
   - Output the complete `<!-- HISTORY_START --> ... <!-- HISTORY_END -->` table with the new story appended so I can paste it straight back into this file.

## PROMPT END