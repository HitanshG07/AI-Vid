# HANDOFF — current state, for any AI picking this repo up

Last updated 2026-11-17. Read `AGENTS.md` first (rules), then this file (where things stand), then `docs/LESSONS_LEARNED.md` (pitfalls). Tool setup for non-Claude AIs: `docs/AI_ADAPTERS.md`.

## What changed on 2026-11-17 (read before doing anything)
- **Character method is LOCKED (owner-approved):** classic **R6** avatars built in Studio from community **catalog items** (`HumanoidDescription` + `Players:CreateHumanoidModelFromDescription(desc, R6)`, 0 Robux) with **our own flat 2D faces** (`engines/faces/classic_faces.py` → `assets/faces/classic_v1/`, image ids in `ids.json`). Per-story cast builder: `engines/roblox/cast_<ID>.luau` (example `cast_001.luau`). Children are scaled with `Model:ScaleTo` (0.75). Argon/Gemini, `generate_avatar`, Blender characters and mesh kits are **retired** — they failed the owner's standard.
- **Sets** are built in Studio from parts, Terrain and free Creator Store models. Free models can hide scripts even when the listing says "No scripts" — delete every `LuaSourceContainer` after inserting.
- **Owner rules added today:** show work in the Studio viewport (not screenshots); after every take reset the camera (fresh Camera instance); the recorder locks the mouse at the top during a take; every story must be complete with an earned meaning; captions upper/lower third.
- Research and decisions behind all this: `docs/REFERENCE_STUDY_2026-11-17.md`, `docs/ADOPTION_GUIDE_2026-11-17.md` (D1/D2 decided), `docs/HARDENING_REPORT_2026-11-17.md`.

## Story 001 "The Glow You Get for Being Brave" — status
| Step | State | Where |
|---|---|---|
| Premise + originality | PASS | `ideas/PREMISES_008_2026-11-17.md` (P4; file name is wrong, ID is 001), `ledger/verification/001.md` |
| Script, beats (48), engagement | PASS 8.0 after Revision 1 | `stories/001_brave-glow/script.md`, `beats.json`, `narration.txt` |
| Voice + word timings | done (52.1 s) | `voice.mp3`, `words.json`, `subs.ass` |
| MANIFEST | PASS | `stories/001_brave-glow/MANIFEST.md` |
| Set | built in Studio (`workspace.Set_Beach001`, x≈548–760, z≈−560…−270; sand y≈8.02, water y=5.4, deep water to the shore at x≈597) | place NOT yet saved — run `save_place` / File→Save once take 4 is accepted |
| Cast | built (`workspace.Cast_001`, 11 rigs) | `engines/roblox/cast_001.luau` = `ServerStorage.Cast001` |
| Engine | reworked after audit 3 | `engines/roblox/story001_cutscene.luau` |
| Takes | 1–10 recorded (audits: `rec/audit3_report.md`, `rec/audit4_report.md`) | `rec/` |
| **FINAL (owner-approved)** | **take 10** — front-crawl swim, calmer walk/run, Kai hair fixed by pixel-edge keepers, bell glow disc removed, noise-bed SFX muted | `stories/001_brave-glow/001_brave-glow_FINAL.mp4` (52.3 s) |
| Known flaw in final | Rosa's hair flashes white ~0.2 s at 16.8 s (cause unknown; not texture loading, not the hair item) | — |

## Channel
YouTube channel **StudVerse Tales** (@StudVerseTales). Everything for the channel and per-video uploads (description, keywords, upload template, story 001 title/description) is in `branding/CHANNEL.md`; banner + profile art in `branding/` (regenerate with `python branding/make_branding.py`).

