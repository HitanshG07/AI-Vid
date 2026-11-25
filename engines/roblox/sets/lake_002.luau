--!nocheck
-- lake_002.luau : builds Set_Lake002 (story 002 ending, MANIFEST B3): frozen lake east of the street end + Set_Lake002.Props
-- (movable/hidden: HoleS1-3, HoleDrv, CrackS1-3, CrackVan, CrackDrv, WetS1-3, WetVan, WetDrv, Hand, CBRadioIce, Steam* emitters).
-- WORLD coords. Lake centre (1030, 0, 0), ROUND ice sheet radius 36 (X 994..1066), top Y 0.2, snow skin top Y 0.26.
-- The street's east end cap gets a gap (Z -3..11) in street_002_winter.luau; RampSnow joins the road to the ice.
-- Marks used by story002_cutscene.luau: Strider sink marks S1 (1018,-4) S2 (1022,6) S3 (1026,-10); van stop (1032,3) yaw -70;
-- driver hole (1058.5, 8); radio on ice (1039.6, 6.6). Idempotent. Yields every 200 parts.
local V, CF = Vector3.new, CFrame.new
local rad, sin, cos = math.rad, math.sin, math.cos
local C = Color3.fromRGB
local M = Enum.Material
local NAME = "Set_Lake002"
local old = workspace:FindFirstChild(NAME)
if old then old:Destroy() end
local set = Instance.new("Model")
set.Name = NAME
set.Parent = workspace
local props = Instance.new("Model")
props.Name = "Props"
local chunk, nChunk, count = nil, 0, 0
local function newChunk() nChunk += 1 chunk = Instance.new("Model") chunk.Name = "Chunk" .. nChunk end
newChunk()
local function flush() chunk.Parent = set newChunk() task.wait() end
local function part(name, sz, cf, mat, col, parent, o)
	local p = Instance.new("Part")
	p.Name, p.Size, p.CFrame = name, sz, cf
	p.Material, p.Color = mat or M.SmoothPlastic, col or C(150, 150, 150)
	p.Anchored = true
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	if parent then p.CanCollide = false end
	if o then for k, v in o do p[k] = v end end
	p.Parent = parent or chunk
	count += 1
	if not parent and count % 200 == 0 then flush() end
	return p
end
local function model(name) local m = Instance.new("Model") m.Name = name m.Parent = props return m end
local SNOW2 = C(242, 246, 250):Lerp(C(110, 125, 160), 0.45) -- night-tinted snow (same as the street set)
local DISC = CFrame.Angles(0, 0, rad(90))              -- Cylinder part axis X -> Y (flat disc)
local ICEC = C(191, 216, 232)

-- ================= ice, ground, ramp =================
part("LakeGround", V(160, 1, 220), CF(1080, -0.6, 0), M.Snow, SNOW2)
part("IceSheet", V(0.4, 72, 72), CF(1030, 0, 0) * DISC, M.Ice, ICEC, nil, { Shape = Enum.PartType.Cylinder })
part("SnowSkin", V(0.06, 72, 72), CF(1030, 0.23, 0) * DISC, M.Snow, C(238, 243, 248):Lerp(C(110, 125, 160), 0.3), nil, { Shape = Enum.PartType.Cylinder, Transparency = 0.25 })
part("RampSnow", V(8, 0.3, 14), CF(997.5, 0.1, 4), M.Snow, SNOW2)
-- windswept blue-grey patches on the skin
for i = 1, 9 do
	local a = i * 2.4
	part("IcePatch", V(0.03, 7 + (i % 3) * 3, 5 + (i % 4) * 2), CF(1030 + cos(a) * (6 + i * 2.6), 0.265, sin(a) * (4 + i * 2.5)) * DISC,
		M.Ice, C(150, 180, 205), nil, { Shape = Enum.PartType.Cylinder, Transparency = 0.5 })
end
-- snowbank shore ring + stepped pines (skipping the road entrance on the west side)
for i = 0, 35 do
	local a = i * 10
	if math.abs(a - 180) > 14 then
		local r = rad(a)
		part("ShoreBank", V(7, 2.4, 4.5), CF(1030 + cos(r) * 37.5, 0.9, sin(r) * 37.5) * CFrame.Angles(0, -r + math.pi / 2, 0), M.Snow, SNOW2)
	end
