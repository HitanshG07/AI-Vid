import json
words = json.load(open('stories/006_wrong-line/words.json'))
for i in range(25):
    print(f"{i}: {words[i]['word']} ({words[i]['start']:.2f} - {words[i]['end']:.2f})")
