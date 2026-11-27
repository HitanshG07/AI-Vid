"""AI-Vid V6.0 Unified Fail-Closed QA Gate (pre | audio | render) + Quarantine Router.

Usage:
  python pipeline/qa_gate.py --story-dir stories/009_slug --stage pre
  python pipeline/qa_gate.py --story-dir stories/009_slug --stage audio
  python pipeline/qa_gate.py --story-dir stories/009_slug --stage render --video stories/009_slug/009_FINAL.mp4
"""
from __future__ import annotations
import argparse, difflib, hashlib, json, re, shutil, subprocess, sys
from pathlib import Path
import yaml
from config_loader import ROOT, load_config
from db import PipelineDB

STOP = set("this that with from have they them then were what when your just into over like been will would could "
           "there their about said says after back down than very more some only even still before again world town".split())


def tokenize(text: str) -> set[str]:
    return {w for w in re.findall(r"[a-z]{3,}", (text or "").lower()) if w not in STOP}


def jaccard(a: set[str], b: set[str]) -> float:
    return (len(a & b) / len(a | b)) if (a and b) else 0.0


def script_text(spec: dict) -> str:
    beats = spec.get("beats") or []
    return " ".join([str(spec.get("rule", ""))] + [re.sub(r"\*", "", str(b.get("line", ""))) for b in beats])


def blended_jaccard(a: str, b: str) -> float:
    """0.45 * unigram + 0.55 * bigram Jaccard over lowercase word tokens (stopwords kept so phrasing counts)."""
    wa, wb = re.findall(r"[a-z0-9']+", a.lower()), re.findall(r"[a-z0-9']+", b.lower())
    bg = lambda w: set(zip(w, w[1:]))
    return 0.45 * jaccard(set(wa), set(wb)) + 0.55 * jaccard(bg(wa), bg(wb))


def script_similarity_errors(spec: dict, others: list[tuple[str, str]], limit: float) -> list[str]:
    """others = [(episode_id, script_text)] of existing stories, candidate's own folder already excluded."""
    cand = script_text(spec)
    hits = [(blended_jaccard(cand, txt), eid) for eid, txt in others]
    s, eid = max(hits, default=(0.0, ""))
    return [f"Script too close to episode {eid} (blended Jaccard={s:.2f} > {limit:.2f})."] if s > limit else []


def load_other_scripts(root: Path, sdir: Path) -> list[tuple[str, str]]:
    out = []
    for f in sorted((root / "stories").glob("*/story.yaml")):
        if f.parent.resolve() == sdir.resolve():
            continue
        try:
            o = yaml.safe_load(f.read_text(encoding="utf-8")) or {}
        except Exception:
            continue
        out.append((str(o.get("id", f.parent.name[:3])), script_text(o)))
    return out


def word_error_rate(ref_text: str, hyp_text: str) -> float:
    norm = lambda s: re.findall(r"[a-z0-9']+", (s or "").lower())
    r, h = norm(ref_text), norm(hyp_text)
    if not r:
        return 0.0
    sm = difflib.SequenceMatcher(None, r, h)
    # Approximate WER from Levenshtein-style opcodes
    edits = 0
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag != "equal":
            edits += max(i2 - i1, j2 - j1)
    return round(edits / len(r), 4)


def quarantine_episode(sdir: Path, root: Path, stage: str, reasons: list[str], db: PipelineDB | None, ep_id: str):
    qroot = root / "quarantine"
    qroot.mkdir(parents=True, exist_ok=True)
    qdir = qroot / sdir.name
    payload = {"episode_id": ep_id, "stage": stage, "reasons": reasons, "source_dir": str(sdir)}
    (sdir / "failure.json").write_text(json.dumps(payload, indent=2), encoding="utf-8")
    if qdir.exists():
        shutil.rmtree(qdir)
    shutil.copytree(sdir, qdir)
    if db and ep_id:
        db.set_status(ep_id, "QUARANTINED", failure_reason=f"[{stage}] " + "; ".join(reasons))
    print(f"[QUARANTINED] {ep_id} at stage={stage}: {reasons}")


# "Show, don't just tell": a concrete thing named in a spoken line must exist on screen. Each word family is
# satisfied by a matching fx, a story prop (name or kit), or a built-in prop of the story's set.
SHOWN_THINGS = {
    "basketball": (r"\b(basket)?balls?\b", {"ball_swish"}, ("ball",)),   # a hoop on the set is not a ball
    "banner": (r"\bbanners?\b", set(), ("banner",)),                    # a blank set sign is not a banner
    "sign": (r"\bsigns?\b", set(), ("banner", "sign")),
    "truck": (r"\btrucks?\b|\bbumper\b", {"truck_pass"}, ("truck",)),
    "phone": (r"\bphones?\b", set(), ("phone",)),
    "exam paper": (r"\bexams?\b|\btests?\b", set(), ("paper",)),
    "podium": (r"\bpodiums?\b|\bdebates?\b", set(), ("podium",)),
    "locker": (r"\blockers?\b", set(), ("locker",)),
}


