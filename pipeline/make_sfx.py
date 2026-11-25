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
    # story 001 (beach) - ambience, impacts, bell, music stings. Voices (scream, giggle) are not synthesised.
    "waves":           ("anoisesrc=d=3:c=brown:a=0.5", "lowpass=f=900,tremolo=f=0.35:d=0.7,afade=t=in:d=0.5," + D.format(s=2.4, d=0.6)),
    "waves_heavy":     ("anoisesrc=d=3:c=brown:a=0.8", "lowpass=f=1400,tremolo=f=0.6:d=0.8,afade=t=in:d=0.3," + D.format(s=2.4, d=0.6)),
    "seagulls":        ("aevalsrc='0.25*sin(2*PI*(1700+500*sin(2*PI*3*t))*t)*gt(sin(2*PI*1.3*t),0.3)':d=2", D.format(s=1.6, d=0.4)),
    "crowd_beach":     ("anoisesrc=d=2.5:c=pink:a=0.35", "bandpass=f=700:w=900,tremolo=f=4:d=0.3,afade=t=in:d=0.4," + D.format(s=2.0, d=0.5)),
    "crowd_cheer":     ("anoisesrc=d=2:c=pink:a=0.6", "bandpass=f=1200:w=1600,afade=t=in:d=0.6," + D.format(s=1.4, d=0.6)),
    "crickets_waves":  ("aevalsrc='0.12*sin(2*PI*4200*t)*gt(sin(2*PI*14*t),0.6)*gt(sin(2*PI*0.9*t),-0.2)':d=3", "afade=t=in:d=0.4," + D.format(s=2.4, d=0.6)),
    "footsteps_sand":  ("aevalsrc='0.5*sin(2*PI*90*t)*exp(-30*mod(t,0.32))':d=1.3", "lowpass=f=600," + D.format(s=1.0, d=0.3)),
    "footsteps_wood":  ("aevalsrc='0.7*sin(2*PI*160*t)*exp(-45*mod(t,0.22))':d=1.3", "lowpass=f=1200," + D.format(s=1.0, d=0.3)),
    "heartbeat":       ("aevalsrc='0.9*sin(2*PI*55*t)*(exp(-25*mod(t,0.9))+0.7*exp(-25*mod(t-0.22,0.9))*gte(t,0.22))':d=1.8", "lowpass=f=200"),
    "heartbeat_fast":  ("aevalsrc='0.9*sin(2*PI*55*t)*(exp(-28*mod(t,0.5))+0.7*exp(-28*mod(t-0.16,0.5))*gte(t,0.16))':d=1.5", "lowpass=f=200"),
    "thunder":         ("anoisesrc=d=2.5:c=brown:a=1", "lowpass=f=300,afade=t=in:d=0.05," + D.format(s=0.6, d=1.9)),
    "splash":          ("anoisesrc=d=0.8:c=white:a=0.7", "bandpass=f=2000:w=3000," + D.format(s=0.1, d=0.7)),
    "swim_splash":     ("anoisesrc=d=1.4:c=white:a=0.5", "bandpass=f=1800:w=2500,tremolo=f=3:d=0.9," + D.format(s=1.0, d=0.4)),
    "whoosh_hit":      ("anoisesrc=d=0.7:c=pink:a=0.7", "bandpass=f=900:w=1400,afade=t=in:d=0.35," + D.format(s=0.45, d=0.25)),
    "whoosh_rewind":   ("aevalsrc='0.4*sin(2*PI*(2400-3000*t)*t)':d=0.6", "highpass=f=200," + D.format(s=0.4, d=0.2)),
    "bass_hit":        ("aevalsrc='1.0*sin(2*PI*48*t)*exp(-6*t)':d=1.0", ""),
    "bass_hit_warm":   ("aevalsrc='0.8*(sin(2*PI*55*t)+0.3*sin(2*PI*110*t))*exp(-4*t)':d=1.2", ""),
    "whistle_blow":    ("aevalsrc='0.35*sin(2*PI*(2900+120*sin(2*PI*40*t))*t)':d=0.7", "afade=t=in:d=0.03," + D.format(s=0.55, d=0.15)),
    "bell_clang_loud": ("aevalsrc='0.5*(sin(2*PI*620*t)+0.6*sin(2*PI*1490*t)+0.3*sin(2*PI*2210*t))*exp(-1.8*t)':d=2.2", ""),
    "bell_ring_fading":("aevalsrc='0.3*(sin(2*PI*620*t)+0.5*sin(2*PI*1490*t))*exp(-1.2*t)*(0.7+0.3*sin(2*PI*5*t))':d=2.5", ""),
    "rope_creak":      ("anoisesrc=d=0.6:c=brown:a=0.6", "bandpass=f=500:w=300,tremolo=f=18:d=0.9," + D.format(s=0.4, d=0.2)),
    "chime_soft":      ("aevalsrc='0.25*(sin(2*PI*1568*t)+sin(2*PI*2093*t))*exp(-3*t)':d=1.2", ""),
    "ignite_shimmer":  ("aevalsrc='0.25*sin(2*PI*(900+1800*t)*t)*(0.5+0.5*sin(2*PI*30*t))':d=1.0", D.format(s=0.6, d=0.4)),
    "ignite_shimmer_big": ("aevalsrc='0.3*(sin(2*PI*(700+1500*t)*t)+0.5*sin(2*PI*(1400+3000*t)*t))*(0.5+0.5*sin(2*PI*24*t))':d=1.6", D.format(s=1.0, d=0.6)),
    "music_soft":      ("aevalsrc='0.12*(sin(2*PI*261.6*t)+sin(2*PI*329.6*t)+sin(2*PI*392*t))':d=3", "afade=t=in:d=0.8," + D.format(s=2.2, d=0.8)),
    "music_swell":     ("aevalsrc='0.14*(sin(2*PI*220*t)+sin(2*PI*277.2*t)+sin(2*PI*329.6*t)+sin(2*PI*440*t))':d=3", "afade=t=in:d=2.0," + D.format(s=2.4, d=0.6)),
    "music_end_chime": ("aevalsrc='0.22*(sin(2*PI*523.3*t)+sin(2*PI*659.3*t)+sin(2*PI*784*t))*exp(-1.1*t)':d=3", ""),
    # impacts: stone thuds, metal snaps, gold dissolve, whooshes (reused by several stories)
    "impact_whoosh":   ("anoisesrc=d=0.7:c=pink:a=0.7", "bandpass=f=900:w=1400,afade=t=in:d=0.35," + D.format(s=0.45, d=0.25)),
    "stone_thud":      ("aevalsrc='0.95*sin(2*PI*55*t)*exp(-12*t)+0.4*sin(2*PI*180*t)*exp(-30*t)':d=0.5", ""),
    "scraping_drag":   ("anoisesrc=d=1.2:c=brown:a=0.6", "bandpass=f=450:w=300,tremolo=f=12:d=0.7," + D.format(s=0.8, d=0.4)),
    "drone_smash":     ("anoisesrc=d=0.4:c=white:a=0.8", "highpass=f=1200," + D.format(s=0.1, d=0.3)),
    "railing_snap":    ("aevalsrc='0.8*sin(2*PI*850*t)*exp(-40*t)+0.6*sin(2*PI*2200*t)*exp(-80*t)':d=0.35", ""),
    "gold_dissolve":   ("aevalsrc='0.3*(sin(2*PI*(700+1500*t)*t)+0.5*sin(2*PI*(1400+3000*t)*t))*(0.5+0.5*sin(2*PI*24*t))':d=1.6", D.format(s=1.0, d=0.6)),
    "resolution_chord":("aevalsrc='0.16*(sin(2*PI*261.6*t)+sin(2*PI*329.6*t)+sin(2*PI*392*t)+sin(2*PI*523.3*t))':d=2.8", "afade=t=in:d=0.5," + D.format(s=1.8, d=1.0)),
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
