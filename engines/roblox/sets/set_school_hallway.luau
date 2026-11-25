-- V6 set: school_hallway -- indoor corridor (x -8.5..8.5, z -42..42), checker floor tiles, two locker rows, hall doors,
-- a wall bench (sit), ceiling light panels. Built at the local origin; the engine offsets it for multi-set stories.
-- Walk lane: x -6.8..6.8 (lockers' front faces). Verify: python pipeline/check_set_paths.py --set school_hallway
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
  return p
end

_G.AIVidSets.school_hallway = function()
  local old = Workspace:FindFirstChild("Set_SchoolHallway")
  if old then old:Destroy() end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_SchoolHallway"
  local wall, trim, navy = Color3.fromRGB(228, 222, 206), Color3.fromRGB(70, 92, 120), Color3.fromRGB(30, 47, 66)
  local wood, glass = Color3.fromRGB(151, 105, 67), Color3.fromRGB(150, 200, 220)

  part(f, "Floor", Vector3.new(18, 1, 86), Vector3.new(0, -0.3, 0), Color3.fromRGB(214, 212, 204))
  for i = 0, 3 do
    for k = 0, 20 do
      if (i + k) % 2 == 0 then
        local t = part(f, "FloorTile", Vector3.new(4, 0.04, 4), Vector3.new(-6 + i * 4, 0.22, -40 + k * 4), Color3.fromRGB(140, 152, 166))
        t.CanCollide = false
      end
    end
  end
  for _, s in ipairs({ -1, 1 }) do
    part(f, "Wall", Vector3.new(1, 13, 86), Vector3.new(s * 9, 6.3, 0), wall, Enum.Material.Concrete)
    part(f, "WallStripe", Vector3.new(0.1, 0.5, 86), Vector3.new(s * 8.45, 8.2, 0), trim).CanCollide = false
  end
  part(f, "EndWall", Vector3.new(18, 13, 1), Vector3.new(0, 6.3, -43), wall, Enum.Material.Concrete)
  part(f, "EndWall", Vector3.new(18, 13, 1), Vector3.new(0, 6.3, 43), wall, Enum.Material.Concrete)
  part(f, "EndWindow", Vector3.new(10, 5, 0.2), Vector3.new(0, 6.5, -42.4), glass, Enum.Material.Glass).Transparency = 0.3
  part(f, "Ceiling", Vector3.new(18, 1, 86), Vector3.new(0, 12.8, 0), Color3.fromRGB(238, 238, 232))
  for z = -36, 36, 12 do
    local panel = part(f, "CeilingLight", Vector3.new(3, 0.2, 6), Vector3.new(0, 12.2, z), Color3.fromRGB(255, 250, 235), Enum.Material.Neon)
    panel.CanCollide = false
    local l = Instance.new("SurfaceLight", panel); l.Face = Enum.NormalId.Bottom; l.Range = 16; l.Brightness = 1.2; l.Angle = 120
  end

  -- locker rows (each locker is a Model so a `kick` can rattle it); gaps for the doors and the bench
  local colors = { Color3.fromRGB(52, 98, 160), Color3.fromRGB(46, 88, 148) }
  local function gap(s, z)
    if s < 0 then return math.abs(z - 14) < 3.4 or (z > -0.6 and z < 6.6) end
    return math.abs(z + 14) < 3.4
  end
  for _, s in ipairs({ -1, 1 }) do
    local n = 0
    for z = -38, 38, 2.1 do
      if not gap(s, z) then
        n += 1
        local m = Instance.new("Model"); m.Name = "Locker"
        part(m, "LockerBody", Vector3.new(1.6, 7, 1.95), Vector3.new(s * 7.6, 3.7, z), colors[n % 2 + 1], Enum.Material.Metal)
        part(m, "LockerVent", Vector3.new(0.05, 1.1, 1.3), Vector3.new(s * 6.78, 6.2, z), Color3.fromRGB(28, 40, 60)).CanCollide = false
        part(m, "LockerHandle", Vector3.new(0.12, 0.6, 0.18), Vector3.new(s * 6.74, 3.8, z + 0.6), Color3.fromRGB(200, 200, 205), Enum.Material.Metal).CanCollide = false
        m.Parent = f
      end
    end
  end
  for _, d in ipairs({ { x = -8.4, z = 14 }, { x = 8.4, z = -14 } }) do
    part(f, "HallDoor", Vector3.new(0.3, 8, 4.4), Vector3.new(d.x, 4.2, d.z), navy, Enum.Material.WoodPlanks)
    part(f, "DoorWindow", Vector3.new(0.34, 2.2, 1.4), Vector3.new(d.x, 5.8, d.z - 0.9), glass, Enum.Material.Glass).CanCollide = false
    part(f, "DoorFrame", Vector3.new(0.4, 0.4, 5.2), Vector3.new(d.x, 8.4, d.z), trim).CanCollide = false
  end
  -- wall bench in the left gap (seat faces +x into the hall)
  part(f, "BenchSeat", Vector3.new(2, 0.3, 5.4), Vector3.new(-7.4, 1.6, 3), wood, Enum.Material.WoodPlanks)
  part(f, "BenchBack", Vector3.new(0.3, 1.6, 5.4), Vector3.new(-8.35, 2.5, 3), wood, Enum.Material.WoodPlanks)
  for _, z in ipairs({ 1, 5 }) do
    part(f, "BenchLeg", Vector3.new(1.6, 1.4, 0.2), Vector3.new(-7.4, 0.8, z), navy, Enum.Material.Metal)
  end
  print("[AI-Vid V6] Loaded set: school_hallway")
end
return _G.AIVidSets.school_hallway
