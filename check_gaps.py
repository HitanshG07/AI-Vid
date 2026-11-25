import json

words = json.load(open('stories/006_wrong-line/words.json'))
for i in range(1, len(words)):
    w0 = words[i-1]
    w1 = words[i]
    gap = w1['start'] - w0['end']
    if gap > 1.0:
        print(f"{i}: {w0['word']} ({w0['end']:.2f}) -> {w1['word']} ({w1['start']:.2f}) gap={gap:.2f}s")
