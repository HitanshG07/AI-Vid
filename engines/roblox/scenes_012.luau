-- Auto-compiled by pipeline/compile_story.py (V5.4) — do not hand-edit
-- Story 012: In This Town, You Only Have Ten Steps A Day | Format: story | Set: street_day
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "012",
  wardrobe_seed = "012",
  format = "story",
  set = "street_day",
  lighting = "neon_drop",
  sets = { { name = "street_day", offset = Vector3.new(0.00, 0.00, 0.00) }, { name = "school_hallway", offset = Vector3.new(400.00, 0.00, 0.00) }, { name = "school_yard", offset = Vector3.new(800.00, 0.00, 0.00) } },
  totalDuration = 52.800,
  cast = {
  { name = "Sam", gender = "boy", face = "neutral", pos = Vector3.new(-18, 0.5, 0), yaw = 270.0, counter = "STEPS: 4" },
  { name = "Max", gender = "boy", face = "grin", pos = Vector3.new(0, 0, 12), yaw = 270.0, counter = "STEPS: 6" },
  { name = "Nia", gender = "girl", face = "scared", pos = Vector3.new(16.2, 0.5, 9.5), yaw = 90.0, counter = "STEPS: 5" },
  { name = "Leo", gender = "boy", face = "neutral", pos = Vector3.new(18, 0.5, -4), yaw = 90.0, counter = "STEPS: 1" },
  { name = "Tess", gender = "girl", face = "grin", pos = Vector3.new(-18, 0.5, 0), yaw = 270.0, counter = "STEPS: 1" },
  { name = "Kai", gender = "boy", face = "neutral", pos = Vector3.new(0, 0, 0), yaw = 180.0, counter = "STEPS: 1" },
  },
  props = {
  { name = "SamPass", attach = "Sam/Right Arm", kit = "paper", text = "BUS" },
  { name = "MaxPass", attach = "Max/Right Arm", kit = "paper", text = "BUS", hide = true },
  },
  beats = {
  { n = 1, t0 = 0.000, dur = 2.400, cam = "wide", fov = 50, motion = "shake", target = "Tess", action = "run", move_to = nil, snap_to = Vector3.new(-18.00, 0.50, 0.00), face = "grin", fx = "", badge = "", yaw = 270.0, set = "street_day", counter = "STEPS: 0", face_mid = "shocked", stone = true },
  { n = 2, t0 = 2.400, dur = 2.400, cam = "closeup", fov = 50, motion = "shake", target = "Kai", action = "walk", move_to = nil, snap_to = Vector3.new(395.80, 0.00, -8.00), face = "neutral", fx = "", badge = "", partners = {{ name = "Nia", action = "recoil", face = "shocked", snap_to = Vector3.new(395.80, 0.00, 14.00), yaw = 90.0 }}, yaw = 90.0, set = "school_hallway", counter = "STEPS: 0", face_mid = "shocked", stone = true },
  { n = 3, t0 = 4.800, dur = 2.400, cam = "closeup", fov = 50, motion = "push_in", target = "Leo", action = "idle", move_to = nil, snap_to = Vector3.new(778.00, 0.00, 9.00), face = "scared", fx = "", badge = "", yaw = 180.0, set = "school_yard", counter = "1 LEFT!" },
  { n = 4, t0 = 7.200, dur = 2.400, cam = "ots", fov = 48, motion = "push_in", target = "Nia", action = "talk", move_to = nil, snap_to = Vector3.new(395.80, 0.00, 14.00), face = "scared", fx = "", badge = "", partners = {{ name = "Sam", action = "idle", face = "neutral", snap_to = Vector3.new(400.00, 0.00, 34.00), yaw = 0.0 }}, yaw = 90.0, set = "school_hallway" },
  { n = 5, t0 = 9.600, dur = 2.400, cam = "closeup", fov = 50, motion = "push_in", target = "Sam", action = "walk", move_to = nil, snap_to = Vector3.new(400.00, 0.00, 34.00), face = "determined", fx = "", badge = "", yaw = 0.0, set = "school_hallway", counter = "STEPS: 3" },
  { n = 6, t0 = 12.000, dur = 2.400, cam = "front", fov = 50, motion = "shake", target = "Max", action = "kick", move_to = nil, snap_to = Vector3.new(400.00, 0.00, 0.00), face = "grin", fx = "", badge = "", partners = {{ name = "Sam", action = "recoil", face = "scared", snap_to = Vector3.new(400.00, 0.00, 34.00), yaw = 0.0 }, { name = "Nia", action = "idle", face = "scared", snap_to = Vector3.new(395.80, 0.00, 14.00), yaw = 90.0 }}, yaw = 180.0, set = "school_hallway" },
  { n = 7, t0 = 14.400, dur = 2.400, cam = "closeup", fov = 50, motion = "push_in", target = "Sam", action = "idle", move_to = nil, snap_to = Vector3.new(400.00, 0.00, 0.00), face = "determined", fx = "", badge = "", yaw = 180.0, set = "school_hallway", counter = "STEPS: 2" },
  { n = 8, t0 = 16.800, dur = 2.400, cam = "wide", fov = 50, motion = "push_in", target = "Max", action = "point", move_to = nil, snap_to = Vector3.new(786.00, 0.00, -18.00), face = "grin", fx = "", badge = "", partners = {{ name = "Sam", action = "idle", face = "determined", snap_to = Vector3.new(786.00, 0.00, -13.00), yaw = 180.0 }, { name = "Leo", action = "idle", face = "grin", snap_to = Vector3.new(797.00, 0.00, 17.80), yaw = 0.0 }}, props = {{ name = "SamPass", hide = true }, { name = "MaxPass", show = true }}, yaw = 180.0, set = "school_yard", counter = "STEPS: 5" },
  { n = 9, t0 = 19.200, dur = 2.400, cam = "closeup", fov = 50, motion = "push_in", target = "Sam", action = "idle", move_to = nil, snap_to = Vector3.new(797.00, 0.00, 17.80), face = "determined", fx = "", badge = "", props = {{ name = "MaxPass", hide = true }, { name = "SamPass", show = true }}, yaw = 0.0, set = "school_yard", counter = "STEPS: 1" },
  { n = 10, t0 = 21.600, dur = 2.400, cam = "front", fov = 50, motion = "push_in", target = "Max", action = "point", move_to = nil, snap_to = Vector3.new(786.00, 0.00, -18.00), face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "idle", face = "grin", snap_to = Vector3.new(797.00, 0.00, 17.80), yaw = 0.0 }, { name = "Nia", action = "idle", face = "scared", snap_to = Vector3.new(800.00, 0.00, 8.00), yaw = 0.0 }}, yaw = 180.0, set = "school_yard", counter = "STEPS: 4" },
  { n = 11, t0 = 24.000, dur = 2.400, cam = "wide", fov = 50, motion = "push_in", target = "Nia", action = "wave", move_to = nil, snap_to = Vector3.new(16.20, 0.50, 9.50), face = "scared", fx = "", badge = "", partners = {{ name = "Sam", action = "idle", face = "determined", snap_to = Vector3.new(-18.00, 0.50, 0.00), yaw = 270.0 }, { name = "Leo", action = "idle", face = "scared", snap_to = Vector3.new(18.00, 0.50, -4.00), yaw = 90.0 }}, yaw = 90.0, set = "street_day" },
  { n = 12, t0 = 26.400, dur = 2.400, cam = "ots", fov = 48, motion = "shake", target = "Max", action = "run", move_to = nil, snap_to = Vector3.new(0.00, 0.00, 12.00), face = "grin", fx = "", badge = "", partners = {{ name = "Sam", action = "idle", face = "determined", snap_to = Vector3.new(-18.00, 0.50, 0.00), yaw = 270.0 }}, yaw = 270.0, set = "street_day", counter = "STEPS: 2" },
  { n = 13, t0 = 28.800, dur = 2.400, cam = "closeup", fov = 50, motion = "push_in", target = "Sam", action = "talk", move_to = nil, snap_to = Vector3.new(-18.00, 0.50, 0.00), face = "proud", fx = "", badge = "", yaw = 270.0, set = "street_day" },
  { n = 14, t0 = 31.200, dur = 2.400, cam = "front", fov = 50, motion = "push_in", target = "Max", action = "point", move_to = nil, snap_to = Vector3.new(0.00, 0.00, 12.00), face = "grin", fx = "", badge = "", yaw = 270.0, set = "street_day", counter = "STEPS: 1", face_mid = "shocked" },
  { n = 15, t0 = 33.600, dur = 2.400, cam = "closeup", fov = 50, motion = "shake", target = "Max", action = "recoil", move_to = nil, snap_to = Vector3.new(0.00, 0.00, 12.00), face = "shocked", fx = "", badge = "", yaw = 270.0, set = "street_day", counter = "STEPS: 0", stone = true },
  { n = 16, t0 = 36.000, dur = 2.400, cam = "wide", fov = 50, motion = "pull_out", target = "Max", action = "idle", move_to = nil, snap_to = Vector3.new(0.00, 0.00, 12.00), face = "shocked", fx = "", badge = "", partners = {{ name = "Leo", action = "recoil", face = "shocked", snap_to = Vector3.new(18.00, 0.50, -4.00), yaw = 90.0 }, { name = "Nia", action = "recoil", face = "shocked", snap_to = Vector3.new(16.20, 0.50, 9.50), yaw = 90.0 }}, yaw = 270.0, set = "street_day", counter = "STATUE!", stone = true },
  { n = 17, t0 = 38.400, dur = 2.400, cam = "closeup", fov = 50, motion = "push_in", target = "Nia", action = "talk", move_to = nil, snap_to = Vector3.new(16.20, 0.50, 9.50), face = "shocked", fx = "", badge = "", partners = {{ name = "Sam", action = "idle", face = "proud", snap_to = Vector3.new(-18.00, 0.50, 0.00), yaw = 270.0 }}, yaw = 90.0, set = "street_day" },
  { n = 18, t0 = 40.800, dur = 2.400, cam = "ots", fov = 48, motion = "push_in", target = "Sam", action = "idle", move_to = nil, snap_to = Vector3.new(-18.00, 0.50, 0.00), face = "proud", fx = "", badge = "", yaw = 270.0, set = "street_day" },
  { n = 19, t0 = 43.200, dur = 2.400, cam = "side_track", fov = 50, motion = "push_in", target = "Sam", action = "walk", move_to = nil, snap_to = Vector3.new(16.20, 0.50, 9.50), face = "proud", fx = "", badge = "", yaw = 90.0, set = "street_day", counter = "STEPS: 0" },
  { n = 20, t0 = 45.600, dur = 2.400, cam = "closeup", fov = 50, motion = "push_in", target = "Sam", action = "sit", move_to = nil, snap_to = Vector3.new(16.20, 0.50, 9.50), face = "proud", fx = "", badge = "", partners = {{ name = "Nia", action = "cheer", face = "proud", snap_to = Vector3.new(18.00, 0.50, -4.00), yaw = 90.0 }, { name = "Leo", action = "cheer", face = "proud", snap_to = Vector3.new(-18.00, 0.50, 0.00), yaw = 270.0 }}, yaw = 90.0, set = "street_day" },
  { n = 21, t0 = 48.000, dur = 2.400, cam = "wide", fov = 50, motion = "pull_out", target = "Max", action = "idle", move_to = nil, snap_to = Vector3.new(0.00, 0.00, 12.00), face = "shocked", fx = "", badge = "", yaw = 270.0, set = "street_day", counter = "UNTIL TOMORROW", stone = true },
  { n = 22, t0 = 50.400, dur = 2.400, cam = "closeup", fov = 50, motion = "push_in", target = "Sam", action = "talk", move_to = nil, snap_to = Vector3.new(16.20, 0.50, 9.50), face = "proud", fx = "", badge = "", yaw = 90.0, set = "street_day" },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