def used_sets(spec: dict) -> list[str]:
    """Top-level set + every per-beat `set:` override, in order of first use."""
    out = [spec.get("set")]
    for b in spec.get("beats", []):
        if b.get("set") and b["set"] not in out:
            out.append(b["set"])
    return out


def check_show_dont_tell(spec: dict, manifest: dict) -> list[str]:
    lines = " ".join((b.get("line") or "") for b in spec.get("beats", [])).lower()
    fxs = {(b.get("fx") or "") for b in spec.get("beats", [])}
    prop_words = " ".join(f"{p.get('name', '')} {p.get('kit', '')}" for p in (spec.get("props") or [])).lower()
    set_words = " ".join(w for st in used_sets(spec) for w in manifest["sets"].get(st, {}).get("props", [])).lower()
    errs = []
    for label, (pattern, fx_ok, words) in SHOWN_THINGS.items():
        if re.search(pattern, lines) and not (fxs & fx_ok) and not any(w in prop_words or w in set_words for w in words):
            errs.append(f"Narration mentions a {label} but story.yaml shows none "
                        f"(add a matching prop/kit{' or fx ' + '/'.join(sorted(fx_ok)) if fx_ok else ''}).")
    return errs


FALL_CUE = re.compile(r"\b(trip\w*|fell|fall\w*|collaps\w*|drop\w*|hits?|hitting|shov\w*|push\w*|slam\w*|crash\w*|trucks?)\b")
INDOOR_WORDS = re.compile(r"\b(hallways?|classrooms?|exams?)\b")


def check_action_sanity(spec: dict, prev_set: str | None) -> list[str]:
    """V6 anti-repetition + action sanity: set rotation, no unmotivated falls, no indoor story on the outdoor yard."""
    errs = []
    if prev_set and spec.get("set") == prev_set:
        errs.append(f"Set '{prev_set}' repeats the previous episode's set (rotate to another set).")
    for i, b in enumerate(spec.get("beats", []), 1):
        falls = [b] + [w for w in (b.get("with") or []) if isinstance(w, dict)]
        if any(x.get("action") == "fall" for x in falls) and not FALL_CUE.search((b.get("line") or "").lower()):
            errs.append(f"Beat {i}: action 'fall' but the line has no fall/impact cue (trip, fell, shove, slam, crash ...).")
    if used_sets(spec) == ["school_yard"]:
        text = " ".join([spec.get("title") or ""] + [b.get("line") or "" for b in spec.get("beats", [])]).lower()
        hit = INDOOR_WORDS.search(text)
        if hit:
            errs.append(f"Story is set in a '{hit.group(1)}' but uses the outdoor school_yard (no indoor school set is built).")
    return errs


COUNTER_OK = re.compile(r"^[A-Za-z0-9 :=+\-/!?.,#%'&]*$")
CARD_OK = re.compile(r"^[A-Za-z0-9 |=/:,.!?\-']*$")


def log_vision_failures(root: Path, ep_id: str, spec: dict, verdict: dict, outcome: str) -> int:
    """One line per flagged beat -> ledger/VISION_FAILURES.md (date | episode | set | beat | cam | action | issue)."""
    import datetime
    f = root / "ledger" / "VISION_FAILURES.md"
    f.parent.mkdir(parents=True, exist_ok=True)
    if not f.exists():
        f.write_text("# Vision QA failures (auto-appended)\n\n| date | episode | set | beat | cam | action | issue |\n"
                     "|---|---|---|---|---|---|---|\n", encoding="utf-8")
    beats = spec.get("beats", [])
    fails = verdict.get("failures") or [{"beat": "-", "category": "error", "issue": verdict.get("error", "judge error")}]
    rows = []
    for x in fails:
        n = x.get("beat")
        b = beats[n - 1] if isinstance(n, int) and 1 <= n <= len(beats) else {}
        issue = f"[{outcome}] {x.get('category', '')}: {x.get('issue', '')}".replace("|", "/")
        rows.append(f"| {datetime.date.today().isoformat()} | {ep_id} | {b.get('set') or spec.get('set', '')} | {n} | "
                    f"{b.get('cam', '')} | {b.get('action', '')} | {issue} |")
    with f.open("a", encoding="utf-8") as fh:
        fh.write("\n".join(rows) + "\n")
    return len(rows)


THEMES = ("default", "comic_issue")
GENRES = ("comedy", "horror", "romance", "slice_of_life", "karma_rules")
COMIC_MAX_OVERLAYS = 7


def is_comic(spec: dict | None) -> bool:
    return bool(spec) and spec.get("theme") == "comic_issue"


