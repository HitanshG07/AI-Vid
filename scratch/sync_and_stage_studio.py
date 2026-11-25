import json
from pathlib import Path

# Read the newly compiled scenes_006.luau and strip the final return
scenes_code = Path("engines/roblox/scenes_006.luau").read_text(encoding="utf-8")
scenes_code = scenes_code.replace('return _G["Story" .. SceneSpec.id]', '-- scene compiled')

# Prepare Luau code that sets up everything in Studio:
# 1. Runs scenes_006.luau (setup Cast_006 and Props_006)
# 2. Re-runs EventProps_006 and Crowd_006 with the new uncrowded spacing
stage_code = f"""
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- 1. Setup compiled scene
{scenes_code}

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
for i, off in ipairs({{ Vector3.new(-3.2, -1.1, -1.3), Vector3.new(3.2, -1.1, -1.3), Vector3.new(-3.2, -1.1, 1.3), Vector3.new(3.2, -1.1, 1.3) }}) do
  makePart(stall, "Leg_"..i, Vector3.new(0.45, 2.0, 0.45), CFrame.new(Vector3.new(19, 2.2, 15) + off), Color3.fromRGB(95, 62, 38), Enum.Material.WoodPlanks)
end
makePart(stall, "FabricSkirt", Vector3.new(6.8, 1.9, 0.15), CFrame.new(19, 1.25, 13.45), Color3.fromRGB(32, 45, 78), Enum.Material.Fabric)
for _, xOff in ipairs({{ -3.45, 3.45 }}) do
  for _, zOff in ipairs({{ -1.55, 1.55 }}) do
    makePart(stall, "BrassBracket", Vector3.new(0.3, 0.42, 0.3), CFrame.new(19 + xOff, 2.2, 15 + zOff), Color3.fromRGB(190, 155, 65), Enum.Material.Metal)
  end
end

-- Prize Crate Hardware Detail (on crate at 18.2, 2.75, 15)
local crateDetail = Instance.new("Model", eventProps); crateDetail.Name = "PrizeCrateDetail"
local cPos = Vector3.new(18.2, 2.75, 15)
for i, off in ipairs({{
  Vector3.new(-0.95, 0.75, -0.95), Vector3.new(0.95, 0.75, -0.95),
  Vector3.new(-0.95, -0.75, -0.95), Vector3.new(0.95, -0.75, -0.95),
  Vector3.new(-0.95, 0.75, 0.95), Vector3.new(0.95, 0.75, 0.95),
  Vector3.new(-0.95, -0.75, 0.95), Vector3.new(0.95, -0.75, 0.95)
}}) do
  makePart(crateDetail, "CornerBracket_"..i, Vector3.new(0.25, 0.25, 0.25), CFrame.new(cPos + off), Color3.fromRGB(205, 170, 75), Enum.Material.Metal)
end
makePart(crateDetail, "BrassHasp", Vector3.new(0.4, 0.5, 0.1), CFrame.new(18.2, 2.8, 13.95), Color3.fromRGB(180, 140, 50), Enum.Material.Metal)
makePart(crateDetail, "PadlockBody", Vector3.new(0.35, 0.4, 0.15), CFrame.new(18.2, 2.65, 13.9), Color3.fromRGB(215, 180, 70), Enum.Material.Metal)
makePart(crateDetail, "PadlockShackle", Vector3.new(0.25, 0.25, 0.1), CFrame.new(18.2, 2.88, 13.9), Color3.fromRGB(160, 165, 175), Enum.Material.Metal)

-- Rock Salt Dumpster
local dumpster = Instance.new("Model", eventProps); dumpster.Name = "RockSaltDumpster"
local dBody = makePart(dumpster, "DumpsterBody", Vector3.new(3.4, 3.2, 4.2), CFrame.new(13.6, 1.7, 15), Color3.fromRGB(42, 68, 50), Enum.Material.CorrodedMetal)
makePart(dumpster, "DumpsterLid", Vector3.new(3.6, 0.35, 4.4), CFrame.new(13.6, 3.35, 15) * CFrame.Angles(0, 0, math.rad(6)), Color3.fromRGB(38, 58, 44), Enum.Material.Metal)
for i, off in ipairs({{ Vector3.new(-1.4, -1.45, -1.8), Vector3.new(1.4, -1.45, -1.8), Vector3.new(-1.4, -1.45, 1.8), Vector3.new(1.4, -1.45, 1.8) }}) do
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
stencilLabel.Text = "CITY SANITATION\\n[ROCK SALT DEPOT]\\nGRADE 4 COARSE"
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
chalkText.Text = "★ GRAND PRIZE EVENT ★\\n\\n10,000 COIN DRAWING\\n\\nWAIT AT LAMP POST\\nDO NOT CROWD STALL"
chalkText.Font = Enum.Font.SourceSansBold; chalkText.TextColor3 = Color3.fromRGB(250, 245, 230); chalkText.TextSize = 22; chalkText.TextWrapped = true

-- 3. Build Crowd_006 with Organic Spacing
local oldCrowd = Workspace:FindFirstChild("Crowd_006")
if oldCrowd then oldCrowd:Destroy() end
local crowdFolder = Instance.new("Folder", Workspace)
crowdFolder.Name = "Crowd_006"

local EXTRAS_DATA = {{
  {{ name = "Extra_Boy1", gender = "boy", skin = Color3.fromRGB(234, 184, 146), shirt = 144076358, pants = 398635338, hair = "17877340", pos = Vector3.new(20.2, 0, -5.5), yaw = 175 }},
  {{ name = "Extra_Boy2", gender = "boy", skin = Color3.fromRGB(196, 144, 102), shirt = 382538295, pants = 398633812, hair = "98588731108499", pos = Vector3.new(19.8, 0, 0.5), yaw = 185 }},
  {{ name = "Extra_Boy3", gender = "boy", skin = Color3.fromRGB(130, 85, 55), shirt = 398633584, pants = 144076760, hair = "376524487", pos = Vector3.new(20.3, 0, 6.5), yaw = 170 }},
  {{ name = "Extra_Boy4", gender = "boy", skin = Color3.fromRGB(245, 205, 175), shirt = 144076358, pants = 144076760, hair = "17877340", pos = Vector3.new(19.9, 0, 10.5), yaw = 180 }},
  {{ name = "Extra_Girl1", gender = "girl", skin = Color3.fromRGB(245, 205, 175), shirt = 91467779965025, pants = 13979853518, hair = "10084548738", pos = Vector3.new(20.1, 0, -3.5), yaw = 185 }},
  {{ name = "Extra_Girl2", gender = "girl", skin = Color3.fromRGB(196, 144, 102), shirt = 91467779965025, pants = 13979853518, hair = "10084548738", pos = Vector3.new(20.0, 0, 4.5), yaw = 175 }},
  {{ name = "Extra_Girl3", gender = "girl", skin = Color3.fromRGB(234, 184, 146), shirt = 91467779965025, pants = 13979853518, hair = "10084548738", pos = Vector3.new(20.4, 0, 12.0), yaw = 190 }},
  {{ name = "Extra_Girl4", gender = "girl", skin = Color3.fromRGB(110, 68, 40), shirt = 91467779965025, pants = 13979853518, hair = "10084548738", pos = Vector3.new(19.8, 0, -2.0), yaw = 170 }},
  {{ name = "Extra_Adult1", gender = "man", skin = Color3.fromRGB(215, 165, 125), shirt = 607785314, pants = 144076760, hair = "62234425", pos = Vector3.new(20.3, 0, -1.0), yaw = 180 }},
  {{ name = "Extra_Adult2", gender = "man", skin = Color3.fromRGB(160, 110, 75), shirt = 607785314, pants = 398635338, hair = "62234425", pos = Vector3.new(20.0, 0, 13.5), yaw = 180 }},
}}

local FACE_IDS = {{
  neutral = "rbxassetid://70950815478959",
  scared  = "rbxassetid://94514852927815",
  shocked = "rbxassetid://103057607693548",
  grin    = "rbxassetid://96253429845051",
}}

local function buildExtra(spec, parent)
  local d = Instance.new("HumanoidDescription")
  d.Shirt = spec.shirt; d.Pants = spec.pants
  if spec.hair and spec.hair ~= "" then d.HairAccessory = spec.hair end
  for _, part in ipairs({{"HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor"}}) do
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
for _, folderName in ipairs({{"Cast_006", "Crowd_006"}}) do
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
"""

Path("scratch/stage_studio.luau").write_text(stage_code, encoding="utf-8")
print("Written scratch/stage_studio.luau successfully!")
