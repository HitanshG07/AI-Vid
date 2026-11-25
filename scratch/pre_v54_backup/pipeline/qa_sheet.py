"""Beat-aligned QA contact sheet: one frame at the MIDPOINT of every beat + the last frame (catches black tails).

A uniform 10-frame sheet skipped 63% of the shots in an early story (missed occlusions + whiteouts). Use this instead.
Usage: python pipeline/qa_sheet.py --video stories/001_brave-glow/001_brave-glow_FINAL.mp4 \
         --words stories/001_brave-glow/words.json --beats stories/001_brave-glow/beats.json \
         --lead 0.3 --out stories/001_brave-glow/rec/qa_beats.png
Beat start times are snapped to when each beat's first word is spoken (words.json), so they match the video.
"""
import argparse, json, re, subprocess, tempfile
from pathlib import Path


def beat_starts(beats_json, words_json):
    beats = json.loads(Path(beats_json).read_text(encoding="utf-8"))
    beats = beats.get("beats", beats) if isinstance(beats, dict) else beats
    words = json.loads(Path(words_json).read_text(encoding="utf-8"))
    norm = lambda w: re.sub(r"\W+", "", w).lower()
    ws, i, out = [norm(w["word"]) for w in words], 0, []
    for b in beats:
        first = next((norm(x) for x in (b.get("line") or "").split() if norm(x)), None)
        j = next((k for k in range(i, len(ws)) if ws[k] == first), None) if first else None
        if j is not None:
            out.append(words[j]["start"]); i = j + 1
    return out


def dur(video):
    return float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", video],
                                capture_output=True, text=True).stdout)


def main():
    a = argparse.ArgumentParser()
    for k in ("--video", "--words", "--beats", "--out"):
        a.add_argument(k, required=True)
    a.add_argument("--lead", type=float, default=0.3)
    x = a.parse_args()
    end = dur(x.video)
    st = [s + x.lead for s in beat_starts(x.beats, x.words)]
    times = [(s + e) / 2 for s, e in zip(st, st[1:] + [end])] + [end - 0.05]
    tmp = Path(tempfile.mkdtemp())
    for n, t in enumerate(times):
        label = f"B{n + 1} {t:.1f}s" if n < len(times) - 1 else f"END {t:.1f}s"
        subprocess.run(["ffmpeg", "-loglevel", "error", "-y", "-ss", f"{t:.2f}", "-i", x.video, "-frames:v", "1", "-vf",
                        f"scale=216:384,drawtext=fontfile='C\:/Windows/Fonts/arial.ttf':text='{label}':x=6:y=6:fontsize=20:fontcolor=yellow:box=1:boxcolor=black@0.6",
                        str(tmp / f"{n:03d}.png")], check=True)
    cols = 8
    subprocess.run(["ffmpeg", "-loglevel", "error", "-y", "-framerate", "1", "-i", str(tmp / "%03d.png"), "-vf",
                    f"tile={cols}x{(len(times) + cols - 1) // cols}", "-frames:v", "1", x.out], check=True)
    print(f"{len(times)} frames -> {x.out}")


if __name__ == "__main__":
    main()
