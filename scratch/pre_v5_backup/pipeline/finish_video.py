"""Turn a rolled-camera Studio recording into a final 1080x1920 short with voice + burned subtitles.

The cutscene rolls the Roblox camera +90 deg, so the landscape window recording holds a sideways 9:16 frame.
This script: rotates it upright, centre-crops to 9:16, scales to 1080x1920 @30fps, delays voice + subtitles
by the cutscene lead-in, burns the off-centre .ass subs, and muxes.

Usage:
  python pipeline/finish_video.py --raw rec/final_p1_raw.mp4 --part-dir stories/001_brave-glow --out stories/001_brave-glow/001_brave-glow_FINAL.mp4 [--lead 0.3] [--end 50.05] [--beats stories/001_brave-glow/beats.json]
"""
import argparse, json, re, subprocess
from pathlib import Path

SFX_DIR = Path(__file__).resolve().parent.parent / "assets" / "sfx"
SFX_GAIN = {"tick": 0.25, "ding": 0.3, "piano_note": 0.35, "whoosh": 0.35,  # default 0.45; voice stays on top
            # owner 2026-11-18 & 2026-11-20: synthesised noise beds / static sounds read as "static hiss" -> completely muted (0)
            # Continuous BGM is exclusively assets/sfx/roblox-story-bg.mp3
            "music_soft": 0, "music_swell": 0, "music_end_chime": 0,
            "waves": 0, "waves_heavy": 0, "crowd_beach": 0, "crowd_cheer": 0, "crickets_waves": 0, "seagulls": 0,
            "splash": 0.15, "swim_splash": 0.12, "thunder": 0.3, "whoosh_hit": 0.2, "whoosh_rewind": 0.25,
            "footsteps_sand": 0.15, "footsteps_wood": 0.2, "rope_creak": 0.15,
            "bell_clang_loud": 0.38, "ignite_shimmer": 0.32, "ignite_shimmer_big": 0.38, "bass_hit": 0.34}


def sfx_cues(beats_json: Path, words_json: Path):
    """[(seconds, wav)] - each beat's `sfx` snapped to when its line's first word is ACTUALLY spoken."""
    beats = json.loads(beats_json.read_text(encoding="utf-8"))
    beats = beats.get("beats", beats) if isinstance(beats, dict) else beats
    words = json.loads(words_json.read_text(encoding="utf-8"))
    norm = lambda w: re.sub(r"\W+", "", w).lower()
    ws, i, cues = [norm(w["word"]) for w in words], 0, []
    for b in beats:
        first = next((norm(x) for x in (b.get("line") or "").split() if norm(x)), None)
        name = b.get("sfx")
        if not first or not name:
            continue
        if not (SFX_DIR / f"{name}.wav").exists():
            print(f"WARNING: beat {b.get('n', '?')}: sfx '{name}' has no assets/sfx/{name}.wav - skipped")
            continue
        j = next((k for k in range(i, len(ws)) if ws[k] == first), None)
        if j is None:
            continue
        i = j + 1
        if SFX_GAIN.get(name, 0.45) > 0:  # gain 0 = muted on purpose
            cues.append((words[j]["start"], SFX_DIR / f"{name}.wav", SFX_GAIN.get(name, 0.45)))
    return cues


def shift_ass(src: Path, dst: Path, secs: float):
    def fmt(t):
        h = int(t // 3600); m = int(t % 3600 // 60); s = t % 60
        return f"{h}:{m:02d}:{s:05.2f}"

    def parse(t):
        h, m, s = t.split(":")
        return int(h) * 3600 + int(m) * 60 + float(s)

    out = []
    for line in src.read_text(encoding="utf-8").splitlines():
        if line.startswith("Dialogue:"):
            head, rest = line.split(":", 1)
            f = rest.split(",", 9)
            f[1] = fmt(parse(f[1].strip()) + secs)
            f[2] = fmt(parse(f[2].strip()) + secs)
            line = head + ":" + ",".join(f)
        out.append(line)
    dst.write_text("\n".join(out) + "\n", encoding="utf-8")


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--raw", required=True)
    p.add_argument("--part-dir", required=True, help="folder with voice.mp3 + subs.ass")
    p.add_argument("--out", required=True)
    p.add_argument("--lead", type=float, default=0.3, help="seconds of video before the narration starts")
    p.add_argument("--end", type=float, default=None, help="cut the video here (s): end on the last image, never on black")
    p.add_argument("--beats", help="beats_pN.json: mix each beat's `sfx` from assets/sfx at its spoken time")
    p.add_argument("--bgm", default="roblox-story-bg.mp3", help="continuous background music file in assets/sfx/ (default: roblox-story-bg.mp3)")
    p.add_argument("--bgm-gain", type=float, default=0.14, help="continuous background music bed gain (0 to disable)")
    p.add_argument("--transpose", default="2", help="ffmpeg transpose value that undoes the +90 camera roll")
    a = p.parse_args()

    d = Path(a.part_dir)
    subs = d / "subs_shifted.ass"
    shift_ass(d / "subs.ass", subs, a.lead)
    ass = str(subs).replace("\\", "/").replace(":", "\\:")
    vf = (f"transpose={a.transpose},"
          "crop=iw:min(ih\\,iw*16/9):0:(ih-min(ih\\,iw*16/9))/2,"   # centre 9:16 crop
          "scale=1080:1920:flags=lanczos,fps=30,"   # capture is 30 fps; 60 only duplicated frames
          f"ass='{ass}'")
    ms = int(a.lead * 1000)
    cues = sfx_cues(Path(a.beats), d / "words.json") if a.beats else []
    bgm_file = SFX_DIR / a.bgm
    use_bgm = a.bgm_gain > 0 and bgm_file.exists()
    ins = [x for _, f, _ in cues for x in ("-i", str(f))]
    if use_bgm:
        ins += ["-stream_loop", "-1", "-i", str(bgm_file)]
    mix = [f"[1:a]adelay={ms}|{ms}[vo];"]
    labels = ["[vo]"]
    for k, (t, _, g) in enumerate(cues):
        dm = int((t + a.lead) * 1000)
        mix.append(f"[{k + 2}:a]volume={g},adelay={dm}|{dm}[s{k}];")
        labels.append(f"[s{k}]")
    if use_bgm:
        mix.append(f"[{len(cues) + 2}:a]volume={a.bgm_gain}[bgm];")
        labels.append("[bgm]")
    aud = ("".join(mix) + "".join(labels) + f"amix=inputs={len(labels)}:normalize=0:duration=first,"
           if len(labels) > 1 else f"[1:a]adelay={ms}|{ms},")
    print(f"SFX cues: {len(cues)} | BGM bed: {'ON (' + bgm_file.name + ')' if use_bgm else 'OFF'}")
    subprocess.run(["ffmpeg", "-y", "-i", a.raw, "-i", str(d / "voice.mp3"), *ins,
                    "-filter_complex", f"[0:v]{vf}[v];{aud}loudnorm=I=-14:TP=-1.5:LRA=11,aresample=48000,apad[a]",
                    "-map", "[v]", "-map", "[a]", "-shortest", *(["-t", str(a.end)] if a.end else []),
                    "-c:v", "libx264", "-preset", "slow", "-crf", "18", "-pix_fmt", "yuv420p",
                    "-c:a", "aac", "-b:a", "192k", "-movflags", "+faststart", a.out], check=True)
    print("FINAL:", a.out)


if __name__ == "__main__":
    main()
