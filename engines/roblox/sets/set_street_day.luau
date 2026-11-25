-- Reusable Horizon-Enclosed Roblox Set Preset (AI-Vid V5.4 — Detailed Roblox Street)
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  return p
end

_G.AIVidSets.street_day = function()
  for _, c in ipairs(Workspace:GetChildren()) do
    if c.Name == "Set_StreetDay" then c:Destroy() end
  end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_StreetDay"
  local stone = Color3.fromRGB(220, 212, 194)
  local glass = Color3.fromRGB(98, 168, 200)
  local darkMetal = Color3.fromRGB(38, 42, 50)

  -- Road, curbs, sidewalks, lane dashes, crosswalk
  part(f, "Road", Vector3.new(28, 1, 180), Vector3.new(0, -0.3, 0), Color3.fromRGB(54, 58, 66), Enum.Material.Asphalt)
  part(f, "SidewalkL", Vector3.new(16, 1.3, 180), Vector3.new(-22, -0.15, 0), Color3.fromRGB(185, 188, 192), Enum.Material.Concrete)
  part(f, "SidewalkR", Vector3.new(16, 1.3, 180), Vector3.new(22, -0.15, 0), Color3.fromRGB(185, 188, 192), Enum.Material.Concrete)
  for z = -75, 75, 12 do
    part(f, "Dash_"..z, Vector3.new(0.45, 0.04, 5), Vector3.new(0, 0.22, z), Color3.fromRGB(240, 200, 68), Enum.Material.SmoothPlastic)
  end
  for x = -11, 11, 3.2 do
    part(f, "Crosswalk_"..x, Vector3.new(1.8, 0.04, 6), Vector3.new(x, 0.22, 12), Color3.fromRGB(238, 238, 238), Enum.Material.SmoothPlastic)
  end

  -- Detailed Roblox storefronts with windows, awnings, doors, lamps, and benches
  local colors = { Color3.fromRGB(178, 92, 74), Color3.fromRGB(108, 134, 162), Color3.fromRGB(196, 165, 118), Color3.fromRGB(130, 108, 96) }
  local awnings = { Color3.fromRGB(186, 46, 54), Color3.fromRGB(34, 112, 86), Color3.fromRGB(40, 82, 148), Color3.fromRGB(204, 136, 36) }
  for i = -3, 3 do
    local z = i * 22
    for _, side in ipairs({ -1, 1 }) do
      local bx = side * 40
      local faceX = side * 29.8
      local h = 26 + ((i + side) % 2) * 8
      part(f, "Bldg_"..side.."_"..i, Vector3.new(20, h, 20), Vector3.new(bx, h / 2, z), colors[((i + 4 + (side > 0 and 2 or 0)) % 4) + 1], Enum.Material.Brick)
      part(f, "Cornice_"..side.."_"..i, Vector3.new(21, 1.2, 21), Vector3.new(bx, h + 0.4, z), stone, Enum.Material.Concrete)
      -- Storefront door + glass + awning
      part(f, "Door_"..side.."_"..i, Vector3.new(0.4, 7.5, 4.2), Vector3.new(faceX, 4.0, z), Color3.fromRGB(48, 56, 72), Enum.Material.WoodPlanks)
      part(f, "Awning_"..side.."_"..i, Vector3.new(3.2, 0.6, 14), Vector3.new(faceX - side * 1.4, 8.6, z), awnings[((i + 4) % 4) + 1], Enum.Material.Fabric)
      for _, wz in ipairs({ z - 5.5, z + 5.5 }) do
        part(f, "WinLow", Vector3.new(0.3, 4.5, 4.2), Vector3.new(faceX, 4.6, wz), glass, Enum.Material.Glass).Reflectance = 0.2
        part(f, "WinTop", Vector3.new(0.3, 4.2, 4.2), Vector3.new(faceX, 15.5, wz), glass, Enum.Material.Glass).Reflectance = 0.2
      end
      -- Streetlamp with warm globe
      part(f, "LampPost_"..side.."_"..i, Vector3.new(0.55, 13, 0.55), Vector3.new(side * 15.2, 6.5, z - 6), darkMetal, Enum.Material.Metal)
      local bulb = part(f, "LampGlobe", Vector3.new(1.4, 1.4, 1.4), Vector3.new(side * 14.4, 13.2, z - 6), Color3.fromRGB(255, 232, 180), Enum.Material.Neon)
      local pl = Instance.new("PointLight", bulb); pl.Brightness = 0.9; pl.Range = 22; pl.Color = Color3.fromRGB(255, 224, 170)
    end
  end

  -- Blocky Roblox parked bus/car silhouette & sidewalk benches
  part(f, "BusStopSign", Vector3.new(0.35, 8, 0.35), Vector3.new(15.5, 4.2, 6), darkMetal, Enum.Material.Metal)
  part(f, "BusStopBoard", Vector3.new(0.3, 2.2, 2.6), Vector3.new(15.5, 7.8, 6), Color3.fromRGB(36, 98, 196), Enum.Material.SmoothPlastic)
  part(f, "BenchSeat", Vector3.new(1.6, 0.25, 5.5), Vector3.new(19.5, 1.35, 6), Color3.fromRGB(130, 88, 56), Enum.Material.WoodPlanks)
  part(f, "BenchBack", Vector3.new(0.25, 1.2, 5.5), Vector3.new(20.2, 2.0, 6), Color3.fromRGB(130, 88, 56), Enum.Material.WoodPlanks)

  -- V6: reusable boxy StreetTruck (fx truck_pass drives it down the road along +Z). Built facing +Z around a
  -- ground-level pivot, parked out of sight behind HorizonNorth. CanCollide off so actor push-out ignores it.
  local truck = Instance.new("Model"); truck.Name = "StreetTruck"
  local white, red, black = Color3.fromRGB(236, 238, 240), Color3.fromRGB(196, 48, 44), Color3.fromRGB(30, 30, 34)
  local function tp(name, size, pos, color, mat)
    local p = part(truck, name, size, pos, color, mat); p.CanCollide = false; return p
  end
  tp("Cargo", Vector3.new(7.4, 7.6, 11), Vector3.new(0, 5.2, -3.2), white, Enum.Material.SmoothPlastic)
  tp("CargoStripe", Vector3.new(7.5, 1.0, 11.05), Vector3.new(0, 3.6, -3.2), red, Enum.Material.SmoothPlastic)
  tp("Cab", Vector3.new(7.0, 5.4, 4.6), Vector3.new(0, 4.1, 4.6), red, Enum.Material.SmoothPlastic)
  tp("Windshield", Vector3.new(6.0, 2.2, 0.2), Vector3.new(0, 5.4, 6.95), Color3.fromRGB(120, 170, 205), Enum.Material.Glass)
  tp("Grille", Vector3.new(5.0, 1.4, 0.2), Vector3.new(0, 2.6, 6.95), black, Enum.Material.Metal)
  tp("Bumper", Vector3.new(7.2, 0.7, 0.5), Vector3.new(0, 1.5, 7.1), Color3.fromRGB(150, 152, 158), Enum.Material.Metal)
  for _, hx in ipairs({ -2.7, 2.7 }) do
    tp("Headlight", Vector3.new(1.0, 0.7, 0.15), Vector3.new(hx, 2.6, 7.0), Color3.fromRGB(255, 244, 200), Enum.Material.Neon)
  end
  for _, wz in ipairs({ 4.6, -6.2 }) do
    for _, wx in ipairs({ -3.6, 3.6 }) do
      local w = tp("Wheel", Vector3.new(1.0, 2.8, 2.8), Vector3.new(wx, 1.4, wz), black, Enum.Material.SmoothPlastic)
      w.Shape = Enum.PartType.Cylinder
    end
  end
  truck.WorldPivot = CFrame.new(0, 0, 0)
  truck.Parent = f
  truck:PivotTo(CFrame.new(-7, 0, -112))   -- parked behind HorizonNorth (z -84..-100)

  -- Horizon skyline blockers
  part(f, "HorizonNorth", Vector3.new(130, 46, 16), Vector3.new(0, 23, -92), Color3.fromRGB(110, 124, 142), Enum.Material.Brick)
  part(f, "HorizonSouth", Vector3.new(130, 46, 16), Vector3.new(0, 23, 92), Color3.fromRGB(110, 124, 142), Enum.Material.Brick)
  print("[AI-Vid V5.4] Loaded detailed Roblox set: street_day")
end
_G.AIVidSets.street = _G.AIVidSets.street_day  -- V6 alias (same builder + spots)
return _G.AIVidSets.street_day