def duration_bounds(spec: dict | None, qa: dict) -> tuple[float, float]:
    """V6.5: comic_issue Shorts run 120-165 s; standard stories 35-58.5 s (nothing in the 61-120 s dead zone)."""
    if is_comic(spec):
        return float(qa.get("comic_min_sec", 120.0)), float(qa.get("comic_max_sec", 165.0))
    return float(qa["min_sec"]), float(qa["max_sec"])


def _story_spec(d: Path) -> dict | None:
    f = d / "story.yaml"
    try:
        return yaml.safe_load(f.read_text(encoding="utf-8")) if f.exists() else None
    except Exception:
        return None


def check_manifest_and_sameness(spec: dict, manifest: dict, recent_eps: list[dict], qa_cfg: dict) -> list[str]:
    errs = []
    if spec.get("theme", "default") not in THEMES:
        errs.append(f"Unknown theme '{spec.get('theme')}' (use {list(THEMES)}).")
    if spec.get("genre") and spec["genre"] not in GENRES:
        errs.append(f"Unknown genre '{spec.get('genre')}' (use {list(GENRES)}).")
    if spec.get("set") not in manifest["sets"]:
        errs.append(f"Unknown set '{spec.get('set')}' (not in assets/manifest.json).")
    for c in spec.get("cast", []):
        if c.get("gender") not in manifest["genders"]:
            errs.append(f"Invalid gender '{c.get('gender')}' for {c.get('name')}.")
        if c.get("default_face", "neutral") not in manifest["faces"]:
            errs.append(f"Invalid face '{c.get('default_face')}' for {c.get('name')}.")
    valid_cams = set(manifest["cameras"])
    valid_acts = set(manifest["actions"])
    valid_sfx = set(manifest["active_sfx"]) | {""}
    for i, b in enumerate(spec.get("beats", []), 1):
        if b.get("cam", "closeup") not in valid_cams:
            errs.append(f"Beat {i}: unknown cam '{b.get('cam')}'.")
        if b.get("action", "idle") not in valid_acts:
            errs.append(f"Beat {i}: unknown action '{b.get('action')}'.")
        if (b.get("sfx") or "").strip() not in valid_sfx:
            errs.append(f"Beat {i}: inactive/banned sfx '{b.get('sfx')}'.")
        if (b.get("badge") or "") not in manifest.get("badges", [""]):
            errs.append(f"Beat {i}: badge '{b.get('badge')}' not allowed (floating emoji badges are off by default).")
        if (b.get("fx") or "") not in set(manifest.get("fx", [])) | {""}:
            errs.append(f"Beat {i}: unknown fx '{b.get('fx')}'.")
    # named spots resolve in the beat's own set (V6 per-beat `set:` overrides; cast spots use the top-level set)
    named = [(c.get("spot"), spec.get("set")) for c in spec.get("cast", [])]
    for i, b in enumerate(spec.get("beats", []), 1):
        bset = b.get("set") or spec.get("set")
        if b.get("set") and b["set"] not in manifest["sets"]:
            errs.append(f"Beat {i}: unknown set '{b['set']}' (not in assets/manifest.json).")
        named += [(x.get(k), bset) for x in [b] + [w for w in (b.get("with") or []) if isinstance(w, dict)]
                  for k in ("spot", "snap_spot")]
    for spot, st in named:
        spots = manifest["sets"].get(st, {}).get("spots", {})
        if spot and spot not in spots:
            errs.append(f"Unknown spot '{spot}' for set '{st}' (valid: {sorted(spots)}).")

    # Every beat target / partner must be a cast member (a missing target leaves the camera on an empty wall)
    names = {c.get("name") for c in spec.get("cast", [])}
    camera_targets = names | {"Crowd"} | {p.get("name") for p in (spec.get("props") or [])}
    for i, b in enumerate(spec.get("beats", []), 1):
        tgt = b.get("target")
        if tgt and tgt not in camera_targets:
            errs.append(f"Beat {i}: target '{tgt}' is not a cast member, 'Crowd', or a story prop.")
        if tgt == "Crowd" and not any((bb.get("fx") or "") == "crowd_cheer" for bb in spec.get("beats", [])):
            errs.append(f"Beat {i}: target 'Crowd' but no beat spawns the crowd (fx: crowd_cheer).")
        for who in [w.get("name") for w in (b.get("with") or []) if isinstance(w, dict)]:
            if who and who not in names:
                errs.append(f"Beat {i}: '{who}' is not in the cast.")

    errs += check_show_dont_tell(spec, manifest)

    # V6 overhead rule counter: short, bold, emoji-free (story rule numbers only)
    max_len = int(manifest.get("overhead_counter", {}).get("max_len", 18))
    holders = [("cast " + str(c.get("name")), c) for c in spec.get("cast", [])]
    for i, b in enumerate(spec.get("beats", []), 1):
        holders += [(f"beat {i}", b)] + [(f"beat {i} partner {w.get('name')}", w) for w in (b.get("with") or []) if isinstance(w, dict)]
    for where, h in holders:
        if "counter" in h and h["counter"] is not None:
            v = str(h["counter"])
            if len(v) > max_len:
                errs.append(f"{where}: counter '{v}' is longer than {max_len} characters.")
            if not COUNTER_OK.match(v):
                errs.append(f"{where}: counter '{v}' has emoji/special characters (A-Z 0-9 : = + - / ! ? . , # % ' & only).")
        # V6.2 per-beat scale / mid-beat face swap
        if h.get("scale") is not None:
            lo, hi = manifest.get("scale", {}).get("min", 0.2), manifest.get("scale", {}).get("max", 2.5)
            try:
                ok = lo <= float(h["scale"]) <= hi
            except (TypeError, ValueError):
                ok = False
            if not ok:
                errs.append(f"{where}: scale '{h['scale']}' must be a number from {lo} to {hi}.")
        if h.get("face_mid") and h["face_mid"] not in manifest["faces"]:
            errs.append(f"{where}: face_mid '{h['face_mid']}' is not a known face.")

    # V6.2 2D reaction overlays (finish_video.py composites them)
    ov_cfg = manifest.get("overlays", {})
    ov_beats = [(i, b) for i, b in enumerate(spec.get("beats", []), 1) if b.get("overlay")]
    ov_max = COMIC_MAX_OVERLAYS if is_comic(spec) else int(ov_cfg.get("max_per_story", 5))
    if len(ov_beats) > ov_max:
        errs.append(f"{len(ov_beats)} overlays; at most {ov_max} per story.")
    if is_comic(spec) and any(b.get("overlay") == "binary_cta" for _, b in ov_beats):
        errs.append("comic_issue: no binary_cta card (it covers the characters); end on the spoken question.")
    for i, b in enumerate(spec.get("beats", []), 1):
        ov, txt = b.get("overlay"), b.get("overlay_text")
        if ov and ov not in ov_cfg.get("values", []):
            errs.append(f"Beat {i}: overlay '{ov}' unknown (use {ov_cfg.get('values')}).")
        if ov == "bubble":
            t = str(txt or "")
            if not (2 <= len(t) <= int(ov_cfg.get("bubble_text_max", 16))):
                errs.append(f"Beat {i}: bubble overlay_text must be 2-{ov_cfg.get('bubble_text_max', 16)} characters.")
            if not COUNTER_OK.match(t):
                errs.append(f"Beat {i}: overlay_text '{t}' has emoji/special characters.")
        elif ov in ("phone_card", "binary_cta"):
            t, mx = str(txt or ""), int(ov_cfg.get("card_text_max", 64))
            if not (4 <= len(t) <= mx):
                errs.append(f"Beat {i}: {ov} overlay_text must be 4-{mx} characters.")
            if not CARD_OK.match(t):
                errs.append(f"Beat {i}: overlay_text '{t}' has emoji/special characters.")
        elif txt:
            errs.append(f"Beat {i}: overlay_text only goes with overlay: bubble / phone_card / binary_cta.")

    # Required V6 narrative clarity fields
    for k in ("rule", "visible_proof", "personal_stake", "motivated_choice", "rule_payoff"):
        if not (spec.get(k) or "").strip():
            errs.append(f"Missing required story clarity field: '{k}'.")

    # Last-30 channel-wide sameness monitor
    cand_sig = (spec.get("rule_type", ""), spec.get("opening_variant", ""), spec.get("ending_type", ""))
    cand_toks = tokenize(f"{spec.get('title','')} {spec.get('rule','')} {spec.get('rule_payoff','')}")
    sig_hits = 0
    for ep in recent_eps:
        if ep.get("episode_id") == str(spec.get("id", "")):
            continue
        ep_sig = (ep.get("rule_type", ""), ep.get("opening_variant", ""), ep.get("ending_type", ""))
        if all(cand_sig) and cand_sig == ep_sig:
            sig_hits += 1
        sim = jaccard(cand_toks, tokenize(ep.get("title", "")))
        if sim >= float(qa_cfg.get("max_premise_jaccard", 0.42)):
            errs.append(f"Premise too close to episode {ep.get('episode_id')} (Jaccard={sim:.2f}).")
    if sig_hits >= 3:
        errs.append(f"Channel sameness limit hit: pattern {cand_sig} appeared {sig_hits} times in last {len(recent_eps)} uploads.")
    return errs


