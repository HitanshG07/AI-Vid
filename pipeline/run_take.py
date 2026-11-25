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


AUDIT_FILES = ["{id}_FINAL.mp4", "thumbnail.jpg", "PUBLISH.md", "story.yaml", "beats.json", "judge_result.json",
               "narration.txt", "narration_segments.json", "raw_transcript.txt", "subs.ass", "subs_shifted.ass",
               "voice.mp3", "words.json", "rec/qa_beats.png", "vision_qa.json"]
STORED = {".mp4", ".jpg", ".mp3", ".png"}   # already compressed: store as-is so zipping stays well under a second


def make_audit_zip(sdir: Path, ep_id: str) -> Path:
    """<story>/<ID>_audit.zip with the review bundle; optional files that don't exist are skipped."""
    import zipfile
    out = sdir / f"{ep_id}_audit.zip"
    with zipfile.ZipFile(out, "w") as z:
        for name in AUDIT_FILES:
            f = sdir / name.format(id=ep_id)
            if f.exists():
                z.write(f, f.name, compress_type=zipfile.ZIP_STORED if f.suffix.lower() in STORED else zipfile.ZIP_DEFLATED)
    return out


def purge_intermediates(sdir: Path) -> int:
    """Deletes rec/raw.mp4 + rec/trimmed.mp4 once an episode has passed / uploaded; returns bytes. The <ID>_audit.zip
    is KEPT for auditing (owner 2026-11-25) and only expires via upload_queue's 14-day prune_audit_zips."""
    freed = 0
    for f in [sdir / "rec" / "raw.mp4", sdir / "rec" / "trimmed.mp4"]:
        if f.exists():
            freed += f.stat().st_size
            f.unlink()
    return freed


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
    if raw.exists():  # always re-trim: a retake must never reuse a stale trimmed.mp4
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
    subprocess.run(cmd, check=True)

    # Step 3: beat-aligned QA contact sheet (draft AND final: the vision gate judges rec/qa_beats.png)
    if (sdir / "words.json").exists() and (sdir / "beats.json").exists():
        qa_out = sdir / "rec" / "qa_beats.png"
        subprocess.run([
            sys.executable, str(ROOT / "pipeline" / "qa_sheet.py"),
            "--video", str(out_mp4), "--words", str(sdir / "words.json"),
            "--beats", str(sdir / "beats.json"), "--out", str(qa_out),
        ], check=True)
        print("Inspect QA sheet:", qa_out)

    # V6: graded + headline thumbnail from the best beat, then the audit bundle (includes the contact sheet)
    if a.final:
        subprocess.run([sys.executable, str(ROOT / "pipeline" / "make_thumbnail.py"), "--story-dir", str(sdir)], check=True)
        print("AUDIT ZIP:", make_audit_zip(sdir, str(spec["id"])))


if __name__ == "__main__":
    main()
