--!nocheck
-- laundromat_002.luau : builds Set_Laundromat002 (story 002 interior, MANIFEST B2) + Set_Laundromat002.Movable
-- (Dryer3Door, HotSocks{SockL,SockR}, Crack, Dryer3Steam: driven by the cutscene).
-- LOCAL coords below = MANIFEST B2 coords minus (200,0,0); built at world origin (900, 0, 70), clear of Set_Street002:
-- interior world X 885..915, Y 0..14, Z 60..80, floor top 0.5. Glass front door world (900, 4.5, 80.5) faces +Z onto a
-- small street backdrop (snow pad Z 81..91, facade Z 94) so the glass shows a night street.
-- Idempotent. Yields every 200 parts; each chunk Model is parented into the live set as it completes.
local V, CF = Vector3.new, CFrame.new
local rad = math.rad
local C = Color3.fromRGB
local M = Enum.Material
local O = CF(900, 0, 70)
local NAME = "Set_Laundromat002"

local old = workspace:FindFirstChild(NAME)
if old then old:Destroy() end
local set = Instance.new("Model")
set.Name = NAME
set.Parent = workspace
local mov = Instance.new("Model")
mov.Name = "Movable"

local chunk, nChunk, count = nil, 0, 0
local function newChunk() nChunk += 1 chunk = Instance.new("Model") chunk.Name = "Chunk" .. nChunk end
newChunk()
local function flush() chunk.Parent = set newChunk() task.wait() end
local function part(name, sz, cf, mat, col, parent, opts)
	local p = Instance.new("Part")
	p.Name, p.Size, p.CFrame = name, sz, O * cf
	p.Material, p.Color = mat or M.SmoothPlastic, col or C(150, 150, 150)
	p.Anchored = true
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	if parent then p.CanCollide = false end
	if opts then for k, v in opts do p[k] = v end end
	p.Parent = parent or chunk
	count += 1
	if count % 200 == 0 then flush() end
	return p
end
local SOFT = "rbxasset://textures/particles/smoke_main.dds"
local function steam(p, rate, size, dir)
	local e = Instance.new("ParticleEmitter")
	e.Name, e.Texture, e.Rate, e.EmissionDirection = "Steam", SOFT, rate, dir or Enum.NormalId.Top
	e.Speed, e.Lifetime, e.SpreadAngle = NumberRange.new(2, 4), NumberRange.new(1.2, 2), Vector2.new(20, 20)
	e.Size = NumberSequence.new(size, size * 3)
	e.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1) })
	e.Color, e.LightInfluence, e.Acceleration = ColorSequence.new(C(245, 245, 250)), 0.5, V(0, 2, 0)
	e.Parent = p
	return e
end
local MINT, BLUE, METAL, AMBER = C(191, 227, 210), C(59, 91, 138), C(201, 205, 210), C(255, 170, 80)

-- floor: checker tiles 2x2 (top Y 0.5)
for x = -14, 14, 2 do
	for z = -9, 9, 2 do
		part("FloorTile", V(2, 0.5, 2), CF(x, 0.25, z), M.SmoothPlastic, ((x + 14) / 2 + (z + 9) / 2) % 2 == 0 and C(230, 230, 230) or C(154, 154, 154))
	end
