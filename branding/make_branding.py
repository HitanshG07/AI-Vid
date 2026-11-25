"""Make the YouTube channel art for StudVerse Tales from REAL Roblox Studio captures of the story 001 cast.

Usage: python branding/make_branding.py
Inputs (captured in Studio from workspace.Set_Beach001 + Cast_001, golden-hour grade, gold "brave" outlines on):
  branding/src/banner_capture.jpg  - cast in two groups with a centre gap (title goes in the gap)
  branding/src/profile_capture.jpg - Kai close-up (optional; falls back to a crop of the banner capture)
Outputs: branding/banner_2560x1440.png, branding/profile_800x800.png
YouTube shows only the centre 2560x423 strip on desktop and 1546x423 on phones, so the cast and title live in that strip.
"""
from pathlib import Path
from PIL import Image, ImageDraw, ImageFilter, ImageFont, ImageEnhance

ROOT = Path(__file__).resolve().parent.parent
SRC, OUT = ROOT / "branding" / "src", ROOT / "branding"
FONT_TITLE = "C:/Windows/Fonts/impact.ttf"
FONT_TAG = "C:/Windows/Fonts/seguibl.ttf"
GOLD, GOLD_HOT, INK = (255, 200, 60), (255, 236, 150), (30, 18, 6)


def cover(im, w, h, cy_frac=0.5, scale=None):
    s = scale or max(w / im.width, h / im.height)
    im = im.resize((round(im.width * s), round(im.height * s)), Image.LANCZOS)
    x0 = (im.width - w) // 2
    y0 = min(max(0, round(im.height * cy_frac - h / 2)), im.height - h)
    return im.crop((x0, y0, x0 + w, y0 + h))


def grade(im):
    im = ImageEnhance.Color(im).enhance(1.15)
    im = ImageEnhance.Contrast(im).enhance(1.06)
    return im.filter(ImageFilter.UnsharpMask(radius=2, percent=90, threshold=2))


def glow_text(base, xy, text, font, fill, glow, blur=16, stroke=8, glow_w=16):
    layer = Image.new("RGBA", base.size, (0, 0, 0, 0))
    ImageDraw.Draw(layer).text(xy, text, font=font, fill=glow, anchor="mm", stroke_width=glow_w, stroke_fill=glow)
    base.alpha_composite(layer.filter(ImageFilter.GaussianBlur(blur)))
    ImageDraw.Draw(base).text(xy, text, font=font, fill=fill, anchor="mm", stroke_width=stroke, stroke_fill=INK)


def banner():
    W, H = 2560, 1440
    cap = Image.open(SRC / "banner_capture.jpg").convert("RGB")
    im = grade(cover(cap, W, H, cy_frac=0.485, scale=1.5)).convert("RGBA")
    # warm golden-hour wash + soft vignette so the title pops
    wash = Image.new("RGBA", (W, H), (255, 170, 80, 38))
    im.alpha_composite(wash)
    vig = Image.new("L", (W, H), 0)
    ImageDraw.Draw(vig).ellipse([-500, -300, W + 500, H + 300], fill=255)
    vig = vig.filter(ImageFilter.GaussianBlur(220))
    dark = Image.new("RGBA", (W, H), (10, 10, 25, 150))
    dark.putalpha(Image.eval(vig, lambda v: 150 - v * 150 // 255))
    im.alpha_composite(dark)
    # title stacked in the centre gap, inside the 1546x423 safe strip (y 508..931)
    cx = W // 2
    glow_text(im, (cx, 630), "STUDVERSE", ImageFont.truetype(FONT_TITLE, 170), (255, 255, 255), GOLD + (240,))
    glow_text(im, (cx, 785), "TALES", ImageFont.truetype(FONT_TITLE, 150), GOLD_HOT, GOLD + (220,))
    glow_text(im, (cx, 895), "ONE WORLD · ONE RULE · ONE STORY", ImageFont.truetype(FONT_TAG, 44), (255, 255, 255),
              (0, 0, 0, 170), blur=8, stroke=4, glow_w=10)
    im.convert("RGB").save(OUT / "banner_2560x1440.png", optimize=True)


def profile():
    S = 800
    p = SRC / "profile_capture.jpg"
    if p.exists():
        # head + shoulders square around Kai's face in the 1884x970 capture
        im = grade(Image.open(p).convert("RGB").crop((560, 70, 1340, 850)).resize((S, S), Image.LANCZOS)).convert("RGBA")
    else:
        cap = Image.open(SRC / "banner_capture.jpg").convert("RGB")
        im = grade(cover(cap.crop((1180, 300, 1460, 580)), S, S)).convert("RGBA")
    # gold ring that survives YouTube's circle crop
    ring = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(ring)
    d.ellipse([10, 10, S - 10, S - 10], outline=GOLD + (255,), width=26)
    glow = ring.filter(ImageFilter.GaussianBlur(14))
    im.alpha_composite(glow)
    im.alpha_composite(ring)
    im.convert("RGB").save(OUT / "profile_800x800.png", optimize=True)


if __name__ == "__main__":
    banner()
    profile()
    print("wrote branding/banner_2560x1440.png and branding/profile_800x800.png")
