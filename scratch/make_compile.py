with open('engines/roblox/core_engine.luau', 'r', encoding='utf-8') as f:
    core = f.read()
with open('engines/roblox/scenes_006.luau', 'r', encoding='utf-8') as f:
    scenes = f.read()

# Strip trailing returns so script flows through
core_clean = core.rstrip()
if core_clean.endswith('return Engine'):
    core_clean = core_clean[:-len('return Engine')].rstrip()

scenes_clean = scenes.rstrip()
suffix = 'return _G["Story" .. SceneSpec.id]'
if scenes_clean.endswith(suffix):
    scenes_clean = scenes_clean[:-len(suffix)].rstrip()

tail = '''
_G.Story006 = Engine.compile(SceneSpec)
return string.format("[READY] Story006 compiled: %s", tostring(type(_G.Story006.play) == "function"))
'''

payload = core_clean + '\n\n' + scenes_clean + '\n\n' + tail

with open('scratch/run_compile.lua', 'w', encoding='utf-8') as f:
    f.write(payload)
print('Wrote clean scratch/run_compile.lua, size:', len(payload))
