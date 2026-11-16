# Complete Reference Benchmarks, Security Audit & Iteration Log

## 1. All Reference Videos Studied & Their Exact Production Formula
1. **[`craftee_films` — "MY GRANDPA KNOCKS ON THIS WALL EVERY DAY..."](https://www.instagram.com/reel/Dfr3KAahSw3/?rpxt=MTRpZjg3bHNsejA2cg%3D%3D)** *(318.4K likes)*:
   - Emotional family mystery, warm daylight/dusk lighting, **Lower-Third (`Y = 82%`)** 1-word bold white subtitles.
2. **[`craftee_films` — "The SWORD"](https://www.instagram.com/reel/DfvPMO-BQIW/?exln=NjdmenI0cnppYmhl)** *(31.7K likes in 9h)*:
   - Beveled 3D Roblox rig with custom baker apron texture, 2D anime/cartoon shocked face decal, flying bread rolls with **object motion blur**, and bold white/green outlined subtitles.
3. **[`craftee_films` — "Never Turn Around"](https://www.instagram.com/reel/DfEbVWLhKIl/?xtok=MXFwODcxNGk0cjk1eg%3D%3D)** *(1.2M likes)*:
   - Low-angle golden-hour framing pairing a blocky Roblox avatar with a tall, lanky smiling orange horror creature in a black top hat.
4. **[`zaylento` — "The Monster Can Only Move in the Dark"](https://www.instagram.com/reel/Dfn3lXXqB1B/?rpxt=MzBhNWp2cmhvcnU5)** *(301.2K likes)* & **["Everyone Has a Bunker Except Me (Part 1)"](https://www.instagram.com/reel/DfMIcVjK4W_/?rpxt=MWNnZmI1eWMzMWpuYw%3D%3D)** *(242.8K likes)*:
   - Multi-part survival series (`Part 1` cliffhanger), sunset/night brick cityscapes with vines and boarded windows, volumetric spotlight cones (`SpotLight` + `Beam`), shallow depth-of-field, and **Lower-Third** bold yellow subtitles.
5. **[`noctaru.story` — "In this world, monsters can smell how strong you are. I'm a zero."](https://www.instagram.com/reel/DfnxkK4APF2/?cplk=MTVoM2hpeDF2a2VpbA%3D%3D)** *(24.9K likes)*:
   - "One-Rule World" underdog premise, glowing cyan chest stat badge (`9,400`) vs monster numbers (`300`), and **Upper-Third (`Y = 15%`)** uppercase white subtitles.
6. **[`gneef.original` — "Superpowers Transfer To Loved Ones"](https://www.instagram.com/reel/DfF7knjBd48/?obrf=MW9zem9ydjV1Mndp)** *(325.5K likes)*:
   - Levitating hero shot against an indigo city sky with swirling purple smoke clouds, star sparkle particles, and glowing orange hand energy.
7. **[`Flupzzy` — "In this world, everyone gets one superpower, but only once"](https://www.youtube.com/shorts/47J1l3p1Abc)** *(4.64M views)*, **[`Kyee`](https://www.youtube.com/watch?v=EDgSEw9ZJq0)** *(193.5K views)*, and **[`VoidCast`](https://www.youtube.com/watch?v=E_wO8RhmUpc)** *(17.2K views)*:
   - Fast 1st-person world-rule hooks, 1–2s camera cuts, and emotional twist endings.
8. **[`howitactually` — "Engine On vs Engine Off at 12 Red Lights"](https://www.instagram.com/reel/Dfr2ahbDLrN/?exln=MW02YXV6cmt1emx0bg%3D%3D)** *(6.6K likes in 23h)*:
   - Dark-mode 2D top-down vector motion graphics with lane spotlight dimming, live counters, and yellow-pill word highlights.

---

## 2. Full Chronological Iteration Log
- **Iteration 1**: Mapped monetization platforms and local RTX 4060 audio/caption stack (`Kokoro-82M`, `Edge-TTS`, `Faster-Whisper`, `FFmpeg`).
- **Iteration 2**: Rejected 7-image `zoompan` slideshow (`Roblox_3D_Fallout_Shelter_Twist_Short.mp4`) for lacking real 3D frame-by-frame motion.
- **Iteration 3**: Tested CPU Python `cv2` polygon rendering (`1,650` frames and `9,000` frames across 5 stories), diagnosed the non-contiguous NumPy sky array bug and floor clipping bug, and proved through a side-by-side audit why CPU OpenCV polygons (`0.5%` quality) cannot substitute for a GPU 3D engine (**Blender EEVEE** / **Roblox Studio `Future`**) with real `.obj` meshes, PBR lighting, volumetric smoke/beams, and spoken neural TTS.
- **Iteration 4**: Audited open-source skills and MCP servers—flagged `Flashloop` ($19–$59/mo paywall), `ahujasid/mcp-for-blender` (Issue #202 Arbitrary File Read), and `MoneyPrinterTurbo` (unauthenticated API), and locked in the lean, safe local stack (`remotion-dev/skills` + `haidrrrry/claude-remotion-skill`, Roblox's built-in Studio MCP, and local Blender 4.x `bpy` + `Edge-TTS`/`Kokoro-82M` + `Faster-Whisper`).
- **Iteration 5 (Final Production Kit)**: Packaged the universal Master Prompt (`MASTER_PROMPT_ANY_AI.md`), custom `SKILL.md`, RTX 4060 Blender EEVEE `bpy` engine (`blender_movie_grade_template.py`), Roblox Studio `Future` cutscene engine (`RobloxStudio_MovieCutscene_Engine.luau`), off-center `.ass` voiceover/subtitle pipeline (`voice_subtitles_ffmpeg_pipeline.py`), all 10 web-original story & 2-part series scripts, and the Windows 11 PowerShell runner.
