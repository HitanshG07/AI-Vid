"""Zero-token pre-flight quality gate: catches static holds, missing SFX, AI jargon, and pacing bugs BEFORE Studio recording.

Usage:
  python pipeline/preflight_lint.py --story stories/016_slug/story.yaml
"""
import argparse, json, re, sys
from pathlib import Path
import yaml
from config_loader import ROOT, load_config

BANNED_JARGON = {
    "permafrost", "pneumatic", "cryo-architect", "catastrophic", "resonance",
    "tumbler", "pungent", "silhouette", "paradigm", "utilize", "manifested",
}
VALID_GENDERS = {"boy", "girl", "man", "woman"}
# Muted by finish_video.SFX_GAIN (synth noise beds) or not a real SFX: banned. Active = other wavs in assets/sfx/.
MUTED_SFX = {"music_soft", "music_swell", "music_end_chime", "waves", "waves_heavy", "crowd_beach",
             "crowd_cheer", "crickets_waves", "seagulls"}
STOP = set("this that with from have they them then were what when your just into over like been will would could "
           "there their about said says after back down than very more some only even still before again".split())


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--story", required=True)
    p.add_argument("--skip-verify", action="store_true", help="Skip ledger/verification/<ID>.md check (testing only)")
    a = p.parse_args()

    cfg = load_config()
    sp = Path(a.story).resolve()
    sdir = sp.parent
    data = yaml.safe_load(sp.read_text(encoding="utf-8"))

    errors, warns = [], []
    fmt = data.get("format", "story")
    title = data.get("title", "")
    max_shot = float(cfg["video"]["max_shot_seconds"])


    # 0. Web originality verification gate (exempt for beat_drop music edits)
    if fmt != "beat_drop" and not a.skip_verify:
        sid = str(data.get("id", "")).strip()
        vfile = ROOT / "ledger" / "verification" / f"{sid}.md"
        if not vfile.exists():
            errors.append(f"Missing originality receipt: ledger/verification/{sid}.md (web-verify premise + save PASS first).")
        else:
            vtxt = vfile.read_text(encoding="utf-8", errors="replace")
            if not re.search(r"\bPASS\b", vtxt):
                errors.append(f"ledger/verification/{sid}.md does not contain PASS — do not produce unverified/duplicate stories.")

    # 1. Standalone title check
    if re.search(r"\bpart\s*[12]\b", title, re.I) and not data.get("allow_multipart"):
        warns.append(f"Title '{title}' looks like a Part 1/2 split. Viral benchmarks favor standalone Shorts.")

    for k in ("engine", "cta"):
        if not data.get(k):
            warns.append(f"story.yaml has no '{k}:' (V5.4.5 Creativity Protocol, see CORE.md).")

    if "#" in title:
        warns.append(f"Title '{title}' contains hashtags. Keep hashtags in the description only.")

    # 2. Cast gender-lock check
    for c in data.get("cast", []):
        if c.get("gender") not in VALID_GENDERS:
            errors.append(f"Cast '{c.get('name')}' missing valid gender ({VALID_GENDERS}).")

    # 3. Beat cut-ceiling & SFX existence check
    sfx_dir = ROOT / "assets" / "sfx"
    total_dur = 0.0
    all_text = []
    for idx, b in enumerate(data.get("beats", []), 1):
        dur = float(b.get("dur", 0))
        total_dur += dur
        motion = (b.get("motion") or "static").lower()
        if dur > max_shot + 0.2 and not b.get("allow_hold"):  # push_in does NOT excuse a long hold
            errors.append(f"Beat {idx}: {dur:.1f}s exceeds {max_shot:.1f}s cap (motion '{motion}'). Split the beat or set allow_hold: true for a purposeful reveal.")
        sfx = (b.get("sfx") or "").strip()
        if sfx and not (sfx_dir / f"{sfx}.wav").exists():
            warns.append(f"Beat {idx}: SFX '{sfx}.wav' not found in assets/sfx/ (run make_sfx.py or drop a real wav).")
        if b.get("line"):
            all_text.append(b["line"])

    # --- Model Parity Gate (CORE.md): hard numbers. beat_drop stays exempt. ---
    beats = data.get("beats", [])
    if fmt != "beat_drop":
        n = len(beats)
        if not 16 <= n <= 24:
            errors.append(f"Parity: {n} beats (must be 16-24).")
        npause = sum(1 for b in beats if b.get("pause_before") or b.get("pause"))
        if npause > 2:
            errors.append(f"Parity: {npause} beats use pause_before (max 2, twist/reveal only).")
        active = {f.stem for f in sfx_dir.glob("*.wav")} - MUTED_SFX
        bad = sorted({(b.get("sfx") or "").strip() for b in beats if (b.get("sfx") or "").strip() not in active | {""}})
        if bad:
            errors.append(f"Parity: SFX not active (missing file or muted): {', '.join(bad)}.")
        nsfx = sum(1 for b in beats if (b.get("sfx") or "").strip() in active)
        if nsfx < 4:
            errors.append(f"Parity: only {nsfx} beats with active SFX (need >=4, target 5).")
        nwith = sum(1 for b in beats if b.get("with"))
        if nwith < 3:
            errors.append(f"Parity: only {nwith} beats with 'with:' partners (need >=3, target 4).")
        lined = [b for b in beats if (b.get("line") or "").strip()]
        nn = sum(1 for b in lined if (b.get("speaker") or "narrator") != "narrator")
        if lined and nn / len(lined) < 0.30:
            errors.append(f"Parity: non-narrator speaker lines {nn}/{len(lined)} = {nn/len(lined):.0%} (need >=30%).")
        if beats and not (beats[0].get("line") or "").strip() and float(beats[0].get("dur", 0)) > 0.8:
            errors.append("Parity: beat 1 has no line and lasts >0.8s (must speak by 0.6s).")
        pos = {c.get("name"): list(c.get("pos", [0, 0, 0])) for c in data.get("cast", [])}
        for idx, b in enumerate(beats, 1):
            snaps = [(b.get("target"), b.get("snap_to"))] + [(w.get("name"), w.get("snap_to")) for w in b.get("with") or [] if isinstance(w, dict)]
            for who, st in snaps:
                if st and who in pos:
                    pos[who] = [float(x) for x in st]
            moves = [(b.get("target"), b.get("move_to"))] + [(w.get("name"), w.get("move_to")) for w in b.get("with") or [] if isinstance(w, dict)]
            for who, mt in moves:
                if not mt or who not in pos:
                    continue
                if sum((float(x) - float(y)) ** 2 for x, y in zip(mt, pos[who])) ** 0.5 <= 0.5:
                    errors.append(f"Parity: beat {idx} move_to for {who} equals its current position (<=0.5 studs).")
                pos[who] = [float(x) for x in mt]
        # distinctive last-3-lines noun already in the title = spoiler
        tw = {w for w in re.findall(r"[a-z]{4,}", title.lower())} - STOP
        last = {w for b in beats[-3:] for w in re.findall(r"[a-z]{4,}", (b.get("line") or "").lower())} - STOP
        if tw & last:
            warns.append(f"Spoiler risk: title shares word(s) with the last 3 lines: {', '.join(sorted(tw & last))}.")

    if fmt != "beat_drop" and not 40 <= total_dur <= 55:
        warns.append(f"Parity: total {total_dur:.1f}s (target 40-55s).")
    max_total = float(cfg["video"].get("max_standalone_seconds", 60.0))
    if total_dur > max_total and not data.get("allow_long"):
        warns.append(f"Total duration is {total_dur:.1f}s (above {max_total:.0f}s standalone target). Tighten setup unless allow_long: true.")

    # 4. Reading-level / AI jargon check
    joined = " ".join(all_text).lower()
    hits = [w for w in BANNED_JARGON if re.search(rf"\b{re.escape(w)}\b", joined)]
    if hits:
        warns.append(f"Formal/AI jargon detected: {', '.join(sorted(hits))}. Simplify to 5th-grade spoken English.")

    # 5. Format-specific duration & WPM checks
    if fmt == "beat_drop" and total_dur > 58:
        errors.append(f"beat_drop Short is {total_dur:.1f}s (>58s risks Content ID block with licensed Shorts music).")

    words_file = sdir / "words.json"
    if words_file.exists():
        words = json.loads(words_file.read_text(encoding="utf-8"))
        if words:
            spoken_sec = max(words[-1]["end"], 0.1)
            wpm = len(words) / (spoken_sec / 60.0)
            if wpm < cfg["voice"]["target_wpm_min"]:
                warns.append(f"Narration pace is {wpm:.0f} WPM (below viral {cfg['voice']['target_wpm_min']}+ WPM target). Bump speed in config.yaml.")
            elif wpm > cfg["voice"]["target_wpm_max"]:
                warns.append(f"Narration pace is {wpm:.0f} WPM (above {cfg['voice']['target_wpm_max']} WPM). Slightly reduce speed.")
            if fmt != "beat_drop":
                starts, t = [], 0.0
                bj = sdir / "beats.json"  # compiled starts include pauses; fall back to summed dur
                comp = json.loads(bj.read_text(encoding="utf-8")) if bj.exists() else []
                comp = comp.get("beats", comp) if isinstance(comp, dict) else comp
                for i, b in enumerate(beats):
                    st = float(comp[i]["start"]) if i < len(comp) and "start" in comp[i] else t
                    starts.append((st, b)); t += float(b.get("dur", 0))
                for w0, w1 in zip(words, words[1:]):
                    gap = w1["start"] - w0["end"]
                    if gap > 1.2:
                        ok = any(abs(w1["start"] - bs) <= 0.3 and (bb.get("pause_before") or bb.get("pause")) or
                                 (not (bb.get("line") or "").strip() and bs - 0.3 <= w0["end"] <= bs + float(bb.get("dur", 0)) + 0.3)
                                 for bs, bb in starts)
                        if not ok:
                            errors.append(f"Parity: {gap:.1f}s dead-air gap in voice at {w0['end']:.1f}s (max 1.2s).")
            print(f"[INFO] Measured voice.mp3: {len(words)} words in {spoken_sec:.1f}s ({wpm:.0f} WPM)")

    # Story-craft polish (WARN only): star emphasis, word count, custom_props cap
    if fmt not in ("beat_drop",):
        spoken = [(b.get("line") or "").strip() for b in beats if (b.get("line") or "").strip()]
        if spoken:
            nstar = sum(1 for l in spoken if re.search(r"\*[^*\s][^*]*\*", l))
            if nstar / len(spoken) < 0.5:
                warns.append(f"Craft: only {nstar}/{len(spoken)} spoken beats have a *starred* word (aim >=60%, min 50%).")
            nwords = len(re.sub(r"\*", "", " ".join(spoken)).split())
            if nwords > 155 and total_dur <= max_total:
                warns.append(f"Craft: {nwords} spoken words (target 125-150, warn >155). Cut lines.")
    cp = data.get("custom_props")
    if cp is not None and len(cp) > 2:
        warns.append(f"Craft: custom_props lists {len(cp)} (max 2 tiny static Parts).")

    print(f"[LINT] Story {data.get('id')} ({fmt}) | {len(data.get('beats', []))} beats | Est. {total_dur:.1f}s")
    for w in warns:
        print(f"  WARN:  {w}")
    for e in errors:
        print(f"  ERROR: {e}")

    if errors:
        print("PREFLIGHT FAILED — fix errors before Studio recording.")
        sys.exit(1)
    print("PREFLIGHT PASSED.")


if __name__ == "__main__":
    main()
