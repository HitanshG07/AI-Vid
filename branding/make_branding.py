"""Make the YouTube channel art for Rulebound Tales (original, Rs 0).

Usage: python branding/make_branding.py
Writes branding/banner_2560x1440.png (YouTube banner; all text inside the 1546x423 safe area that shows on every device)
and branding/profile_800x800.png (round-cropped by YouTube): a classic blocky head wearing our own grin face
(assets/faces/classic_v1/grin.png) with the gold "brave" outline from story 011.
"""
from pathlib import Path
from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "branding"
FONT_TITLE = "C:/Windows/Fonts/impact.ttf"
FONT_TAG = "C:/Windows/Fonts/seguibl.ttf"
GOLD, GOLD_HOT = (255, 200, 60), (255, 236, 150)


def gradient(w, h, top, bottom):
    im = Image.new("RGB", (w, h))
    d = ImageDraw.Draw(im)
    for y in range(h):
        k = y / (h - 1)
        d.line([(0, y), (w, y)], fill=tuple(int(a + (b - a) * k) for a, b in zip(top, bottom)))
    return im


def glow_text(base, xy, text, font, fill, glow, radius=18, anchor="mm"):
    layer = Image.new("RGBA", base.size, (0, 0, 0, 0))
    ImageDraw.Draw(layer).text(xy, text, font=font, fill=glow, anchor=anchor, stroke_width=10, stroke_fill=glow)
    base.alpha_composite(layer.filter(ImageFilter.GaussianBlur(radius)))
    d = ImageDraw.Draw(base)
    d.text(xy, text, font=font, fill=fill, anchor=anchor, stroke_width=6, stroke_fill=(40, 25, 10))


def banner():
    W, H = 2560, 1440
    im = gradient(W, H, (70, 150, 220), (255, 185, 120)).convert("RGBA")
    d = ImageDraw.Draw(im)
    # low sun + sea + sand band (behind the safe area so it reads on TV and phone crops alike)
    sun = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(sun).ellipse([1880, 760, 2200, 1080], fill=(255, 240, 190, 255))
    im.alpha_composite(sun.filter(ImageFilter.GaussianBlur(6)))
    d.rectangle([0, 900, W, 1040], fill=(40, 150, 175))
    d.rectangle([0, 1040, W, H], fill=(232, 200, 150))
    # row of blocky silhouettes, all gold-outlined except one (the story-011 world rule)
    x = 260
    for i in range(14):
        h = 150 if i % 3 else 120
        top = 1040 - h
        col = (40, 40, 60) if i != 9 else (70, 70, 90)
        body = [x, top + 40, x + 46, 1040]
        head = [x + 6, top, x + 40, top + 36]
        if i != 9:
            for box in (body, head):
                d.rectangle([box[0] - 5, box[1] - 5, box[2] + 5, box[3] + 5], fill=GOLD)
        d.rectangle(body, fill=col)
        d.rectangle(head, fill=col)
        x += 150
    # safe area 1546x423 centred
    cx, cy = W // 2, H // 2
    glow_text(im, (cx, cy - 55), "RULEBOUND TALES", ImageFont.truetype(FONT_TITLE, 190), (255, 255, 255), GOLD + (230,))
    glow_text(im, (cx, cy + 105), "In this world, every rule has a story.", ImageFont.truetype(FONT_TAG, 62),
              GOLD_HOT, (0, 0, 0, 160), radius=10)
    im.convert("RGB").save(OUT / "banner_2560x1440.png", optimize=True)


def profile():
    S = 800
    im = gradient(S, S, (70, 150, 220), (255, 185, 120)).convert("RGBA")
    d = ImageDraw.Draw(im)
    pad = 150
    head = [pad, pad + 40, S - pad, S - pad + 40]
    d.rounded_rectangle([head[0] - 22, head[1] - 22, head[2] + 22, head[3] + 22], 90, fill=GOLD)
    d.rounded_rectangle(head, 70, fill=(245, 205, 60))
    face_png = ROOT / "assets" / "faces" / "classic_v1" / "grin.png"
    if face_png.exists():
        face = Image.open(face_png).convert("RGBA").resize((head[2] - head[0], head[3] - head[1]), Image.LANCZOS)
        im.alpha_composite(face, (head[0], head[1]))
    im.convert("RGB").save(OUT / "profile_800x800.png", optimize=True)


if __name__ == "__main__":
    OUT.mkdir(exist_ok=True)
    banner()
    profile()
    print("wrote branding/banner_2560x1440.png and branding/profile_800x800.png")
