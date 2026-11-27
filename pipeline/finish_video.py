"""AI-Vid V5 Finisher: rotate rolled Studio take -> 1080x1920 @30fps + safe-zone subs + SFX + mood BGM + optional thumbnail.

New in V5:
  - --draft       : ultra-fast 480x854 preview in ~5s for instant QA
  - --bgm-mood    : mystery | action | wholesome | dark | none (from config.yaml, falls back to roblox-story-bg.mp3)
  - --music-only  : for beat_drop Shorts without voice.mp3 (mixes SFX + optional bed; attach trending track in YouTube Shorts)
  - --thumb-at    : auto-extract clean caption-free 1080x1920 thumbnail.jpg at <sec>
"""
import argparse, json, re, subprocess
from pathlib import Path
from config_loader import ROOT, load_config

SFX_DIR = ROOT / "assets" / "sfx"
SFX_GAIN = {
    "tick": 0.25, "ding": 0.30, "piano_note": 0.35, "whoosh": 0.38, "whoosh_hit": 0.28,
    "whoosh_rewind": 0.28, "thunder": 0.32, "bell_clang_loud": 0.38, "ignite_shimmer": 0.34,
    "ignite_shimmer_big": 0.40, "bass_hit": 0.36, "thud": 0.38, "glass_clink": 0.34,
    # Synthesized noise beds remain muted; drop real CC0 wavs to enable
    "music_soft": 0, "music_swell": 0, "music_end_chime": 0, "waves": 0, "waves_heavy": 0,
    "crowd_beach": 0, "crowd_cheer": 0, "crickets_waves": 0, "seagulls": 0,
}


def load_beats(beats_json: Path | None) -> list:
    if not beats_json or not beats_json.exists():
        return []
    raw = json.loads(beats_json.read_text(encoding="utf-8"))
    return raw.get("beats", raw) if isinstance(raw, dict) else raw


def build_bgm_volume_expr(beats: list, lead: float, base_g: float, duck_g: float, climax_g: float) -> str:
    """ffmpeg volume expr: base gain, near-silence on bgm_duck beats (music drop), louder on bgm_climax beats."""
    expr = f"{base_g:.3f}"
    for b in reversed(beats):
        t0 = float(b.get("start", 0.0)) + lead
        t1 = t0 + float(b.get("dur", 1.8))
        if b.get("bgm_duck"):
            expr = f"if(between(t,{t0:.2f},{t1:.2f}),{duck_g:.3f},{expr})"
        elif b.get("bgm_climax"):
            expr = f"if(between(t,{t0:.2f},{t1:.2f}),{climax_g:.3f},{expr})"
    return expr


# ponytail: SFX are still synthesized sine beeps (make_sfx.py); swap in owner-sourced CC0 wavs in assets/sfx/ -- do not auto-download.
def sfx_cues(beats: list, words_json: Path | None):
    words = json.loads(words_json.read_text(encoding="utf-8")) if (words_json and words_json.exists()) else []
    norm = lambda w: re.sub(r"\W+", "", w).lower()
    ws, i, cues, missing = [norm(w["word"]) for w in words], 0, [], []
    for b in beats:
        name = (b.get("sfx") or "").strip()
        if not name:
            continue
        if not (SFX_DIR / f"{name}.wav").exists():
            missing.append(name)
            continue
        t_sec = float(b.get("start", 0.0))
        if words and (b.get("line") or "").strip():
            first = next((norm(x) for x in b["line"].split() if norm(x)), None)  # first-word match, same as compile (ponytail: 1 word)
            j = next((k for k in range(i, len(ws)) if ws[k] == first), None) if first else None
            if j is not None:
                t_sec = words[j]["start"]
                i = j + 1
        g = SFX_GAIN.get(name, 0.38)
        if g > 0:
            cues.append((t_sec, SFX_DIR / f"{name}.wav", g))
    return cues, missing


