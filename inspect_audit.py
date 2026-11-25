import json
import os
import subprocess
from pathlib import Path
from PIL import Image

def run_full_audit():
    print("==================================================")
    print("    POST-PRODUCTION QA AUDIT: STORY 006           ")
    print("==================================================")
    
    # 1. BEATS & TIMINGS
    with open('stories/006_wrong-line/beats.json', 'r', encoding='utf-8') as f:
        beats_data = json.load(f)
    beats = beats_data.get("beats", beats_data) if isinstance(beats_data, dict) else beats_data
    
    print(f"\n[1. BEATS & PACING AUDIT] Total beats: {len(beats)}")
    total_dur = 0
    non_narrator = 0
    with_partners = 0
    sfx_beats = []
    
    for i, b in enumerate(beats):
        dur = float(b.get("dur", 0))
        start = float(b.get("start", total_dur))
        total_dur = start + dur
        spk = b.get("speaker", "narrator")
        if spk != "narrator":
            non_narrator += 1
        if b.get("with"):
            with_partners += 1
        if b.get("sfx"):
            sfx_beats.append((i+1, b.get("sfx"), start))
        print(f"Beat {i+1:02d} [{start:5.2f}s - {total_dur:5.2f}s | dur {dur:4.2f}s] cam={b.get('cam'):11s} target={b.get('target', 'None'):6s} act={b.get('action'):9s} spk={spk:8s} sfx={str(b.get('sfx'))}")
    
    print(f"\nTiming & Beat Metrics:")
    print(f"  Calculated Total Duration: {total_dur:.2f}s")
    print(f"  Non-narrator lines: {non_narrator}/{len(beats)} ({non_narrator/len(beats)*100:.1f}%)")
    print(f"  Partner beats ('with'): {with_partners}")
    print(f"  SFX cue count: {len(sfx_beats)}")

    # 2. CAPTIONS & SAFE ZONE AUDIT
    print(f"\n[2. CAPTIONS & SAFE ZONE AUDIT]")
    with open('stories/006_wrong-line/subs_shifted.ass', 'r', encoding='utf-8') as f:
        ass_content = f.read()
    
    # Check Styles
    for line in ass_content.splitlines():
        if line.startswith("Style:"):
            print("  ASS Style definition:", line.strip())
            
    # Dialogue events
    dialogue_lines = [l for l in ass_content.splitlines() if l.startswith("Dialogue:")]
    print(f"  Total caption cards: {len(dialogue_lines)}")
    
    # Check words per card, durations, highlights
    high_word_count = []
    card_durations = []
    def parse_time(tstr):
        h, m, s = tstr.split(':')
        return int(h)*3600 + int(m)*60 + float(s)
        
    for idx, dline in enumerate(dialogue_lines):
        parts = dline.split(',', 9)
        st = parse_time(parts[1])
        et = parse_time(parts[2])
        cdur = et - st
        card_durations.append(cdur)
        raw_text = parts[9]
        # remove ass formatting tags
        clean_words = []
        in_tag = False
        cur_word = ""
        for ch in raw_text:
            if ch == '{':
                in_tag = True
            elif ch == '}':
                in_tag = False
            elif not in_tag:
                cur_word += ch
        words = cur_word.strip().split()
        if len(words) > 2:
            high_word_count.append((idx+1, len(words), cur_word.strip()))
            
    print(f"  Cards with >2 words: {len(high_word_count)}")
    if high_word_count:
        for item in high_word_count:
            print(f"    Card {item[0]}: {item[1]} words -> '{item[2]}'")
    print(f"  Card duration stats: min={min(card_durations):.3f}s, max={max(card_durations):.3f}s, avg={sum(card_durations)/len(card_durations):.3f}s")

    # 3. CONTACT SHEET INSPECTION & FRAME SLICING
    print(f"\n[3. CONTACT SHEET INSPECTION]")
    qa_beats = Image.open('stories/006_wrong-line/rec/qa_beats.png')
    w, h = qa_beats.size
    print(f"  qa_beats.png: {w}x{h}")
    # 8 columns x 3 rows of 216x384
    tile_w, tile_h = 216, 384
    cols = 8
    rows = (len(beats) + 1 + cols - 1) // cols
    print(f"  Expected grid: {cols}x{rows} tiles of {tile_w}x{tile_h}")
    
    out_dir = Path('stories/006_wrong-line/rec/audit_tiles')
    out_dir.mkdir(parents=True, exist_ok=True)
    
    for n in range(len(beats) + 1):
        c = n % cols
        r = n // cols
        box = (c * tile_w, r * tile_h, (c + 1) * tile_w, (r + 1) * tile_h)
        tile = qa_beats.crop(box)
        label = f"B{n+1}" if n < len(beats) else "END"
        tile.save(out_dir / f"{label}.png")
        
    print(f"  Successfully extracted {len(beats)+1} tiles into {out_dir}")
    
    # First 3s strip
    qa_first3s = Image.open('stories/006_wrong-line/rec/qa_beats_first3s.png')
    print(f"  qa_beats_first3s.png: {qa_first3s.size}")
    first3s_dir = Path('stories/006_wrong-line/rec/audit_first3s')
    first3s_dir.mkdir(parents=True, exist_ok=True)
    f_cols = 6
    for c in range(f_cols):
        box = (c * tile_w, 0, (c + 1) * tile_w, tile_h)
        tile = qa_first3s.crop(box)
        t_sec = c * 0.5
        tile.save(first3s_dir / f"first3s_{t_sec:.1f}s.png")
    print(f"  Successfully extracted {f_cols} hook frames into {first3s_dir}")

    # 4. AUDIO STREAMS & LOUDNORM
    print(f"\n[4. AUDIO SPECS & DRAFT CHECK]")
    probe_cmd = ['ffprobe', '-v', 'error', '-show_entries', 'format=duration,bit_rate:stream=codec_type,codec_name,sample_rate,channels', '-of', 'json', 'stories/006_wrong-line/006_draft.mp4']
    res = subprocess.run(probe_cmd, capture_output=True, text=True)
    print("  FFprobe stream info:")
    print(" ", res.stdout.strip())

if __name__ == '__main__':
    run_full_audit()
