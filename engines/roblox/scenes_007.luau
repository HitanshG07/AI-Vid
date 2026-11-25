-- Auto-compiled by pipeline/compile_story.py (V5.4) — do not hand-edit
-- Story 007: The Unspoken Name ⚡ | Format: story | Set: street_day
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "007",
  format = "story",
  set = "street_day",
  lighting = "day_bright",
  totalDuration = 35.770,
  cast = {
  { name = "Eli", gender = "boy", face = "neutral", pos = Vector3.new(-18, 0.5, 0), yaw = 270.0 },
  { name = "Jax", gender = "boy", face = "determined", pos = Vector3.new(18, 0.5, -4), yaw = 90.0 },
  { name = "Officer", gender = "woman", face = "shocked", pos = Vector3.new(16.2, 0.5, 9.5), yaw = 90.0 },
  },
  props = {

  },
  beats = {
  { n = 1, t0 = 0.000, dur = 2.840, cam = "closeup", fov = 46, motion = "push_in", target = "Eli", action = "walk", move_to = Vector3.new(0.00, 0.00, 12.00), snap_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 2, t0 = 2.840, dur = 1.740, cam = "side_track", fov = 48, motion = "push_in", target = "Officer", action = "talk", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 3, t0 = 4.580, dur = 1.820, cam = "wide", fov = 54, motion = "push_in", target = "Eli", action = "idle", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Jax", action = "walk", face = "determined", move_to = Vector3.new(0.00, 0.00, 0.00) }} },
  { n = 4, t0 = 6.400, dur = 1.900, cam = "ots", fov = 46, motion = "push_in", target = "Jax", action = "point", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Eli", action = "idle", face = "neutral" }} },
  { n = 5, t0 = 8.300, dur = 1.680, cam = "closeup", fov = 44, motion = "push_in", target = "Eli", action = "talk", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 6, t0 = 9.980, dur = 1.840, cam = "side_track", fov = 48, motion = "push_in", target = "Jax", action = "talk", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Eli", action = "idle", face = "neutral" }} },
  { n = 7, t0 = 11.820, dur = 2.300, cam = "wide", fov = 54, motion = "push_in", target = "Eli", action = "walk", move_to = Vector3.new(-18.00, 0.50, 0.00), snap_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 8, t0 = 14.120, dur = 1.340, cam = "reverse_ots", fov = 46, motion = "push_in", target = "Jax", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Eli", action = "idle", face = "neutral" }} },
  { n = 9, t0 = 15.460, dur = 1.100, cam = "closeup", fov = 44, motion = "push_in", target = "Eli", action = "talk", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "" },
  { n = 10, t0 = 16.560, dur = 2.020, cam = "wide", fov = 54, motion = "push_in", target = "Eli", action = "walk", move_to = Vector3.new(0.00, 0.00, 12.00), snap_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 11, t0 = 18.580, dur = 1.360, cam = "reverse_ots", fov = 46, motion = "shake", target = "Officer", action = "point", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 12, t0 = 19.940, dur = 1.120, cam = "closeup", fov = 44, motion = "shake", target = "Eli", action = "recoil", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 13, t0 = 21.060, dur = 2.040, cam = "low_hero", fov = 46, motion = "push_in", target = "Eli", action = "idle", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 14, t0 = 23.100, dur = 1.640, cam = "wide", fov = 56, motion = "push_in", target = "Jax", action = "run", move_to = Vector3.new(0.00, 0.00, 12.00), snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Eli", action = "idle", face = "scared" }} },
  { n = 15, t0 = 24.740, dur = 0.960, cam = "ots", fov = 46, motion = "push_in", target = "Jax", action = "talk", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Eli", action = "idle", face = "scared" }} },
  { n = 16, t0 = 25.700, dur = 1.020, cam = "reverse_ots", fov = 46, motion = "shake", target = "Jax", action = "point", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Eli", action = "recoil", face = "shocked" }} },
  { n = 17, t0 = 26.720, dur = 1.000, cam = "closeup", fov = 42, motion = "static", target = "Eli", action = "recoil", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 18, t0 = 27.720, dur = 1.660, cam = "wide", fov = 54, motion = "shake", target = "Jax", action = "punch", move_to = nil, snap_to = nil, face = "determined", fx = "truck_pass", badge = "", partners = {{ name = "Eli", action = "fall", face = "shocked", move_to = Vector3.new(18.00, 0.50, -4.00) }} },
  { n = 19, t0 = 29.380, dur = 2.380, cam = "low_hero", fov = 46, motion = "shake", target = "Jax", action = "fall", move_to = nil, snap_to = nil, face = "shocked", fx = "truck_pass", badge = "" },
  { n = 20, t0 = 31.760, dur = 1.520, cam = "side_track", fov = 48, motion = "push_in", target = "Officer", action = "run", move_to = Vector3.new(0.00, 0.00, 0.00), snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Jax", action = "downed", face = "neutral" }} },
  { n = 21, t0 = 33.280, dur = 1.100, cam = "closeup", fov = 44, motion = "push_in", target = "Eli", action = "walk", move_to = Vector3.new(0.00, 0.00, 0.00), snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Jax", action = "downed", face = "neutral" }} },
  { n = 22, t0 = 34.380, dur = 1.390, cam = "high_angle", fov = 50, motion = "pull_out", target = "Jax", action = "downed", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Eli", action = "idle", face = "shocked" }} },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
