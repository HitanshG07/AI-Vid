-- Auto-compiled by pipeline/compile_story.py (V5.4) — do not hand-edit
-- Story 009: The Empty Hallway 👻 | Format: story | Set: school_hallway
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "009",
  format = "story",
  set = "school_hallway",
  lighting = "dark_mystery",
  sets = { { name = "school_hallway", offset = Vector3.new(0.00, 0.00, 0.00) } },
  totalDuration = 41.210,
  cast = {
  { name = "Zane", gender = "boy", face = "determined", pos = Vector3.new(0, 0, 34), yaw = 0.0 },
  { name = "Toby", gender = "boy", face = "neutral", pos = Vector3.new(-3.8, 0, 3), yaw = 90.0 },
  { name = "Mia", gender = "girl", face = "scared", pos = Vector3.new(-4.2, 0, -8), yaw = 90.0 },
  },
  props = {

  },
  beats = {
  { n = 1, t0 = 0.000, dur = 2.340, cam = "wide", fov = 54, motion = "push_in", target = "Zane", action = "walk", move_to = Vector3.new(0.00, 0.00, 0.00), snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 2, t0 = 2.340, dur = 1.300, cam = "closeup", fov = 44, motion = "push_in", target = "Zane", action = "talk", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 3, t0 = 3.640, dur = 2.120, cam = "closeup", fov = 48, motion = "push_in", target = "Mia", action = "recoil", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 4, t0 = 5.760, dur = 1.980, cam = "reverse_ots", fov = 46, motion = "push_in", target = "Zane", action = "point", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Mia", action = "idle", face = "scared", invisible = true }} },
  { n = 5, t0 = 7.740, dur = 1.580, cam = "ots", fov = 46, motion = "push_in", target = "Zane", action = "talk", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 6, t0 = 9.320, dur = 2.200, cam = "closeup", fov = 44, motion = "push_in", target = "Zane", action = "talk", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "" },
  { n = 7, t0 = 11.520, dur = 2.520, cam = "wide", fov = 54, motion = "push_in", target = "Zane", action = "walk", move_to = Vector3.new(4.20, 0.00, 8.00), snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 8, t0 = 14.040, dur = 2.040, cam = "side_track", fov = 48, motion = "push_in", target = "Zane", action = "talk", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 9, t0 = 16.080, dur = 1.420, cam = "closeup", fov = 44, motion = "push_in", target = "Zane", action = "talk", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 10, t0 = 17.500, dur = 2.360, cam = "wide", fov = 54, motion = "push_in", target = "Zane", action = "walk", move_to = Vector3.new(0.00, 0.00, -34.00), snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 11, t0 = 19.860, dur = 1.280, cam = "ots", fov = 46, motion = "push_in", target = "Zane", action = "talk", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 12, t0 = 21.140, dur = 1.880, cam = "reverse_ots", fov = 46, motion = "push_in", target = "Mia", action = "walk", move_to = Vector3.new(-4.20, 0.00, 14.00), snap_to = nil, face = "scared", fx = "", badge = "", invisible = false },
  { n = 13, t0 = 23.020, dur = 2.840, cam = "closeup", fov = 44, motion = "push_in", target = "Zane", action = "recoil", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 14, t0 = 25.860, dur = 1.940, cam = "wide", fov = 54, motion = "push_in", target = "Zane", action = "walk", move_to = Vector3.new(4.20, 0.00, 8.00), snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 15, t0 = 27.800, dur = 1.340, cam = "front", fov = 46, motion = "shake", target = "Zane", action = "kick", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", yaw = 270.0 },
  { n = 16, t0 = 29.140, dur = 3.260, cam = "low_hero", fov = 46, motion = "push_in", target = "Toby", action = "sit", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 17, t0 = 32.400, dur = 1.420, cam = "closeup", fov = 44, motion = "static", target = "Zane", action = "recoil", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 18, t0 = 33.820, dur = 1.060, cam = "ots", fov = 46, motion = "push_in", target = "Toby", action = "sit", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Zane", action = "idle", face = "shocked" }} },
  { n = 19, t0 = 34.880, dur = 1.000, cam = "side_track", fov = 48, motion = "push_in", target = "Zane", action = "point", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Toby", action = "sit", face = "neutral" }} },
  { n = 20, t0 = 35.880, dur = 1.160, cam = "closeup", fov = 44, motion = "push_in", target = "Toby", action = "sit", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 21, t0 = 37.040, dur = 1.880, cam = "wide", fov = 54, motion = "push_in", target = "Toby", action = "walk", move_to = Vector3.new(0.00, 0.00, -34.00), snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Zane", action = "walk", face = "shocked", move_to = Vector3.new(-3.80, 0.00, 3.00) }} },
  { n = 22, t0 = 38.920, dur = 2.290, cam = "high_angle", fov = 50, motion = "pull_out", target = "Zane", action = "sit", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
