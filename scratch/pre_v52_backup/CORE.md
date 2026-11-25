# AI-Vid V5 — Lean Production Rulebook (Low-Quota Edition)

**Single source of truth.** Read ONLY this file + `config.yaml` before starting a Short. Never scan old story folders, archived docs, or raw search dumps.

## Token-Saving Rules (Strict)
1. **AI writes ONLY `stories/<ID>_<slug>/story.yaml` (~3–5 KB).** Never hand-write `narration.txt`, `beats.json`, `PUBLISH.md`, or 80 KB Luau monoliths—`pipeline/compile_story.py` generates all of them locally at 0 token cost.
2. **Never copy or edit `engines/roblox/core_engine.luau`.** All camera rigs, R6 animations, `setFace()`, 3D badges, anime combat FX, and beat-drop FX live in `core_engine.luau`.
3. **Run local `pipeline/preflight_lint.py` before touching Studio.** Fix any flagged >2.2s static shots, missing SFX, or word-count issues locally in 1 pass.
4. **Model tiering:** Use low-tier models for originality checks & ledger appends; mid/high-tier ONLY for writing `story.yaml`.
5. **Owner-only rules:** Never record until owner says "record". Always record via `pipeline/record_take.py` (locks cursor at `900, 12`). Never modify `CORE.md`, `config.yaml`, `core_engine.luau`, or `pipeline/*.py` unless explicitly directed.

## The 4-Step Fast Loop (~20–30 min per Short)
1. **Author (`story.yaml`):** Pick a template from `templates/formats/`, check `ledger/STORY_LEDGER.md` (no repeated rule/twist), and write `stories/<ID>_<slug>/story.yaml`.
2. **Compile & Voice (0 AI tokens):**
   ```powershell
   python pipeline/compile_story.py --story stories/<ID>_<slug>/story.yaml
   python pipeline/voice_subs.py --story-dir stories/<ID>_<slug>
   python pipeline/preflight_lint.py --story stories/<ID>_<slug>/story.yaml
   ```
   *(For `beat_drop` music-only shorts, skip `voice_subs.py`.)*
3. **Studio Preview:** Serve `engines/roblox` (`python -m http.server 8765 --bind 127.0.0.1`), load `core_engine.luau` + compiled `scenes_<ID>.luau`. Verify cast gender-lock (`boy|girl|man|woman`) and lighting.
4. **Record, Auto-QA & Export (only after owner says "record"):**
   ```powershell
   python pipeline/run_take.py --story-dir stories/<ID>_<slug> --draft
   # Inspect rec/qa_beats.png -> if PASS:
   python pipeline/run_take.py --story-dir stories/<ID>_<slug> --final
   ```

## Viral Quality Gates (Enforced by `preflight_lint.py`)
- **Standalone by default:** Ship complete 30–58s or 1:45–2:30 arcs. No `(Part 1)` / `(Part 2)` splits unless a video already broke 50K views.
- **0–2s Visual Hook:** Frame 1 shows the rule, power, clue, or setup in motion on a bright, high-contrast set.
- **Cut Ceiling:** Max **2.2s** per static shot. Every beat uses camera motion (`push_in`, `orbit360`, `shake`) or an angle swap (`wide`, `closeup`, `ots`).
- **Voice & Captions:** **185–195 WPM**, silences compressed (`0.14s -> 0.05s`), captions anchored in `SafeCenterPop` (`MarginV = 560`) clear of YouTube Shorts' bottom UI.
- **5th-Grade Spoken English:** Short, punchy sentences. Zero formal AI jargon ("permafrost bedrock", "pneumatic", "resonance").
- **Monetization Hygiene:** 100% original Roblox Studio animation for anime fights (never splice raw anime clips). For `beat_drop` shorts, keep ≤60s and attach trending audio via YouTube Shorts' official sound library.

## Supported Channel Playlists (`templates/formats/`)
| Format | Playlist | Length | Voice | Core Hook |
|---|---|---|---|---|
| `story` | In This World Stories | 50–58s or 2:00–2:30 | Yes | Active rule + 15s conflict + shock twist/CTA |
| `anime_fight` | Roblox Anime Fights | 35–55s | Yes | Underdog awakening + impact frames + aura clash |
| `spot_the_lie` | Spot The Lie Mysteries | 40–55s | Yes | Hidden visual clue in frame 1 (130%+ rewatch loop) |
| `beat_drop` | Beat-Drop Edits | 15–28s | No (YT Audio) | Setup → bass-drop lighting flip + synced emote |
| `psychology` | Roblox Mind Rules | 30–45s | Yes | Relatable life/psychology rule via 3D physical metaphor |
| `thought_sim` | What If Simulations | 45–60s | Yes | Real-life physics/survival scenario + comment debate |

## Preserved V4/V5 Reference
- Your renumbered stories (`001`–`003`), sets, casts, `ideas/`, and `ledger/verification/` are preserved in place; start new stories at **`004`**.
- Legacy detailed docs & agent configs are archived in `docs/_archive/` (do not load unless debugging a rare edge case).
