from faster_whisper import WhisperModel
import json

model = WhisperModel("small.en", device="cpu", compute_type="int8")
segs, _ = model.transcribe("stories/006_wrong-line/voice.mp3", word_timestamps=True)
for s in segs:
    print(f"[{s.start:.2f} -> {s.end:.2f}] {s.text}")
    for w in s.words:
        print(f"   {w.word} ({w.start:.2f} -> {w.end:.2f})")
    if s.start > 10.0:
        break
