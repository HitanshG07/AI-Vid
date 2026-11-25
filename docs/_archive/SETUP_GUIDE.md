# AI-Vid Setup & Operating Guide (for any AI agent)

You are an AI agent (Claude, Gemini, Cursor, Codex, ChatGPT, etc.) working in `C:\AI-Vid`.
Follow this guide top to bottom. Do not skip steps. If a check fails, stop and tell the user what failed.
The rules you must obey while working are in `AGENTS.md`; this guide is how to get set up and run the loop.

---

## Part 1: One-time machine setup

Run each check. Only install what is missing.

| # | Check (PowerShell) | If missing |
|---|---|---|
| 1 | `python --version` (need 3.10+) | `winget install -e --id Python.Python.3.11` |
| 2 | `ffmpeg -version` | `winget install -e --id Gyan.FFmpeg` |
| 3 | `git --version` | `winget install -e --id Git.Git` |
| 4 | `Test-Path "C:\Program Files\Blender Foundation\Blender 5.3\blender.exe"` (optional engine) | `winget install -e --id BlenderFoundation.Blender` (needs admin) |
| 5 | `python -c "import edge_tts, faster_whisper"` | `python -m pip install -r requirements.txt` |
| 6 | (optional, GPU transcription) | `python -m pip install nvidia-cublas-cu12 nvidia-cudnn-cu12` |

Shortcut: `powershell -ExecutionPolicy Bypass -File setup.ps1` does steps 2, 4, 5. Run it from an admin PowerShell.

**Roblox Studio (primary engine):**
1. Install Roblox Studio and sign in.
2. In Studio: Assistant → `...` → Manage MCP Servers → enable **"Studio as MCP server"**.
3. Connect your AI client to the Studio MCP server. Claude Code already has it. For other clients, add the Roblox Studio MCP server in that client's MCP settings.
4. Check: with Studio open, call the MCP tool `get_studio_state`. It must respond.

**Pipeline self-test (must pass before any real work):**
```powershell
ffmpeg -y -f lavfi -i color=c=gray:s=1080x1920:r=30:d=6 stories/_test/raw.mp4
python pipeline/voice_subs.py --story-dir stories/_test --text "In this town, every shadow has real weight." --raw-video stories/_test/raw.mp4
ffmpeg -y -ss 1.5 -i stories/_test/final.mp4 -frames:v 1 stories/_test/qa.png
```
Open `qa.png`. Pass = yellow uppercase words in the **lower third**, not the center.
Note: Edge-TTS sometimes returns no audio. The script retries automatically. If CUDA DLLs are missing, it falls back to CPU automatically.

---

## Part 2: Know the files (read these first, every session)

| File | Why |
|---|---|
| `AGENTS.md` | The rules. Golden rules, model tiers, freshness brief, asset process. |
| `ledger/STORY_LEDGER.md` | Every story ever pitched, with its status. Never repeat a rule, twist or meaning. |
| `ideas/IDEA_BANK.md` | Verified, unused premises. Use these first. |
| `ideas/TRENDS.md` | What formats/themes are booming now. |
| `docs/ENGAGEMENT_RULES.md` | Script structure + the scoring rubric (≥ 8 to produce). |
| `assets/INDEX.md` | Every reusable asset. Reuse before generating. |
| `templates/` | Shapes for script, beats.json, verification files. |
| `.claude/skills/*/SKILL.md` | Step-by-step workflows (plain markdown; any AI can follow them). |
| `.claude/agents/*.md` | Role prompts for researcher / verifier / showrunner / render-qa. |

---

## Part 3: Model tiers (use the cheapest model that can do the job)

| Role | Tier | Claude | Gemini | OpenAI | Does |
|---|---|---|---|---|---|
| researcher | low | Haiku | Flash | mini | web searches, URL collection, file moves, ledger edits, running commands |
| verifier | mid | Sonnet | Pro | standard | originality verdicts, engagement scoring |
| render-qa | mid | Sonnet | Pro | standard | inspect frames, fix camera/subtitle coordinates |
| showrunner | high | Opus | Pro (best) | best | brainstorm premises, write scripts, beats.json, scene code |

- **Claude Code:** spawn the agent by name (`researcher`, `verifier`, `render-qa`, `showrunner`). The model is pinned in its file.
- **Other AIs without sub-agents:** read the matching `.claude/agents/<role>.md` and act as that role. If you can choose models, follow the tier column. If not, do the work yourself but keep the steps.

---

## Part 4: The production loop (repeat for every video)

### Step 0: Trend refresh (weekly, researcher)
Search for formats/themes currently booming in Roblox story shorts ("in this town", "in this world", 2-part survival, underdog stat counters...). Append to `ideas/TRENDS.md`: date, platform, format/theme, an example account (for style only), notes. Never record a specific story to copy.