def run_pre_gate(sdir: Path, cfg: dict, root: Path, db: PipelineDB | None, skip_lint: bool = False) -> tuple[bool, list[str], dict]:
    spec = yaml.safe_load((sdir / "story.yaml").read_text(encoding="utf-8"))
    manifest = json.loads((root / "assets" / "manifest.json").read_text(encoding="utf-8"))
    qa_cfg = cfg["automation"]["qa"]
    recent = db.recent_published(int(qa_cfg.get("sameness_window", 30))) if db else []
    errs = check_manifest_and_sameness(spec, manifest, recent, qa_cfg)
    errs += script_similarity_errors(spec, load_other_scripts(root, sdir), float(qa_cfg.get("max_script_jaccard", 0.42)))
    prev = db.previous_episode(str(spec.get("id", ""))) if db else None
    prev_set = None
    if prev:
        pdir = Path(prev["story_dir"]) if Path(prev["story_dir"]).is_absolute() else root / prev["story_dir"]
        if (pdir / "story.yaml").exists():
            prev_set = (yaml.safe_load((pdir / "story.yaml").read_text(encoding="utf-8")) or {}).get("set")
    errs += check_action_sanity(spec, prev_set)

    # bgm_mood must map to a real file (finish_video.py would silently fall back to the mystery track)
    mood = spec.get("bgm_mood", "mystery")
    bgm = cfg["audio"]["bgm_moods"].get(mood)
    if bgm is None:
        errs.append(f"bgm_mood '{mood}' is not defined in config.yaml audio.bgm_moods.")
    elif bgm and not (root / "assets" / "sfx" / bgm).exists():
        errs.append(f"bgm_mood '{mood}' -> assets/sfx/{bgm} is missing on disk (add the track or pick another mood).")

    jfile = sdir / "judge_result.json"
    if jfile.exists():
        jres = json.loads(jfile.read_text(encoding="utf-8"))
        if not jres.get("pass"):
            errs.append(f"Independent judge rejected story (mean={jres.get('mean_score')}, reason={jres.get('reason')}).")
    else:
        errs.append("Missing judge_result.json (story must pass independent model judge).")

    if not skip_lint and (root / "pipeline" / "preflight_lint.py").exists():
        r = subprocess.run([sys.executable, str(root / "pipeline" / "preflight_lint.py"),
                            "--story", str(sdir / "story.yaml"), "--skip-verify"],
                           capture_output=True, text=True)
        if r.returncode != 0:
            errs.append(f"preflight_lint.py failed: {r.stdout.strip().splitlines()[-1] if r.stdout.strip() else r.stderr.strip()}")

    return len(errs) == 0, errs, {"stage": "pre", "errors": errs}


