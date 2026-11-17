"""Draw transparent classic-Roblox-style face decals (flat 2D, black ink) for R6 heads.

Usage: python engines/faces/classic_faces.py [out_dir]
Writes <emotion>.png (512x512 RGBA, transparent background) plus _sheet.png for review.
Style target: the finished reference shorts (bold black eyes with a white catch-light,
simple brows, readable mouth shapes), not semi-realistic faces.
"""
import sys
from pathlib import Path
from PIL import Image, ImageDraw

S = 4                 # supersampling factor
W = 512 * S
INK = (20, 20, 20, 255)
WHITE = (255, 255, 255, 255)
TEETH = (250, 250, 250, 255)
TONGUE = (200, 60, 70, 255)
LW = 14 * S           # line width

def P(*v):            # 0..512 coords -> supersampled
    return [x * S for x in v]

def eye(d, cx, cy, rx, ry, look=(0, 0), lid=0.0):
    """Black oval eye with catch-light; lid 0..1 covers the top (tired/determined)."""
    d.ellipse(P(cx - rx, cy - ry, cx + rx, cy + ry), fill=INK)
    hx, hy = cx - rx * 0.35 + look[0], cy - ry * 0.4 + look[1]
    d.ellipse(P(hx - rx * 0.3, hy - ry * 0.25, hx + rx * 0.3, hy + ry * 0.25), fill=WHITE)
    if lid > 0:
        d.rectangle(P(cx - rx - 4, cy - ry - 4, cx + rx + 4, cy - ry + 2 * ry * lid), fill=(0, 0, 0, 0))
        d.line(P(cx - rx - 2, cy - ry + 2 * ry * lid, cx + rx + 2, cy - ry + 2 * ry * lid), fill=INK, width=LW)

def ring_eye(d, cx, cy, r):
    """Wide white eye with small pupil (shock/fear)."""
    d.ellipse(P(cx - r, cy - r * 1.15, cx + r, cy + r * 1.15), fill=WHITE, outline=INK, width=LW)
    d.ellipse(P(cx - r * 0.3, cy - r * 0.3, cx + r * 0.3, cy + r * 0.3), fill=INK)

def brow(d, x1, y1, x2, y2):
    d.line(P(x1, y1, x2, y2), fill=INK, width=int(LW * 1.3))

def neutral(d):
    eye(d, 190, 215, 26, 38); eye(d, 322, 215, 26, 38)
    d.line(P(220, 345, 292, 345), fill=INK, width=LW)

def scared(d):
    ring_eye(d, 188, 220, 40); ring_eye(d, 324, 220, 40)
    brow(d, 145, 168, 220, 146); brow(d, 292, 146, 367, 168)   # inner ends raised = fear
    d.line(P(205, 360, 228, 345, 256, 362, 284, 345, 307, 360), fill=INK, width=LW, joint="curve")

def shocked(d):
    ring_eye(d, 188, 210, 42); ring_eye(d, 324, 210, 42)
    brow(d, 148, 138, 225, 132); brow(d, 287, 132, 364, 138)
    d.ellipse(P(226, 315, 286, 395), fill=INK)

def grin(d):
    eye(d, 190, 205, 24, 34); eye(d, 322, 205, 24, 34)
    brow(d, 158, 150, 220, 142); brow(d, 292, 142, 354, 150)
    d.chord(P(160, 255, 352, 420), 0, 180, fill=INK)
    d.rectangle(P(186, 337, 326, 362), fill=TEETH)                 # top teeth just inside the mouth line

def determined(d):
    eye(d, 190, 222, 26, 32, lid=0.35); eye(d, 322, 222, 26, 32, lid=0.35)
    brow(d, 150, 160, 222, 186); brow(d, 290, 186, 362, 160)
    d.line(P(212, 350, 300, 340), fill=INK, width=LW)

def proud(d):
    eye(d, 190, 212, 26, 36, look=(0, -4)); eye(d, 322, 212, 26, 36, look=(0, -4))
    brow(d, 155, 150, 222, 140); brow(d, 290, 140, 357, 150)
    d.arc(P(200, 290, 312, 370), 15, 165, fill=INK, width=LW)

EMOTIONS = {"neutral": neutral, "scared": scared, "shocked": shocked,
            "grin": grin, "determined": determined, "proud": proud}

def render(fn):
    im = Image.new("RGBA", (W, W), (0, 0, 0, 0))
    fn(ImageDraw.Draw(im))
    # zoom ~1.3x around the feature centre: on an R6 head the features must fill the face like the reference shorts
    c = 56 * S, 60 * S, 456 * S, 460 * S
    return im.crop(c).resize((512, 512), Image.LANCZOS)

def main(out):
    out.mkdir(parents=True, exist_ok=True)
    sheet = Image.new("RGBA", (512 * 3, 512 * 2), (232, 190, 150, 255))  # skin-tone backdrop for review
    for i, (name, fn) in enumerate(EMOTIONS.items()):
        im = render(fn)
        assert im.getpixel((5, 5))[3] == 0, f"{name}: background not transparent"
        im.save(out / f"{name}.png")
        sheet.alpha_composite(im, ((i % 3) * 512, (i // 3) * 512))
    sheet.save(out / "_sheet.png")
    print(f"wrote {len(EMOTIONS)} faces + _sheet.png to {out}")

if __name__ == "__main__":
    main(Path(sys.argv[1]) if len(sys.argv) > 1 else Path("assets/faces/classic_v1"))
