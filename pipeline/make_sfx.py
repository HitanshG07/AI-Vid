"""Synthesize the reusable SFX library into assets/sfx/*.wav with ffmpeg (original, Rs 0, no licences).

Usage: python pipeline/make_sfx.py      (skips files that already exist; --force to rebuild)
Names match the `sfx` field in beats_*.json. Add a new sound = add one line here.
"""
import subprocess, sys
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "assets" / "sfx"
D = "afade=t=out:st={s}:d={d}"
SFX = {  # name: (lavfi source, filters)
    "whoosh":      ("anoisesrc=d=0.6:c=pink:a=0.6", "bandpass=f=900:w=1200,afade=t=in:d=0.25," + D.format(s=0.3, d=0.3)),
    "rewind_zip":  ("aevalsrc='0.5*sin(2*PI*(1800-2600*t)*t)':d=0.45", "highpass=f=200," + D.format(s=0.3, d=0.15)),
    "skin_creak":  ("anoisesrc=d=0.5:c=brown:a=0.7", "bandpass=f=300:w=200,tremolo=f=28:d=0.9," + D.format(s=0.3, d=0.2)),
    "shutter":     ("aevalsrc='0.8*sin(2*PI*2500*t)*exp(-90*t)+0.6*sin(2*PI*1800*(t-0.09))*exp(-90*(t-0.09))*gte(t,0.09)':d=0.25", "highpass=f=400"),
    "ding":        ("aevalsrc='0.4*sin(2*PI*1320*t)*exp(-4*t)':d=0.9", ""),
    "tick":        ("aevalsrc='0.6*sin(2*PI*3000*t)*exp(-200*t)':d=0.08", ""),
    "piano_note":  ("aevalsrc='0.35*(sin(2*PI*440*t)+0.5*sin(2*PI*880*t)+0.25*sin(2*PI*1320*t))*exp(-2.5*t)':d=1.6", ""),
    "bell":        ("aevalsrc='0.3*sin(2*PI*880*t)*(0.6+0.4*sin(2*PI*22*t))':d=1.0", D.format(s=0.7, d=0.3)),
    "glass_clink": ("aevalsrc='0.4*(sin(2*PI*3100*t)+sin(2*PI*4700*t))*exp(-12*t)':d=0.5", ""),
    "pour":        ("anoisesrc=d=1.2:c=pink:a=0.4", "lowpass=f=1500,tremolo=f=9:d=0.4,afade=t=in:d=0.15," + D.format(s=0.9, d=0.3)),
    "hiss_crack":  ("anoisesrc=d=0.9:c=white:a=0.5", "highpass=f=3000,afade=t=in:d=0.4," + D.format(s=0.75, d=0.15)),
    "thud":        ("aevalsrc='0.9*sin(2*PI*60*t)*exp(-14*t)':d=0.4", ""),
}

def main():
    OUT.mkdir(parents=True, exist_ok=True)
    for name, (src, flt) in SFX.items():
        f = OUT / f"{name}.wav"
        if f.exists() and "--force" not in sys.argv:
            continue
        subprocess.run(["ffmpeg", "-loglevel", "error", "-y", "-f", "lavfi", "-i", src,
                        *(["-af", flt] if flt else []), "-ar", "48000", "-ac", "2", str(f)], check=True)
        print("made", f.name)

if __name__ == "__main__":
    main()