### Step 1: Pick or brainstorm (showrunner)
- If `ideas/IDEA_BANK.md` has an unused premise and the user didn't ask for new ideas, offer it.
- Else brainstorm 3–5 premises. Each has a title, world rule, twist, core meaning, format, and 3 search keywords.
- Use the freshness brief in `AGENTS.md`: one rule category + one emotion + one setting. The combo must differ from the last 5 ledger rows.
- Premises have no ID yet (use a short slug). A premise gets a story ID only when it is chosen for production: highest ID in the ledger's Stories table + 1, 3 digits, starting at 001, never reused.

### Step 2: Originality check (researcher → verifier). MANDATORY
1. For each premise build ≥ 5 queries:
   - `"in this town" "<rule keyword>" roblox`
   - `"in this world" "<rule keyword>" roblox story`
   - `"<core mechanic>" story` (Reddit r/WritingPrompts, Wattpad, Reedsy)
   - `"<twist keyword>" roblox` (YouTube Shorts / TikTok / Instagram)
   - `"<rule in plain words>" short film OR short story`
2. Researcher runs all of them and records query | engine | top results (title, URL, summary). Real URLs only.
3. Verifier judges: **REJECT if the same world rule OR the same twist exists anywhere** (reworded counts), or it overlaps a ledger row. A generic trope alone is not a reject. Open uncertain URLs to confirm.
4. Write `ledger/verification/ideas/<slug>.md` from `templates/verification_template.md`, for PASS and REJECT alike.
5. Update the ledger: PASS → a "Verified ideas" row (`Verified`) + an IDEA_BANK row; REJECT → a "Verified ideas" row (`REJECTED`).
6. If nothing passes, go back to Step 1 (max 3 rounds).

**No verification file = the story may not be scripted or produced.** Assets may be reused; stories never copied.

### Step 3: Script + beats (showrunner)
Create `stories/<ID>_<kebab-slug>/` containing:
- `script.md` from `templates/script_template.md` (format, style ref, subtitle style, core meaning, narration, SFX cues)
- `narration.txt`: plain narration only, ~150–175 words per ≤60s part (series: narration_p1.txt, narration_p2.txt...), 1st person, no tags
- `beats.json` from `templates/beats_template.json`: a shot every 1.2–2s with camera, face, action, vfx, sfx, line

Follow `docs/ENGAGEMENT_RULES.md`: hook in under 1s, show the rule, make it personal, escalate, a fair twist that uses the rule, a one-line payoff. For a 2-part story, Part 1 ends at peak crisis.

### Step 4: Engagement score (verifier)
Score hook, pacing, twist and payoff 1–10. Average < 8 → give concrete fixes → showrunner rewrites (max 2 rounds). Write the scores into `script.md`. Ledger status → `Scripted`, and remove the premise from IDEA_BANK.

### Step 4b: MANIFEST + cast builder (showrunner, verifier)
Follow `.claude/skills/new-story/SKILL.md` steps 5b–6c: `MANIFEST.md`, the verifier's manifest gate, then the cast builder `engines/roblox/cast_<ID>.luau` (locked R6 catalog method, AGENTS.md Asset process). Argon is retired for characters/props/sets (2026-11-17). Log every asset in `assets/INDEX.md`.

### Step 5: Produce
Follow `.claude/skills/produce-video/SKILL.md` exactly. It is the only production procedure (voice, SFX, Studio setup, 30 fps record on the user's command, `finish_video.py`, beat-aligned QA). An earlier version of this guide had its own steps (60 fps render, 4-frame QA, muxing with `voice_subs.py --raw-video`); those were superseded and must not be used, because they skip the SFX mix, the lead-in shift, the end trim and beat QA.

### Step 6: Log
Ledger status → `Produced`. After upload → `Posted`.

---

## Part 5: Hard rules checklist (verify before saying "done")
- [ ] `ledger/verification/<ID>.md` exists and says PASS
- [ ] Engagement average ≥ 8, recorded in script.md
- [ ] Authentic Roblox characters, no primitives
- [ ] GPU render (Studio Future / Blender EEVEE). No slideshow, no OpenCV
- [ ] Subtitles lower or upper third, 1–3 words per beat
- [ ] MANIFEST.md passed the verifier's manifest gate
- [ ] Beat-aligned QA passed and saved (`rec/qa_pN.md`: per-beat PASS, repeated frames <2%, captions spelled per the script)
- [ ] New assets logged in `assets/INDEX.md`
- [ ] Ledger status updated

## Part 6: Known issues
- Edge-TTS can fail intermittently → the pipeline retries 4×.
- Faster-Whisper GPU needs `nvidia-cublas-cu12` + `nvidia-cudnn-cu12`; otherwise it runs on CPU (fine for 60s audio).
- Blender 5.x: the template skips compositor bloom (the API moved). Port it if Blender becomes the main engine.
- Custom Claude Code agents/skills appear only after restarting Claude Code in this folder.


## Production Manifest + cast builder (from story 008)
Characters are classic R6 avatars with catalog items and our 2D face decals; sets come from Studio parts and Creator Store models. Every story's `/new-story` run ends with `MANIFEST.md` and `engines/roblox/cast_<ID>.luau`. No Argon zip (retired 2026-11-17; history in docs/ARGON_PIPELINE.md). Then run `/produce-video`.
