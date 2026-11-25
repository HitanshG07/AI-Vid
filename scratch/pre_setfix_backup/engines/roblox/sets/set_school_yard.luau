-- Reusable Horizon-Enclosed Roblox Set Preset (AI-Vid V5.3)
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  return p
end

_G.AIVidSets.school_yard = function()
  local old = Workspace:FindFirstChild("Set_SchoolYard")
  if old then old:Destroy() end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_SchoolYard"
  part(f, "Courtyard", Vector3.new(90, 1, 90), Vector3.new(0, -0.5, 0), Color3.fromRGB(194, 186, 170), Enum.Material.Cobblestone)
  part(f, "SchoolMain", Vector3.new(64, 24, 18), Vector3.new(0, 12, -32), Color3.fromRGB(174, 84, 68), Enum.Material.Brick)
  part(f, "WingL", Vector3.new(18, 22, 68), Vector3.new(-42, 11, 0), Color3.fromRGB(165, 80, 65), Enum.Material.Brick)
  part(f, "WingR", Vector3.new(18, 22, 68), Vector3.new(42, 11, 0), Color3.fromRGB(165, 80, 65), Enum.Material.Brick)
  part(f, "BackFence", Vector3.new(90, 12, 3), Vector3.new(0, 6, 44), Color3.fromRGB(78, 92, 74), Enum.Material.Grass)
  for x = -30, 30, 15 do
    part(f, "Trunk_"..x, Vector3.new(2, 10, 2), Vector3.new(x, 5, 36), Color3.fromRGB(102, 72, 48), Enum.Material.Wood)
    part(f, "Canopy_"..x, Vector3.new(10, 9, 10), Vector3.new(x, 12, 36), Color3.fromRGB(64, 118, 62), Enum.Material.Grass)
  end
  print("[AI-Vid V5.3] Loaded horizon-enclosed set: school_yard")
end
return _G.AIVidSets.school_yard
