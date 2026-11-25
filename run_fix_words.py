import json, difflib, re
from faster_whisper import WhisperModel

model = WhisperModel("small.en", device="cpu", compute_type="int8")
segs, _ = model.transcribe("stories/006_wrong-line/voice.mp3", word_timestamps=True)
raw_words = [{"word": w.word.strip(), "start": w.start, "end": w.end} for s in segs for w in (s.words or [])]

script_text = open("stories/006_wrong-line/narration.txt", encoding="utf-8").read()
toks = script_text.replace('"', '').split()
norm = lambda s: re.sub(r"\W+", "", s).lower()

out = []
for tag, i1, i2, j1, j2 in difflib.SequenceMatcher(None, [norm(w["word"]) for w in raw_words], [norm(x) for x in toks]).get_opcodes():
    ws, ts = raw_words[i1:i2], toks[j1:j2]
    if tag == "equal":
        out += [{"word": x, "start": w["start"], "end": w["end"]} for x, w in zip(ts, ws)]
    elif ts:
        t0 = ws[0]["start"] if ws else (out[-1]["end"] if out else 0.0)
        t1 = ws[-1]["end"] if ws else (raw_words[i1]["start"] if i1 < len(raw_words) else t0 + 0.28 * len(ts))
        step = max(t1 - t0, 0.05 * len(ts)) / len(ts)
        out += [{"word": x, "start": round(t0 + k * step, 3), "end": round(t0 + (k + 1) * step, 3)} for k, x in enumerate(ts)]

json.dump(out, open("stories/006_wrong-line/words.json", "w", encoding="utf-8"), indent=1)
print(f"Updated words.json with {len(out)} words. Last end: {out[-1]['end']:.2f}s")