end
-- walls (mint) + 3-stud blue wainscot; south wall has the 5x8 door opening at X -2.5..2.5
part("WallN", V(32, 15, 1), CF(0, 7.5, -10.5), M.SmoothPlastic, MINT)
part("WallW", V(1, 15, 22), CF(-15.5, 7.5, 0), M.SmoothPlastic, MINT)
part("WallE", V(1, 15, 22), CF(15.5, 7.5, 0), M.SmoothPlastic, MINT)
part("WallS_L", V(13.5, 15, 1), CF(-9.25, 7.5, 10.5), M.SmoothPlastic, MINT)
part("WallS_R", V(13.5, 15, 1), CF(9.25, 7.5, 10.5), M.SmoothPlastic, MINT)
part("WallS_Top", V(5, 6.5, 1), CF(0, 11.75, 10.5), M.SmoothPlastic, MINT)
part("Ceiling", V(32, 1, 22), CF(0, 14.5, 0), M.SmoothPlastic, C(240, 240, 236))
part("WainscotN", V(30, 3, 0.2), CF(0, 2, -9.9), M.WoodPlanks, BLUE)
part("WainscotW", V(0.2, 3, 20), CF(-14.9, 2, 0), M.WoodPlanks, BLUE)
part("WainscotE", V(0.2, 3, 20), CF(14.9, 2, 0), M.WoodPlanks, BLUE)
part("WainscotS_L", V(12.5, 3, 0.2), CF(-8.75, 2, 9.9), M.WoodPlanks, BLUE)
part("WainscotS_R", V(12.5, 3, 0.2), CF(8.75, 2, 9.9), M.WoodPlanks, BLUE)
-- glass front door (D12) + frame; back door drawn on the east wall
part("GlassDoor", V(5, 8, 0.3), CF(0, 4.5, 10.5), M.Glass, C(180, 210, 230), nil, { Transparency = 0.3 })
part("GlassDoorFrame", V(5.6, 0.4, 0.6), CF(0, 8.7, 10.5), M.Metal, C(160, 165, 170))
part("GlassDoorHandle", V(0.2, 1.2, 0.2), CF(1.8, 4.5, 10.2), M.Metal, C(200, 200, 205))
part("BackDoor", V(0.3, 7.5, 4), CF(14.85, 4.25, 0), M.Wood, C(90, 60, 40))
part("BackDoorSign", V(0.1, 0.8, 2), CF(14.7, 8.6, 0), M.Neon, C(60, 200, 90))
-- ceiling tube lights (G.laundro)
for _, x in { -8, 0, 8 } do
	local t = part("TubeLight", V(4, 0.3, 0.6), CF(x, 13.75, 0), M.Neon, C(255, 246, 224))
	local l = Instance.new("SurfaceLight")
	l.Face, l.Color, l.Brightness, l.Range, l.Angle = Enum.NormalId.Bottom, C(255, 240, 210), 0.8, 16, 120 -- 0.8 (was 2.5): blew out to white in take 1
	l.Parent = t
end

-- dryers (D11): bottom row X -10..10 at Y 2.5, top row Y 6.5, along Z -8.2; dryer #3 = bottom X 0 (hollow, door opens)
for _, x in { -10, -5, 0, 5, 10 } do
	for _, y in { 2.5, 6.5 } do
		if not (x == 0 and y == 2.5) then
			part("Dryer", V(4, 4, 3.5), CF(x, y, -8.2), M.Metal, METAL)
			local d = part("DryerDoor", V(0.2, 2.6, 2.6), CF(x, y, -6.35) * CFrame.Angles(0, rad(90), 0), M.Glass, AMBER, nil, { Shape = Enum.PartType.Cylinder, Transparency = 0.35 })
			if y == 2.5 then local l = Instance.new("PointLight") l.Color, l.Range, l.Brightness = AMBER, 4, 1 l.Parent = d end
			part("DryerPanel", V(3.6, 0.5, 0.1), CF(x, y + 1.6, -6.42), M.SmoothPlastic, C(60, 64, 70))
		end
	end
