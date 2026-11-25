--!nocheck
-- street_002_winter.luau : builds Set_Street002 (story 002 "Footsteps Glow With Heat", winter Main Street at night)
-- plus Set_Street002.Props002 (movable props the cutscene drives: NightVan, Cat, HotBottle, IceBootL/R, Radio, DriverCap,
-- CBMic, RoofDebris, Bread).
-- Standalone street builder (LOCAL coords below = MANIFEST B1 coords), built at the
-- empty area around world origin (900, 0, 0): world X = local X + 900, world Z = local Z. Road X 840..995, Z -5..5.
-- Run once via execute_luau (idempotent: destroys the old set first). Yields every 200 parts; each chunk Model is
-- parented into the live set as it completes (Studio froze on one-shot builds).
local V, CF = Vector3.new, CFrame.new
local rad = math.rad
local C = Color3.fromRGB
local M = Enum.Material
local O = CF(900, 0, 0)
local NAME = "Set_Street002"

local old = workspace:FindFirstChild(NAME)
if old then old:Destroy() end
local set = Instance.new("Model")
set.Name = NAME
set.Parent = workspace
local props = Instance.new("Model") -- parented at the very end
props.Name = "Props002"

local chunk, nChunk, count = nil, 0, 0
local function newChunk() nChunk += 1 chunk = Instance.new("Model") chunk.Name = "Chunk" .. nChunk end
newChunk()
local function flush() chunk.Parent = set newChunk() task.wait() end

local night -- defined below SNOW (forward decl)
local function part(name, sz, cf, mat, col, parent, opts)
	local p = Instance.new("Part")
	p.Name, p.Size, p.CFrame = name, sz, O * cf
	p.Material, p.Color = mat or M.Concrete, col or C(150, 150, 150)
	if p.Material == M.Snow then p.Color = night(p.Color) end
	p.Anchored = true
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	if parent then p.CanCollide = false end -- props never collide
	if opts then for k, v in opts do p[k] = v end end
	p.Parent = parent or chunk
	count += 1
	if count % 200 == 0 then flush() end
	return p
end
local function model(name, parent) local m = Instance.new("Model") m.Name = name m.Parent = parent or props return m end
local function sign(p, face, text, col, w, h, bg)
	local g = Instance.new("SurfaceGui")
	g.Face, g.SizingMode, g.CanvasSize, g.LightInfluence = face, Enum.SurfaceGuiSizingMode.FixedSize, Vector2.new(w, h), 0
	local l = Instance.new("TextLabel")
	l.Size, l.BackgroundTransparency, l.Text, l.TextScaled = UDim2.fromScale(1, 1), bg and 0 or 1, text, true
	l.BackgroundColor3, l.Font, l.TextColor3 = bg or C(0, 0, 0), Enum.Font.FredokaOne, col
	l.Parent = g
	g.Parent = p
end
local SOFT = "rbxasset://textures/particles/smoke_main.dds"
local function steam(p, rate, size)
	local e = Instance.new("ParticleEmitter")
	e.Name, e.Texture, e.Rate, e.EmissionDirection = "Steam", SOFT, rate, Enum.NormalId.Top
	e.Speed, e.Lifetime, e.SpreadAngle = NumberRange.new(2, 4), NumberRange.new(1.2, 2), Vector2.new(15, 15)
	e.Size = NumberSequence.new(size or 1, (size or 1) * 3)
	e.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 1) })
	e.Color, e.LightInfluence, e.Acceleration = ColorSequence.new(C(240, 244, 250)), 0.5, V(0, 1.5, 0)
	e.Parent = p
	return e
end
local function light(p, col, range, br, cls)
	local l = Instance.new(cls or "PointLight")
	l.Color, l.Range, l.Brightness = col, range, br
	l.Parent = p
	return l
end

