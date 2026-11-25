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


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--story", required=True)
    a = p.parse_args()

    cfg = load_config()
    sp = Path(a.story).resolve()
    sdir = sp.parent
    data = yaml.safe_load(sp.read_text(encoding="utf-8"))

    errors, warns = [], []
    fmt = data.get("format", "story")
    title = data.get("title", "")
    max_shot = float(cfg["video"]["max_shot_seconds"])

    # 1. Standalone title check
    if re.search(r"\bpart\s*[12]\b", title, re.I) and not data.get("allow_multipart"):
        warns.append(f"Title '{title}' looks like a Part 1/2 split. Viral benchmarks favor standalone Shorts.")

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
        if dur > max_shot and motion == "static":
            errors.append(f"Beat {idx}: static hold is {dur:.1f}s (max {max_shot:.1f}s). Split beat or add camera motion.")
        elif dur > max_shot + 0.8:
            warns.append(f"Beat {idx}: {dur:.1f}s is long even with motion '{motion}'. Consider splitting into 2 cuts.")
        sfx = (b.get("sfx") or "").strip()
        if sfx and not (sfx_dir / f"{sfx}.wav").exists():
            warns.append(f"Beat {idx}: SFX '{sfx}.wav' not found in assets/sfx/ (run make_sfx.py or drop a real wav).")
        if b.get("line"):
            all_text.append(b["line"])

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
            print(f"[INFO] Measured voice.mp3: {len(words)} words in {spoken_sec:.1f}s ({wpm:.0f} WPM)")

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
