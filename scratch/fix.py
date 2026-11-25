import re,sys
S='scratch/tmp_extract_v5/AI-Vid/.claude/skills/'
D='.claude/skills/'
def go(n,reps):
    t=open(S+n+'/SKILL.md',encoding='utf-8').read()
    for a,b in reps:
        if a not in t: print('MISSING',n,a[:50])
        t=t.replace(a,b)
    open(D+n+'/SKILL.md','w',encoding='utf-8',newline='\n').write(t)
catch='- Follow the **catchiness gates** in `CORE.md`: active rule (not a badge), rule visible in frame 1, 3 planted clues, taboo broken by 25s, rule-of-3 attempts, rule-hack climax, action-echo ending, no moral/lecture lines. Avg >= 8.5, none below 8, every gate passes.'
old_catch=[l for l in open(S+'roblox-characters/SKILL.md',encoding='utf-8').read().split('\n') if l.startswith('- Follow the **catchiness')][0]
wpm_c='- Voice and pacing come from `config.yaml` (Kokoro, 185-195 WPM).'
wpm_old=[l for l in open(S+'roblox-characters/SKILL.md',encoding='utf-8').read().split('\n') if l.startswith('- ~165')][0]
wpm_old2=[l for l in open(S+'roblox-cinema-director/SKILL.md',encoding='utf-8').read().split('\n') if l.startswith('- ~165')][0]
eng_old='- New cutscenes start from `engines/roblox/story001_cutscene.luau`; reset `loco` every frame; no frozen rigs; no wall-clipping or tilted giant-face filler shots.'
eng_new='- Cutscenes run on `engines/roblox/core_engine.luau` (never edit it); it resets `loco` every frame; no frozen rigs; no wall-clipping or tilted giant-face filler shots.'
go('roblox-characters',[
("Studio jobs run ONE at a time (see AGENTS.md).","Studio jobs run ONE at a time (see CORE.md and config.yaml)."),
('this file and AGENTS.md "Asset process" win','this file and CORE.md win'),
("- Per-story **cast builder** = a Luau module like `engines/roblox/cast_001.luau`: a CAST table (catalog ids + skin + default face), `build(name, x, floorY, z, yaw, parent)` and `setFace(model, emotion)`. Write `engines/roblox/cast_<ID>.luau` from MANIFEST section C.",
 "- **Cast flow (V5.3):** story.yaml `cast:` lists name/gender/default_face/pos. `core_engine.luau` builds rigs from it via `Engine.buildRig()` and swaps faces via `Engine.setFace()`. `cast_001.luau` / `cast_002.luau` are reference only for catalog ids and outfit style. `buildRig` adds FLOOR_Y=0.2 automatically (set floors sit at y=0.2; the engine hides the baseplate)."),
("(`setFace(model, beat.face)`)","(`Engine.setFace(model, beat.face)`)"),
("Emotion swap (from beats.json `face`)","Emotion swap (from the story.yaml beat `face`)"),
("Keep the cast builder in `engines/roblox/` and log it in `assets/INDEX.md`.","Cast lives in story.yaml; log any new catalog ids/outfits in `assets/INDEX.md`."),
('(LESSONS "Cutscene code")',"(CORE.md section 1)"),
(old_catch,catch),(wpm_old,wpm_c),(eng_old,eng_new),
("both in `cast_<ID>.luau` and in `cutscene.setup()` before recording.","`core_engine.luau` already disables them; verify in the lineup before recording."),
])
go('roblox-cinema-director',[
("built on the locked R6 catalog characters, our 2D face decals and the per-story MANIFEST.md.","built on the locked R6 catalog characters, our 2D face decals and the per-story story.yaml."),
("Source of truth: `AGENTS.md`, `docs/LESSONS_LEARNED.md` (grade presets still in `docs/ARGON_PIPELINE.md`). The story's spec is `stories/<ID>_<slug>/MANIFEST.md`, section G.",
 "Source of truth: `CORE.md` and `config.yaml`. The story's spec is `stories/<ID>_<slug>/story.yaml` (`cast:` list with name/gender/default_face/pos; beats with face/cam/motion/action/move_to; `set:`)."),
("manifest face names come from that set","story.yaml face names come from that set"),
("per AGENTS.md, and never","per `config.yaml` (captions block), and never"),
("- No robotic TTS. Use Kokoro `am_adam` (`--engine kokoro --kokoro-voice am_adam`) with Faster-Whisper timing via `pipeline/voice_subs.py`.","- No robotic TTS. Voice and pacing come from `config.yaml` (Kokoro, 185-195 WPM) via `pipeline/voice_subs.py`."),
("Camera mix (AGENTS.md)","Camera mix"),
("Section G names the mode per beat; count them before handing the table over.","Each beat's `cam` names the mode; count them before handing it over."),
("(LESSONS)","(CORE.md)"),
("- Use only the grade presets G.n, G.r, G.s, G.h and any defined in the manifest.","- Use only the lighting presets in `core_engine.luau`, set via `lighting:` in story.yaml.\n- Sets: 4 reusable sets `street_day`, `school_yard`, `anime_arena`, `cozy_room` (+ `street_002_winter`); floors sit at y=0.2, the engine hides the baseplate and buildRig adds FLOOR_Y=0.2 automatically."),
("- Run `pipeline/qa_sheet.py` for one frame per beat plus END, then have the `render-qa` agent check every tile against MANIFEST section H and `reference/design_bible/05_*.jpg`.",
 "- QA sheet = `rec/qa_beats.png` from `run_take.py --draft`; have `render-qa` judge every tile against CORE.md section 1 and `reference/design_bible/`."),
(old_catch,catch),(wpm_old2,wpm_c),(eng_old,eng_new),
])
