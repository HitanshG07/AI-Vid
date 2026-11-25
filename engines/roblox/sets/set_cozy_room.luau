-- Reusable Horizon-Enclosed Roblox Set Preset (AI-Vid V5.4 — Detailed Roblox Bedroom/Study)
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  return p
end

_G.AIVidSets.cozy_room = function()
  for _, c in ipairs(Workspace:GetChildren()) do
    if c.Name == "Set_CozyRoom" then c:Destroy() end
  end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_CozyRoom"
  local wood = Color3.fromRGB(122, 84, 54)
  local trim = Color3.fromRGB(238, 232, 222)

  -- Floor, rug, ceiling, walls, baseboards
  part(f, "Floor", Vector3.new(34, 1, 34), Vector3.new(0, -0.3, 0), Color3.fromRGB(154, 114, 78), Enum.Material.WoodPlanks)
  part(f, "Rug", Vector3.new(12, 0.08, 9), Vector3.new(0, 0.24, 1), Color3.fromRGB(72, 102, 138), Enum.Material.Fabric)
  part(f, "Ceiling", Vector3.new(34, 1, 34), Vector3.new(0, 14.5, 0), trim, Enum.Material.SmoothPlastic)
  part(f, "WallN", Vector3.new(34, 15, 1.2), Vector3.new(0, 7.5, -16), Color3.fromRGB(220, 212, 198), Enum.Material.Concrete)
  part(f, "WallS", Vector3.new(34, 15, 1.2), Vector3.new(0, 7.5, 16), Color3.fromRGB(220, 212, 198), Enum.Material.Concrete)
  part(f, "WallE", Vector3.new(1.2, 15, 34), Vector3.new(16, 7.5, 0), Color3.fromRGB(204, 196, 184), Enum.Material.Brick)
  part(f, "WallW", Vector3.new(1.2, 15, 34), Vector3.new(-16, 7.5, 0), Color3.fromRGB(204, 196, 184), Enum.Material.Brick)

  -- Window with sill + sky pane
  part(f, "WinFrame", Vector3.new(8.6, 6.2, 0.4), Vector3.new(2, 7.8, -15.3), trim, Enum.Material.Wood)
  part(f, "WinGlass", Vector3.new(7.6, 5.2, 0.2), Vector3.new(2, 7.8, -15.2), Color3.fromRGB(122, 182, 224), Enum.Material.Glass).Reflectance = 0.2

  -- Desk, monitor, chair, bed, bookshelf, wall posters
  part(f, "DeskTop", Vector3.new(7.5, 0.35, 3.4), Vector3.new(-9, 3.0, -13), wood, Enum.Material.WoodPlanks)
  part(f, "DeskLegL", Vector3.new(0.4, 2.8, 3.0), Vector3.new(-12.4, 1.5, -13), wood, Enum.Material.Wood)
  part(f, "DeskLegR", Vector3.new(0.4, 2.8, 3.0), Vector3.new(-5.6, 1.5, -13), wood, Enum.Material.Wood)
  part(f, "Monitor", Vector3.new(3.2, 2.0, 0.2), Vector3.new(-9, 4.4, -13.8), Color3.fromRGB(30, 34, 42), Enum.Material.SmoothPlastic)
  part(f, "Screen", Vector3.new(2.9, 1.7, 0.08), Vector3.new(-9, 4.4, -13.68), Color3.fromRGB(70, 150, 235), Enum.Material.Neon)
  -- V6: keyboard + mouse resting on DeskTop (top surface y = 3.175), in front of the monitor
  part(f, "MonitorStand", Vector3.new(0.9, 0.5, 0.6), Vector3.new(-9, 3.42, -13.75), Color3.fromRGB(30, 34, 42), Enum.Material.SmoothPlastic)
  part(f, "Keyboard", Vector3.new(2.6, 0.12, 0.85), Vector3.new(-9, 3.235, -12.45), Color3.fromRGB(38, 40, 46), Enum.Material.SmoothPlastic)
  part(f, "KeyboardKeys", Vector3.new(2.4, 0.05, 0.65), Vector3.new(-9, 3.32, -12.45), Color3.fromRGB(210, 212, 218), Enum.Material.SmoothPlastic)
  part(f, "MousePad", Vector3.new(1.1, 0.03, 0.9), Vector3.new(-7.0, 3.19, -12.4), Color3.fromRGB(46, 58, 92), Enum.Material.Fabric)
  part(f, "Mouse", Vector3.new(0.34, 0.14, 0.52), Vector3.new(-7.0, 3.275, -12.4), Color3.fromRGB(38, 40, 46), Enum.Material.SmoothPlastic)

  part(f, "BedFrame", Vector3.new(6.2, 1.3, 9.5), Vector3.new(11, 0.85, -9.5), wood, Enum.Material.Wood)
  part(f, "Mattress", Vector3.new(5.8, 0.8, 9.0), Vector3.new(11, 1.85, -9.5), Color3.fromRGB(190, 62, 68), Enum.Material.Fabric)
  part(f, "Pillow", Vector3.new(4.2, 0.6, 2.0), Vector3.new(11, 2.5, -12.6), trim, Enum.Material.Fabric)

  part(f, "Bookshelf", Vector3.new(1.8, 8.5, 6.0), Vector3.new(-14.5, 4.45, 2), wood, Enum.Material.WoodPlanks)
  part(f, "Poster1", Vector3.new(0.1, 3.6, 2.6), Vector3.new(-15.3, 8.0, -6), Color3.fromRGB(235, 168, 48), Enum.Material.SmoothPlastic)
  part(f, "Door", Vector3.new(0.35, 8.2, 4.4), Vector3.new(15.3, 4.3, 7), Color3.fromRGB(96, 68, 46), Enum.Material.WoodPlanks)

  for _, lx in ipairs({ -6, 6 }) do
    local lamp = part(f, "CeilingLamp", Vector3.new(3.6, 0.35, 3.6), Vector3.new(lx, 13.8, 0), Color3.fromRGB(255, 226, 186), Enum.Material.Neon)
    local l = Instance.new("PointLight", lamp); l.Brightness = 1.6; l.Range = 28; l.Color = Color3.fromRGB(255, 224, 184)
  end
  print("[AI-Vid V5.4] Loaded detailed Roblox set: cozy_room")
end
_G.AIVidSets.living_room = _G.AIVidSets.cozy_room  -- V6 alias (same builder + spots)
return _G.AIVidSets.cozy_room
