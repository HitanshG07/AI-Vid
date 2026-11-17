--!nocheck
-- story007_cutscene.luau : stages + plays Story 007 "Wrist Rewind" (2 parts) in Roblox Studio EDIT mode.
-- Run this file once via execute_luau; it defines _G.Story007 = { play(part), reset(), test(), setMode(m) }.
-- play() blocks for the part length, so start it with: task.spawn(_G.Story007.play, 1)
-- No Animator/AnimationTrack: joints are driven per frame (AnimationConstraint Attachment0 offset or Transform).
local SS = game:GetService("ServerStorage")
local Lighting = game:GetService("Lighting")
local WS = workspace
local V, CF = Vector3.new, CFrame.new
local rad, sin, cos, abs, clamp = math.rad, math.sin, math.cos, math.abs, math.clamp

-- ================= knobs (calibrate after the first visual check) =================
local LEAD, TAIL = 0.3, 0.4
local LEN = { 49.7, 51.6 }
local ROLL = CFrame.Angles(0, 0, rad(90))        -- vertical-video roll (landscape window rotated later)
local JOINT_MODE = "attachment"                  -- "attachment" | "transform" (see test())
local WAIST = 4.4                                -- bench top height that suits a 6-stud kid; higher benches get a riser
local SIT_DY = -0.6                              -- Grandma pivot drop when seated
local HOLD_OFF = CF(0, -0.55, -0.1)              -- bottle in Jace's RightHand
local PHONE_OFF = CF(0, -0.25, -0.2) * CFrame.Angles(rad(-80), 0, 0) -- phone in Jace's LeftHand
local PENCIL_OFF = CF(0, -0.25, -0.15) * CFrame.Angles(0, rad(90), 0)
local AGED = Color3.fromRGB(150, 128, 110)       -- full-aged hand tint
local OFF = CF(0, -300, -1000)                   -- off-stage

local function ease(x) x = clamp(x, 0, 1) return x * x * (3 - 2 * x) end
local function seg(u, a, b) return ease((u - a) / (b - a)) end
local function lerp(a, b, x) return a + (b - a) * x end
local function tapc(u, at) return clamp(1 - abs(u - at) / 0.07, 0, 1) end
local function flashAt(u, at, d) return clamp(1 - abs((u - at) * d) / 0.15, 0, 1) end

-- ================= rigs =================
local R = {}
local Hr, Mi, Ja, Te, Gr, LH
local EX = {}