def ffprobe_json(media_path: Path) -> dict:
    r = subprocess.run(["ffprobe", "-v", "error", "-show_format", "-show_streams", "-of", "json", str(media_path)],
                       capture_output=True, text=True, check=True)
    return json.loads(r.stdout)


def run_audio_gate(sdir: Path, cfg: dict) -> tuple[bool, list[str], dict]:
    qa = cfg["automation"]["qa"]
    errs, metrics = [], {}
    voice = sdir / "voice.mp3"
    if not voice.exists():
        return False, ["Missing voice.mp3"], metrics
    info = ffprobe_json(voice)
    dur = float(info["format"].get("duration", 0))
    metrics["duration"] = round(dur, 2)
    lo, hi = duration_bounds(_story_spec(sdir), qa)
    if not (lo <= dur <= hi):
        errs.append(f"Audio duration {dur:.2f}s outside [{lo}, {hi}]s.")

    # Unplanned silence check
    s_log = subprocess.run(
        ["ffmpeg", "-i", str(voice), "-af", f"silencedetect=noise=-40dB:d={qa['max_silence_sec']}", "-f", "null", "-"],
        capture_output=True, text=True
    ).stderr
    silences = [float(x) for x in re.findall(r"silence_duration:\s*([\d.]+)", s_log)]
    metrics["long_silences"] = silences
    if silences:
        errs.append(f"Unplanned silence >{qa['max_silence_sec']}s detected: {silences}.")

    # Optional ASR round-trip WER check if raw_transcript.txt exists alongside narration.txt
    if (sdir / "narration.txt").exists() and (sdir / "raw_transcript.txt").exists():
        wer = word_error_rate((sdir / "narration.txt").read_text(encoding="utf-8"),
                              (sdir / "raw_transcript.txt").read_text(encoding="utf-8"))
        metrics["asr_wer"] = wer
        if wer > float(qa["max_asr_wer"]):
            errs.append(f"ASR round-trip WER {wer:.1%} exceeds {float(qa['max_asr_wer']):.0%} cap.")

    return len(errs) == 0, errs, metrics


