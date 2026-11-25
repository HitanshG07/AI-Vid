-- Auto-compiled by pipeline/compile_story.py (V5.4) — do not hand-edit
-- Story 006: Why Is Everyone Laughing? 😭 | Format: story | Set: school_yard
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "006",
  format = "story",
  set = "school_yard",
  lighting = "day_bright",
  totalDuration = 44.940,
  cast = {
  { name = "Kai", gender = "boy", face = "grin", pos = Vector3.new(-14, 0, -12), yaw = 180.0 },
  { name = "Milo", gender = "boy", face = "neutral", pos = Vector3.new(1, 0, -3), yaw = 90.0, shirt = 12329928029, pants = 134609569320601, hair = 124340390453001 },
  { name = "Zoe", gender = "girl", face = "neutral", pos = Vector3.new(-9, 0, -6), yaw = 90.0, shirt = 5688801027, pants = 6092144716 },
  { name = "Coach", gender = "man", face = "neutral", pos = Vector3.new(-22, 0, 1), yaw = 180.0, shirt = 2885430411, pants = 140429444258386, hair = 120646937583722 },
  },
  props = {
  { name = "TrashCan", shape = "cylinder", material = "Metal", size = Vector3.new(3.00, 2.00, 2.00), pos = Vector3.new(-15.30, 1.70, -10.80), rot = Vector3.new(0.00, 0.00, 90.00), color = Color3.fromRGB(46, 110, 70) },
  { name = "Wrapper", material = "Foil", attach = "Kai/Right Leg", size = Vector3.new(0.80, 0.06, 0.55), rot = Vector3.new(-18.00, 12.00, 0.00), offset = Vector3.new(0.05, -0.92, -0.62), color = Color3.fromRGB(230, 60, 160) },
  { name = "PhotoCam", material = "Metal", attach = "Coach/Head", size = Vector3.new(1.30, 0.85, 0.50), offset = Vector3.new(0.00, -0.05, -0.85), color = Color3.fromRGB(200, 202, 210), hide = true },
  { name = "PhotoLens", shape = "cylinder", material = "Metal", attach = "Coach/Head", size = Vector3.new(0.50, 0.60, 0.60), rot = Vector3.new(0.00, 90.00, 0.00), offset = Vector3.new(0.00, -0.05, -1.30), color = Color3.fromRGB(20, 20, 22), hide = true },
  },
  beats = {
  { n = 1, t0 = 0.000, dur = 3.300, cam = "front", fov = 52, motion = "push_in", target = "Kai", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 2, t0 = 3.300, dur = 1.920, cam = "closeup", fov = 44, motion = "push_in", target = "Kai", action = "idle", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "" },
  { n = 3, t0 = 5.220, dur = 1.780, cam = "side_track", fov = 48, motion = "push_in", target = "Kai", action = "walk", move_to = Vector3.new(-11.00, 0.00, -7.00), snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 4, t0 = 7.000, dur = 1.820, cam = "wide", fov = 56, motion = "static", target = "Zoe", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Kai", action = "idle", face = "shocked" }}, face_partner = true },
  { n = 5, t0 = 8.820, dur = 1.700, cam = "closeup", fov = 44, motion = "push_in", target = "Kai", action = "idle", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", yaw = 180.0 },
  { n = 6, t0 = 10.520, dur = 2.880, cam = "side_track", fov = 48, motion = "push_in", target = "Kai", action = "walk", move_to = Vector3.new(3.00, 0.00, -3.00), snap_to = Vector3.new(5.00, 0.00, -3.00), face = "neutral", fx = "", badge = "", partners = {{ name = "Milo", action = "walk", face = "shocked", move_to = Vector3.new(1.00, 0.00, -6.50) }}, yaw = 90.0 },
  { n = 7, t0 = 13.400, dur = 1.360, cam = "closeup", fov = 44, motion = "push_in", target = "Milo", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", yaw = -60.0 },
  { n = 8, t0 = 14.760, dur = 1.620, cam = "closeup", fov = 44, motion = "push_in", target = "Kai", action = "idle", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 9, t0 = 16.380, dur = 2.160, cam = "wide", fov = 56, motion = "push_in", target = "Kai", action = "idle", move_to = nil, snap_to = Vector3.new(-20.00, 0.00, 8.00), face = "proud", fx = "", badge = "", partners = {{ name = "Coach", action = "wave", face = "neutral", snap_to = Vector3.new(-22.00, 0.00, -2.00), yaw = 180.0 }, { name = "Milo", action = "idle", face = "neutral", snap_to = Vector3.new(-24.00, 0.00, 8.00), yaw = 0.0 }, { name = "Zoe", action = "idle", face = "neutral", snap_to = Vector3.new(-27.00, 0.00, 8.00), yaw = 0.0 }}, yaw = 0.0 },
  { n = 10, t0 = 18.540, dur = 1.620, cam = "side_track", fov = 48, motion = "push_in", target = "Kai", action = "run", move_to = Vector3.new(-20.00, 0.00, 4.50), snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 11, t0 = 20.160, dur = 1.800, cam = "side_track", fov = 58, motion = "static", target = "Kai", action = "fall", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 12, t0 = 21.960, dur = 1.140, cam = "wide", fov = 54, motion = "static", target = "Milo", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Zoe", action = "point", face = "grin", yaw = -55.0 }}, yaw = -45.0 },
  { n = 13, t0 = 23.100, dur = 1.740, cam = "closeup", fov = 44, motion = "push_in", target = "Kai", action = "idle", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "", yaw = 135.0 },
  { n = 14, t0 = 24.840, dur = 1.780, cam = "side_track", fov = 48, motion = "push_in", target = "Kai", action = "walk", move_to = Vector3.new(14.50, 0.00, 1.50), snap_to = Vector3.new(18.00, 0.00, 3.00), face = "grin", fx = "", badge = "", partners = {{ name = "Coach", action = "block", face = "neutral", snap_to = Vector3.new(14.00, 0.00, 8.00), yaw = 0.0 }}, props = {{ name = "PhotoCam", show = true }, { name = "PhotoLens", show = true }} },
  { n = 15, t0 = 26.620, dur = 2.300, cam = "high_angle", fov = 52, motion = "static", target = "Kai", action = "dance", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Coach", action = "block", face = "grin" }, { name = "Milo", action = "idle", face = "grin", snap_to = Vector3.new(12.00, 0.00, 1.50), yaw = 180.0 }, { name = "Zoe", action = "idle", face = "grin", snap_to = Vector3.new(17.00, 0.00, 1.50), yaw = 180.0 }}, yaw = 180.0 },
  { n = 16, t0 = 28.920, dur = 0.780, cam = "closeup", fov = 44, motion = "push_in", target = "Coach", action = "block", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 17, t0 = 29.700, dur = 1.620, cam = "closeup", fov = 44, motion = "shake", target = "Kai", action = "point", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", props = {{ name = "PhotoCam", hide = true }, { name = "PhotoLens", hide = true }} },
  { n = 18, t0 = 31.320, dur = 1.800, cam = "ots", fov = 46, motion = "push_in", target = "Milo", action = "point", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Kai", action = "idle", face = "neutral" }}, face_partner = true, props = {{ name = "TrashCan", pos = Vector3.new(17.00, 1.70, 5.50), rot = Vector3.new(0.00, 0.00, 90.00) }} },
  { n = 19, t0 = 33.120, dur = 1.940, cam = "foot_insert", fov = 40, motion = "push_in", target = "Kai", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", yaw = 180.0 },
  { n = 20, t0 = 35.060, dur = 2.020, cam = "side_track", fov = 48, motion = "push_in", target = "Kai", action = "walk", move_to = Vector3.new(15.50, 0.00, 4.00), snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Coach", action = "walk", move_to = Vector3.new(22.00, 0.00, 12.00) }}, props = {{ name = "Wrapper", hide = true }} },
  { n = 21, t0 = 37.080, dur = 2.060, cam = "side_track", fov = 48, motion = "static", target = "Kai", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", yaw = 225.0 },
  { n = 22, t0 = 39.140, dur = 0.980, cam = "foot_insert", fov = 42, motion = "push_in", target = "Kai", action = "walk", move_to = Vector3.new(14.60, 0.00, 4.60), snap_to = nil, face = "shocked", fx = "", badge = "", props = {{ name = "Wrapper", attach = "Kai/Left Leg", rot = Vector3.new(-18.00, -12.00, 0.00), offset = Vector3.new(-0.05, -0.92, -0.62), show = true }} },
  { n = 23, t0 = 40.120, dur = 1.620, cam = "wide", fov = 54, motion = "pull_out", target = "Kai", action = "idle", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "", partners = {{ name = "Milo", action = "point", face = "grin" }, { name = "Zoe", action = "point", face = "grin" }} },
  { n = 24, t0 = 41.740, dur = 3.200, cam = "wide", fov = 54, motion = "pull_out", target = "Kai", action = "walk", move_to = Vector3.new(10.00, 0.00, 10.00), snap_to = nil, face = "determined", fx = "", badge = "" },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
