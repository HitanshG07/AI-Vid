
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- 1. Setup compiled scene
-- Auto-compiled by pipeline/compile_story.py (V5.4) — do not hand-edit
-- Story 006: You Cut the Wrong Line 😈 | Format: story | Set: street_day
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "006",
  format = "story",
  set = "street_day",
  lighting = "day_bright",
  totalDuration = 40.620,
  cast = {
  { name = "Leo", gender = "boy", face = "neutral", pos = Vector3.new(20, 0, -8), yaw = 0.0, scale = 1.00, shirt = 398633584, pants = 144076760, hair = 17877340 },
  { name = "Chad", gender = "boy", face = "grin", pos = Vector3.new(18, 0, -12), yaw = 0.0, scale = 1.05, shirt = 144076358, pants = 398635338, hair = 376524487 },
  { name = "Zoe", gender = "girl", face = "neutral", pos = Vector3.new(20, 0, 2.5), yaw = 0.0, scale = 0.96, shirt = 91467779965025, pants = 13979853518, hair = 10084548738 },
  { name = "Milo", gender = "boy", face = "neutral", pos = Vector3.new(20, 0, 8.5), yaw = 0.0, scale = 0.98, shirt = 382538295, pants = 398633812, hair = 98588731108499 },
  { name = "Vendor", gender = "man", face = "neutral", pos = Vector3.new(20, 0, 16.5), yaw = 0.0, scale = 1.02, shirt = 607785314, pants = 144076760, hair = 62234425 },
  },
  props = {
  { name = "PrizeCrate", shape = "block", material = "WoodPlanks", size = Vector3.new(2.00, 1.60, 2.00), pos = Vector3.new(18.20, 2.75, 15.00), color = Color3.fromRGB(160, 110, 50) },
  { name = "SodaCup", shape = "cylinder", material = "SmoothPlastic", attach = "Leo/Left Arm", size = Vector3.new(0.60, 0.80, 0.60), pos = Vector3.new(19.20, 2.50, -8.00), offset = Vector3.new(0.00, -0.80, 0.00), color = Color3.fromRGB(220, 40, 40) },
  },
  beats = {
  { n = 1, t0 = 0.000, dur = 2.360, cam = "ots", fov = 48, motion = "push_in", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 2, t0 = 2.360, dur = 1.300, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Chad", action = "punch", move_to = nil, snap_to = Vector3.new(19.20, 0.00, -9.00), face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "knockback", face = "shocked" }} },
  { n = 3, t0 = 3.660, dur = 1.720, cam = "wide", fov = 54, motion = "static", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", props = {{ name = "SodaCup", hide = true }} },
  { n = 4, t0 = 5.380, dur = 2.280, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Chad", action = "run", move_to = Vector3.new(20.00, 0.00, 0.50), snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Zoe", action = "block", face = "scared" }} },
  { n = 5, t0 = 7.660, dur = 1.880, cam = "ots", fov = 48, motion = "push_in", target = "Zoe", action = "point", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Chad", action = "idle", face = "grin" }} },
  { n = 6, t0 = 9.540, dur = 1.100, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Chad", action = "wave", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 7, t0 = 10.640, dur = 2.420, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Chad", action = "run", move_to = Vector3.new(20.00, 0.00, 6.50), snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Milo", action = "block", face = "scared" }} },
  { n = 8, t0 = 13.060, dur = 1.360, cam = "ots", fov = 48, motion = "push_in", target = "Milo", action = "point", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", yaw = 30.0 },
  { n = 9, t0 = 14.420, dur = 2.220, cam = "wide", fov = 52, motion = "push_in", target = "Chad", action = "point", move_to = Vector3.new(19.00, 0.00, 14.00), snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Vendor", action = "idle", face = "neutral" }} },
  { n = 10, t0 = 16.640, dur = 2.080, cam = "ots", fov = 48, motion = "push_in", target = "Chad", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", yaw = 20.0 },
  { n = 11, t0 = 18.720, dur = 2.500, cam = "ots", fov = 48, motion = "push_in", target = "Vendor", action = "point", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "", yaw = 40.0 },
  { n = 12, t0 = 21.220, dur = 1.440, cam = "wide", fov = 52, motion = "static", target = "Chad", action = "dance", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Milo", action = "idle", face = "scared" }, { name = "Zoe", action = "idle", face = "scared" }} },
  { n = 13, t0 = 22.660, dur = 2.900, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Vendor", action = "walk", move_to = Vector3.new(20.00, 0.00, 8.00), snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Chad", action = "block", face = "neutral" }} },
  { n = 14, t0 = 25.560, dur = 2.460, cam = "ots", fov = 48, motion = "push_in", target = "Vendor", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "idle", face = "shocked" }} },
  { n = 15, t0 = 28.020, dur = 0.912, cam = "ots", fov = 48, motion = "push_in", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 16, t0 = 28.932, dur = 2.428, cam = "wide", fov = 52, motion = "push_in", target = "Vendor", action = "wave", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "idle", face = "proud" }} },
  { n = 17, t0 = 31.360, dur = 1.560, cam = "ots", fov = 48, motion = "shake", target = "Chad", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "alert", yaw = 20.0 },
  { n = 18, t0 = 32.920, dur = 2.620, cam = "reverse_ots", fov = 48, motion = "push_in", target = "Vendor", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Chad", action = "knockback", face = "shocked" }} },
  { n = 19, t0 = 35.540, dur = 2.780, cam = "wide", fov = 52, motion = "static", target = "Chad", action = "fall", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Zoe", action = "point", face = "grin" }, { name = "Milo", action = "point", face = "grin" }}, yaw = 90.0 },
  { n = 20, t0 = 38.320, dur = 2.300, cam = "ots", fov = 46, motion = "static", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "green_check" },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))
-- scene compiled


_G.Story006.setup()

-- 2. Build EventProps_006
local oldProps = Workspace:FindFirstChild("EventProps_006")
if oldProps then oldProps:Destroy() end
local eventProps = Instance.new("Folder", Workspace)
eventProps.Name = "EventProps_006"

local function makePart(parent, name, size, cf, color, mat)
  local p = Instance.new("Part")
  p.Name = name; p.Size = size; p.CFrame = cf; p.Color = color
  p.Material = mat or Enum.Material.SmoothPlastic
  p.Anchored = true; p.CanCollide = false; p.CastShadow = true; p.Parent = parent
  return p
end

-- Market Counter Table
local stall = Instance.new("Model", eventProps); stall.Name = "MarketCounter"
makePart(stall, "TableTop", Vector3.new(7, 0.4, 3.2), CFrame.new(19, 2.2, 15), Color3.fromRGB(135, 90, 55), Enum.Material.WoodPlanks)
for i, off in ipairs({ Vector3.new(-3.2, -1.1, -1.3), Vector3.new(3.2, -1.1, -1.3), Vector3.new(-3.2, -1.1, 1.3), Vector3.new(3.2, -1.1, 1.3) }) do
  makePart(stall, "Leg_"..i, Vector3.new(0.45, 2.0, 0.45), CFrame.new(Vector3.new(19, 2.2, 15) + off), Color3.fromRGB(95, 62, 38), Enum.Material.WoodPlanks)
end
makePart(stall, "FabricSkirt", Vector3.new(6.8, 1.9, 0.15), CFrame.new(19, 1.25, 13.45), Color3.fromRGB(32, 45, 78), Enum.Material.Fabric)
for _, xOff in ipairs({ -3.45, 3.45 }) do
  for _, zOff in ipairs({ -1.55, 1.55 }) do
    makePart(stall, "BrassBracket", Vector3.new(0.3, 0.42, 0.3), CFrame.new(19 + xOff, 2.2, 15 + zOff), Color3.fromRGB(190, 155, 65), Enum.Material.Metal)
  end
end

-- Prize Crate Hardware Detail (on crate at 18.2, 2.75, 15)
local crateDetail = Instance.new("Model", eventProps); crateDetail.Name = "PrizeCrateDetail"
local cPos = Vector3.new(18.2, 2.75, 15)
for i, off in ipairs({
  Vector3.new(-0.95, 0.75, -0.95), Vector3.new(0.95, 0.75, -0.95),
  Vector3.new(-0.95, -0.75, -0.95), Vector3.new(0.95, -0.75, -0.95),
  Vector3.new(-0.95, 0.75, 0.95), Vector3.new(0.95, 0.75, 0.95),
  Vector3.new(-0.95, -0.75, 0.95), Vector3.new(0.95, -0.75, 0.95)
}) do
  makePart(crateDetail, "CornerBracket_"..i, Vector3.new(0.25, 0.25, 0.25), CFrame.new(cPos + off), Color3.fromRGB(205, 170, 75), Enum.Material.Metal)
end
makePart(crateDetail, "BrassHasp", Vector3.new(0.4, 0.5, 0.1), CFrame.new(18.2, 2.8, 13.95), Color3.fromRGB(180, 140, 50), Enum.Material.Metal)
makePart(crateDetail, "PadlockBody", Vector3.new(0.35, 0.4, 0.15), CFrame.new(18.2, 2.65, 13.9), Color3.fromRGB(215, 180, 70), Enum.Material.Metal)
makePart(crateDetail, "PadlockShackle", Vector3.new(0.25, 0.25, 0.1), CFrame.new(18.2, 2.88, 13.9), Color3.fromRGB(160, 165, 175), Enum.Material.Metal)

-- Rock Salt Dumpster
local dumpster = Instance.new("Model", eventProps); dumpster.Name = "RockSaltDumpster"
local dBody = makePart(dumpster, "DumpsterBody", Vector3.new(3.4, 3.2, 4.2), CFrame.new(13.6, 1.7, 15), Color3.fromRGB(42, 68, 50), Enum.Material.CorrodedMetal)
makePart(dumpster, "DumpsterLid", Vector3.new(3.6, 0.35, 4.4), CFrame.new(13.6, 3.35, 15) * CFrame.Angles(0, 0, math.rad(6)), Color3.fromRGB(38, 58, 44), Enum.Material.Metal)
for i, off in ipairs({ Vector3.new(-1.4, -1.45, -1.8), Vector3.new(1.4, -1.45, -1.8), Vector3.new(-1.4, -1.45, 1.8), Vector3.new(1.4, -1.45, 1.8) }) do
  makePart(dumpster, "Wheel_"..i, Vector3.new(0.5, 0.5, 0.5), CFrame.new(Vector3.new(13.6, 1.7, 15) + off), Color3.fromRGB(25, 25, 28), Enum.Material.Metal)
end
makePart(dumpster, "SaltSpillSidewalk", Vector3.new(2.8, 0.18, 3.2), CFrame.new(15.6, 0.58, 15), Color3.fromRGB(242, 244, 246), Enum.Material.Sand)
makePart(dumpster, "SaltSpillCurb", Vector3.new(1.8, 0.22, 2.5), CFrame.new(13.8, 0.2, 16.2), Color3.fromRGB(235, 238, 240), Enum.Material.Concrete)

local stencilGui = Instance.new("SurfaceGui")
stencilGui.Name = "StencilGui"; stencilGui.Face = Enum.NormalId.Right
stencilGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud; stencilGui.PixelsPerStud = 50
stencilGui.Parent = dBody
local stencilLabel = Instance.new("TextLabel", stencilGui)
stencilLabel.Size = UDim2.new(1, 0, 1, 0); stencilLabel.BackgroundTransparency = 1
stencilLabel.Text = "CITY SANITATION\n[ROCK SALT DEPOT]\nGRADE 4 COARSE"
stencilLabel.Font = Enum.Font.GothamBold; stencilLabel.TextColor3 = Color3.fromRGB(235, 195, 45)
stencilLabel.TextSize = 22; stencilLabel.TextWrapped = true

-- A-Frame Sign at curb entrance X=14.0, Z=-10.0
local aFrame = Instance.new("Model", eventProps); aFrame.Name = "AFrameSign"
makePart(aFrame, "BoardA", Vector3.new(0.18, 3.4, 2.4), CFrame.new(14.0, 1.7, -10.0) * CFrame.Angles(0, 0, math.rad(14)), Color3.fromRGB(90, 62, 40), Enum.Material.WoodPlanks)
makePart(aFrame, "BoardB", Vector3.new(0.18, 3.4, 2.4), CFrame.new(14.0, 1.7, -10.0) * CFrame.Angles(0, 0, math.rad(-14)), Color3.fromRGB(90, 62, 40), Enum.Material.WoodPlanks)
local chalkBoard = makePart(aFrame, "ChalkFace", Vector3.new(0.08, 2.7, 2.0), CFrame.new(14.45, 1.7, -10.0) * CFrame.Angles(0, 0, math.rad(-14)), Color3.fromRGB(34, 36, 40), Enum.Material.Slate)
local chalkGui = Instance.new("SurfaceGui", chalkBoard)
chalkGui.Name = "ChalkGui"; chalkGui.Face = Enum.NormalId.Right
chalkGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud; chalkGui.PixelsPerStud = 50
local chalkText = Instance.new("TextLabel", chalkGui)
chalkText.Size = UDim2.new(1, -20, 1, -20); chalkText.Position = UDim2.new(0, 10, 0, 10); chalkText.BackgroundTransparency = 1
chalkText.Text = "★ GRAND PRIZE EVENT ★\n\n10,000 COIN DRAWING\n\nWAIT AT LAMP POST\nDO NOT CROWD STALL"
chalkText.Font = Enum.Font.SourceSansBold; chalkText.TextColor3 = Color3.fromRGB(250, 245, 230); chalkText.TextSize = 22; chalkText.TextWrapped = true

-- 3. Build Crowd_006 with Organic Spacing
local oldCrowd = Workspace:FindFirstChild("Crowd_006")
if oldCrowd then oldCrowd:Destroy() end
local crowdFolder = Instance.new("Folder", Workspace)
crowdFolder.Name = "Crowd_006"

local EXTRAS_DATA = {
  -- Boys (4 distinct outfits & hair, zero overlap with Leo/Chad/Milo)
  { name = "Extra_Boy1", gender = "boy", skin = Color3.fromRGB(234, 184, 146), shirt = 86330417861158, pants = 12671481024, hair = "71343213020367", pos = Vector3.new(20.2, 0, -5.5), yaw = 175 },
  { name = "Extra_Boy2", gender = "boy", skin = Color3.fromRGB(196, 144, 102), shirt = 12329928029, pants = 134609569320601, hair = "124340390453001", pos = Vector3.new(19.8, 0, 0.5), yaw = 185 },
  { name = "Extra_Boy3", gender = "boy", skin = Color3.fromRGB(130, 85, 55), shirt = 78421295651694, pants = 12574395860, hair = "74528752688799", pos = Vector3.new(20.3, 0, 6.5), yaw = 170 },
  { name = "Extra_Boy4", gender = "boy", skin = Color3.fromRGB(245, 205, 175), shirt = 93684471979859, pants = 89518846190037, hair = "94946081980224", pos = Vector3.new(19.9, 0, 10.5), yaw = 180 },
  
  -- Girls (4 distinct outfits & hair, zero overlap with Zoe)
  { name = "Extra_Girl1", gender = "girl", skin = Color3.fromRGB(245, 205, 175), shirt = 133484080647039, pants = 389857088, hair = "100973074711029", pos = Vector3.new(20.1, 0, -3.5), yaw = 185 },
  { name = "Extra_Girl2", gender = "girl", skin = Color3.fromRGB(196, 144, 102), shirt = 85435724220934, pants = 18332980667, hair = "17890789000", pos = Vector3.new(20.0, 0, 4.5), yaw = 175 },
  { name = "Extra_Girl3", gender = "girl", skin = Color3.fromRGB(234, 184, 146), shirt = 5688801027, pants = 6092144716, hair = "140124368601570", pos = Vector3.new(20.4, 0, 12.0), yaw = 190 },
  { name = "Extra_Girl4", gender = "girl", skin = Color3.fromRGB(110, 68, 40), shirt = 18566797626, pants = 5498774219, hair = "129421843016867", pos = Vector3.new(19.8, 0, -2.0), yaw = 170 },
  
  -- Adults / Teens (2 distinct outfits & hair, zero overlap with Vendor)
  { name = "Extra_Adult1", gender = "man", skin = Color3.fromRGB(215, 165, 125), shirt = 2885430411, pants = 140429444258386, hair = "120646937583722", pos = Vector3.new(20.3, 0, -1.0), yaw = 180 },
  { name = "Extra_Adult2", gender = "man", skin = Color3.fromRGB(160, 110, 75), shirt = 4593507067, pants = 3234753288, hair = "139671521768286", pos = Vector3.new(20.0, 0, 13.5), yaw = 180 },
}

local FACE_IDS = {
  neutral = "rbxassetid://70950815478959",
  scared  = "rbxassetid://94514852927815",
  shocked = "rbxassetid://103057607693548",
  grin    = "rbxassetid://96253429845051",
}

local function buildExtra(spec, parent)
  local d = Instance.new("HumanoidDescription")
  d.Shirt = spec.shirt; d.Pants = spec.pants
  if spec.hair and spec.hair ~= "" then d.HairAccessory = spec.hair end
  for _, part in ipairs({"HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor"}) do
    d[part] = spec.skin
  end
  local m = Players:CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R6)
  m.Name = spec.name
  local hrp = m:FindFirstChild("HumanoidRootPart")
  if hrp then m.PrimaryPart = hrp end
  local hum = m:FindFirstChildOfClass("Humanoid")
  if hum then
    hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
    hum.DisplayName = ""
  end
  local scale = (spec.gender == "girl") and 0.96 or (spec.gender == "boy" and 0.98 or 1.02)
  m:ScaleTo(scale)
  local targetPos = spec.pos
  m:PivotTo(CFrame.new(targetPos.X, 0.5, targetPos.Z) * CFrame.Angles(0, math.rad(spec.yaw or 0), 0))
  local low = math.huge
  for _, p in ipairs(m:GetChildren()) do
    if p:IsA("BasePart") then low = math.min(low, p.Position.Y - p.Size.Y / 2) end
  end
  m:PivotTo(m:GetPivot() + Vector3.new(0, 0.5 - low, 0))
  for _, p in ipairs(m:GetDescendants()) do
    if p:IsA("BasePart") then
      p.Anchored = (p.Name == "HumanoidRootPart")
      p.CanCollide = false
    elseif p:IsA("LuaSourceContainer") then
      p:Destroy()
    end
  end
  local head = m:FindFirstChild("Head")
  if head then
    local face = head:FindFirstChild("face") or Instance.new("Decal", head)
    face.Name = "face"; face.Texture = FACE_IDS.neutral
  end
  m.Parent = parent
  return m
end

for _, spec in ipairs(EXTRAS_DATA) do
  buildExtra(spec, crowdFolder)
end

-- Floor snap all models
for _, folderName in ipairs({"Cast_006", "Crowd_006"}) do
  local f = Workspace:FindFirstChild(folderName)
  if f then
    for _, m in ipairs(f:GetChildren()) do
      if m:IsA("Model") then
        local low = math.huge
        for _, p in ipairs(m:GetChildren()) do
          if p:IsA("BasePart") then low = math.min(low, p.Position.Y - p.Size.Y / 2) end
        end
        m:PivotTo(m:GetPivot() + Vector3.new(0, 0.5 - low, 0))
      end
    end
  end
end

return "Staged Story 006, EventProps_006, and Crowd_006 successfully!"
