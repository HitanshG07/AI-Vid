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
ffmpeg -y -f lavfi -i color=c=gray:s=1080x1920:r=60:d=6 stories/_test/raw.mp4
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
- Assign IDs: highest ledger ID + 1, sequential, 3 digits.

### Step 2: Originality check (researcher → verifier). MANDATORY
1. For each premise build ≥ 5 queries:
   - `"in this town" "<rule keyword>" roblox`
   - `"in this world" "<rule keyword>" roblox story`
   - `"<core mechanic>" story` (Reddit r/WritingPrompts, Wattpad, Reedsy)
   - `"<twist keyword>" roblox` (YouTube Shorts / TikTok / Instagram)
   - `"<rule in plain words>" short film OR short story`
2. Researcher runs all of them and records query | engine | top results (title, URL, summary). Real URLs only.
3. Verifier judges: **REJECT if the same world rule OR the same twist exists anywhere** (reworded counts), or it overlaps a ledger row. A generic trope alone is not a reject. Open uncertain URLs to confirm.
4. Write `ledger/verification/<ID>.md` from `templates/verification_template.md`, for PASS and REJECT alike.
5. Update the ledger: PASS → `Verified` + an IDEA_BANK row; REJECT → `REJECTED`.
6. If nothing passes, go back to Step 1 (max 3 rounds).

**No verification file = the story may not be scripted or produced.** Assets may be reused; stories never copied.

### Step 3: Script + beats (showrunner)
Create `stories/<ID>_<kebab-slug>/` containing:
- `script.md` from `templates/script_template.md` (format, style ref, subtitle style, core meaning, narration, SFX cues)
- `narration.txt`: plain narration only, ~150–175 words per ≤60s part (series: narration_p1.txt, narration_p2.txt...), 1st person, no tags
- `beats.json` from `templates/beats_template.json`: a shot every 1.5–2s with camera, face, action, vfx, sfx, line

Follow `docs/ENGAGEMENT_RULES.md`: hook in under 1s, show the rule, make it personal, escalate, a fair twist that uses the rule, a one-line payoff. For a 2-part story, Part 1 ends at peak crisis.

### Step 4: Engagement score (verifier)
Score hook, pacing, twist and payoff 1–10. Average < 8 → give concrete fixes → showrunner rewrites (max 2 rounds). Write the scores into `script.md`. Ledger status → `Scripted`, and remove the premise from IDEA_BANK.

### Step 5: Assets (AI-made → stored here → loaded into Studio)
1. Check `assets/INDEX.md` for anything reusable (characters, map, faces, SFX).
2. Generate what's missing with the Studio MCP tools:
   - characters: `generate_avatar` (authentic R6/R15 look; never generic primitives)
   - props/buildings: `generate_mesh`, `generate_procedural_model`
   - surfaces: `generate_texture`, `generate_material`
   - maps: write a Luau builder script → `assets/maps/<name>.luau`
   - Toolbox (`search_asset` / `insert_asset`): only free-to-use items, with the source logged
3. Export/save each asset into `assets/rigs|maps|faces|sfx/`. Add a row to `assets/INDEX.md`: path, type, description, tool + exact prompt, source/license.

### Step 6: Produce (follow `.claude/skills/produce-video/SKILL.md`)
1. Voice + subtitles (researcher can run it):
   `python pipeline/voice_subs.py --story-dir stories/<ID>_<slug> --style <LowerThirdWhite|LowerThirdYellow|UpperThirdWhite>`
   → voice.mp3, words.json, subs.ass
2. Retime beats.json to the words.json timings.
3. Render in **Roblox Studio** (primary): load the map + characters via MCP (`execute_luau`, `insert_asset`), use `engines/roblox/RobloxStudio_MovieCutscene_Engine.luau` as the base, set `Lighting.Technology = Future`, animate from beats.json, record 1080x1920 at 60fps → `render.mp4`.
   *Blender (optional):* the template in `engines/blender/` is a helper library only. Write `stories/<ID>_<slug>/scene.py` that imports it and builds the scene, then run `blender -b -P stories/<ID>_<slug>/scene.py`.
4. QA (render-qa): extract frames at 10/40/70/90% (`ffmpeg -ss <t> -i render.mp4 -frames:v 1 qa_<n>.png`). Check characters are visible and lit, the camera doesn't clip, and subtitles are off-center and don't cover faces. Fix and re-render until it passes.
5. Mux: `python pipeline/voice_subs.py --story-dir stories/<ID>_<slug> --style <style> --raw-video stories/<ID>_<slug>/render.mp4` → `final.mp4`
6. Ledger status → `Produced`. After upload → `Posted`.

---

## Part 5: Hard rules checklist (verify before saying "done")
- [ ] `ledger/verification/<ID>.md` exists and says PASS
- [ ] Engagement average ≥ 8, recorded in script.md
- [ ] Authentic Roblox characters, no primitives
- [ ] GPU render (Studio Future / Blender EEVEE). No slideshow, no OpenCV
- [ ] Subtitles lower or upper third, 1–3 words per beat
- [ ] 4-frame QA passed
- [ ] New assets logged in `assets/INDEX.md`
- [ ] Ledger status updated

## Part 6: Known issues
- Edge-TTS can fail intermittently → the pipeline retries 4×.
- Faster-Whisper GPU needs `nvidia-cublas-cu12` + `nvidia-cudnn-cu12`; otherwise it runs on CPU (fine for 60s audio).
- Blender 5.x: the template skips compositor bloom (the API moved). Port it if Blender becomes the main engine.
- Custom Claude Code agents/skills appear only after restarting Claude Code in this folder.


## Argon + Production Manifest (from story 008)
Argon builds all assets. Every story's `/new-story` run ends with `MANIFEST.md` and `audits/ARGON-<NNN>_..._part1of1.zip`. Give the zip to Argon: paste 01, then 02, then export to the listed paths. Then run `/produce-video`. Details: docs/ARGON_PIPELINE.md.
