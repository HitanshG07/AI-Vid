import json, glob

for path in sorted(glob.glob('stories/_inbox/*.judge.json')):
    with open(path, 'r', encoding='utf-8') as f:
        d = json.load(f)
    scores = d['scores']
    calc_mean = round(sum(scores.values()) / 4.0, 2)
    assert 'writer_model' in d
    assert 'judge_model' in d
    assert 'scores' in d
    assert 'mean_score' in d
    assert 'pass' in d
    assert 'reason' in d
    assert abs(d['mean_score'] - calc_mean) <= 0.01
    print(f"{path}: pass={d['pass']}, mean_score={d['mean_score']} (calc={calc_mean}), hook={scores['hook_2s']}, stakes={scores['stakes']}, rule={scores['rule_consistency']}, tech={scores['technical_validity']}")