## Status 2026-11-20
Story 003 ("In This Freezing Town, Every Tear Turns Into a Glass Key") is **PRODUCED, FINALIZED & PACKAGED**:
- **Published Deliverables (2-Part Series Release):**
  - **Part 1:** `stories/003_glass-key-tears/003_tears_to_glass_keys_part1.mp4` (114.57s, 1080x1920, ends on peak crisis cliffhanger with spoken outro hook "Watch Part 2 to see how he saved her" and animated cyan/white LowerThird CTA). Thumbnail: `thumbnail_part1.jpg`.
  - **Part 2:** `stories/003_glass-key-tears/003_tears_to_glass_keys_part2.mp4` (93.33s, 1080x1920, starts on panicking crowd, Bram fake keys crumbling, and resolves with Dad's watch ticking again as love brings them home). Thumbnail: `thumbnail_part2.jpg`.
- **Approved Take:** `stories/003_glass-key-tears/rec/take14.mp4` with QA sheet `qa_beats_take14.png` and report `qa_take14.md`.
- **Roblox Studio Place:** Persisted and saved to Roblox Cloud Version 12 with full cutscene auto-loader in `Workspace.Script` and `ServerStorage.Story003Cutscene`.
- **Publishing Package:** Fully documented with copy-paste metadata for YouTube Shorts, TikTok, and Instagram Reels in `stories/003_glass-key-tears/PUBLISH.md`.
- **Disk & Scratch Cleanup:** All draft takes 1–13 (>9 GB) and intermediate scratch audio/video/luau files deleted; repo is clean.
- **Rules Locked:**
  1. Standard continuous BGM across all reels: `assets/sfx/roblox-story-bg.mp3` (`--bgm roblox-story-bg.mp3 --bgm-gain 0.14`). Static/noise beds banned.
  2. Multi-part series: Part 1 hard-cuts on danger with spoken outro hook + LowerThird CTA. Part 2 delivers full action-echo payoff.
  3. Studio Cloud Saves: always execute `save_place` to save cloud version history after building or updating sets/casts.
  4. Zero em dashes (`—` or `–` or `--`) across all scripts, subtitles, and publish copy.

## Status 2026-11-18
Story 001 is **DONE** (owner-approved final = take 10, `stories/001_brave-glow/001_brave-glow_FINAL.mp4`). The steps below are kept as the record of how it was finished; the next job is **story 004** via `/new-story` (or `.claude/skills/new-story/SKILL.md`), reusing `engines/roblox/story001_cutscene.luau` and `cast_001.luau` as templates and running `engines/roblox/texture_keepers.luau` before every take.

## Next steps (in order) — story 001 record
1. Finish the pre-record QA in `rec/qa_take4_pre.md` until every beat has a PASS from a preview taken after its last edit.
2. Record take 4 (procedure below), finish it, then run a fresh **frame-by-frame audit** (render-qa / mid-tier model) at 4 fps contact sheets + 30 fps strips, checking every category in `rec/audit3_report.md` (hair/clothes popping, poses, water, eyeline, camera, glow rule, faces, captions, colour/rendering/physics, stutters). Fix and repeat until clean, then show the owner.
3. Owner sign-off → save the Studio place, set the ledger row to Produced, commit.
4. Known open items: no `scream_child`/`giggle` SFX (voices can't be synthesised well — find a licence-free source or drop them); Milo's face reads pale in dark storm water (decals ignore lighting).

## How to run the Studio engine (any AI with Roblox Studio MCP)
1. Load: send the **entire** text of `engines/roblox/story001_cutscene.luau` as one `execute_luau` call (Edit datamodel). It sets `_G.Story001`. Then `_G.Story001.setup()`.
2. Check a beat: `_G.Story001.preview(n)` (n = 1…48). Captures are rolled 90° (world up = right side) because the final video is vertical.
3. Take: `game.Lighting.Grade.Brightness = -1` → `python pipeline/record_take.py --seconds 62 --out stories/001_brave-glow/rec/takeN_p1_raw.mp4` (background; brings Studio forward, locks the mouse) → ~2 s later `task.spawn(_G.Story001.play, 1)` → when the recorder exits `_G.Story001.resetCamera()`.
4. Finish: `python pipeline/record_take.py --trim <raw> --out <take>`; repeated-frame check (LESSONS "Recording"); `python pipeline/finish_video.py --raw <take> --part-dir stories/001_brave-glow --out stories/001_brave-glow/001_brave-glow_takeN.mp4 --lead 0.3 --end 53.1 --beats stories/001_brave-glow/beats.json`.
5. Only record when the owner has said to (`record`).

## Pitfalls that cost hours today (also in LESSONS)
- **Owner-only changes (2026-11-18):** never change the workflow, rules, skills, agents, templates, pipeline scripts, engine code, cast/face assets or ledger rows, and never delete or move files, unless the owner explicitly directs that specific change. A trial run once deleted a whole story folder and edited the ledger unasked. Propose changes and wait.
- **Never put a `--` comment in the middle of a Luau expression** (e.g. `a or -- note b`): it comments out the rest of the line. Several engine reloads failed this way.
- R6 catalog rigs **pivot on the Head** (PrimaryPart = Head): tilting a model rotates it around the head. Don't build lying/sitting/swimming poses by tilting; keep characters upright (swim = upright chest-deep).
- Use real R6 AnimationTracks (`Animator:StepAnimations(dt)` each frame in Edit mode) for walk/run/idle; hand-built limb swings look stiff.
- Don't hide characters by transparency or park them far away — textures reload late (white hair, missing clothes). Keep them visible somewhere off-camera nearby, AND run `engines/roblox/texture_keepers.luau` right before every take (pixel-edge ViewportFrame copies keep textures loaded; proven on story 001 take 8).
- Highlight fill tints hair/clothes: outline only.
- The Studio MCP's `execute_luau` can force the camera back to Scriptable, which locks the owner's viewport; `resetCamera()` swaps in a fresh Camera.
- Free face decals are mostly unusable (opaque/fake-checker backgrounds); draw faces with `engines/faces/classic_faces.py`.
- A Creator Store Decal id is not its image id: resolve with `game:GetObjects("rbxassetid://<id>")[1].Texture`.

## Model tiers
low (Haiku / Gemini Flash / GPT-mini): searching, running commands, reloading the engine. mid (Sonnet / Gemini Pro / GPT standard): originality judging, scoring, Studio QA, frame audits. high (Opus / best available): premises, scripts, beats, engine/scene code.


## v2 rules (2026-11-19, owner-approved)
- Follow the **catchiness engine** in `docs/ENGAGEMENT_RULES.md`: active rule (not a badge), rule visible in frame 1, 3 planted clues, taboo broken by 25s, rule-of-3 attempts, rule-hack climax, action-echo ending, no moral/lecture lines. Avg >= 8.5, none below 8, every gate passes.
- ~165–180 words per part (default voice preset `viral_storyteller`).
- Every cast entry declares `gender` (boy/girl/man/woman); all clothing, hair and accessories must match it.
- New cutscenes start from `engines/roblox/story001_cutscene.luau`; reset `loco` every frame; no frozen rigs; no wall-clipping or tilted giant-face filler shots.
- **Mouse lock (owner rule):** every take is recorded ONLY via `pipeline/record_take.py`, which locks the cursor at the top menu bar (900,12) for the whole take and releases it after; never record any other way, never move or unlock the mouse during a take, and never park it at the bottom/corners (taskbar pops up).

## Status (2026-11-19)
- Story 002 "Footsteps Glow With Heat" is **Produced**. Final: `stories/002_heat-footsteps/002_heat-footsteps_FINAL.mp4`.
- Voice: Kokoro `am_adam` (`--engine kokoro`). Finishing uses `--lead 1.1`.
- Next story is **004**.

