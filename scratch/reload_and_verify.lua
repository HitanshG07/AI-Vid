-- Reload Story 006 Scene Spec and Spawn Crowd 50 into Roblox Studio
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local Engine = _G.AIVidCore
assert(Engine, "Engine not found in _G.AIVidCore")

local SceneSpec = {
  id = "006",
  format = "story",
  set = "street_day",
  lighting = "day_bright",
  totalDuration = 42.040,
  cast = {
  { name = "Leo", gender = "boy", face = "neutral", pos = Vector3.new(20, 0, -4), yaw = 0.0, shirt = 398633584, pants = 144076760, hair = 17877340 },
  { name = "Chad", gender = "boy", face = "grin", pos = Vector3.new(17.5, 0, -8.5), yaw = 0.0, scale = 1.20, shirt = 144076358, pants = 398635338, hair = 376524487 },
  { name = "Zoe", gender = "girl", face = "neutral", pos = Vector3.new(20, 0, 4), yaw = 0.0, scale = 0.96, shirt = 91467779965025, pants = 13979853518, hair = 10084548738 },
  { name = "Milo", gender = "boy", face = "neutral", pos = Vector3.new(20, 0, 12), yaw = 0.0, scale = 0.98, shirt = 382538295, pants = 398633812, hair = 98588731108499 },
  { name = "Vendor", gender = "man", face = "neutral", pos = Vector3.new(20, 0, 18), yaw = 0.0, scale = 1.08, shirt = 607785314, pants = 144076760, hair = 62234425 },
  },
  props = {
  { name = "PrizeCrate", shape = "block", material = "Metal", size = Vector3.new(2.00, 1.60, 2.00), pos = Vector3.new(18.20, 2.75, 17.00), color = Color3.fromRGB(225, 180, 45) },
  { name = "SodaCup", shape = "cylinder", material = "SmoothPlastic", attach = "Leo/Right Arm", size = Vector3.new(0.60, 0.80, 0.60), pos = Vector3.new(20.80, 2.50, -4.00), offset = Vector3.new(0.00, -0.80, 0.00), color = Color3.fromRGB(220, 40, 40) },
  },
  beats = {
  { n = 1, t0 = 0.000, dur = 1.685, cam = "closeup", fov = 44, motion = "push_in", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 2, t0 = 1.685, dur = 1.475, cam = "closeup", fov = 46, motion = "push_in", target = "Chad", action = "punch", move_to = nil, snap_to = Vector3.new(19.20, 0.00, -5.20), face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "knockback", face = "shocked" }} },
  { n = 3, t0 = 3.160, dur = 2.480, cam = "wide", fov = 54, motion = "static", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", props = {{ name = "SodaCup", hide = true }} },
  { n = 4, t0 = 5.640, dur = 1.980, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Chad", action = "run", move_to = Vector3.new(20.00, 0.00, 0.00), snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Zoe", action = "block", face = "scared" }} },
  { n = 5, t0 = 7.620, dur = 2.100, cam = "closeup", fov = 44, motion = "push_in", target = "Zoe", action = "point", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Chad", action = "idle", face = "grin" }} },
  { n = 6, t0 = 9.720, dur = 1.680, cam = "closeup", fov = 44, motion = "push_in", target = "Chad", action = "wave", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 7, t0 = 11.400, dur = 1.880, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Chad", action = "run", move_to = Vector3.new(20.00, 0.00, 8.00), snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Milo", action = "block", face = "scared" }} },
  { n = 8, t0 = 13.280, dur = 1.840, cam = "closeup", fov = 44, motion = "push_in", target = "Milo", action = "point", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 9, t0 = 15.120, dur = 2.260, cam = "wide", fov = 54, motion = "push_in", target = "Chad", action = "point", move_to = Vector3.new(19.00, 0.00, 16.00), snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Vendor", action = "idle", face = "neutral" }} },
  { n = 10, t0 = 17.380, dur = 2.140, cam = "closeup", fov = 44, motion = "push_in", target = "Chad", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 11, t0 = 19.520, dur = 2.560, cam = "closeup", fov = 44, motion = "push_in", target = "Vendor", action = "point", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 12, t0 = 22.080, dur = 1.280, cam = "wide", fov = 54, motion = "static", target = "Chad", action = "dance", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Milo", action = "idle", face = "scared" }, { name = "Zoe", action = "idle", face = "scared" }} },
  { n = 13, t0 = 23.360, dur = 2.960, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Vendor", action = "walk", move_to = Vector3.new(20.00, 0.00, 10.00), snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Chad", action = "block", face = "neutral" }} },
  { n = 14, t0 = 26.320, dur = 2.720, cam = "ots", fov = 46, motion = "push_in", target = "Vendor", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "idle", face = "shocked", yaw = 180.0 }} },
  { n = 15, t0 = 29.040, dur = 0.940, cam = "closeup", fov = 44, motion = "push_in", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", yaw = 180.0 },
  { n = 16, t0 = 29.980, dur = 2.800, cam = "wide", fov = 54, motion = "push_in", target = "Vendor", action = "wave", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "idle", face = "proud", yaw = 180.0 }} },
  { n = 17, t0 = 32.780, dur = 1.680, cam = "closeup", fov = 44, motion = "shake", target = "Chad", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "alert" },
  { n = 18, t0 = 34.460, dur = 2.980, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Vendor", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Chad", action = "knockback", face = "shocked" }} },
  { n = 19, t0 = 37.440, dur = 2.300, cam = "wide", fov = 54, motion = "static", target = "Chad", action = "fall", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Zoe", action = "point", face = "grin" }, { name = "Milo", action = "point", face = "grin" }} },
  { n = 20, t0 = 39.740, dur = 2.300, cam = "closeup", fov = 42, motion = "static", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "green_check", yaw = 180.0 },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s compiled and ready!", SceneSpec.id))

-- Reposition Cast to starting positions
local cast = Workspace:FindFirstChild("Cast_006")
if cast then
    if cast:FindFirstChild("Leo") then cast.Leo:PivotTo(CFrame.new(20, 3.5, -4) * CFrame.Angles(0, 0, 0)) end
    if cast:FindFirstChild("Chad") then cast.Chad:PivotTo(CFrame.new(17.5, 3.5, -8.5) * CFrame.Angles(0, 0, 0)) end
    if cast:FindFirstChild("Zoe") then cast.Zoe:PivotTo(CFrame.new(20, 3.38, 4) * CFrame.Angles(0, 0, 0)) end
    if cast:FindFirstChild("Milo") then cast.Milo:PivotTo(CFrame.new(20, 3.44, 12) * CFrame.Angles(0, 0, 0)) end
    if cast:FindFirstChild("Vendor") then cast.Vendor:PivotTo(CFrame.new(20, 3.74, 18) * CFrame.Angles(0, 0, 0)) end
end

-- Ensure SodaCup is attached to Leo Right Arm
local propsFolder = Workspace:FindFirstChild("Props_006")
local cup = propsFolder and propsFolder:FindFirstChild("SodaCup")
local leoArm = cast and cast:FindFirstChild("Leo") and cast.Leo:FindFirstChild("Right Arm")
if cup and leoArm then
    cup.Position = leoArm.Position + Vector3.new(0, -0.8, 0)
    cup.Transparency = 0
    for _, ch in ipairs(cup:GetDescendants()) do
        if ch:IsA("BasePart") then ch.Transparency = 0 end
    end
end

return "Story 006 recompiled, cast reset to starting poses."
