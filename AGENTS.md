# AI-Vid — Rulebook for ANY AI agent (Claude, Gemini, Cursor, Codex, ChatGPT)

This file is the single source of truth. Every agent working in this repo follows it.
**New here? Do `docs/SETUP_GUIDE.md` first** (setup, self-test, full step-by-step loop).
**Before any production: read `docs/LESSONS_LEARNED.md`** (hard-won rules: faces, sets, shots, recording).
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
| 3b. Argon handover | `/new-story` (end) | Zip theme-lock prompt + per-story build prompt + MANIFEST + refs into `audits/ARGON-<NNN>_<date>_<ID>_part1of1.zip` (see docs/ARGON_PIPELINE.md) | low |
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
- Authentic Roblox R6/R15 characters only (imported rigs from `assets/rigs/` first, else exact R6 proportions). No generic primitives.
- Render on GPU: Blender EEVEE (`engines/blender/`) and/or Roblox Studio Future lighting via Studio MCP (`engines/roblox/`). No slideshows, no OpenCV boxes.
- Subtitles lower-third (Y≈82%) or upper-third (Y≈15%) only, 1–3 words per beat. Never dead-center.
- Natural TTS (Edge-TTS `en-US-AndrewNeural`) + Faster-Whisper word timing via `pipeline/voice_subs.py`.
- 4-frame QA (10/40/70/90%) before final render.

## Argon assets + Production Manifest (MANDATORY from story 008)
- **Argon builds all assets** (characters, extras, props, sets, materials, grade presets) to one locked theme/style: `docs/ARGON_PIPELINE.md` (style lock, grade presets, the Argon prompts). The Studio MCP steps below are the **fallback** only.
- **Every story ships `stories/<ID>_<slug>/MANIFEST.md`** from `templates/production_manifest_template.md`, with zero vagueness. It covers:
  - (A) meta
  - (B) every set: what it looks like, coordinates, lighting/grade
  - (C) every character: look, skin hex, **what they do** across the story, **every emotion needed**
  - (D) every asset/mesh: size, material, socket, reuse or new
  - (E) every animation
  - (F) every VFX
  - (G) a beat-by-beat table every ~1.2–2 s covering shot, each character's action, face swaps, props, VFX, SFX and grade
  - (H) the QA checklist
- No production until MANIFEST.md is complete and the verifier passes it. Then Haiku builds the **Argon handover package** for the user (`audits/ARGON-<NNN>_...zip`).
- Story 007 predates this rule (its assets were already built). It needs no manifest or handover.

## Asset process (fallback when Argon can't make it; stored here, loaded into Roblox Studio)
1. **Make** (AI): characters — **main/named characters** via Studio MCP `generate_avatar` (unique, detailed; check they look clean before saving); **bystanders/extras** via a Luau `HumanoidDescription` script (`Players:CreateHumanoidModelFromDescription`) that MUST be fully dressed with real catalog hair, shirt, pants and face (or a full outfit/bundle) — never bare colour-only bodies; vary outfits so crowds don't look cloned. **Never build characters in Blender** (rejected: doesn't look like Roblox); props/buildings via `generate_mesh` / `generate_procedural_model`; surfaces via `generate_texture` / `generate_material`; face decals as PNGs; maps as Luau builder scripts. Toolbox assets (`search_asset`/`insert_asset`) only if free-to-use, logged with source.
2. **Store** (this folder, source of truth): `assets/rigs/` (.rbxm exports), `assets/maps/` (Luau builders + .rbxm), `assets/faces/` (PNG), `assets/sfx/`. Every asset gets a row in `assets/INDEX.md` (path, what, how generated, prompt used). Reuse before generating new.
   **Studio = one job at a time.** Never stack Studio generations or spawn agents to push more of them; a timeout ≠ failure (check Workspace before retrying). Do non-Studio work (voice, subtitles, retiming, SFX, docs) in parallel meanwhile.
3. **Load** into Studio for each story (MCP `execute_luau` / `insert_asset`), animate from beats.json, record.
Roblox Studio is the primary engine; Blender is optional/secondary.

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