local SNOW, SNOW2 = C(232, 238, 245), C(242, 246, 250)
night = function(c) return c:Lerp(C(110, 125, 160), 0.45) end -- Snow reads white at night: tint blue-grey (Studio tweak, now reproducible)
local WARMWIN = C(150, 105, 60) -- dim warm Neon (blooms softly at Threshold 0.9)

-- ================= ground, road, sidewalks =================
part("GroundSnow", V(200, 1, 200), CF(0, -0.6, 0), M.Snow, SNOW) -- world X 800..1000, Z -100..100, top -0.1 (parking area too)
part("RoadAsphalt", V(155, 1, 12), CF(17.5, -0.5, 0), M.Concrete, C(45, 47, 52))
part("SnowRoad", V(155, 0.3, 10), CF(17.5, 0.15, 0), M.Snow, SNOW) -- road walk floor Y 0.3
for x = -56, 92, 8 do -- yellow centre stripe faintly showing through the snow
	part("RoadStripe", V(4, 0.02, 0.4), CF(x, 0.31, 0), M.SmoothPlastic, C(240, 210, 60), nil, { Transparency = 0.6 })
end
for _, s in { -1, 1 } do
	local tag = s < 0 and "North" or "South"
	part("Sidewalk" .. tag, V(155, 1.4, 12), CF(17.5, -0.3, 12 * s), M.Concrete, C(175, 172, 168))
	part("SidewalkSnow" .. tag, V(155, 0.3, 12), CF(17.5, 0.55, 12 * s), M.Snow, SNOW) -- walk floor Y 0.7
	part("Curb" .. tag, V(155, 1.6, 0.8), CF(17.5, -0.2, 5.6 * s), M.Concrete, C(130, 128, 125))
end

-- ================= buildings (+ roof snow; Strider roof floors: N1 28.0, N2 32.0, N3 26.0) =================
local B = {
	{ "BuildingN1_Bakery", V(45, 28, 8), V(-35, 13.5, -22), M.Brick, C(145, 68, 55) },
	{ "BuildingN2_Stone", V(35, 32, 8), V(5, 15.5, -22), M.Cobblestone, C(120, 125, 130) },
	{ "BuildingN3_Laundromat", V(45, 26, 8), V(42, 12.5, -22), M.Concrete, C(180, 165, 145) },
	{ "BuildingN4_Brick", V(32, 24, 8), V(80.5, 11.5, -22), M.Brick, C(110, 62, 50) },
	{ "BuildingS1_Home", V(60, 28, 8), V(-25, 13.5, 22), M.Brick, C(120, 58, 48) },
	{ "BuildingS2", V(65, 30, 8), V(35, 14.5, 22), M.Concrete, C(165, 160, 150) },
	{ "BuildingS3", V(28, 26, 8), V(81.5, 12.5, 22), M.Brick, C(132, 80, 60) },
}
for _, b in B do
	part(b[1], b[2], CF(b[3]), b[4], b[5])
	part(b[1] .. "_RoofSnow", V(b[2].X, 0.5, b[2].Z), CF(b[3].X, b[3].Y + b[2].Y / 2 + 0.25, b[3].Z), M.Snow, SNOW2)
	part(b[1] .. "_Cornice", V(b[2].X, 0.6, 0.6), CF(b[3].X, b[3].Y + b[2].Y / 2 - 0.3, b[3].Z + (b[3].Z < 0 and 4.2 or -4.2)), M.Concrete, C(90, 88, 86))
	-- upper-floor lit windows on the street face
	local fz = b[3].Z < 0 and -17.9 or 17.9
	local top = b[3].Y + b[2].Y / 2
	for wx = b[3].X - b[2].X / 2 + 5, b[3].X + b[2].X / 2 - 4, 7 do
		for wy = 14, top - 5, 7 do
			part("UpperWindow", V(3, 3.6, 0.2), CF(wx, wy, fz), M.Neon, ((wx + wy) % 3 < 1) and C(40, 44, 60) or WARMWIN)
			part("WindowSill", V(3.6, 0.3, 0.5), CF(wx, wy - 2, fz + (fz < 0 and 0.2 or -0.2)), M.Snow, SNOW2)
		end
	end