end
-- dryer #3 shell (hollow drum, dark inside)
part("Dryer3Top", V(4, 0.3, 3.5), CF(0, 4.35, -8.2), M.Metal, METAL)
part("Dryer3Bottom", V(4, 0.3, 3.5), CF(0, 0.65, -8.2), M.Metal, METAL) -- drum floor top 0.8
part("Dryer3SideL", V(0.3, 4, 3.5), CF(-1.85, 2.5, -8.2), M.Metal, METAL)
part("Dryer3SideR", V(0.3, 4, 3.5), CF(1.85, 2.5, -8.2), M.Metal, METAL)
part("Dryer3Back", V(4, 4, 0.3), CF(0, 2.5, -9.8), M.Metal, METAL)
part("Dryer3Drum", V(3.3, 3.3, 0.1), CF(0, 2.5, -9.6), M.DiamondPlate, C(60, 60, 64))
part("Dryer3FrontL", V(0.7, 4, 0.2), CF(-1.65, 2.5, -6.55), M.Metal, METAL)
part("Dryer3FrontR", V(0.7, 4, 0.2), CF(1.65, 2.5, -6.55), M.Metal, METAL)
part("Dryer3FrontT", V(2.6, 0.7, 0.2), CF(0, 4.15, -6.55), M.Metal, METAL)
part("Dryer3FrontB", V(2.6, 0.7, 0.2), CF(0, 0.85, -6.55), M.Metal, METAL)
part("Dryer3Panel", V(3.6, 0.5, 0.1), CF(0, 4.1, -6.42), M.SmoothPlastic, C(60, 64, 70))
local dl = part("Dryer3Glow", V(0.2, 0.2, 0.2), CF(0, 2.5, -8.6), M.SmoothPlastic, C(0, 0, 0), nil, { Transparency = 1, CanQuery = false })
local pl = Instance.new("PointLight") pl.Color, pl.Range, pl.Brightness = AMBER, 5, 1.2 pl.Parent = dl

-- furniture
part("FoldingTable", V(8, 0.4, 4), CF(8, 3.0, 0), M.SmoothPlastic, C(235, 235, 230))
for _, o in { { 4.4, -1.6 }, { 11.6, -1.6 }, { 4.4, 1.6 }, { 11.6, 1.6 } } do part("TableLeg", V(0.3, 2.5, 0.3), CF(o[1], 1.75, o[2]), M.Metal, C(120, 120, 125)) end
part("Basket", V(2, 1.2, 1.4), CF(9.5, 3.8, 0.3), M.Fabric, C(90, 150, 200))
for _, x in { -11, -8 } do
	part("ChairSeat", V(1.6, 0.3, 1.6), CF(x, 1.8, 4), M.SmoothPlastic, C(230, 120, 50))
	part("ChairBack", V(1.6, 1.8, 0.3), CF(x, 2.85, 4.75), M.SmoothPlastic, C(230, 120, 50))
	part("ChairLeg", V(1.2, 1.2, 1.2), CF(x, 1.1, 4), M.Metal, C(120, 120, 125), nil, { Transparency = 0.5 })
end
part("CoinMachine", V(2, 5, 1.5), CF(-13.5, 3, 4), M.Metal, C(200, 60, 60))
part("CoinMachineFace", V(1.4, 1.2, 0.1), CF(-13.5, 4, 3.2), M.Neon, C(255, 220, 120))
part("NoticeBoard", V(0.2, 3, 4), CF(14.85, 7, -4), M.Fabric, C(180, 140, 90))
for i, o in { { 7.6, -5.2 }, { 6.6, -3.6 }, { 7.3, -2.6 } } do
	part("Flyer" .. i, V(0.05, 0.9, 0.7), CF(14.72, o[1], o[2]), M.SmoothPlastic, i == 2 and C(255, 240, 150) or C(250, 250, 250))
end