# ---- V6.2 editing energy: 2D reaction overlays + beat punch-zooms ------------------------------------------------
OVERLAY_SECS = {"sweat": 1.1, "hearts": 1.4, "bubble": 1.1, "flash_red_blue": 1.2, "phone_card": 1.6, "binary_cta": 2.0, "speedlines": 1.0, "crimson_vignette": 1.3}
FONT_BOLD = "C:/Windows/Fonts/arialbd.ttf"
CARDS = {"phone_card": ((90, 180, 990, 390), (255, 77, 94)), "binary_cta": ((90, 120, 990, 230), (56, 189, 248))}  # V6.4: compact top pill (manual use only)
FONT_BLACK = "C:/Windows/Fonts/ariblk.ttf"


def _heart(dr, cx, cy, r, fill):
    dr.ellipse([cx - r, cy - r, cx, cy], fill=fill, outline=(60, 0, 30, 255), width=3)
    dr.ellipse([cx, cy - r, cx + r, cy], fill=fill, outline=(60, 0, 30, 255), width=3)
    dr.polygon([(cx - r, cy - r * 0.45), (cx + r, cy - r * 0.45), (cx, cy + r)], fill=fill)


def _wrap(dr, text, font, maxw):
    lines, cur = [], ""
    for wd in text.split():
        nxt = (cur + " " + wd).strip()
        if cur and dr.textlength(nxt, font=font) > maxw:
            lines.append(cur); cur = wd
        else:
            cur = nxt
    return lines + ([cur] if cur else [])


def _card(kind, text):
    """Full-frame 1080x1920 RGBA: rounded #121622 card, 6px accent border, accent title + wrapped white body.
    Fonts shrink until title + body fit inside the box (never clips, never reaches the MarginV=560 subtitle zone)."""
    from PIL import Image, ImageDraw, ImageFont
    (x0, y0, x1, y1), acc = CARDS[kind]
    title, _, body = (s.strip() for s in text.partition("|"))
    if kind == "binary_cta":
        title, body = title.upper(), body.upper()
    im = Image.new("RGBA", (1080, 1920), (0, 0, 0, 0)); dr = ImageDraw.Draw(im)
    dr.rounded_rectangle([x0, y0, x1, y1], radius=24, fill=(18, 22, 34, 245), outline=acc + (255,), width=6)
    pad, maxw = 36, (x1 - x0) - 72
    for size in range(60, 17, -2):
        tf, bf = ImageFont.truetype(FONT_BLACK, size), ImageFont.truetype(FONT_BOLD, size)
        tl, bl = _wrap(dr, title, tf, maxw), _wrap(dr, body, bf, maxw)
        lh = int(size * 1.22)
        if (len(tl) + len(bl)) * lh <= (y1 - y0) - 2 * pad and all(dr.textlength(s, font=tf) <= maxw for s in tl)                 and all(dr.textlength(s, font=bf) <= maxw for s in bl):
            break
    y = y0 + ((y1 - y0) - (len(tl) + len(bl)) * lh) / 2
    for s, f, col in [(s, tf, acc + (255,)) for s in tl] + [(s, bf, (255, 255, 255, 255)) for s in bl]:
        dr.text((540, y + lh / 2), s, font=f, fill=col, anchor="mm"); y += lh
    return im