local function register(m, prefix)
	local r = { m = m, prefix = prefix, joints = {}, off = {}, tint = {}, ph = (#m.Name * 1.7) % 6 }
	for _, d in m:GetDescendants() do
		if d:IsA("AnimationConstraint") and d.Attachment0 and d.Attachment1 then
			local a0 = d.Attachment0
			local base = a0:GetAttribute("S7Base")
			if not base then base = a0.CFrame a0:SetAttribute("S7Base", base) end
			r.joints[d.Attachment1.Parent.Name] = { c = d, a0 = a0, base = base }
		elseif d:IsA("Motor6D") and d.Part1 then
			local base = d:GetAttribute("S7Base")
			if not base then base = d.C0 d:SetAttribute("S7Base", base) end
			r.joints[d.Part1.Name] = { m6 = d, base = base }
		end
	end
	r.head = m:FindFirstChild("Head")
	local pv = m:GetAttribute("S7Pivot")
	if not pv then pv = m:GetPivot() m:SetAttribute("S7Pivot", pv) end
	r.pivot0 = pv
	local bcf, bsz = m:GetBoundingBox()
	r.baseY = m:GetPivot().Y - (bcf.Y - bsz.Y / 2)
	for _, pn in { "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm" } do
		local p = m:FindFirstChild(pn)
		local sa = p and p:FindFirstChildOfClass("SurfaceAppearance")
		if sa then
			local c0 = sa:GetAttribute("S7Col")
			if not c0 then c0 = sa.Color sa:SetAttribute("S7Col", c0) end
			r.tint[pn] = { sa = sa, c0 = c0, w = pn:find("Hand") and 1 or 0.4 }
		end
	end
	local hum = m:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
	end
	R[m.Name] = r
	return r
end

local function P(r, n, x, y, z)
	if not r then return end
	r.off[n] = (r.off[n] or CFrame.identity) * CFrame.Angles(rad(x or 0), rad(y or 0), rad(z or 0))
end

local function applyJoints(r)
	for n, j in r.joints do
		local o = r.off[n] or CFrame.identity
		if j.m6 then j.m6.C0 = j.base * o
		elseif JOINT_MODE == "transform" then j.a0.CFrame = j.base j.c.Transform = o
		else j.a0.CFrame = j.base * o end
	end
	table.clear(r.off)
end

local function place(r, x, z, yaw, dy)
	if not r then return end
	if x == nil then r.m:PivotTo(OFF) return end
	r.m:PivotTo(CF(x, r.baseY + (dy or 0), z) * CFrame.Angles(0, rad(yaw or 0), 0))
end

local FACES = SS:FindFirstChild("ApprovedFaces")
local function setFace(r, emo)
	if not r or not r.head or r.emo == emo then return end
	r.emo = emo
	pcall(function()
		if r.swap then r.swap:Destroy() r.swap = nil end
		local src = emo and FACES and FACES:FindFirstChild(r.prefix .. "_" .. emo)
		if not src then r.head.Transparency = 0 return end
		local h = src:Clone()
		h.Name = "S7Face" h.Anchored = false h.CanCollide = false h.Massless = true
		if r.m.Name ~= r.prefix then h.Size = r.head.Size end -- scaled clones (LittleHero)
		h.CFrame = r.head.CFrame
		local w = Instance.new("WeldConstraint") w.Part0 = r.head w.Part1 = h w.Parent = h
		h.Parent = r.m
		r.head.Transparency = 1
		r.swap = h
	end)
end

-- visible aging (AUDIT-001: a colour tint alone is invisible on a phone): 3 dark knuckle/crease bands welded
-- around each hand, fading in with age. Only rigs whose story uses aging (Hero, Jace).
local function ageRig(r)
	if r.ageParts then return r.ageParts end
	r.ageParts = {}
	if r.prefix ~= "Hero" and r.prefix ~= "Jace" then return r.ageParts end
	for _, n in { "LeftHand", "RightHand" } do
		local hp = r.m:FindFirstChild(n)
		if hp then
			for k = 1, 3 do
				local old = hp:FindFirstChild("S7Age" .. n .. k) if old then old:Destroy() end -- v2 slabs hovered off the hand
				local nm = "S7AgeVein" .. n .. k
				local c = hp:FindFirstChild(nm)
				if not c then -- v3: thin dorsal vein, flush inside the back of the hand
					c = Instance.new("Part") c.Name = nm c.Shape = Enum.PartType.Cylinder
					c.Size = V(0.28, 0.032, 0.032)
					c.CFrame = hp.CFrame * CF((k - 2) * 0.075, 0.02, -0.14) * CFrame.Angles(0, 0, rad(90))
					c.Color = Color3.fromRGB(105, 72, 58) c.Material = Enum.Material.SmoothPlastic
					c.Anchored, c.CanCollide, c.CanQuery, c.CanTouch, c.Massless, c.CastShadow = false, false, false, false, true, false
					local w = Instance.new("WeldConstraint") w.Part0 = hp w.Part1 = c w.Parent = c
					c.Parent = hp
				end
				table.insert(r.ageParts, c)
			end
		end
	end
	return r.ageParts
end

local function setAge(r, k)
	if not r or r.age == k then return end
	r.age = k
	for _, t in r.tint do pcall(function() t.sa.Color = t.c0:Lerp(AGED, k * t.w) end) end
	for _, c in ageRig(r) do c.Transparency = 1 - 0.8 * math.clamp(k, 0, 1) end
end

local function hp(r, n)
	local p = r and r.m:FindFirstChild(n)
	return p and p.Position or (r and r.m:GetPivot().Position or V())
end
local function headP(r) return hp(r, "Head") end
local function handsP(r) return (hp(r, "LeftHand") + hp(r, "RightHand")) / 2 end
local function partCF(r, n) local p = r and r.m:FindFirstChild(n) return p and p.CFrame or CFrame.identity end

-- ================= gestures (degrees; +X pitch = limb forward, +Y yaw = toward character's left) =================
local function arm(r, side, pitch, yaw, elbow)
	P(r, side .. "UpperArm", 0, yaw, 0)
	P(r, side .. "UpperArm", pitch, 0, 0)
	P(r, side .. "LowerArm", elbow, 0, 0)
end
local function tapPose(r, k, tap, trem)
	arm(r, "Left", 40 * k, -20 * k, 75 * k)
	arm(r, "Right", 45 * k, 40 * k, 55 * k - 14 * (tap or 0) + (trem or 0))
	P(r, "Head", -18 * k, 0, 0)
end
local function selfie(r, k, side)
	side = side or "Left"
	local s = side == "Left" and 1 or -1
	arm(r, side, 115 * k, -20 * s * k, 70 * k)
	P(r, "Head", 6 * k, 12 * s * k, 0)
end
local function hold(r, k, tilt)
	arm(r, "Right", 55 * k, 25 * k, 40 * k)
	P(r, "RightHand", 0, 0, -(tilt or 0))
end
local function reach(r, side, k, yaw) arm(r, side, 70 * k, (yaw or 0) * k, 10 * k) end
local function lean(r, k) P(r, "UpperTorso", -16 * k, 0, 0) end
local function fist(r, k) arm(r, "Right", 35 * k, 20 * k, 110 * k) P(r, "RightHand", -30 * k, 0, 0) end
local function sit(r)
	for _, s in { "Left", "Right" } do P(r, s .. "UpperLeg", 85, 0, 0) P(r, s .. "LowerLeg", -85, 0, 0) end
end
local function walk(r, t, sp)
	local s = sin(t * (sp or 7))
	P(r, "LeftUpperLeg", 25 * s, 0, 0) P(r, "RightUpperLeg", -25 * s, 0, 0)
	P(r, "LeftLowerLeg", -25 * math.max(0, -s), 0, 0) P(r, "RightLowerLeg", -25 * math.max(0, s), 0, 0)
	P(r, "LeftUpperArm", -18 * s, 0, 0) P(r, "RightUpperArm", 18 * s, 0, 0)
	return abs(s) * 0.12
end
-- continuous life: breathing, sway, drifting head glances, arm sway + a per-cut pose variant (r.v*, set on every cut)
local function idle(r, t)
	local p = r.ph
	P(r, "UpperTorso", 2 * sin(t * 1.7 + p) + (r.vt or 0), 3 * sin(t * 0.37 + p), 1.5 * sin(t * 0.29 + p))
	P(r, "Head", 2.5 * sin(t * 0.9 + p) + (r.vh or 0), 9 * sin(t * 0.31 + p) * sin(t * 0.13 + p * 2) + (r.vy or 0), 3 * sin(t * 0.5 + p) + (r.vr or 0))
	P(r, "LeftUpperArm", 2 * sin(t * 1.7 + p), 0, -4 - 2 * sin(t * 1.1 + p))
	P(r, "RightUpperArm", 2 * sin(t * 1.7 + p + 1), 0, 4 + 2 * sin(t * 1.3 + p))
	P(r, "LeftLowerArm", r.ve or 0, 0, 0) P(r, "RightLowerArm", (r.ve or 0) * 0.7, 0, 0)
end
local function newPose(r, rnd)
	r.vt, r.vh, r.vy, r.vr, r.ve = rnd:NextNumber(-3, 3), rnd:NextNumber(-6, 5), rnd:NextNumber(-12, 12), rnd:NextNumber(-4, 4), rnd:NextNumber(0, 22)
end

-- ================= props =================
local PF, PR = nil, {}
local TOP, DY, ZS, ZP, CLK = 6.8, 0, -393, -395.4, CF(8, 14, -419.4)
local X_H, X_J, X_M = -20, -15.5, -11.5
local W0, A0, B0, PEN0
local CRACK = { { 0.3, 0.0, 0.35 }, { 0.62, 0.12, 0.3 }, { 0.9, -0.1, 0.32 }, { 0.6, -0.15, 0.25 }, { 1.1, 0.05, 0.22 } }
local SH = {}

local function part(parent, name, size, cf, color, mat, tr, shape, cls)
	local p = Instance.new(cls or "Part")
	p.Name = name p.Size = size p.CFrame = cf p.Color = color
	p.Material = mat or Enum.Material.SmoothPlastic p.Transparency = tr or 0
	if shape then p.Shape = shape end
	p.Anchored = true p.CanCollide = false p.CanQuery = true -- queryable for the occlusion guard p.CanTouch = false p.CastShadow = (tr or 0) < 0.5
	p.TopSurface = Enum.SurfaceType.Smooth p.BottomSurface = Enum.SurfaceType.Smooth
	p.Parent = parent
	return p
end
local UPR = CFrame.Angles(0, 0, rad(90)) -- cylinder axis X -> Y
local function cyl(m, name, h, d, y, color, mat, tr)
	return part(m, name, V(h, d, d), CF(0, y, 0) * UPR, color, mat, tr, Enum.PartType.Cylinder)
end
local function model(name)
	local m = Instance.new("Model") m.Name = name m.Parent = PF
	m.PrimaryPart = part(m, "Root", V(0.1, 0.1, 0.1), CFrame.identity, Color3.new(), nil, 1)
	return m
end
local GLASS = Color3.fromRGB(215, 235, 245)
local function bottle(name, red)
	local m = model(name)
	cyl(m, "Body", 1.1, 0.62, 0.55, GLASS, Enum.Material.Glass, 0.35)
	cyl(m, "Liquid", 0.8, 0.52, 0.45, red and Color3.fromRGB(225, 240, 160) or Color3.fromRGB(170, 210, 255), nil, 0.35)
	cyl(m, "Shoulder", 0.2, 0.45, 1.2, GLASS, Enum.Material.Glass, 0.35)
	cyl(m, "Neck", 0.35, 0.25, 1.45, GLASS, Enum.Material.Glass, 0.3)
	cyl(m, "Cap", 0.15, 0.3, 1.68, red and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(240, 240, 240))
	if red then cyl(m, "Label", 0.45, 0.64, 0.55, Color3.fromRGB(220, 40, 40)) end
	return m
end
local function phone(name)
	local m = model(name)
	part(m, "Body", V(0.6, 1.1, 0.08), CFrame.identity, Color3.fromRGB(25, 25, 30))
	part(m, "Screen", V(0.52, 1.0, 0.02), CF(0, 0, -0.045), Color3.fromRGB(90, 160, 255), Enum.Material.Neon)
	local fl = part(m, "Flash", V(0.08, 0.08, 0.02), CF(0.18, 0.42, 0.045), Color3.new(1, 1, 1), Enum.Material.Neon)
	local l = Instance.new("PointLight") l.Name = "Light" l.Range = 8 l.Brightness = 0 l.Parent = fl
	return m
end

local function surfaceY(x, z, inst)
	local prm = RaycastParams.new()
	prm.FilterType = Enum.RaycastFilterType.Include
	prm.FilterDescendantsInstances = { inst }
	local hit = WS:Raycast(V(x, 12, z), V(0, -20, 0), prm) -- start below the lab ceiling
	return hit and hit.Position.Y
end

local function buildProps()
	local old = WS:FindFirstChild("Story007Props")
	if old then old:Destroy() end
	PF = Instance.new("Folder") PF.Name = "Story007Props" PF.Parent = WS
	local lab = WS:FindFirstChild("Set_ChemLab")
	-- bench top under the hero/Jace/Mia spot: lowest hit wins (skips beakers already on the bench)
	if lab then
		local best
		for _, x in { -19, -17, -15, -13, -11 } do
			local y = surfaceY(x, ZP, lab)
			if y and (not best or y < best) then best = y end
		end
		TOP = best or TOP
		-- clock on the chalkboard wall
		local prm = RaycastParams.new() prm.FilterType = Enum.RaycastFilterType.Include prm.FilterDescendantsInstances = { lab }
		local hit = WS:Raycast(V(12, 14, -405), V(0, 0, -30), prm)
		CLK = CF(12, 14, (hit and hit.Position.Z or -419.6) + 0.2)
	end
	DY = math.max(0, TOP - WAIST)
	if DY > 0.3 then -- risers so kids reach the tall benches
		for _, c in { { -15, -406 }, { 15, -406 }, { -15, -397 }, { 15, -397 }, { -15, -388 }, { 15, -388 } } do
			part(PF, "Riser", V(20, DY, 3.6), CF(c[1], DY / 2, c[2] + 4), Color3.fromRGB(160, 160, 168), Enum.Material.Plastic)
		end
	end
	W0 = CF(-16.4, TOP, ZP)
	A0 = CF(-15.6, TOP, ZP)
	B0 = CF(-14.0, TOP, ZP)
	PEN0 = CF(-12.6, TOP + 0.08, ZP + 0.5)

	PR.Fill = nil
	PR.Acid = bottle("Acid", true)
	PR.Water = bottle("Water", false)
	local bk = model("Beaker")
	cyl(bk, "Glass", 1.4, 1.0, 0.7, GLASS, Enum.Material.Glass, 0.4)
	PR.BeakerLiquid = cyl(bk, "Liquid", 0.7, 0.9, 0.38, Color3.fromRGB(130, 230, 140), nil, 0.3)
	cyl(bk, "Rim", 0.06, 1.06, 1.4, Color3.new(1, 1, 1), nil, 0.3)
	PR.Beaker = bk
	PR.Crack = {}
	for i, c in CRACK do
		PR.Crack[i] = part(PF, "Crack", V(0.04, c[3], 0.04), OFF, Color3.fromRGB(235, 255, 235), Enum.Material.Neon, 0)
	end
	local rnd = Random.new(7)
	for i = 1, 12 do
		local s = part(PF, "Shard", V(0.05, 0.07, 0.45), OFF,
			i % 2 == 0 and Color3.fromRGB(150, 255, 220) or Color3.fromRGB(225, 248, 255), i % 2 == 0 and Enum.Material.Neon or Enum.Material.Glass, 0.15, nil, "WedgePart") -- glinting, not grey paper
		SH[i] = { p = s, off = V(rnd:NextNumber(-1, 1), rnd:NextNumber(-0.7, 0.9), rnd:NextNumber(-1, 1)), spin = V(rnd:NextNumber(-6, 6), rnd:NextNumber(-6, 6), rnd:NextNumber(-6, 6)) }
	end
	PR.Smoke = {}
	for i = 1, 4 do PR.Smoke[i] = part(PF, "Smoke", V(0.5, 0.5, 0.5), OFF, Color3.fromRGB(225, 245, 225), nil, 0.5, Enum.PartType.Ball) end
	PR.Stream = part(PF, "Stream", V(1, 0.08, 0.08), OFF, Color3.fromRGB(200, 240, 140), Enum.Material.Neon, 0.3, Enum.PartType.Cylinder)
	PR.Ripple = part(PF, "Ripple", V(0.05, 1, 1), OFF, Color3.fromRGB(80, 170, 255), Enum.Material.Neon, 0.55, Enum.PartType.Cylinder) -- v3: thin ring, never a ball over the hand
	local rl = Instance.new("PointLight") rl.Color = Color3.fromRGB(80, 170, 255) rl.Range = 10 rl.Brightness = 3 rl.Parent = PR.Ripple
	PR.RippleLight = rl
	-- tap payoff burst (created once; :Emit per tap, never per frame)
	local pe = Instance.new("ParticleEmitter")
	pe.Rate = 0 pe.Enabled = true pe.LightEmission = 1 pe.LightInfluence = 0
	pe.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	pe.Color = ColorSequence.new(Color3.fromRGB(200, 235, 255), Color3.fromRGB(70, 150, 255))
	pe.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14), NumberSequenceKeypoint.new(1, 0) })
	pe.Transparency = NumberSequence.new(0, 1)
	pe.Lifetime = NumberRange.new(0.35, 0.7) pe.Speed = NumberRange.new(3, 6)
	pe.SpreadAngle = Vector2.new(180, 180) pe.Drag = 4 pe.ZOffset = 0.5
	pcall(function() pe.Shape = Enum.ParticleEmitterShape.Sphere pe.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface end)
	pe.Parent = PR.Ripple
	PR.Burst = pe
	PR.Streaks = {}
	for i = 1, 8 do PR.Streaks[i] = part(PF, "Streak", V(0.05, 0.05, 1.6), OFF, Color3.fromRGB(120, 195, 255), Enum.Material.Neon, 0.2) end
	PR.Phone = phone("Phone")
	PR.Phone2 = phone("Phone2")
	local cup = model("MilkCup")
	cyl(cup, "Cup", 0.85, 0.58, 0.42, Color3.fromRGB(215, 45, 45), nil, 0) -- red cup: white milk must read against it
	cyl(cup, "Rim", 0.05, 0.62, 0.85, Color3.new(1, 1, 1), nil, 0)
	cyl(cup, "Milk", 0.6, 0.52, 0.36, Color3.fromRGB(255, 255, 245))
	PR.Cup = cup
	PR.Puddle = part(PF, "Puddle", V(0.03, 1.6, 1.6), OFF, Color3.fromRGB(255, 255, 248), nil, 0, Enum.PartType.Cylinder)
	PR.MilkStream = part(PF, "MilkStream", V(1, 0.12, 0.12), OFF, Color3.fromRGB(255, 255, 248), nil, 0, Enum.PartType.Cylinder)
	local pen = model("Pencil")
	part(pen, "Wood", V(0.14, 0.14, 1.3), CFrame.identity, Color3.fromRGB(245, 200, 40))
	part(pen, "Eraser", V(0.15, 0.15, 0.18), CF(0, 0, 0.72), Color3.fromRGB(240, 140, 160))
	part(pen, "Tip", V(0.08, 0.08, 0.16), CF(0, 0, -0.72), Color3.fromRGB(40, 40, 40))
	PR.Pencil = pen
	-- wall clock (faces +Z)
	local ck = model("Clock")
	part(ck, "Rim", V(0.15, 2.8, 2.8), CF(0, 0, -0.05) * CFrame.Angles(0, rad(90), 0), Color3.fromRGB(30, 30, 30), nil, 0, Enum.PartType.Cylinder)
	part(ck, "Face", V(0.12, 2.5, 2.5), CF(0, 0, 0.02) * CFrame.Angles(0, rad(90), 0), Color3.fromRGB(250, 250, 245), nil, 0, Enum.PartType.Cylinder)
	for i = 0, 11 do
		local a = rad(i * 30)
		part(ck, "Tick", V(0.08, i % 3 == 0 and 0.3 or 0.18, 0.04), CF(sin(a) * 1.05, cos(a) * 1.05, 0.1) * CFrame.Angles(0, 0, -a), Color3.fromRGB(30, 30, 30))
	end
	PR.HourH = part(PF, "HourHand", V(0.12, 0.7, 0.04), OFF, Color3.fromRGB(30, 30, 30))
	PR.MinH = part(PF, "MinHand", V(0.08, 1.0, 0.04), OFF, Color3.fromRGB(30, 30, 30))
	PR.SecH = part(PF, "SecHand", V(0.04, 1.1, 0.04), OFF, Color3.fromRGB(220, 40, 40))
	ck:PivotTo(CLK)
	PR.Clock = ck
	PR.Fade = part(PF, "FadeCard", V(6, 6, 0.05), OFF, Color3.new(0, 0, 0), Enum.Material.Neon, 1)
	PR.Fade.CastShadow = false
	PR.HL = Instance.new("Highlight")
	PR.HL.FillColor = Color3.fromRGB(255, 230, 90) PR.HL.FillTransparency = 0.8
	PR.HL.OutlineColor = Color3.fromRGB(255, 220, 60) PR.HL.Enabled = false PR.HL.Parent = PF