end
part("EndCapWest", V(8, 30, 60), CF(-58, 14.5, 0), M.Concrete, C(130, 130, 135))
part("EndCapEastN", V(8, 30, 27), CF(96, 14.5, -16.5), M.Concrete, C(130, 130, 135)) -- gap Z -3..11: van road runs on to the frozen lake (lake_002.luau)
part("EndCapEastS", V(8, 30, 19), CF(96, 14.5, 20.5), M.Concrete, C(130, 130, 135))

-- ================= shopfronts (lit backing behind glass) =================
local function shop(name, x, w, amber)
	local back = part(name .. "Backing", V(w, 7.6, 0.2), CF(x, 4.5, -18.05), M.SmoothPlastic, C(255, 205, 150))
	light(back, C(255, 200, 140), 12, 2, "SurfaceLight").Face = Enum.NormalId.Back
	part(name, V(w, 8, 0.4), CF(x, 4.5, -17.75), M.Glass, C(180, 210, 230), nil, { Transparency = 0.4 })
	part(name .. "Frame", V(w + 0.6, 0.5, 0.6), CF(x, 8.7, -17.7), M.Wood, C(60, 40, 30))
	part(name .. "Sill", V(w + 0.6, 0.6, 0.8), CF(x, 0.6, -17.6), M.Snow, SNOW2)
	if amber then -- dryers glowing through the laundromat window
		for i = 1, amber do
			part("DryerGlow", V(0.1, 2.4, 2.4), CF(x - w / 2 + i * w / (amber + 1), 3.4, -17.98) * CFrame.Angles(0, rad(90), 0), M.Neon, C(255, 170, 80), nil, { Shape = Enum.PartType.Cylinder })
		end
	end
end
shop("ShopWindow1", -46, 12)            -- bakery window (shatters on beat 10)
shop("ShopWindow2", 5, 12)
shop("ShopWindow3", 30, 10, 3)          -- laundromat window, 3 amber dryers
shop("ShopWindow4", 80, 12)
-- bakery door (-35) and laundromat glass door (42) per MANIFEST B1
part("BakeryDoor", V(5, 8, 0.3), CF(-35, 4.7, -17.85), M.Wood, C(90, 55, 35))
part("BakeryDoorWindow", V(3, 3, 0.35), CF(-35, 6, -17.85), M.Neon, WARMWIN)
local lb = part("LaundroDoorBacking", V(5.2, 8, 0.2), CF(42, 4.7, -18.1), M.SmoothPlastic, C(70, 60, 50))
light(lb, C(255, 190, 120), 10, 1.5, "SurfaceLight").Face = Enum.NormalId.Back
part("LaundroDoorDryer", V(0.1, 2.4, 2.4), CF(42, 3.2, -18.0) * CFrame.Angles(0, rad(90), 0), M.Neon, C(255, 170, 80), nil, { Shape = Enum.PartType.Cylinder })
part("LaundroGlassDoor", V(5, 8, 0.3), CF(42, 4.7, -17.85), M.Glass, C(180, 210, 230), nil, { Transparency = 0.3 })
part("LaundroDoorFrame", V(5.6, 0.4, 0.5), CF(42, 8.9, -17.8), M.Metal, C(160, 165, 170))
-- dryer vent with steam (D17)
part("DryerVent", V(1, 1.5, 1.5), CF(48, 6, -17.6) * CFrame.Angles(0, rad(90), 0), M.Metal, C(170, 175, 180), nil, { Shape = Enum.PartType.Cylinder })
steam(part("DryerVentSteam", V(1, 0.2, 1), CF(48, 6, -16.8), M.SmoothPlastic, C(255, 255, 255), nil, { Transparency = 1, CanQuery = false }), 15, 1)
-- awnings with snow ridges
for _, a in { { -40, 20, C(30, 75, 120) }, { 5, 14, C(140, 45, 40) }, { 37, 18, C(35, 100, 60) }, { 80, 14, C(120, 90, 40) } } do
	local cf = CF(a[1], 9.4, -16) * CFrame.Angles(rad(15), 0, 0)
	part("Awning", V(a[2], 1.2, 5), cf, M.Fabric, a[3])
	part("AwningSnow", V(a[2], 0.3, 5), cf * CF(0, 0.75, 0), M.Snow, SNOW2)
