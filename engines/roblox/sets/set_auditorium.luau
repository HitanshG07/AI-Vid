-- V6 set: auditorium -- hall x -32..32, z -32..32. Raised wooden stage (top y 2.8, z -32..-14) with two debate
-- podiums + mics, side ramps (x +-19, walkable by PathfindingService), stage lights, audience seat rows (z 1..23.5)
-- around a 14-stud centre aisle. Verify: python pipeline/check_set_paths.py --set auditorium
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
  return p
end

_G.AIVidSets.auditorium = function()
  local old = Workspace:FindFirstChild("Set_Auditorium")
  if old then old:Destroy() end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_Auditorium"
  -- V6 (owner 2026-11-25): warm, readable hall -- the old dark walls + unlit ceiling went near-black on camera
  local wall, wood, red = Color3.fromRGB(176, 142, 118), Color3.fromRGB(150, 104, 64), Color3.fromRGB(150, 34, 50)
  local navy = Color3.fromRGB(34, 52, 92)
  local gold, dark = Color3.fromRGB(216, 173, 93), Color3.fromRGB(34, 36, 42)

  part(f, "Floor", Vector3.new(66, 1, 66), Vector3.new(0, -0.3, 0), Color3.fromRGB(110, 40, 46), Enum.Material.Fabric)
  part(f, "Wall", Vector3.new(66, 19, 1), Vector3.new(0, 9.3, -33), wall, Enum.Material.Concrete)
  part(f, "Wall", Vector3.new(66, 19, 1), Vector3.new(0, 9.3, 33), wall, Enum.Material.Concrete)
  part(f, "Wall", Vector3.new(1, 19, 66), Vector3.new(-33, 9.3, 0), wall, Enum.Material.Concrete)
  part(f, "Wall", Vector3.new(1, 19, 66), Vector3.new(33, 9.3, 0), wall, Enum.Material.Concrete)
  part(f, "Ceiling", Vector3.new(66, 1, 66), Vector3.new(0, 18.8, 0), Color3.fromRGB(118, 104, 100))

  -- stage
  part(f, "StageDeck", Vector3.new(48, 2.6, 18), Vector3.new(0, 1.5, -23), wood, Enum.Material.WoodPlanks)
  part(f, "StageTrim", Vector3.new(48.2, 0.2, 0.2), Vector3.new(0, 2.7, -13.95), gold, Enum.Material.Metal).CanCollide = false
  part(f, "Backdrop", Vector3.new(44, 13, 0.4), Vector3.new(0, 9.3, -31.6), red, Enum.Material.Fabric)
  local sign = part(f, "DebateBanner", Vector3.new(22, 2.4, 0.2), Vector3.new(0, 13.2, -31.3), Color3.fromRGB(30, 47, 66), Enum.Material.Fabric)
  local g = Instance.new("SurfaceGui", sign); g.Face = Enum.NormalId.Back
  g.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud; g.PixelsPerStud = 40
  local l = Instance.new("TextLabel", g); l.Size = UDim2.fromScale(1, 1); l.BackgroundTransparency = 1
  l.Text = "CHAMPIONSHIP DEBATE"; l.TextScaled = true; l.Font = Enum.Font.GothamBlack; l.TextColor3 = gold
  -- side ramps from the stage front (top 2.8 at z -14) down to the floor (0.2 at z -7)
  local rise, run = 2.6, 7
  local ang = math.atan(rise / run)
  for _, x in ipairs({ -19, 19 }) do
    -- 1 stud thick / 8 wide: thinner ramps fall between PathfindingService's 4-stud voxels and read as unwalkable
    local r = part(f, "StageRamp", Vector3.new(8, 1, math.sqrt(rise * rise + run * run)), Vector3.zero, wood, Enum.Material.WoodPlanks)
    r.CFrame = CFrame.new(x, 1.5 - 0.5 / math.cos(ang), -10.5) * CFrame.Angles(ang, 0, 0)
  end
  -- debate podiums (speaker stands behind at z -19.5 facing the audience)
  for _, x in ipairs({ -7, 7 }) do
    local m = Instance.new("Model"); m.Name = "Podium"
    part(m, "PodiumBody", Vector3.new(2.6, 3.6, 1.6), Vector3.new(x, 4.6, -17), wood, Enum.Material.WoodPlanks)
    part(m, "PodiumTop", Vector3.new(3, 0.25, 2), Vector3.new(x, 6.5, -17.1), Color3.fromRGB(120, 80, 48), Enum.Material.WoodPlanks)
    part(m, "PodiumCrest", Vector3.new(1.2, 1.2, 0.05), Vector3.new(x, 5, -16.17), gold, Enum.Material.Metal).CanCollide = false
    local stand = part(m, "MicStand", Vector3.new(0.12, 1.4, 0.12), Vector3.new(x, 7.3, -16.6), dark, Enum.Material.Metal)
    stand.CanCollide = false
    local mic = part(m, "Mic", Vector3.new(0.35, 0.35, 0.35), Vector3.new(x, 8.05, -16.75), dark, Enum.Material.Metal)
    mic.Shape = Enum.PartType.Ball; mic.CanCollide = false
    for _, c in ipairs(m:GetChildren()) do c.CanCollide = false end  -- speakers stand right behind; keeps the spot reachable for pathfinding
    m.Parent = f
  end
  -- wall panels: navy curtains on the side walls between burgundy pilasters, gold sconces (PointLights)
  for _, sx in ipairs({ -1, 1 }) do
    for z = -24, 24, 12 do
      part(f, "WallCurtain", Vector3.new(0.4, 12, 8), Vector3.new(sx * 32.3, 8, z), navy, Enum.Material.Fabric).CanCollide = false
      part(f, "WallPilaster", Vector3.new(0.6, 15, 1.6), Vector3.new(sx * 32.2, 7.7, z + 6), red, Enum.Material.Fabric).CanCollide = false
      local sconce = part(f, "Sconce", Vector3.new(0.5, 0.8, 0.8), Vector3.new(sx * 31.8, 11, z + 6), Color3.fromRGB(255, 214, 150), Enum.Material.Neon)
      sconce.CanCollide = false
      local pl = Instance.new("PointLight", sconce); pl.Range = 18; pl.Brightness = 0.7; pl.Color = Color3.fromRGB(255, 214, 172)
    end
  end
  for _, sx in ipairs({ -1, 1 }) do  -- navy stage wings framing the backdrop
    part(f, "StageWing", Vector3.new(3, 13, 0.6), Vector3.new(sx * 23.5, 9.3, -30.8), navy, Enum.Material.Fabric).CanCollide = false
  end
  -- house lights: ceiling panels with SurfaceLights over the audience and the stage
  for _, x in ipairs({ -18, 0, 18 }) do
    for _, z in ipairs({ -22, -8, 6, 20 }) do
      local panel = part(f, "CeilingLight", Vector3.new(5, 0.2, 5), Vector3.new(x, 18.2, z), Color3.fromRGB(255, 244, 222), Enum.Material.Neon)
      panel.CanCollide = false
      local l = Instance.new("SurfaceLight", panel); l.Face = Enum.NormalId.Bottom; l.Range = 26; l.Brightness = 0.8; l.Angle = 120
      l.Color = Color3.fromRGB(255, 232, 206)
    end
  end
  -- (no extra stage-wash lights: stacked on the spots + ceiling panels they blew actors out to white)
  -- stage lights
  local truss = part(f, "LightTruss", Vector3.new(40, 0.5, 0.5), Vector3.new(0, 16, -12), dark, Enum.Material.Metal)
  truss.CanCollide = false
  for _, x in ipairs({ -14, 0, 14 }) do  -- 3 soft spots (not one directly over each podium + the ceiling panels)
    local h = part(f, "StageLight", Vector3.new(0.9, 0.9, 1.2), Vector3.new(x, 15.4, -12), dark, Enum.Material.Metal)
    h.CanCollide = false
    local s = Instance.new("SpotLight", h); s.Face = Enum.NormalId.Bottom; s.Range = 30; s.Angle = 55; s.Brightness = 0.6
    s.Color = Color3.fromRGB(255, 232, 196)
  end
  -- audience rows (seats face the stage), 14-stud centre aisle
  for _, z in ipairs({ 1, 5.5, 10, 14.5, 19, 23.5 }) do
    for _, s in ipairs({ -1, 1 }) do
      for i = 0, 5 do
        local x = s * (8.3 + i * 2.6)
        part(f, "AudSeat", Vector3.new(1.9, 0.45, 1.6), Vector3.new(x, 1.45, z), red, Enum.Material.Fabric)
        part(f, "AudSeatBack", Vector3.new(1.9, 2.1, 0.3), Vector3.new(x, 2.6, z + 0.9), red, Enum.Material.Fabric)
        part(f, "AudSeatBase", Vector3.new(1.2, 1.1, 1.2), Vector3.new(x, 0.75, z), dark, Enum.Material.Metal)
      end
    end
  end
  print("[AI-Vid V6] Loaded set: auditorium")
end
return _G.AIVidSets.auditorium
