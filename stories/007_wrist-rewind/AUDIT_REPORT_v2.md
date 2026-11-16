# Story 007 "Wrist Rewind" - Audit Response v2

Response to external audit **AUDIT-001** ("story007_wristrewind_qa_audit_and_next_story_playbook").

## 1. Summary

- **Status:** All code and rule fixes from AUDIT-001 are done. New takes are recorded in `rec/v2/` (`part1.mp4`, `part2.mp4`).
- **Published finals are NOT yet replaced.** `007_wrist-rewind_part1.mp4` and `007_wrist-rewind_part2.mp4` still hold the old versions.
- **One Part 2 fix is coded but not re-recorded:** the beat at ~17.2s (beaker over Jace's face).

## 2. Claim verification

| Claim (from AUDIT-001) | Verdict | Evidence |
|---|---|---|
| Extras are clones of main cast | CONFIRMED | `audit_v2/01_before_cited_frames.png` (background figures reuse the main cast looks) |
| Bottles/beaker block Jace's face (P1 27.4/29.0, P2 19.2) | CONFIRMED | `audit_v2/01_before_cited_frames.png` (Jace's face hidden behind red bottle and beaker) |
| Hero arm across Mia's neck, P2 38.5 | CONFIRMED | `audit_v2/05a_before_p2_38.5.png`. Our earlier dismissal was wrong; it was based on a coarse 10-frame sheet |
| White-on-white milk | CONFIRMED | `audit_v2/07a_before_milk.png` (white cup against white wall) |
| Aging hands only tinted | CONFIRMED | `audit_v2/08_after_aged_hands.png` shows tint plus faint crease bands; full-size check still pending (see section 5) |
| Caption phrase splits ("OFF FOR HIS", "HE TURNS TO", "DO I SPEND / IT ON HER?") | CONFIRMED | `audit_v2/01_before_cited_frames.png` |
| Whisper count-mismatch bypass in script_lock | CONFIRMED | Fixed in `pipeline/voice_subs.py` (see section 3) |
| No SFX mixed | CONFIRMED | Fixed: `finish_video.py --beats` (see section 3) |
| QA sheet skips shots | CONFIRMED | Fixed: `pipeline/qa_sheet.py` now shows every beat midpoint plus END (see `audit_v2/02`, `03`) |
| Part 1 ends cutting away from Mia | CONFIRMED | Fixed: P1 last beat stays on Mia with shards, no fade (see `audit_v2/06b_after_p1_end.png`) |
| "FOR TAPS" in published P2 | OUTDATED | Already "FOUR TAPS" in `p2/subs.ass` line 62 |
| 2.35s black tail on P1 | OUTDATED | Published P1 is 50.05s; last frame is not black; trimmed with `--end` |
| Selfie flash whiteout | PARTIAL | Not visible at the cited frame, but flash limits were reduced anyway (brightness +0.04, bloom +0.12, light 2.5 range 8) |

## 3. Changes made

| File | Change |
|---|---|
| `pipeline/voice_subs.py` | `script_lock` now aligns with `difflib.SequenceMatcher`, so a count mismatch no longer skips spelling fixes. `chunk_words` never ends a card on a function word (to/into/in/on/of/for/with/at/by/from/the/a/an/my/his/her/our/their/your/and/or/but); the word carries to the next card. New `--subs-only` flag rebuilds subs from existing voice. Self-check: `pipeline/test_voice_subs.py` (passes). |
| `p1/subs.ass`, `p2/subs.ass` | Rebuilt. Examples: "LEANED INTO / WATCH." became "MIA LEANED / IN TO WATCH."; "OFF FOR HIS" became "JACE WAS SHOWING OFF / FOR HIS PHONE,"; "DO I SPEND / IT ON HER?" kept as whole phrases. |
| `pipeline/make_sfx.py` (new) | 12 original SFX synthesized with ffmpeg into `assets/sfx`: whoosh, rewind_zip, skin_creak, shutter, ding, tick, piano_note, bell, glass_clink, pour, hiss_crack, thud. |
| `pipeline/finish_video.py` | `--beats` flag mixes each beat's SFX, snapped to the time its line is actually spoken (from `words.json`). 27 cues in P1, 28 in P2. |
| `pipeline/qa_sheet.py` (new) | One frame per beat midpoint plus an END frame. |
| `pipeline/record_take.py` (new) | Studio in foreground, cursor parked in menu bar, gdigrab 30fps, auto-trim at first non-black frame. |
| `assets/rigs/bystanders_school.luau` (new) | 6 dressed HumanoidDescription extras built from free Roblox catalog items. Old clones deleted. |
| `engines/roblox/story007_cutscene.luau` | Extras no longer cloned. `clearShot()` occlusion guard (raycasts face/chin/torso, moves camera up/sideways) on faceCam, eyeCam and the P2 pouring insert. Props `CanQuery=true`. Flash capped. Red milk cup. Neon/glint shards. Visible age crease bands on Hero/Jace hands. P2 posing beat turn capped at 40 degrees. P2 Mia-smile beat: Hero moved to X=-20.6, camera on Mia's far side. P1 last beat stays on Mia + shards, no fade. Only Part 2 fades. |
| `.claude/agents/render-qa.md` | Uses the beat sheet; explicit fail list. |
| `.claude/skills/produce-video/SKILL.md` | Rewritten with exact commands. |
| `docs/LESSONS_LEARNED.md` | New AUDIT-001 section; corrected the wrong "floating head" note. |
| `docs/ENGAGEMENT_RULES.md` | 3-5 hashtags; Part 1 ends on the endangered person. |
| `stories/007_wrist-rewind/PUBLISH.md` | Hashtags trimmed to 5. |