end
-- signs (SurfaceGui on the street-facing Back face, FixedSize per LESSONS)
local s1 = part("SignBakery", V(16, 2.6, 0.3), CF(-40, 11.8, -17.75), M.Wood, C(70, 40, 25))
sign(s1, Enum.NormalId.Back, "BAKERY", C(255, 225, 160), 640, 104)
local s3 = part("SignLaundromat", V(16, 2.6, 0.3), CF(37, 11.8, -17.75), M.Wood, C(30, 60, 70))
sign(s3, Enum.NormalId.Back, "LAUNDROMAT 24H", C(160, 255, 230), 640, 104)
local s2 = part("SignStore", V(12, 2.2, 0.3), CF(5, 11.6, -17.75), M.Wood, C(60, 50, 40))
sign(s2, Enum.NormalId.Back, "GENERAL STORE", C(255, 240, 200), 560, 102)

-- ================= streetlamps (standard streetlamp layout + 2 east) =================
for i, lx in { -40, -15, 10, 35, 60, 85 } do
	part("LampPole_" .. i, V(0.6, 12, 0.6), CF(lx, 5.5, -6.5), M.Metal, C(40, 42, 45))
	part("LampArm_" .. i, V(0.5, 0.5, 2.5), CF(lx, 11.2, -7.5), M.Metal, C(40, 42, 45))
	part("LampCapSnow_" .. i, V(1.5, 0.3, 1.5), CF(lx, 11.55, -8.5), M.Snow, SNOW2)
	local bulb = part("LampBulb_" .. i, V(1.2, 1.0, 1.2), CF(lx, 10.8, -8.5), M.Neon, C(255, 240, 190))
	light(bulb, C(255, 220, 160), 22, 0.7).Shadows = true
end

-- ================= bare winter trees =================
for i, tx in { -28, 22 } do
	part("Planter_" .. i, V(4, 1.2, 4), CF(tx, 0.5, -6.5), M.Concrete, C(110, 108, 105))
	part("PlanterSnow_" .. i, V(3.8, 0.4, 3.8), CF(tx, 1.25, -6.5), M.Snow, SNOW2)
	part("Trunk_" .. i, V(1.0, 10, 1.0), CF(tx, 5.5, -6.5), M.Wood, C(70, 50, 35))
	part("TrunkBranchA_" .. i, V(0.5, 5, 0.5), CF(tx + 1.4, 10.5, -6.5) * CFrame.Angles(0, 0, rad(-35)), M.Wood, C(70, 50, 35))
	part("TrunkBranchB_" .. i, V(0.5, 4.5, 0.5), CF(tx - 1.2, 11, -6.2) * CFrame.Angles(rad(15), 0, rad(30)), M.Wood, C(70, 50, 35))
	for j, o in { V(1.9, 12.6, 0), V(-1.6, 12.8, 0.3), V(0, 10.6, 0) } do
		part("SnowClump_" .. i .. j, V(1.4, 0.7, 1.2), CF(tx + o.X, o.Y, -6.5 + o.Z), M.Snow, SNOW2)
	end
end

-- ================= snowbanks (D15). Bottle bank = local -4 (world 896,6.2); Theo's bank = local 8 (world 908,6.2) =================
for _, b in { { -52, -6.2 }, { -8, -6.2 }, { 47, -6.2 }, { -48, 6.2 }, { -14, 6.2 }, { -4, 6.2 }, { 8, 6.2 }, { 22, 6.2 }, { 44, 6.2 } } do
	part("Snowbank", V(6, 3, 3), CF(b[1], 1.0, b[2]), M.Snow, SNOW2, nil, { Shape = Enum.PartType.Cylinder })
	part("SnowbankBase", V(6.4, 0.8, 3.2), CF(b[1], 0.5, b[2]), M.Snow, SNOW2)