def make_overlay_png(kind: str, text: str, out: Path, w: int, h: int) -> Path:
    """Transparent RGBA PNG for one overlay, drawn at 1080x1920 scale then resized to the output width."""
    from PIL import Image, ImageDraw, ImageFont, ImageFilter
    k = w / 1080
    if kind in CARDS:
        _card(kind, text).resize((w, h)).save(out)
        return out
    if kind == "speedlines":  # radial anime lines; centre (r < 350) stays clear
        import math, random
        rnd = random.Random(42)
        im = Image.new("RGBA", (1080, 1920), (0, 0, 0, 0)); dr = ImageDraw.Draw(im)
        for _ in range(95):
            a, r0 = rnd.uniform(0, 2 * math.pi), rnd.uniform(350, 520)
            c, s = math.cos(a), math.sin(a)
            dr.line([(540 + c * r0, 960 + s * r0), (540 + c * 1220, 960 + s * 1220)],
                    fill=(255, 255, 255, rnd.randint(95, 195)), width=rnd.randint(3, 8))
        im.resize((w, h)).save(out)
        return out
    if kind == "crimson_vignette":
        mask = Image.new("L", (1080, 1920), 0)
        ImageDraw.Draw(mask).rectangle([0, 0, 1079, 1919], outline=255, width=150)
        mask = mask.filter(ImageFilter.GaussianBlur(70)).point(lambda v: int(v * 0.35))
        im = Image.new("RGBA", (1080, 1920), (255, 35, 55, 0)); im.putalpha(mask)
        im.resize((w, h)).save(out)
        return out
    if kind == "sweat":
        im = Image.new("RGBA", (140, 190), (0, 0, 0, 0)); dr = ImageDraw.Draw(im)
        dr.polygon([(70, 8), (122, 112), (18, 112)], fill=(80, 170, 255, 255))
        dr.ellipse([18, 70, 122, 182], fill=(80, 170, 255, 255), outline=(10, 40, 90, 255), width=6)
        dr.line([(70, 8), (18, 112)], fill=(10, 40, 90, 255), width=6); dr.line([(70, 8), (122, 112)], fill=(10, 40, 90, 255), width=6)
        dr.ellipse([42, 110, 64, 140], fill=(255, 255, 255, 230))
    elif kind == "hearts":
        im = Image.new("RGBA", (1080, 520), (0, 0, 0, 0)); dr = ImageDraw.Draw(im)
        for cx, cy, r in ((110, 380, 46), (200, 200, 34), (930, 420, 50), (990, 230, 36), (860, 90, 30)):
            _heart(dr, cx, cy, r, (255, 90, 160, 255))
    elif kind == "bubble":
        font = ImageFont.truetype(FONT_BLACK, 84)
        tw, th = font.getbbox(text)[2:]
        bw, bh = tw + 110, th + 90
        im = Image.new("RGBA", (bw + 20, bh + 70), (0, 0, 0, 0)); dr = ImageDraw.Draw(im)
        dr.polygon([(bw * 0.30, bh), (bw * 0.46, bh), (bw * 0.26, bh + 58)], fill=(255, 255, 255, 255), outline=(0, 0, 0, 255))
        dr.line([(bw * 0.30, bh - 2), (bw * 0.26, bh + 58), (bw * 0.46, bh - 2)], fill=(0, 0, 0, 255), width=6)
        dr.rounded_rectangle([10, 10, bw, bh], radius=48, fill=(255, 255, 255, 255), outline=(0, 0, 0, 255), width=6)
        dr.polygon([(bw * 0.31, bh - 4), (bw * 0.45, bh - 4), (bw * 0.28, bh + 48)], fill=(255, 255, 255, 255))
        dr.text((10 + bw / 2 - 5, 10 + bh / 2 - 8), text, font=font, fill=(0, 0, 0, 255), anchor="mm")
    else:  # flash_red_blue: one edge vignette per colour (red file, blue file)
        mask = Image.new("L", (1080, 1920), 0); md = ImageDraw.Draw(mask)
        md.rectangle([0, 0, 1079, 1919], outline=255, width=150)
        mask = mask.filter(ImageFilter.GaussianBlur(70)).point(lambda v: int(v * 0.22))
        for tag, col in (("red", (255, 30, 30)), ("blue", (30, 80, 255))):
            im = Image.new("RGBA", (1080, 1920), col + (0,)); im.putalpha(mask)
            im.resize((w, h)).save(out.with_name(out.stem + f"_{tag}.png"))
        return out
    im.resize((max(2, int(im.width * k)), max(2, int(im.height * k)))).save(out)
    return out


def punch_zoom_vf(beats: list, lead: float) -> str:
    """1.07x -> 1.00x over 0.20 s at each impact beat start (bgm_duck / bgm_climax / shocked or scared face)."""
    ts = [float(b["start"]) + lead for b in beats
          if b.get("bgm_duck") or b.get("bgm_climax") or b.get("face") in ("shocked", "scared")]
    if not ts:
        return ""
    z = "1+0.07*(" + "+".join(f"max(0,1-(t-{t:.3f})/0.2)*gte(t,{t:.3f})" for t in ts) + ")"
    return f",scale=w='trunc(iw*({z})/2)*2':h='trunc(ih*({z})/2)*2':eval=frame,crop=iw0:ih0"


