"""Self-check for story props + prop cues: python pipeline/test_compile_props.py"""
from compile_story import compile_luau

data = {"id": "T", "cast": [{"name": "Kai", "gender": "boy"}],
        "props": [{"name": "Wrapper", "size": [0.8, 0.06, 0.55], "color": [230, 60, 160], "material": "Foil",
                   "attach": "Kai/Right Leg", "offset": [0, -0.92, -0.62]}]}
beats = [{"line": "a", "dur": 1.5},
         {"line": "b", "dur": 1.5, "cam": "foot_insert", "prop": {"name": "Wrapper", "hide": True}},
         {"line": "c", "dur": 1.5, "prop": [{"name": "Wrapper", "attach": "Kai/Left Leg", "show": True}]}]
out = compile_luau(data, beats)
assert 'attach = "Kai/Right Leg"' in out and 'Color3.fromRGB(230, 60, 160)' in out, out
assert 'props = {{ name = "Wrapper", hide = true }}' in out, out
assert 'attach = "Kai/Left Leg"' in out and "show = true" in out, out
assert 'cam = "foot_insert"' in out
assert out.count("props = {") == 3  # story list + 2 cued beats
print("ok")