end

-- ================= Theo's porch (BuildingS1). Deck top Y 2.2 (X -30..-20, Z 13.8..17.8); steps X -30..-25 =================
part("PorchDeck", V(10, 1.5, 4), CF(-25, 1.45, 15.8), M.WoodPlanks, C(107, 74, 47))
part("PorchStep1", V(5, 0.9, 1.2), CF(-27.5, 1.15, 13.2), M.WoodPlanks, C(100, 70, 45))  -- top 1.6
part("PorchStep2", V(5, 0.45, 1.2), CF(-27.5, 0.925, 12.0), M.WoodPlanks, C(100, 70, 45)) -- top 1.15
part("PorchRail", V(5, 0.3, 0.3), CF(-22.5, 4.2, 13.95), M.Wood, C(230, 225, 215))           -- top 4.35 (radio sits on it)
part("PorchRailPost", V(0.3, 2.0, 0.3), CF(-24.85, 3.2, 13.95), M.Wood, C(230, 225, 215))
for _, x in { -29.75, -20.25 } do part("PorchPost", V(0.5, 7.0, 0.5), CF(x, 5.7, 14.05), M.Wood, C(230, 225, 215)) end
part("PorchRoof", V(11, 0.5, 5), CF(-25, 9.45, 15.6), M.WoodPlanks, C(80, 60, 45))
part("PorchRoofSnow", V(11, 0.35, 5), CF(-25, 9.87, 15.6), M.Snow, SNOW2)
local pb = part("PorchBulb", V(0.6, 0.6, 0.6), CF(-25, 8.9, 17.5), M.Neon, C(255, 220, 170))
light(pb, C(255, 210, 150), 12, 1.2)
part("FrontDoor", V(3.6, 6.4, 0.3), CF(-25, 5.4, 17.85), M.Wood, C(70, 40, 30))
part("FrontDoorKnob", V(0.3, 0.3, 0.3), CF(-23.7, 5.2, 17.65), M.Metal, C(220, 190, 90))
for _, x in { -31.5, -18.5 } do part("HomeWindow", V(3, 3, 0.2), CF(x, 5.5, 17.9), M.Neon, WARMWIN) end
-- ice-boot rack by the front door (D7) with two decorative pairs
part("BootRackShelf", V(3.6, 0.25, 1.0), CF(-28.5, 3.0, 16.9), M.Wood, C(107, 74, 47))
part("BootRackBack", V(3.6, 1.6, 0.2), CF(-28.5, 3.4, 17.45), M.Wood, C(107, 74, 47))
for _, x in { -30.2, -26.8 } do part("BootRackLeg", V(0.25, 0.8, 1.0), CF(x, 2.6, 16.9), M.Wood, C(90, 62, 40)) end
for _, x in { -29.8, -29.0, -28.0, -27.2 } do
	part("RackBootShaft", V(0.6, 0.7, 0.6), CF(x, 3.5, 16.95), M.Ice, C(91, 127, 166))
	part("RackBootSole", V(0.62, 0.22, 0.85), CF(x, 3.24, 16.85), M.SmoothPlastic, C(221, 230, 238))
end

