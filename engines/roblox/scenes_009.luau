-- Auto-compiled by pipeline/compile_story.py (V5.4) — do not hand-edit
-- Story 009: In This Town, Every Mean Word Makes You Shorter | Format: story | Set: school_yard
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "009",
  wardrobe_seed = "011",
  format = "story",
  set = "school_yard",
  lighting = "day_bright",
  sets = { { name = "school_yard", offset = Vector3.new(0.00, 0.00, 0.00) } },
  totalDuration = 37.150,
  cast = {
  { name = "Sam", gender = "boy", face = "neutral", pos = Vector3.new(-4, 0, 13), yaw = 180.0, counter = "HEIGHT: 5 FT" },
  { name = "Toby", gender = "boy", face = "scared", pos = Vector3.new(4, 0, 13), yaw = 180.0, counter = "HEIGHT: 5 FT" },
  { name = "Rex", gender = "boy", face = "grin", pos = Vector3.new(-14, 0, -13), yaw = 180.0, counter = "HEIGHT: 5 FT" },
  },
  props = {

  },
  beats = {
  { n = 1, t0 = 0.000, dur = 2.260, cam = "wide", fov = 50, motion = "push_in", target = "Rex", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 2, t0 = 2.260, dur = 1.940, cam = "ots", fov = 48, motion = "push_in", target = "Toby", action = "talk", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Sam", action = "idle", face = "neutral" }}, face_mid = "scared" },
  { n = 3, t0 = 4.200, dur = 1.780, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Sam", action = "talk", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "", partners = {{ name = "Toby", action = "idle", face = "scared" }}, face_mid = "determined" },
  { n = 4, t0 = 5.980, dur = 1.480, cam = "closeup", fov = 50, motion = "push_in", target = "Sam", action = "talk", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 5, t0 = 7.460, dur = 1.560, cam = "wide", fov = 50, motion = "push_in", target = "Rex", action = "walk", move_to = Vector3.new(0.00, 0.00, 8.00), snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 6, t0 = 9.020, dur = 1.600, cam = "ots", fov = 48, motion = "push_in", target = "Rex", action = "recoil", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Toby", action = "point", face = "shocked" }}, counter = "HEIGHT: 4 FT", scale = 0.8 },
  { n = 7, t0 = 10.620, dur = 1.580, cam = "closeup", fov = 50, motion = "shake", target = "Rex", action = "recoil", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", counter = "HEIGHT: 4 FT", scale = 0.8, face_mid = "scared" },
  { n = 8, t0 = 12.200, dur = 1.560, cam = "ots", fov = 48, motion = "push_in", target = "Rex", action = "point", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Sam", action = "idle", face = "neutral" }} },
  { n = 9, t0 = 13.760, dur = 1.580, cam = "front", fov = 50, motion = "push_in", target = "Rex", action = "talk", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", counter = "HEIGHT: 3 FT", scale = 0.65, face_mid = "shocked" },
  { n = 10, t0 = 15.340, dur = 1.720, cam = "closeup", fov = 50, motion = "push_in", target = "Toby", action = "talk", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 11, t0 = 17.060, dur = 1.660, cam = "front", fov = 50, motion = "shake", target = "Rex", action = "talk", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "", counter = "HEIGHT: 2 FT", scale = 0.5 },
  { n = 12, t0 = 18.720, dur = 1.920, cam = "ots", fov = 48, motion = "push_in", target = "Rex", action = "talk", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Sam", action = "idle", face = "proud" }}, face_mid = "scared" },
  { n = 13, t0 = 20.640, dur = 1.280, cam = "low_hero", fov = 50, motion = "push_in", target = "Rex", action = "recoil", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 14, t0 = 21.920, dur = 1.500, cam = "side_track", fov = 50, motion = "push_in", target = "Rex", action = "talk", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "", counter = "HEIGHT: 1 FT", scale = 0.35 },
  { n = 15, t0 = 23.420, dur = 1.540, cam = "high_angle", fov = 50, motion = "push_in", target = "Rex", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Toby", action = "idle", face = "grin" }, { name = "Sam", action = "idle", face = "proud" }} },
  { n = 16, t0 = 24.960, dur = 1.900, cam = "high_angle", fov = 50, motion = "shake", target = "Rex", action = "talk", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", face_mid = "shocked" },
  { n = 17, t0 = 26.860, dur = 1.920, cam = "low_hero", fov = 50, motion = "push_in", target = "Sam", action = "recoil", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Toby", action = "recoil", face = "shocked" }, { name = "Rex", action = "idle", counter = "HEIGHT: 0 FT", invisible = true }} },
  { n = 18, t0 = 28.780, dur = 2.080, cam = "closeup", fov = 50, motion = "push_in", target = "Sam", action = "talk", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "" },
  { n = 19, t0 = 30.860, dur = 1.380, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Sam", action = "talk", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Toby", action = "idle", face = "proud" }} },
  { n = 20, t0 = 32.240, dur = 1.240, cam = "wide", fov = 50, motion = "push_in", target = "Sam", action = "walk", move_to = Vector3.new(-14.00, 0.00, -13.00), snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Toby", action = "walk", face = "proud", move_to = Vector3.new(-14.00, 0.00, -13.00) }} },
  { n = 21, t0 = 33.480, dur = 1.480, cam = "low_hero", fov = 50, motion = "push_in", target = "Toby", action = "cheer", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "" },
  { n = 22, t0 = 34.960, dur = 2.190, cam = "high_angle", fov = 50, motion = "pull_out", target = "Sam", action = "wave", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Toby", action = "wave", face = "proud" }} },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
