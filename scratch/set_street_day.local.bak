-- Reusable Horizon-Enclosed Roblox Set Preset (AI-Vid V5.3)
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  return p
end

_G.AIVidSets.street_day = function()
  local old = Workspace:FindFirstChild("Set_StreetDay")
  if old then old:Destroy() end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_StreetDay"
  -- Textured road + sidewalks (no empty green void)
  part(f, "Road", Vector3.new(28, 1, 180), Vector3.new(0, -0.3, 0), Color3.fromRGB(58, 62, 70), Enum.Material.Asphalt)
  part(f, "SidewalkL", Vector3.new(14, 1.3, 180), Vector3.new(-21, -0.15, 0), Color3.fromRGB(185, 188, 192), Enum.Material.Concrete)
  part(f, "SidewalkR", Vector3.new(14, 1.3, 180), Vector3.new(21, -0.15, 0), Color3.fromRGB(185, 188, 192), Enum.Material.Concrete)
  -- Horizon-enclosing brick storefronts along both sides + end-cap buildings
  local colors = { Color3.fromRGB(178, 92, 74), Color3.fromRGB(110, 132, 158), Color3.fromRGB(196, 165, 118), Color3.fromRGB(130, 108, 96) }
  for i = -4, 4 do
    local z = i * 20
    part(f, "BldgL_"..i, Vector3.new(22, 26 + (i%2)*8, 19), Vector3.new(-39, 13, z), colors[(i%4)+1], Enum.Material.Brick)
    part(f, "BldgR_"..i, Vector3.new(22, 28 + ((i+1)%2)*6, 19), Vector3.new(39, 14, z), colors[((i+2)%4)+1], Enum.Material.Brick)
    part(f, "LampL_"..i, Vector3.new(0.6, 12, 0.6), Vector3.new(-15, 6, z), Color3.fromRGB(40, 44, 52), Enum.Material.Metal)
    part(f, "LampR_"..i, Vector3.new(0.6, 12, 0.6), Vector3.new(15, 6, z), Color3.fromRGB(40, 44, 52), Enum.Material.Metal)
  end
  part(f, "HorizonNorth", Vector3.new(120, 42, 16), Vector3.new(0, 21, -92), Color3.fromRGB(122, 134, 148), Enum.Material.Brick)
  part(f, "HorizonSouth", Vector3.new(120, 42, 16), Vector3.new(0, 21, 92), Color3.fromRGB(122, 134, 148), Enum.Material.Brick)
  print("[AI-Vid V5.3] Loaded horizon-enclosed set: street_day")
end
return _G.AIVidSets.street_day
