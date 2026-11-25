with open("engines/roblox/core_engine.luau", "r", encoding="utf-8") as f:
    core = f.read()
with open("engines/roblox/sets/set_street_day.luau", "r", encoding="utf-8") as f:
    street = f.read()
with open("engines/roblox/scenes_006.luau", "r", encoding="utf-8") as f:
    scenes = f.read()

scenes = scenes.rstrip()
suffix = 'return _G["Story" .. SceneSpec.id]'
if scenes.endswith(suffix):
    scenes = scenes[:-len(suffix)].rstrip()

tail = '''
_G.Story006 = Engine.compile(SceneSpec)
return string.format("[READY] Story 006 fully compiled with %d beats. Play function: %s", #SceneSpec.beats, tostring(type(_G.Story006.play) == "function"))
'''

payload = core + "\n\n" + street + "\n\n" + scenes + "\n\n" + tail

with open("load_full_scenes_006.lua", "w", encoding="utf-8") as f:
    f.write(payload)

print("Generated load_full_scenes_006.lua, size:", len(payload))
