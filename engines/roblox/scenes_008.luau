-- Auto-compiled by pipeline/compile_story.py (V5.4) — do not hand-edit
-- Story 008: The Lucky Prankster 🍀 | Format: story | Set: school_yard
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "008",
  format = "story",
  set = "school_yard",
  lighting = "day_bright",
  totalDuration = 41.530,
  cast = {
  { name = "Dex", gender = "boy", face = "grin", pos = Vector3.new(-14, 0, -13), yaw = 180.0 },
  { name = "Maya", gender = "girl", face = "neutral", pos = Vector3.new(-14, 0, -18), yaw = 180.0 },
  { name = "Principal", gender = "man", face = "determined", pos = Vector3.new(24, 0, 4.4), yaw = 0.0 },
  },
  props = {
  { name = "Phone", attach = "Dex/Right Arm", kit = "phone", text = "LUCK 100%", hide = true },
  { name = "Banner", kit = "banner", text = "FAREWELL DEX!", hide = true },
  },
  beats = {
  { n = 1, t0 = 0.000, dur = 2.740, cam = "closeup", fov = 46, motion = "push_in", target = "Dex", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", props = {{ name = "Phone", show = true }} },
  { n = 2, t0 = 2.740, dur = 1.900, cam = "side_track", fov = 48, motion = "push_in", target = "Dex", action = "walk", move_to = Vector3.new(-14.00, 0.00, -18.00), snap_to = nil, face = "grin", fx = "", badge = "", props = {{ name = "Phone", hide = true }} },
  { n = 3, t0 = 4.640, dur = 1.560, cam = "ots", fov = 46, motion = "push_in", target = "Maya", action = "talk", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Dex", action = "idle", face = "grin" }} },
  { n = 4, t0 = 6.200, dur = 2.340, cam = "wide", fov = 54, motion = "push_in", target = "Dex", action = "point", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Maya", action = "idle", face = "neutral" }} },
  { n = 5, t0 = 8.540, dur = 1.980, cam = "side_track", fov = 48, motion = "push_in", target = "Maya", action = "talk", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Dex", action = "idle", face = "proud" }} },
  { n = 6, t0 = 10.520, dur = 1.880, cam = "closeup", fov = 44, motion = "push_in", target = "Dex", action = "talk", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 7, t0 = 12.400, dur = 2.100, cam = "wide", fov = 54, motion = "push_in", target = "Dex", action = "walk", move_to = Vector3.new(-22.00, 0.00, 9.00), snap_to = nil, face = "proud", fx = "ball_swish", badge = "" },
  { n = 8, t0 = 14.500, dur = 2.040, cam = "low_hero", fov = 46, motion = "push_in", target = "Dex", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "ball_swish", badge = "" },
  { n = 9, t0 = 16.540, dur = 1.240, cam = "ots", fov = 46, motion = "push_in", target = "Maya", action = "recoil", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Dex", action = "idle", face = "grin" }} },
  { n = 10, t0 = 17.780, dur = 1.400, cam = "closeup", fov = 44, motion = "push_in", target = "Dex", action = "talk", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "" },
  { n = 11, t0 = 19.180, dur = 1.280, cam = "side_track", fov = 48, motion = "push_in", target = "Dex", action = "walk", move_to = Vector3.new(-3.00, 0.00, -5.80), snap_to = nil, face = "proud", fx = "", badge = "" },
  { n = 12, t0 = 20.460, dur = 2.320, cam = "wide", fov = 54, motion = "push_in", target = "Dex", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 13, t0 = 22.780, dur = 1.520, cam = "reverse_ots", fov = 46, motion = "shake", target = "Principal", action = "slam_desk", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Dex", action = "idle", face = "grin" }} },
  { n = 14, t0 = 24.300, dur = 2.060, cam = "wide", fov = 48, motion = "pull_out", target = "Crowd", action = "talk", move_to = nil, snap_to = nil, face = "grin", fx = "crowd_cheer", badge = "", partners = {{ name = "Maya", action = "talk" }, { name = "Dex", action = "idle" }} },
  { n = 15, t0 = 26.360, dur = 2.060, cam = "closeup", fov = 44, motion = "push_in", target = "Dex", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "crowd_cheer", badge = "" },
  { n = 16, t0 = 28.420, dur = 1.620, cam = "ots", fov = 46, motion = "push_in", target = "Dex", action = "talk", move_to = nil, snap_to = nil, face = "grin", fx = "crowd_cheer", badge = "", partners = {{ name = "Maya", action = "idle", face = "grin" }} },
  { n = 17, t0 = 30.040, dur = 2.200, cam = "closeup", fov = 48, motion = "push_in", target = "Banner", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Maya", action = "point" }, { name = "Dex", action = "idle", face = "shocked" }}, props = {{ name = "Banner", show = true }} },
  { n = 18, t0 = 32.240, dur = 2.920, cam = "wide", fov = 54, motion = "shake", target = "Dex", action = "recoil", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 19, t0 = 35.160, dur = 1.300, cam = "closeup", fov = 44, motion = "push_in", target = "Dex", action = "talk", move_to = nil, snap_to = nil, face = "scared", fx = "", badge = "" },
  { n = 20, t0 = 36.460, dur = 1.640, cam = "ots", fov = 46, motion = "push_in", target = "Principal", action = "talk", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Dex", action = "idle", face = "scared" }} },
  { n = 21, t0 = 38.100, dur = 1.600, cam = "low_hero", fov = 46, motion = "shake", target = "Dex", action = "fall", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 22, t0 = 39.700, dur = 1.830, cam = "high_angle", fov = 50, motion = "pull_out", target = "Dex", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Maya", action = "point", face = "grin" }} },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