## 4. Screenshots

### Before (old published cut and audit grid)

- [01_before_cited_frames.png](audit_v2/01_before_cited_frames.png) - 10-cell grid of the cited frames: clone extras, bottles over Jace's face, split captions.
- [05a_before_p2_38.5.png](audit_v2/05a_before_p2_38.5.png) - P2 38.5s: Hero arm across Mia's neck.
- [06a_before_p1_end.png](audit_v2/06a_before_p1_end.png) - P1 49.9s: ends on a hand, cutting away from Mia.
- [07a_before_milk.png](audit_v2/07a_before_milk.png) - P1 8.8s: the cup is held by an old clone extra that looks like Mia (white cup against a white wall).

### After (new takes in rec/v2)

- [02_after_part1_beat_sheet.png](audit_v2/02_after_part1_beat_sheet.png) - Part 1 beat sheet: one frame per beat (B1-B27) plus END, with captions.
- [03_after_part2_beat_sheet.png](audit_v2/03_after_part2_beat_sheet.png) - Part 2 beat sheet: one frame per beat (B1-B28) plus END, with captions.
- [04_new_bystanders.jpg](audit_v2/04_new_bystanders.jpg) - Six new dressed bystanders (distinct hair, outfits and skin tones; not clones of the main cast).
- [05b_after_p2_39.8.png](audit_v2/05b_after_p2_39.8.png) - P2 39.8s: Mia smile shot, Hero moved clear.
- [06b_after_p1_end.png](audit_v2/06b_after_p1_end.png) - P1 49.9s: Mia reacting with shards, no cut-away.
- [07b_after_milk.png](audit_v2/07b_after_milk.png) - P1 8.5s: red-dot milk carton on the new bystander.
- [08_after_aged_hands.png](audit_v2/08_after_aged_hands.png) - P2 11.2s: aged hands with tint and faint crease bands (not yet verified at full size).

## 5. Remaining issues (honest)

- P2 beat at ~17.2s: beaker over Jace's face. Fixed in code, **not re-recorded**.
- P1 B5/B6: beaker still in front of Jace's chest. His face is clear.
- P1 hook opens on a hand, not a face.
- Extras use the plain default face and the classic blocky style. Fine in the blurred background, but not a finished look.
- `.claude/skills/roblox-cinema-director/SKILL.md` still describes the old Blender / 4-frame rules. Update pending.
- Finals not yet replaced.
- Aged-hand crease bands not yet verified at full size (see `audit_v2/08`).

## 6. How to reproduce

Run from `C:\AI-Vid`. Paths in `<angle brackets>` are per-take; check the story folder for the exact filenames.

```
# 1. Rebuild subtitles from the existing voice and words (no re-voicing)
python -I pipeline/voice_subs.py --story-dir stories/007_wrist-rewind --subs-only

# 2. Synthesize the 12 SFX into assets/sfx (skips existing files unless --force)
python -I pipeline/make_sfx.py

# 3. Record a Studio take (foreground, gdigrab 30fps, auto-trim at first non-black frame)
python -I pipeline/record_take.py --seconds <sec> --out stories/007_wrist-rewind/rec/v2/<take>.mp4

# 4. Finish the part: mux voice + subs + beat SFX, cut on the last image
python -I pipeline/finish_video.py --raw <raw.mp4> --part-dir stories/007_wrist-rewind/<p1|p2> \
    --out <final.mp4> --beats <beats_pN.json> --end <sec>

# 5. Beat sheet: one frame per beat midpoint plus END
python -I pipeline/qa_sheet.py --video <final.mp4> --words <words.json> --beats <beats_pN.json> --out <qa_pN.png>
```

`pipeline/test_voice_subs.py` is the self-check for step 1.
