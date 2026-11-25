"""AI-Vid V6 thumbnail: smart frame pick -> graded 1080x1920 still -> bold hook headline -> <story>/thumbnail.jpg.

  python pipeline/make_thumbnail.py --story-dir stories/<ID>_<slug> [--beat N] [--text "HEADLINE"]

Frame: story.yaml `thumb_beat` (1-based) if set, else the best-scoring beat (camera, face, music cue; motion and
floor shots penalised). The beat's midpoint is pulled from rec/trimmed.mp4 with finish_video.py's exact filter.
Headline: story.yaml `thumb_text` (mark the keyword *like this*), else the emoji-free title, upper-case, max 2 lines.
"""
from __future__ import annotations
import argparse, io, json, re, subprocess, sys
from pathlib import Path
import yaml
from PIL import Image, ImageDraw, ImageEnhance, ImageFilter, ImageFont
from config_loader import load_config

W, H = 1080, 1920
FONTS = [r"C:\Windows\Fonts\ariblk.ttf", r"C:\Windows\Fonts\impact.ttf"]
YELLOW, WHITE, BLACK = (255, 230, 0), (255, 255, 255), (0, 0, 0)
TEXT_TOP, TEXT_BOTTOM = 140, 360           # upper safe zone (clear of Shorts UI)
MAX_JPEG = int(1.9 * 1024 * 1024)          # YouTube custom thumbnail limit is 2 MB


def score_beat(b: dict, timing: dict) -> int:
    s = 0
    cam, face, act = b.get("cam", ""), b.get("face", ""), b.get("action", "")
    s += 3 if cam in ("closeup", "low_hero") else 2 if cam in ("ots", "reverse_ots") else 0
    s += 3 if face in ("shocked", "scared") else 2 if face in ("grin", "determined") else 0
    s += 1 if (timing.get("bgm_duck") or timing.get("bgm_climax") or b.get("bgm_duck") or b.get("bgm_climax")) else 0
    s -= 3 if act in ("fall", "downed", "walk") else 0
    return s


def rank_beats(story_beats: list, timed: list) -> list[int]:
    """0-based beat indices, best thumbnail candidate first. Ties go to the earliest beat (the hook)."""
    scores = [score_beat(story_beats[i] if i < len(story_beats) else {}, timed[i]) for i in range(len(timed))]
    return sorted(range(len(scores)), key=lambda i: (-scores[i], i))


def pick_beat(story_beats: list, timed: list, forced: int | None = None) -> int:
    if forced:
        return max(0, min(int(forced) - 1, len(timed) - 1))
    return rank_beats(story_beats, timed)[0]


def caption_free_time(words: list, start: float, dur: float, lead: float, hold: float) -> float | None:
    """A moment inside the beat (final-video clock) with no caption card on screen, closest to the midpoint."""
    busy = [(w["start"] + lead, max(w["end"], w["start"] + hold) + lead) for w in words]
    mid = start + lead + dur / 2
    cands = [start + lead + dur * k / 20 for k in range(1, 20)]
    free = [t for t in cands if not any(a - 0.04 <= t <= b + 0.04 for a, b in busy)]
    return min(free, key=lambda t: abs(t - mid)) if free else None


def grab_frame(video: Path, t: float, cfg: dict, raw: bool = True) -> Image.Image:
    vf = (f"transpose={cfg['video']['transpose']},crop=iw:min(ih\\,iw*16/9):0:(ih-min(ih\\,iw*16/9))/2,"
          f"scale={W}:{H}:flags=lanczos") if raw else f"scale={W}:{H}:flags=lanczos"   # FINAL is already upright
    png = subprocess.run(["ffmpeg", "-loglevel", "error", "-ss", f"{t:.3f}", "-i", str(video), "-frames:v", "1",
                          "-vf", vf, "-f", "image2pipe", "-vcodec", "png", "-"], capture_output=True, check=True).stdout
    return Image.open(io.BytesIO(png)).convert("RGB")


def grade(img: Image.Image) -> Image.Image:
    img = ImageEnhance.Contrast(img).enhance(1.15)
    img = ImageEnhance.Color(img).enhance(1.22)
    img = ImageEnhance.Sharpness(img).enhance(1.35)
    # top scrim: 55% black at the top edge fading to clear at 28% height (headline backdrop, face untouched)
    scrim = Image.new("L", (W, H), 0)
    top = int(H * 0.28)
    for y in range(top):
        ImageDraw.Draw(scrim).line([(0, y), (W, y)], fill=int(255 * 0.55 * (1 - y / top) ** 1.4))
    # subtle edge vignette: darken only outside a soft centre ellipse
    vig = Image.new("L", (W, H), 255)
    ImageDraw.Draw(vig).ellipse([-W * 0.18, H * 0.06, W * 1.18, H * 0.94], fill=0)
    vig = vig.filter(ImageFilter.GaussianBlur(160)).point(lambda v: int(v * 0.32))
    dark = Image.new("RGB", (W, H), BLACK)
    img = Image.composite(dark, img, scrim)
    return Image.composite(dark, img, vig)


HOOK_PREFIX = re.compile(r"^\s*in this (world|town)\s*,?\s*", re.I)


