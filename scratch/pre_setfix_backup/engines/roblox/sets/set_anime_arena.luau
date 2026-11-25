-- Reusable Horizon-Enclosed Roblox Set Preset (AI-Vid V5.3)
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  return p
end

_G.AIVidSets.anime_arena = function()
  local old = Workspace:FindFirstChild("Set_AnimeArena")
  if old then old:Destroy() end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_AnimeArena"
  part(f, "ArenaFloor", Vector3.new(96, 1, 96), Vector3.new(0, -0.5, 0), Color3.fromRGB(72, 76, 86), Enum.Material.Basalt)
  for i = 0, 7 do
    local a = i * (math.pi / 4)
    part(f, "Pillar_"..i, Vector3.new(6, 26, 6), Vector3.new(math.cos(a)*34, 13, math.sin(a)*34), Color3.fromRGB(94, 98, 108), Enum.Material.Slate)
  end
  part(f, "WallN", Vector3.new(100, 32, 6), Vector3.new(0, 16, -48), Color3.fromRGB(54, 58, 68), Enum.Material.Slate)
  part(f, "WallS", Vector3.new(100, 32, 6), Vector3.new(0, 16, 48), Color3.fromRGB(54, 58, 68), Enum.Material.Slate)
  part(f, "WallE", Vector3.new(6, 32, 100), Vector3.new(48, 16, 0), Color3.fromRGB(54, 58, 68), Enum.Material.Slate)
  part(f, "WallW", Vector3.new(6, 32, 100), Vector3.new(-48, 16, 0), Color3.fromRGB(54, 58, 68), Enum.Material.Slate)
  print("[AI-Vid V5.3] Loaded horizon-enclosed set: anime_arena")
end
return _G.AIVidSets.anime_arena