def progress_bar(cur: str, w: int, h: int, dur: float) -> list[str]:
    """Thin top bar (y=12, h=8, 24px side padding): dark track + gold fill growing 0->100% over dur.
    Built from in-graph color sources, so it adds no '-i' inputs and never shifts overlay_base_idx."""
    k = w / 1080
    bw, bh, x, y = w - 2 * round(24 * k), max(2, round(8 * k)), round(24 * k), round(12 * k)
    return [f"color=c=black@0.45:s={bw}x{bh},format=rgba[pbt]", f"color=c=0xFFD43B@0.95:s={bw}x{bh},format=rgba[pbf]",
            f"[pbt][pbf]overlay=x='-W+W*min(1,t/{dur:.3f})':y=0[pbb]",
            f"[{cur}][pbb]overlay={x}:{y}:shortest=1[pb]"]


def video_graph(base_vf: str, ass_vf: str, beats: list, lead: float, w: int, h: int, first_idx: int, outdir: Path,
                bar_dur: float = 0.0):
    """[0:v] -> zoom -> overlays -> progress bar -> subtitles -> [v]. Returns (extra ffmpeg inputs, filtergraph)."""
    zoom = punch_zoom_vf(beats, lead).replace("crop=iw0:ih0", f"crop={w}:{h}")
    ins, g, cur, idx = [], [f"[0:v]{base_vf}{zoom}[z0]"], "z0", first_idx
    k = w / 1080
    for n, b in enumerate(beats):
        kind = b.get("overlay")
        if kind not in OVERLAY_SECS:
            continue
        t0 = float(b["start"]) + lead; t1 = t0 + OVERLAY_SECS[kind]
        png = make_overlay_png(kind, (lambda s: s if kind in CARDS else s.upper())(str(b.get("overlay_text", ""))), outdir / f"ov_{n:02d}_{kind}.png", w, h)
        en = f"between(t,{t0:.3f},{t1:.3f})"
        if kind == "flash_red_blue":
            for tag, cond in (("red", "lt(mod(t,0.3),0.15)"), ("blue", "gte(mod(t,0.3),0.15)")):
                ins += ["-loop", "1", "-i", str(png.with_name(png.stem + f"_{tag}.png"))]
                g.append(f"[{cur}][{idx}:v]overlay=0:0:enable='{en}*{cond}':shortest=1[o{idx}]"); cur, idx = f"o{idx}", idx + 1
            continue
        ins += ["-loop", "1", "-i", str(png)]
        p = f"(t-{t0:.3f})/{t1 - t0:.3f}"
        xy = {"sweat": (f"{760 * k:.0f}", f"{380 * k:.0f}+{60 * k:.0f}*{p}"),
              "hearts": ("0", f"{700 * k:.0f}-{220 * k:.0f}*{p}"),
              "bubble": ("(W-w)/2", f"{300 * k:.0f}"), "phone_card": ("0", "0"), "binary_cta": ("0", "0"),
              "speedlines": ("0", "0"), "crimson_vignette": ("0", "0")}[kind]
        g.append(f"[{cur}][{idx}:v]overlay=x='{xy[0]}':y='{xy[1]}':enable='{en}':shortest=1[o{idx}]"); cur, idx = f"o{idx}", idx + 1
    if bar_dur > 0:
        g += progress_bar(cur, w, h, bar_dur); cur = "pb"
    g.append(f"[{cur}]{ass_vf.lstrip(',') or 'null'}[v]")
    return ins, ";".join(g)


def overlay_base_idx(ins: list, music_only: bool) -> int:
    """ffmpeg input index of the first overlay PNG: [0]=raw, [1]=voice (unless music-only), then one per '-i' in ins
    (SFX cues + BGM). Counting list items instead would also count '-stream_loop', '-1' and file names."""
    return (1 if music_only else 2) + ins.count("-i")


