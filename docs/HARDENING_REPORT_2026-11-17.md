# Hardening report: production loop (2026-11-17)

Scope: web research on how others make Roblox story shorts, then one pass over the rulebook, docs, templates, skills and agents. No code under pipeline/ or engines/ was changed, and nothing under archive/, stories/, ledger/, argon/, audits/ or assets/ was touched. The two third-party skills were not modified.

## 1. What the research established, and how far to trust it

| Source file | What it covers | Reliability |
|---|---|---|
| research_2_artstyle | Lighting, camera, face and animation values | **High.** Mostly official Roblox Creator Hub pages: the Future-lighting tutorials, Camera class, Animation Editor, dynamic heads and post-processing. DevForum items (dolly zoom, Ctrl+Shift+C/G, bloom values) are search snippets only. |
| research_1_workflows | Creator workflows, structure, captions, audio, posting | **Low.** 16 of 46 sources were actually read, and most of those are vendor or SEO blogs (GhostShorts, Opus, inReels). Every retention or view statistic is unsourced. The useful parts are three things everyone agrees on: OBS/screen capture is the norm, word-synced bold captions are the norm, and a muted viewer must still follow the story. Two more items fit our own experience: open on conflict, and cut any beat that changes nothing. |
| research_3_skills + security audit | Public skills and MCP servers | **Medium.** Pages were read through a summarising fetch, not raw files. The result is that two markdown-only skills were installed (roblox-luau, roblox-studio-workflow). Roblox's archived rust MCP server confirms the built-in Studio MCP is the supported route, which is what we already use. |

The research found **no named Roblox story channel's visual style**. Nothing here invents one.

## 2. Weaknesses in the loop, ranked by how likely each is to ruin a video

1. **The frame-rate contract is broken across three layers.** AGENTS.md (Mission) and LESSONS "Recording" say we capture at a locked 30 fps. But `pipeline/finish_video.py:75` outputs `fps=60`, the old produce-video skill and SETUP_GUIDE (self-test, Step 6) said 60 fps, and both `templates/beats_template.json` and story 007's `beats_p1.json` say `"fps": 60`. Upsampling a 30 fps take to 60 duplicates every frame. So the "repeated frames <2%" acceptance gate either always fails on the final file or is run on the wrong file, and the shipped file is a 60 fps container of 30 fps motion.
2. **SETUP_GUIDE Part 4 had a whole second, stale production procedure** (old Step 5 and Step 6). It said to generate assets with MCP rather than Argon, render at 60 fps, run 4-frame QA, and mux with `voice_subs.py --raw-video`. That path has no SFX mix, no lead-in shift, no `--end` trim and no beat QA, so it produces exactly the dry, black-tailed, under-QA'd video that LESSONS bans. Any non-Claude agent that follows SETUP_GUIDE "top to bottom" would take it. AGENTS.md "Hard production rules" also still required "4-frame QA (10/40/70/90%)", which LESSONS bans.
3. **Several QA gates can be passed with no evidence:**
   - `pipeline/qa_sheet.py:21-23` silently skips any beat whose `line` is empty or whose first word isn't found. Those beats get no tile, and nothing reports the gap.
   - `pipeline/finish_video.py:27-28` silently skips any `sfx` whose wav is missing.
   - LESSONS described the repeated-frame check ("tblend+signalstats") without a command.
   - render-qa returned PASS/FAIL in chat only, with nothing saved.
