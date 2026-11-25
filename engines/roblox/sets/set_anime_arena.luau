-- Reusable Horizon-Enclosed Roblox Set Preset (AI-Vid V5.4 — Detailed Roblox Obby / Battle Arena)
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  return p
end

_G.AIVidSets.anime_arena = function()
  for _, c in ipairs(Workspace:GetChildren()) do
    if c.Name == "Set_AnimeArena" then c:Destroy() end
  end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_AnimeArena"
  part(f, "ArenaFloor", Vector3.new(96, 1, 96), Vector3.new(0, -0.3, 0), Color3.fromRGB(68, 72, 82), Enum.Material.Basalt)
  -- Center ring + glowing accent lanes (reads cleanly on Roblox camera)
  part(f, "CenterPad", Vector3.new(26, 0.12, 26), Vector3.new(0, 0.24, 0), Color3.fromRGB(92, 98, 112), Enum.Material.Cobblestone)
  part(f, "TrimN", Vector3.new(26, 0.14, 0.6), Vector3.new(0, 0.26, -13), Color3.fromRGB(56, 189, 248), Enum.Material.Neon)
  part(f, "TrimS", Vector3.new(26, 0.14, 0.6), Vector3.new(0, 0.26, 13), Color3.fromRGB(56, 189, 248), Enum.Material.Neon)

  -- Sculpted pillars with capitals + torch braziers
  for i = 0, 7 do
    local a = i * (math.pi / 4)
    local px, pz = math.cos(a) * 34, math.sin(a) * 34
    part(f, "PillarBase_"..i, Vector3.new(7.5, 2.2, 7.5), Vector3.new(px, 1.3, pz), Color3.fromRGB(76, 80, 92), Enum.Material.Concrete)
    part(f, "Pillar_"..i, Vector3.new(5.5, 24, 5.5), Vector3.new(px, 13.5, pz), Color3.fromRGB(96, 100, 112), Enum.Material.Slate)
    part(f, "PillarCap_"..i, Vector3.new(7.5, 2.0, 7.5), Vector3.new(px, 26.2, pz), Color3.fromRGB(76, 80, 92), Enum.Material.Concrete)
    local flame = part(f, "Brazier_"..i, Vector3.new(2.2, 2.2, 2.2), Vector3.new(px, 28.0, pz), Color3.fromRGB(255, 152, 46), Enum.Material.Neon)
    local pl = Instance.new("PointLight", flame); pl.Brightness = 1.2; pl.Range = 28; pl.Color = Color3.fromRGB(255, 166, 76)
  end

  -- Stadium walls + banners
  part(f, "WallN", Vector3.new(100, 34, 6), Vector3.new(0, 17, -48), Color3.fromRGB(52, 56, 66), Enum.Material.Slate)
  part(f, "WallS", Vector3.new(100, 34, 6), Vector3.new(0, 17, 48), Color3.fromRGB(52, 56, 66), Enum.Material.Slate)
  part(f, "WallE", Vector3.new(6, 34, 100), Vector3.new(48, 17, 0), Color3.fromRGB(52, 56, 66), Enum.Material.Slate)
  part(f, "WallW", Vector3.new(6, 34, 100), Vector3.new(-48, 17, 0), Color3.fromRGB(52, 56, 66), Enum.Material.Slate)
  for _, bx in ipairs({ -24, 0, 24 }) do
    part(f, "BannerN_"..bx, Vector3.new(5, 14, 0.4), Vector3.new(bx, 18, -44.6), Color3.fromRGB(168, 42, 54), Enum.Material.Fabric)
  end
  print("[AI-Vid V5.4] Loaded detailed Roblox set: anime_arena")
end
return _G.AIVidSets.anime_arena
