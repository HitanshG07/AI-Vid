"""AI-Vid V6.0 Automated Test Suite + 4 Deliberate-Failure QA Fixtures.

Runs 100% locally (0 AI tokens) to verify:
  1. SQLite state machine & quota_log.csv telemetry
  2. 3-Model Judge != Writer exclusion logic
  3. All 4 deliberate-failure fixtures (bad manifest asset, last-30 sameness hit, audio silence/WER fail, bad render res/black)
  4. Post-upload raw capture purger & 14-day quarantine video pruner
"""
from __future__ import annotations
import json, os, subprocess, sys, tempfile, time
from pathlib import Path
import yaml

sys.path.insert(0, str(Path(__file__).resolve().parent))
import db as db_mod
import qa_gate
import upload_queue
import story_gen


def make_valid_story(ep_id: str, title: str, rule_type="curse", opening="consequence_first", ending="ironic_flip") -> dict:
    beats = []
    for i in range(1, 17):
        beats.append({
            "dur": 2.0, "cam": "closeup" if i % 2 else "ots", "motion": "push_in",
            "target": "Hero", "action": "idle" if i % 3 else "walk", "face": "shocked",
            "speaker": "boy" if i % 3 == 0 else "narrator",
            "sfx": "whoosh" if i in (1, 5, 10, 15) else "",
            "with": [{"name": "Friend", "action": "wave", "face": "scared"}] if i in (2, 7, 12) else [],
            "line": f"Beat {i} shows the *rule* clearly." if i == 1 else f"Step {i} raises the *stakes* fast.",
        })
    return {
        "id": ep_id, "format": "story", "set": "school_yard", "title": title,
        "description": "One clear rule flips everything.", "bgm_mood": "mystery", "lighting": "day_bright",
        "engine": "ironic_reframe", "rule_type": rule_type, "opening_variant": opening, "ending_type": ending,
        "rule": "Unfinished homework walks away at sunset.",
        "visible_proof": "A half-folded paper boat sails down the hall.",
        "personal_stake": "My sister's note to dad is inside the boat.",
        "motivated_choice": "I sprint past the janitor to fold the last corner.",
        "rule_payoff": "Finishing the last fold freezes the boat right before the drain.",
        "cta": "Would you finish it or let it sail?",
        "cast": [
            {"name": "Hero", "gender": "boy", "default_face": "neutral", "pos": [0, 0, 4], "yaw": 180},
            {"name": "Friend", "gender": "girl", "default_face": "neutral", "pos": [3, 0, 4], "yaw": 180},
        ],
        "beats": beats,
    }