-- street backdrop seen through the glass door (night street, snow pad for the Strider + prints)
part("BackdropSidewalk", V(40, 0.7, 13), CF(0, 0.35, 17.5), M.Snow, C(232, 238, 245)) -- top 0.7, Z 11..24
part("BackdropRoad", V(60, 0.3, 30), CF(0, 0.15, 30), M.Snow, C(225, 232, 240))
part("BackdropFacade", V(60, 22, 1), CF(0, 11, 24.5), M.Brick, C(120, 58, 48))
for _, x in { -12, -4, 6, 14 } do part("BackdropWindow", V(3, 3.6, 0.2), CF(x, 6, 23.9), M.Neon, C(150, 105, 60)) end
part("BackdropSideW", V(1, 22, 14), CF(-20, 11, 17.5), M.Brick, C(110, 55, 45))
part("BackdropSideE", V(1, 22, 14), CF(20, 11, 17.5), M.Brick, C(110, 55, 45))
part("BackdropBank", V(6, 3, 3), CF(7, 1.4, 16), M.Snow, C(242, 246, 250), nil, { Shape = Enum.PartType.Cylinder })
part("BackdropLampPole", V(0.6, 12, 0.6), CF(-7, 6, 16), M.Metal, C(40, 42, 45))
local bl = part("BackdropLampBulb", V(1.2, 1, 1.2), CF(-7, 11.5, 16), M.Neon, C(255, 240, 190))
local bll = Instance.new("PointLight") bll.Color, bll.Range, bll.Brightness = C(255, 220, 160), 20, 1.6 bll.Parent = bl

-- ================= Movable (cutscene-driven) =================
-- Dryer #3 door: disc + ring, hinge on its left (-X) edge; attribute Hinge = world hinge point
local door = Instance.new("Model") door.Name = "Dryer3Door" door.Parent = mov
local disc = part("Disc", V(0.2, 2.6, 2.6), CF(0, 2.5, -6.35) * CFrame.Angles(0, rad(90), 0), M.Glass, AMBER, door, { Shape = Enum.PartType.Cylinder, Transparency = 0.35 })
part("Ring", V(0.15, 2.9, 2.9), CF(0, 2.5, -6.4) * CFrame.Angles(0, rad(90), 0), M.Metal, C(170, 175, 180), door, { Shape = Enum.PartType.Cylinder })
part("Handle", V(0.2, 0.8, 0.3), CF(1.2, 2.5, -6.15), M.Metal, C(60, 60, 64), door)
door.PrimaryPart = disc
door:SetAttribute("Hinge", (O * CF(-1.3, 2.5, -6.35)).Position)
-- hot socks (D10) in the drum (drum floor top 0.8), steaming
local socks = Instance.new("Model") socks.Name = "HotSocks" socks.Parent = mov
local sl = part("SockL", V(1.1, 0.9, 1.25), CF(-0.5, 1.25, -8.4) * CFrame.Angles(0, rad(20), rad(80)), M.Fabric, C(179, 32, 42), socks)
part("SockR", V(1.1, 0.9, 1.25), CF(0.6, 1.25, -8.0) * CFrame.Angles(0, rad(-30), rad(85)), M.Fabric, C(179, 32, 42), socks)
steam(sl, 4, 0.3)
-- steam rolling out of dryer #3 (Rate set by the cutscene once the door opens)
steam(part("Dryer3Steam", V(2, 0.2, 1), CF(0, 2.5, -6.0), M.SmoothPlastic, C(255, 255, 255), mov, { Transparency = 1, CanQuery = false }), 0, 0.8, Enum.NormalId.Back)
-- glass crack (hidden until beat 31): thin white lines on the inside face of the glass, radiating from (0.8, 5.5)
local crack = Instance.new("Model") crack.Name = "Crack" crack.Parent = mov
for i = 1, 7 do
	local a = rad(i * 51 + 10)
	local len = 1.2 + (i % 3) * 0.9
	part("Line" .. i, V(0.07, len, 0.05), CF(0.8 + math.cos(a) * len / 2, 5.5 + math.sin(a) * len / 2, 10.3) * CFrame.Angles(0, 0, a - math.pi / 2),
		M.Neon, C(235, 245, 255), crack, { Transparency = 1, CanQuery = false })
end

chunk.Parent = set
mov.Parent = set
print(("[Set_Laundromat002] built: %d parts in %d chunks, origin world (900,0,70)"):format(count, nChunk))
return count