-- ================= PROPS (movable; the cutscene drives them, CanCollide off) =================
-- Radio (D5) on the porch rail, LED + VAN 7 sticker on top
local radio = model("Radio")
local rbox = part("Box", V(1.6, 0.8, 1.0), CF(-21, 4.75, 13.95), M.Metal, C(184, 188, 194), radio)
part("FacePanel", V(1.4, 0.5, 0.05), CF(-21.15, 4.75, 13.43), M.SmoothPlastic, C(30, 30, 34), radio)
part("LED", V(0.18, 0.18, 0.18), CF(-20.45, 4.95, 13.42), M.Neon, C(255, 30, 30), radio, { Shape = Enum.PartType.Ball, Transparency = 0.75 })
part("Antenna", V(0.08, 1.2, 0.08), CF(-21.6, 5.75, 14.2), M.Metal, C(40, 40, 40), radio)
sign(rbox, Enum.NormalId.Top, "VAN 7", C(255, 255, 255), 160, 100, C(200, 40, 40))
radio.PrimaryPart = rbox

-- Cat (D9): orange, faces -Z, floor 0.7 at world (906, -9)
local cat = model("Cat")
local OR, ORD = C(232, 137, 43), C(190, 100, 30)
local cb = part("Body", V(0.7, 0.8, 1.4), CF(6, 1.45, -9), M.SmoothPlastic, OR, cat)
for _, z in { -9.3, -8.7 } do part("Stripe", V(0.72, 0.82, 0.18), CF(6, 1.45, z), M.SmoothPlastic, ORD, cat) end
part("Head", V(0.75, 0.7, 0.7), CF(6, 1.8, -9.95), M.SmoothPlastic, OR, cat)
for _, x in { -0.22, 0.22 } do
	part("Ear", V(0.2, 0.3, 0.2), CF(6 + x, 2.28, -9.95) * CFrame.Angles(0, rad(45), 0), M.SmoothPlastic, ORD, cat)
	part("Eye", V(0.12, 0.14, 0.05), CF(6 + x * 0.8, 1.9, -10.31), M.SmoothPlastic, C(20, 20, 20), cat)
end
part("Nose", V(0.12, 0.08, 0.05), CF(6, 1.74, -10.31), M.SmoothPlastic, C(240, 140, 150), cat)
for _, o in { { -0.22, -0.5 }, { 0.22, -0.5 }, { -0.22, 0.5 }, { 0.22, 0.5 } } do
	part("Leg", V(0.22, 0.4, 0.22), CF(6 + o[1], 0.9, -9 + o[2]), M.SmoothPlastic, OR, cat)
end
part("Tail", V(0.2, 0.2, 1.1), CF(6, 1.95, -8.2) * CFrame.Angles(rad(-35), 0, 0), M.SmoothPlastic, ORD, cat)
cat.PrimaryPart = cb

-- Hot-water bottle (D8), steams
local hb = model("HotBottle")
local hbb = part("Body", V(1.1, 1.5, 0.4), CF(-23.5, 2.95, 14.6), M.SmoothPlastic, C(192, 57, 43), hb)
part("Cap", V(0.35, 0.3, 0.35), CF(-23.5, 3.85, 14.6), M.SmoothPlastic, C(30, 30, 30), hb)
steam(hbb, 4, 0.3)
hb.PrimaryPart = hbb

-- Ice boots (D6), pivot = shaft centre (sole bottom 0.9 below). Home: porch floor by the rack.
for i, nm in { "IceBootL", "IceBootR" } do
	local bm = model(nm)
	local x = -27.4 + (i - 1) * 1.3
	local sh = part("Shaft", V(1.15, 1.1, 1.15), CF(x, 3.1, 16.4), M.Ice, C(91, 127, 166), bm)
	part("Sole", V(1.2, 0.4, 1.6), CF(x, 2.4, 16.2), M.SmoothPlastic, C(221, 230, 238), bm)
	part("FurTop", V(1.25, 0.25, 1.25), CF(x, 3.65, 16.4), M.Fabric, C(245, 245, 245), bm)
	bm.PrimaryPart = sh
end

