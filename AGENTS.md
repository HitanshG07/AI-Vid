# AI-Vid — Rulebook for ANY AI agent (Claude, Gemini, Cursor, Codex, ChatGPT)

This file is the single source of truth. Every agent working in this repo follows it.
**New here? Do `docs/SETUP_GUIDE.md` first** (setup, self-test, full step-by-step loop).
**Before any production: read `docs/LESSONS_LEARNED.md`** (hard-won rules: faces, sets, shots, recording).
**Picking up work in progress? Read `docs/HANDOFF.md`** (current story status, next steps, today's pitfalls).
**Not Claude Code?** Configure your tool with `docs/AI_ADAPTERS.md` (Antigravity, Codex, Gemini CLI, Cursor, ChatGPT).

## Mission
Produce **original, high-retention Roblox story shorts** (1080x1920, 30 FPS locked, ≤60s per part, ~150–175 words per part at natural speech, 1st-person; multi-part series welcome)
for YouTube Shorts / Instagram Reels / TikTok, as automated as possible, at ₹0 extra cost, on a local
Windows 11 laptop (RTX 4060 8GB, 16GB RAM).

## The 4 golden rules
1. **Stories are never copied.** Every premise (world rule + twist) is web-verified and the evidence is saved in
   `ledger/verification/<ID>.md` before any script is written. Assets (rigs, maps, SFX, faces) may be reused freely.
2. **Engagement first.** Every script follows `docs/ENGAGEMENT_RULES.md` and must score ≥ 8/10 before production.
3. **Meaningful and complete.** Every story has a clear earned meaning and a real ending (series allowed; the final part resolves everything). No filler.
4. **Never repeat.** Check `ledger/STORY_LEDGER.md` — no reused world rule, twist, or core meaning.

## Workflow (same every time)
| Step | Command (Claude Code) | Manual equivalent for other AIs | Tier |
|---|---|---|---|
| 0. Trend refresh (weekly) | researcher agent | Update `ideas/TRENDS.md` with formats/themes booming now | low |
| 1. Brainstorm 3–5 premises | `/new-story` | Read ledger + TRENDS + `ideas/IDEA_BANK.md`, follow freshness brief below | high |
| 2. Originality check | `/verify-originality` | Follow `.claude/skills/verify-originality/SKILL.md` exactly | low + mid |
| 3. Script + beats + **MANIFEST** | `/new-story` (continues) | Fill `templates/script_template.md` + `templates/beats_template.json` + **`templates/production_manifest_template.md` → `stories/<ID>/MANIFEST.md`** | high |
| 3b. Cast builder | `/new-story` (end) | Write `engines/roblox/cast_<ID>.luau` (catalog ids + skin + default face per character) from MANIFEST section C. No Argon handover (retired 2026-11-17) | mid |
| 4. Engagement score | verifier agent | Score with the rubric in `docs/ENGAGEMENT_RULES.md`; <8 → rewrite | mid |
| 5. Produce | `/produce-video <ID>` | Follow `.claude/skills/produce-video/SKILL.md` | mid |
| 6. Log | automatic | Update the story's row status in `ledger/STORY_LEDGER.md` | low |

## Model tiers (use models responsibly)
- **low = Haiku** (or Gemini Flash / GPT-mini): web searching, collecting URLs, file moves, ledger appends, running commands.
- **mid = Sonnet** (or Gemini Pro / GPT standard): judging originality, scoring scripts, render QA, fixing coordinates.
- **high = Opus** (or best available): brainstorming premises, writing final scripts/beats, writing scene code.
Never use a high-tier model for low-tier work. In Claude Code these are enforced by `.claude/agents/*.md`.

## Freshness brief (for brainstorming)
Combine one from each list and rotate — never pick the same combo as the last 5 ledger rows:
- **Rule category:** body/biology · emotions made physical · time · money/value · sound/voice · light/shadow · memory · numbers on people · weather · objects with will · family rituals
- **Emotion core:** grief · sacrifice · honesty · forgiveness · unseen kindness · loneliness · courage · gratitude · jealousy→love
- **Setting:** school · small town · city at night · winter village · hospital · bus/train · farm · apartment block · beach town · medieval village
- **Format:** Standalone (≤60s) or 2-Part (Part 1 ends on a cliffhanger).

## Hard production rules (from benchmarks)
- **Characters (LOCKED 2026-11-17, owner-approved):** classic **R6** Roblox avatars (main AND extras) built in Studio with `Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R6)`, dressed with real community catalog items (see Asset process). Faces are our own flat 2D decals (`assets/faces/classic_v1/`). No R15 default rigs, no Argon/mesh/`generate_avatar`/Blender characters, no generic primitives.
- Render on GPU: Blender EEVEE (`engines/blender/`) and/or Roblox Studio Future lighting via Studio MCP (`engines/roblox/`). No slideshows, no OpenCV boxes.
- Subtitles lower-third (Y≈82%) or upper-third (Y≈15%) only, 1–3 words per beat. Never dead-center.
- Natural TTS (Edge-TTS `en-US-AndrewNeural`) + Faster-Whisper word timing via `pipeline/voice_subs.py`.
- Beat-aligned QA before calling a video done: `pipeline/qa_sheet.py` (one frame per beat + END), checked by render-qa. Uniform 4/10-frame samples are banned (they skipped 63% of shots in story 007; see `docs/LESSONS_LEARNED.md`).
- Capture is a locked 30 fps (`pipeline/record_take.py`). Never record until the user says "record".

## Production rules update (2026-11-16, viral research)
- **Dual-engine rule:** Roblox Studio (MCP) is the primary engine. Blender 4.x/5.x (`bpy`, headless) is allowed alongside it for converting/importing meshes and props, headless 1080x1920 renders, and quick check-picture previews. Blender never *designs* characters; characters are the locked R6 catalog method (Studio).
- **3-mode camera mix:** ~60% slow push-ins, ~25% snap pull-outs (close to wide), ~15% impact snap-zooms with a 2.5° Dutch tilt. Cuts every ~1.2–2 s.
- **Sound-off rule:** the story's world rule must be visible on screen in every shot where it applies (e.g. a counter or number above heads, or aged hands shown), so the video works muted.
- **Light:** the default present-day grade uses `Lighting.ClockTime = 16.8` (low sun, long shadows) and textured surfaces (brick, wood, wainscot), not flat pastel walls.

## Production Manifest (MANDATORY from story 008) — Argon retired 2026-11-17
- **Argon/Gemini no longer builds characters, props or sets.** Every Argon, mesh, `generate_avatar` and Blender character method failed the owner's standard ("look like the Roblox stories out there"). Argon may still be used for optional 2D art only. The Argon handover zip is no longer required (`docs/ARGON_PIPELINE.md` is kept as history).
- **Every story ships `stories/<ID>_<slug>/MANIFEST.md`** from `templates/production_manifest_template.md`, with zero vagueness. It covers:
  - (A) meta
  - (B) every set: what it looks like, coordinates, lighting/grade
  - (C) every character: look, skin hex, catalog item ids, face set, **what they do** across the story, **every emotion needed**
  - (D) every asset: size, material, socket, source (Studio-built / Creator Store / reuse)
  - (E) every animation
  - (F) every VFX
  - (G) a beat-by-beat table every ~1.2–2 s covering shot, each character's action, face swaps, props, VFX, SFX and grade
  - (H) the QA checklist
- No production until MANIFEST.md is complete and the verifier passes it.
- Story 007 predates this rule (its assets were already built). It needs no manifest.

## Asset process (LOCKED 2026-11-17; stored here, loaded into Roblox Studio)
1. **Characters (main AND extras): classic R6 + catalog items + our own face decals.**
   - Build with `Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R6)`. R15 default rigs ignore decal faces, so never R15.
   - Dress with real community catalog items found via `AvatarEditorService:SearchCatalog` (Relevance sort): detailed classic Shirts/Pants, layered hair, themed accessories. They render in Studio without being owned (0 Robux). Pick items that read like the reference shorts (varsity jackets, hoodies, printed tees, swimwear). Never bare default bodies; vary outfits so crowds aren't clones.
   - Faces: our flat 2D transparent PNG decals from `engines/faces/classic_faces.py` into `assets/faces/classic_v1/` (neutral, scared, shocked, grin, determined, proud), uploaded; ids in `assets/faces/classic_v1/ids.json`. An emotion swap = change the Head's `face` Decal Texture. New emotions are added to that script, never taken from free Creator Store decals.
   - Per-story cast builder: a Luau module like `engines/roblox/cast_011.luau` (CAST table of catalog ids + skin + default face; `build(name, x, floorY, z, yaw, parent)`; `setFace(model, emotion)`).
2. **Props, sets, surfaces:** built in Studio from Roblox-native Parts, Terrain and free Creator Store models (inspect every inserted model for scripts; log the source). Maps as Luau builder scripts. Blender only converts/imports meshes. Optional 2D art may come from Argon.
3. **Store** (this folder, source of truth): `assets/rigs/`, `assets/maps/` (Luau builders + .rbxm), `assets/faces/`, `assets/sfx/`. Every asset gets a row in `assets/INDEX.md` (path, what, how made, source). Reuse before making new.
   **Studio = one job at a time.** Never stack Studio jobs or spawn agents to push more of them; a timeout ≠ failure (check Workspace before retrying). Do non-Studio work (voice, subtitles, retiming, SFX, docs) in parallel meanwhile.
4. **Load** into Studio for each story (MCP `execute_luau`), animate from beats.json, record. Roblox Studio is the primary engine; Blender is optional/secondary.

## Folder map
```
ledger/         STORY_LEDGER.md + verification/<ID>.md (evidence)
ideas/          IDEA_BANK.md (verified, unused), TRENDS.md, KIT_STORIES_001-010.md
stories/<ID>_<slug>/  narration.txt, script.md, beats.json, voice.mp3, words.json, subs.ass, final.mp4
templates/      script, beats, verification templates
docs/           ENGAGEMENT_RULES.md
engines/        blender/, roblox/
pipeline/       voice_subs.py
assets/         rigs/ maps/ faces/ sfx/ + INDEX.md
reference/      BENCHMARKS.md (reference videos), ITERATION_LOG.md
archive/        original raw files — do not edit
```

## IDs
Story IDs are 3-digit, sequential, from the ledger (next = highest + 1). Folder: `stories/<ID>_<kebab-slug>/`.
