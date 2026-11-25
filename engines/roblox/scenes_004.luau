-- Auto-compiled by pipeline/compile_story.py (V5.3) — do not hand-edit
-- Story 004: Every Broken Promise Leaves a Mark | Format: story | Set: school_yard
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "004",
  format = "story",
  set = "school_yard",
  lighting = "day_bright",
  totalDuration = 55.970,
  cast = {
  { name = "Lena", gender = "girl", face = "neutral", pos = Vector3.new(0, 0, 4), yaw = 180.0 },
  { name = "Ben", gender = "boy", face = "grin", pos = Vector3.new(-4, 0, 2), yaw = 180.0, scale = 0.72, shirt = 8071523811, pants = 5225423257 },
  { name = "Coach", gender = "woman", face = "neutral", pos = Vector3.new(24, 0, 0.8), yaw = 180.0 },
  { name = "Maya", gender = "girl", face = "determined", pos = Vector3.new(7, 1.2, -3.65), yaw = 180.0, shirt = 86330417861158, pants = 18332980667, hair = 100973074711029 },
  { name = "Eli", gender = "boy", face = "proud", pos = Vector3.new(14, 1.2, -3.65), yaw = 180.0, shirt = 8836645430, pants = 14262996290, hair = 140624854156017 },
  { name = "Noah", gender = "boy", face = "grin", pos = Vector3.new(21, 1.2, -3.65), yaw = 180.0, shirt = 91467779965025, pants = 5225423257 },
  },
  beats = {
  { n = 1, t0 = 0.000, dur = 1.640, cam = "wide", motion = "static", target = "Ben", action = "wave", move_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Lena", action = "idle" }} },
  { n = 2, t0 = 1.640, dur = 1.660, cam = "wide", motion = "push_in", target = "Ben", action = "dance", move_to = nil, face = "grin", fx = "", badge = "" },
  { n = 3, t0 = 3.300, dur = 1.800, cam = "wide", motion = "static", target = "Lena", action = "wave", move_to = nil, face = "grin", fx = "", badge = "" },
  { n = 4, t0 = 5.100, dur = 1.260, cam = "ots", motion = "push_in", target = "Ben", action = "walk", move_to = Vector3.new(-6.00, 0.00, -3.00), face = "neutral", fx = "", badge = "" },
  { n = 5, t0 = 6.360, dur = 1.560, cam = "wide", motion = "static", target = "Coach", action = "wave", move_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 6, t0 = 7.920, dur = 2.200, cam = "wide", motion = "push_in", target = "Maya", action = "floss", move_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Eli", action = "wrestler_dance" }, { name = "Noah", action = "dance" }} },
  { n = 7, t0 = 10.120, dur = 1.720, cam = "wide", motion = "static", target = "Noah", action = "dance", move_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Maya", action = "floss" }, { name = "Eli", action = "wrestler_dance" }} },
  { n = 8, t0 = 11.840, dur = 2.000, cam = "wide", motion = "push_in", target = "Lena", action = "run", move_to = Vector3.new(6.00, 0.00, 0.00), face = "neutral", fx = "", badge = "" },
  { n = 9, t0 = 13.840, dur = 1.960, cam = "wide", motion = "static", target = "Ben", action = "idle", move_to = nil, face = "scared", fx = "", badge = "" },
  { n = 10, t0 = 15.800, dur = 1.960, cam = "ots", motion = "push_in", target = "Lena", action = "point", move_to = nil, face = "shocked", fx = "", badge = "🔴" },
  { n = 11, t0 = 17.760, dur = 1.800, cam = "wide", motion = "static", target = "Coach", action = "point", move_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 12, t0 = 19.560, dur = 1.860, cam = "wide", motion = "static", target = "Lena", action = "point", move_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 13, t0 = 21.420, dur = 1.800, cam = "ots", motion = "push_in", target = "Lena", action = "walk", move_to = Vector3.new(1.00, 0.00, 3.00), face = "shocked", fx = "", badge = "" },
  { n = 14, t0 = 23.220, dur = 1.860, cam = "wide", motion = "static", target = "Lena", action = "point", move_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 15, t0 = 25.080, dur = 1.580, cam = "wide", motion = "push_in", target = "Lena", action = "idle", move_to = nil, face = "scared", fx = "", badge = "" },
  { n = 16, t0 = 26.660, dur = 2.060, cam = "wide", motion = "push_in", target = "Lena", action = "wave", move_to = nil, face = "scared", fx = "", badge = "" },
  { n = 17, t0 = 28.720, dur = 1.640, cam = "ots", motion = "static", target = "Ben", action = "walk", move_to = Vector3.new(-8.00, 0.00, -3.00), face = "neutral", fx = "", badge = "" },
  { n = 18, t0 = 30.360, dur = 2.160, cam = "wide", motion = "push_in", target = "Lena", action = "idle", move_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 19, t0 = 32.520, dur = 1.880, cam = "wide", motion = "static", target = "Coach", action = "point", move_to = nil, face = "determined", fx = "", badge = "" },
  { n = 20, t0 = 34.400, dur = 1.760, cam = "ots", motion = "push_in", target = "Lena", action = "idle", move_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 21, t0 = 36.160, dur = 2.080, cam = "wide", motion = "static", target = "Lena", action = "walk", move_to = Vector3.new(3.00, 0.00, 0.00), face = "determined", fx = "", badge = "" },
  { n = 22, t0 = 38.240, dur = 1.580, cam = "wide", motion = "push_in", target = "Lena", action = "run", move_to = Vector3.new(-5.00, 0.00, -2.00), face = "determined", fx = "", badge = "" },
  { n = 23, t0 = 39.820, dur = 1.360, cam = "ots", motion = "static", target = "Lena", action = "wave", move_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 24, t0 = 41.180, dur = 1.800, cam = "wide", motion = "push_in", target = "Ben", action = "point", move_to = nil, face = "scared", fx = "", badge = "" },
  { n = 25, t0 = 42.980, dur = 1.860, cam = "wide", motion = "static", target = "Lena", action = "dance", move_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Ben" }}, face_partner = true },
  { n = 26, t0 = 44.840, dur = 1.940, cam = "ots", motion = "push_in", target = "Ben", action = "dance", move_to = nil, face = "determined", fx = "", badge = "" },
  { n = 27, t0 = 46.780, dur = 1.300, cam = "wide", motion = "static", target = "Lena", action = "dance", move_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Ben" }}, face_partner = true },
  { n = 28, t0 = 48.080, dur = 2.020, cam = "wide", motion = "push_in", target = "Ben", action = "dance", move_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Lena" }}, face_partner = true },
  { n = 29, t0 = 50.100, dur = 1.720, cam = "ots", motion = "static", target = "Lena", action = "idle", move_to = nil, face = "shocked", fx = "", badge = "", clear_badge = true },
  { n = 30, t0 = 51.820, dur = 2.160, cam = "wide", motion = "push_in", target = "Ben", action = "wave", move_to = nil, face = "proud", fx = "", badge = "" },
  { n = 31, t0 = 53.980, dur = 1.990, cam = "wide", motion = "static", target = "Lena", action = "dance", move_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Ben" }}, face_partner = true },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.3] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
return _G["Story" .. SceneSpec.id]
