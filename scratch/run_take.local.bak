"""AI-Vid V5 1-Command Post-Record Runner: auto-trim raw take -> fast draft + QA sheet OR 1080p final + thumbnail.

Usage:
  1. Record via record_take.py (preserving ClipCursor 900,12 rule) -> stories/<ID>_<slug>/rec/raw.mp4
  2. Fast QA loop (~10s):   python pipeline/run_take.py --story-dir stories/<ID>_<slug> --draft
  3. Final 1080p export:    python pipeline/run_take.py --story-dir stories/<ID>_<slug> --final
"""
import argparse, subprocess, sys
from pathlib import Path
import yaml
from config_loader import ROOT


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--story-dir", required=True)
    p.add_argument("--raw", help="Override raw take path (default: <story-dir>/rec/raw.mp4)")
    p.add_argument("--draft", action="store_true")
    p.add_argument("--final", action="store_true")
    a = p.parse_args()
    if not a.draft and not a.final:
        a.draft = True

    sdir = Path(a.story_dir).resolve()
    spec = yaml.safe_load((sdir / "story.yaml").read_text(encoding="utf-8"))
    fmt = spec.get("format", "story")
    mood = spec.get("bgm_mood", "mystery")
    raw = Path(a.raw) if a.raw else (sdir / "rec" / "raw.mp4")
    trimmed = sdir / "rec" / "trimmed.mp4"

    # Step 1: Trim leading black frames using existing record_take.py
    if raw.exists() and not trimmed.exists():
        subprocess.run([sys.executable, str(ROOT / "pipeline" / "record_take.py"), "--trim", str(raw), "--out", str(trimmed)], check=True)
    src_vid = trimmed if trimmed.exists() else raw

    # Step 2: Finish draft or final
    out_mp4 = sdir / (f"{spec['id']}_draft.mp4" if a.draft else f"{spec['id']}_FINAL.mp4")
    cmd = [
        sys.executable, str(ROOT / "pipeline" / "finish_video.py"),
        "--raw", str(src_vid), "--part-dir", str(sdir), "--out", str(out_mp4),
        "--bgm-mood", mood,
    ]
    if fmt == "beat_drop":
        cmd.append("--music-only")
    if a.draft:
        cmd.append("--draft")
    else:
        cmd += ["--thumb-at", str(spec.get("thumb_at", 1.5))]
    subprocess.run(cmd, check=True)

    # Step 3: Auto-generate beat-aligned QA contact sheet on draft
    if a.draft and (sdir / "words.json").exists() and (sdir / "beats.json").exists():
        qa_out = sdir / "rec" / "qa_beats.png"
        subprocess.run([
            sys.executable, str(ROOT / "pipeline" / "qa_sheet.py"),
            "--video", str(out_mp4), "--words", str(sdir / "words.json"),
            "--beats", str(sdir / "beats.json"), "--out", str(qa_out),
        ], check=True)
        print("Inspect QA sheet:", qa_out)


if __name__ == "__main__":
    main()
