import subprocess
import json
from pathlib import Path
from PIL import Image, ImageStat

def analyze_frames_deeply():
    print("=== DEEP FRAME ANALYSIS ===")
    out_dir = Path("stories/006_wrong-line/rec/highres_frames")
    out_dir.mkdir(parents=True, exist_ok=True)
    
    with open('stories/006_wrong-line/beats.json', 'r', encoding='utf-8') as f:
        beats_data = json.load(f)
    beats = beats_data.get("beats", beats_data) if isinstance(beats_data, dict) else beats_data
    
    for i, b in enumerate(beats):
        st = float(b.get("start", 0))
        dur = float(b.get("dur", 0))
        mid = st + dur / 2.0
        frame_path = out_dir / f"beat_{i+1:02d}_{b.get('cam')}.jpg"
        cmd = ['ffmpeg', '-y', '-ss', f"{mid:.2f}", '-i', 'stories/006_wrong-line/006_draft.mp4', '-vframes', '1', '-q:v', '2', str(frame_path)]
        subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        
        # Analyze image stats
        im = Image.open(frame_path)
        stat = ImageStat.Stat(im)
        # Check aspect & resolution
        w, h = im.size
        # Crop upper 1/3 (head/shoulders), middle 1/3 (torso/waist), bottom 1/3 (legs/ground/captions)
        top = im.crop((0, 0, w, h // 3))
        mid_part = im.crop((0, h // 3, w, 2 * (h // 3)))
        bottom = im.crop((0, 2 * (h // 3), w, h))
        
        stat_top = ImageStat.Stat(top)
        stat_mid = ImageStat.Stat(mid_part)
        stat_bot = ImageStat.Stat(bottom)
        
        # Check brightness/contrast across vertical sections to confirm environment/character distribution
        print(f"Beat {i+1:02d} [{b.get('cam'):11s}]: mid={mid:5.2f}s | size={w}x{h} | mean_rgb=({stat.mean[0]:.1f},{stat.mean[1]:.1f},{stat.mean[2]:.1f})")

def analyze_hook_deeply():
    print("\n=== HOOK FIRST 3 SECONDS ANALYSIS ===")
    out_dir = Path("stories/006_wrong-line/rec/highres_hook")
    out_dir.mkdir(parents=True, exist_ok=True)
    
    # Extract frames at 0.3s, 0.8s, 1.4s, 2.0s, 2.5s, 3.0s
    times = [0.3, 0.8, 1.4, 2.0, 2.5, 3.0]
    for t in times:
        frame_path = out_dir / f"hook_{t:.1f}s.jpg"
        cmd = ['ffmpeg', '-y', '-ss', f"{t:.2f}", '-i', 'stories/006_wrong-line/006_draft.mp4', '-vframes', '1', '-q:v', '2', str(frame_path)]
        subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        im = Image.open(frame_path)
        print(f"Hook frame at {t:.1f}s saved: {frame_path.name} (size {im.size})")

if __name__ == '__main__':
    analyze_frames_deeply()
    analyze_hook_deeply()