-- Bakery roof debris (D13): 12 brick chunks + 4 snow slabs on the roof front edge (bakery roof Y 27.5..28.0)
local deb = model("RoofDebris")
for i = 1, 16 do
	local s = 1 + (i * 7 % 5) * 0.25
	local snow = i > 12
	part("Debris" .. i, snow and V(2, 0.4, 1.4) or V(s, s * 0.7, s * 0.8), CF(-32 + ((i * 5) % 9) - 4, 28.2 + (i % 3) * 0.3, -18.8 - (i % 2) * 0.6),
		snow and M.Snow or M.Brick, snow and SNOW2 or C(145, 80, 55), deb)
end
-- Bread loaves (D14) in the rubble, shown from beat 10
local bread = model("Bread")
for i = 1, 5 do
	part("Loaf" .. i, V(1.2, 0.6, 0.6), CF(-35 + (i - 3) * 1.6, 1.0, -14.5 + (i % 2) * 0.9) * CFrame.Angles(0, rad(i * 37), 0), M.SmoothPlastic, C(198, 134, 66), bread)
end

-- Driver cap + CB mic (D4)
local cap = model("DriverCap")
local crown = part("Crown", V(1.15, 0.5, 1.15), CF(-85, 12, -60), M.Fabric, C(120, 80, 40), cap)
part("Brim", V(1.1, 0.12, 0.7), CF(-85, 11.8, -60.75), M.Fabric, C(100, 65, 30), cap)
cap.PrimaryPart = crown
part("CBMic", V(0.4, 0.7, 0.25), CF(-85, 12, -58), M.SmoothPlastic, C(17, 17, 17), props)

-- NIGHT VAN (D2 + D3 cab). Van-local: +X forward, wheel bottoms at y 0, lane Z 2.5 when driving.
-- Pivot = Root (van-local origin). Home: world (815, 0.3, -60), hidden behind the west end cap.
local van = model("NightVan")
local VC = CF(-85, 0.3, -60)
local BLUE, DARK = C(47, 93, 138), C(42, 42, 42)
local function vp(name, sz, x, y, z, mat, col, rot, opts) return part(name, sz, VC * CF(x, y, z) * (rot or CFrame.identity), mat, col, van, opts) end
local root = vp("Root", V(1, 1, 1), 0, 0, 0, M.SmoothPlastic, DARK, nil, { Transparency = 1, CanQuery = false })
van.PrimaryPart = root
local cargo = vp("Cargo", V(10, 6.6, 7), -2, 4.6, 0, M.SmoothPlastic, BLUE)
for _, f in { Enum.NormalId.Front, Enum.NormalId.Back } do sign(cargo, f, "VAN 7", C(255, 255, 255), 500, 330) end
sign(cargo, Enum.NormalId.Top, "VAN 7", C(255, 255, 255), 500, 350)
vp("CargoStripe", V(10.05, 0.6, 7.05), -2, 2.4, 0, M.SmoothPlastic, C(235, 235, 235))
vp("RearDoorLine", V(0.05, 6, 0.1), -7.03, 4.6, 0, M.SmoothPlastic, C(20, 30, 45))
vp("CabFloor", V(4.2, 0.4, 7), 5.1, 1.5, 0, M.SmoothPlastic, BLUE)
vp("Hood", V(1.0, 2.6, 7), 6.7, 2.6, 0, M.SmoothPlastic, BLUE)
vp("Grille", V(0.1, 1.2, 4), 7.25, 2.4, 0, M.SmoothPlastic, C(25, 25, 25))
vp("Windscreen", V(0.25, 3.2, 6.6), 6.9, 5.4, 0, M.Glass, C(170, 200, 220), nil, { Transparency = 0.65 })
local roof = vp("CabRoof", V(4.6, 0.4, 7), 5.0, 7.2, 0, M.SmoothPlastic, BLUE) -- underside 7.0, top 7.4
light(roof, C(180, 200, 255), 6, 1)
vp("DoorL", V(4, 2.8, 0.3), 5.0, 3.0, -3.35, M.SmoothPlastic, BLUE) -- driver side (-Z): window open above
vp("PillarL", V(0.4, 2.6, 0.3), 6.8, 5.7, -3.35, M.SmoothPlastic, BLUE)
vp("DoorR", V(4, 2.8, 0.3), 5.0, 3.0, 3.35, M.SmoothPlastic, BLUE)
vp("WindowR", V(4, 2.6, 0.25), 5.0, 5.7, 3.35, M.Glass, C(170, 200, 220), nil, { Transparency = 0.6 })
vp("PillarR", V(0.4, 2.6, 0.3), 6.8, 5.7, 3.35, M.SmoothPlastic, BLUE)
local dash = vp("Dashboard", V(1.0, 1.0, 6.4), 6.1, 3.6, 0, M.SmoothPlastic, DARK)
sign(dash, Enum.NormalId.Left, "VAN 7", C(255, 255, 255), 640, 100)
vp("SteeringWheel", V(0.2, 1.5, 1.5), 5.4, 4.3, -1.6, M.SmoothPlastic, C(25, 25, 25), CFrame.Angles(0, 0, rad(-25)), { Shape = Enum.PartType.Cylinder })
vp("CBUnit", V(0.8, 0.4, 0.6), 6.1, 4.3, 1.0, M.SmoothPlastic, C(30, 30, 30))
vp("CBUnitLED", V(0.1, 0.1, 0.1), 5.68, 4.35, 1.0, M.Neon, C(255, 40, 40))
for _, z in { -1.6, 1.6 } do
	vp("Seat", V(1.6, 1.0, 1.8), 4.3, 1.9, z, M.Fabric, C(50, 45, 40)) -- seat top 2.4
	vp("SeatBack", V(0.4, 2.6, 1.8), 3.4, 3.7, z, M.Fabric, C(50, 45, 40))