def run_render_gate(video_path: Path, cfg: dict) -> tuple[bool, list[str], dict]:
    qa = cfg["automation"]["qa"]
    errs, metrics = [], {}
    if not video_path.exists():
        return False, [f"Missing video file: {video_path}"], metrics

    info = ffprobe_json(video_path)
    dur = float(info["format"].get("duration", 0))
    vstreams = [s for s in info.get("streams", []) if s.get("codec_type") == "video"]
    astreams = [s for s in info.get("streams", []) if s.get("codec_type") == "audio"]
    if not vstreams:
        return False, ["No video stream found."], metrics
    if not astreams:
        errs.append("No audio stream found.")

    vs = vstreams[0]
    w, h = int(vs.get("width", 0)), int(vs.get("height", 0))
    num, den = (vs.get("r_frame_rate", "0/1").split("/") + ["1"])[:2]
    fps = round(float(num) / max(float(den), 1.0), 2)
    metrics.update({"width": w, "height": h, "fps": fps, "duration": round(dur, 2)})

    if (w, h) != (int(cfg["video"]["width"]), int(cfg["video"]["height"])):
        errs.append(f"Resolution {w}x{h} != {cfg['video']['width']}x{cfg['video']['height']}.")
    if abs(fps - float(cfg["video"]["fps"])) > 0.5:
        errs.append(f"FPS {fps} != {cfg['video']['fps']}.")
    lo, hi = duration_bounds(_story_spec(video_path.parent), qa)
    if not (lo <= dur <= hi):
        errs.append(f"Rendered duration {dur:.2f}s outside [{lo}, {hi}]s.")

    # Black frames & frozen frames
    vf_log = subprocess.run(
        ["ffmpeg", "-i", str(video_path),
         "-vf", f"blackdetect=d={qa['max_black_sec']}:pix_th=0.08,freezedetect=n=-60dB:d=1.0",
         "-an", "-f", "null", "-"],
        capture_output=True, text=True
    ).stderr
    blacks = [float(x) for x in re.findall(r"black_duration:([\d.]+)", vf_log)]
    freezes = [float(x) for x in re.findall(r"freeze_duration:\s*([\d.]+)", vf_log)]
    freeze_pct = round((sum(freezes) / max(dur, 0.1)) * 100.0, 2)
    metrics.update({"black_segments": blacks, "freeze_pct": freeze_pct})
    if blacks:
        errs.append(f"Unplanned black frames detected ({blacks}s).")
    if freeze_pct > float(qa["max_freeze_pct"]):
        errs.append(f"Frozen frames {freeze_pct:.2f}% exceeds {qa['max_freeze_pct']}% cap.")

    # Loudness & True Peak (ebur128)
    eb_log = subprocess.run(
        ["ffmpeg", "-i", str(video_path), "-af", "ebur128=peak=true", "-vn", "-f", "null", "-"],
        capture_output=True, text=True
    ).stderr
    # ebur128 prints a per-frame "I: ... LUFS" line from frame 1 (-70.0 at start); only the final Summary counts.
    m_i = (re.findall(r"I:\s*(-?[\d.]+)\s*LUFS", eb_log) or [None])[-1]
    m_tp = re.search(r"Peak:\s*(-?[\d.]+)\s*dBFS", eb_log)
    if m_i:
        lufs = float(m_i)
        metrics["lufs"] = lufs
        if abs(lufs - float(qa["lufs_target"])) > float(qa["lufs_tol"]):
            errs.append(f"Loudness {lufs:.1f} LUFS outside {qa['lufs_target']} ± {qa['lufs_tol']} LUFS.")
    if m_tp:
        tp = float(m_tp.group(1))
        metrics["true_peak_db"] = tp
        if tp > float(qa["max_true_peak_db"]):
            errs.append(f"True peak {tp:.1f} dB exceeds {qa['max_true_peak_db']} dBTP.")

    metrics["sha256"] = hashlib.sha256(video_path.read_bytes()).hexdigest()[:16]
    return len(errs) == 0, errs, metrics


# === V6 VISION GATE: one Gemini Flash call over the beat contact sheet =============================================
VISION_PROMPT = """You are the visual QA judge for a vertical Roblox story short. The image is a contact sheet: one
labeled frame per beat (in beat order, then the last frame). Below are the beats (number, narration, camera, action,
target, set), the cast (name + gender) and, per set, the valid spot names.

Flag a beat ONLY for a real visual defect that would ruin the Short. Exactly these categories:
  actor_clip - an actor's body visibly passes through furniture, a stage, or a wall
  camera     - the camera clips under the floor (blue/empty void, floor seen from below) or inside geometry, OR the
               beat's target is hidden behind another actor's back/torso filling the frame
  wrong_set  - the whole environment is wrong for the narration (e.g. an outdoor school yard when the line says
               classroom / hallway / auditorium, or an indoor room when it says street)
  wardrobe   - a character clearly looks like the wrong gender, or a leftover/extra character who should not be there
NEVER fail a beat for any of these (they are expected, not defects):
  - small held or ground props that are tiny or hard to see (phone, pebble, paper, card, keys ...)
  - transient motion props that may simply not be in this single mid-beat frame (a flying basketball, a passing truck)
  - reaction closeups where the narration describes a crowd or event shown in an adjacent beat
  - lighting, art style, framing taste, or a prop being small/partly visible
  - a normal tight facial closeup: do NOT flag it as camera clipping unless geometry is visibly cut in half
When unsure, do NOT flag. For each failure say whether a safe automatic fix exists. Only these patch keys are
allowed, with values from the lists given: "cam" (camera preset), "spot" (a spot name valid for that beat's set),
"motion" (camera motion). Only actor_clip and camera problems can be fixable; wrong_set and wardrobe never are.

Return STRICT JSON only, no prose:
{"pass": true|false, "failures": [{"beat": <int>, "category": "actor_clip|camera|wrong_set|wardrobe",
  "issue": "<short>", "fixable": true|false, "patch": {"cam": "...", "spot": "...", "motion": "..."}}]}
Use "pass": true and an empty list when nothing is wrong. Omit patch keys you don't need.
"""


