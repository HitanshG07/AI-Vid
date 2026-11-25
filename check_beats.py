import json

beats = json.load(open('stories/006_wrong-line/beats.json'))
for b in beats:
    print(f"Beat {b.get('n')}: t0={b.get('t0'):.2f}, dur={b.get('dur'):.2f}, line={b.get('line')}")