def run_tests():
    tmp = Path(tempfile.mkdtemp(prefix="aivid_v6_test_"))
    manifest = json.loads((Path(__file__).resolve().parent.parent / "assets" / "manifest.json").read_text(encoding="utf-8"))
    cfg = {
        "video": {"width": 1080, "height": 1920, "fps": 30},
        "automation": {
            "qa": {
                "min_sec": 35.0, "max_sec": 58.5, "lufs_target": -14.0, "lufs_tol": 1.8,
                "max_true_peak_db": -1.0, "max_silence_sec": 1.5, "max_asr_wer": 0.10,
                "max_freeze_pct": 2.0, "max_black_sec": 0.35, "sameness_window": 30, "max_premise_jaccard": 0.42,
            }
        }
    }
    (tmp / "assets").mkdir()
    (tmp / "assets" / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    db = db_mod.PipelineDB(tmp / "ledger" / "pipeline.db", tmp / "ledger" / "quota_log.csv")

    # 1. Test SQLite state machine + quota log
    db.upsert_episode("010", "paper-boat", str(tmp / "stories" / "010_paper-boat"),
                      title="Unfinished Paper Boat", rule_type="curse", opening_variant="consequence_first", ending_type="ironic_flip")
    db.log_quota("010", "writer", "gemini_flash", "gemini-2.5-flash", 1200, 900, "ok")
    db.log_quota("010", "judge", "groq", "llama-3.3-70b-versatile", 950, 120, "ok")
    q = db.summarize_quota("010")
    assert q["calls"] == 2 and q["input_tokens"] == 2150 and (tmp / "ledger" / "quota_log.csv").exists()
    print("[PASS] Test 1: SQLite state machine & quota_log.csv")

    # 2. Fixture A: Missing/invalid manifest set & banned SFX -> MUST FAIL Gate 1
    bad_a = make_valid_story("011", "Bad Set Story")
    bad_a["set"] = "nonexistent_mars_base"
    bad_a["beats"][0]["sfx"] = "crowd_cheer"  # banned muted SFX
    errs_a = qa_gate.check_manifest_and_sameness(bad_a, manifest, [], cfg["automation"]["qa"])
    assert any("Unknown set" in e for e in errs_a) and any("inactive/banned sfx" in e for e in errs_a), errs_a
    print("[PASS] Fixture A: Invalid set & banned SFX blocked by Gate 1")

    # 3. Fixture B: Last-30 sameness violation (same rule_type + opening + ending >= 3 times) -> MUST FAIL Gate 1
    recent = [
        {"episode_id": "001", "title": "Alpha", "rule_type": "curse", "opening_variant": "consequence_first", "ending_type": "ironic_flip"},
        {"episode_id": "002", "title": "Beta", "rule_type": "curse", "opening_variant": "consequence_first", "ending_type": "ironic_flip"},
        {"episode_id": "003", "title": "Gamma", "rule_type": "curse", "opening_variant": "consequence_first", "ending_type": "ironic_flip"},
    ]
    bad_b = make_valid_story("012", "Fourth Identical Pattern")
    errs_b = qa_gate.check_manifest_and_sameness(bad_b, manifest, recent, cfg["automation"]["qa"])
    assert any("Channel sameness limit hit" in e for e in errs_b), errs_b
    print("[PASS] Fixture B: Channel-wide last-30 sameness blocked by Gate 1")

    # 4. Fixture C: ASR round-trip WER failure (>10%) & missing voice.mp3 -> MUST FAIL Gate 2
    wer = qa_gate.word_error_rate("in this town every promise glows red", "in this clown very promise blows bread")
    assert wer > 0.10, f"Expected WER > 0.10, got {wer}"
    sdir_c = tmp / "stories" / "013_missing_audio"
    sdir_c.mkdir(parents=True)
    ok_c, errs_c, _ = qa_gate.run_audio_gate(sdir_c, cfg)
    assert not ok_c and "Missing voice.mp3" in errs_c
    print(f"[PASS] Fixture C: ASR WER ({wer:.0%}) & missing audio blocked by Gate 2")

    # 5. Fixture D: Wrong resolution + black frames MP4 (generated via ffmpeg) -> MUST FAIL Gate 3 & Quarantine
    sdir_d = tmp / "stories" / "014_bad_render"
    sdir_d.mkdir(parents=True)
    bad_mp4 = sdir_d / "014_FINAL.mp4"
    subprocess.run([
        "ffmpeg", "-y", "-loglevel", "error",
        "-f", "lavfi", "-i", "color=c=black:s=640x480:r=24:d=2",
        "-f", "lavfi", "-i", "anullsrc=r=48000:cl=stereo", "-t", "2",
        "-c:v", "libx264", "-c:a", "aac", str(bad_mp4)
    ], check=True)
    ok_d, errs_d, _ = qa_gate.run_render_gate(bad_mp4, cfg)
    assert not ok_d and any("Resolution 640x480" in e for e in errs_d) and any("black frames" in e for e in errs_d), errs_d
    qa_gate.quarantine_episode(sdir_d, tmp, "render", errs_d, db, "010")
    assert (tmp / "quarantine" / "014_bad_render" / "failure.json").exists()
    assert db.get_episode("010")["status"] == "QUARANTINED"
    print("[PASS] Fixture D: Bad resolution/black frames blocked by Gate 3 & quarantined")

    # 6. Storage hygiene: raw purge & 14-day quarantine MP4 pruner (keeps failure.json)
    rec = sdir_d / "rec"
    rec.mkdir()
    (rec / "raw.mp4").write_bytes(b"0" * 1024)
    (rec / "trimmed.mp4").write_bytes(b"0" * 1024)
    assert upload_queue.purge_raw_captures(sdir_d) == 2048 and not (rec / "raw.mp4").exists()

    q_mp4 = tmp / "quarantine" / "014_bad_render" / "014_FINAL.mp4"
    old_ts = time.time() - (20 * 86400)
    os.utime(q_mp4, (old_ts, old_ts))
    freed = upload_queue.prune_quarantine_videos(tmp, retention_days=14)
    assert freed > 0 and not q_mp4.exists() and (tmp / "quarantine" / "014_bad_render" / "failure.json").exists()
    print("[PASS] Test 6: Post-upload raw purge & 14-day quarantine pruner verified")

    db.close()

    # 7. Inbox ingest: Judge == Writer rejected, valid pair registered as GENERATED
    inbox = tmp / "stories" / "_inbox"
    inbox.mkdir(parents=True)
    for name, w, j in (("same", "claude-opus", "Claude-Opus"), ("good", "gemini-pro", "codex-gpt")):
        (inbox / f"{name}.yaml").write_text(yaml.safe_dump(make_valid_story("x", f"{name} story")), encoding="utf-8")
        (inbox / f"{name}.judge.json").write_text(json.dumps(
            {"writer_model": w, "judge_model": j, "scores": {}, "mean_score": 8.5, "pass": True}), encoding="utf-8")
    made = story_gen.ingest(inbox, root=tmp, db_path=tmp / "ledger" / "pipeline.db")
    assert len(made) == 1 and made[0][1] == "good-story", made
    assert (inbox / "_rejected" / "same.reason.txt").exists() and (inbox / "_done" / "good.yaml").exists()
    db = db_mod.PipelineDB(tmp / "ledger" / "pipeline.db", tmp / "ledger" / "quota_log.csv")
    assert db.get_episode(made[0][0])["status"] == "GENERATED"
    db.close()
    print("[PASS] Test 7: Inbox ingest rejects Judge == Writer, registers valid pair")

    # 8. V6 engine defaults: named spots resolve, unknown spots / emoji badges fail Gate 1, light_flash_red allowed
    import compile_story
    st = make_valid_story("016", "Spot Story")
    st["set"] = "cozy_room"
    st["cast"][0]["spot"] = "center_rug"; st["cast"][0].pop("pos")
    st["beats"][1]["spot"] = "in_front_of_desk"
    st["beats"][2]["fx"] = "light_flash_red"
    compile_story.resolve_spots(st, manifest)
    assert st["cast"][0]["pos"] == [0, 0, 1] and st["beats"][1]["move_to"] == [-9, 0, -9.6], st["cast"][0]
    assert not [e for e in qa_gate.check_manifest_and_sameness(st, manifest, [], cfg["automation"]["qa"])
                if "spot" in e or "badge" in e or "fx" in e]
    bad = make_valid_story("017", "Bad Spot Story")
    bad["set"] = "cozy_room"; bad["beats"][0]["spot"] = "on_the_moon"; bad["beats"][1]["badge"] = "skull"
    errs8 = qa_gate.check_manifest_and_sameness(bad, manifest, [], cfg["automation"]["qa"])
    assert any("Unknown spot" in e for e in errs8) and any("badge 'skull'" in e for e in errs8), errs8
    print("[PASS] Test 8: Named spots resolve; unknown spot + emoji badge blocked by Gate 1")

    # 9. Show-don't-tell + cast targets: named props/events need a prop/kit/fx; beat targets must be cast
    told = make_valid_story("018", "Invisible Props")
    told["beats"][0]["line"] = "My *phone* buzzed as a basketball hit the banner."
    told["beats"][1]["target"] = "Ghost"
    e9 = qa_gate.check_manifest_and_sameness(told, manifest, [], cfg["automation"]["qa"])
    assert any("phone" in e for e in e9) and any("basketball" in e for e in e9) and any("banner" in e for e in e9), e9
    assert any("'Ghost' is not a cast member" in e for e in e9), e9
    told["props"] = [{"name": "Phone", "kit": "phone"}, {"name": "Banner", "kit": "banner", "text": "HI"}]
    told["beats"][2]["fx"] = "ball_swish"
    e9b = qa_gate.check_show_dont_tell(told, manifest)
    assert not e9b, e9b
    print("[PASS] Test 9: Show-don't-tell props/fx + missing cast target blocked by Gate 1")

    # 10. Thumbnail picker/headline + upload metadata (tags under YouTube's limit, rich description)
    import make_thumbnail, upload_queue as uq
    sb = [{"cam": "wide", "action": "walk"}, {"cam": "closeup", "face": "shocked"}, {"cam": "low_hero", "action": "fall", "face": "scared"}]
    tb = [{"start": 0, "dur": 2}, {"start": 2, "dur": 2}, {"start": 4, "dur": 2}]
    assert make_thumbnail.pick_beat(sb, tb) == 1 and make_thumbnail.pick_beat(sb, tb, forced=3) == 2
    hw = make_thumbnail.headline_words({"title": "The Lucky Prankster 🍀"}, None)
    assert [w for w, _ in hw] == ["THE", "LUCKY", "PRANKSTER"] and hw[-1][1] is True, hw
    assert make_thumbnail.caption_free_time([{"start": 0.0, "end": 1.9}], 0.0, 2.0, 0.0, 0.55) is None
    assert make_thumbnail.caption_free_time([{"start": 0.0, "end": 0.4}], 0.0, 2.0, 0.0, 0.55) is not None
    mcfg = {"channel": {"default_hashtags": ["#roblox"]}, "automation": {"youtube": {"default_tags": ["roblox"] * 3 + [f"tag number {i}" for i in range(80)]}}}
    t10, d10, g10 = uq.build_metadata({"title": "Big Twist 🍀", "description": "D", "cta": "Fair?", "rule_type": "curse"}, mcfg)
    assert t10 == "Big Twist 🍀" and "Fair?" in d10 and "StudVerse Tales" in d10
    assert uq.tag_cost(g10) <= uq.TAG_BUDGET and g10.count("roblox") == 1 and "curse" in g10, g10
    print("[PASS] Test 10: Thumbnail beat picker/headline + upload tags/description")

    # 11. Camera targets: cast member, Crowd (needs crowd_cheer), or a story prop; partners must be cast
    tg = make_valid_story("019", "Target Story")
    tg["props"] = [{"name": "Banner", "kit": "banner", "text": "HI"}]
    tg["beats"][3]["target"] = "Banner"; tg["beats"][4]["target"] = "Crowd"; tg["beats"][4]["fx"] = "crowd_cheer"
    e11 = qa_gate.check_manifest_and_sameness(tg, manifest, [], cfg["automation"]["qa"])
    assert not [e for e in e11 if "target" in e or "not in the cast" in e], e11
    tg["beats"][4]["fx"] = ""; tg["beats"][5]["target"] = "Ghost"; tg["beats"][6]["with"] = [{"name": "Banner"}]
    e11b = qa_gate.check_manifest_and_sameness(tg, manifest, [], cfg["automation"]["qa"])
    assert any("no beat spawns the crowd" in e for e in e11b) and any("'Ghost' is not a cast member" in e for e in e11b), e11b
    assert any("'Banner' is not in the cast" in e for e in e11b), e11b
    print("[PASS] Test 11: Camera targets (cast / Crowd / story prop) validated by Gate 1")

    # 12. Anti-repetition + action sanity: set rotation, motivated falls, no indoor story on the outdoor yard
    sa = make_valid_story("020", "Quiet Yard")
    sa["set"] = "street_day"
    sa["beats"][2]["action"] = "fall"; sa["beats"][2]["line"] = "He smiled at the *door*."
    sa["beats"][3]["with"] = [{"name": sa["cast"][0]["name"], "action": "fall"}]; sa["beats"][3]["line"] = "A shove sent him *flying*."
    e12 = qa_gate.check_action_sanity(sa, "street_day")
    assert any("repeats the previous episode" in e for e in e12) and any(e.startswith("Beat 3: action 'fall'") for e in e12), e12
    assert not any(e.startswith("Beat 4") for e in e12), e12
    assert not qa_gate.check_action_sanity({"set": "street_day", "beats": []}, "cozy_room")
    sb12 = {"set": "school_yard", "title": "The Silent Hallway", "beats": []}
    assert any("'hallway'" in e for e in qa_gate.check_action_sanity(sb12, None))
    sb12["title"] = "Last Hoop"; sb12["beats"] = [{"line": "She sat down for the surprise *exam*."}]
    assert any("'exam'" in e for e in qa_gate.check_action_sanity(sb12, None))
    sb12["set"] = "cozy_room"
    assert not qa_gate.check_action_sanity(sb12, None)
    print("[PASS] Test 12: Set rotation, unmotivated fall, indoor-on-yard mismatch blocked by Gate 1")

    # 13. Multi-set stories: per-beat `set:` spots resolve in that set at its offset; Gate 1 checks spots per set
    import compile_story
    ms = make_valid_story("021", "Two Rooms")
    ms["set"] = "classroom"
    ms["beats"][3].update(set="auditorium", snap_spot="podium_left", invisible=True)
    ms["beats"][4].update(set="auditorium", spot="aisle_front")
    ms["beats"][5].update(set="auditorium", move_to=[1, 0, 2])
    rs = compile_story.resolve_spots(json.loads(json.dumps(ms)), manifest)
    assert rs["_sets"] == {"classroom": [0, 0, 0], "auditorium": [400.0, 0, 0]}, rs["_sets"]
    assert rs["beats"][3]["snap_to"] == [393.0, 2.6, -19.5], rs["beats"][3]
    assert rs["beats"][4]["move_to"] == [400.0, 0.0, -4.0] and rs["beats"][5]["move_to"] == [401.0, 0.0, 2.0]
    lu = compile_story.compile_luau(rs, rs["beats"])
    assert 'set = "auditorium"' in lu and "invisible = true" in lu and "Vector3.new(400.00, 0.00, 0.00)" in lu
    ms["beats"][6].update(set="auditorium", spot="desk_seat")          # a classroom spot used in the auditorium
    e13 = qa_gate.check_manifest_and_sameness(ms, manifest, [], cfg["automation"]["qa"])
    assert any("Unknown spot 'desk_seat' for set 'auditorium'" in e for e in e13), e13
    assert len([e for e in e13 if 'Unknown spot' in e]) == 1, e13
    ex = {"set": "school_yard", "title": "Quiz", "beats": [{"line": "The *test* was hard."}]}
    assert any("exam paper" in e for e in qa_gate.check_show_dont_tell(ex, manifest))
    ex["beats"][0]["set"] = "classroom"
    assert not qa_gate.check_show_dont_tell(ex, manifest)
    print("[PASS] Test 13: Per-beat sets resolve spots at set offsets; Gate 1 checks spots per set + exam paper shown")

    # 14. Vision gate (mocked Gemini, no quota): PASS, one auto-fix retry, unfixable/second failure -> quarantine
    import daemon
    db = db_mod.PipelineDB(tmp / "ledger" / "pipeline.db", tmp / "ledger" / "quota_log.csv")
    def vision_story(ep):
        d = tmp / "stories" / f"{ep}_vision"
        (d / "rec").mkdir(parents=True, exist_ok=True)
        vs = make_valid_story(ep, "Vision Story"); vs["set"] = "classroom"
        (d / "story.yaml").write_text(yaml.safe_dump(vs, sort_keys=False), encoding="utf-8")
        (d / "beats.json").write_text(json.dumps({"beats": [{"n": i + 1, "line": b.get("line", ""), "cam": b.get("cam")}
                                                             for i, b in enumerate(vs["beats"])]}), encoding="utf-8")
        (d / "rec" / "qa_beats.png").write_bytes(b"PNG fake sheet")
        db.upsert_episode(ep, "vision", str(d), status="GATE3_PASS")
        return d
    clean = lambda png, text: {"pass": True, "failures": []}
    fixable = {"pass": False, "failures": [{"beat": 2, "category": "camera", "issue": "blocked by partner",
                                            "fixable": True, "patch": {"cam": "wide", "spot": "aisle_left"}}]}
    v1 = vision_story("031")
    assert daemon.vision_with_retry("031", v1, cfg, db, lambda: 1 / 0, judge=clean, root=tmp)
    assert json.loads((v1 / "vision_qa.json").read_text())["pass"] is True
    v2 = vision_story("032"); verdicts = iter([fixable, {"pass": True, "failures": []}]); recaps = []
    assert daemon.vision_with_retry("032", v2, cfg, db, lambda: recaps.append(1) or True,
                                    judge=lambda png, text: next(verdicts), root=tmp)
    patched = yaml.safe_load((v2 / "story.yaml").read_text(encoding="utf-8"))["beats"][1]
    assert recaps == [1] and patched["cam"] == "wide" and patched["spot"] == "aisle_left"
    assert (v2 / "story.pre_vision.yaml").exists() and db.get_episode("032")["status"] == "GATE3_PASS"
    v3 = vision_story("033"); recaps = []
    assert not daemon.vision_with_retry("033", v3, cfg, db, lambda: recaps.append(1) or True,
                                        judge=lambda png, text: fixable, root=tmp)   # still failing after the one retry
    assert recaps == [1] and db.get_episode("033")["status"] == "QUARANTINED"
    assert (tmp / "quarantine" / "033_vision" / "failure.json").exists()
    v4 = vision_story("034"); recaps = []
    wardrobe = {"pass": False, "failures": [{"beat": 1, "category": "wardrobe", "issue": "girl in a boy outfit", "fixable": False}]}
    assert not daemon.vision_with_retry("034", v4, cfg, db, lambda: recaps.append(1) or True,
                                        judge=lambda png, text: wardrobe, root=tmp)
    assert recaps == [] and db.get_episode("034")["status"] == "QUARANTINED"
    v5 = vision_story("035")
    bad_patch = {"pass": False, "failures": [{"beat": 2, "category": "camera", "issue": "x", "fixable": True,
                                              "patch": {"cam": "drone_fpv"}}]}
    assert not daemon.vision_with_retry("035", v5, cfg, db, lambda: True, judge=lambda p, t: bad_patch, root=tmp)
    def broken(png, text): raise TimeoutError("quota")
    v6 = vision_story("036")
    assert not daemon.vision_with_retry("036", v6, cfg, db, lambda: True, judge=broken, root=tmp)
    assert "quota" in json.loads((v6 / "vision_qa.json").read_text())["error"]
    print("[PASS] Test 14: Vision gate PASS, 1 auto-fix retry, unfixable/invalid/2nd-fail/API-error -> quarantine")

    # 15. Quarantine never stalls the day (next pending episode, max_produce_attempts) + intermediates purge
    queue = iter(["041", "042", "043", "044"])
    for ep, st in (("041", "QUARANTINED"), ("042", "QUARANTINED"), ("043", "GATE3_PASS"), ("044", "AUDIO_PASS")):
        db.upsert_episode(ep, "q", str(tmp / "stories" / ep), status=st)
    pcfg = {"automation": {"max_produce_attempts": 3}}
    assert daemon.produce_until_ok(pcfg, db, produce=lambda: next(queue)) == ["041", "042", "043"]
    db.set_status("043", "QUARANTINED")
    queue = iter(["041", "042", "043", "044"])
    assert daemon.produce_until_ok(pcfg, db, produce=lambda: next(queue)) == ["041", "042", "043"]   # capped at 3
    assert daemon.produce_until_ok(pcfg, db, produce=lambda: None) == []
    import run_take
    pd = tmp / "stories" / "045_purge"; (pd / "rec").mkdir(parents=True)
    for f in ("rec/raw.mp4", "rec/trimmed.mp4", "045_audit.zip", "045_FINAL.mp4", "thumbnail.jpg"):
        (pd / f).write_bytes(b"x" * 10)
    assert run_take.purge_intermediates(pd) == 20
    assert sorted(f.name for f in pd.rglob("*") if f.is_file()) == ["045_FINAL.mp4", "045_audit.zip", "thumbnail.jpg"]
    print("[PASS] Test 15: Quarantined episode -> next pending (max 3 per run); raw/trimmed purged, audit zip + FINAL kept")

    # 16. Style anchors are themselves gold-standard: kid-simple lint + Gate 1 manifest checks pass for all three
    import re as _re
    from config_loader import ROOT
    anchors = [yaml.safe_load(blk) for blk in _re.findall(r"```yaml\n(.*?)```",
               (ROOT / "templates" / "style_anchors.md").read_text(encoding="utf-8"), _re.S)]
    assert len(anchors) == 3 and all(len(x["beats"]) == 22 for x in anchors)
    for anc in anchors:
        assert not story_gen.kid_simple_errors(anc), (anc["id"], story_gen.kid_simple_errors(anc))
        e16 = [e for e in qa_gate.check_manifest_and_sameness(anc, manifest, [], cfg["automation"]["qa"]) if "Premise" not in e]
        assert not e16, (anc["id"], e16)
        assert not qa_gate.check_action_sanity(anc, None), anc["id"]
    dull = dict(anchors[0], title="The Silence Tax")
    dull["beats"] = [dict(x) for x in anchors[0]["beats"]]
    dull["beats"][0]["line"] = "The corrupt valedictorian was officially disqualified from the championship today."
    ek = story_gen.kid_simple_errors(dull)
    assert any("In This World" in e for e in ek) and any("Adult/essay" in e for e in ek) and any("Beat 1:" in e for e in ek), ek
    print("[PASS] Test 16: 3 style anchors pass the 8-Year-Old Test + Gate 1; dull title/adult words/long lines rejected")

    # 17. Overhead rule counter: compiles for cast / beat / partner; Gate 1 rejects emoji and > 18 chars
    ct = make_valid_story("051", "Counter Story")
    ct["cast"][0]["counter"] = "10 WORDS"; ct["beats"][1]["counter"] = "LIES: 99"
    ct["beats"][1]["with"] = [{"name": "Friend", "action": "idle", "counter": "3 WORDS"}]
    lu17 = compile_story.compile_luau(ct, ct["beats"])
    assert 'counter = "10 WORDS"' in lu17 and 'counter = "LIES: 99"' in lu17 and 'counter = "3 WORDS"' in lu17
    assert not [e for e in qa_gate.check_manifest_and_sameness(ct, manifest, [], cfg["automation"]["qa"]) if "counter" in e]
    ct["beats"][2]["counter"] = "LIES 🔥"; ct["beats"][3]["counter"] = "THIS IS WAY TOO LONG!!"
    e17 = [e for e in qa_gate.check_manifest_and_sameness(ct, manifest, [], cfg["automation"]["qa"]) if "counter" in e]
    assert any("emoji" in e for e in e17) and any("longer than 18" in e for e in e17), e17
    print("[PASS] Test 17: counter: compiles (cast/beat/partner); emoji and >18-char counters blocked by Gate 1")

    # 18. Vision failures are logged (Test 14's retry/quarantine runs) + learning brief ranks published episodes
    vf = (tmp / "ledger" / "VISION_FAILURES.md").read_text(encoding="utf-8")
    assert "| date | episode | set | beat | cam | action | issue |" in vf
    assert _re.search(r"\| 032 \| classroom \| 2 \| ots \| .*\[retry\] camera: blocked by partner", vf), vf
    assert "| 034 |" in vf and "[quarantine] wardrobe" in vf and "| 036 |" in vf
    import learning_brief
    assert "No published episodes" in learning_brief.build_brief(tmp, tmp / "ledger" / "pipeline.db")
    for ep, title, views, setn, rt in (("061", "In This World, You Freeze on Red", 9000, "school_yard", "curse"),
                                       ("062", "The Silence Tax", 300, "classroom", "speech_cost"),
                                       ("063", "In This Town, Lies Float Up", 7000, "school_hallway", "perception")):
        d = tmp / "stories" / f"{ep}_lb"; d.mkdir(parents=True, exist_ok=True)
        (d / "story.yaml").write_text(yaml.safe_dump({"title": title, "set": setn}), encoding="utf-8")
        (d / "beats.json").write_text(json.dumps({"beats": [{"dur": 2.0}] * 22}), encoding="utf-8")
        db.upsert_episode(ep, "lb", str(d), title=title, status="SCHEDULED", rule_type=rt, views_7d=views,
                          youtube_video_id=f"vid{ep}")
    (tmp / "ledger" / "studio_export.csv").write_text(
        "Content,Video title,Average percentage viewed (%),Stayed to watch (%)\nvid061,x,88.5,74\nvid062,y,41.0,52\n",
        encoding="utf-8")
    brief = learning_brief.build_brief(tmp, tmp / "ledger" / "pipeline.db")
    assert "Based on 3 published episode(s)" in brief and "| In This World/Town hook | 2 |" in brief
    assert "| curse | 1 | 9000 | 74 | 88 |" in brief, brief                       # viewed % vs APV % columns kept apart
    assert "Top: **curse**" in brief and "Bottom: **speech_cost**" in brief, brief  # by views (partial export)
    print("[PASS] Test 18: VISION_FAILURES.md rows (retry + quarantine); learning brief ranks dims incl. Studio APV")

    # 19. Auto replenishment (mocked Gemini): writer fallback, rewrite on rule failure, independent judge, ingest
    import shutil as _sh
    (tmp / "templates").mkdir(exist_ok=True)
    _sh.copy(ROOT / "templates" / "style_anchors.md", tmp / "templates" / "style_anchors.md")
    good = dict(anchors[2]); good.pop("id")
    good["title"] = "In This World, Red Things Freeze You"
    bad = dict(good, title="Red Freeze")
    calls = []
    def fake(model, prompt, json_mode):
        calls.append((model, json_mode))
        if model == "gemini-4-hydrogen":
            raise TimeoutError("overloaded")                 # writer fallback -> gemini-3.6-flash
        if json_mode:
            return json.dumps({"scores": {k: 9 for k in ("rule_simplicity", "spoken_english", "emotional_stakes",
                               "hook_title", "visual_clarity", "stageable")}, "pass": True, "reason": "clear"}), {"promptTokenCount": 50}
        first = sum(1 for m, j in calls if not j and m != "gemini-4-hydrogen") == 1
        return "```yaml\n" + yaml.safe_dump(bad if first else good, sort_keys=False) + "```", {"promptTokenCount": 900, "candidatesTokenCount": 700}
    made19 = story_gen.auto_generate(1, root=tmp, db_path=tmp / "ledger" / "pipeline.db", generate=fake)
    assert len(made19) == 1, made19
    jr = json.loads(next((tmp / "stories").glob(f"{made19[0][0]}_*/judge_result.json")).read_text())
    assert jr["writer_model"] == "gemini-3.6-flash" and jr["judge_model"] == "gemini-3.8-flash" and jr["pass"] is True
    assert jr["input_tokens"] == 900 and jr["mean_score"] == 9.0
    assert [m for m, j in calls if not j].count("gemini-3.6-flash") == 2          # one rewrite after the dull title
    db2 = db_mod.PipelineDB(tmp / "ledger" / "pipeline.db")
    assert db2.get_episode(made19[0][0])["status"] == "GENERATED"; db2.close()
    def low_judge(model, prompt, json_mode):
        if json_mode:
            return json.dumps({"scores": {"rule_simplicity": 9, "spoken_english": 6, "emotional_stakes": 9,
                               "hook_title": 9, "visual_clarity": 9, "stageable": 9}, "pass": True}), {}
        hall = {k: v for k, v in anchors[1].items() if k != "id"}         # hallway: rotates away from school_yard
        return yaml.safe_dump(dict(hall, title="In This World, Blue Things Burn You"), sort_keys=False), {}
    assert story_gen.auto_generate(1, root=tmp, db_path=tmp / "ledger" / "pipeline.db", generate=low_judge) == []
    assert list((tmp / "stories" / "_inbox" / "_rejected").glob("auto_in-this-world-blue*.reason.txt"))
    print("[PASS] Test 19: Auto story gen: writer fallback + rewrite, independent judge, low score rejected, pass ingested")

    # 20. V6.2 per-beat scale + mid-beat face swap: compile for cast / beat / partner; Gate 1 range + face checks
    sc = make_valid_story("071", "Scale Story")
    sc["cast"][0]["scale"] = 1.0; sc["beats"][1]["scale"] = 0.6; sc["beats"][1]["face_mid"] = "shocked"
    sc["beats"][1]["with"] = [{"name": "Friend", "action": "idle", "scale": 0.4, "face_mid": "scared"}]
    lu20 = compile_story.compile_luau(sc, sc["beats"])
    assert "scale = 0.6" in lu20 and "scale = 0.4" in lu20 and "scale = 1.0" in lu20
    assert 'face_mid = "shocked"' in lu20 and 'face_mid = "scared"' in lu20
    g20 = lambda: [e for e in qa_gate.check_manifest_and_sameness(sc, manifest, [], cfg["automation"]["qa"]) if "scale" in e or "face_mid" in e]
    assert not g20(), g20()
    sc["beats"][2]["scale"] = 3.0; sc["beats"][3]["face_mid"] = "laughing"; sc["beats"][4]["scale"] = "big"
    e20 = g20()
    assert sum("scale" in e for e in e20) == 2 and any("face_mid 'laughing'" in e for e in e20), e20
    eng = (ROOT / "engines" / "roblox" / "core_engine.luau").read_text(encoding="utf-8")
    assert "function Engine.setScale" in eng and "r.baseC0[jn] = m6d.C0" in eng and "active.dur * 0.5" in eng
    print("[PASS] Test 20: scale/face_mid compile (cast/beat/partner); Gate 1 blocks scale 3.0, non-number, unknown face")

    # 21. V6.2 2D overlays + punch-zoom: Gate 1 limits, filtergraph, and a real 2 s render
    import finish_video
    ov = make_valid_story("072", "Overlay Story")
    ov["beats"][1].update(overlay="bubble", overlay_text="WAIT WHAT?!"); ov["beats"][2]["overlay"] = "sweat"
    g21 = lambda: [e for e in qa_gate.check_manifest_and_sameness(ov, manifest, [], cfg["automation"]["qa"]) if "overlay" in e]
    assert not g21(), g21()
    for i in range(3, 7):
        ov["beats"][i]["overlay"] = "hearts"
    ov["beats"][7].update(overlay="bubble"); ov["beats"][8].update(overlay="bubble", overlay_text="WAY TOO LONG BUBBLE")
    ov["beats"][9].update(overlay="sparkles"); ov["beats"][10].update(overlay="bubble", overlay_text="NO 🔥")
    ov["beats"][11]["overlay_text"] = "LOOSE"
    e21 = g21()
    for want in ("overlays; at most 5", "2-16 characters", "unknown", "emoji", "only goes with overlay: bubble"):
        assert any(want in e for e in e21), (want, e21)
    vt = tmp / "vfx"; vt.mkdir(exist_ok=True)
    bts = [{"start": 0.2, "dur": 0.9, "face": "shocked", "overlay": "bubble", "overlay_text": "SO TINY!"},
           {"start": 1.1, "dur": 0.9, "overlay": "flash_red_blue"}]
    ins21, g = finish_video.video_graph("scale=270:480", "", bts, 0.0, 270, 480, 1, vt)
    assert "enable='between(t,0.200,1.300)'" in g and "eval=frame" in g and "crop=270:480" in g and len(ins21) == 12, (g, ins21)
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", "testsrc2=s=320x240:r=30:d=2",
                    *ins21, "-filter_complex", g, "-map", "[v]", "-c:v", "libx264", "-preset", "ultrafast",
                    str(vt / "o.mp4")], check=True)
    pr = subprocess.run(["ffprobe", "-v", "error", "-count_frames", "-show_entries", "stream=width,height,nb_read_frames",
                         "-of", "csv=p=0", str(vt / "o.mp4")], capture_output=True, text=True, check=True).stdout.strip()
    assert pr == "270,480,60", pr
    # overlay index with SFX + looping BGM inputs present: raw=0, voice=1, 2 sfx=2,3, bgm=4 -> first PNG is [5:v]
    ins_av = ["-i", "a.wav", "-i", "b.wav", "-stream_loop", "-1", "-i", "bgm.mp3"]
    assert finish_video.overlay_base_idx(ins_av, False) == 5 and finish_video.overlay_base_idx(ins_av, True) == 4
    _, g_av = finish_video.video_graph("scale=270:480", "", bts[:1], 0.0, 270, 480,
                                       finish_video.overlay_base_idx(ins_av, False), vt)
    assert "[z0][5:v]overlay" in g_av, g_av
    # real render: voice + SFX + BGM + overlay through one filtergraph
    for nm, src in (("voice.wav", "sine=f=300:d=2"), ("sfx.wav", "sine=f=900:d=0.3"), ("bgm.wav", "sine=f=150:d=1")):
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", src, str(vt / nm)], check=True)
    ins_r = ["-i", str(vt / "sfx.wav"), "-stream_loop", "-1", "-i", str(vt / "bgm.wav")]
    pngs, g_r = finish_video.video_graph("scale=270:480", "", bts[:1], 0.0, 270, 480,
                                         finish_video.overlay_base_idx(ins_r, False), vt)
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", "testsrc2=s=320x240:r=30:d=2",
                    "-i", str(vt / "voice.wav"), *ins_r, *pngs, "-filter_complex",
                    g_r + ";[1:a][2:a][3:a]amix=inputs=3:duration=first[a]", "-map", "[v]", "-map", "[a]",
                    "-c:v", "libx264", "-preset", "ultrafast", str(vt / "av.mp4")], check=True)
    print("[PASS] Test 21: overlays (Gate 1 count/enum/text/emoji), zoom+overlay filtergraph renders 60 clean frames")

    # 22. Capability contract: unstageable shrink/vanish rules fail before the judge; judge stageable score gates
    shrink = dict(anchors[2]); shrink["beats"] = [dict(x) for x in anchors[2]["beats"]]
    shrink["beats"][5]["line"] = "Every mean word makes you *shrink*."
    assert any("scale:" in e for e in story_gen.kid_simple_errors(shrink))
    shrink["beats"][6]["scale"] = 0.6
    assert not any("scale:" in e for e in story_gen.kid_simple_errors(shrink))
    shrink["beats"][7]["line"] = "Then he just *vanished* away."
    assert any("invisible:" in e for e in story_gen.kid_simple_errors(shrink))
    shrink["beats"][8]["invisible"] = True     # True must count as staged (True == 1 in Python)
    assert not story_gen.kid_simple_errors(shrink), story_gen.kid_simple_errors(shrink)
    assert "stageable" in story_gen.JUDGE_PROMPT and "scale:" in story_gen.JUDGE_PROMPT and "CAPABILITY" in story_gen.JUDGE_PROMPT
    def unstageable(model, prompt, json_mode):
        if json_mode:
            return json.dumps({"scores": {"rule_simplicity": 9, "spoken_english": 9, "emotional_stakes": 9,
                               "hook_title": 9, "visual_clarity": 9, "stageable": 3}, "pass": True}), {}
        assert "ENGINE CAPABILITY CONTRACT" in prompt
        return yaml.safe_dump(dict(good, title="In This World, Green Things Stick To You"), sort_keys=False), {}
    assert story_gen.auto_generate(1, root=tmp, db_path=tmp / "ledger" / "pipeline.db", generate=unstageable) == []
    print("[PASS] Test 22: capability lint blocks shrink-without-scale / vanish-without-invisible; low stageable rejected")

    # 23. V6.2.1 thumbnail headline: hook prefix dropped, whole clause kept, 2 balanced lines; engine tiny-actor guards
    import make_thumbnail
    hw = make_thumbnail.headline_words({"title": "In This Town, Every Mean Word Makes You Shorter"}, None)
    assert [[w for w, _ in ln] for ln in make_thumbnail.layout(hw)] == [["EVERY", "MEAN", "WORD"], ["MAKES", "YOU", "SHORTER"]]
    assert [w for w, h in hw if h] == ["SHORTER"]
    hw2 = make_thumbnail.headline_words({"title": "In This World, Touching Red Freezes You Forever"}, None)
    assert " ".join(w for w, _ in hw2) == "TOUCHING RED FREEZES YOU FOREVER" and len(make_thumbnail.layout(hw2)) == 2
    assert [w for w, _ in make_thumbnail.headline_words({"thumb_text": "SO *TINY*"}, None)] == ["SO", "TINY"]
    eng = (ROOT / "engines" / "roblox" / "core_engine.luau").read_text(encoding="utf-8")
    assert "(targetRig.scale or 1) < 0.5" in eng and "fy + 3.5" in eng and "math.max(r.scale or 1, 0.20)" in eng
    assert "(p.Position - camPos).Magnitude >= 5.5" in eng
    print("[PASS] Test 23: thumbnail keeps the whole hook clause on 2 lines; tiny-actor camera + near-lens sign guards")

    # 24. V6.2.2 camera-inside-part guard runs after every override and before the floor clamp; yard side + spacing
    ui = eng.index("cam.CFrame = Engine.unclipCamera(")
    assert "function Engine.unclipCamera(cf, aim, ignore)" in eng and "GetPartBoundsInBox(CFrame.new(p), CAM_BOX" in eng
    assert eng.index("V6.2.1 outdoor sets") < ui < eng.index("local clamped = Engine.clampCamAboveFloor"), "guard order"
    assert 'wrongSide = cp.Z < aim.Z - 0.5' in eng and "local MIN_ACTOR_DIST = 3.8" in eng
    ss = eng[eng.index("function Engine.setScale"):eng.index("function Engine.updateCounters")]
    assert ss.index("r.m.WorldPivot = prevCF") < ss.index("r.m:ScaleTo(s)") < ss.index("CFrame.new(prevCF.X, cur.Y, prevCF.Z)")
    assert "local feetY = p.Y - 3 * (r.scale or 1)" in eng, "pushOut must scale the feet height"
    assert "(a.d > b.d and a or b).p.CounterGui.Enabled = false" in eng, "overlapping signs: farther one hidden"
    assert "if not on or cut or rad > math.min(vs.X, vs.Y) * 0.45 then" in eng, "edge-cut / huge signs hidden"
    print("[PASS] Test 24: camera unclip guard wired before floor clamp; school_yard +Z side; shared-spot spacing 3.8")

    # 25. V6.3 phone_card + binary_cta overlays: Gate 1 text rules and a real 1080x1920 30fps A/V render
    pc = make_valid_story("073", "Card Story")
    pc["beats"][1].update(overlay="phone_card", overlay_text="NEW TEXT: SAM | Look behind you!")
    pc["beats"][15].update(overlay="binary_cta", overlay_text="WHAT WOULD YOU DO? | LIKE = STAY / COMMENT = RUN")
    g25 = lambda: [e for e in qa_gate.check_manifest_and_sameness(pc, manifest, [], cfg["automation"]["qa"]) if "overlay" in e]
    assert not g25(), g25()
    pc["beats"][1]["overlay_text"] = "X" * 65; pc["beats"][15]["overlay_text"] = "STAY OR RUN? 🔥"
    pc["beats"][2].update(overlay="sweat", overlay_text="DRIP")
    e25 = g25()
    for want in ("4-64 characters", "emoji", "only goes with overlay"):
        assert any(want in e for e in e25), (want, e25)
    ct = tmp / "cards"; ct.mkdir(exist_ok=True)
    bc = [{"start": 0.1, "dur": 1.0, "overlay": "phone_card", "overlay_text": "NEW TEXT: SAM | Look behind you!"},
          {"start": 1.2, "dur": 1.0, "overlay": "binary_cta", "overlay_text": "WHAT WOULD YOU DO? | LIKE = STAY / COMMENT = RUN"}]
    for nm, src in (("voice.wav", "sine=f=300:d=3"), ("sfx.wav", "sine=f=900:d=0.3"), ("bgm.wav", "sine=f=150:d=1")):
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", src, str(ct / nm)], check=True)
    ins_c = ["-i", str(ct / "sfx.wav"), "-stream_loop", "-1", "-i", str(ct / "bgm.wav")]
    pngs, g_c = finish_video.video_graph("scale=1080:1920,fps=30", "", bc, 0.0, 1080, 1920,
                                         finish_video.overlay_base_idx(ins_c, False), ct)
    assert "[z0][4:v]overlay" in g_c and len(pngs) == 8, (g_c, pngs)
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", "color=c=0x406080:s=1080x1920:r=30:d=3",
                    "-i", str(ct / "voice.wav"), *ins_c, *pngs, "-filter_complex",
                    g_c + ";[1:a][2:a][3:a]amix=inputs=3:duration=first[a]", "-map", "[v]", "-map", "[a]",
                    "-c:v", "libx264", "-preset", "ultrafast", "-c:a", "aac", str(ct / "cards.mp4")], check=True)
    pr = subprocess.run(["ffprobe", "-v", "error", "-count_frames", "-select_streams", "v", "-show_entries",
                         "stream=width,height,nb_read_frames,r_frame_rate", "-of", "csv=p=0", str(ct / "cards.mp4")],
                        capture_output=True, text=True, check=True).stdout.strip()
    assert pr == "1080,1920,30/1,90", pr
    from PIL import Image
    for png, box in ((ct / "ov_00_phone_card.png", (90, 180, 990, 390)), (ct / "ov_01_binary_cta.png", (90, 120, 990, 230))):
        a = Image.open(png).getchannel("A")
        assert a.getbbox() == (box[0], box[1], box[2] + 1, box[3] + 1), (png.name, a.getbbox())
        assert max(a.crop((0, 1920 - 560, 1080, 1920)).getdata()) == 0, "card reaches subtitle zone"
    print("[PASS] Test 25: phone_card/binary_cta Gate 1 text rules; 1080x1920 30fps voice+SFX+BGM card render, safe zones")

    # 26. V6.3 full-script blended unigram+bigram Jaccard: recycled lines fail even under a new title
    base = make_valid_story("074", "In This Town, Shadows Keep Score")
    for i, b in enumerate(base["beats"]):
        b["line"] = ["Mia's shadow trips anyone who lies", "the baker lied and fell flat",
                     "my brother hides a broken window", "his shadow starts to twitch now",
                     "I beg him to just confess", "Dad walks into the yard slowly",
                     "the shadow lunges at his ankles", "he shouts the truth and stands"][i % 8] + f" scene {i}"
    others = [("074", qa_gate.script_text(base))]
    fresh = make_valid_story("075", "In This World, Rain Sings Your Secrets")
    for i, b in enumerate(fresh["beats"]):
        b["line"] = f"Rain hums softly over number {i} roofs tonight"
    fresh["rule"] = "Rain sings every secret out loud."
    assert not qa_gate.script_similarity_errors(fresh, others, 0.42)
    copy = json.loads(json.dumps(base)); copy["id"] = "076"; copy["title"] = "In This World, Cats Rule Mondays"
    for b in copy["beats"][::4]:
        b["line"] = "cats nap on every warm car"
    e26 = qa_gate.script_similarity_errors(copy, others, 0.42)
    assert e26 and "episode 074" in e26[0] and "blended Jaccard" in e26[0], e26
    assert qa_gate.jaccard(qa_gate.tokenize(copy["title"]), qa_gate.tokenize(base["title"])) < 0.42, "titles must differ"
    sd = tmp / "stories_scan"; (sd / "stories" / "074_x").mkdir(parents=True, exist_ok=True)
    (sd / "stories" / "074_x" / "story.yaml").write_text(yaml.safe_dump(base), encoding="utf-8")
    assert [e for e, _ in qa_gate.load_other_scripts(sd, sd / "stories" / "076_y")] == ["074"]
    assert qa_gate.load_other_scripts(sd, sd / "stories" / "074_x") == [], "own folder must be excluded"
    print("[PASS] Test 26: full-script blended Jaccard passes distinct script, fails recycled lines under a new title")

    # 27. V6.3.1 speedlines + crimson_vignette overlays and the thin top progress bar
    from PIL import Image
    sv = tmp / "speed"; sv.mkdir(exist_ok=True)
    for kind in ("speedlines", "crimson_vignette"):
        a = Image.open(finish_video.make_overlay_png(kind, "", sv / f"{kind}.png", 1080, 1920)).getchannel("A")
        assert max(a.crop((440, 860, 640, 1060)).getdata()) == 0, f"{kind}: centre must stay clear"
        assert max(a.crop((0, 0, 1080, 120)).getdata()) > 0 and max(a.crop((0, 1800, 1080, 1920)).getdata()) > 0, kind
    sp = make_valid_story("077", "Speed Story")
    sp["beats"][1]["overlay"] = "speedlines"; sp["beats"][2]["overlay"] = "crimson_vignette"
    g27 = lambda: [e for e in qa_gate.check_manifest_and_sameness(sp, manifest, [], cfg["automation"]["qa"]) if "overlay" in e]
    assert not g27(), g27()
    sp["beats"][1]["overlay_text"] = "ZOOM"; sp["beats"][2]["overlay_text"] = "DANGER"
    assert sum("only goes with overlay" in e for e in g27()) == 2, g27()
    bs = [{"start": 0.3, "dur": 1.0, "overlay": "speedlines"}, {"start": 1.4, "dur": 1.0, "overlay": "crimson_vignette"}]
    for nm, src in (("voice.wav", "sine=f=300:d=3"), ("sfx.wav", "sine=f=900:d=0.3"), ("bgm.wav", "sine=f=150:d=1")):
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", src, str(sv / nm)], check=True)
    ins_s = ["-i", str(sv / "sfx.wav"), "-stream_loop", "-1", "-i", str(sv / "bgm.wav")]
    pngs, g_s = finish_video.video_graph("scale=1080:1920,fps=30", "", bs, 0.0, 1080, 1920,
                                         finish_video.overlay_base_idx(ins_s, False), sv, bar_dur=3.0)
    assert len(pngs) == 8 and "[z0][4:v]overlay" in g_s and g_s.index("[pb]") > g_s.index("[5:v]"), g_s
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", "color=c=0x406080:s=1080x1920:r=30:d=3",
                    "-i", str(sv / "voice.wav"), *ins_s, *pngs, "-filter_complex",
                    g_s + ";[1:a][2:a][3:a]amix=inputs=3:duration=first[a]", "-map", "[v]", "-map", "[a]",
                    "-c:v", "libx264", "-preset", "ultrafast", "-c:a", "aac", str(sv / "speed.mp4")], check=True)
    pr = subprocess.run(["ffprobe", "-v", "error", "-select_streams", "v", "-show_entries", "stream=width,height,r_frame_rate",
                         "-of", "csv=p=0", str(sv / "speed.mp4")], capture_output=True, text=True, check=True).stdout.strip()
    assert pr == "1080,1920,30/1", pr
    def gold(ts):
        f = sv / f"bar_{ts}.png"
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-ss", str(ts), "-i", str(sv / "speed.mp4"),
                        "-frames:v", "1", str(f)], check=True)
        im = Image.open(f).convert("RGB")
        return sum(1 for x in range(1080) if (lambda c: c[0] > 180 and c[1] > 150 and c[2] < 120)(im.getpixel((x, 16))))
    g05, g25 = gold(0.5), gold(2.5)
    assert 50 < g05 < g25 and g25 > 700, (g05, g25)
    print(f"[PASS] Test 27: speedlines/crimson_vignette PNGs + Gate 1 no-text rule; 1080x1920 30fps render, bar {g05}px -> {g25}px")

    # 28. V6.3.2 pacing: 0.25 s beat breaths + 0.8 s final hold stay clear of Gate 2 silence/duration limits
    import voice_subs
    from config_loader import load_config as _lc
    vcfg = _lc()["voice"]
    assert float(vcfg["beat_pause_sec"]) == 0.25 and float(vcfg["final_beat_hold_sec"]) == 0.8
    segs = [{"text": "x", "pause_before": (1.0 if i == 11 else 0.0)} for i in range(22)]
    gaps, hold = voice_subs.segment_gaps(segs, 0.25, 0.8)
    assert gaps[0] == 0.0 and gaps[1] == 0.25 and gaps[11] == 1.0 and hold == 0.8, (gaps, hold)
    pd = tmp / "pace"; pd.mkdir(exist_ok=True)
    clips = []
    for i, gp in enumerate(gaps):
        if gp > 0.02:
            clips.append(voice_subs._silence(pd / f"s{i:02d}.wav", gp))
        tone = pd / f"t{i:02d}.wav"
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", "sine=f=220:d=2.0:sample_rate=24000",
                        "-ac", "1", str(tone)], check=True)
        clips.append(tone)
    clips.append(voice_subs._silence(pd / "hold.wav", hold))
    (pd / "l.txt").write_text(chr(10).join(f"file '{str(c).replace(chr(92), '/')}'" for c in clips), encoding="utf-8")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "concat", "-safe", "0", "-i", str(pd / "l.txt"),
                    "-c:a", "libmp3lame", "-q:a", "2", str(pd / "voice.mp3")], check=True)
    ok28, e28, m28 = qa_gate.run_audio_gate(pd, cfg)
    assert ok28 and not m28["long_silences"] and 48.0 <= m28["duration"] <= 55.0, (e28, m28)
    print(f"[PASS] Test 28: beat_pause 0.25 s + final hold 0.8 s -> {m28['duration']} s voice, no Gate 2 silence trip")

    # 29. V6.5 comic_issue theme: 50 beats, 120-165 s through Gates 1/2/3 (horror + comedy); 90 s dead zone rejected
    def comic_story(ep, genre):
        cs = make_valid_story(ep, "In This Town, Shadows Keep Your Secrets")
        cs.update(theme="comic_issue", genre=genre,
                  cast=[{"name": "Sam", "gender": "boy", "default_face": "neutral"},
                        {"name": "Toby", "gender": "boy", "default_face": "grin"}])
        cs["beats"] = [{"dur": 2.6, "cam": "closeup" if i % 2 else "front", "motion": "push_in",
                        "target": "Sam" if i % 2 else "Toby", "action": "talk", "face": "neutral",
                        "speaker": "narrator" if i % 3 == 0 else "boy", "line": f"Toby hides the {i} shiny *secret* fast"}
                       for i in range(50)]
        for i, kind in ((5, "bubble"), (12, "sweat"), (20, "hearts"), (28, "speedlines"), (33, "crimson_vignette"), (40, "sweat")):
            cs["beats"][i]["overlay"] = kind
            if kind == "bubble":
                cs["beats"][i]["overlay_text"] = "WAIT WHAT?!"
        return cs
    for gname in ("horror", "comedy"):
        cs = comic_story("078", gname)
        e29 = story_gen.kid_simple_errors(cs) + [e for e in qa_gate.check_manifest_and_sameness(cs, manifest, [], cfg["automation"]["qa"])
                                                  if "Premise" not in e and "sameness" not in e]
        assert not e29, (gname, e29)
    bad = comic_story("079", "horror"); bad["beats"] = bad["beats"][:22]
    assert any("46-54" in e for e in story_gen.kid_simple_errors(bad))
    bad = comic_story("079", "horror"); bad["beats"][44].update(overlay="binary_cta", overlay_text="STAY? | LIKE = YES / COMMENT = NO")
    assert any("no binary_cta" in e for e in qa_gate.check_manifest_and_sameness(bad, manifest, [], cfg["automation"]["qa"]))
    bad["beats"][44].update(overlay="sweat"); bad["beats"][44].pop("overlay_text")
    bad["beats"][45]["overlay"] = "hearts"; bad["beats"][46]["overlay"] = "hearts"
    assert any("at most 7" in e for e in qa_gate.check_manifest_and_sameness(bad, manifest, [], cfg["automation"]["qa"]))
    qcfg = dict(cfg); qcfg["automation"] = dict(cfg["automation"]); qcfg["automation"]["qa"] = dict(cfg["automation"]["qa"], comic_min_sec=120.0, comic_max_sec=165.0)
    cd = tmp / "comic"; cd.mkdir(exist_ok=True)
    (cd / "story.yaml").write_text(yaml.safe_dump(comic_story("078", "comedy")), encoding="utf-8")
    def tone_voice(secs):
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", f"sine=f=220:d={secs}:sample_rate=24000",
                        "-c:a", "libmp3lame", "-q:a", "6", str(cd / "voice.mp3")], check=True)
    tone_voice(130)
    ok29, e29a, m29 = qa_gate.run_audio_gate(cd, qcfg)
    assert ok29 and 120 <= m29["duration"] <= 165, (e29a, m29)
    tone_voice(90)
    ok29b, e29b, _ = qa_gate.run_audio_gate(cd, qcfg)
    assert not ok29b and any("[120.0, 165.0]" in e for e in e29b), e29b
    assert qa_gate.duration_bounds({"theme": "default"}, qcfg["automation"]["qa"]) == (35.0, 58.5)
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", "testsrc2=s=1080x1920:r=30:d=130",
                    "-f", "lavfi", "-i", "sine=f=300:d=130", "-c:v", "libx264", "-preset", "ultrafast", "-crf", "35",
                    "-c:a", "aac", "-shortest", str(cd / "078_FINAL.mp4")], check=True)
    ok29c, e29c, m29c = qa_gate.run_render_gate(cd / "078_FINAL.mp4", qcfg)
    assert not [e for e in e29c if "duration" in e], (e29c, m29c)
    print(f"[PASS] Test 29: comic_issue 50 beats passes Gates 1/2/3 (horror + comedy, {m29['duration']} s audio, {m29c['duration']} s render); 90 s dead zone, binary_cta, >7 overlays rejected")

    # 30. V6.5 --genre auto rotation + anti-shrink lock from the last stories on disk
    gr = tmp / "genre_root"
    def put(ep, genre, scale):
        st = make_valid_story(ep, f"In This Town, Story {ep}"); st["genre"] = genre
        if scale:
            st["beats"][3]["scale"] = 0.6
        d = gr / "stories" / f"{ep}_s"; d.mkdir(parents=True, exist_ok=True)
        (d / "story.yaml").write_text(yaml.safe_dump(st), encoding="utf-8")
    put("101", "karma_rules", False); put("102", "comedy", True); put("103", "karma_rules", True)
    rs = story_gen.recent_stories(gr, 3)
    assert [s["id"] for s in rs] == ["103", "102", "101"]
    g30 = story_gen.pick_genre(rs, "auto")
    assert g30 not in ("karma_rules", "comedy") and story_gen.pick_genre(rs, "romance") == "romance", g30
    assert story_gen.banned_mechanics(rs) == {"scale"}
    sh = make_valid_story("104", "In This Town, Lies Make You Shrink"); sh["beats"][2]["scale"] = 0.5
    assert any("last 2 episodes" in e for e in story_gen.kid_simple_errors(sh, story_gen.banned_mechanics(rs)))
    assert not any("last 2 episodes" in e for e in story_gen.kid_simple_errors(sh, set()))
    wp = story_gen.writer_prompt(Path(__file__).resolve().parent.parent, [], None, "", g30, "default", {"scale"})
    assert "FORBIDDEN this time: shrinking" in wp and f"GENRE: {g30}" in wp
    put("105", "horror", False); put("106", "romance", False)
    assert story_gen.banned_mechanics(story_gen.recent_stories(gr, 3)) == set(), "scale only locked while in the last 2"
    print(f"[PASS] Test 30: --genre auto picks '{g30}' (not the last genres); scale/shrink locked after 2 recent scale episodes, unlocked later")

    print("ALL V6 SUITE TESTS PASSED.")


if __name__ == "__main__":
    run_tests()