end
for i = 0, 43 do
	local a = i * (360 / 44)
	if math.abs(a - 180) > 16 then
		local r = rad(a)
		local rr = 43 + (i % 3) * 3.5
		local x, z = 1030 + cos(r) * rr, sin(r) * rr
		local h = 1 + (i % 4) * 0.22
		part("PineTrunk", V(1.2, 4 * h, 1.2), CF(x, 2 * h, z), M.Wood, C(70, 50, 35))
		for t = 1, 3 do
			local w = (8.5 - t * 1.9) * h
			local y = 4 * h + (t - 1) * 3 * h + 1.2
			part("PineTier", V(w, 3 * h, w), CF(x, y, z), M.Grass, C(46, 74, 58))
			part("PineSnow", V(w * 0.8, 0.4, w * 0.8), CF(x, y + 1.4 * h, z), M.Snow, SNOW2)
		end
	end
end
-- leaning THIN ICE sign (faces the road, -X)
local post = part("SignPost", V(0.4, 4, 0.4), CF(1001, 1.9, -6) * CFrame.Angles(0, 0, rad(12)), M.Wood, C(80, 55, 38))
local board = part("ThinIceSign", V(0.3, 1.6, 3.2), CF(1000.6, 3.7, -6) * CFrame.Angles(0, 0, rad(12)), M.Wood, C(200, 190, 170))
local g = Instance.new("SurfaceGui")
g.Face, g.SizingMode, g.CanvasSize, g.LightInfluence = Enum.NormalId.Left, Enum.SurfaceGuiSizingMode.FixedSize, Vector2.new(320, 160), 0
local l = Instance.new("TextLabel")
l.Size, l.BackgroundTransparency, l.Text, l.TextScaled, l.Font, l.TextColor3 = UDim2.fromScale(1, 1), 1, "THIN ICE", true, Enum.Font.FredokaOne, C(190, 30, 30)
l.Parent = g
g.Parent = board
chunk.Parent = set

-- ================= props (hidden until the cutscene reveals them) =================
local function hole(name, x, z, dia)
	local m = model(name)
	part("Disc", V(0.1, dia, dia), CF(x, 0.22, z) * DISC, M.Glass, C(5, 11, 18), m, { Shape = Enum.PartType.Cylinder, Transparency = 1 })
	for i = 1, 8 do
		local a = i * math.pi / 4
		part("Chunk", V(1.2, 0.35, 0.8), CF(x + cos(a) * (dia / 2 + 0.5), 0.4, z + sin(a) * (dia / 2 + 0.5)) * CFrame.Angles(0, -a, rad(25 + (i % 3) * 5)),
			M.Ice, C(215, 232, 242), m, { Transparency = 1 })
	end
	m.PrimaryPart = m:FindFirstChild("Disc")
end
hole("HoleS1", 1018, -4, 3.2)
hole("HoleS2", 1022, 6, 3.2)
hole("HoleS3", 1026, -10, 3.2)
hole("HoleDrv", 1058.5, 8, 2.8)
local function crack(name, x, z, radius)
	local m = model(name)
	for i = 1, 9 do
		local a = i * 40 + (i % 2) * 11
		local len = radius * (0.45 + 0.55 * (((i * 37) % 10) / 10))
		part("Line" .. i, V(0.16, 0.03, len), CF(x, 0.285, z) * CFrame.Angles(0, rad(a), 0) * CF(0, 0, -len / 2), M.Neon, C(225, 240, 255), m, { Transparency = 1 })
	end
