"""Record a Roblox Studio cutscene take (Windows): Studio to FOREGROUND, cursor parked in the menu bar, gdigrab 30fps.

Usage:
  1. In Studio (MCP execute_luau) black the screen:  game.Lighting.Grade.Brightness = -1
  2. python pipeline/record_take.py --seconds 56 --out stories/<ID>/rec/take_p1_raw.mp4   (runs in background)
  3. ~2 s later start the cutscene via MCP: task.spawn(_G.Story007.play, 1)
  4. python pipeline/record_take.py --trim stories/<ID>/rec/take_p1_raw.mp4 --out stories/<ID>/rec/take_p1.mp4
     (cuts everything before the first non-black frame = cutscene start)
Rules (docs/LESSONS_LEARNED.md): foreground Studio (background = 47% repeated frames), never park the cursor at the
bottom/corner (pops the taskbar), nobody touches Studio during a take, clear the Selection first.
"""
import argparse, ctypes, re, subprocess

TITLE = r"C:\AI-Vid\assets\maps\story007.rbxl - Roblox Studio"
REGION = dict(x=4, y=160, w=1882, h=966)  # the 3D viewport with ribbon + command bar collapsed


def foreground(title):
    subprocess.run(["powershell", "-NoProfile", "-Command",
                    f"(New-Object -ComObject WScript.Shell).AppActivate('{title}') | Out-Null"], check=False)
    ctypes.windll.user32.SetCursorPos(900, 12)  # empty menu bar, outside the viewport


def record(seconds, out, title):
    foreground(title)
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "gdigrab", "-framerate", "30", "-draw_mouse", "0",
                    "-offset_x", str(REGION["x"]), "-offset_y", str(REGION["y"]),
                    "-video_size", f'{REGION["w"]}x{REGION["h"]}', "-t", str(seconds), "-i", f"title={title}",
                    "-c:v", "libx264", "-preset", "ultrafast", "-crf", "12", "-pix_fmt", "yuv420p", out], check=True)


def trim(raw, out):
    log = subprocess.run(["ffmpeg", "-i", raw, "-vf", "blackdetect=d=0.1:pix_th=0.05", "-an", "-f", "null", "-"],
                         capture_output=True, text=True).stderr
    m = re.search(r"black_start:0(?:\.0+)? black_end:([\d.]+)", log)
    start = float(m.group(1)) if m else 0.0
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-ss", f"{start:.3f}", "-i", raw, "-c:v", "libx264",
                    "-preset", "fast", "-crf", "14", "-pix_fmt", "yuv420p", out], check=True)
    print(f"trimmed {start:.2f}s -> {out}")


if __name__ == "__main__":
    a = argparse.ArgumentParser()
    a.add_argument("--seconds", type=float)
    a.add_argument("--trim")
    a.add_argument("--out", required=True)
    a.add_argument("--title", default=TITLE)
    x = a.parse_args()
    trim(x.trim, x.out) if x.trim else record(x.seconds, x.out, x.title)