4. **The face method in `.claude/skills/roblox-characters/SKILL.md` contradicted the locked rule.** Old lines 9 and 15 said "Preferred: keep dynamic heads and drive FaceControls", and old section 4 swapped only `ClassicHead.face.Texture`. LESSONS "Characters & faces" says FaceControls looked creepy, the method is per-emotion head clones, and texture-only swaps fail. The skill's trigger is "Use whenever a story needs characters", so it was the first file an agent would read.
5. **The 3-mode camera mix is required but not implemented or checked.** It is required in AGENTS.md "Production rules update" and in MANIFEST template section G. But `engines/roblox/story007_cutscene.luau:1277-1281` applies a push-in to every shot, and there is no snapOut or impactZoom helper. Nothing counts the ratio.
6. **"Record only when the user says record" was missing from the produce-video skill**, which is the step that actually records. It appeared only in cinema-director and ARGON_PIPELINE.
7. **Lighting values disagree with the rule.** AGENTS.md says `ClockTime = 16.8`, but `engines/roblox/roblox_look.luau:6` sets 17.3. That script also leaves `LightingStyle` at the default (Soft) and sets EnvironmentDiffuse/Specular to 0.6/0.4, while the official tutorials use Realistic and 1/1.
8. **The finale ending had contradictory wording.** The MANIFEST template said "the final part fades to black"; LESSONS "Delivery" says never end on black. Story 007 actually fades only in a 0.4 s tail, and the engine then holds black (`story007_cutscene.luau:1297-1301`). The finish `--end` trim is what saves it.
9. **The loudness figure was documented wrong.** LESSONS said ≈-16 LUFS, but `finish_video.py:86` uses `I=-14`.
10. **Cut-rate and caption-position wording was inconsistent.** ENGAGEMENT and SETUP said 1.5–2 s while LESSONS and cinema-director said 1.2–2 s. Cinema-director allowed only lower-third captions, while AGENTS allows lower or upper third.
11. **The freshness combo can't be checked.** The rule is "differ from the last 5 ledger rows' combo", but `ledger/STORY_LEDGER.md` has no rule-category, emotion or setting columns, so the check depends on the agent remembering.
12. **`ideas/TRENDS.md` says "Last refreshed: never".** The brainstorm step reads an empty file.
13. **`pipeline/voice_subs.py:140` defaults the voice to `--rate +8%`,** while LESSONS and ENGAGEMENT say "never speed the voice up". The +8% appears to be a tuned default rather than a cram, but the docs don't say so.
14. **`record_take.py:20` hard-codes the capture REGION** (1882x966). If Studio's ribbon or panels change, the region silently captures chrome, or less than the 968 px LESSONS requires.
15. Minor:
    - Mojibake ("â†’") in docs/AI_ADAPTERS.md.
    - reference/BENCHMARKS.md downloads into `C:\AI-Vid\ref_pack\`, but LESSONS points to `reference/ref_pack/`.
    - The beats template had no `part`, `engine` or `narration` fields, unlike the worked example.

## 3. Edits made

| File | Change | Why / source |
|---|---|---|
| AGENTS.md | Replaced "4-frame QA (10/40/70/90%)" with beat-aligned qa_sheet QA. Added "capture locked 30 fps; never record until the user says record". | Weakness 2 and 1. Source: LESSONS (own experience). |
| docs/LESSONS_LEARNED.md | Loudness now matches the code (I=-14). Added the exact repeated-frame command, measured on the trimmed 30 fps take. Added a note that Roblox Video Captures is beta and ~30 s, so gdigrab stays. | Weakness 9 and 3. Video Captures: Creator Hub. |
| docs/ENGAGEMENT_RULES.md | Cut rate is now 1.2–2 s (3 s max). Added the sound-off line. | Weakness 10. Matches LESSONS and AGENTS. |
| docs/SETUP_GUIDE.md | Replaced old Steps 5–6 with Step 4b (MANIFEST + Argon) and a pointer to produce-video, with a warning not to use the old steps. Self-test is now r=30. Beats cadence is now 1.2–2 s. Checklist now requires the manifest gate and a saved `rec/qa_pN.md`. | Weakness 2, 1 and 3. |
| .claude/skills/produce-video/SKILL.md | Fixed the description to 30 fps. Precondition now includes the manifest and engagement pass. Pointers to the two third-party skills, with Edit-mode caveats. Cast now comes from Argon. Checks that every sfx wav exists and every beat has a spoken `line`. Record step is gated on the user saying "record". Repeated-frame check runs on the 30 fps take. `SFX cues` count must match. qa_sheet frame count must equal beats + 1. `rec/qa_pN.md` evidence is required. Added a note on the 60 fps code. | Weaknesses 1, 3 and 6. Third-party skill integration. |
| .claude/agents/render-qa.md | Frame-count check (beats + 1). Fails on: missing sound-off rule visibility, subject in the caption zone or at the right edge, black END on any part. Reports the repeated-frame ratio. Report saved as `rec/qa_pN.md`. | Weakness 3. Rules from AGENTS and LESSONS. |
| .claude/skills/roblox-cinema-director/SKILL.md | Captions lower or upper third. Cut max 3 s. Camera-mix line plus "count the modes". Camera facts: Scriptable, FOV clamp/default, and a plain FOV tween is not a dolly zoom. Related-skills pointers. | Weaknesses 10 and 5. Camera: Creator Hub Camera class. The dolly note is a DevForum snippet, but it only warns, it doesn't prescribe a value. |
| .claude/skills/roblox-characters/SKILL.md | Argon-first header. LESSONS wins on faces. FaceControls marked rejected. Section 4 is now the head-clone swap. Added Animation Editor facts (30 fps, CubicV2 not Cubic, loop needs duplicated first keys) and the Edit-mode/no-Animator caveat. | Weakness 4. Animation facts: Creator Hub Animation Editor and dynamic-heads pages. |
| templates/production_manifest_template.md | Ending wording is now "fade only in the ≤0.4 s tail, never hold black". Added a freshness-combo line. Section H gains checks for: spoken `line` per beat, sfx files exist, camera-mode ratio, sound-off, qa_pN.md, and repeated frames. | Weaknesses 8, 11, 3 and 5. |
| templates/beats_template.json | fps 30. Added part, engine and narration fields. rig path is now .rbxm. Shot is named with a camera mode. | Weakness 1. Matches story 007's structure. |
| docs/ARGON_PIPELINE.md | Added official Roblox reference lighting values (LightingStyle Realistic, ExposureCompensation over Brightness, indoor/outdoor/practical-light numbers). ClockTime 16.8 explicitly kept. | Weakness 7. Source: Creator Hub Future-lighting tutorials. |
| .claude/skills/new-story/SKILL.md | Each premise states its combo and the last 5 rows' combos. | Weakness 11. |
| docs/AI_ADAPTERS.md | Fixed the mojibake arrows. | Minor. |

The third-party skills are now referenced from produce-video and cinema-director. The useful parts are: pick the Studio with `list_roblox_studios` and `studio_id`, inventory before editing, clean up temporary parts, label each check as executed, statically checked or not run, and use `task.*` Luau. The parts to ignore are Rojo, selene and play-mode testing, because our engine runs in Edit mode.

## 4. Where the research disagrees with our rules, and which side I kept

| Topic | Research says | Our rule | Kept |
|---|---|---|---|
| Caption position | Centred, 35–50% down the frame (S8, vendor) | Upper or lower third, never dead-centre | **Ours.** It comes from the owner's takes and matches all 12 benchmark reels. |
| Voice speed | 10–15% faster, or 1.3x with pitch change (S8, S17) | Never speed up; split into parts | **Ours.** |
| Capture fps | 1080p60 at 10–15 Mbps (S24, vendor) | Locked 30 fps; the reference shorts are 30 | **Ours.** 30 fps foreground capture solved the judder. |
| Cut rate | Every 2–8 s (S7, S35) | 1.2–2 s, 3 s max | **Ours.** It came from 007 QA and benchmarks. |
| Story beat clock | Rant clock: hook 0–3 s, CTA at 50–60 s (S7) | ENGAGEMENT table: hook 0–1 s, payoff 52–60 s, no CTA | **Ours.** Ours is a story clock, not a rant clock. |
| ClockTime | Official tutorials: 17 outdoor, 15.6 indoor | 16.8 | **Ours.** The official values are recorded as reference only. |
| Faces | Dynamic heads with FACS are the official route | Per-emotion head clones | **Ours.** It was tested and rejected. The docs also say face animations can't be imported. |
| Music | Music at 15–20% or -10 dB | No music mandated; SFX mandatory | Unchanged. Music is a test idea (section 6). |

## 5. Code changes I recommend but did not make

1. **`pipeline/finish_video.py:75`**: change `fps=60` to `fps=30`, and update the docstring at line 4. This fixes weakness 1 and makes the 2% repeated-frame gate valid on the final file. Then update produce-video step 6 to drop the "currently resamples to 60" note.
2. **`pipeline/qa_sheet.py` `beat_starts()`** (lines 18–24): when a beat is not matched, print `WARN beat N dropped: <line>` and exit non-zero (or add `--strict`, default on), so a missing tile can't pass quietly.
3. **`pipeline/finish_video.py` `sfx_cues()`** (lines 25–31): print a warning for each beat whose `sfx` wav is missing or whose first word is unmatched, instead of a silent `continue`.
4. **New flag `pipeline/record_take.py --check <mp4>`** (or a small function there): run the tblend/signalstats command now in LESSONS, print the repeated-frame ratio, and exit non-zero at ≥2%. Today the check is still a manual command.
5. **`pipeline/record_take.py` REGION (line 20)**: before recording, read the Studio window rect (`GetWindowRect` via ctypes) and refuse to record if the viewport height is under 968 px or the region falls outside the window.
6. **`engines/roblox/roblox_look.luau`**: line 6 `ClockTime = 17.3` should become 16.8 (AGENTS rule). Add `pcall(function() Lighting.LightingStyle = Enum.LightingStyle.Realistic end)`. Try EnvironmentDiffuse/SpecularScale = 1 (official), but A/B it first (section 6).
7. **Engine camera modes** (`story007_cutscene.luau` around lines 1277–1284, carried into the next story's engine): add `snapOut` (start tight, ease out to wide over ~0.25 s) and `impactZoom` (FOV punch of ~8° over 0.12 s plus a 2.5° roll added to `ROLL`), selected by a per-beat `mode` field. The push-in currently applies to every shot.
8. **Engine end of Part 2** (lines 1297–1301): the black hold after the finale relies on `--end` to be trimmed. Better to hold the last image, and let the 0.4 s fade be the only darkening.
9. **`pipeline/voice_subs.py:140`**: either document `+8%` as the tuned natural rate in LESSONS, or set it to `+0%`. The owner should decide.

## 6. Experiments worth one test take each

- **Lighting A/B:** current `roblox_look` vs `LightingStyle = Realistic` with EnvironmentDiffuse/Specular 1 and brightening through ExposureCompensation (official). Compare face readability on 3 beat tiles.
- **Caption highlight:** word-by-word colour highlight inside the existing 1–3-word card (vendor sources S7/S8 all show it). Position stays as it is.
- **Quiet music bed** around -10 dB under the voice (S17; weak source). Check the rule still reads and Content ID doesn't flag it.
- **MKV capture and remux** (DevForum snippet) so a Studio crash doesn't lose the take.
- **Hiding UI with Ctrl+Shift+C / Ctrl+Shift+G** (DevForum snippet), if any GUI ever leaks into a take.
- **Before publishing:** set "not made for kids" unless the story targets children, and consider the altered/synthetic disclosure for the AI voice (S37/S11, vendor). Check against YouTube's own policy pages before adding this to PUBLISH.md as a rule.

## 7. What the research did not answer

- Any named Roblox story channel's visual style or production method. No transcripts of the tutorial videos were read.
- Whether Moon Animator 2 can export, and camera-path tooling (DevForum threads didn't load).
- Verified retention data on cut rate, caption style or length. Every number found was a vendor claim.
- Whether R6 works with dynamic heads or the Face Animation Editor (the docs mention R15 only).
- Roblox's own terms for monetised videos of Studio footage.
- Reddit, TikTok and Instagram creator processes (blocked or login-walled).