end

-- ================= init =================
local inited = false
local function clearS7(m)
	m:SetAttribute("S7Pivot", nil)
	for _, d in m:GetDescendants() do
		if d:GetAttribute("S7Base") ~= nil then d:SetAttribute("S7Base", nil) end
		if d:GetAttribute("S7Col") ~= nil then d:SetAttribute("S7Col", nil) end
		if d.Name == "S7Face" then d:Destroy() end
	end
	local h = m:FindFirstChild("Head") if h then h.Transparency = 0 end
end
local function resetRig(r)
	setFace(r, nil) r.emo = nil
	if r.swap then pcall(function() r.swap:Destroy() end) r.swap = nil end
	for _, d in r.m:GetChildren() do if d.Name == "S7Face" then d:Destroy() end end
	if r.head then r.head.Transparency = 0 end
	applyJoints(r)
	r.age = nil setAge(r, 0)
end

local function init()
	if inited then return true end
	FACES = SS:FindFirstChild("ApprovedFaces")
	for _, n in { "Hero", "Mia", "Jace", "Teacher", "Grandma" } do
		local m = WS:FindFirstChild(n)
		if m then resetRig(register(m, n)) else warn("[Story007] missing character " .. n) end
	end
	if not R.Hero then warn("[Story007] Hero missing, abort") return false end
	Hr, Mi, Ja, Te, Gr = R.Hero, R.Mia, R.Jace, R.Teacher, R.Grandma
	-- LittleHero (flashback) = scaled Hero clone
	local lm = WS:FindFirstChild("LittleHero")
	if not lm then
		lm = Hr.m:Clone() clearS7(lm) lm.Name = "LittleHero" lm.Parent = WS
		pcall(function() lm:ScaleTo(0.62) end)
	end
	LH = register(lm, "Hero")
	-- extras
	for i = 1, 6 do
		local name = "Extra" .. i
		-- extras = dressed HumanoidDescription rigs from assets/rigs/bystanders_school.luau (never clones of the cast)
		local m = WS:FindFirstChild(name)
		if m then EX[i] = register(m, name) resetRig(EX[i]) else warn("[Story007] run assets/rigs/bystanders_school.luau for " .. name) end
	end
	resetRig(LH)
	buildProps()
	inited = true
	return true
end

-- ================= staging =================
local STATIONS = { { -18, -402 }, { 12, -402 }, { 18, -393 }, { 13, -384 }, { -15, -384 }, { 17, -402 } }
local function labStand(r, x, yaw) place(r, x, ZS, yaw or 0, DY) end
local function stageDefault()
	labStand(Hr, X_H) labStand(Ja, X_J) labStand(Mi, X_M)
	place(Te, -4, -416.5, 180)
	place(Gr, 200, -408.2, 180, SIT_DY)
	place(LH, nil)
	for i, r in EX do place(r, STATIONS[i][1], STATIONS[i][2], 0, DY) end
end

-- ================= grade =================
local G = {
	n = { Color3.fromRGB(255, 244, 230), 0.08, 0.08, 0.02 },
	r = { Color3.fromRGB(170, 200, 255), -0.3, 0.15, 0.0 },
	s = { Color3.fromRGB(255, 220, 165), -0.8, 0.15, 0.0 },
}
local function fx(class, name)
	local o = Lighting:FindFirstChild(name)
	if not o then o = Instance.new(class) o.Name = name o.Parent = Lighting end
	return o
end

-- ================= per-frame scene state =================
local S = {}   -- persistent across beats within a take
local F = {}   -- reset every frame, filled by beat functions

local function rel(r, v) return (r.m:GetPivot() * CF(v)).Position end
local function look(from, at) return CFrame.lookAt(from, at) end
local function heldMouth(which) return PR[which]:GetPivot() * CF(0, 1.75, 0) end
local function beakerTop() return B0.Position + V(0, 1.4, 0) end
local function mid(a, b) return (a + b) / 2 end
local applyFaces -- defined after the beat tables; beats call it at runtime for in-shot expression changes

-- medium-close face shot (face ~30% of 9:16 frame height). Camera is raised (~20 deg down) so bench props
-- stay below the face line; side offset keeps the line clear of bottles/beaker. low>0 lowers the aim toward the hands.
-- occlusion guard (AUDIT-001: bottles / a shoulder in front of faces): if a prop or another character blocks
-- the line to the face, raise the camera (props sit low) then swing sideways, until the line is clear.
local function clearShot(pos, tgt, r)
	local prm = RaycastParams.new()
	prm.FilterType = Enum.RaycastFilterType.Include
	local lab = WS:FindFirstChild("Set_ChemLab")
	local inc = { PF, lab }
	for _, o in R do if o ~= r and o.m.Parent then table.insert(inc, o.m) end end
	prm.FilterDescendantsInstances = inc
	local right = (tgt - pos):Cross(V(0, 1, 0)).Unit
	for _, o in { V(), V(0, 0.6, 0), V(0, 1.2, 0), right * 0.8, -right * 0.8, V(0, 1.2, 0) + right * 1.2, V(0, 1.2, 0) - right * 1.2,
		V(0, 2.0, 0), V(0, 2.0, 0) + right * 1.6, V(0, 2.0, 0) - right * 1.6, V(0, 2.8, 0) + right * 1.0, V(0, 2.8, 0) - right * 1.0 } do -- high = look down over bench props
		local p = pos + o
		local clear = true
		for _, aim in { tgt, tgt - V(0, 0.7, 0), tgt - V(0, 1.6, 0) } do -- face AND chest: foreground clutter over the body reads as occlusion too
			local hit = WS:Spherecast(p, 0.52, (aim - p) * 0.92, prm) -- v3: fat ray catches off-centre bottles
			local i = hit and hit.Instance
			-- blockers: our props, characters, and SMALL set pieces (bench bottles); walls/benches don't count
			if i and i.Transparency <= 0.9 and not (lab and i:IsDescendantOf(lab) and i.Size.Magnitude > 6) then clear = false end
		end
		if clear then return p end
	end
	return pos
end
local function rigScale(r) local ok, s = pcall(function() return r.m:GetScale() end) return ok and s or 1 end
local function faceCam(r, u, side, d, low, fov)
	local s = rigScale(r)
	local h = headP(r)
	local pv = r.m:GetPivot()
	d = (d and d * 1.5 or 5.0) * s
	local tgt = h - V(0, (low or 0.15) * s, 0)
	local pos = tgt + pv.LookVector * lerp(d + 0.35 * s, d, ease(u)) + pv.RightVector * (side or 0.7) * s + V(0, 1.6 * s, 0)
	return look(clearShot(pos, tgt, r), tgt), fov or 40, h
end
-- eye-level (+0.3) front-side shot for leaning/shocked faces
local function eyeCam(r, u, side, d, fov)
	local h = headP(r)
	local pv = r.m:GetPivot()
	d = (d or 3.2) * 1.5
	local pos = h + pv.LookVector * lerp(d + 0.4, d, ease(u)) + pv.RightVector * (side or 1.1) + V(0, 0.3, 0)
	return look(clearShot(pos, h, r), h), fov or 40, h
end
-- high-angle insert from the far (-Z) side of the bench: kids' faces behind stay out of frame, nothing over a face
local function topInsert(c, u, up, back, fov)
	up, back = up or 2.4, back or 1.6
	local p = c + V(0.4, up, -back):Lerp(V(0.3, up * 0.85, -back * 0.85), ease(u))
	-- lab x -29..29, z -421..-379, ceiling ~20: stay >=1.5 from walls
	p = V(clamp(p.X, -27.5, 27.5), clamp(p.Y, c.Y + 1, 18), clamp(p.Z, -419.5, -380.5))
	return look(p, c), fov or 40, c
end
-- split a beat into two camera angles; sets F.shot so the loop resets push-in + pose variant on the cut
local function cut2(u, at) if u >= at then F.shot = 2 return true end return false end
local function su(u, a, b) return clamp((u - a) / (b - a), 0, 1) end

-- ================= beats (t = word start in words.json, seconds of audio) =================
-- Standard shots reused by both parts
-- readable wrist-tap framing (~3.3 studs, face/shoulder in frame); far/near kept in the signature for old callers but ignored
local function camHand(u, far, near, fov)
	local h = hp(Hr, "LeftHand")
	return look(h + V(0.4, 1.5, -3.2):Lerp(V(0.3, 1.3, -2.8), ease(u)), h + V(0, 0.5, 0.3)), 40, h
