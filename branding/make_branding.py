"""Make the YouTube channel art for StudVerse Tales (original, Rs 0).

Usage: python branding/make_branding.py
Writes branding/banner_2560x1440.png (YouTube banner; title inside the 1546x423 safe area that shows on every device)
and branding/profile_800x800.png (YouTube crops it to a circle): a classic blocky head with our own grin face
(assets/faces/classic_v1/grin.png) and the gold "brave" outline from story 011, on a studded brick.
"""
from pathlib import Path
from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "branding"
FONT_TITLE = "C:/Windows/Fonts/impact.ttf"
FONT_TAG = "C:/Windows/Fonts/seguibl.ttf"
GOLD, GOLD_HOT = (255, 200, 60), (255, 236, 150)
NAME = "STUDVERSE TALES"
TAGLINE = "One world. One rule. One story."


def gradient(w, h, top, bottom):
    im = Image.new("RGB", (w, h))
    d = ImageDraw.Draw(im)
    for y in range(h):
        k = y / (h - 1)
        d.line([(0, y), (w, y)], fill=tuple(int(a + (b - a) * k) for a, b in zip(top, bottom)))
    return im.convert("RGBA")


def studs(im, box, colour, pitch=64, r=20):
    """Classic brick studs: a light top disc with a darker rim, on a grid."""
    d = ImageDraw.Draw(im)
    x0, y0, x1, y1 = box
    dark = tuple(max(0, c - 40) for c in colour)
    light = tuple(min(255, c + 30) for c in colour)
    y = y0 + pitch // 2
    while y < y1:
        x = x0 + pitch // 2
        while x < x1:
            d.ellipse([x - r, y - r + 6, x + r, y + r + 6], fill=dark)
            d.ellipse([x - r, y - r, x + r, y + r], fill=light)
            x += pitch
        y += pitch


def glow_text(base, xy, text, font, fill, glow, radius=18, stroke=7):
    layer = Image.new("RGBA", base.size, (0, 0, 0, 0))
    ImageDraw.Draw(layer).text(xy, text, font=font, fill=glow, anchor="mm", stroke_width=14, stroke_fill=glow)
    base.alpha_composite(layer.filter(ImageFilter.GaussianBlur(radius)))
    ImageDraw.Draw(base).text(xy, text, font=font, fill=fill, anchor="mm", stroke_width=stroke, stroke_fill=(35, 22, 8))


def blocky(d, x, ground, s, body, outline=None):
    """Simple R6 silhouette (head, torso, arms, legs); optional gold 'brave' outline."""
    parts = [
        (x + 10 * s, ground - 100 * s, x + 42 * s, ground - 70 * s),   # head
        (x, ground - 68 * s, x + 52 * s, ground - 32 * s),             # torso
        (x - 22 * s, ground - 68 * s, x - 2 * s, ground - 34 * s),     # left arm
        (x + 54 * s, ground - 68 * s, x + 74 * s, ground - 34 * s),    # right arm
        (x + 2 * s, ground - 32 * s, x + 24 * s, ground),              # left leg
        (x + 28 * s, ground - 32 * s, x + 50 * s, ground),             # right leg
    ]
    if outline:
        for p in parts:
            d.rectangle([p[0] - 6, p[1] - 6, p[2] + 6, p[3] + 6], fill=outline)
    for p in parts:
        d.rectangle(p, fill=body)


def banner():
    W, H = 2560, 1440
    im = gradient(W, H, (64, 140, 230), (255, 178, 110))
    # low sun with soft halo
    halo = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    hd = ImageDraw.Draw(halo)
    hd.ellipse([1720, 520, 2360, 1160], fill=(255, 220, 150, 120))
    hd.ellipse([1880, 680, 2200, 1000], fill=(255, 244, 200, 255))
    im.alpha_composite(halo.filter(ImageFilter.GaussianBlur(30)))
    d = ImageDraw.Draw(im)
    # sea, then a studded green baseplate as the ground
    d.rectangle([0, 900, W, 1010], fill=(36, 140, 170))
    d.rectangle([0, 1010, W, H], fill=(86, 170, 70))
    studs(im, (0, 1010, W, H), (86, 170, 70), pitch=72, r=22)
    d = ImageDraw.Draw(im)
    # a crowd of blocky characters, all glowing gold except one (story 011's world rule)
    cols = [(230, 90, 90), (70, 140, 230), (250, 200, 60), (120, 200, 120), (240, 160, 210), (160, 110, 230)]
    x, i = 120, 0
    while x < W - 100:
        s = 1.6 if i % 2 else 1.35
        unlit = i == 8
        blocky(d, x, 1012, s, (60, 60, 75) if unlit else cols[i % len(cols)], None if unlit else GOLD)
        x += int(170 * s * 0.75) + 30
        i += 1
    # title + tagline inside the safe area (centre 1280x720, 1546x423)
    cx, cy = W // 2, H // 2
    plate = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(plate).rounded_rectangle([cx - 780, cy - 190, cx + 780, cy + 170], 60, fill=(20, 20, 40, 120))
    im.alpha_composite(plate.filter(ImageFilter.GaussianBlur(4)))
    glow_text(im, (cx, cy - 50), NAME, ImageFont.truetype(FONT_TITLE, 200), (255, 255, 255), GOLD + (235,))
    glow_text(im, (cx, cy + 105), TAGLINE, ImageFont.truetype(FONT_TAG, 64), GOLD_HOT, (0, 0, 0, 150), radius=8, stroke=4)
    im.convert("RGB").save(OUT / "banner_2560x1440.png", optimize=True)


def profile():
    S = 800
    im = gradient(S, S, (64, 140, 230), (255, 178, 110))
    # studded brick behind the head
    brick = (220, 60, 60)
    d = ImageDraw.Draw(im)
    d.rectangle([0, 560, S, S], fill=brick)
    studs(im, (0, 560, S, S), brick, pitch=100, r=30)
    d = ImageDraw.Draw(im)
    # head with gold glow + outline
    head = [170, 140, 630, 600]
    glow = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    ImageDraw.Draw(glow).rounded_rectangle([head[0] - 40, head[1] - 40, head[2] + 40, head[3] + 40], 120, fill=GOLD + (200,))
    im.alpha_composite(glow.filter(ImageFilter.GaussianBlur(28)))
    d = ImageDraw.Draw(im)
    d.rounded_rectangle([head[0] - 16, head[1] - 16, head[2] + 16, head[3] + 16], 96, fill=GOLD)
    d.rounded_rectangle(head, 84, fill=(248, 210, 70))
    # head stud on top (classic Roblox head)
    d.rounded_rectangle([330, 96, 470, 150], 18, fill=(228, 190, 55))
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
