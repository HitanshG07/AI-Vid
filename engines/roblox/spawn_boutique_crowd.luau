-- ============================================================================
-- AI-Vid V5.4 Boutique Crowd Generator (Story 006 Rebuild)
-- Spawns 10 distinct, individually styled, fully dressed catalog extras
-- along the sidewalk queue with organic spacing, gender-locked wardrobe,
-- zero duplicate clothing/hair, and desynchronized reactive animations.
-- ============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local EXTRAS_DATA = {
  -- Boys (4 distinct outfits & hair, zero overlap with Leo/Chad/Milo)
  { name = "Extra_Boy1", gender = "boy", skin = Color3.fromRGB(234, 184, 146), shirt = 86330417861158, pants = 12671481024, hair = "71343213020367", pos = Vector3.new(25.2, 0, -10.0), yaw = 260 },
  { name = "Extra_Boy2", gender = "boy", skin = Color3.fromRGB(196, 144, 102), shirt = 12329928029, pants = 134609569320601, hair = "124340390453001", pos = Vector3.new(25.0, 0, 2.5), yaw = 270 },
  { name = "Extra_Boy3", gender = "boy", skin = Color3.fromRGB(130, 85, 55), shirt = 78421295651694, pants = 12574395860, hair = "74528752688799", pos = Vector3.new(25.0, 0, 8.5), yaw = 280 },
  { name = "Extra_Boy4", gender = "boy", skin = Color3.fromRGB(245, 205, 175), shirt = 93684471979859, pants = 89518846190037, hair = "94946081980224", pos = Vector3.new(25.5, 0, 11.0), yaw = 270 },
  
  -- Girls (4 distinct outfits & hair, zero overlap with Zoe)
  { name = "Extra_Girl1", gender = "girl", skin = Color3.fromRGB(245, 205, 175), shirt = 133484080647039, pants = 389857088, hair = "100973074711029", pos = Vector3.new(25.5, 0, -6.0), yaw = 275 },
  { name = "Extra_Girl2", gender = "girl", skin = Color3.fromRGB(196, 144, 102), shirt = 85435724220934, pants = 18332980667, hair = "17890789000", pos = Vector3.new(25.6, 0, 5.0), yaw = 265 },
  { name = "Extra_Girl3", gender = "girl", skin = Color3.fromRGB(234, 184, 146), shirt = 5688801027, pants = 6092144716, hair = "140124368601570", pos = Vector3.new(25.2, 0, 13.5), yaw = 285 },
  { name = "Extra_Girl4", gender = "girl", skin = Color3.fromRGB(110, 68, 40), shirt = 18566797626, pants = 5498774219, hair = "129421843016867", pos = Vector3.new(24.8, 0, -4.5), yaw = 260 },
  
  -- Adults / Teens (2 distinct outfits & hair, zero overlap with Vendor)
  { name = "Extra_Adult1", gender = "man", skin = Color3.fromRGB(215, 165, 125), shirt = 2885430411, pants = 140429444258386, hair = "120646937583722", pos = Vector3.new(25.4, 0, -1.0), yaw = 270 },
  { name = "Extra_Adult2", gender = "man", skin = Color3.fromRGB(160, 110, 75), shirt = 4593507067, pants = 3234753288, hair = "139671521768286", pos = Vector3.new(25.8, 0, 17.0), yaw = 270 },
}

local FACE_IDS = {
  neutral = "rbxassetid://70950815478959",
  scared  = "rbxassetid://94514852927815",
  shocked = "rbxassetid://103057607693548",
  grin    = "rbxassetid://96253429845051",
}

