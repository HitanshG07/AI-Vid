-- ============================================================================
-- AI-Vid V5.4 Scene & Handcrafted Props Setup for Story 006
-- Builds: Market Counter, Prize Crate Accents, Rock Salt Dumpster, A-Frame Sign,
-- and spawns the 10-person boutique crowd.
-- ============================================================================

local Workspace = game:GetService("Workspace")

local function buildPropsAndSet()
  -- 1. Ensure Set_StreetDay exists
  if not Workspace:FindFirstChild("Set_StreetDay") then
    if _G.AIVidSets and _G.AIVidSets.street_day then
      _G.AIVidSets.street_day()
    else
      warn("Set_StreetDay function not found in _G.AIVidSets")
    end
  end

  local setFolder = Workspace:FindFirstChild("Set_StreetDay")
  if not setFolder then
    setFolder = Instance.new("Folder", Workspace)
    setFolder.Name = "Set_StreetDay"
  end

  -- Remove old EventProps if present
  local oldProps = setFolder:FindFirstChild("EventProps")
  if oldProps then oldProps:Destroy() end

  local eventProps = Instance.new("Folder", setFolder)
  eventProps.Name = "EventProps"

  local function makePart(parent, name, size, cf, color, mat, transparency)
    local p = Instance.new("Part")
    p.Name = name
    p.Size = size
    p.CFrame = cf
    p.Color = color
    p.Material = mat or Enum.Material.SmoothPlastic
    p.Transparency = transparency or 0
    p.Anchored = true
    p.CanCollide = false
    p.CastShadow = true
    p.Parent = parent
    return p
  end

  -- --------------------------------------------------------------------------
  -- 2. Market Counter (Wooden vendor stall table)
  -- --------------------------------------------------------------------------
  local stall = Instance.new("Model", eventProps)
  stall.Name = "MarketCounter"

  -- Table Top: 7 x 0.4 x 3.2 at Y=2.2, Z=15, X=19
  local tableTop = makePart(stall, "TableTop", Vector3.new(7, 0.4, 3.2), CFrame.new(19, 2.2, 15), Color3.fromRGB(135, 90, 55), Enum.Material.WoodPlanks)
  
  -- Table Legs (4 corners)
  local legOffsets = {
    Vector3.new(-3.2, -1.1, -1.3),
    Vector3.new(3.2, -1.1, -1.3),
    Vector3.new(-3.2, -1.1, 1.3),
    Vector3.new(3.2, -1.1, 1.3)
  }
  for i, off in ipairs(legOffsets) do
    makePart(stall, "Leg_"..i, Vector3.new(0.45, 2.0, 0.45), CFrame.new(Vector3.new(19, 2.2, 15) + off), Color3.fromRGB(95, 62, 38), Enum.Material.WoodPlanks)
  end

  -- Table Skirt (Navy blue fabric draped across front facing queue at Z = 13.4)
  makePart(stall, "FabricSkirt", Vector3.new(6.8, 1.9, 0.15), CFrame.new(19, 1.25, 13.45), Color3.fromRGB(32, 45, 78), Enum.Material.Fabric)

  -- Brass Corner Brackets on table edges
  for i, xOff in ipairs({ -3.45, 3.45 }) do
    for _, zOff in ipairs({ -1.55, 1.55 }) do
      makePart(stall, "BrassBracket", Vector3.new(0.3, 0.42, 0.3), CFrame.new(19 + xOff, 2.2, 15 + zOff), Color3.fromRGB(190, 155, 65), Enum.Material.Metal)
    end
  end

  -- --------------------------------------------------------------------------
  -- 3. Crate Hardware (Heavy brass padlock & brackets for Prize Crate)
  -- --------------------------------------------------------------------------
  local crateDetail = Instance.new("Model", eventProps)
  crateDetail.Name = "PrizeCrateDetail"
  -- Brass corner reinforcements on the crate pos (18.2, 2.75, 15)
  local cPos = Vector3.new(18.2, 2.75, 15)
  local cCorners = {
    Vector3.new(-0.95, 0.75, -0.95), Vector3.new(0.95, 0.75, -0.95),
    Vector3.new(-0.95, -0.75, -0.95), Vector3.new(0.95, -0.75, -0.95),
    Vector3.new(-0.95, 0.75, 0.95), Vector3.new(0.95, 0.75, 0.95),
    Vector3.new(-0.95, -0.75, 0.95), Vector3.new(0.95, -0.75, 0.95)
  }
  for i, off in ipairs(cCorners) do
    makePart(crateDetail, "CornerBracket_"..i, Vector3.new(0.25, 0.25, 0.25), CFrame.new(cPos + off), Color3.fromRGB(205, 170, 75), Enum.Material.Metal)
  end

  -- Heavy Brass Padlock / Hasp on front face (facing queue, Z = 13.98)
  local hasp = makePart(crateDetail, "BrassHasp", Vector3.new(0.4, 0.5, 0.1), CFrame.new(18.2, 2.8, 13.95), Color3.fromRGB(180, 140, 50), Enum.Material.Metal)
  local lockBody = makePart(crateDetail, "PadlockBody", Vector3.new(0.35, 0.4, 0.15), CFrame.new(18.2, 2.65, 13.9), Color3.fromRGB(215, 180, 70), Enum.Material.Metal)
  local lockShackle = makePart(crateDetail, "PadlockShackle", Vector3.new(0.25, 0.25, 0.1), CFrame.new(18.2, 2.88, 13.9), Color3.fromRGB(160, 165, 175), Enum.Material.Metal)

  -- --------------------------------------------------------------------------
  -- 4. Weathered Rock Salt Dumpster (at curb X=14.0, Z=15.0)
  -- --------------------------------------------------------------------------
  local dumpster = Instance.new("Model", eventProps)
  dumpster.Name = "RockSaltDumpster"

  -- Main container body: dark weathered green metal
  local dBody = makePart(dumpster, "DumpsterBody", Vector3.new(3.4, 3.2, 4.2), CFrame.new(13.6, 1.7, 15), Color3.fromRGB(42, 68, 50), Enum.Material.CorrodedMetal)
  
  -- Hinged Slanted Lid
  local dLid = makePart(dumpster, "DumpsterLid", Vector3.new(3.6, 0.35, 4.4), CFrame.new(13.6, 3.35, 15) * CFrame.Angles(0, 0, math.rad(6)), Color3.fromRGB(38, 58, 44), Enum.Material.Metal)

  -- Heavy Black Caster Wheels
  local wheelOffsets = {
    Vector3.new(-1.4, -1.45, -1.8),
    Vector3.new(1.4, -1.45, -1.8),
    Vector3.new(-1.4, -1.45, 1.8),
    Vector3.new(1.4, -1.45, 1.8)
  }
  for i, off in ipairs(wheelOffsets) do
    makePart(dumpster, "Wheel_"..i, Vector3.new(0.5, 0.5, 0.5), CFrame.new(Vector3.new(13.6, 1.7, 15) + off), Color3.fromRGB(25, 25, 28), Enum.Material.Metal)
  end

  -- Rock Salt Overflow Spilled on Sidewalk & Curb
  makePart(dumpster, "SaltSpillSidewalk", Vector3.new(2.8, 0.18, 3.2), CFrame.new(15.6, 0.58, 15), Color3.fromRGB(242, 244, 246), Enum.Material.Sand)
  makePart(dumpster, "SaltSpillCurb", Vector3.new(1.8, 0.22, 2.5), CFrame.new(13.8, 0.2, 16.2), Color3.fromRGB(235, 238, 240), Enum.Material.Concrete)

  -- Stencil on dumpster side facing sidewalk (SurfaceGui on Face Right)
  local stencilGui = Instance.new("SurfaceGui")
  stencilGui.Name = "StencilGui"
  stencilGui.Face = Enum.NormalId.Right
  stencilGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
  stencilGui.PixelsPerStud = 50
  stencilGui.Parent = dBody

  local stencilLabel = Instance.new("TextLabel")
  stencilLabel.Size = UDim2.new(1, 0, 1, 0)
  stencilLabel.BackgroundTransparency = 1
  stencilLabel.Text = "CITY SANITATION\n[ROCK SALT DEPOT]\nGRADE 4 COARSE"
  stencilLabel.Font = Enum.Font.GothamBold
  stencilLabel.TextColor3 = Color3.fromRGB(235, 195, 45)
  stencilLabel.TextSize = 22
  stencilLabel.TextWrapped = true
  stencilLabel.Parent = stencilGui

  -- --------------------------------------------------------------------------
  -- 5. Freestanding Wooden A-Frame Sign (at curb entrance X=14.0, Z=-6.0)
  -- --------------------------------------------------------------------------
  local aFrame = Instance.new("Model", eventProps)
  aFrame.Name = "AFrameSign"

  -- Legs: dark stained timber A-frame
  local legA = makePart(aFrame, "BoardA", Vector3.new(0.18, 3.4, 2.4), CFrame.new(14.0, 1.7, -6.0) * CFrame.Angles(0, 0, math.rad(14)), Color3.fromRGB(90, 62, 40), Enum.Material.WoodPlanks)
  local legB = makePart(aFrame, "BoardB", Vector3.new(0.18, 3.4, 2.4), CFrame.new(14.0, 1.7, -6.0) * CFrame.Angles(0, 0, math.rad(-14)), Color3.fromRGB(90, 62, 40), Enum.Material.WoodPlanks)

  -- Charcoal Chalkboard Face facing Sidewalk Queue (NormalId.Right)
  local chalkBoard = makePart(aFrame, "ChalkFace", Vector3.new(0.08, 2.7, 2.0), CFrame.new(14.45, 1.7, -6.0) * CFrame.Angles(0, 0, math.rad(-14)), Color3.fromRGB(34, 36, 40), Enum.Material.Slate)

  local chalkGui = Instance.new("SurfaceGui")
  chalkGui.Name = "ChalkGui"
  chalkGui.Face = Enum.NormalId.Right
  chalkGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
  chalkGui.PixelsPerStud = 50
  chalkGui.Parent = chalkBoard

  local chalkText = Instance.new("TextLabel")
  chalkText.Size = UDim2.new(1, -20, 1, -20)
  chalkText.Position = UDim2.new(0, 10, 0, 10)
  chalkText.BackgroundTransparency = 1
  chalkText.Text = "★ GRAND PRIZE EVENT ★\n\n10,000 COIN DRAWING\n\nWAIT AT LAMP POST\nDO NOT CROWD STALL"
  chalkText.Font = Enum.Font.SourceSansBold
  chalkText.TextColor3 = Color3.fromRGB(250, 245, 230)
  chalkText.TextSize = 22
  chalkText.TextWrapped = true
  chalkText.Parent = chalkGui

  print("[setup_006_scene] Handcrafted props built successfully!")
  return eventProps
end

_G.Build006Props = buildPropsAndSet
return buildPropsAndSet()