end
local function grandmaHands(L, u)
	P(Gr, "RightUpperArm", 0, 20, 0) arm(Gr, "Right", 50, 0, 30 + 3 * sin(L * 38))
	P(Gr, "RightHand", 4 * sin(L * 31), 0, 3 * sin(L * 27))
	local h = hp(Gr, "RightHand")
	F.fill = h + V(0.5, 1.2, 2.2)
	return look(h + V(1.3, 1.6, 5.0):Lerp(V(1.0, 1.4, 4.5), ease(u)), h + V(0, 0.9, 0)), 45, h
end
local function tapBeat(far, near)
	return function(L, u, d, b)
		tapPose(Hr, 1, tapc(u, b.tapAt))
		F.shake = 0.6 * tapc(u, b.tapAt)
		return camHand(u, far, near)
	end
end
local function shardsBeat(k0, k1)
	return function(L, u)
		F.held, F.holdK, F.crack, F.smoke = "Acid", 1, 1, true
		hold(Ja, 1, 40)
		F.shards = lerp(k0, k1, u)
		lean(Mi, -0.4) P(Mi, "Head", 4, 20, 0)
		return faceCam(Mi, u, 1.3, 3.6, 0.35) -- shards fly in from beside, never over the face
	end
end

local B1 = {
	-- HOOK: big hero face + wrist tap flash inside the first ~1.2 s, then hand insert
	{ t = 0.00, line = "In my world, tapping your wrist rewinds any mistake", g = "n", tapAt = 0.3,
		f = function(L, u, d, b)
			tapPose(Hr, seg(u, 0, 0.12), tapc(u, b.tapAt))
			if u > b.tapAt then F.g = "r" end
			applyFaces({ hero = u > b.tapAt + 0.04 and "Shocked" or "Determined" })
			if cut2(u, 0.58) then return camHand(su(u, 0.58, 1)) end
			F.shake = 0.8 * tapc(u, b.tapAt)
			local cf, fov, h = faceCam(Hr, su(u, 0, 0.58), 0.6, 3.6, 0.55)
			return cf, fov, h
		end },
	{ t = 3.14, line = "by ten seconds.", g = "r",
		f = function(L, u)
			F.clockSpeed = -900
			F.streak = { CLK.Position + V(0, 0, 0.4), u }
			local c = CLK.Position
			return look(c + V(0.6, -0.4, 4):Lerp(V(0, 0, 2.6), ease(u)), c), 40, c
		end },
	{ t = 4.48, line = "But your hands age one year every time.", g = "r",
		enter = function() place(EX[3], 100, -396, 0) end,
		f = function(L, u)
			local r = EX[3]
			tapPose(r, 1, tapc((u * 3) % 1, 0.5))
			F.age[r] = seg(u, 0.1, 0.9)
			F.ripple = { hp(r, "LeftHand"), (u * 3) % 1 }
			if cut2(u, 0.5) then -- insert: the aging hand
				local h = hp(r, "LeftHand")
				return look(h + V(0.5, 1.8, -4.2):Lerp(V(0.4, 1.6, -3.8), ease(su(u, 0.5, 1))), h + V(0, 0.8, 0.3)), 40, h
			end
			local c = r.m:GetPivot().Position + V(0, 0.8, 0)
			local h = hp(r, "LeftHand")
				return look(h + V(0.5, 1.8, -4.2):Lerp(V(0.4, 1.6, -3.8), ease(su(u, 0, 0.5))), h + V(0, 0.8, 0.3)), 40, h
		end },
	{ t = 6.68, line = "Kids rewind dropped phones and spilled milk.", g = "r",
		enter = function() place(EX[1], 98.5, -404, 0) place(EX[2], 101.5, -399, 0) end,
		f = function(L, u)
			local k = 1 - (1 - clamp(u * 1.4, 0, 1)) ^ 3
			reach(EX[1], "Right", k, 10)
			local hand = partCF(EX[1], "RightHand") * CF(0, -0.3, 0)
			F.phone2 = CF(98.9, 0.1, -405.2):Lerp(hand, k) * CFrame.Angles((1 - k) * 9, 0, (1 - k) * 4)
			reach(EX[2], "Right", 1, 0)
			local up = seg(u, 0, 0.7)
			F.milk = { partCF(EX[2], "RightHand") * CF(0, -0.68, -0.58) * CFrame.Angles(0, 0, rad(100 * (1 - up))), 1 - up }
			F.streak = { V(100, 2.5, -402), u }
			if cut2(u, 0.5) then -- insert: milk flowing back up into the cup
				local c = (F.milk[1] * CF(0, 0.3, 0)).Position
				return look(c + V(1.2, 0.9, -2.8):Lerp(V(1.0, 0.8, -2.3), ease(su(u, 0.5, 1))), c + V(0, 0.2, 0)), 45, c
			end
			return look(V(97, 4.2, -392):Lerp(V(96.8, 3.6, -397.5), ease(su(u, 0, 0.5))), V(100, 2.5, -402)), 50, V(100, 2.5, -402)
		end },
	{ t = 9.66, line = "Jace rewinds bad selfies", g = "n",
		f = function(L, u, d)
			selfie(Ja, seg(u, 0, 0.3))
			labStand(Ja, X_J, lerp(0, -35, seg(u, 0.2, 0.6)))
			F.flash = flashAt(u, 0.55, d)
			return faceCam(Ja, u, 0.9, 3.5, 0.35)
		end },
	{ t = 11.30, line = "he has thirty-year-old hands.", g = "n",
		f = function(L, u)
			arm(Ja, "Left", 50, -25, 60) arm(Ja, "Right", 50, 25, 60)
			local h = handsP(Ja)
			return look(h + V(1.8, 2.2, -3.6):Lerp(V(1.4, 1.9, -3.0), ease(u)), h + V(0, 0.9, 0)), 40, h
		end },
	{ t = 13.18, line = "Mine are fifteen. Zero taps.", g = "n",
		enter = function() labStand(Hr, -18) labStand(Ja, -16) end,
		f = function(L, u)
			arm(Hr, "Left", 70, -10, 10) arm(Ja, "Left", 70, -10, 10)
			if cut2(u, 0.5) then return faceCam(Hr, su(u, 0.5, 1), 0.7) end -- reaction: hero's worried face
			local m = mid(hp(Hr, "LeftHand"), hp(Ja, "LeftHand"))
			return look(m + V(0, 2.2, -2.6):Lerp(V(0, 1.8, -2.1), ease(su(u, 0, 0.5))), m), 50, m
		end },
	{ t = 15.26, line = "My grandma spent her taps on herself,", g = "s",
		f = function(L, u)
			local tp = (u * 4) % 1
			tapPose(Gr, 1, tapc(tp, 0.5))
			F.ripple = { hp(Gr, "LeftHand"), tp }
			if cut2(u, 0.5) then return faceCam(Gr, su(u, 0.5, 1), -0.7, 3.4, 0.3) end -- grandma's sad face
			local c = Gr.m:GetPivot().Position + V(0, 1, 0)
			return look(V(192.5, 5.6, -393):Lerp(V(193.5, 5.2, -395), ease(su(u, 0, 0.5))), c), 50, c
		end },
	{ t = 17.40, line = "her hands shook too hard to hold mine.", g = "s",
		enter = function() place(LH, 198.3, -406.2, -90) end,
		f = function(L, u)
			reach(LH, "Left", 1, -10)
			local drop = seg(u, 0.55, 0.8)
			arm(Gr, "Right", lerp(55, 15, drop), 20, 20 + 4 * sin(L * 38))
			P(Gr, "RightHand", 5 * sin(L * 33), 0, 0)
			if cut2(u, 0.55) then return faceCam(LH, su(u, 0.55, 1), 0.6, 3.3) end -- little hero crying
			local m = mid(hp(Gr, "RightHand"), hp(LH, "LeftHand"))
			return look(m + V(-1.2, 0.8, 3.4):Lerp(V(0.2, 0.7, 3.0), ease(su(u, 0, 0.55))), m + V(0, 0.5, 0)), 40, m
		end },
	{ t = 19.84, line = "So I saved mine.", g = "n",
		f = function(L, u)
			fist(Hr, seg(u, 0.1, 0.6))
			return faceCam(Hr, u, 0.8, 3.5, 0.45)
		end },
	{ t = 20.96, line = "Then chemistry class, last period.", g = "n",
		f = function(L, u)
			for i, x in { [5] = 1.5, [6] = -1.5 } do
				local bob = walk(EX[i], L, 7)
				place(EX[i], x, lerp(-379, -386, u), 0, bob)
			end
			arm(Te, "Right", 120 + 8 * sin(L * 5), 0, 30)
			local c = V(-6, 4 + DY, -400)
			return look(V(6, 17.5, -381):Lerp(V(8, 11, -381.5), ease(u)), c), 60, c
		end },
	{ t = 23.34, line = "Mia sits beside Jace.", g = "n",
		f = function(L, u)
			P(Mi, "Head", 0, 18 * seg(u, 0.2, 0.6), 0)
			return faceCam(Mi, u, 0.8)
		end },
	{ t = 24.78, line = "She once lent me a pencil", g = "s",
		enter = function() place(Ja, nil) labStand(Mi, -17.2) end,
		f = function(L, u)
			reach(Mi, "Left", seg(u, 0, 0.4), 15)
			local k = seg(u, 0.1, 0.9)
			F.pencil = CF(lerp(-16.2, -19.2, k), TOP + 0.08, ZP + 0.6) * CFrame.Angles(0, rad(90), 0)
			-- medium: pencil on the bench low in frame, Mia + hero faces above it (camera across the bench, raised)
			local c = V(-18.6, TOP + 1.2, ZP + 1.4)
			return look(c + V(0.6, 1.8, -5.2):Lerp(V(0.4, 1.6, -4.6), ease(u)), c), 48, c
		end },
	{ t = 25.92, line = "when nobody else would talk to me.", g = "s",
		enter = function() place(Ja, nil) place(Mi, nil) end,
		f = function(L, u)
			local k = seg(u, 0.1, 0.7)
			place(EX[1], -23.5, ZS + 3, lerp(0, 160, k), DY)
			place(EX[2], -16, ZS + 3, lerp(0, -160, k), DY)
			P(Hr, "Head", -15 * k, 0, 0)
			local h = headP(Hr)
			return look(h + V(1.4, 1.9, -6.4):Lerp(V(1.2, 1.6, -5.6), ease(u)), h - V(0, 0.2, 0)), 48, h
		end },
	{ t = 27.38, line = "Jace was showing off for his phone, as always.", g = "n",
		f = function(L, u, d)
			selfie(Ja, 1)
			labStand(Ja, X_J, 15 * sin(L * 2.2))
			F.flash = flashAt(u, 0.6, d)
			if cut2(u, 0.5) then -- second angle: other side, looser, head tilted for the pose
				P(Ja, "Head", 0, 0, 12)
				return faceCam(Ja, su(u, 0.5, 1), 1.2, 3.6, 0.25, 42)
			end
			return faceCam(Ja, su(u, 0, 0.5), 0.9, 3.4, 0.3)
		end },
	{ t = 30.44, line = "Two bottles, same shape, side by side.", g = "n",
		f = function(L, u)
			local m = mid(W0.Position, A0.Position) + V(0, 0.6, 0)
			if cut2(u, 0.55) then -- reaction: hero eyeing the bottles
				P(Hr, "Head", -8, -25, 0)
				return faceCam(Hr, su(u, 0.55, 1), 0.9)
			end
			return topInsert(m, su(u, 0, 0.55), 3.6, 0.8, 38) -- bottles from above, no face behind them
		end },
	{ t = 33.06, line = "Red label is acid. Plain one is water.", g = "n",
		f = function(L, u)
			-- two inserts from the far side of the bench, low: faces are above frame, camera never inside a kid
			F.focusR = 0.5
			if cut2(u, 0.5) then
				F.hl = PR.Water
				local w = W0.Position + V(0, 0.6, 0)
				return look(w + V(-0.9, 1.7, -1.8):Lerp(V(-0.7, 1.55, -1.6), ease(su(u, 0.5, 1))), w), 34, w
			end
			F.hl = PR.Acid
			local a = A0.Position + V(0, 0.6, 0)
			return look(a + V(0.9, 1.7, -1.8):Lerp(V(0.7, 1.55, -1.6), ease(su(u, 0, 0.5))), a), 34, a
		end },
	{ t = 35.78, line = "He grabbed the red one.", g = "n",
		f = function(L, u)
			local k = seg(u, 0, 0.45)
			F.held, F.holdK = "Acid", seg(u, 0.4, 0.6)
			if u < 0.5 then reach(Ja, "Right", k, 10) else hold(Ja, 1, 0) end
			P(Hr, "Head", 0, -35 * seg(u, 0.3, 0.6), 0)
			return faceCam(Ja, u, 1.0, 3.6, 0.6) -- Jace smirking, grabbing hand below the face
		end },
	{ t = 37.22, line = "Mia leaned in to watch.", g = "n",
		f = function(L, u)
			F.held, F.holdK = "Acid", 1
			hold(Ja, 1, 0)
			lean(Mi, seg(u, 0, 0.6)) P(Mi, "Head", -8, 20 * seg(u, 0, 0.6), 0)
			return eyeCam(Mi, u, 1.0, 3.2)
		end },
	{ t = 38.46, line = "He poured. The beaker hissed.", g = "n", ts = 0.4,
		f = function(L, u)
			local tilt = 95 * seg(u, 0, 0.5)
			F.held, F.holdK = "Acid", 1
			hold(Ja, 1, tilt)
			lean(Mi, 1) P(Mi, "Head", -8, 20, 0)
			F.stream = tilt > 60 and "Acid"
			F.smoke = u > 0.5
			if cut2(u, 0.55) then return eyeCam(Mi, su(u, 0.55, 1), 1.1, 3.2) end -- Mia close, smoke beside her
			local t = beakerTop()
			return topInsert(t - V(0, 0.4, 0), su(u, 0, 0.55), 3.6, 0.8, 42) -- pour from above
		end },
	{ t = 40.34, line = "The glass cracked, bulging toward her face.", g = "n", ts = 0.4,
		f = function(L, u)
			F.held, F.holdK = "Acid", 1
			hold(Ja, 1, lerp(95, 40, u))
			lean(Mi, 1) P(Mi, "Head", -8, 20, 0)
			F.crack = seg(u, 0, 0.6) F.smoke = true F.shake = 0.5
			F.liquidGlow = u
			if cut2(u, 0.5) then return eyeCam(Mi, su(u, 0.5, 1), 1.1, 3.1) end -- shocked face, beaker below
			local c = B0.Position + V(0.3, 0.7, 0)
			return look(c + V(1.5, 3.2, -1.2):Lerp(V(1.2, 3.0, -1.0), ease(su(u, 0, 0.5))), c), 42, c -- crack insert (crack faces +X)
		end },
	{ t = 43.20, line = "Nobody else saw it.", g = "n", ts = 0.3,
		f = function(L, u)
			F.held, F.holdK, F.crack, F.smoke = "Acid", 1, 1, true
			hold(Ja, 1, 40)
			lean(Mi, 1)
			arm(Te, "Right", 120 + 8 * sin(L * 1.5), 0, 30)
			local w = ease(clamp(u / 0.25, 0, 1))
			local pos = V(-4, 12 + DY * 0.5, -386)
			local tgt = V(-4, 6, -416):Lerp(V(-14.5, TOP + 0.4, -395), w)
			F.shake = (w > 0 and w < 1) and 1.5 or 0.2
			return look(pos, tgt), 55, tgt
		end },
	{ t = 44.34, line = "My finger hovered over my wrist.", g = "r", ts = 0.2,
		f = function(L, u)
			F.held, F.holdK, F.crack, F.smoke = "Acid", 1, 1, true
			F.shards = 0.4
			hold(Ja, 1, 40)
			tapPose(Hr, 1, 0, 2.5 * sin(L * 40))
			if cut2(u, 0.5) then applyFaces({ hero = "Worried" }) return faceCam(Hr, su(u, 0.5, 1), -0.7, 3.3, 0.3) end
			local h = hp(Hr, "LeftHand")
			return look(h + V(0.5, 1.8, -4.2):Lerp(V(0.4, 1.6, -3.8), ease(su(u, 0, 0.5))), h + V(0, 0.8, 0.3)), 40, h
		end },
	{ t = 46.34, line = "Fifteen years of saving.", g = "n", ts = 0.2,
		f = function(L, u)
			F.held, F.holdK, F.crack, F.smoke = "Acid", 1, 1, true
			F.shards = 0.45
			hold(Ja, 1, 40)
			tapPose(Hr, 1, 0, 1.5 * sin(L * 40))
			P(Hr, "Head", 0, 0, 2 * sin(L * 23)) -- trembling
			return faceCam(Hr, u, 0.6, 3.1, 0.2)
		end },
	{ t = 47.82, line = "One tap breaks it.", g = "s", f = grandmaHands },
	{ t = 48.96, line = "Do I spend it", g = "n", ts = 0.15, f = shardsBeat(0.5, 0.72) },
	{ t = 49.56, line = "on her?", g = "n", ts = 0, f = shardsBeat(0.72, 0.8) }, -- Part 1 ends ON the person in danger (shards frozen at her face); hard cut, no fade
}