local function buildExtra(spec, parent)
  local d = Instance.new("HumanoidDescription")
  d.Shirt = spec.shirt
  d.Pants = spec.pants
  if spec.hair and spec.hair ~= "" then
    d.HairAccessory = spec.hair
  end
  for _, part in ipairs({"HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor"}) do
    d[part] = spec.skin
  end

  local m = Players:CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R6)
  m.Name = spec.name

  local hrp = m:FindFirstChild("HumanoidRootPart")
  if hrp then m.PrimaryPart = hrp end

  local hum = m:FindFirstChildOfClass("Humanoid")
  if hum then
    hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
    hum.DisplayName = ""
  end

  -- Scale
  local scale = (spec.gender == "girl") and 0.96 or (spec.gender == "boy" and 0.98 or 1.02)
  m:ScaleTo(scale)

  -- Position & Yaw
  local targetPos = spec.pos
  m:PivotTo(CFrame.new(targetPos.X, 0.5, targetPos.Z) * CFrame.Angles(0, math.rad(spec.yaw or 0), 0))

  -- Grounding
  local low = math.huge
  for _, p in ipairs(m:GetChildren()) do
    if p:IsA("BasePart") then
      low = math.min(low, p.Position.Y - p.Size.Y / 2)
    end
  end
  m:PivotTo(m:GetPivot() + Vector3.new(0, 0.5 - low, 0))

  -- Anchoring & Collision: Anchor ONLY HumanoidRootPart to ensure accessories attach properly
  for _, p in ipairs(m:GetDescendants()) do
    if p:IsA("BasePart") then
      p.Anchored = (p.Name == "HumanoidRootPart")
      p.CanCollide = false
      p.CanTouch = false
      p.CanQuery = false
    elseif p:IsA("LuaSourceContainer") then
      p:Destroy()
    end
  end

  -- Face decal
  local head = m:FindFirstChild("Head")
  if head then
    local face = head:FindFirstChild("face")
    if not face then
      face = Instance.new("Decal")
      face.Name = "face"
      face.Parent = head
    end
    face.Texture = FACE_IDS.neutral
  end

  m.Parent = parent
  return m
end

local function spawnBoutiqueCrowd()
  local crowdFolder = Workspace:FindFirstChild("Crowd_006")
  if not crowdFolder then
    crowdFolder = Instance.new("Folder")
    crowdFolder.Name = "Crowd_006"
    crowdFolder.Parent = Workspace
  else
    crowdFolder:ClearAllChildren()
  end

  local rigs = {}
  for _, spec in ipairs(EXTRAS_DATA) do
    local model = buildExtra(spec, crowdFolder)
    local torso = model:FindFirstChild("Torso")
    local neck = torso and torso:FindFirstChild("Neck")
    local rShoulder = torso and torso:FindFirstChild("Right Shoulder")
    local lShoulder = torso and torso:FindFirstChild("Left Shoulder")
    table.insert(rigs, {
      model = model,
      neck = neck,
      baseNeck = neck and neck.C0,
      rShoulder = rShoulder,
      baseRS = rShoulder and rShoulder.C0,
      lShoulder = lShoulder,
      baseLS = lShoulder and lShoulder.C0,
      phase = math.random() * math.pi * 2,
      baseYaw = spec.yaw or 0,
      pos = spec.pos,
    })
  end

  -- Desynchronized Reactive Animation Loop
  _G.Crowd10_StopAnim = false
  task.spawn(function()
    while not _G.Crowd10_StopAnim do
      local now = os.clock()
      local castFolder = Workspace:FindFirstChild("Cast_006")
      local chad = castFolder and castFolder:FindFirstChild("Chad")
      local chadPos = chad and chad:GetPivot().Position or Vector3.new(0, 0, 0)

      for _, r in ipairs(rigs) do
        local p = now * 1.8 + r.phase
        local breath = math.sin(p) * 0.04

        -- Subtle natural idle breathing
        if r.neck and r.baseNeck then
          local headTurn = math.sin(p * 0.5) * 0.08
          r.neck.C0 = r.baseNeck * CFrame.Angles(breath * 0.5, headTurn, 0)
        end
        if r.rShoulder and r.baseRS then
          r.rShoulder.C0 = r.baseRS * CFrame.Angles(0, 0, breath)
        end
        if r.lShoulder and r.baseLS then
          r.lShoulder.C0 = r.baseLS * CFrame.Angles(0, 0, -breath)
        end

        -- Reaction: Chad nearby (flinch back)
        local distToChad = (r.pos - chadPos).Magnitude
        if distToChad < 3.5 and chadPos.Z > r.pos.Z - 2 and chadPos.Z < r.pos.Z + 2 then
          if r.neck and r.baseNeck then
            r.neck.C0 = r.baseNeck * CFrame.Angles(-0.15, -0.25, 0)
          end
        end
      end
      RunService.Heartbeat:Wait()
    end
  end)

  return #rigs
end

_G.SpawnBoutiqueCrowd = spawnBoutiqueCrowd
return spawnBoutiqueCrowd()
