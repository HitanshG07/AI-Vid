import json, re, difflib

from test_whisper import model
segs, _ = model.transcribe("stories/006_wrong-line/voice.mp3", word_timestamps=True)
raw_words = [{"word": w.word.strip(), "start": w.start, "end": w.end} for s in segs for w in (s.words or [])]

script_text = open("stories/006_wrong-line/narration.txt", encoding="utf-8").read()

toks = script_text.replace('"', '').split()
norm = lambda s: re.sub(r"\W+", "", s).lower()

print(f"raw_words count: {len(raw_words)}, toks count: {len(toks)}")

matcher = difflib.SequenceMatcher(None, [norm(w["word"]) for w in raw_words], [norm(x) for x in toks])
for tag, i1, i2, j1, j2 in matcher.get_opcodes():
    print(tag, i1, i2, j1, j2)
    if tag != "equal":
        print("  raw:", [w["word"] for w in raw_words[i1:i2]])
        print("  tok:", toks[j1:j2])
