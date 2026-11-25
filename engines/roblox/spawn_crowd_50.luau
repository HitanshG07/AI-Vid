-- AI-Vid V5.4: 50-Person Queue Spawner & Dynamic Reactive Animation Engine
-- Spawns exactly 47 unique R6 catalog extras (+ Leo, Zoe, Milo = 50 people waiting in line!)
-- Full R6 catalog packages, gender-locked, zero nameplates, floor-snapped
-- CanCollide=false, CanQuery=false, CanTouch=false so camera raycasts NEVER snag or collide
-- Dynamic Proximity & Story Reactions:
--   1. Natural idle breathing, conversational chatter pairs, watch-checking
--   2. Chad Sprint Flinch: defensive lean-back and arm raise when Chad charges past
--   3. Chad Boasting Disgust: arms crossed and head shake when Chad dances at counter
--   4. Vendor Reveal: all 47 extras pivot 180° back toward Leo (Customer #50)
--   5. Salt Collapse: entire crowd points, cheers, and bobs with laughter when Chad collapses!

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local set = Workspace:FindFirstChild("Set_StreetDay")
assert(set, "Set_StreetDay not found in Workspace")

-- Clean up any old crowd folder & stanchions
local oldCrowd = set:FindFirstChild("Crowd_50")
if oldCrowd then oldCrowd:Destroy() end

local cast = Workspace:FindFirstChild("Cast_006")
assert(cast, "Cast_006 not found in Workspace")

local oldCrowdCast = cast:FindFirstChild("Crowd_50")
if oldCrowdCast then oldCrowdCast:Destroy() end

local crowdFolder = Instance.new("Folder", cast)
crowdFolder.Name = "Crowd_50"

local leoTemplate = cast:FindFirstChild("Leo")
local zoeTemplate = cast:FindFirstChild("Zoe")
local vendorTemplate = cast:FindFirstChild("Vendor")
local miloTemplate = cast:FindFirstChild("Milo")
local chadRig = cast:FindFirstChild("Chad")

assert(leoTemplate and zoeTemplate and vendorTemplate, "Cast templates missing")

-- Clean up any duplicate stanchions in EventProps
local ep = set:FindFirstChild("EventProps")
if ep then
    for _, ch in ipairs(ep:GetChildren()) do
        if ch.Name:find("Stanchion") or ch.Name:find("VelvetRope") then
            ch:Destroy()
        end
    end
end

-- ============================================================================
-- 1. BUILD RE-DESIGNED QUEUE SIGN MODEL (Zero pole overlap, ultra-sharp SurfaceGui)
-- ============================================================================
local oldSign = ep and ep:FindFirstChild("QueueSignModel")
if oldSign then oldSign:Destroy() end

local signModel = Instance.new("Model")
signModel.Name = "QueueSignModel"
signModel.Parent = ep or set

-- Position at sidewalk curb entrance: X=13.8, Y=0.5, Z=-7.0 (clear of all stanchions & ropes)
local signPos = Vector3.new(13.8, 0.5, -7.0)
local brassColor = Color3.fromRGB(225, 185, 45)
local darkNavy = Color3.fromRGB(15, 28, 55)

-- Base: Heavy weighted brass pedestal disc
local base = Instance.new("Part", signModel)
base.Name = "Base"
base.Shape = Enum.PartType.Cylinder
base.Size = Vector3.new(0.25, 1.8, 1.8)
base.CFrame = CFrame.new(signPos + Vector3.new(0, 0.12, 0)) * CFrame.Angles(0, 0, math.rad(90))
base.Anchored = true; base.CanCollide = false; base.CanQuery = false; base.CanTouch = false
base.Material = Enum.Material.Metal; base.Color = brassColor

-- Upright pole: terminates at Y=3.6 into collar (never intersects board)
local pole = Instance.new("Part", signModel)
pole.Name = "Pole"
pole.Size = Vector3.new(0.22, 2.9, 0.22)
pole.Position = signPos + Vector3.new(0, 1.65, 0)
pole.Anchored = true; pole.CanCollide = false; pole.CanQuery = false; pole.CanTouch = false
pole.Material = Enum.Material.Metal; pole.Color = brassColor

-- Decorative Collar bracket
local collar = Instance.new("Part", signModel)
collar.Name = "Collar"
collar.Size = Vector3.new(0.5, 0.2, 0.5)
collar.Position = signPos + Vector3.new(0, 3.1, 0)
collar.Anchored = true; collar.CanCollide = false; collar.CanQuery = false; collar.CanTouch = false
collar.Material = Enum.Material.Metal; collar.Color = brassColor

-- Sign Board: Navy blue display panel
local board = Instance.new("Part", signModel)
board.Name = "Board"
board.Size = Vector3.new(3.0, 2.1, 0.18)
board.Position = signPos + Vector3.new(0, 4.35, 0)
board.Anchored = true; board.CanCollide = false; board.CanQuery = false; board.CanTouch = false
board.Material = Enum.Material.SmoothPlastic; board.Color = darkNavy

-- 3D Perimeter Edge Trims (Never covers or occludes SurfaceGui text!)
local trimTop = Instance.new("Part", signModel)
trimTop.Name = "TrimTop"; trimTop.Size = Vector3.new(3.2, 0.12, 0.22); trimTop.Position = board.Position + Vector3.new(0, 1.11, 0)
trimTop.Anchored = true; trimTop.CanCollide = false; trimTop.CanQuery = false; trimTop.CanTouch = false; trimTop.Material = Enum.Material.Metal; trimTop.Color = brassColor

local trimBottom = Instance.new("Part", signModel)
trimBottom.Name = "TrimBottom"; trimBottom.Size = Vector3.new(3.2, 0.12, 0.22); trimBottom.Position = board.Position - Vector3.new(0, 1.11, 0)
trimBottom.Anchored = true; trimBottom.CanCollide = false; trimBottom.CanQuery = false; trimBottom.CanTouch = false; trimBottom.Material = Enum.Material.Metal; trimBottom.Color = brassColor

local trimLeft = Instance.new("Part", signModel)
trimLeft.Name = "TrimLeft"; trimLeft.Size = Vector3.new(0.12, 2.1, 0.22); trimLeft.Position = board.Position - Vector3.new(1.56, 0, 0)
trimLeft.Anchored = true; trimLeft.CanCollide = false; trimLeft.CanQuery = false; trimLeft.CanTouch = false; trimLeft.Material = Enum.Material.Metal; trimLeft.Color = brassColor

local trimRight = Instance.new("Part", signModel)
trimRight.Name = "TrimRight"; trimRight.Size = Vector3.new(0.12, 2.1, 0.22); trimRight.Position = board.Position + Vector3.new(1.56, 0, 0)
trimRight.Anchored = true; trimRight.CanCollide = false; trimRight.CanQuery = false; trimRight.CanTouch = false; trimRight.Material = Enum.Material.Metal; trimRight.Color = brassColor

local function createSignGui(face)
    local sg = Instance.new("SurfaceGui", board)
    sg.Face = face
    sg.AlwaysOnTop = false
    sg.LightInfluence = 0
    sg.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
    sg.CanvasSize = Vector2.new(600, 420)
    
    local root = Instance.new("Frame", sg)
    root.Size = UDim2.new(1, 0, 1, 0)
    root.BackgroundColor3 = darkNavy
    root.BorderSizePixel = 0
    
    local innerBorder = Instance.new("Frame", root)
    innerBorder.Size = UDim2.new(1, -24, 1, -24)
    innerBorder.Position = UDim2.new(0, 12, 0, 12)
    innerBorder.BackgroundTransparency = 1
    innerBorder.BorderColor3 = brassColor
    innerBorder.BorderSizePixel = 4
    
    local header = Instance.new("TextLabel", innerBorder)
    header.Size = UDim2.new(1, 0, 0.24, 0)
    header.Position = UDim2.new(0, 0, 0.05, 0)
    header.BackgroundTransparency = 1
    header.Font = Enum.Font.FredokaOne
    header.Text = "★ GRAND PRIZE LINE ★"
    header.TextColor3 = Color3.fromRGB(255, 215, 0)
    header.TextScaled = true
    
    local title = Instance.new("TextLabel", innerBorder)
    title.Size = UDim2.new(1, -16, 0.42, 0)
    title.Position = UDim2.new(0, 8, 0.28, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.FredokaOne
    title.Text = "LINE STARTS\nHERE"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    
    local footer = Instance.new("TextLabel", innerBorder)
    footer.Size = UDim2.new(1, 0, 0.22, 0)
    footer.Position = UDim2.new(0, 0, 0.72, 0)
    footer.BackgroundTransparency = 1
    footer.Font = Enum.Font.FredokaOne
    footer.Text = "▼ 50 PERSON MAX ▼"
    footer.TextColor3 = Color3.fromRGB(255, 225, 50)
    footer.TextScaled = true
end

createSignGui(Enum.NormalId.Back)
createSignGui(Enum.NormalId.Front)

-- Gender-Locked Wardrobe Catalogs
local GENDER_WARDROBE = {
    boy = {
        shirts = {
            "http://www.roblox.com/asset/?id=398633582",      -- Denim hoodie
            "http://www.roblox.com/asset/?id=144076357",      -- Motorcycle leather jacket
            "http://www.roblox.com/asset/?id=382538294",      -- Guitar graphic tee
            "http://www.roblox.com/asset/?id=86330417861158", -- Boy skate tee
            "http://www.roblox.com/asset/?id=12329928029",    -- Red puffer jacket
        },
        pants = {
            "http://www.roblox.com/asset/?id=144076759",      -- Dark blue denim
            "http://www.roblox.com/asset/?id=398635336",      -- Khaki cargo pants
            "http://www.roblox.com/asset/?id=398633811",      -- Black skinny jeans
            "http://www.roblox.com/asset/?id=134609569320601",-- Boy jeans
            "http://www.roblox.com/asset/?id=12671481024",    -- Skate denim
        },
    },
    girl = {
        shirts = {
            "http://www.roblox.com/asset/?id=95440911588969", -- Floral summer top
            "http://www.roblox.com/asset/?id=91467779965025", -- Cute girl graphic tee
            "http://www.roblox.com/asset/?id=85435724220934", -- Pastel casual top
            "http://www.roblox.com/asset/?id=133484080647039",-- Girl cute hoodie
            "http://www.roblox.com/asset/?id=18566797626",    -- Black comfy sweater
        },
        pants = {
            "http://www.roblox.com/asset/?id=13979853480",    -- Denim shorts
            "http://www.roblox.com/asset/?id=13979853518",    -- Fitted denim shorts
            "http://www.roblox.com/asset/?id=18332980667",    -- Chic girl pants
            "http://www.roblox.com/asset/?id=5498774219",     -- Womens casual jeans
            "http://www.roblox.com/asset/?id=389857088",      -- Girl denim jeans
        },
    },
    man = {
        shirts = {
            "http://www.roblox.com/asset/?id=607785311",      -- Formal suit jacket
            "http://www.roblox.com/asset/?id=144076357",      -- Motorcycle leather jacket
            "http://www.roblox.com/asset/?id=3568313512",     -- Billy's works shirt MEN
            "http://www.roblox.com/asset/?id=2885430411",     -- Mens tracksuit
            "http://www.roblox.com/asset/?id=8836645430",     -- Mens casual button shirt
        },
        pants = {
            "http://www.roblox.com/asset/?id=144076759",      -- Dark blue slacks / denim
            "http://www.roblox.com/asset/?id=398635336",      -- Khaki cargo slacks
            "http://www.roblox.com/asset/?id=398633811",      -- Black slacks
            "http://www.roblox.com/asset/?id=140429444258386",-- Balenci Men's tracksuit pants
            "http://www.roblox.com/asset/?id=12858384874",    -- Beige cargo pants for men
        },
    }
}

local SKINS = {
    Color3.fromRGB(255, 204, 153), -- Peach
    Color3.fromRGB(234, 190, 150), -- Tan
    Color3.fromRGB(215, 160, 110), -- Golden
    Color3.fromRGB(176, 124, 92),  -- Deep Bronze
    Color3.fromRGB(150, 100, 70),  -- Deep Brown
    Color3.fromRGB(110, 75, 55),   -- Espresso
    Color3.fromRGB(240, 200, 160), -- Fair
}

local FACES = {
    neutral    = "rbxassetid://70950815478959",
    grin       = "rbxassetid://96253429845051",
    shocked    = "rbxassetid://103057607693548",
    scared     = "rbxassetid://94514852927815",
    determined = "rbxassetid://109687999939498",
    proud      = "rbxassetid://96477668083717",
}

local FACE_LIST = {
    FACES.neutral, FACES.grin, FACES.shocked, FACES.scared, FACES.determined, FACES.proud
}

-- Gender-Locked Hair Repositories
local BOY_HAIR = {}
local GIRL_HAIR = {}
local MAN_HAIR = {}

if leoTemplate:FindFirstChild("Ultra-Fabulous Hair Brown") then table.insert(BOY_HAIR, leoTemplate["Ultra-Fabulous Hair Brown"]) end
if miloTemplate:FindFirstChild("Accessory (Brown Fluffy Anime Hair)") then table.insert(BOY_HAIR, miloTemplate["Accessory (Brown Fluffy Anime Hair)"]) end
if zoeTemplate:FindFirstChild("Aesthetic Y2k Long Ponytail (black)") then table.insert(GIRL_HAIR, zoeTemplate["Aesthetic Y2k Long Ponytail (black)"]) end
if vendorTemplate:FindFirstChild("Hat1") then table.insert(MAN_HAIR, vendorTemplate["Hat1"]) end

local ss = game:GetService("ServerStorage")
local old011 = ss:FindFirstChild("_Old") and ss._Old:FindFirstChild("011") and ss._Old["011"]:FindFirstChild("Cast_011")
if old011 then
    if old011:FindFirstChild("E4") and old011.E4:FindFirstChild("Accessory (BunHair)") then table.insert(GIRL_HAIR, old011.E4["Accessory (BunHair)"]) end
    if old011:FindFirstChild("Rosa") and old011.Rosa:FindFirstChild("Accessory (Ponytail)") then table.insert(GIRL_HAIR, old011.Rosa["Accessory (Ponytail)"]) end
    if old011:FindFirstChild("E6") and old011.E6:FindFirstChild("Accessory (curly boy hair)") then table.insert(BOY_HAIR, old011.E6["Accessory (curly boy hair)"]) end
end
local old013 = ss:FindFirstChild("_Old") and ss._Old:FindFirstChild("013") and ss._Old["013"]:FindFirstChild("Cast_013")
if old013 then
    if old013:FindFirstChild("Extra_Man") and old013.Extra_Man:FindFirstChild("Accessory (Meshes/Hair2 final ver1Accessory)") then
        table.insert(MAN_HAIR, old013.Extra_Man["Accessory (Meshes/Hair2 final ver1Accessory)"])
    end
end

-- ============================================================================
-- 2. BUILD QUEUE STANCHIONS & VELVET ROPES (Raycast-safe: CanQuery=false)
-- ============================================================================
local stanchionFolder = set:FindFirstChild("Stanchions_50")
if stanchionFolder then stanchionFolder:Destroy() end
stanchionFolder = Instance.new("Folder", set)
stanchionFolder.Name = "Stanchions_50"

local brass = Color3.fromRGB(225, 185, 45)
local velvet = Color3.fromRGB(180, 20, 25)

local function buildStanchion(pos)
    local b = Instance.new("Part", stanchionFolder)
    b.Name = "StanchionBase"; b.Size = Vector3.new(0.9, 0.15, 0.9); b.Position = pos + Vector3.new(0, 0.08, 0)
    b.Anchored = true; b.CanCollide = false; b.CanQuery = false; b.CanTouch = false; b.Material = Enum.Material.Metal; b.Color = brass

    local p = Instance.new("Part", stanchionFolder)
    p.Name = "StanchionPole"; p.Size = Vector3.new(0.18, 3.2, 0.18); p.Position = pos + Vector3.new(0, 1.7, 0)
    p.Anchored = true; p.CanCollide = false; p.CanQuery = false; p.CanTouch = false; p.Material = Enum.Material.Metal; p.Color = brass

    local cap = Instance.new("Part", stanchionFolder)
    cap.Name = "StanchionCap"; cap.Shape = Enum.PartType.Ball; cap.Size = Vector3.new(0.5, 0.5, 0.5); cap.Position = pos + Vector3.new(0, 3.4, 0)
    cap.Anchored = true; cap.CanCollide = false; cap.CanQuery = false; cap.CanTouch = false; cap.Material = Enum.Material.Metal; cap.Color = brass
    return cap
end

local function buildRope(pA, pB)
    local mid = (pA + pB) / 2
    local dist = (pA - pB).Magnitude
    local r = Instance.new("Part", stanchionFolder)
    r.Name = "VelvetRope"; r.Shape = Enum.PartType.Cylinder; r.Size = Vector3.new(dist, 0.2, 0.2)
    r.CFrame = CFrame.lookAt(mid + Vector3.new(0, -0.25, 0), pB + Vector3.new(0, -0.25, 0)) * CFrame.Angles(0, math.rad(90), 0)
    r.Anchored = true; r.CanCollide = false; r.CanQuery = false; r.CanTouch = false; r.Material = Enum.Material.Fabric; r.Color = velvet
end

-- Stanchion rows: Row 1 (X=18.6) starts at Z=-2.5 so Z<=-2.5 is completely OPEN at the entrance
local rowsX = { 18.6, 21.2, 23.7, 26.2 }
for _, sx in ipairs(rowsX) do
    local prevCap = nil
    local zStart = (sx == 18.6 or sx == 21.2 or sx == 26.2) and -2.2 or -4.5
    for sz = zStart, 16.5, 3.8 do
        local skip = (sx == 23.7 and sz > 13.5)
        if not skip then
            local cap = buildStanchion(Vector3.new(sx, 0.5, sz))
            if prevCap then
                buildRope(prevCap.Position, cap.Position)
            end
            prevCap = cap
        else
            prevCap = nil
        end
    end
end

-- ============================================================================
-- 3. SPONSOR 47 R6 QUEUE EXTRAS (Well-spaced, no collision with Chad's run corridor)
-- ============================================================================
local SLOTS = {}

-- Lane 1: extras tucked against X=20.5 leaving X=19.5-20.0 open for Chad's charge!
table.insert(SLOTS, { pos = Vector3.new(20.5, 0.5, -2.0), yaw = 0, gender = "boy", inLane1 = true, personality = "flinch" })
table.insert(SLOTS, { pos = Vector3.new(20.5, 0.5, 0.0),  yaw = 0, gender = "girl", inLane1 = true, personality = "watch" })
table.insert(SLOTS, { pos = Vector3.new(20.5, 0.5, 2.0),  yaw = 0, gender = "man", inLane1 = true, personality = "flinch" })
table.insert(SLOTS, { pos = Vector3.new(20.5, 0.5, 6.5),  yaw = 0, gender = "boy", inLane1 = true, personality = "flinch" })
table.insert(SLOTS, { pos = Vector3.new(20.5, 0.5, 9.0),  yaw = 0, gender = "girl", inLane1 = true, personality = "chat" })
table.insert(SLOTS, { pos = Vector3.new(20.5, 0.5, 14.5), yaw = 0, gender = "boy", inLane1 = true, personality = "disgust" }) -- Customer #1

-- Lane 2 (14 extras)
local zSteps2 = { -4.0, -2.5, -1.0, 0.5, 2.0, 3.5, 5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0, 15.5 }
for i, z in ipairs(zSteps2) do
    local g = (i % 3 == 0) and "girl" or ((i % 3 == 1) and "boy" or "man")
    local p = (i % 4 == 0) and "watch" or ((i % 2 == 0) and "chat" or "idle")
    table.insert(SLOTS, { pos = Vector3.new(22.5, 0.5, z), yaw = 0, gender = g, personality = p })
end

-- Lane 3 (14 extras, facing -Z toward queue loop)
local zSteps3 = { 15.5, 14.0, 12.5, 11.0, 9.5, 8.0, 6.5, 5.0, 3.5, 2.0, 0.5, -1.0, -2.5, -4.0 }
for i, z in ipairs(zSteps3) do
    local g = (i % 3 == 1) and "girl" or ((i % 3 == 2) and "boy" or "man")
    local p = (i % 3 == 0) and "chat" or "idle"
    table.insert(SLOTS, { pos = Vector3.new(24.9, 0.5, z), yaw = 180, gender = g, personality = p })
end

-- Lane 4 (13 extras)
local zSteps4 = { -4.0, -2.5, -1.0, 0.5, 2.0, 3.5, 5.0, 6.5, 8.0, 9.5, 11.0, 12.5, 14.0 }
for i, z in ipairs(zSteps4) do
    local g = (i % 2 == 0) and "girl" or "boy"
    local p = (i % 4 == 1) and "watch" or ((i % 2 == 1) and "chat" or "idle")
    table.insert(SLOTS, { pos = Vector3.new(27.3, 0.5, z), yaw = 0, gender = g, personality = p })
end

local animatedCrowdRigs = {}

for idx, slot in ipairs(SLOTS) do
    local gender = slot.gender or "boy"
    local tmpl = (gender == "girl") and zoeTemplate or ((gender == "man") and vendorTemplate or leoTemplate)
    local m = tmpl:Clone()
    m.Name = "Extra_" .. idx
    
    for _, ch in ipairs(m:GetChildren()) do
        if ch:IsA("Accessory") then ch:Destroy() end
    end
    
    local w = GENDER_WARDROBE[gender] or GENDER_WARDROBE.boy
    local shirt = m:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", m)
    shirt.ShirtTemplate = w.shirts[(idx % #w.shirts) + 1]
    
    local pants = m:FindFirstChildOfClass("Pants") or Instance.new("Pants", m)
    pants.PantsTemplate = w.pants[((idx * 2) % #w.pants) + 1]
    
    local skin = SKINS[(idx % #SKINS) + 1]
    local bc = m:FindFirstChildOfClass("BodyColors") or Instance.new("BodyColors", m)
    for _, k in ipairs({ "HeadColor3", "TorsoColor3", "LeftArmColor3", "RightArmColor3", "LeftLegColor3", "RightLegColor3" }) do
        bc[k] = skin
    end
    
    local head = m:FindFirstChild("Head")
    local faceDecal = head and (head:FindFirstChildOfClass("Decal") or Instance.new("Decal", head))
    local initialFace = FACE_LIST[(idx % #FACE_LIST) + 1]
    if faceDecal then
        faceDecal.Name = "face"; faceDecal.Face = Enum.NormalId.Front
        faceDecal.Texture = initialFace
    end
    
    local hairPool = (gender == "girl") and GIRL_HAIR or ((gender == "man") and MAN_HAIR or BOY_HAIR)
    if #hairPool > 0 then
        local hairTemplate = hairPool[(idx % #hairPool) + 1]
        local hairClone = hairTemplate:Clone()
        local handle = hairClone:FindFirstChild("Handle")
        if handle then
            for _, ch in ipairs(handle:GetChildren()) do
                if ch:IsA("Weld") or ch:IsA("WeldConstraint") then ch:Destroy() end
            end
            handle.CanCollide = false
            handle.CanQuery = false
            handle.CanTouch = false
            handle.Anchored = false
        end
        local hum = m:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:AddAccessory(hairClone)
        else
            hairClone.Parent = m
        end
    end
    
    local hum = m:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        hum.DisplayName = ""
    end
    
    for _, p in ipairs(m:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = false
            p.CanQuery = false
            p.CanTouch = false
            p.Anchored = (p.Name == "HumanoidRootPart")
        end
    end
    
    local hrp = m:FindFirstChild("HumanoidRootPart")
    if hrp then m.PrimaryPart = hrp end
    m:PivotTo(CFrame.new(slot.pos.X, 3.5, slot.pos.Z) * CFrame.Angles(0, math.rad(slot.yaw), 0))
    
    local low = math.huge
    for _, p in ipairs(m:GetChildren()) do
        if p:IsA("BasePart") then low = math.min(low, p.Position.Y - p.Size.Y / 2) end
    end
    m:PivotTo(m:GetPivot() + Vector3.new(0, 0.5 - low, 0))
    
    m.Parent = crowdFolder
    
    local torso = m:FindFirstChild("Torso")
    if torso then
        local rShoulder = torso:FindFirstChild("Right Shoulder")
        local lShoulder = torso:FindFirstChild("Left Shoulder")
        local rHip = torso:FindFirstChild("Right Hip")
        local lHip = torso:FindFirstChild("Left Hip")
        local neck = torso:FindFirstChild("Neck")
        if rShoulder and lShoulder and neck then
            table.insert(animatedCrowdRigs, {
                m = m,
                faceDecal = faceDecal,
                initialFace = initialFace,
                inLane1 = slot.inLane1,
                personality = slot.personality,
                rShoulder = rShoulder,
                lShoulder = lShoulder,
                rHip = rHip,
                lHip = lHip,
                neck = neck,
                baseR = rShoulder.C0,
                baseL = lShoulder.C0,
                baseRH = rHip and rHip.C0 or CFrame.new(),
                baseLH = lHip and lHip.C0 or CFrame.new(),
                baseN = neck.C0,
                phase = math.random() * 6.28,
                speed = 1.2 + math.random() * 0.8,
                homePos = slot.pos,
                laneYaw = slot.yaw,
            })
        end
    end
end

print(string.format("[AI-Vid V5.4] Staged %d extras. Dynamic Reactive Engine starting.", #SLOTS))

-- ============================================================================
-- 4. DYNAMIC REACTIVE CROWD ANIMATION ENGINE (Heartbeat loop)
-- ============================================================================
_G.Crowd50_StopAnim = true
task.wait(0.05)
_G.Crowd50_StopAnim = false

local startTime = os.clock()
local lastChadZ = -10.0

task.spawn(function()
    while not _G.Crowd50_StopAnim and crowdFolder.Parent do
        local now = os.clock()
        local t = now - startTime
        
        -- Live actor tracking
        local chadPos = chadRig and chadRig:FindFirstChild("HumanoidRootPart") and chadRig.HumanoidRootPart.Position or Vector3.new(20, 0, -20)
        local vendorPos = vendorTemplate and vendorTemplate:FindFirstChild("HumanoidRootPart") and vendorTemplate.HumanoidRootPart.Position or Vector3.new(20, 0, 18)
        local chadTorso = chadRig and chadRig:FindFirstChild("Torso")
        local chadOrientationX = chadTorso and chadTorso.Orientation.X or 0
        local chadPosY = chadPos.Y
        
        -- Detect Story State dynamically:
        -- 1. Chad is collapsed on ground: pitch drops or low Y
        local isChadCollapsed = (chadOrientationX < -25 or chadOrientationX > 70 or chadPosY < 2.2) and (chadPos.Z > 10)
        -- 2. Vendor has walked out to make announcement: Vendor moved forward to Z <= 13
        local isVendorAnnouncing = (vendorPos.Z <= 13.5 and vendorPos.Z >= 6.0)
        -- 3. Chad is dancing at counter: Chad is at Z >= 15 and Vendor is at counter Z >= 16
        local isChadDancingAtCounter = (chadPos.Z >= 14.5 and vendorPos.Z >= 16.0 and not isChadCollapsed)
        -- 4. Chad sprint: moving rapidly along Lane 1
        local isChadCharging = (chadPos.Z > -8 and chadPos.Z < 15 and not isChadCollapsed and not isVendorAnnouncing)
        
        for idx, r in ipairs(animatedCrowdRigs) do
            local p = now * r.speed + r.phase
            local breath = math.sin(p) * 0.04
            local headYaw = math.sin(p * 0.6) * 0.06
            local headPitch = math.sin(p * 0.9) * 0.03
            local rArmAngle = 0
            local lArmAngle = 0
            local bodyLeanZ = 0
            
            -- Personality base idle variation
            if r.personality == "chat" then
                -- Conversational pair: tilt head toward partner, small nods and arm gesture
                local chatTurn = (idx % 2 == 0) and 0.28 or -0.28
                headYaw = chatTurn + math.sin(p * 2.2) * 0.12
                rArmAngle = math.sin(p * 2.2) * 0.20
            elseif r.personality == "watch" then
                -- Impatiently checking watch
                headPitch = math.rad(-22)
                lArmAngle = math.rad(78)
            end
            
            -- Dynamic Story Reactions:
            if isChadCollapsed then
                -- REACTION 5: Chad collapsed under road salt!
                -- Entire crowd celebrates, laughs, and points!
                local dirToChad = (chadPos - r.homePos).Unit
                local angleToChad = math.atan2(-dirToChad.X, -dirToChad.Z)
                headYaw = angleToChad - math.rad(r.laneYaw)
                local laughBob = math.sin(now * 9.0 + r.phase) * 0.16
                rArmAngle = math.rad(95) -- Pointing at Chad
                breath = breath + laughBob
                headPitch = math.sin(now * 9.0) * 0.08
                if r.faceDecal and r.faceDecal.Texture ~= FACES.grin and r.faceDecal.Texture ~= FACES.proud then
                    r.faceDecal.Texture = (idx % 2 == 0) and FACES.proud or FACES.grin
                end
            elseif isVendorAnnouncing then
                -- REACTION 4: Vendor calls Customer #50 at the back!
                -- ALL 47 extras pivot 3D head to look directly at Leo at Z=-4
                local leoPos = leoTemplate and leoTemplate:GetPivot().Position or Vector3.new(20, 3.5, -4)
                local headPos = r.m:FindFirstChild("Head") and r.m.Head.Position or r.homePos
                local dirToLeo = (leoPos - headPos).Unit
                local worldAngle = math.atan2(-dirToLeo.X, -dirToLeo.Z)
                headYaw = worldAngle - math.rad(r.laneYaw)
                headPitch = math.sin(p * 0.5) * 0.05
                if idx % 3 == 0 then
                    rArmAngle = math.rad(85) -- Several people point back to Leo
                end
                if r.faceDecal and r.faceDecal.Texture ~= FACES.shocked and r.faceDecal.Texture ~= FACES.grin then
                    r.faceDecal.Texture = (idx % 2 == 0) and FACES.shocked or FACES.grin
                end
            elseif isChadDancingAtCounter then
                -- REACTION 3: Chad boasts at counter
                -- Extras near front stare at counter in disgust
                if r.homePos.Z >= 6.0 then
                    headYaw = (r.laneYaw == 0) and 0 or math.rad(180)
                    rArmAngle = math.rad(65) -- Crossed arms / annoyed
                    lArmAngle = math.rad(65)
                end
            elseif isChadCharging then
                -- REACTION 2: Chad charging past
                local distToChad = (r.homePos - chadPos).Magnitude
                if distToChad < 4.5 then
                    local flinch = math.clamp((4.5 - distToChad) / 4.5, 0, 1)
                    breath = breath + flinch * 0.35 -- Raise arms defensively
                    headYaw = headYaw - flinch * 0.45 -- Turn head away from Chad's charge
                    rArmAngle = flinch * math.rad(75)
                    lArmAngle = flinch * math.rad(75)
                    if r.faceDecal and flinch > 0.4 then
                        r.faceDecal.Texture = FACES.scared
                    end
                elseif r.faceDecal and r.faceDecal.Texture ~= r.initialFace then
                    r.faceDecal.Texture = r.initialFace
                end
            else
                -- Normal idle face reset
                if r.faceDecal and r.faceDecal.Texture ~= r.initialFace then
                    r.faceDecal.Texture = r.initialFace
                end
            end
            
            r.rShoulder.C0 = r.baseR * CFrame.Angles(0, 0, breath + rArmAngle)
            r.lShoulder.C0 = r.baseL * CFrame.Angles(0, 0, -breath - lArmAngle)
            r.neck.C0 = r.baseN * CFrame.Angles(headPitch, headYaw, 0)
        end
        RunService.Heartbeat:Wait()
    end
end)

return { extras = #SLOTS, totalQueue = #SLOTS + 3 }