end
crack("CrackS1", 1018, -4, 5)
crack("CrackS2", 1022, 6, 5)
crack("CrackS3", 1026, -10, 5)
crack("CrackVan", 1032, 3, 8)
crack("CrackDrv", 1058.5, 8, 5)
local function wet(name, x, z, dia) part(name, V(0.03, dia, dia), CF(x, 0.272, z) * DISC, M.SmoothPlastic, C(111, 135, 150), props, { Shape = Enum.PartType.Cylinder, Transparency = 1 }) end
wet("WetS1", 1018, -4, 6) wet("WetS2", 1022, 6, 6) wet("WetS3", 1026, -10, 6) wet("WetVan", 1032, 3, 14) wet("WetDrv", 1058.5, 8, 7)
-- steam emitters (Rate driven by the cutscene)
local SOFT = "rbxasset://textures/particles/smoke_main.dds"
local function steam(name, x, z)
	local p = part(name, V(0.5, 0.2, 0.5), CF(x, 0.35, z), M.SmoothPlastic, C(255, 255, 255), props, { Transparency = 1, CanQuery = false })
	local e = Instance.new("ParticleEmitter")
	e.Texture, e.Rate, e.EmissionDirection, e.Speed, e.Lifetime = SOFT, 0, Enum.NormalId.Top, NumberRange.new(2, 4), NumberRange.new(1.2, 1.8)
	e.SpreadAngle, e.Size, e.Acceleration, e.LightInfluence = Vector2.new(18, 18), NumberSequence.new(0.8, 2.6), V(0, 1.5, 0), 0.5
	e.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.45), NumberSequenceKeypoint.new(1, 1) })
	e.Color = ColorSequence.new(C(240, 244, 250))
	e.Parent = p
end
steam("SteamS1", 1018, -4) steam("SteamS2", 1022, 6) steam("SteamS3", 1026, -10) steam("SteamVan", 1032, 3) steam("SteamDrv", 1058.5, 8)
-- grey Strider hand + cuff (no body), hidden below the ice until the burst
local hand = model("Hand")
local HC = CF(1058.3, -3, 8.3)
local fore = part("Forearm", V(1, 2.6, 1), HC, M.SmoothPlastic, C(200, 200, 205), hand)
part("Cuff", V(1.15, 0.7, 1.15), HC * CF(0, -1.0, 0), M.SmoothPlastic, C(20, 20, 20), hand)
part("Palm", V(1.1, 0.5, 1.1), HC * CF(0, 1.5, 0), M.SmoothPlastic, C(200, 200, 205), hand)
for i = 1, 4 do
	local o = (i - 2.5) * 0.3
	part("Finger" .. i, V(0.22, 0.95, 0.25), HC * CF(o, 2.25, 0) * CFrame.Angles(0, 0, rad(-o * 70)), M.SmoothPlastic, C(200, 200, 205), hand)
end
hand.PrimaryPart = fore
-- handheld CB radio lying on the ice (VAN 7 sticker, red LED)
local radio = model("CBRadioIce")
local rb = part("Body", V(0.8, 1.4, 0.4), CF(1039.6, 0.75, 6.6), M.SmoothPlastic, C(17, 17, 17), radio)
part("Antenna", V(0.12, 0.8, 0.12), CF(1039.6 - 0.25, 1.8, 6.6), M.Metal, C(40, 40, 40), radio)
part("LED", V(0.2, 0.2, 0.2), CF(1039.6 + 0.2, 1.3, 6.6 - 0.22), M.Neon, C(255, 30, 30), radio, { Shape = Enum.PartType.Ball })
local rg = Instance.new("SurfaceGui")
rg.Face, rg.SizingMode, rg.CanvasSize, rg.LightInfluence = Enum.NormalId.Front, Enum.SurfaceGuiSizingMode.FixedSize, Vector2.new(160, 280), 0
local rl = Instance.new("TextLabel")
rl.Size, rl.BackgroundColor3, rl.Text, rl.TextScaled, rl.Font, rl.TextColor3 = UDim2.fromScale(0.8, 0.3), C(200, 40, 40), "VAN 7", true, Enum.Font.FredokaOne, C(255, 255, 255)
rl.Position = UDim2.fromScale(0.1, 0.6)
rl.Parent = rg
rg.Parent = rb
radio.PrimaryPart = rb
radio:PivotTo(CF(1039.6, 0.46, 6.6) * CFrame.Angles(rad(90), 0, rad(20)))
props.Parent = set
print(("[Set_Lake002] built: %d parts"):format(count))
return count
