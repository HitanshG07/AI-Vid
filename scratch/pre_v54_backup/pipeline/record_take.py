"""Record a Roblox Studio cutscene take (Windows): Studio to FOREGROUND, cursor parked in the menu bar, gdigrab 30fps.

Usage:
  1. In Studio (MCP execute_luau) black the screen:  game.Lighting.Grade.Brightness = -1
  2. python pipeline/record_take.py --seconds 56 --out stories/<ID>/rec/take_p1_raw.mp4   (runs in background)
  3. ~2 s later start the cutscene via MCP: task.spawn(_G.Story001.play, 1)
  4. python pipeline/record_take.py --trim stories/<ID>/rec/take_p1_raw.mp4 --out stories/<ID>/rec/take_p1.mp4
     (cuts everything before the first non-black frame = cutscene start)
Rules (docs/LESSONS_LEARNED.md): foreground Studio (background = 47% repeated frames), never park the cursor at the
bottom/corner (pops the taskbar), nobody touches Studio during a take, clear the Selection first.
"""
import argparse, ctypes, re, subprocess
from ctypes import wintypes

class STARTUPINFOW(ctypes.Structure):
    _fields_ = [
        ('cb', wintypes.DWORD),
        ('lpReserved', wintypes.LPWSTR),
        ('lpDesktop', wintypes.LPWSTR),
        ('lpTitle', wintypes.LPWSTR),
        ('dwX', wintypes.DWORD),
        ('dwY', wintypes.DWORD),
        ('dwXSize', wintypes.DWORD),
        ('dwYSize', wintypes.DWORD),
        ('dwXCountChars', wintypes.DWORD),
        ('dwYCountChars', wintypes.DWORD),
        ('dwFillAttribute', wintypes.DWORD),
        ('dwFlags', wintypes.DWORD),
        ('wShowWindow', wintypes.WORD),
        ('cbReserved2', wintypes.WORD),
        ('lpReserved2', ctypes.c_void_p),
        ('hStdInput', wintypes.HANDLE),
        ('hStdOutput', wintypes.HANDLE),
        ('hStdError', wintypes.HANDLE),
    ]

class PROCESS_INFORMATION(ctypes.Structure):
    _fields_ = [
        ('hProcess', wintypes.HANDLE),
        ('hThread', wintypes.HANDLE),
        ('dwProcessId', wintypes.DWORD),
        ('dwThreadId', wintypes.DWORD),
    ]

def studio_title():
    """Current Studio window title (changes with the open place, e.g. 'Ai-vid - Roblox Studio')."""
    # Try desktop enumeration first for sandboxed/service environments
    try:
        u32 = ctypes.windll.user32
        hDesk = u32.OpenDesktopW('default', 0, False, 0x10000000)
        if hDesk:
            u32.SetThreadDesktop(hDesk)
            titles = []
            def check_wnd(hwnd, lparam):
                length = u32.GetWindowTextLengthW(hwnd)
                if length > 0:
                    buf = ctypes.create_unicode_buffer(length + 1)
                    u32.GetWindowTextW(hwnd, buf, length + 1)
                    if 'Roblox Studio' in buf.value:
                        titles.append(buf.value)
                return True
            proc = ctypes.WINFUNCTYPE(wintypes.BOOL, wintypes.HWND, wintypes.LPARAM)(check_wnd)
            u32.EnumDesktopWindows(hDesk, proc, 0)
            if titles:
                # Prefer title containing place name (with ' - ')
                for t in titles:
                    if ' - ' in t:
                        return t
                return titles[0]
    except Exception:
        pass

    out = subprocess.run(["powershell", "-NoProfile", "-Command",
                          "(Get-Process RobloxStudioBeta | ? MainWindowTitle | select -First 1).MainWindowTitle"],
                         capture_output=True, text=True).stdout.strip()
    return out or "Roblox Studio"
REGION = dict(x=4, y=160, w=1882, h=966)  # the 3D viewport with ribbon + command bar collapsed


def foreground(title):
    subprocess.run(["powershell", "-NoProfile", "-Command",
                    f"(New-Object -ComObject WScript.Shell).AppActivate('{title}') | Out-Null"], check=False)
    ctypes.windll.user32.SetCursorPos(900, 12)  # empty menu bar, outside the viewport


class RECT(ctypes.Structure):
    _fields_ = [("left", ctypes.c_long), ("top", ctypes.c_long), ("right", ctypes.c_long), ("bottom", ctypes.c_long)]


def record(seconds, out, title):
    foreground(title)
    # Owner rule: lock the mouse at the top (menu bar) for the whole take so it can't wander into the viewport.
    # ClipCursor confines it to a 1x1 px box; always released in finally (also on Ctrl+C / ffmpeg error).
    u32 = ctypes.windll.user32
    u32.ClipCursor(ctypes.byref(RECT(900, 12, 901, 13)))
    try:
        cmd = f'ffmpeg -y -loglevel error -f gdigrab -framerate 30 -draw_mouse 0 -offset_x {REGION["x"]} -offset_y {REGION["y"]} -video_size {REGION["w"]}x{REGION["h"]} -t {seconds} -i "title={title}" -c:v libx264 -preset ultrafast -crf 12 -pix_fmt yuv420p "{out}"'
        si = STARTUPINFOW()
        si.cb = ctypes.sizeof(STARTUPINFOW)
        si.lpDesktop = 'WinSta0\\default'
        pi = PROCESS_INFORMATION()
        res = ctypes.windll.kernel32.CreateProcessW(None, cmd, None, None, False, 0, None, None, ctypes.byref(si), ctypes.byref(pi))
        if not res:
            err = ctypes.windll.kernel32.GetLastError()
            raise RuntimeError(f"CreateProcessW failed with error {err}")
        ctypes.windll.kernel32.WaitForSingleObject(pi.hProcess, int((seconds + 15) * 1000))
        ec = wintypes.DWORD()
        ctypes.windll.kernel32.GetExitCodeProcess(pi.hProcess, ctypes.byref(ec))
        ctypes.windll.kernel32.CloseHandle(pi.hProcess)
        ctypes.windll.kernel32.CloseHandle(pi.hThread)
        if ec.value != 0:
            raise RuntimeError(f"ffmpeg exited with non-zero code {ec.value}")
    finally:
        u32.ClipCursor(None)


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
    a.add_argument("--title", default=None)
    x = a.parse_args()
    trim(x.trim, x.out) if x.trim else record(x.seconds, x.out, x.title or studio_title())
