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


def sfx_cues(beats_json: Path, words_json: Path | None):
    beats = json.loads(beats_json.read_text(encoding="utf-8"))
    beats = beats.get("beats", beats) if isinstance(beats, dict) else beats
    words = json.loads(words_json.read_text(encoding="utf-8")) if (words_json and words_json.exists()) else []
    norm = lambda w: re.sub(r"\W+", "", w).lower()
    ws, i, cues = [norm(w["word"]) for w in words], 0, []
    for b in beats:
        name = (b.get("sfx") or "").strip()
        if not name or not (SFX_DIR / f"{name}.wav").exists():
            continue
        t_sec = float(b.get("start", 0.0))
        if words and (b.get("line") or "").strip():
            first = next((norm(x) for x in b["line"].split() if norm(x)), None)
            j = next((k for k in range(i, len(ws)) if ws[k] == first), None) if first else None
            if j is not None:
                t_sec = words[j]["start"]
                i = j + 1
        g = SFX_GAIN.get(name, 0.38)
        if g > 0:
            cues.append((t_sec, SFX_DIR / f"{name}.wav", g))
    return cues


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

    vf = base_vf
    if not a.music_only and (d / "subs.ass").exists():
        subs = d / "subs_shifted.ass"
        shift_ass(d / "subs.ass", subs, a.lead)
        ass_esc = str(subs).replace("\\", "/").replace(":", "\\:")
        vf += f",ass='{ass_esc}'"

    bgm_name = cfg["audio"]["bgm_moods"].get(a.bgm_mood, "")
    bgm_file = (SFX_DIR / bgm_name) if bgm_name else None
    if bgm_file and not bgm_file.exists():
        bgm_file = SFX_DIR / "roblox-story-bg.mp3"
    use_bgm = a.bgm_gain > 0 and bgm_file and bgm_file.exists()

    beats_p = Path(a.beats) if a.beats else (d / "beats.json" if (d / "beats.json").exists() else None)
    cues = sfx_cues(beats_p, None if a.music_only else (d / "words.json")) if beats_p else []

    preset = "ultrafast" if a.draft else "slow"
    crf = "26" if a.draft else "18"

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
                mix.append(f"[{len(cues)+1}:a]volume={a.bgm_gain}[bgm];")
                labels.append("[bgm]")
            fc = f"[0:v]{vf}[v];{''.join(mix)}{''.join(labels)}amix=inputs={len(labels)}:normalize=0:duration=longest,loudnorm=I=-14:TP=-1.5:LRA=11[a]"
            cmd = ["ffmpeg", "-y", "-i", a.raw, *ins, "-filter_complex", fc, "-map", "[v]", "-map", "[a]", "-shortest"]
        else:
            cmd = ["ffmpeg", "-y", "-i", a.raw, "-vf", vf, "-an"]
    else:
        ms = int(a.lead * 1000)
        ins = [x for _, f, _ in cues for x in ("-i", str(f))]
        if use_bgm:
            ins += ["-stream_loop", "-1", "-i", str(bgm_file)]
        mix, labels = [f"[1:a]adelay={ms}|{ms}[vo];"], ["[vo]"]
        for k, (t, _, g) in enumerate(cues):
            mix.append(f"[{k+2}:a]volume={g},adelay={int((t+a.lead)*1000)}|{int((t+a.lead)*1000)}[s{k}];")
            labels.append(f"[s{k}]")
        if use_bgm:
            mix.append(f"[{len(cues)+2}:a]volume={a.bgm_gain}[bgm];")
            labels.append("[bgm]")
        aud = ("".join(mix) + "".join(labels) + f"amix=inputs={len(labels)}:normalize=0:duration=first," if len(labels) > 1 else f"[1:a]adelay={ms}|{ms},")
        fc = f"[0:v]{vf}[v];{aud}loudnorm=I=-14:TP=-1.5:LRA=11,aresample=48000,apad[a]"
        cmd = ["ffmpeg", "-y", "-i", a.raw, "-i", str(d / "voice.mp3"), *ins, "-filter_complex", fc, "-map", "[v]", "-map", "[a]", "-shortest"]

    if a.end:
        cmd += ["-t", str(a.end)]
    cmd += ["-c:v", "libx264", "-preset", preset, "-crf", crf, "-pix_fmt", "yuv420p", "-c:a", "aac", "-b:a", "192k", "-movflags", "+faststart", a.out]
    subprocess.run(cmd, check=True)
    print(f"{'DRAFT' if a.draft else 'FINAL'}: {a.out}")


if __name__ == "__main__":
    main()
