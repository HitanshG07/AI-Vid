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
  part(f, "Courtyard", Vector3.new(90, 1, 90), Vector3.new(0, -0.3, 0), Color3.fromRGB(194, 186, 170), Enum.Material.Cobblestone)
  part(f, "SchoolMain", Vector3.new(64, 24, 18), Vector3.new(0, 12, -32), Color3.fromRGB(174, 84, 68), Enum.Material.Brick)
  part(f, "WingL", Vector3.new(18, 22, 68), Vector3.new(-42, 11, 0), Color3.fromRGB(165, 80, 65), Enum.Material.Brick)
  part(f, "WingR", Vector3.new(18, 22, 68), Vector3.new(42, 11, 0), Color3.fromRGB(165, 80, 65), Enum.Material.Brick)
  part(f, "BackFence", Vector3.new(90, 12, 3), Vector3.new(0, 6, 44), Color3.fromRGB(78, 92, 74), Enum.Material.Grass)
  local stage = Instance.new("Model", f)
  stage.Name = "SchoolShowStage"
  local wood = Color3.fromRGB(151, 105, 67)
  local navy = Color3.fromRGB(30, 47, 66)
  local gold = Color3.fromRGB(216, 173, 93)
  local burgundy = Color3.fromRGB(114, 32, 56)
  local stone = Color3.fromRGB(222, 207, 176)
  local glass = Color3.fromRGB(96, 164, 192)
  part(f, "SchoolCornice", Vector3.new(65, 1.2, 1.2), Vector3.new(0, 23.6, -22.7), stone, Enum.Material.Concrete)
  part(f, "SchoolBeltCourse", Vector3.new(64, 0.65, 0.5), Vector3.new(0, 11.2, -22.9), stone, Enum.Material.Concrete)
  for _, x in ipairs({-26, -18, -10, -2, 6, 14, 22, 28}) do
    for _, level in ipairs({6, 16.7}) do
      if level > 10 or x < -19 or x > -7 then
        part(f, "WindowFrame", Vector3.new(5.1, 5.2, 0.4), Vector3.new(x, level, -22.75), stone, Enum.Material.Concrete)
        for _, offset in ipairs({-1.15, 1.15}) do
          part(f, "WindowPane", Vector3.new(2.16, 4.35, 0.19), Vector3.new(x + offset, level, -22.45), glass, Enum.Material.Glass).Reflectance = 0.15
        end
        part(f, "WindowSill", Vector3.new(5.35, 0.28, 0.7), Vector3.new(x, level - 2.45, -22.35), stone, Enum.Material.Concrete)
      end
    end
  end
  part(f, "EntryFrame", Vector3.new(10.7, 9.4, 0.6), Vector3.new(-14, 4.9, -22.55), stone, Enum.Material.Concrete)
  for _, x in ipairs({-16.28, -11.72}) do
    part(f, "EntryDoor", Vector3.new(4.35, 7.4, 0.32), Vector3.new(x, 3.93, -22.08), navy, Enum.Material.WoodPlanks)
    part(f, "DoorGlass", Vector3.new(3.65, 3.5, 0.1), Vector3.new(x, 5, -21.87), glass, Enum.Material.Glass)
    part(f, "DoorPull", Vector3.new(0.85, 0.12, 0.18), Vector3.new(x, 3.05, -21.78), gold, Enum.Material.Metal)
  end
  part(f, "EntryCanopy", Vector3.new(13, 0.6, 3.3), Vector3.new(-14, 9.3, -21.35), navy, Enum.Material.Concrete)
  local entrySign = part(f, "SchoolSign", Vector3.new(12.5, 1.65, 0.3), Vector3.new(-14, 10.3, -19.55), navy, Enum.Material.WoodPlanks)
  local entryGui = Instance.new("SurfaceGui", entrySign)
  entryGui.Face = Enum.NormalId.Back
  entryGui.CanvasSize = Vector2.new(820, 108)
  local entryLabel = Instance.new("TextLabel", entryGui)
  entryLabel.Size = UDim2.fromScale(1, 1)
  entryLabel.BackgroundTransparency = 1
  entryLabel.Text = "MAPLE GROVE SCHOOL"
  entryLabel.Font = Enum.Font.GothamBold
  entryLabel.TextSize = 68
  entryLabel.TextColor3 = stone
  part(f, "EntryWalk", Vector3.new(11, 0.06, 14), Vector3.new(-14, 0.22, -15), stone, Enum.Material.Concrete)

  local courtX = -22
  local courtZ = 9
  part(f, "PlayCourt", Vector3.new(20, 0.12, 22), Vector3.new(courtX, 0.24, courtZ), Color3.fromRGB(73, 112, 121), Enum.Material.Concrete)
  for _, x in ipairs({-31, -13}) do
    part(f, "CourtSideline", Vector3.new(0.15, 0.015, 20), Vector3.new(x, 0.31, courtZ), stone, Enum.Material.Concrete)
  end
  for _, z in ipairs({-1, 9, 19}) do
    part(f, "CourtLine", Vector3.new(18, 0.015, 0.15), Vector3.new(courtX, 0.31, z), stone, Enum.Material.Concrete)
  end
  part(f, "BasketPost", Vector3.new(0.3, 7, 0.3), Vector3.new(courtX, 3.8, -1.6), navy, Enum.Material.Metal)
  part(f, "Backboard", Vector3.new(3.8, 2.5, 0.18), Vector3.new(courtX, 6.9, -1.33), stone, Enum.Material.Concrete)
  for segment = 0, 11 do
    local angle = segment * math.pi / 6
    local rim = part(f, "BasketRim", Vector3.new(0.33, 0.09, 0.09), Vector3.new(courtX + 0.61 * math.cos(angle), 6.15, -0.57 + 0.61 * math.sin(angle)), Color3.fromRGB(224, 94, 38), Enum.Material.Metal)
    rim.Orientation = Vector3.new(0, -math.deg(angle) - 90, 0)
  end
  for _, x in ipairs({-26, -3}) do
    part(f, "Planter", Vector3.new(7, 0.7, 2.4), Vector3.new(x, 0.55, -10.5), stone, Enum.Material.Concrete)
    part(f, "PlanterGreenery", Vector3.new(6.5, 0.55, 1.95), Vector3.new(x, 1, -10.5), Color3.fromRGB(75, 120, 63), Enum.Material.Grass)
    part(f, "BenchSeat", Vector3.new(5, 0.22, 1.5), Vector3.new(x, 1.15, -7.8), wood, Enum.Material.WoodPlanks)
    part(f, "BenchBack", Vector3.new(5, 0.7, 0.2), Vector3.new(x, 1.65, -8.42), wood, Enum.Material.WoodPlanks)
    for _, offset in ipairs({-1.8, 1.8}) do
      part(f, "BenchLeg", Vector3.new(0.17, 0.85, 1.15), Vector3.new(x + offset, 0.65, -7.8), navy, Enum.Material.Metal)
    end
  end

  part(stage, "Riser", Vector3.new(23, 1.02, 10.6), Vector3.new(14, 0.71, -6.3), navy, Enum.Material.WoodPlanks)
  part(stage, "Deck", Vector3.new(23.2, 0.18, 10.7), Vector3.new(14, 1.31, -6.3), wood, Enum.Material.WoodPlanks)
  part(stage, "UpperStep", Vector3.new(5, 0.8, 0.9), Vector3.new(14, 0.6, -0.52), wood, Enum.Material.WoodPlanks)
  part(stage, "LowerStep", Vector3.new(5, 0.4, 0.9), Vector3.new(14, 0.4, 0.35), wood, Enum.Material.WoodPlanks)
  part(stage, "FrontTrim", Vector3.new(23.2, 0.12, 0.12), Vector3.new(14, 1.26, -0.89), gold, Enum.Material.WoodPlanks)
  part(stage, "Backdrop", Vector3.new(22.5, 8.2, 0.35), Vector3.new(14, 5.5, -11.36), navy, Enum.Material.Fabric)
  part(stage, "Valance", Vector3.new(23.2, 1.5, 0.6), Vector3.new(14, 9, -10.4), burgundy, Enum.Material.Fabric)
  part(stage, "ValanceTrim", Vector3.new(23.2, 0.12, 0.65), Vector3.new(14, 8.28, -10.4), gold, Enum.Material.WoodPlanks)
  for _, center in ipairs({4, 24}) do
    part(stage, "CurtainWing", Vector3.new(2.4, 7.1, 0.4), Vector3.new(center, 4.95, -10.4), burgundy, Enum.Material.Fabric)
    for fold = -2, 2 do
      part(stage, "CurtainFold", Vector3.new(0.26, 7.1, 0.5), Vector3.new(center + fold * 0.46, 4.95, -10.18), burgundy, Enum.Material.Fabric)
    end
  end
  for _, x in ipairs({3.7, 24.3}) do
    part(stage, "Speaker", Vector3.new(1, 1.6, 0.9), Vector3.new(x, 2.2, -1.75), navy, Enum.Material.WoodPlanks)
    part(stage, "SpeakerGrille", Vector3.new(0.81, 1.38, 0.04), Vector3.new(x, 2.2, -1.28), Color3.fromRGB(40, 43, 49), Enum.Material.Fabric)
  end
  for _, x in ipairs({7, 14, 21}) do
    for _, z in ipairs({-3.65, -8}) do
      local mark = part(stage, "PerformerMark", Vector3.new(0.86, 0.015, 0.16), Vector3.new(x, 1.405, z), gold, Enum.Material.Fabric)
      mark.CanCollide = false
    end
    part(stage, "LightingRail", Vector3.new(0.22, 0.24, 8.2), Vector3.new(x, 8.25, -7.3), navy, Enum.Material.WoodPlanks)
    local housing = part(stage, "StageLight", Vector3.new(0.85, 0.35, 0.65), Vector3.new(x, 8, -3.65), navy, Enum.Material.WoodPlanks)
    local light = Instance.new("SurfaceLight", housing)
    light.Face = Enum.NormalId.Bottom
    light.Color = Color3.fromRGB(255, 228, 187)
    light.Angle = 90
    light.Brightness = 1.8
    light.Range = 12
  end
  local sign = part(stage, "TryoutSign", Vector3.new(13, 1.45, 0.24), Vector3.new(14, 10.2, -9.9), navy, Enum.Material.WoodPlanks)
  local board = Instance.new("SurfaceGui", sign)
  board.Face = Enum.NormalId.Back
  board.CanvasSize = Vector2.new(1000, 200)
  local label = Instance.new("TextLabel", board)
  label.Size = UDim2.fromScale(1, 1)
  label.BackgroundTransparency = 1
  label.Text = "SCHOOL SHOW  •  TRYOUTS"
  label.TextWrapped = false
  label.Font = Enum.Font.GothamBlack
  label.TextColor3 = Color3.fromRGB(255, 240, 183)
  label.TextSize = 67
  local tableWood = Color3.fromRGB(119, 82, 58)
  part(f, "CoachTableTop", Vector3.new(4, 0.18, 1.5), Vector3.new(24, 1.62, 2.2), tableWood, Enum.Material.WoodPlanks)
  for _, x in ipairs({22.25, 25.75}) do
    for _, z in ipairs({1.65, 2.75}) do
      part(f, "CoachTableLeg", Vector3.new(0.16, 1.35, 0.16), Vector3.new(x, 0.875, z), tableWood, Enum.Material.WoodPlanks)
    end
  end
  for x = -30, 30, 15 do
    part(f, "Trunk_"..x, Vector3.new(2, 10, 2), Vector3.new(x, 5, 36), Color3.fromRGB(102, 72, 48), Enum.Material.Wood)
    part(f, "Canopy_"..x, Vector3.new(10, 9, 10), Vector3.new(x, 12, 36), Color3.fromRGB(64, 118, 62), Enum.Material.Grass)
  end
  print("[AI-Vid V5.3] Loaded horizon-enclosed set: school_yard")
end
return _G.AIVidSets.school_yard