def shift_ass(src: Path, dst: Path, secs: float):
    fmt = lambda t: f"{int(t // 3600)}:{int(t % 3600 // 60):02d}:{t % 60:05.2f}"
    parse = lambda s: int(s.split(":")[0]) * 3600 + int(s.split(":")[1]) * 60 + float(s.split(":")[2])
    out = []
    for line in src.read_text(encoding="utf-8").splitlines():
        if line.startswith("Dialogue:"):
            head, rest = line.split(":", 1)
            f = rest.split(",", 9)
            f[1], f[2] = fmt(parse(f[1].strip()) + secs), fmt(parse(f[2].strip()) + secs)
            line = head + ":" + ",".join(f)
        out.append(line)
    dst.write_text("\n".join(out) + "\n", encoding="utf-8")


def main():
    cfg = load_config()
    p = argparse.ArgumentParser()
    p.add_argument("--raw", required=True)
    p.add_argument("--part-dir", required=True)
    p.add_argument("--out", required=True)
    p.add_argument("--lead", type=float, default=float(cfg["video"]["lead_in_seconds"]))
    p.add_argument("--end", type=float, default=None)
    p.add_argument("--beats", help="beats.json path")
    p.add_argument("--bgm-mood", default="mystery", choices=list(cfg["audio"]["bgm_moods"].keys()))
    p.add_argument("--bgm-gain", type=float, default=float(cfg["audio"]["bgm_gain"]))
    p.add_argument("--transpose", default=str(cfg["video"]["transpose"]))
    p.add_argument("--music-only", action="store_true", help="No voice.mp3 (for beat_drop Shorts)")
    p.add_argument("--draft", action="store_true", help="Fast 480x854 ultrafast preview for QA")
    p.add_argument("--thumb-at", type=float, default=None, help="Extract clean caption-free thumbnail.jpg at <sec>")
    a = p.parse_args()

    d = Path(a.part_dir)
    w, h = (480, 854) if a.draft else (cfg["video"]["width"], cfg["video"]["height"])
    base_vf = f"transpose={a.transpose},crop=iw:min(ih\\,iw*16/9):0:(ih-min(ih\\,iw*16/9))/2,scale={w}:{h}:flags=lanczos,fps={cfg['video']['fps']}"

    if a.thumb_at is not None and not a.draft:
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-ss", f"{a.thumb_at:.2f}", "-i", a.raw,
                        "-frames:v", "1", "-vf", base_vf, str(d / "thumbnail.jpg")], check=True)
        print("THUMBNAIL:", d / "thumbnail.jpg")

    vf = ""   # subtitles only; the full chain is built by video_graph()
    if not a.music_only and (d / "subs.ass").exists():
        subs = d / "subs_shifted.ass"
        shift_ass(d / "subs.ass", subs, a.lead)
        ass_esc = str(subs).replace("\\", "/").replace(":", "\\:")
        vf += f",ass='{ass_esc}'"

    bgm_name = cfg["audio"]["bgm_moods"].get(a.bgm_mood, "")
    bgm_file = (SFX_DIR / bgm_name) if bgm_name else None
    bgm_status = "exact"
    if a.bgm_mood != "none" and bgm_file and not bgm_file.exists():
        print(f"!!! WARNING: BGM mood '{a.bgm_mood}' track MISSING: {bgm_file} -> FALLING BACK to roblox-story-bg.mp3. Add the file or pick another mood.")
        bgm_status = "FALLBACK"
        bgm_file = SFX_DIR / "roblox-story-bg.mp3"
    use_bgm = a.bgm_gain > 0 and bgm_file and bgm_file.exists()

    beats_p = Path(a.beats) if a.beats else (d / "beats.json" if (d / "beats.json").exists() else None)
    beats = load_beats(beats_p)
    cues, missing_sfx = sfx_cues(beats, None if a.music_only else (d / "words.json"))
    print(f"[AUDIO REPORT] BGM mood='{a.bgm_mood}' [{bgm_status}] file={bgm_file if use_bgm else 'none'}")
    print(f"[AUDIO REPORT] SFX resolved={[str(f) for _, f, _ in cues] or 'none'}")
    if missing_sfx:
        print(f"!!! WARNING: SFX named in beats but missing in {SFX_DIR}: {missing_sfx}")
    bgm_vol = f"'{build_bgm_volume_expr(beats, a.lead, a.bgm_gain, float(cfg['audio']['duck_bgm_gain']), float(cfg['audio']['climax_bgm_gain']))}':eval=frame"

    bar_dur = 0.0
    if cfg["video"].get("progress_bar", True):
        # ponytail: bar spans --end or the raw take length; the voice path's -shortest can end a little earlier
        bar_dur = float(a.end) if a.end else float(subprocess.run(
            ["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", a.raw],
            capture_output=True, text=True, check=True).stdout.strip())

    def vgraph(first_idx):
        return video_graph(base_vf, vf, beats, a.lead, w, h, first_idx, d, bar_dur)

    preset = "ultrafast" if a.draft else "medium"   # V6.4: medium + 4 threads = far less CPU/heat, same 1080p look
    crf = "26" if a.draft else "19"

    if a.music_only:
        ins = [x for _, f, _ in cues for x in ("-i", str(f))]
        if use_bgm:
            ins += ["-stream_loop", "-1", "-i", str(bgm_file)]
        if cues or use_bgm:
            mix, labels = [], []
            for k, (t, _, g) in enumerate(cues):
                mix.append(f"[{k+1}:a]volume={g},adelay={int((t+a.lead)*1000)}|{int((t+a.lead)*1000)}[s{k}];")
                labels.append(f"[s{k}]")
            if use_bgm:
                mix.append(f"[{len(cues)+1}:a]aformat=channel_layouts=stereo,volume={bgm_vol}[bgm];")
                labels.append("[bgm]")
            vins, vg = vgraph(overlay_base_idx(ins, True)); ins += vins
            fc = f"{vg};{''.join(mix)}{''.join(labels)}amix=inputs={len(labels)}:normalize=0:duration=longest,loudnorm=I=-14:TP=-1.5:LRA=11,aresample=48000,alimiter=limit=0.85:level=false,aformat=channel_layouts=stereo[a]"
            cmd = ["ffmpeg", "-y", "-i", a.raw, *ins, "-filter_complex", fc, "-map", "[v]", "-map", "[a]", "-shortest"]
        else:
            vins, vg = vgraph(1)
            cmd = ["ffmpeg", "-y", "-i", a.raw, *vins, "-filter_complex", vg, "-map", "[v]", "-an"]
    else:
        ms = int(a.lead * 1000)
        ins = [x for _, f, _ in cues for x in ("-i", str(f))]
        if use_bgm:
            ins += ["-stream_loop", "-1", "-i", str(bgm_file)]
        mix, labels = [f"[1:a]aformat=channel_layouts=stereo,adelay={ms}|{ms}[vo];"], ["[vo]"]
        for k, (t, _, g) in enumerate(cues):
            mix.append(f"[{k+2}:a]volume={g},adelay={int((t+a.lead)*1000)}|{int((t+a.lead)*1000)}[s{k}];")
            labels.append(f"[s{k}]")
        if use_bgm:
            mix.append(f"[{len(cues)+2}:a]aformat=channel_layouts=stereo,volume={bgm_vol}[bgm];")
            labels.append("[bgm]")
        aud = ("".join(mix) + "".join(labels) + f"amix=inputs={len(labels)}:normalize=0:duration=first," if len(labels) > 1 else f"[1:a]aformat=channel_layouts=stereo,adelay={ms}|{ms},")
        apad = "" if use_bgm else ",apad"  # apad only when there is no BGM bed
        vins, vg = vgraph(overlay_base_idx(ins, False)); ins += vins
        fc = f"{vg};{aud}loudnorm=I=-14:TP=-1.5:LRA=11,aresample=48000,alimiter=limit=0.85:level=false{apad},aformat=channel_layouts=stereo[a]"
        cmd = ["ffmpeg", "-y", "-i", a.raw, "-i", str(d / "voice.mp3"), *ins, "-filter_complex", fc, "-map", "[v]", "-map", "[a]", "-shortest"]

    if a.end:
        cmd += ["-t", str(a.end)]
    cmd += ["-threads", "4", "-c:v", "libx264", "-preset", preset, "-crf", crf, "-pix_fmt", "yuv420p", "-c:a", "aac", "-b:a", "192k", "-movflags", "+faststart", a.out]
    subprocess.run(cmd, check=True)
    print(f"{'DRAFT' if a.draft else 'FINAL'}: {a.out}")


if __name__ == "__main__":
    main()