end
for _, x in { -4.5, 4.5 } do
	for _, z in { -3.1, 3.1 } do
		vp("Tyre", V(1.0, 2.4, 2.4), x, 1.2, z, M.SmoothPlastic, C(26, 26, 26), CFrame.Angles(0, rad(90), 0), { Shape = Enum.PartType.Cylinder })
		vp("Hubcap", V(1.05, 1.0, 1.0), x, 1.2, z, M.Metal, C(180, 180, 185), CFrame.Angles(0, rad(90), 0), { Shape = Enum.PartType.Cylinder })
	end
end
vp("BumperF", V(0.4, 0.6, 7), 7.3, 1.4, 0, M.Metal, C(150, 150, 155))
vp("BumperR", V(0.4, 0.6, 7), -7.15, 1.4, 0, M.Metal, C(150, 150, 155))
vp("BackStep", V(1.2, 0.4, 4), -7.6, 1.0, 0, M.DiamondPlate, C(150, 150, 155)) -- top 1.2 (world 1.5)
vp("GrabRail", V(0.2, 4, 0.2), -7.1, 4.2, 1.9, M.Metal, C(190, 190, 195))
for _, z in { -2.9, 2.9 } do
	light(vp("TailLight", V(0.2, 0.8, 1.0), -7.1, 2.8, z, M.Neon, C(255, 30, 20)), C(255, 40, 30), 8, 1)
	vp("HeadLight", V(0.2, 0.8, 1.2), 7.25, 2.9, z * 0.9, M.Neon, C(255, 245, 220))
end
local hl = vp("HeadBeam", V(0.2, 0.2, 0.2), 7.3, 2.9, 0, M.SmoothPlastic, DARK, nil, { Transparency = 1, CanQuery = false })
local sl = light(hl, C(255, 240, 200), 35, 2, "SpotLight")
sl.Face, sl.Angle = Enum.NormalId.Right, 50
steam(vp("RoofSteam", V(6, 0.2, 5), -2, 8.0, 0, M.SmoothPlastic, C(255, 255, 255), nil, { Transparency = 1, CanQuery = false }), 15, 1)

chunk.Parent = set
props.Parent = set
print(("[Set_Street002] built: %d parts in %d chunks, origin world (900,0,0)"):format(count, nChunk))
return count