def headline_words(spec: dict, override: str | None) -> list[tuple[str, bool]]:
    """[(WORD, highlighted)]: the whole hook clause, never cut mid-phrase. A title's "In This World/Town," prefix is
    dropped (the clause is the hook). *word* marks the keyword, else the last word. draw_headline shrinks the font."""
    raw = override or spec.get("thumb_text") or HOOK_PREFIX.sub("", spec.get("title", ""))
    raw = re.sub(r"[^\w\s'!?.,*&-]", "", raw).strip().rstrip(",")
    words = raw.upper().split()
    marked = [i for i, w in enumerate(words) if w.startswith("*") and w.endswith("*") and len(w) > 2]
    words = [w.strip("*") for w in words][:8]   # ponytail: >8 words would get tiny; titles are max 60 chars
    hi = marked[0] if marked and marked[0] < len(words) else len(words) - 1
    return [(w, i == hi) for i, w in enumerate(words)]


def layout(words: list[tuple[str, bool]]) -> list[list[tuple[str, bool]]]:
    """Two balanced lines (1 line for <= 2 words): the split with the shortest longer line."""
    if len(words) <= 2:
        return [words] if words else []
    n = lambda ws: len(" ".join(w for w, _ in ws))
    k = min(range(1, len(words)), key=lambda i: max(n(words[:i]), n(words[i:])))
    return [words[:k], words[k:]]


def draw_headline(img: Image.Image, words: list[tuple[str, bool]]) -> Image.Image:
    lines = layout(words)
    font_path = next((f for f in FONTS if Path(f).exists()), None)
    stroke = 14
    for size in range(190, 40, -4):                                  # largest size that fits 86% width + the zone
        font = ImageFont.truetype(font_path, size) if font_path else ImageFont.load_default(size)
        widths = [font.getlength(" ".join(w for w, _ in ln)) + 2 * stroke for ln in lines]
        line_h = size * 1.05
        if max(widths) <= W * 0.86 and line_h * len(lines) <= TEXT_BOTTOM - TEXT_TOP:
            break
    y0 = TEXT_TOP + ((TEXT_BOTTOM - TEXT_TOP) - line_h * len(lines)) / 2
    shadow = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    text = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    ds, dt = ImageDraw.Draw(shadow), ImageDraw.Draw(text)
    space = font.getlength(" ")
    for li, ln in enumerate(lines):
        x = (W - font.getlength(" ".join(w for w, _ in ln))) / 2
        y = y0 + li * line_h
        for w, hi in ln:
            ds.text((x + 8, y + 10), w, font=font, fill=(0, 0, 0, 170), stroke_width=stroke, stroke_fill=(0, 0, 0, 170))
            dt.text((x, y), w, font=font, fill=YELLOW if hi else WHITE, stroke_width=stroke, stroke_fill=BLACK)
            x += font.getlength(w) + space
    out = img.convert("RGBA")
    out.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(9)))
    out.alpha_composite(text)
    return out.convert("RGB")


def save_jpeg(img: Image.Image, path: Path) -> int:
    for q in (94, 88, 82):
        buf = io.BytesIO(); img.save(buf, "JPEG", quality=q, optimize=True)
        if buf.tell() <= MAX_JPEG or q == 82:
            path.write_bytes(buf.getvalue()); return q


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--story-dir", required=True)
    p.add_argument("--beat", type=int, help="1-based beat override (else story.yaml thumb_beat, else auto)")
    p.add_argument("--text", help="headline override (else story.yaml thumb_text, else title)")
    a = p.parse_args()
    sdir = Path(a.story_dir).resolve()
    spec = yaml.safe_load((sdir / "story.yaml").read_text(encoding="utf-8"))
    timed = json.loads((sdir / "beats.json").read_text(encoding="utf-8"))["beats"]
    cfg = load_config()
    i = pick_beat(spec.get("beats", []), timed, a.beat or spec.get("thumb_beat"))
    start, dur = float(timed[i]["start"]), float(timed[i]["dur"])
    t, raw = start + dur / 2, True
    video = next((v for v in (sdir / "rec" / "trimmed.mp4", sdir / "rec" / "raw.mp4") if v.exists()), None)
    if video is None:
        # raw takes are purged after upload: fall back to the FINAL (captions burned in) at a caption-free moment
        video = next(iter(sorted(sdir.glob("*_FINAL*.mp4"))), None)
        if video is None:
            sys.exit(f"No rec/trimmed.mp4, rec/raw.mp4 or *_FINAL.mp4 in {sdir}")
        raw = False
        words = json.loads((sdir / "words.json").read_text(encoding="utf-8")) if (sdir / "words.json").exists() else []
        lead = float(cfg["video"].get("lead_in_seconds", 0.3))
        hold = float(cfg["captions"].get("min_card_sec", 0.55))
        free = caption_free_time(words, start, dur, lead, hold)
        if free is None and not (a.beat or spec.get("thumb_beat")):
            for j in rank_beats(spec.get("beats", []), timed)[1:6]:   # next-best beats that have a clean moment
                f = caption_free_time(words, float(timed[j]["start"]), float(timed[j]["dur"]), lead, hold)
                if f is not None:
                    i, free = j, f
                    break
        t = free if free is not None else start + lead + dur / 2
        print(f"[thumb] using {video.name}" + ("" if free is not None else " (no caption-free moment in this beat)"))
    img = draw_headline(grade(grab_frame(video, t, cfg, raw)), headline_words(spec, a.text))
    out = sdir / "thumbnail.jpg"
    q = save_jpeg(img, out)
    print(f"THUMBNAIL: {out} | beat {i + 1} @ {t:.2f}s | q={q} | {out.stat().st_size / 1024:.0f} KB")


if __name__ == "__main__":
    main()
