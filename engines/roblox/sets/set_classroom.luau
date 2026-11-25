-- V6 set: classroom -- room x -20..20, z -18..18: chalkboard wall (z -18), teacher desk, 3x3 student desks with chairs
-- (chairs face the board; `sit` uses ChairSeat), exam papers on every desk, windows, door. Aisles x = -6 / +6 are 8.6 wide.
-- Verify: python pipeline/check_set_paths.py --set classroom
local Workspace = game:GetService("Workspace")
_G.AIVidSets = _G.AIVidSets or {}

local function part(parent, name, size, pos, color, mat)
  local p = Instance.new("Part", parent)
  p.Name = name; p.Size = size; p.Position = pos; p.Anchored = true
  p.Color = color; p.Material = mat or Enum.Material.SmoothPlastic
  p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
  return p
end

local function label(p, face, text, color, font)
  local g = Instance.new("SurfaceGui", p); g.Face = face
  g.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud; g.PixelsPerStud = 50
  local l = Instance.new("TextLabel", g); l.Size = UDim2.fromScale(1, 1); l.BackgroundTransparency = 1
  l.Text = text; l.TextScaled = true; l.TextColor3 = color; l.Font = font or Enum.Font.GothamBold
  return l
end

_G.AIVidSets.classroom = function()
  local old = Workspace:FindFirstChild("Set_Classroom")
  if old then old:Destroy() end
  local f = Instance.new("Folder", Workspace); f.Name = "Set_Classroom"
  local wall, wood, dark = Color3.fromRGB(236, 228, 210), Color3.fromRGB(160, 116, 74), Color3.fromRGB(60, 64, 72)
  local glass = Color3.fromRGB(150, 200, 225)

  part(f, "Floor", Vector3.new(42, 1, 38), Vector3.new(0, -0.3, 0), Color3.fromRGB(176, 132, 90), Enum.Material.WoodPlanks)
  part(f, "Wall", Vector3.new(42, 13, 1), Vector3.new(0, 6.3, -19), wall, Enum.Material.Concrete)
  part(f, "Wall", Vector3.new(42, 13, 1), Vector3.new(0, 6.3, 19), wall, Enum.Material.Concrete)
  part(f, "Wall", Vector3.new(1, 13, 38), Vector3.new(-21, 6.3, 0), wall, Enum.Material.Concrete)
  part(f, "Wall", Vector3.new(1, 13, 38), Vector3.new(21, 6.3, 0), wall, Enum.Material.Concrete)
  part(f, "Ceiling", Vector3.new(42, 1, 38), Vector3.new(0, 12.8, 0), Color3.fromRGB(240, 240, 236))
  for _, x in ipairs({ -10, 10 }) do
    for _, z in ipairs({ -8, 8 }) do
      local panel = part(f, "CeilingLight", Vector3.new(4, 0.2, 4), Vector3.new(x, 12.2, z), Color3.fromRGB(255, 250, 235), Enum.Material.Neon)
      panel.CanCollide = false
      local l = Instance.new("SurfaceLight", panel); l.Face = Enum.NormalId.Bottom; l.Range = 18; l.Brightness = 1.1; l.Angle = 120
    end
  end
  for _, z in ipairs({ -9, 0, 9 }) do
    part(f, "Window", Vector3.new(0.2, 5, 6), Vector3.new(-20.4, 6.5, z), glass, Enum.Material.Glass).Transparency = 0.25
  end
  part(f, "ClassDoor", Vector3.new(0.3, 8, 4.4), Vector3.new(20.4, 4.2, -6), Color3.fromRGB(30, 47, 66), Enum.Material.WoodPlanks)

  local board = part(f, "Chalkboard", Vector3.new(18, 5.5, 0.3), Vector3.new(0, 6.6, -18.35), Color3.fromRGB(38, 70, 52), Enum.Material.Slate)
  label(board, Enum.NormalId.Back, "MATH  ·  CLASS 6B", Color3.fromRGB(240, 240, 230), Enum.Font.Cartoon)
  part(f, "ChalkTray", Vector3.new(18, 0.2, 0.5), Vector3.new(0, 3.75, -18.1), wood, Enum.Material.WoodPlanks)

  -- teacher desk (front panel faces the class)
  part(f, "TeacherDesk", Vector3.new(6, 0.3, 2.5), Vector3.new(0, 2.95, -11), wood, Enum.Material.WoodPlanks)
  part(f, "TeacherDeskPanel", Vector3.new(6, 2.6, 0.2), Vector3.new(0, 1.5, -9.85), wood, Enum.Material.WoodPlanks)
  for _, x in ipairs({ -2.85, 2.85 }) do
    part(f, "TeacherDeskSide", Vector3.new(0.2, 2.6, 2.4), Vector3.new(x, 1.5, -11), wood, Enum.Material.WoodPlanks)
  end

  -- 3x3 student desks: desk at z = c, chair behind it at c + 2 (seat faces -z toward the board)
  for _, x in ipairs({ -12, 0, 12 }) do
    for _, c in ipairs({ -2, 4, 10 }) do
      part(f, "DeskTop", Vector3.new(3.4, 0.25, 2), Vector3.new(x, 2.6, c), Color3.fromRGB(196, 160, 112), Enum.Material.WoodPlanks)
      for _, dx in ipairs({ -1.5, 1.5 }) do
        for _, dz in ipairs({ -0.8, 0.8 }) do
          part(f, "DeskLeg", Vector3.new(0.18, 2.4, 0.18), Vector3.new(x + dx, 1.35, c + dz), dark, Enum.Material.Metal)
        end
      end
      local paper = part(f, "ExamPaper", Vector3.new(1, 0.02, 1.3), Vector3.new(x + 0.3, 2.74, c), Color3.fromRGB(250, 250, 246))
      paper.CanCollide = false
      label(paper, Enum.NormalId.Top, "EXAM", Color3.fromRGB(40, 40, 60))
      part(f, "ChairSeat", Vector3.new(1.8, 0.25, 1.6), Vector3.new(x, 1.6, c + 2), Color3.fromRGB(70, 110, 160))
      part(f, "ChairBack", Vector3.new(1.8, 1.8, 0.22), Vector3.new(x, 2.6, c + 2.9), Color3.fromRGB(70, 110, 160))
      for _, dx in ipairs({ -0.75, 0.75 }) do
        for _, dz in ipairs({ -0.65, 0.65 }) do
          part(f, "ChairLeg", Vector3.new(0.14, 1.4, 0.14), Vector3.new(x + dx, 0.85, c + 2 + dz), dark, Enum.Material.Metal)
        end
      end
    end
  end
  print("[AI-Vid V6] Loaded set: classroom")
end
return _G.AIVidSets.classroom