def vision_context(spec: dict, beats: list, manifest: dict) -> str:
    sets = used_sets(spec)
    lines = [f"Beat {b.get('n', i)}: \"{b.get('line', '')}\" cam={b.get('cam')} action={b.get('action')} "
             f"target={sb.get('target', '')} set={sb.get('set') or spec.get('set')}"
             for i, (b, sb) in enumerate(zip(beats, spec.get("beats", [])), 1)]
    cast = ", ".join(f"{c.get('name')} ({c.get('gender')})" for c in spec.get("cast", []))
    spots = "; ".join(f"{st}: {sorted(manifest['sets'].get(st, {}).get('spots', {}))}" for st in sets)
    return (f"Title: {spec.get('title', '')}\nCast: {cast}\nCameras: {manifest['cameras']}\n"
            f"Motions: {manifest['motions']}\nSpots per set: {spots}\n\n" + "\n".join(lines))


def gemini_api_key(root: Path) -> str:
    import os
    key = os.environ.get("GEMINI_API_KEY", "").strip()
    f = root / "secrets" / "gemini_api_key.txt"
    if not key and f.exists():
        key = f.read_text(encoding="utf-8").strip()
    if not key:
        raise RuntimeError("No Gemini key: set GEMINI_API_KEY or create secrets/gemini_api_key.txt")
    return key


def call_gemini(png: bytes, text: str, model: str, key: str) -> dict:
    """Single generateContent call (stdlib only) -> parsed JSON verdict."""
    import base64, urllib.request
    body = {"contents": [{"parts": [{"text": VISION_PROMPT + "\n" + text},
                                    {"inline_data": {"mime_type": "image/png", "data": base64.b64encode(png).decode()}}]}],
            "generationConfig": {"responseMimeType": "application/json", "temperature": 0}}
    req = urllib.request.Request(
        f"https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent",
        data=json.dumps(body).encode(), headers={"Content-Type": "application/json", "x-goog-api-key": key})
    import time, urllib.error
    for attempt in range(2):  # 429 quota / 503 "high demand": one 10 s back-off, then the next fallback model
        try:
            with urllib.request.urlopen(req, timeout=120) as r:
                resp = json.loads(r.read())
            break
        except urllib.error.HTTPError as e:
            if e.code not in (429, 503) or attempt == 1:
                raise RuntimeError(f"Gemini HTTP {e.code}: {e.read()[:300].decode('utf-8', 'replace')}") from e
            time.sleep(10 * 2 ** attempt)
    return json.loads(resp["candidates"][0]["content"]["parts"][0]["text"])


def run_vision_gate(sdir: Path, cfg: dict, root: Path, judge=None) -> tuple[bool, list[str], dict]:
    """Gemini Flash judges rec/qa_beats.png + beats.json + story.yaml in ONE call; verdict -> vision_qa.json.
    `judge(png_bytes, context_text) -> dict` replaces the API (tests). Any API/parse error fails closed."""
    spec = yaml.safe_load((sdir / "story.yaml").read_text(encoding="utf-8"))
    manifest = json.loads((root / "assets" / "manifest.json").read_text(encoding="utf-8"))
    sheet = sdir / "rec" / "qa_beats.png"
    if not sheet.exists():
        return False, [f"Missing contact sheet {sheet} (run run_take.py --final)."], {"stage": "vision"}
    beats = json.loads((sdir / "beats.json").read_text(encoding="utf-8"))
    beats = beats.get("beats", beats) if isinstance(beats, dict) else beats
    text = vision_context(spec, beats, manifest)
    try:
        if judge is None:
            qa = cfg["automation"]["qa"]
            models = [qa.get("gemini_vision_model", "gemini-3.8-flash")] + list(qa.get("gemini_vision_fallbacks") or [])
            key, tried = gemini_api_key(root), []
            for model in models:
                try:
                    verdict = call_gemini(sheet.read_bytes(), text, model, key)
                    verdict["model"] = model
                    break
                except (RuntimeError, TimeoutError, OSError) as e:   # overloaded / unreachable: next model
                    tried.append(f"{model}: {str(e)[:120]}")
            else:
                raise RuntimeError("all vision models failed -> " + " | ".join(tried))
        else:
            verdict = judge(sheet.read_bytes(), text)
        fails = list(verdict.get("failures") or [])
    except Exception as e:  # network, quota, malformed JSON: never pass a video nobody looked at
        verdict, fails = {"pass": False, "error": str(e), "failures": []}, None
    (sdir / "vision_qa.json").write_text(json.dumps(verdict, indent=2), encoding="utf-8")
    if fails is None:
        return False, [f"Vision judge error: {verdict['error']}"], {"stage": "vision", **verdict}
    errs = [f"Beat {f.get('beat')}: [{f.get('category')}] {f.get('issue')}" for f in fails]
    if not verdict.get("pass") and not errs:
        errs = ["Vision judge returned pass=false without failures."]
    return not errs, errs, {"stage": "vision", **verdict}


