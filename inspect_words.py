import json

words = json.load(open('stories/006_wrong-line/words.json'))
for i in range(15, 30):
    print(f"{i}: {words[i]}")
