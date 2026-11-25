-- Reusable Horizon-Enclosed Roblox Set Preset (AI-Vid V5.3)
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  return p
end

_G.AIVidSets.cozy_room = function()
  local old = Workspace:FindFirstChild("Set_CozyRoom")
  if old then old:Destroy() end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_CozyRoom"
  part(f, "Floor", Vector3.new(32, 1, 32), Vector3.new(0, -0.5, 0), Color3.fromRGB(154, 114, 78), Enum.Material.WoodPlanks)
  part(f, "Ceiling", Vector3.new(32, 1, 32), Vector3.new(0, 14.5, 0), Color3.fromRGB(235, 232, 224), Enum.Material.SmoothPlastic)
  part(f, "WallN", Vector3.new(32, 15, 1.2), Vector3.new(0, 7.5, -16), Color3.fromRGB(218, 210, 196), Enum.Material.Concrete)
  part(f, "WallS", Vector3.new(32, 15, 1.2), Vector3.new(0, 7.5, 16), Color3.fromRGB(218, 210, 196), Enum.Material.Concrete)
  part(f, "WallE", Vector3.new(1.2, 15, 32), Vector3.new(16, 7.5, 0), Color3.fromRGB(198, 190, 178), Enum.Material.Brick)
  part(f, "WallW", Vector3.new(1.2, 15, 32), Vector3.new(-16, 7.5, 0), Color3.fromRGB(198, 190, 178), Enum.Material.Brick)
  part(f, "Desk", Vector3.new(7, 3.2, 3.2), Vector3.new(-8, 1.6, -12), Color3.fromRGB(112, 78, 52), Enum.Material.Wood)
  print("[AI-Vid V5.3] Loaded horizon-enclosed set: cozy_room")
end
return _G.AIVidSets.cozy_room
