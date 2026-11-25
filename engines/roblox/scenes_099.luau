-- Auto-compiled by pipeline/compile_story.py from story.yaml (do not hand-edit)
-- Story 099: In This World, EVERYONE Has a Secret Timer... 😭 | Format: story
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "099",
  format = "story",
  lighting = "day_bright",
  totalDuration = 5.70,
  cast = {
  { name = "Hero", gender = "boy", face = "shocked", pos = Vector3.new(0, 3, 0) },
  { name = "Bully", gender = "boy", face = "grin", pos = Vector3.new(6, 3, -2) },
  },
  beats = {
  { n = 1, t0 = 0.00, dur = 1.80, cam = "closeup", motion = "push_in", target = "Hero", action = "idle", face = "shocked", fx = "", badge = "00:10" },
  { n = 2, t0 = 1.80, dur = 1.90, cam = "wide", motion = "push_in", target = "Bully", action = "idle", face = "grin", fx = "", badge = "99:59" },
  { n = 3, t0 = 3.70, dur = 2.00, cam = "ots", motion = "shake", target = "Hero", action = "idle", face = "determined", fx = "impact", badge = "RESET" },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5] Story %s ready (%.1fs, %d beats)", SceneSpec.id, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