local B2 = {
	{ t = 0.00, line = "Fifteen years of saving.", g = "n", ts = 0,
		f = function(L, u)
			F.held, F.holdK, F.crack, F.smoke, F.shards = "Acid", 1, 1, true, 0.72
			hold(Ja, 1, 40) lean(Mi, -0.4)
			-- HOOK: big straining hero face, finger trembling over the wrist
			tapPose(Hr, 1, 0, 2 * sin(L * 40))
			P(Hr, "Head", 0, 0, 2 * sin(L * 23))
			return faceCam(Hr, u, 0.6, 3.2, 0.3)
		end },
	{ t = 1.62, line = "One tap.", g = "r", tapAt = 0.35, ageTo = 0.25, ts = 0,
		f = function(L, u, d, b)
			F.held, F.holdK, F.crack, F.smoke, F.shards = "Acid", 1, 1, true, 0.72
			hold(Ja, 1, 40)
			tapPose(Hr, 1, tapc(u, b.tapAt))
			F.shake = 1.2 * tapc(u, b.tapAt)
			local h = hp(Hr, "LeftHand")
			return look(h + V(0.4, 1.5, -3.4), h + V(0, 0.5, 0.3)), lerp(46, 38, seg(u, 0.3, 0.45)), h
		end },
	{ t = 2.54, line = "Ten seconds back, before the pour.", g = "r",
		f = function(L, u)
			local v = 1 - seg(u, 0, 0.85)
			F.held, F.holdK = "Acid", v
			if v > 0 then hold(Ja, v, 40 * v) end
			reach(Ja, "Right", math.max(v, 0.6) * (1 - v), 10)
			F.crack = v
			F.shards = v > 0.02 and 0.72 * v or nil
			F.smoke = v > 0.5
			lean(Mi, -0.4 * v)
			F.streak = { B0.Position + V(0, 1, 0), u }
			if cut2(u, 0.55) then return faceCam(Hr, su(u, 0.55, 1), -0.8) end -- hero, determined, blue grade
			local c = V(-15.5, TOP + 0.5, -395)
			return look(V(-15, TOP + 3.4, -403):Lerp(V(-15, TOP + 3, -402), ease(su(u, 0, 0.55))), c), 50, c
		end },
	{ t = 4.56, line = "I yelled. He poured anyway.", g = "n",
		f = function(L, u)
			arm(Hr, "Left", 55, -15, 10) arm(Hr, "Right", 55, 15, 10) P(Hr, "Head", 8, -20, 0)
			F.held, F.holdK = "Acid", seg(u, 0.25, 0.5)
			hold(Ja, 1, 95 * seg(u, 0.5, 0.8))
			F.stream = u > 0.65 and "Acid"
			F.smoke = u > 0.8
			if cut2(u, 0.45) then F.shake = 0.3 return topInsert(beakerTop() - V(0, 0.4, 0), su(u, 0.45, 1), 3.6, 0.8, 42) end
			F.shake = 0.6 -- hero yelling
			return faceCam(Hr, su(u, 0, 0.45), 0.8, 3.4)
		end },
	{ t = 6.66, line = "Tap.", g = "r", tapAt = 0.3, ageTo = 0.5, f = tapBeat(V(1.5, 0.5, -0.8), V(1.0, 0.35, -0.5)) },
	{ t = 7.12, line = "I grabbed his arm.", g = "n",
		f = function(L, u)
			local k = seg(u, 0, 0.5)
			labStand(Hr, lerp(-19, -17.6, k))
			reach(Hr, "Right", k, -15)
			reach(Ja, "Right", 0.6, 10)
			F.shake = 0.7
			local m = mid(headP(Hr), headP(Ja))
			return look(m + V(0, 1.6, -5.6):Lerp(V(0, 1.4, -5.0), ease(u)), m - V(0, 0.2, 0)), 45, m -- raised over the bench props
		end },
	{ t = 8.28, line = "He shoved me, and poured.", g = "n",
		f = function(L, u)
			local s = seg(u, 0, 0.2) * (1 - seg(u, 0.35, 0.5))
			arm(Ja, "Left", 85 * s, 15 * s, 5)
			P(Ja, "UpperTorso", -10 * s, 15 * s, 0)
			local push = seg(u, 0.12, 0.4)
			labStand(Hr, lerp(-17.6, -20.5, push)) P(Hr, "UpperTorso", 14 * push * (1 - seg(u, 0.5, 0.8)), 0, 0)
			F.held, F.holdK = "Acid", seg(u, 0.4, 0.55)
			hold(Ja, 1, 95 * seg(u, 0.55, 0.8))
			F.stream = u > 0.7 and "Acid"
			F.smoke = u > 0.8
			F.shake = 1.4 * s + 0.3
			local m = mid(headP(Hr), headP(Ja))
			return look(m + V(0.6, 1.6, -5.8):Lerp(V(0.4, 1.4, -5.2), ease(u)), m - V(0, 0.2, 0)), 45, m
		end },
	{ t = 9.90, line = "Tap. My knuckles started to wrinkle.", g = "r", tapAt = 0.12, ageTo = 0.75, ageAt = 0.3,
		f = function(L, u, d, b)
			tapPose(Hr, 1, tapc(u, b.tapAt))
			F.shake = 0.6 * tapc(u, b.tapAt)
			if cut2(u, 0.6) then return faceCam(Hr, su(u, 0.6, 1), 0.7, 3.2) end -- crying at the wrinkles
			return camHand(su(u, 0, 0.6))
		end },
	{ t = 12.00, line = "So I stopped fighting and started watching.", g = "n",
		f = function(L, u)
			labStand(Hr, lerp(-20, -20.6, seg(u, 0, 0.5)))
			P(Hr, "Head", -5, -20 * seg(u, 0.3, 0.7), 0)
			F.focusR = 1
			return faceCam(Hr, u, -0.6, 3.4)
		end },
	{ t = 14.22, line = "Water bottle, left of the acid.", g = "n",
		f = function(L, u)
			F.hl = PR.Water
			local w = W0.Position + V(0, 0.6, 0)
			return look(headP(Hr) + V(0, 0.1, -0.4) + V(0.3 * u, 0, 0), w), 32, w
		end },
	{ t = 16.14, line = "He pours with his right hand.", g = "n",
		f = function(L, u)
			local k = seg(u, 0, 0.5)
			if u < 0.5 then reach(Ja, "Right", k, 10) else hold(Ja, 1, 0) end
			F.held, F.holdK = "Acid", seg(u, 0.4, 0.7)
			local h = hp(Ja, "RightHand") -- front-side insert on the pouring hand, chest-up context
			local p = clearShot(h + V(0.5, 1.8, -4.2):Lerp(V(0.4, 1.6, -3.8), ease(u)), headP(Ja), Ja) -- beaker must not cover his face
			return look(p, h + V(0, 0.8, 0.3)), 40, h
		end },
	{ t = 17.72, line = "At second seven, he turns to pose for his phone.", g = "n",
		f = function(L, u, d)
			labStand(Ja, X_J, lerp(0, 40, seg(u, 0.3, 0.7))) -- faceCam beat: never turn the subject's back to camera
			selfie(Ja, seg(u, 0.4, 0.75))
			F.flash = flashAt(u, 0.85, d)
			if cut2(u, 0.5) then return faceCam(Ja, su(u, 0.5, 1), -1.0, 3.6, 0.4) end -- posing, smirk, flash
			return faceCam(Ja, su(u, 0, 0.5), 0.9, 3.6, 0.4) -- front-side, turning to pose
		end },
	{ t = 20.72, line = "Tap. Last loop.", g = "r", tapAt = 0.12, ageTo = 1, f = tapBeat(V(1.6, 0.6, -0.8), V(1.0, 0.4, -0.5)) },
	{ t = 22.08, line = "I waited. He turned.", g = "n",
		f = function(L, u)
			labStand(Ja, X_J, lerp(20, 150, seg(u, 0.4, 0.8)))
			selfie(Ja, seg(u, 0.5, 0.9))
			P(Hr, "Head", 0, -18 * seg(u, 0.4, 0.8), 0) -- eyes follow Jace
			return faceCam(Hr, u, 0.9)
		end },
	{ t = 23.76, line = "Flash. I swapped the bottles.", g = "n", ts = 0.4,
		f = function(L, u, d)
			labStand(Ja, X_J, 150) selfie(Ja, 1)
			F.flash = flashAt(u, 0.08, d)
			labStand(Hr, -17.8)
			local k = seg(u, 0.2, 0.9)
			reach(Hr, "Left", 1, 10) reach(Hr, "Right", 1, -10)
			local arc = sin(math.pi * k) * 0.6
			F.bcf = { Water = W0:Lerp(A0, k) + V(0, arc, 0.15 * arc), Acid = A0:Lerp(W0, k) + V(0, arc, -0.15 * arc) }
			-- insert from the far side of the bench (old camera sat inside Jace): hands + bottles, faces above frame
			local m = mid(W0.Position, A0.Position) + V(0, 0.5, 0)
			return topInsert(m, u, 3.6, 0.8, 40) -- steep top-down, bottles only
		end },
	{ t = 25.84, line = "He poured water. Nothing happened.", g = "n",
		enter = function() S.swap = true end,
		f = function(L, u)
			labStand(Hr, -19)
			F.held, F.holdK = "Water", seg(u, 0, 0.2)
			hold(Ja, 1, 95 * seg(u, 0.15, 0.45))
			F.stream = u > 0.35 and u < 0.85 and "Water"
			return topInsert(beakerTop() - V(0, 0.4, 0), u, 3.6, 0.8, 40)
		end },
	{ t = 27.40, line = "Jace checked his selfie, never the beaker.", g = "n",
		f = function(L, u, d)
			labStand(Hr, -19)
			selfie(Ja, 1) P(Ja, "Head", -10, 0, 0)
			F.flash = flashAt(u, 0.6, d)
			if cut2(u, 0.5) then -- reaction two-shot, raised over the bench
				local m = mid(headP(Hr), headP(Ja))
				return look(m + V(0, 1.6, -6.4):Lerp(V(0, 1.4, -5.8), ease(su(u, 0.5, 1))), m - V(0, 0.2, 0)), 45, m
			end
			return faceCam(Ja, su(u, 0, 0.5), 0.9, 3.4, 0.35) -- Jace grinning at his phone
		end },
	{ t = 30.26, line = "I pulled my sleeves over my hands.", g = "n",
		f = function(L, u)
			labStand(Hr, -19)
			local k = seg(u, 0.1, 0.7)
			arm(Hr, "Left", 20 * k, 10 * k, 100 * k) arm(Hr, "Right", 20 * k, -10 * k, 100 * k)
			P(Hr, "Head", -15 * k, 0, 0)
			local h = handsP(Hr) -- hands low in frame, sad face visible above
			return look(h + V(0.8, 2.0, -3.8):Lerp(V(0.7, 1.8, -3.3), ease(u)), h + V(0, 0.9, 0.2)), 42, h
		end },
	{ t = 32.30, line = "Mia saw them anyway. You never tap. Why now?", g = "n",
		enter = function() labStand(Hr, -19.5) labStand(Mi, -17.4) labStand(Ja, -13.5, 150) end,
		f = function(L, u)
			selfie(Ja, 1)
			arm(Hr, "Left", 20, 10, 100) arm(Hr, "Right", 20, -10, 100)
			P(Mi, "Head", -15, 25, 0)
			if cut2(u, 0.55) then -- hero caught, sad
				P(Hr, "Head", -10, -15, 0)
				return faceCam(Hr, su(u, 0.55, 1), -0.8)
			end
			return faceCam(Mi, su(u, 0, 0.55), -0.9) -- (old OTS showed the back of Mia's head)
		end },
	{ t = 35.14, line = "Four taps. Four years.", g = "n",
		enter = function() labStand(Hr, -19.5) labStand(Mi, -17.4) labStand(Ja, -13.5, 150) end,
		f = function(L, u)
			selfie(Ja, 1)
			tapPose(Hr, 1, 0)
			local fl, lv = 0, 1
			for i, at in { 0.1, 0.3, 0.5, 0.7 } do
				local x = tapc(u, at)
				if x > fl then fl = x end
				if u < at then lv = math.min(lv, (i - 1) * 0.25 + 0.25) end
			end
			F.age[Hr] = lv
			F.flash = fl * 0.6
			F.ripple = { hp(Hr, "LeftHand"), (u * 5) % 1 }
			local h = handsP(Hr)
			return camHand(u)
		end },
	{ t = 36.98, line = "For ten seconds.", g = "r",
		f = function(L, u)
			F.clockSpeed = 0 F.clockTick = seg(u, 0.45, 0.55)
			local c = CLK.Position
			return look(c + V(0.3, -0.2, 2.6), c), 38, c
		end },
	{ t = 38.22, line = "Mia smiled at me, her face perfect,", g = "n",
		enter = function() labStand(Hr, -20.6) labStand(Mi, -17.4) labStand(Ja, -13.5, 150) end,
		f = function(L, u)
			selfie(Ja, 1)
			P(Mi, "Head", 0, 15, 0)
			F.bloom = 0.5
			F.focusR = 0.8
			return faceCam(Mi, u, 0.6, 3.2, 0.15, 38) -- camera on Mia's far side: Hero's arm never crosses her neck
		end },
	{ t = 40.70, line = "and lent me a pencil again.", g = "n",
		enter = function() labStand(Hr, -19.5) labStand(Mi, -17.4) labStand(Ja, -13.5, 150) end,
		f = function(L, u)
			selfie(Ja, 1)
			reach(Mi, "Left", seg(u, 0, 0.4), 15)
			F.pencil = CF(lerp(-16.6, -18.8, seg(u, 0.1, 0.9)), TOP + 0.08, ZP + 0.6) * CFrame.Angles(0, rad(90), 0)
			F.bloom = 0.4
			-- medium from across the bench (old camera sat inside Mia): pencil low, both smiling faces above
			local c = V(-18.4, TOP + 1.2, ZP + 1.4)
			return look(c + V(-0.6, 1.8, -5.0):Lerp(V(-0.4, 1.6, -4.4), ease(u)), c), 48, c
		end },
	{ t = 42.32, line = "Jace spends his years on selfies.", g = "n",
		enter = function() labStand(Ja, -13.5, 0) end,
		f = function(L, u, d)
			local sk = seg(u, 0.5, 0.7)
			if sk < 0.5 then tapPose(Ja, 1, tapc(u, 0.3)) else selfie(Ja, sk) end
			F.ripple = { hp(Ja, "LeftHand"), (u - 0.3) / 0.25 }
			F.age[Ja] = lerp(0.7, 0.85, seg(u, 0.3, 0.5))
			S.jaceAge = F.age[Ja]
			F.flash = flashAt(u, 0.85, d)
			return faceCam(Ja, u, 1.0, 3.7, 0.6) -- face + tapping hand low in frame
		end },
	{ t = 44.48, line = "Grandma spent hers on her own mistakes.", g = "s",
		f = function(L, u)
			if cut2(u, 0.5) then grandmaHands(L, 1) F.fill = headP(Gr) + Gr.m:GetPivot().LookVector * 2.5 + V(0, 0.6, 0) return faceCam(Gr, su(u, 0.5, 1), -0.7, 3.4, 0.3) end
			return grandmaHands(L, su(u, 0, 0.5))
		end },
	{ t = 46.72, line = "I spent mine on someone else.", g = "n",
		enter = function() labStand(Hr, -19.5) labStand(Mi, -17.4) labStand(Ja, -13.5, 150) end,
		f = function(L, u)
			arm(Hr, "Left", 45, -15, 50) arm(Hr, "Right", 45, 15, 50)
			F.pencil = partCF(Hr, "RightHand") * PENCIL_OFF
			F.bloom = 0.5
			return faceCam(Hr, u, 0.7, 3.9, 0.7) -- happy face, pencil + aged hands low in frame
		end },
	{ t = 48.28, line = "A few years of my hands for her whole face.", g = "n",
		enter = function() labStand(Hr, -19.5) labStand(Mi, -17.4) labStand(Ja, -13.5, 150) end,
		f = function(L, u)
			selfie(Ja, 1)
			arm(Hr, "Right", 30, 10, 40)
			F.pencil = partCF(Hr, "RightHand") * PENCIL_OFF
			P(Mi, "Head", 6 * abs(sin(L * 9)), 20, 0) P(Mi, "UpperTorso", 3 * abs(sin(L * 9)), 0, 0)
			P(Hr, "Head", 0, -15, 0)
			F.bloom = 0.5
			local m = mid(headP(Hr), headP(Mi))
			return look(m + V(-1.2, 1.4, -4.8):Lerp(V(1.2, 1.2, -4.3), ease(u)), m - V(0, 0.15, 0)), 42, m
		end },
	{ t = 50.14, line = "They were saved for her.", g = "n",
		enter = function() labStand(Hr, -19.5) labStand(Mi, -17.4) labStand(Ja, -13.5, 150) end,
		f = function(L, u)
			selfie(Ja, 1)
			tapPose(Hr, 1, 0.6)
			F.bloom = 0.6
			-- starts on the happy hero face, eases back to a wide of the three
			local fc = faceCam(Hr, 0, 0.6, 3.6, 0.5)
			local h = headP(Hr)
			local pos = fc.Position:Lerp(h + V(6, 4, -8), ease(seg(u, 0.15, 1)))
			return look(pos, h:Lerp(mid(h, headP(Mi)), ease(u)) - V(0, 0.4, 0)), lerp(40, 50, ease(u)), h
		end },
}
local BEATS = { B1, B2 }
local START_FACES = {
	{ hero = "Determined", jace = "Smirk", mia = "Happy", teacher = "Happy", grandma = "Sad" },
	{ hero = "Straining", jace = "Smirk", mia = "Shocked", teacher = "Happy", grandma = "Sad" },
}
-- faces per beat (from beats_p1/p2.json "face")
local FACE1 = {
	{ hero = "Determined" }, { hero = "Determined" }, {}, {}, { jace = "Smirk" }, { jace = "Smirk" }, { hero = "Worried" },
	{ grandma = "Sad" }, { grandma = "Crying", hero = "Crying" }, { hero = "Determined" }, { teacher = "Happy" },
	{ mia = "Happy" }, { mia = "Happy", hero = "Happy" }, { hero = "Sad" }, { jace = "Smirk" }, { hero = "Worried" }, {},
	{ hero = "Shocked", jace = "Smirk" }, { mia = "Happy" }, { jace = "Smirk", mia = "Shocked" }, { mia = "Shocked" },
	{ teacher = "Happy", jace = "Smirk" }, { hero = "Straining" }, { hero = "Worried" }, { grandma = "Sad" },
	{ mia = "Shocked" }, { hero = "Determined" },
}
local FACE2 = {
	{ hero = "Straining", mia = "Shocked" }, { hero = "Determined" }, { jace = "Smirk", hero = "Determined" }, { hero = "Worried", jace = "Smirk" },
	{ hero = "Straining" }, { hero = "Straining" }, { jace = "Smirk", hero = "Shocked" }, { hero = "Crying" }, { hero = "Determined" }, {},
	{ jace = "Smirk" }, { jace = "Smirk" }, { hero = "Determined" }, { hero = "Determined" }, { jace = "Smirk" },
	{ mia = "Happy" }, { jace = "Smirk", hero = "Sad" }, { hero = "Sad" }, { mia = "Shocked", hero = "Sad" }, { hero = "Sad" },
	{ hero = "Sad" }, { mia = "Happy" }, { mia = "Happy", hero = "Happy" }, { jace = "Smirk" }, { grandma = "Sad" },
	{ hero = "Happy" }, { hero = "Happy", mia = "Happy" }, { hero = "Happy", mia = "Happy" },
}
for i, f in FACE1 do B1[i].face = f end
for i, f in FACE2 do B2[i].face = f end
local FACEKEY = { hero = { "Hero", "LittleHero" }, mia = { "Mia" }, jace = { "Jace" }, teacher = { "Teacher" }, grandma = { "Grandma" } }
function applyFaces(map) -- assigns the forward-declared local
	for k, emo in map do
		for _, n in FACEKEY[k] or {} do setFace(R[n], emo) end
	end
end

-- ================= prop update =================
local function hide(x) if typeof(x) == "Instance" then if x:IsA("Model") then x:PivotTo(OFF) else x.CFrame = OFF end end end
local function streamBetween(p, a, b)
	local d = (b - a).Magnitude
	p.Size = V(math.max(d, 0.05), p.Size.Y, p.Size.Z)
	p.CFrame = CFrame.lookAt((a + b) / 2, b) * CFrame.Angles(0, rad(90), 0)
end

local function applyProps(tI, T)
	-- bottles
	local restW, restA = W0, A0
	if S.swap then restW, restA = A0, W0 end
	local handCF = partCF(Ja, "RightHand") * HOLD_OFF
	for name, rest in { Water = restW, Acid = restA } do
		local cf = (F.bcf and F.bcf[name]) or rest
		if F.held == name then cf = rest:Lerp(handCF, F.holdK or 1) end
		PR[name]:PivotTo(cf)
	end
	PR.Beaker:PivotTo(B0)
	PR.BeakerLiquid.Color = Color3.fromRGB(130, 230, 140):Lerp(Color3.fromRGB(200, 255, 120), F.liquidGlow or (F.crack or 0))
	-- crack lines on the +X side (toward Mia)
	local ck = F.crack or 0
	for i, c in CRACK do
		local p = PR.Crack[i]
		if ck > (i - 1) / #CRACK * 0.6 then
			local len = c[3] * clamp(ck * 1.5 - (i - 1) * 0.15, 0.05, 1)
			p.Size = V(0.04, len, 0.04)
			p.CFrame = B0 * CF(0.51, c[1], c[2]) * CFrame.Angles(0, 0, rad(i % 2 == 0 and 25 or -20)) * CF(0, len / 2, 0)
		else hide(p) end
	end
	-- shards fly from the crack toward Mia's face, stop at F.shards (0..1)
	if F.shards and F.shards > 0 and Mi then
		local a, b = B0.Position + V(0.5, 0.8, 0), headP(Mi)
		for _, s in SH do
			local k = F.shards
			s.p.CFrame = CF(a:Lerp(b, k * 0.75) + s.off * k * 0.5 - V(0, 0.25 * k, 0)) * CFrame.Angles(s.spin.X * k, s.spin.Y * k, s.spin.Z * k)
		end
	else for _, s in SH do hide(s.p) end end
	-- soft fill light for sepia grandma shot
	if not PR.Fill then
		local fp = part(PF, "Fill", V(0.2, 0.2, 0.2), OFF, Color3.new(1, 1, 1), nil, 1)
		local fl = Instance.new("PointLight") fl.Color = Color3.fromRGB(255, 225, 180) fl.Range = 12 fl.Brightness = 0.8 fl.Parent = fp -- v3 cap: no blown sepia
		PR.Fill = fp
	end
	if F.fill then PR.Fill.CFrame = CF(F.fill) else hide(PR.Fill) end
	-- smoke
	for i, p in PR.Smoke do
		if F.smoke then
			local ph = ((tI * 0.35) + i / #PR.Smoke) % 1
			p.Size = V(1, 1, 1) * lerp(0.35, 1.3, ph)
			p.Transparency = lerp(0.45, 1, ph)
			p.CFrame = CF(beakerTop() + V(sin(i * 2.1 + tI) * 0.3 * ph, ph * 2.5, cos(i * 1.7) * 0.3 * ph))
		else hide(p) end
	end
	-- pour stream
	if F.stream then
		PR.Stream.Color = F.stream == "Acid" and Color3.fromRGB(200, 240, 140) or Color3.fromRGB(190, 225, 255)
		PR.Stream.Transparency = F.stream == "Acid" and 0.3 or 0.55
		streamBetween(PR.Stream, heldMouth(F.stream).Position, beakerTop() - V(0, 0.6, 0))
	else hide(PR.Stream) end
	-- tap ripple
	if F.ripple and F.ripple[2] >= 0 and F.ripple[2] <= 1 then
		local k = F.ripple[2]
		local d = lerp(0.3, 1.6, ease(k))
		PR.Ripple.Size = V(0.05, d, d) -- thin ring around the wrist
		PR.Ripple.Transparency = lerp(0.55, 1, k)
		PR.Ripple.CFrame = CF(F.ripple[1]) * CFrame.Angles(0, 0, rad(90))
		PR.RippleLight.Brightness = 1 + 3 * (1 - k)
		if S.ripK < 0 or k < S.ripK - 0.2 then pcall(function() PR.Burst:Emit(26) end) end -- new tap (or loop wrap)
		S.ripK = k
		F.flash = math.max(F.flash or 0, 0.4 * (1 - k * 3))
		F.tapK = math.max(F.tapK or 0, clamp(1 - k * 2.5, 0, 1))
	else hide(PR.Ripple) S.ripK = -1 end
	-- rewind streaks (spiral backwards around a centre)
	for i, p in PR.Streaks do
		if F.streak then
			local a = -F.streak[2] * 12 + i * (math.pi / 4)
			local c = F.streak[1]
			p.CFrame = CFrame.lookAt(c + V(cos(a) * 1.6, sin(a * 0.5 + i) * 0.8, sin(a) * 1.6), c + V(cos(a + 0.6) * 1.6, 0, sin(a + 0.6) * 1.6))
			p.Transparency = 0.2 + 0.5 * F.streak[2]
		else hide(p) end
	end
	-- phones
	if Ja then PR.Phone:PivotTo(partCF(Ja, "LeftHand") * PHONE_OFF) end
	PR.Phone.Flash.Light.Brightness = 2.5 * (F.flash or 0)
	if F.phone2 then PR.Phone2:PivotTo(F.phone2) else hide(PR.Phone2) end
	if F.milk then
		PR.Cup:PivotTo(F.milk[1])
		local k = F.milk[2]
		local floor = V(101.9, 0.06, -400.4)
		PR.Puddle.Size = V(0.03, 1.8 * k + 0.01, 1.8 * k + 0.01)
		PR.Puddle.CFrame = CF(floor) * UPR
		if k > 0.05 then streamBetween(PR.MilkStream, (F.milk[1] * CF(0, 0.6, 0)).Position, floor) else hide(PR.MilkStream) end
	else hide(PR.Cup) hide(PR.Puddle) hide(PR.MilkStream) end
	PR.Pencil:PivotTo(F.pencil or PEN0)
	-- clock (3:14 pm, runs with clockT)
	local sec = S.clockT
	local center = CLK
	local function hand(p, ang, len) p.CFrame = center * CFrame.Angles(0, 0, -ang) * CF(0, len / 2 - 0.1, 0.14) end
	hand(PR.HourH, (sec / 43200) * 2 * math.pi, 0.7)
	hand(PR.MinH, (sec / 3600) * 2 * math.pi, 1.0)
	hand(PR.SecH, (math.floor(sec) + (F.clockTick or 0)) / 60 * 2 * math.pi, 1.1)
	-- highlight
	PR.HL.Adornee = F.hl
	PR.HL.Enabled = F.hl ~= nil
end

-- ================= reset / play =================
local M = {}
local function allRigs() local t = {} for _, r in R do table.insert(t, r) end return t end

function M.reset()
	if not init() then return end
	for _, r in allRigs() do resetRig(r) end
	for _, r in allRigs() do r.m:PivotTo(r.pivot0) end
	stageDefault()
	S = { clockT = 15 * 3600 + 14 * 60, ageCur = 0, ageFrom = 0, swap = false, jaceAge = 0.7, grade = "n", ripK = -1 }
	F = { age = {} }
	applyProps(0, 0)
	local gr = fx("ColorCorrectionEffect", "Grade")
	gr.TintColor, gr.Saturation, gr.Contrast, gr.Brightness = G.n[1], G.n[2], G.n[3], G.n[4]
	gr.Enabled = true
	fx("DepthOfFieldEffect", "DOF").Enabled = true
	hide(PR.Fade)
end

function M.play(part)
	part = (part == 2) and 2 or 1
	if not init() then return end
	M.reset()
	local beats, total = BEATS[part], LEN[part]
	print(("[Story007] Part %d timing (video s = audio + %.1f lead)"):format(part, LEAD))
	for i, b in beats do
		local e = beats[i + 1] and beats[i + 1].t or total + TAIL
		print(("%2d  %6.2f  %5.2f  %s"):format(i, b.t + LEAD, e - b.t, b.line))
	end
	applyFaces(START_FACES[part])
	if part == 2 then S.ageCur = 0 end
	local cam = WS.CurrentCamera
	local grade = fx("ColorCorrectionEffect", "Grade")
	local dof = fx("DepthOfFieldEffect", "DOF")
	local bloom = fx("BloomEffect", "Bloom")
	local bloom0 = 0.6
	local cur, tI, last = 0, 0, os.clock()
	local t0 = os.clock()
	local endT = LEAD + total + TAIL
	local g = { G.n[1], G.n[2], G.n[3], G.n[4] }
	local rigs = allRigs()
	local rnd = Random.new(part * 31)
	local shotKey, shotT0 = nil, 0
	local BLUE = Color3.fromRGB(215, 230, 255)
	while true do
		local now = os.clock()
		local T = now - t0
		if T >= endT then break end
		local dt = math.min(now - last, 0.1) last = now
		local t = math.max(0, T - LEAD)
		local i = cur
		while beats[i + 1] and t >= beats[i + 1].t do i += 1 end
		if i == 0 then i = 1 end
		local b = beats[i]
		if i ~= cur then
			cur = i
			stageDefault()
			S.ageFrom = S.ageCur
			if b.ageTo then S.ageCur = b.ageTo end
			if b.enter then pcall(b.enter) end
			applyFaces(b.face or {})
		end
		local d = (beats[i + 1] and beats[i + 1].t or total + TAIL) - b.t
		local L = t - b.t
		local u = clamp(L / d, 0, 1)
		tI += dt * (b.ts or 1)
		F = { age = {}, g = b.g, clockSpeed = 1, shot = 1 }
		for _, r in rigs do idle(r, tI) end
		sit(Gr)
		local ok, ccf, fov, focus = pcall(b.f, L, u, d, b)
		if not ok then warn("[Story007] beat " .. i .. ": " .. tostring(ccf)) ccf = nil end
		-- new shot (beat change or in-beat cut): restart push-in clock, new pose variant on everyone
		local key = i * 10 + F.shot
		if key ~= shotKey then
			shotKey, shotT0 = key, T
			for _, r in rigs do newPose(r, rnd) end
		end
		local shotE = T - shotT0
		for _, r in rigs do
			if r.m:GetPivot().Y < -100 then table.clear(r.off) else applyJoints(r) end -- perf: skip off-stage rigs
		end
		-- ages
		local heroAge = b.ageTo and lerp(S.ageFrom, S.ageCur, seg(u, b.ageAt or b.tapAt or 0.4, (b.ageAt or b.tapAt or 0.4) + 0.3)) or S.ageCur
		if part == 1 then heroAge = 0 end
		setAge(Hr, F.age[Hr] or heroAge)
		setAge(Ja, F.age[Ja] or S.jaceAge)
		setAge(Gr, 1)
		for _, r in EX do setAge(r, F.age[r] or 0) end
		-- tap ripple for tap beats
		if b.tapAt and not F.ripple then F.ripple = { hp(Hr, "LeftHand"), (u - b.tapAt) / 0.3 } end
		S.clockT += dt * F.clockSpeed
		applyProps(tI, T)
		-- grade
		local tg = G[F.g or "n"]
		local a = math.min(1, dt * 10)
		g[1] = g[1]:Lerp(tg[1], a) g[2] = lerp(g[2], tg[2], a) g[3] = lerp(g[3], tg[3], a) g[4] = lerp(g[4], tg[4], a)
		local fade = 0
		if part == 2 then fade = seg(T, endT - TAIL, endT) end -- Part 1 cliffhanger NEVER fades (hard cut on the freeze)
		-- tap payoff: instant blue rewind tint + brightness + bloom spike (bypasses the slow grade lerp)
		local tk = F.tapK or 0
		grade.TintColor, grade.Saturation, grade.Contrast = g[1]:Lerp(BLUE, 0.5 * tk), g[2], g[3] + 0.05 * tk
		grade.Brightness = g[4] + 0.04 * (F.flash or 0) - fade -- flash capped: faces must stay readable
		bloom.Intensity = bloom0 + (F.bloom or 0) + 0.12 * (F.flash or 0) + 0.2 * tk
		-- camera
		if ccf then
			local sh = F.shake or 0
			local shake = CFrame.Angles(math.noise(T * 4, 1) * 0.03 * sh, math.noise(T * 4, 2) * 0.03 * sh, math.noise(T * 4, 3) * 0.015 * sh)
			-- slow push-in on every shot (eased start, ~4%/s of subject distance) + subtle smooth handheld drift
			local dist = focus and (focus - ccf.Position).Magnitude or 4
			local push = math.min(dist * 0.04 * shotE * ease(shotE / 0.6), dist * 0.15)
			local hand = CFrame.Angles(math.noise(T * 0.6, 4) * 0.006, math.noise(T * 0.6, 5) * 0.006, math.noise(T * 0.5, 6) * 0.004)
			ccf = ccf * CF(0, 0, -push) * hand
			cam.CameraType = Enum.CameraType.Scriptable
			cam.CFrame = ccf * shake * ROLL
			cam.FieldOfView = fov or 50
			if focus then
				dof.FocusDistance = (focus - ccf.Position).Magnitude
				dof.InFocusRadius = F.focusR or 1.5
				dof.NearIntensity, dof.FarIntensity = 0.5, 0.45
			end
		end
		if fade > 0 then
			PR.Fade.CFrame = cam.CFrame * CF(0, 0, -0.6)
			PR.Fade.Transparency = 1 - fade
		else hide(PR.Fade) end
		task.wait()
	end
	if part == 2 then -- hold black only after the series finale; Part 1 holds its last image
		PR.Fade.CFrame = cam.CFrame * CF(0, 0, -0.6)
		PR.Fade.Transparency = 0
		grade.Brightness = -1
	end
	print(("[Story007] Part %d done in %.2fs"):format(part, os.clock() - t0))
end

-- Run after EVERY take (owner rule): undo the vertical-video roll and hand the viewport back to the editor.
function M.resetCamera()
	-- Swap in a FRESH camera: Studio's editor default (free right-mouse look). Changing CameraType on the
	-- old camera is not enough - something (capture tools) can leave it Scriptable and lock the viewport.
	local old = workspace.CurrentCamera
	local p, look = old.CFrame.Position, old.CFrame.LookVector
	local cam = Instance.new("Camera")
	cam.Name = "Camera"
	cam.FieldOfView = 70
	cam.CFrame = CFrame.lookAt(p, p + look, Vector3.yAxis)
	cam.Focus = CFrame.new(p + look * 20)
	cam.Parent = workspace
	workspace.CurrentCamera = cam
	for _, c in old:GetChildren() do c.Parent = cam end
	old:Destroy()
	if PR and PR.Fade then PR.Fade.Transparency = 1 end
	print("[Story007] camera reset: fresh editor camera, roll 0, FOV 70")
end

function M.setMode(m) JOINT_MODE = m print("[Story007] JOINT_MODE = " .. m) end

-- Quick check that driving joints moves limbs in Edit mode.
function M.test()
	if not init() then return end
	local h = Hr.m:FindFirstChild("LeftHand")
	if not h then warn("no LeftHand") return end
	local p0 = h.Position
	arm(Hr, "Left", 90, 0, 0) applyJoints(Hr)
	task.wait(0.1)
	local p1 = h.Position
	print(("[Story007] test: LeftHand moved %.2f studs (want > 1). mode=%s. bench TOP=%.2f riser DY=%.2f"):format((p1 - p0).Magnitude, JOINT_MODE, TOP, DY))
	applyJoints(Hr)
end

M.R = R
M.clearShot = function(...) return clearShot(...) end
_G.Story007 = M
print("[Story007] loaded: task.spawn(_G.Story007.play, 1) / (…, 2); _G.Story007.reset(); _G.Story007.test()")
return M