VISION_PATCH_KEYS = ("cam", "spot", "motion")


def plan_vision_patches(verdict: dict, spec: dict, manifest: dict, max_beats: int = 3) -> dict | None:
    """{beat_number: patch} when EVERY failure is a fixable camera/staging issue with a valid cam/spot/motion
    patch and there are 1..max_beats of them; otherwise None (= quarantine)."""
    fails = verdict.get("failures") or []
    if not 1 <= len(fails) <= max_beats:
        return None
    beats = spec.get("beats", [])
    out = {}
    for f in fails:
        n, patch = f.get("beat"), f.get("patch") or {}
        if (not f.get("fixable") or f.get("category") not in ("camera", "actor_clip") or not isinstance(n, int)
                or not 1 <= n <= len(beats) or not patch or set(patch) - set(VISION_PATCH_KEYS)):
            return None
        bset = beats[n - 1].get("set") or spec.get("set")
        if ("cam" in patch and patch["cam"] not in manifest["cameras"]) \
                or ("motion" in patch and patch["motion"] not in manifest["motions"]) \
                or ("spot" in patch and patch["spot"] not in manifest["sets"].get(bset, {}).get("spots", {})):
            return None
        out.setdefault(n, {}).update(patch)
    return out


def apply_vision_patches(story_yaml: Path, patches: dict) -> None:
    """Write cam/spot/motion patches into story.yaml (original kept once as story.pre_vision.yaml)."""
    backup = story_yaml.with_name("story.pre_vision.yaml")
    if not backup.exists():
        shutil.copy2(story_yaml, backup)
    spec = yaml.safe_load(story_yaml.read_text(encoding="utf-8"))
    for n, patch in patches.items():
        spec["beats"][int(n) - 1].update(patch)
    story_yaml.write_text(yaml.safe_dump(spec, sort_keys=False, allow_unicode=True, width=110), encoding="utf-8")


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--story-dir", required=True)
    p.add_argument("--stage", required=True, choices=["pre", "audio", "render", "vision"])
    p.add_argument("--video", help="Final MP4 path (for --stage render)")
    p.add_argument("--skip-lint", action="store_true")
    p.add_argument("--no-db", action="store_true")
    p.add_argument("--no-quarantine", action="store_true",
                   help="vision: on failure exit 2 without quarantining (daemon decides on one auto-fix retry)")
    a = p.parse_args()

    cfg = load_config()
    sdir = Path(a.story_dir).resolve()
    spec = yaml.safe_load((sdir / "story.yaml").read_text(encoding="utf-8"))
    ep_id = str(spec.get("id", sdir.name.split("_")[0]))
    db = None if a.no_db else PipelineDB(ROOT / "ledger" / "pipeline.db")

    try:
        if a.stage == "pre":
            ok, errs, metrics = run_pre_gate(sdir, cfg, ROOT, db, skip_lint=a.skip_lint)
            next_st, col = "GATE1_PASS", "gate1_json"
        elif a.stage == "audio":
            ok, errs, metrics = run_audio_gate(sdir, cfg)
            next_st, col = "AUDIO_PASS", "gate2_json"
        elif a.stage == "vision":
            ok, errs, metrics = run_vision_gate(sdir, cfg, ROOT)
            next_st, col = None, None          # verdict lives in vision_qa.json; status stays GATE3_PASS
        else:
            vid = Path(a.video) if a.video else (sdir / f"{ep_id}_FINAL.mp4")
            ok, errs, metrics = run_render_gate(vid, cfg)
            next_st, col = "GATE3_PASS", "gate3_json"

        print(f"[QA:{a.stage.upper()}] {'PASS' if ok else 'FAIL'} | {json.dumps(metrics)}")
        if ok:
            if db and next_st:
                extra = {col: json.dumps(metrics)}
                if a.stage == "render" and "sha256" in metrics:
                    extra["render_sha256"] = metrics["sha256"]
                db.set_status(ep_id, next_st, **extra)
        elif a.stage == "vision" and a.no_quarantine:
            log_vision_failures(ROOT, ep_id, spec, metrics, "flagged")
            sys.exit(2)
        else:
            if a.stage == "vision":
                log_vision_failures(ROOT, ep_id, spec, metrics, "quarantine")
            quarantine_episode(sdir, ROOT, a.stage, errs, db, ep_id)
            sys.exit(1)
    finally:
        if db:
            db.close()


if __name__ == "__main__":
    main()
