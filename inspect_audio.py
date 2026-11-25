import soundfile as sf
import numpy as np

data, samplerate = sf.read('stories/006_wrong-line/voice.mp3')
t = np.arange(len(data)) / samplerate

# Look at rms energy in 0.1s windows between 2.0s and 6.0s
for start in np.arange(2.0, 6.0, 0.25):
    idx = (t >= start) & (t < start + 0.25)
    rms = np.sqrt(np.mean(data[idx]**2)) if np.any(idx) else 0
    print(f"Time {start:.2f}-{start+0.25:.2f}: RMS = {rms:.5f}")
