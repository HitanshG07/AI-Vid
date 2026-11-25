--!nocheck
-- story002_cutscene.luau: live engine exported from Studio (ServerStorage.S13Src), comments stripped. 62 beats, TIMES table = first-word times from words.json.
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local WS = workspace
local V, CF = Vector3.new, CFrame.new
local rad, sin, cos, abs, clamp = math.rad, math.sin, math.cos, math.abs, math.clamp
local LEAD, TAIL, LEN = 0.3, 0.4, 58.3
local TIMES = { 0.0, 0.42, 1.54, 2.28, 3.58, 4.64, 5.9, 7.22, 7.66, 9.02, 9.56, 10.72, 11.42, 12.52, 14.48, 15.2, 16.72, 18.52, 19.48, 20.06, 20.46, 21.38, 22.08, 23.16, 24.28, 24.5, 25.26, 26.38, 26.54, 27.4, 29.18, 29.44, 30.18, 31.34, 32.72, 33.48, 34.18, 34.84, 35.2, 36.12, 37.5, 38.84, 39.82, 40.34, 41.56, 41.74, 42.62, 43.84, 45.12, 45.76, 46.46, 47.7, 48.18, 49.68, 50.96, 52.26, 52.46, 54.08, 54.92, 55.44, 56.48, 56.88 } -- beat start = first-word time from stories/002_heat-footsteps/words.json (ONE place to refresh)
local ROLL = CFrame.Angles(0, 0, rad(90))
local DUTCH = CFrame.Angles(0, 0, rad(2.5))
local SGN = { fwd = 1, out = 1, down = 1, left = 1 }
local OFF = CF(900, -300, 0)
local DT = 1
local HOT_T, HOT_END = 37.62, 43.62
local ANIM = { walk = "rbxassetid://180426354", idle = "rbxassetid://180435571" }
local EMOS = { "neutral", "grin", "scared", "shocked", "determined", "proud", "eyeless" }
local NAMES = { "Theo", "June", "Jogger", "VanDriver", "Extra_Woman", "Extra_Man", "Strider1", "Strider2", "Strider3", "X1", "X2", "X3", "X4", "X5", "X6" }
local SKIP = { "rail", "post", "lamp", "sign", "awning", "trunk", "clump", "bulb", "bank", "vent", "window", "glass", "door", "rack", "tube", "flyer", "porchroof", "ceiling", "ceilfixture" }
local PK = {
	A = { col = Color3.fromRGB(255, 70, 0), tr = 0.1, life = 3 },
	B = { col = Color3.fromRGB(255, 74, 26), tr = 0.2, life = 4, range = 6, br = 2 },
	C = { col = Color3.fromRGB(255, 244, 224), tr = 0, life = 1e9, range = 6, br = 1.2, steam = true },
	E = { col = Color3.fromRGB(255, 140, 60), tr = 0.55, life = 2.5 },
	D = { col = Color3.fromRGB(70, 80, 98), tr = 0.45, life = 1e9, mat = Enum.Material.SmoothPlastic },
}

local function ease(x) x = clamp(x, 0, 1) return x * x * (3 - 2 * x) end
local function seg(u, a, b) return ease((u - a) / (b - a)) end
local function lerp(a, b, x) return a + (b - a) * x end
local function lerpA(a, b, x) return a + (((b - a + 180) % 360) - 180) * x end
local function yawTo(a, b) return math.deg(math.atan2(-(b.X - a.X), -(b.Z - a.Z))) end
local function fwdOf(y) return V(-sin(rad(y)), 0, -cos(rad(y))) end
local function arc(a, b, k, h) return a:Lerp(b, k) + V(0, h * sin(math.pi * clamp(k, 0, 1)), 0) end

local CACHE = {}
local function W(o, k, v)
	if not o then return end
	local c = CACHE[o]
	if not c then c = {} CACHE[o] = c end
	if c[k] ~= v then c[k] = v o[k] = v end
end

local FACES = {
	neutral = "rbxassetid://70950815478959", scared = "rbxassetid://94514852927815", shocked = "rbxassetid://103057607693548",
	grin = "rbxassetid://96253429845051", determined = "rbxassetid://109687999939498", proud = "rbxassetid://96477668083717",
	eyeless = "",
}
local CASTD = {
	Theo = { gender = "boy", scale = 1.0, shirt = 12329928029, pants = 134609569320601, hair = "98588731108499", hat = "17500690164", skin = Color3.fromRGB(234, 190, 150), face = "neutral" },
	June = { gender = "girl", scale = 0.7, shirt = 90274186166468, pants = 14075581338, hair = "140124368601570", skin = Color3.fromRGB(255, 220, 190), face = "grin" },
	Jogger = { gender = "man", scale = 1.08, shirt = 2885430411, pants = 140429444258386, hair = "120646937583722", skin = Color3.fromRGB(205, 150, 110), face = "grin" },
	VanDriver = { gender = "man", scale = 1.08, shirt = 3568313512, pants = 12858384874, hair = "139671521768286", skin = Color3.fromRGB(176, 124, 92), face = "neutral" },
	Extra_Woman = { gender = "woman", scale = 1.02, shirt = 18566797626, pants = 5498774219, hair = "129421843016867", skin = Color3.fromRGB(225, 175, 135), face = "neutral" },
	Extra_Man = { gender = "man", scale = 1.08, shirt = 4593507067, pants = 3234753288, hair = "124340390453001", skin = Color3.fromRGB(110, 75, 55), face = "neutral" },
	Strider = { gender = "man", scale = 1.4, shirt = 17181790240, pants = 122205461150104, hair = "", skin = Color3.fromRGB(200, 200, 205), face = "eyeless" },
}
local XV = { X1 = { "Extra_Woman", Color3.fromRGB(150, 105, 75), 1.0 }, X2 = { "Extra_Man", Color3.fromRGB(235, 195, 160), 1.05 }, X3 = { "Jogger", Color3.fromRGB(110, 75, 55), 1.1 },
	X4 = { "Extra_Woman", Color3.fromRGB(255, 222, 195), 0.98 }, X5 = { "Extra_Man", Color3.fromRGB(205, 150, 110), 1.1 }, X6 = { "VanDriver", Color3.fromRGB(235, 195, 160), 1.04 } }
for k, v in XV do local c = table.clone(CASTD[v[1]]) c.skin, c.scale = v[2], v[3] CASTD[k] = c end
local CASTM = {}
function CASTM.setFace(model, emotion)
	local h = model:FindFirstChild("Head")
	if not h then return end
	local d = h:FindFirstChild("face") or h:FindFirstChildOfClass("Decal")
	if not d then d = Instance.new("Decal") d.Name, d.Face, d.Parent = "face", Enum.NormalId.Front, h end
	d.Texture = assert(FACES[emotion], "unknown face " .. tostring(emotion))
end
function CASTM.build(key, name, x, floorY, z, yawDeg, parent)
	local o = assert(CASTD[key], "unknown cast member " .. key)
	assert(o.gender, "cast entry missing gender (owner rule 2026-11-19)")
	local d = Instance.new("HumanoidDescription")
	d.Shirt, d.Pants, d.HairAccessory = o.shirt, o.pants, o.hair
	if o.hat then d.HatAccessory = o.hat end
	for _, k in { "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" } do d[k] = o.skin end
	local m = Players:CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R6)
	m.Name = name
	if o.scale then m:ScaleTo(o.scale) end
	m:PivotTo(CF(x, floorY + 5, z) * CFrame.Angles(0, rad(yawDeg or 0), 0))
	if key == "Strider" then
		local torso = m:FindFirstChild("Torso")
		if torso then
			local s = o.scale
			local t = Instance.new("Part")
			t.Name, t.Size, t.Color, t.Material = "CoatTail", V(2.2, 2.4, 0.2) * s, Color3.fromRGB(20, 20, 20), Enum.Material.SmoothPlastic
			t.CanCollide, t.CanQuery, t.CanTouch, t.Massless, t.Anchored = false, false, false, true, false
			t.CFrame = torso.CFrame * CF(0, -1.75 * s, 0.55 * s)
			local w = Instance.new("WeldConstraint") w.Part0, w.Part1, w.Parent = torso, t, t
			t.Parent = m
		end
	end
	local low = math.huge
	for _, p in m:GetChildren() do if p:IsA("BasePart") then low = math.min(low, p.Position.Y - p.Size.Y / 2) end end
	m:PivotTo(m:GetPivot() + V(0, floorY - low, 0))
	for _, p in m:GetDescendants() do if p:IsA("BasePart") then p.Anchored = (p.Name == "HumanoidRootPart") end end
	m.Parent = parent or WS
	CASTM.setFace(m, o.face)
	return m
end

local R, RP, RPC, F = {}, nil, nil, {}
local S = { lastT = -1, frame = 0 }
local JN = { RS = "Right Shoulder", LS = "Left Shoulder", RH = "Right Hip", LH = "Left Hip", N = "Neck", RJ = "RootJoint" }

local function skipHit(inst)
	local n = (inst.Name .. " " .. (inst.Parent and inst.Parent.Name or "")):lower()
	for _, s in SKIP do if n:find(s, 1, true) then return true end end
	return false
end
local function inLaund(x, z) return x > 884 and x < 916 and z > 59 and z < 81 end
local function inHome(x, z) return x > 889 and x < 911 and z > 131 and z < 149 end
local function groundY(x, z)
	if not RP then return 0.3 end
	local y = (inLaund(x, z) or inHome(x, z)) and 12 or 60
	for _ = 1, 4 do
		local hit = WS:Raycast(V(x, y, z), V(0, -(y + 20), 0), RP)
		if not hit then return 0 end
		if not skipHit(hit.Instance) then return hit.Position.Y end
		y = hit.Position.Y - 0.05
	end
	return 0.3
end

local function register(m)
	local r = { m = m, j = {}, off = {}, ph = (#m.Name * 1.7) % 6 }
	for k, n in JN do
		local mt = m:FindFirstChild(n, true)
		if mt and mt:IsA("Motor6D") then
			local b = mt:GetAttribute("S13Base")
			if not b then b = mt.C0 mt:SetAttribute("S13Base", b) end
			mt.C0 = b
			mt.Transform = CFrame.identity
			r.j[k] = { m6 = mt, base = b }
		end
	end
	m:PivotTo(OFF)
	r.head = m:FindFirstChild("Head")
	local ok, s = pcall(function() return m:GetScale() end)
	r.s = ok and s or 1
	local low = math.huge
	for _, p in m:GetChildren() do if p:IsA("BasePart") then low = math.min(low, p.Position.Y - p.Size.Y / 2) end end
	r.baseY = m:GetPivot().Y - low
	r.strider = m.Name:find("Strider") ~= nil
	local hum = m:FindFirstChildOfClass("Humanoid")
	if hum then hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
	R[m.Name] = r
	return r
end

local function P(r, k, x, y, z) if r then r.off[k] = (r.off[k] or CFrame.identity) * CFrame.Angles(rad(x), rad(y), rad(z)) end end
local function limb(r, k, fwd, out)
	local s = (k == "RS" or k == "RH") and 1 or -1
	P(r, k, -s * fwd * SGN.fwd, 0, s * (out or 0) * SGN.out)
end
local function head(r, down, left) P(r, "N", down * SGN.down, 0, (left or 0) * SGN.left) end
local function torso(r, lean, left) P(r, "RJ", lean * SGN.down, 0, (left or 0) * SGN.left) end
local function applyJ(r)
	for k, j in r.j do j.m6.C0 = j.base * (r.off[k] or CFrame.identity) end
	table.clear(r.off)
end

local function park(r)
	if r.mk == "park" then return end
	r.on, r.mode, r.mk, r.gy, r.gh, r.lp, r.lpp = false, nil, "park", nil, nil, nil, nil
	local p = r.park
	r.m:PivotTo(CF(p.X, groundY(p.X, p.Z) + r.baseY, p.Z) * CFrame.Angles(0, rad(90), 0))
end
local function place(r, x, z, yaw, mode, dy)
	if not r then return end
	if not x then park(r) return end
	r.mode, r.mk, r.pf = mode, nil, S.frame
	r.on, r.x, r.z, r.yaw, r.fwd = true, x, z, yaw or 0, fwdOf(yaw or 0)
	local rot = CFrame.Angles(0, rad(r.yaw), 0)
	local y
	if mode == "at" then y = dy + r.baseY
	elseif mode == "sit" then y = dy + r.baseY - 1.5 * r.s
	else
		local gy, h = groundY(x, z), V(x, 0, z)
		if r.gy and r.gh and (h - r.gh).Magnitude < 3 then gy = lerp(r.gy, gy, math.min(1, 10 * DT)) end
		r.gy, r.gh = gy, h
		y = gy + r.baseY + (dy or 0)
	end
	for _, j in r.j do j.m6.C0 = j.base end
	r.m:PivotTo(CF(x, y, z) * rot)
end
local function pos(r) return r.m:GetPivot().Position end
local function setFace(r, e)
	if r and r.strider then e = "eyeless" end
	if r and r.emo ~= e then
		r.emo = e
		pcall(CASTM.setFace, r.m, e)
	end
end
local function partCF(r, n) local p = r.m:FindFirstChild(n) return p and p.CFrame or r.m:GetPivot() end

local function idle(r, T) r.idleOK = true head(r, 0, 6 * sin(T * 0.31 + r.ph) * sin(T * 0.13 + 2 * r.ph)) end
local function walk(r) r.loco = "walk" end
local function run(r) r.loco = "run" torso(r, 4, 0) end
local function wave1(r, k, L, T, dur)
	local a = 1 - seg(L, (dur or 0.8) - 0.2, dur or 0.8)
	if a > 0 then limb(r, k, (8 + 10 * sin(T * 11)) * a, 125 * a) end
end
local function point(r, k) limb(r, k or "RS", 90, 0) end
local function hug(r) limb(r, "RS", 85, -12) limb(r, "LS", 85, -12) end
local function ears(r) limb(r, "RS", 170, 25) limb(r, "LS", 170, 25) end
local function armsOut(r) limb(r, "RS", 10, 60) limb(r, "LS", 10, 60) end
local function stomp(r, T, running)
	if running then run(r) else walk(r) end
	local k = sin(T * (running and 11 or 8))
	if k > 0 then limb(r, "RH", 70 * k) else limb(r, "LH", -70 * k) end
end
local function throwArm(r, L) limb(r, "RS", lerp(200, 40, seg(L, 0.05, 0.35)), 0) end
local function sniff(r, T) head(r, 12 + 7 * math.max(0, sin(T * 13)), 0) end

local PROPF
local function safe(p)
	if inHome(p.X, p.Z) then return V(clamp(p.X, 891.5, 908.5), clamp(p.Y, 1.2, 11.8), clamp(p.Z, 133, 146.8)) end
	if inLaund(p.X, p.Z) then return V(clamp(p.X, 886, 914), clamp(p.Y, 1.2, 12.5), clamp(p.Z, 61, 79)) end
	return V(p.X, math.max(p.Y, groundY(p.X, p.Z) + 1.0), p.Z)
end
local function guard(p, tg)
	if not RPC then return p end
	local d = p - tg
	local m = d.Magnitude
	if m < 0.5 then return p end
	local dir, from = d.Unit, tg
	for _ = 1, 4 do
		local hit = WS:Raycast(from, p + dir * 1.5 - from, RPC)
		if not hit then return p end
		local hd = (hit.Position - tg).Magnitude
		if hit.Instance.Transparency < 0.25 and hd >= 2 then return tg + dir * math.min(m, hd - 1.5) end
		from = hit.Position + dir * 0.05
	end
	return p
end
local function clearShot(p, tg, r)
	local inc = {}
	for _, o in R do if o ~= r and o.on then table.insert(inc, o.m) end end
	if PROPF then table.insert(inc, PROPF) end
	if #inc == 0 then return p end
	local prm = RaycastParams.new()
	prm.FilterType, prm.FilterDescendantsInstances = Enum.RaycastFilterType.Include, inc
	local right = (tg - p):Cross(V(0, 1, 0))
	right = right.Magnitude > 0.01 and right.Unit or V(1, 0, 0)
	for _, o in { V(), V(0, 0.6, 0), right * 0.8, -right * 0.8, V(0, 1.2, 0) + right * 1.2, V(0, 1.2, 0) - right * 1.2, V(0, 2, 0) } do
		local q, clear = p + o, true
		for _, aim in { tg, tg - V(0, 0.7, 0) } do
			local hit = WS:Spherecast(q, 0.4, (aim - q) * 0.92, prm)
			if hit and hit.Instance.Transparency < 0.9 then clear = false break end
		end
		if clear then return q end
	end
	return p
end
local function look(p, tg, r)
	p = safe(p)
	if r then p = clearShot(p, tg, r) end
	return CFrame.lookAt(guard(p, tg), tg)
end
local function faceP(r, d, side, up, low)
	local h, f, s = r.head.Position, r.fwd, r.s
	return h + f * d * s + V(-f.Z, 0, f.X) * (side or 0.8) * s + V(0, (up or 0.3) * s, 0), h - V(0, (low or 0.9) * s, 0)
end
local function faceCam(r, d, side, up, fov, low) local p, tg = faceP(r, d, side, up, low) return look(p, tg, r), fov or 48, r.head.Position end
local function shot(p, tg, fov) return look(p, tg), fov or 50, tg end
local function track(r, ahead, side, up, tup, fov)
	local p, f = pos(r) - V(0, r.baseY, 0), r.fwd
	F.raw = true
	return shot(p + f * ahead + V(-f.Z, 0, f.X) * side + V(0, up, 0), p + V(0, tup, 0), fov)
end
local function pull(u, p1, t1, p2, t2, f1, f2) local k = ease(u / 0.35) local tg = t1:Lerp(t2, k) return look(p1:Lerp(p2, k), tg), lerp(f1, f2, k), tg end

local ST = {
	ext = { Extra_Man = { 921, -12, 90 }, Extra_Woman = { 858, -10, -90 }, Theo = { 878, 10, -90 } },
	run = { Extra_Man = { 920, -12, 90 }, Extra_Woman = { 884, -10, -90 } },
	roof1 = { Strider1 = { 878, -19.6, 180 } },
	jog = { Jogger = { 912, -10, 90 }, Strider1 = { 878, -19.6, 180 } },
	boom = { Strider1 = { 868, -16.5, 180 } },
	rubble = { Strider1 = { 868, -15, 180 }, Strider2 = { 863.5, -14.2, 160 }, Strider3 = { 872.5, -14.5, 200 }, Jogger = { 871, -12, -90 } },
	slow = { Extra_Woman = { 898, -10, -90 }, Extra_Man = { 894, -12.5, -90 } },
	boots = { Theo = { 873, 14.5, 0, "sit", 2.2 } },
	van = { Strider2 = { 905, -19.6, 180 } },
	porch = { Theo = { 871.8, 15.2, 0 }, June = { 876.5, 15.2, 0 } },
	vent = { Extra_Woman = { 932, -11, -90 } },
	june = { June = { 880, 5, -60 }, Theo = { 874, 15.2, 0 } },
	cat = { June = { 905, -7.6, 0 } },
	theo = { Theo = { 874.5, 14.8, 0 }, June = { 905, -7.6, 0 } },
	roofs = { Strider1 = { 884, -19.6, 180 }, Strider2 = { 905, -19.6, 180 }, Strider3 = { 926, -19.6, 180 } },
	throw = { Theo = { 879, 9.5, 0 }, June = { 876.8, 10.8, 0 } },
	bottle = { Strider1 = { 902, 4, 90 }, Theo = { 879, 9.5, 0 }, June = { 876.8, 10.8, 0 } },
	drag = { Theo = { 941.5, -11, 180 }, June = { 941.5, -8.8, 0 } },
	door = { Strider1 = { 900, 82, 0 }, June = { 896, 76.5, 150 }, Theo = { 901.5, 74, 180 } },
	dryer = { Theo = { 900, 65.4, 0 }, June = { 887, 66, -90 } },
	out = { Theo = { 942, -16.6, 180 } },
	chase = { Theo = { 900, -1, 90 }, Strider1 = { 915, -1, 90 }, Strider2 = { 920, 1.5, 90 }, Strider3 = { 925, -3, 90 } },
	vanjump = { Theo = { 891, -0.6, 90 } },
	circle = { Strider1 = { 894, -0.6, 0 }, Strider2 = { 888, -0.6, 180 } },
	away = {},
	follow = { Strider1 = { 893, -1, -90 }, Strider2 = { 890, 1.5, -90 }, Strider3 = { 887, -3.2, -90 }, Theo = { 908.5, 8.4, 90, "at", -1.2 } },
	home = { Theo = { 872.5, 9, 180 }, June = { 876.5, 15.4, 90 } },
	sting = {},
	xm = {},
}
local function stage(name)
	local s = ST[name] or {}
	for n, r in R do
		local e = s[n]
		if not e then park(r)
		elseif r.mk ~= e then place(r, e[1], e[2], e[3], e[4], e[5]) r.mk = e end
	end
end

local function poly(pts, k)
	local segs, tot = {}, 0
	for i = 1, #pts - 2, 2 do
		local a, b = V(pts[i], 0, pts[i + 1]), V(pts[i + 2], 0, pts[i + 3])
		local l = (b - a).Magnitude
		table.insert(segs, { a, b, l })
		tot += l
	end
	local d = clamp(k, 0, 1) * tot
	for i, s in segs do
		if d <= s[3] or i == #segs then
			local p = s[1] + (s[2] - s[1]).Unit * math.min(d, s[3])
			return p.X, p.Z, yawTo(s[1], s[2])
		end
		d -= s[3]
	end
end
local function mv(r, pts, k, running) local x, z, y = poly(pts, k) place(r, x, z, y) if running then run(r) else walk(r) end return x, z end
local function faceTo(r, x, z, tx, tz) place(r, x, z, yawTo(V(x, 0, z), V(tx, 0, tz))) end

local function van(x, yaw, z, y, nodriver)
	local vcf = CF(x, y or 0.3, z or 2.5) * CFrame.Angles(0, rad(yaw or 0), 0)
	F.vanCF = vcf
	if nodriver then return vcf end
	local sp = (vcf * CF(4.3, 2.4, -1.6)).Position
	local d = R.VanDriver
	place(d, sp.X, sp.Z, -90 + (yaw or 0), "sit", sp.Y)
	limb(d, "RS", 75, -8) limb(d, "LS", 75, -8)
	return vcf
end
local function carry(jx) -- June carries Theo piggyback along the dusk sidewalk (Theo attached to June's back, both animated)
	local jn, th = R.June, R.Theo
	place(jn, jx, 11, 90) walk(jn) torso(jn, 10, 0) limb(jn, "RS", -35, 0) limb(jn, "LS", -35, 0)
	place(th, jx, 11, 90)
	limb(th, "RH", 12, 10) limb(th, "LH", 12, 10) limb(th, "RS", 100, -5) limb(th, "LS", 100, -5)
	th.m:PivotTo(partCF(jn, "Torso") * CF(0, 1.5, 1.1))
end
local SM = { { 1018, -4 }, { 1022, 6 }, { 1026, -10 } } -- Strider sink marks on the lake (lake_002.luau)

local function hold(kind, pts, n, age, s) return { kind, pts, n, age or 0.3, age or 0.3, true, s } end
local function fade(kind, pts, n, a0, a1, s) return { kind, pts, n, a0, a1, false, s } end
local TJ = { 876.5, 15.2, 873.5, 12.0, 874, 9.5, 880, 5, 905, -8.2 }
local TMAN = { 934, -12, 892, -12 }
local TJOG = { 925, -10, 884, -10, 866.5, -16.6 }
local TC = { 942, -16.6, 941, -8, 932, -1, 891, -0.6 }
local TCH = { 886, 3, 878, 7, 872.5, 10.5, 872.5, 12.6, 873.5, 14.6 }
local TLB = { 900, 80, 900, 66.5 }
local TOUT = { 897, 92, 899.5, 81.2 }
local TDRAG = { 905, -8.2, 924, -9.5, 941.5, -9.5 }

local function catAt(t) -- cat darts across the street in a zig-zag (b18..b21), ends at its rest spot (906,-9)
	local a, b = TIMES[18], TIMES[21] + 0.5
	local k = clamp((t - a) / (b - a), 0, 1)
	local function pt(q) return 906 + 6 * sin(4 * math.pi * q), -9 + 8.5 * (1 - cos(2 * math.pi * q)) end
	local x, z = pt(k)
	local x2, z2 = pt(math.min(1, k + 0.004))
	local x1, z1 = pt(math.max(0, k - 0.004))
	return x, z, math.deg(math.atan2(-(x2 - x1), -(z2 - z1))), k
end
local function catPts(t0, t1, n) local p = {} for i = 0, n - 1 do local x, z = catAt(lerp(t0, t1, i / (n - 1))) p[#p + 1] = x p[#p + 1] = z end return p end
local function cut2(u, at) if u >= at then F.shot = 2 return true end return false end
local XC = { { "Extra_Woman", 893, -8, 1 }, { "Extra_Man", 918, -9.5, -1 }, { "Jogger", 930, -6, -1 }, { "VanDriver", 880, -10.5, 1 }, { "X1", 905, -3, 1 },
	{ "X2", 922, 3.5, -1 }, { "X3", 934, 1, -1 }, { "X4", 887, 3, 1 }, { "X5", 868, -8.5, 1 }, { "X6", 898, 7.5, -1 } }
local XFACE = {} for _, c in XC do XFACE[c[1]] = "grin" end
local function xm()
	for _, n in { "NightVan", "Cat", "HotBottle", "IceBootL", "IceBootR", "SockL", "SockR", "CBMic", "DriverCap" } do F.pp[n] = OFF end
end
local function crowd(t)
	local L = t - TIMES[57]
	for _, c in XC do place(R[c[1]], c[2] + c[4] * 1.3 * L, c[3], c[4] > 0 and -90 or 90) walk(R[c[1]]) end
end
local BEATS = {
	{ t = 0.00, line = "In my town,", g = "night", st = "ext", cam = "snapZoom", face = { Extra_Man = "neutral", Extra_Woman = "neutral", Theo = "neutral" },
		tr = { fade("A", { 934, -12, 922, -12 }, 8, 2.6, 0.3) },
		f = function(L, u) place(R.Extra_Man, lerp(921, 914, u), -12, 90) walk(R.Extra_Man)
			return shot(V(934, 4.6, -2), V(918, 1.4, -12), 52) end },
	{ t = 0.74, line = "every footstep glows", g = "night", st = "ext", cam = "pullOut", vfx = { "steam_plume" },
		tr = { fade("A", { 930, -12, 914, -12 }, 8, 2.4, 0.3), fade("A", { 846, -10, 858, -10 }, 6, 2.2, 0.3) },
		f = function(L, u) place(R.Extra_Man, lerp(914, 905, u), -12, 90) walk(R.Extra_Man)
			place(R.Extra_Woman, lerp(858, 867, u), -10, -90) walk(R.Extra_Woman)
			van(lerp(845, 873, u))
			return pull(u, V(916, 2.2, -9.3), V(912.5, 0.8, -12), V(925, 12, -15.5), V(890, 2, 0), 40, 60) end },
	{ t = 1.68, line = "with your body heat", g = "night", st = "ext", cam = "pushIn",
		tr = { fade("A", { 868, 10, 878, 10 }, 6, 2.2, 0.3) },
		f = function(L, u) local x = lerp(878, 885.5, u) place(R.Theo, x, 10, -90) walk(R.Theo)
			return track(R.Theo, 9, -3.5, 3.2, 2.4, 50) end },
	{ t = 2.46, line = "for sixty seconds.", g = "night", st = "ext", cam = "pushIn", vfx = { "print_fade" },
		tr = { fade("A", { 872, 10, 892, 10 }, 8, 1.6, 0.4) },
		f = function(L, u) place(R.Theo, lerp(886, 899, u), 10, -90) walk(R.Theo)
			return shot(V(886, 8, 1), V(893, 1.5, 10), 56) end },
	{ t = 3.76, line = "Walk, it's faint.", g = "night", st = "run", cam = "pushIn", face = { Extra_Woman = "neutral" },
		tr = { fade("A", { 860, -10, 872, -10 }, 7, 2.0, 0.3) },
		f = function(L, u) local x = lerp(872, 884, u) place(R.Extra_Woman, x, -10, -90) walk(R.Extra_Woman)
			return track(R.Extra_Woman, 10, -5, 4.2, 2.6, 52) end },
	{ t = 5.16, line = "Run, it blazes.", g = "night", st = "run", cam = "snapZoom", face = { Extra_Man = "shocked" },
		tr = { fade("B", { 934, -12, 920, -12 }, 6, 1.0, 0.2) },
		f = function(L, u) place(R.Extra_Man, lerp(920, 892, u), -12, 90) run(R.Extra_Man)
			return track(R.Extra_Man, 10, -6, 3.6, 2.6, 52) end },
	{ t = 6.74, line = "Blind Striders hunt it.", g = "night", st = "roof1", cam = "pullOut", vfx = { "breath_steam" },
		tr = { hold("B", { 905, -12, 888, -12 }, 8, 0.6) },
		f = function(L, u, d, T) local s = R.Strider1 P(s, "N", 0, 25 * seg(u, 0, 0.3), 0) sniff(s, T) F.breath = s
			local p, tg = faceP(s, 4.5, 1.0, 0.2)
			return pull(u, p, tg, V(886, 26, 2), V(878, 28.5, -19), 46, 42) end },
	{ t = 7.98, line = "A jogger", g = "night", st = "jog", cam = "pushIn", face = { Jogger = "grin" },
		tr = { fade("B", { 925, -10, 912, -10 }, 6, 1.0, 0.2) },
		f = function(L, u) place(R.Jogger, lerp(912, 892, u), -10, 90) run(R.Jogger)
			return track(R.Jogger, 10.5, 5.5, 4.2, 2.8, 52) end },
	{ t = 9.12, line = "sprinted to the bakery.", g = "night", st = "jog", cam = "pushIn", face = { Jogger = "grin" },
		tr = { hold("B", { 912, -10, 884, -10 }, 10, 0.8) },
		f = function(L, u) if u > 0.88 then park(R.Jogger) else mv(R.Jogger, { 884, -10, 866.5, -16.6 }, u / 0.88, true) end
			return shot(V(882, 7, -1), V(871, 3, -13), 52) end },
	{ t = 10.36, line = "Boom.", g = "night", st = "boom", cam = "snapZoom", vfx = { "debris_burst", "snow_puff" }, ev = { "puff", V(868, 27, -18.5), 40 },
		tr = { hold("B", TJOG, 12, 1.0) },
		f = function(L) local k = clamp(L / 0.4, 0, 1)
			place(R.Strider1, 868, -16.5, 180, "at", lerp(34, 0.7, k * k))
			if k >= 1 then limb(R.Strider1, "RH", 40) limb(R.Strider1, "LH", 40) torso(R.Strider1, 20, 0) end
			F.shake = 0.3 * clamp(1 - L / 0.25, 0, 1)
			return shot(V(866, 5, 7), V(868, 13, -17), 62) end },
	{ t = 11.16, line = "Striders through the roof.", g = "night", st = "rubble", cam = "pullOut", vfx = { "dust" }, face = { Jogger = "shocked" },
		tr = { hold("B", TJOG, 12, 1.2) },
		f = function(L, u, d, T) for i, n in { "Strider1", "Strider2", "Strider3" } do head(R[n], 5, 18 * sin(T * 1.3 + i)) end
			place(R.Jogger, lerp(871, 888, u), lerp(-12, -9, u), -90) run(R.Jogger) ears(R.Jogger)
			F.dust = V(868, 2, -15)
			return pull(u, V(869.5, 9, -9), V(868, 7, -16), V(865, 8, 6), V(868, 4.5, -14), 46, 58) end },
	{ t = 12.38, line = "So we walk slow,", g = "night", st = "slow", cam = "pushIn", face = { Extra_Woman = "scared", Extra_Man = "scared" },
		tr = { fade("A", { 888, -10, 898, -10 }, 6, 2.0, 0.3), fade("A", { 884, -12.5, 894, -12.5 }, 6, 2.0, 0.3) },
		f = function(L, u) place(R.Extra_Woman, lerp(888, 896, u), -10, -90) walk(R.Extra_Woman) armsOut(R.Extra_Woman)
			place(R.Extra_Man, lerp(884, 892, u), -12.5, -90) walk(R.Extra_Man) armsOut(R.Extra_Man)
			return shot(V(903, 4.2, -3.5), V(892, 2.9, -11.5), 52) end },
	{ t = 13.52, line = "in ice boots.", g = "night", st = "boots", cam = "pushIn", vfx = { "frost_shimmer" }, face = { Theo = "neutral" },
		tr = { hold("A", { 872.5, 8.5, 872.5, 12.6, 873, 13.6 }, 5, 0.6) },
		f = function(L, u, d, T) local r = R.Theo limb(r, "RS", 45 + 12 * sin(T * 9), -6) limb(r, "LS", 45 + 12 * sin(T * 9 + 1), -6) head(r, 25, 0)
			F.frost = V(871.5, 3.4, 16.9)
			return shot(V(867, 4.6, 5), V(873, 3.2, 14.5), 50) end },
	{ t = 14.60, line = "Only the night van drives fast.", g = "night", st = "van", cam = "pullOut", vfx = { "steam_plume" }, face = { VanDriver = "neutral" },
		tr = { hold("A", { 880, 10, 899, 10 }, 8, 0.8) },
		f = function(L, u) local vx = lerp(868, 924, u) van(vx)
			local dr = R.VanDriver dr.off.LS = nil limb(dr, "LS", 30, 50)
			place(R.Strider2, 905, -19.6, 180, "at", 31.2) head(R.Strider2, 15, 0)
			return pull(u, V(vx - 4, 11.6, -1.8), V(vx - 2, 8.3, 2.5), V(916, 5.5, 13.5), V(902, 13, -8), 46, 58) end },
	{ t = 16.48, line = "My sister June", g = "night", st = "porch", cam = "pushIn", face = { June = "grin", Theo = "neutral" },
		tr = { hold("A", { 877.5, 17.2, 876.5, 15.6 }, 3, 0.5, 0.7), hold("A", { 872.5, 10, 873.5, 14.4 }, 4, 1.0) },
		f = function(L, u, d, T) limb(R.June, "RS", 85, -12) wave1(R.June, "LS", L, T, 0.6)
			return shot(V(873, 7.5, -1), V(875.5, 3.6, 15.2), 46) end },
	{ t = 17.14, line = "hugs a hot-water bottle.", g = "night", st = "porch", cam = "pushIn", vfx = { "steam_wisp" }, face = { June = "grin" },
		tr = { hold("A", { 877.5, 17.2, 876.5, 15.6 }, 3, 0.5, 0.7) },
		f = function(L, u, d, T) local r = R.June limb(r, "RS", 85 + 5 * sin(T * 6), -12) limb(r, "LS", 85 + 5 * sin(T * 6), -12)
			local ch, f = r.head.Position - V(0, 1.2 * r.s, 0), r.fwd
			return shot(V(879, 8.5, 6), V(876, 3.2, 15.2), 46) end },
	{ t = 18.58, line = "The laundromat steams all night.", g = "night", st = "vent", cam = "pushIn", vfx = { "steam_plume" }, face = { Extra_Woman = "neutral" },
		tr = { fade("A", { 922, -11, 932, -11 }, 6, 2.0, 0.3) },
		f = function(L, u) place(R.Extra_Woman, lerp(932, 944, u), -11, -90) walk(R.Extra_Woman) F.steam = V(948, 6.5, -16.6)
			return shot(V(947, 5.5, -2), V(941, 5, -16), 56) end },
	{ t = 20.36, line = "Then June saw her cat.", g = "night", st = "porch", cam = "pushIn", face = { June = "shocked" },
		tr = { hold("A", { 877.5, 17.2, 876.5, 15.6 }, 3, 0.5, 0.7) },
		f = function(L, u) local r = R.June
			place(r, 876.5, 15.2, lerpA(0, yawTo(V(876.5, 0, 15.2), V(906, 0, -9)), seg(u, 0, 0.3)))
			if u > 0.3 then point(r, "RS") else hug(r) end
			if cut2(u, 0.3) then local cx, cz = catAt(TIMES[18] + L) local cat = V(cx, 1.4, cz)
				return shot(V(cx - 3, 9, cz + 8), cat, 38) end
			return shot(V(873, 7.5, -1), V(875.5, 3.6, 15.2), 46) end },
	{ t = 21.80, line = "She ran.", g = "night", st = "porch", cam = "snapZoom", face = { June = "determined", Theo = "shocked" },
		tr = { hold("A", { 877.5, 17.2, 876.5, 15.6 }, 3, 0.5, 0.7) },
		f = function(L, u) local jx, jz, jyw = poly({ 876.5, 15.2, 873.5, 12.0, 874, 8.5 }, u) place(R.June, jx, jz, jyw, nil, 1.1 * sin(math.pi * clamp(u * 2.5, 0, 1))) run(R.June)
			faceTo(R.Theo, 874, 15.2, 874, 10) limb(R.Theo, "RS", 90, 0) torso(R.Theo, 10, 0)
			if cut2(u, 0.45) then local cx, cz = catAt(TIMES[19] + L) return shot(V(cx - 3, 9, cz + 8), V(cx, 1.5, cz), 38) end
			return shot(V(886, 8, 4), V(875, 3.2, 12), 56) end },
	{ t = 22.72, line = "Barefoot.", g = "night", st = "june", cam = "pushIn", face = { June = "determined" },
		tr = { hold("B", { 876.5, 15.2, 873.5, 12.0, 874, 9.5, 879, 5.5 }, 6, 0.4, 0.7) },
		f = function(L, u) mv(R.June, { 879, 5.5, 888, 1 }, u, true)
			return track(R.June, 7, 3.5, 2.6, 1.3, 46) end },
	{ t = 23.38, line = "Her prints blazed.", g = "night", st = "cat", cam = "pullOut", vfx = { "ignite" }, face = { June = "grin" },
		tr = { hold("B", TJ, 16, 0.4, 0.7) },
		f = function(L, u) local r = R.June faceTo(r, 905, -7.6, 906, -9)
			if u < 0.35 then torso(r, 30, 0) limb(r, "RS", 30, -6) limb(r, "LS", 30, -6) else hug(r) end
			return pull(u, V(900.5, 3.2, -1), V(905, 1.8, -7.6), V(896, 8.5, 7), V(902, 1.8, -5), 40, 54) end },
	{ t = 25.04, line = "Sixty seconds.", g = "night", st = "theo", cam = "pushIn", face = { Theo = "scared" },
		tr = { hold("B", TJ, 16, 0.5, 0.7) },
		f = function() faceTo(R.Theo, 874.5, 14.8, 890, 0) return shot(V(874.5, 7.5, 3.5), V(874.5, 3.6, 14.8), 50) end },
	{ t = 26.08, line = "The Striders turned.", g = "night", st = "roofs", cam = "pushIn", vfx = { "breath_steam" },
		tr = { hold("B", TJ, 16, 0.6, 0.7) },
		f = function(L, u, d, T) local k = seg(u, 0.1, 0.5)
			for _, n in { "Strider1", "Strider2", "Strider3" } do head(R[n], 15, -50 * k) end
			F.breath = R.Strider2 F.sg = 1.1
			return shot(V(905, 15, 12), V(905, 28, -19), 50) end },
	{ t = 27.36, line = "I threw ice boots.", g = "night", st = "throw", cam = "pushIn", face = { Theo = "determined", June = "scared" },
		tr = { hold("B", TJ, 16, 0.6, 0.7) },
		f = function(L, u) local r = R.Theo faceTo(r, 879, 9.5, 888, 2) throwArm(r, L) hug(R.June)
			local tgt = V(888, 1.2, 2)
			if L < 0.3 then local h = partCF(r, "Right Arm") F.pp.IceBootL = h * CF(0, -1.3, 0) F.pp.IceBootR = h * CF(0.6, -1.3, 0.3)
			else local rel = pos(r) + r.fwd * 1 + V(0, 1.5, 0) local k = clamp((L - 0.3) / 0.5, 0, 1)
				F.pp.IceBootL = CF(arc(rel, tgt, k, 4)) * CFrame.Angles(k * 6, 0, k * 3) F.pp.IceBootR = CF(arc(rel, tgt + V(0.8, 0, 0.4), k, 4)) * CFrame.Angles(0, k * 4, k * 5) end
			return shot(V(893, 5.5, 14), V(884, 2.6, 6), 54) end },
	{ t = 28.18, line = "Hiss!", g = "night", st = "throw", cam = "snapZoom", vfx = { "steam_burst" }, ev = { "steam", V(888, 0.6, 2), 30 },
		tr = { hold("B", TJ, 16, 0.7, 0.8) },
		f = function() F.steam = V(888, 0.6, 2) return shot(V(893.5, 3.6, 6), V(888, 1.0, 2), 50) end },
	{ t = 29.36, line = "Still bright.", g = "night", st = "throw", cam = "pushIn", face = { Theo = "shocked", June = "scared" },
		tr = { hold("B", TJ, 16, 0.7, 0.8) },
		f = function() F.steam = V(888, 0.6, 2) hug(R.June) return shot(V(893, 6.5, -2), V(881, 2.4, 8.5), 50) end },
	{ t = 30.40, line = "I flung her bottle.", g = "night", st = "throw", cam = "pushIn", vfx = { "steam_wisp" }, face = { Theo = "determined", June = "scared" },
		tr = { hold("B", TJ, 16, 0.8, 0.9) },
		f = function(L, u) local r = R.Theo faceTo(r, 879, 9.3, 896, 6.2) throwArm(r, L) hug(R.June)
			if L < 0.35 then F.pp.HotBottle = partCF(r, "Right Arm") * CF(0, -1.4, 0)
			else local k = clamp((L - 0.35) / 0.55, 0, 1) F.pp.HotBottle = CF(arc(pos(r) + r.fwd + V(0, 1.5, 0), V(896, 2.7, 6.2), k, 3)) * CFrame.Angles(k * 9, 0, 0) end
			return shot(V(892, 5.5, 14), V(880, 2.8, 9.6), 54) end },
	{ t = 31.64, line = "Splat!", g = "night", st = "throw", cam = "snapZoom", vfx = { "water_splat" }, ev = { "splat", V(896, 2.6, 6.2), 24 },
		tr = { hold("B", TJ, 16, 0.8, 0.9) },
		f = function() return shot(V(891, 5.2, 1), V(896, 2.4, 6.2), 52) end },
	{ t = 32.32, line = "It froze.", g = "night", st = "bottle", cam = "pullOut", vfx = { "frost_shimmer" },
		tr = { hold("B", TJ, 16, 0.9, 1.0) },
		f = function(L, u) place(R.Strider1, lerp(902, 893, u), 4, 90) walk(R.Strider1) F.frost = V(896, 2.8, 6.2)
			return pull(u, V(894.5, 3.4, 3.4), V(896, 2.4, 6), V(884, 8.5, -5), V(896, 4, 4), 42, 56) end },
	{ t = 33.26, line = "I dragged her into the laundromat.", g = "night", st = "drag", cam = "pushIn", face = { Theo = "determined", June = "scared" },
		tr = { hold("B", TDRAG, 12, 0.6) },
		f = function(L, u) place(R.Theo, lerp(941.5, 942, u), lerp(-11, -16, u), 180) walk(R.Theo) limb(R.Theo, "LS", 75, 0)
			place(R.June, lerp(941.5, 942, u), lerp(-6.4, -11.4, u), 0) walk(R.June) torso(R.June, 15, 0) head(R.June, 15, 0)
			return shot(V(948.5, 4.6, -5.5), V(942, 3, -13.5), 50) end },
	{ t = 34.92, line = "Crack!", g = "laundro", st = "door", cam = "snapZoom", vfx = { "glass_crack" }, face = { June = "shocked", Theo = "scared" },
		tr = { hold("B", TLB, 9, 0.5), hold("B", TOUT, 6, 0.5) },
		f = function(L, u) limb(R.Strider1, "RS", lerp(160, 90, seg(L, 0, 0.12)), 0) head(R.June, 0, 30)
			F.flash = clamp(1 - L / 0.12, 0, 1)
			return shot(V(888.5, 5.5, 70), V(899.5, 4.2, 79), 54) end },
	{ t = 35.58, line = "The door split.", g = "laundro", st = "door", cam = "pushIn",
		tr = { hold("B", TLB, 9, 0.5), hold("B", TOUT, 6, 0.5) },
		f = function() local s = R.Strider1 limb(s, "RS", 90, 0) limb(s, "LS", 90, 0) torso(s, 8, 0)
			return shot(V(891, 6, 67), V(900, 4.8, 81), 56) end },
	{ t = 36.54, line = "My prints led in.", g = "laundro", st = "door", cam = "pullOut", face = { Theo = "shocked" },
		tr = { hold("B", TLB, 9, 0.5), hold("B", TOUT, 6, 0.5) },
		f = function(L, u) place(R.Theo, 900, 68, 180) head(R.Theo, 35, 0)
			return pull(u, V(897, 2.5, 72.4), V(900, 0.8, 74.5), V(889, 8.5, 69), V(900, 2.4, 74), 42, 54) end },
	{ t = 37.68, line = "I yanked the dryer open.", g = "laundro", st = "dryer", cam = "pushIn", vfx = { "steam_plume" }, face = { Theo = "determined", June = "scared" },
		tr = { hold("B", TLB, 9, 0.6) },
		f = function(L, u) limb(R.Theo, "RS", u < 0.15 and 80 or lerp(80, 20, seg(u, 0.15, 0.4)), 0) hug(R.June)
			return shot(V(907, 6.5, 74.5), V(899.5, 2.6, 65), 54) end },
	{ t = 39.12, line = "Hot socks on.", g = "laundro", st = "dryer", cam = "pushIn", vfx = { "steam_wisp" }, face = { Theo = "determined" },
		tr = { hold("B", TLB, 9, 0.6) },
		f = function(L, u, d, T) local r = R.Theo place(r, 900, 66.8, 180, "sit", 0.5)
			limb(r, "RS", 60 + 8 * sin(T * 10), -6) limb(r, "LS", 60 + 8 * sin(T * 10 + 1), -6) head(r, 30, 0)
			if u < 0.35 then local a = partCF(r, "Right Arm") F.pp.SockL = a * CF(0, -1.2, -0.2) F.pp.SockR = partCF(r, "Left Arm") * CF(0, -1.2, -0.2) end
			return shot(V(906, 7, 74.5), V(900, 2.2, 66), 54) end },
	{ t = 40.22, line = "Then I stomped.", g = "whitehot", st = "out", cam = "pushIn", vfx = { "print_white_hot", "snow_puff" }, face = { Theo = "determined" },
		tr = { fade("A", TDRAG, 10, 2.2, 2.6), hold("C", { 942, -16.6, 941, -12 }, 4) },
		f = function(L, u, d, T) place(R.Theo, lerp(942, 941, u), lerp(-16.6, -8, u), 180) stomp(R.Theo, T, false)
			return shot(V(951, 5, -4), V(941.5, 2.2, -12.5), 54) end },
	{ t = 41.36, line = "Harder than ever.", g = "whitehot", st = "out", cam = "pullOut", vfx = { "lens_flare" }, face = { Theo = "determined" },
		tr = { hold("C", { 942, -16.6, 941, -8, 936, -1 }, 7), hold("B", TDRAG, 12, 3.0) },
		f = function(L, u, d, T) place(R.Theo, lerp(936, 924, u), -1, 90) stomp(R.Theo, T, true) F.lens = clamp(1 - abs(u - 0.3) / 0.3, 0, 1)
			return pull(u, V(939.6, 1.8, -3.4), V(941.2, 0.4, -6.2), V(950, 11, 11), V(922, 2, -2), 42, 56) end },
	{ t = 42.26, line = "My trail", g = "whitehot", st = "out", cam = "pushIn", vfx = { "steam_wisp" }, face = { Theo = "determined" },
		tr = { hold("C", { 942, -16.6, 941, -8, 932, -1, 924, -1 }, 9) },
		f = function(L, u, d, T) place(R.Theo, lerp(924, 917, u), -1, 90) stomp(R.Theo, T, true)
			return track(R.Theo, 7, -4, 3.2, 2.4, 50) end },
	{ t = 43.50, line = "blazed white.", g = "whitehot", st = "out", cam = "pushIn", face = { Theo = "scared" },
		tr = { hold("C", { 942, -16.6, 941, -8, 932, -1, 910, -1 }, 12) },
		f = function(L, u) place(R.Theo, lerp(917, 899, u), -1, 90) run(R.Theo)
			return track(R.Theo, 10, -6.5, 4.6, 2.8, 52) end },
	{ t = 44.34, line = "Every Strider followed.", g = "whitehot", st = "chase", cam = "pullOut", vfx = { "breath_steam" }, face = { Theo = "scared" },
		tr = { hold("C", { 942, -16.6, 941, -8, 932, -1, 900, -1 }, 14) },
		f = function(L, u) place(R.Theo, lerp(900, 891, u), -1, 90) run(R.Theo)
			for i, n in { "Strider1", "Strider2", "Strider3" } do
				local z = ({ -1, 1.5, -3 })[i] place(R[n], lerp(912 + i * 4, 900 + i * 4, u), z, 90) run(R[n])
			end
			F.breath = R.Strider1
			local p, tg = faceP(R.Theo, 4.6, 1.0)
			return pull(u, p, tg, V(884, 8, 8.5), V(904, 4, -1), 46, 56) end },
	{ t = 45.58, line = "I jumped the night van.", g = "whitehot", st = "vanjump", cam = "pushIn", face = { Theo = "determined", VanDriver = "neutral" },
		tr = { hold("C", TC, 16) },
		f = function(L, u) local vx = lerp(888, 910, u) van(vx) local r = R.Theo
			local k = seg(u, 0.42, 0.68)
			local st = V(vx - 7.75, 0, 2.5)
			if k <= 0 then place(r, 891, -0.6, lerpA(90, -90, seg(u, 0, 0.3)))
			elseif k < 1 then local p = V(891, 0, -0.6):Lerp(st, k) place(r, p.X, p.Z, -90, "at", lerp(0.3, 1.5, k) + 3 * sin(math.pi * k)) limb(r, "RH", 40 * sin(math.pi * k)) limb(r, "LH", 40 * sin(math.pi * k))
			else place(r, st.X, st.Z, -90, "at", 1.5) limb(r, "RS", 120, 10) end
			return shot(V(884, 5, 11), V(894, 3, 1.5), 54) end },
	{ t = 47.12, line = "Socks onto the roof.", g = "whitehot", st = "vanjump", cam = "pushIn", vfx = { "steam_plume" }, face = { Theo = "determined" },
		tr = { hold("C", TC, 16) },
		f = function(L, u) local vx = lerp(910, 950, u) local vcf = van(vx) local r = R.Theo
			local roofL, roofR = vcf * CF(-3.6, 8.05, -0.7) * CFrame.Angles(0, rad(15), 0), vcf * CF(-3.0, 8.05, 0.6)
			if u < 0.42 then
				place(r, vx - 7.75, 2.5, -90, "at", 1.5) limb(r, "RS", 120, 10) limb(r, "RH", lerp(0, 110, seg(u, 0.05, 0.25)))
				local k = clamp((u - 0.12) / 0.3, 0, 1)
				if k > 0 then F.pp.SockL = CF(arc(partCF(r, "Right Leg").Position, roofL.Position, k, 3)) * CFrame.Angles(k * 7, 0, 0)
					F.pp.SockR = CF(arc(partCF(r, "Left Leg").Position, roofR.Position, k, 3.5)) * CFrame.Angles(0, 0, k * 6) end
			else
				F.pp.SockL, F.pp.SockR = roofL, roofR
				local k = seg(u, 0.45, 0.75)
				local a, b = V(lerp(910, 950, 0.45) - 7.75, 0, 2.5), V(908.5, 0, 8.4)
				local p = a:Lerp(b, k)
				place(r, p.X, p.Z, lerpA(-90, 90, k), "at", lerp(1.5, -1.2, k) + 1.8 * sin(math.pi * k)) torso(r, 40 * sin(math.pi * k), 0)
				if k < 1 then ears(r) end
			end
			if u < 0.45 then return shot(V(vx - 21, 9, 18), V(vx - 7, 3.5, 3), 52) end
			return shot(V(902, 5, 14), V(908.5, 2.5, 7), 46) end },
{ t = 44.70, line = "They chased it", g = "whitehot", st = "lk", cam = "pullOut", vfx = { "impact_whoosh" },
		f = function(L, u, d, T) local vx = lerp(950, 996, u) van(vx)
			for i, n in { "Strider1", "Strider2", "Strider3" } do
				local z = ({ 1, 4, -0.5 })[i] place(R[n], vx - 14 - 4 * i, z, -90) run(R[n])
			end
			return pull(u, V(vx - 12, 1.7, 8.5), V(vx - 18, 0.9, 1), V(926, 10, 9), V(985, 2.5, 3), 40, 58) end },
	{ t = 45.24, line = "onto the frozen lake.", g = "lake", st = "lk", cam = "pullOut", vfx = { "snow_spray" }, face = { VanDriver = "shocked" },
		tr = { hold("B", { 984, 1, 1018, -4 }, 7, 0.5), hold("B", { 981, 4, 1022, 6 }, 7, 0.5), hold("B", { 978, -0.5, 1026, -10 }, 8, 0.5) },
		f = function(L, u, d, T) local k = ease(u)
			local vcf = van(lerp(1000, 1032, k), lerp(0, -70, k), lerp(2.5, 3, k))
			torso(R.VanDriver, 15, 0)
			F.steam = (vcf * CF(-3, 0.6, 3.4)).Position
			local SZ, XS = { 1, 4, -0.5 }, { 984, 981, 978 }
			for i, n in { "Strider1", "Strider2", "Strider3" } do mv(R[n], { XS[i], SZ[i], SM[i][1], SM[i][2] }, k, true) end
			return pull(u, V(1003, 1.8, 9), V(1001, 1.0, 3.5), V(984, 15, 22), V(1008, 1, 1), 40, 66) end },
	{ t = 46.64, line = "Crack!", g = "lake", st = "lk", cam = "snapZoom", vfx = { "crack_spread" }, ev = { "puff", V(1018, 0.5, -4), 10 },
		tr = { hold("B", { 984, 1, 1018, -4 }, 7, 0.5), hold("B", { 981, 4, 1022, 6 }, 7, 0.5), hold("B", { 978, -0.5, 1026, -10 }, 8, 0.5) },
		f = function(L, u) van(1032, -70, 3) torso(R.VanDriver, 12, 0)
			for i, n in { "Strider1", "Strider2", "Strider3" } do local r = R[n] place(r, SM[i][1], SM[i][2], -90) limb(r, "RH", 40) limb(r, "LH", -30) end
			return shot(V(1005, 7, 10), V(1018, 4.5, -4), 54) end },
	{ t = 47.20, line = "The ice melted.", g = "lake", st = "lk", cam = "pushIn", vfx = { "melt_steam" },
		tr = { hold("B", { 984, 1, 1018, -4 }, 7, 0.6), hold("B", { 981, 4, 1022, 6 }, 7, 0.6), hold("B", { 978, -0.5, 1026, -10 }, 8, 0.6) },
		f = function(L, u, d, T) van(1032, -70, 3) torso(R.VanDriver, 8, 0)
			for i, n in { "Strider1", "Strider2", "Strider3" } do local r = R[n]
				place(r, SM[i][1], SM[i][2], -90 + 20 * sin(T * 1.5 + i)) head(r, 20, 12 * sin(T * 2 + i)) end
			return shot(V(1008, 6, 14), V(1022, 1.5, 0), 50) end },
	{ t = 48.18, line = "Every Strider sank.", g = "lake", st = "lk", cam = "pullOut", vfx = { "water_splash" }, ev = { "splat", V(1022, 0.5, 6), 24 },
		f = function(L, u, d, T) van(1032, -70, 3)
			for i, n in { "Strider1", "Strider2", "Strider3" } do local r = R[n]
				local k = clamp((L - (0.05 + 0.27 * (i - 1))) / 0.35, 0, 1)
				if k >= 1 then park(r) else
					place(r, SM[i][1], SM[i][2], -90, "at", lerp(0.26, -6, k * k))
					limb(r, "RS", 150, 10) limb(r, "LS", 150, 10) end
			end
			return pull(u, V(1012, 2.8, 11), V(1022, 1.8, 3), V(1007, 8, 14), V(1022, 0.5, 1), 44, 52) end },
	{ t = 49.36, line = "The driver jumped out.", g = "lake", st = "lk", cam = "pushIn", face = { VanDriver = "grin" },
		f = function(L, u, d, T) local vcf = van(1032, -70, 3) local dr = R.VanDriver dr.off.RS, dr.off.LS = nil, nil
			local sp, dp = (vcf * CF(4.3, 2.4, -1.6)).Position, (vcf * CF(5, 0, -4.8)).Position
			local k = seg(u, 0.05, 0.35)
			local dy = k < 1 and (lerp(1.8, 0.26, k) + 1.2 * sin(math.pi * k)) or (0.26 + 0.35 * abs(sin(math.pi * 2 * (u - 0.35) / 0.65)))
			place(dr, lerp(sp.X, dp.X, k), lerp(sp.Z, dp.Z, k), -90, "at", dy) limb(dr, "RS", 140, 40) limb(dr, "LS", 140, 40)
			F.pp.CBRadioIce = partCF(dr, "Torso") * CF(0.9, -0.6, -0.6)
			return shot(V(1046, 4.2, 0.5), V(1038.2, 2.8, 6), 50) end },
	{ t = 50.60, line = "Then he ran.", g = "lake", st = "lk", cam = "snapZoom", face = { VanDriver = "grin" },
		f = function(L, u, d, T) van(1032, -70, 3, nil, true) local dr = R.VanDriver
			mv(dr, { 1038.2, 6.06, 1050, 8 }, u, true)
			local k = clamp(L / 0.45, 0, 1)
			F.pp.CBRadioIce = CF(arc(V(1038.2, 2.6, 6.06), V(1039.6, 0.5, 6.6), k, 1.2)) * CFrame.Angles(k * 6, 0, k * 3)
			return track(dr, 13, 5, 4.2, 2, 54) end },
	{ t = 51.56, line = "One grey hand", g = "lake", st = "lk", cam = "pushIn", face = { VanDriver = "grin" },
		f = function(L, u, d, T) van(1032, -70, 3, nil, true) mv(R.VanDriver, { 1050, 8, 1053.4, 8.2 }, u, true)
			if L > 0.45 then F.emit = { "shards1", V(1058.5, 0.5, 8.3), 18 } end
			return shot(V(1047, 4.6, 18), V(1056.5, 2.4, 8.3), 52) end },
	{ t = 52.34, line = "burst through the ice.", g = "lake", st = "lk", cam = "snapZoom", face = { VanDriver = "shocked" },
		tr = { hold("B", { 1038.2, 6.06, 1055.4, 8.2 }, 12, 0.7) },
		f = function(L, u, d, T) van(1032, -70, 3, nil, true) local dr = R.VanDriver
			place(dr, 1053.6, 8.2, -90) torso(dr, -15, 0) limb(dr, "RS", 120, 60) limb(dr, "LS", 120, 60) head(dr, -10, 0)
			return shot(V(1047, 4.6, 18), V(1056.5, 2.4, 8.3), 52) end },
	{ t = 53.62, line = "Gone.", g = "lake", st = "lk", cam = "pushIn",
		tr = { hold("B", { 1038.2, 6.06, 1055.4, 8.2 }, 12, 0.9) },
		f = function(L, u, d, T) van(1032, -70, 3, nil, true) return shot(V(1047, 2.8, 12.5), V(1057, 0.4, 8.2), 42) end },
	{ t = 54.30, line = "Only his radio crackled.", g = "lake", st = "lk", cam = "pushIn", vfx = { "radio_led_flash" },
		tr = { hold("B", { 1038.2, 6.06, 1055.4, 8.2 }, 12, 2.2) },
		f = function(L, u, d, T) van(1032, -70, 3, nil, true) F.led = math.floor(T / 0.15) % 2 == 0
			return shot(V(1044, 4.8, 10.5), V(1039.8, 1.0, 6.6), 36) end },
	{ t = 55.72, line = "My feet burned for weeks.", g = "homein", st = "lk", cam = "pushIn", face = { Theo = "scared", June = "neutral" },
		f = function(L, u, d, T) local th, jn = R.Theo, R.June
			place(th, 900, 144.4, 0, "sit", 2.15) P(th, "RH", 0, 0, 90) P(th, "LH", 0, 0, -90)
			P(th, "RH", 4 * sin(T * 12.6), 0, 0) P(th, "LH", -4 * sin(T * 12.6), 0, 0) head(th, 8 * seg(L, 0.4, 0.8), 0)
			place(jn, 902.8, 141.4, 90) hug(jn) head(jn, 14, 0)
			return shot(V(895.5, 4.2, 136.5), V(900, 2.6, 142.4), 48) end },
	{ t = 57.36, line = "So June carried me home.", g = "dusk", st = "lk", cam = "pullOut", face = { June = "determined", Theo = "proud" },
		f = function(L, u, d, T) carry(lerp(960, 957, u))
			return pull(u, V(951.5, 3.2, 7), V(958, 2.6, 11), V(946, 4.5, 5), V(955, 2.6, 11.2), 36, 46) end },
	{ t = 58.82, line = "Slowly.", g = "dusk", st = "lk", cam = "pushIn", face = { June = "determined", Theo = "proud" },
		f = function(L, u, d, T) carry(lerp(957, 954.6, u))
			return shot(V(947, 4, 6.5), V(955, 2.6, 11.2), 44) end },
	{ t = 52.46, line = "Then Christmas came.", g = "xmas", st = "xm", cam = "pullOut", face = XFACE,
		f = function(L, u, d, T, t) xm() crowd(t)
			return pull(u, V(917, 4, 3), V(908, 7, 11), V(944, 9, 0), V(903, 5, 3), 50, 58) end },
	{ t = 54.08, line = "Streets full.", g = "xmas", st = "xm", cam = "pushIn", face = XFACE,
		f = function(L, u, d, T, t) xm() crowd(t)
			return shot(V(946, 14, 1), V(900, 2.5, 0), 54) end },
	{ t = 54.92, line = "Nobody ran.", g = "xmas", st = "xm", cam = "pushIn", face = XFACE,
		f = function(L, u, d, T, t) xm() crowd(t)
			return shot(V(912, 1.4, -4.5), V(900, 1.0, -8), 48) end },
	{ t = 55.44, line = "Except June.", g = "xmas", st = "xm", cam = "snapZoom", face = { June = "determined" },
		f = function(L, u, d, T, t) xm() crowd(t)
			local x = lerp(914, 893, u) place(R.June, x, -1, 90) run(R.June)
			return shot(V(x + 2, 3.2, 8), V(x - 1.5, 2.6, -1), 42) end },
	{ t = 56.48, line = "Every morning,", g = "xmas", st = "xm", cam = "pushIn", face = { June = "grin" },
		f = function(L, u, d, T, t) xm() local j = R.June
			place(j, lerp(876.5, 875.5, u), lerp(4.5, 11, u), 180) run(j) limb(j, "RS", 170, 10)
			local h = partCF(j, "Right Arm") * CF(0, -1.2 * j.s, 0)
			F.pp.SockL, F.pp.SockR = h, h * CF(0.3, 0.1, 0) F.steam = h.Position + V(0, 0.6, 0)
			return shot(V(868, 3.6, 4), V(875.5, 3.4, 10), 46) end },
	{ t = 56.88, line = "bringing me hot socks.", g = "xmas", st = "xm", cam = "pushIn", face = { Theo = "grin", June = "grin" },
		f = function(L, u, d, T) xm() local th, jn = R.Theo, R.June
			place(th, 873, 14.5, 0, "sit", 2.2) P(th, "RH", 0, 0, 90) P(th, "LH", 0, 0, -90) head(th, 10, 0)
			place(jn, 873, 11.3, 180) torso(jn, 14, 0) limb(jn, "RS", 55, -10) limb(jn, "LS", 55, 10) head(jn, -8, 0)
			F.pp.SockL, F.pp.SockR = partCF(th, "Left Leg") * CF(0, -0.55, -0.1), partCF(th, "Right Leg") * CF(0, -0.55, -0.1)
			F.steam = partCF(th, "Left Leg").Position + V(0, -0.2, -0.3)
			return shot(V(868.3, 3.4, 7.8), V(873.2, 2.7, 12.6), 46) end },
}
for i, b in BEATS do
	b.n = i
	b.t = TIMES[i] or b.t
	b.fx = {}
	for _, v in b.vfx or {} do b.fx[v] = true end
	b.np = b.np or {}
end

local function BT(n) return BEATS[n].t end
HOT_T, HOT_END = BT(36), BT(42)
local C3 = Color3.fromRGB
local GN = { clock = 19.2, bright = 1, exp = 0.1, amb = C3(40, 50, 80), oamb = C3(60, 72, 110), eds = 0.4, tint = C3(200, 215, 255), sat = -0.1, con = 0.15, cb = 0,
	atD = 0.35, atH = 1.2, atC = C3(150, 170, 210), bloom = 1.2, bsz = 24, bth = 0.95, snow = true }
local function with(base, o) local t = table.clone(base) for k, v in o do t[k] = v end return t end
local GR = {
	night = GN,
	laundro = with(GN, { exp = -0.7, tint = C3(255, 238, 214), sat = -0.02, con = 0.12, bloom = 0.25, snow = false, atD = 0.2 }),
	whitehot = with(GN, { bloom = 0.9, con = 0.2, bth = 0.97 }),
	home = with(GN, { tint = C3(225, 220, 255), bloom = 1.5 }),
	lake = with(GN, { atH = 1.6, bloom = 1.0, tint = C3(190, 210, 255), bth = 0.95 }),
	homein = with(GN, { exp = 0.1, tint = C3(255, 240, 230), sat = 0, con = 0.08, bloom = 0.4, snow = false, atD = 0, amb = C3(140, 120, 105), oamb = C3(140, 120, 105), eds = 0.6 }),
	dusk = with(GN, { clock = 17.6, bright = 1.2, exp = 0.1, amb = C3(90, 80, 110), oamb = C3(140, 110, 130), tint = C3(255, 215, 200), sat = 0, con = 0.1, bloom = 1.2, atD = 0.3, atH = 1, atC = C3(230, 170, 150) }),
	xmas = with(GN, { clock = 19.2, bright = 1, exp = 0.15, amb = C3(70, 60, 80), oamb = C3(75, 70, 100), tint = C3(255, 232, 210), sat = 0.05, con = 0.12, bloom = 1.0, bsz = 24, bth = 0.95, atD = 0.3, atH = 1, atC = C3(255, 200, 160) }),
	road = with(GN, { atD = 0.45, atH = 2, atC = C3(40, 50, 75) }),
}
local LPROPS = { "ClockTime", "Brightness", "ExposureCompensation", "OutdoorAmbient", "Ambient", "EnvironmentDiffuseScale" }
local M = {}
local FX, LFX, CURG, PROPS, DEBRIS, WHEELS, PRS = {}, {}, nil, {}, {}, {}, { dyn = {}, st = {}, di = 0, si = 0 }
local LK, WRAPS = nil, {}
local NDYN, NST = 90, 70
local inited = false
local XM, XMS, XL = nil, false, {}

local function writeGrade(G, fl)
	fl = fl or 0
	W(Lighting, "ClockTime", G.clock)
	W(Lighting, "Brightness", G.bright)
	W(Lighting, "OutdoorAmbient", G.oamb)
	W(Lighting, "Ambient", G.amb)
	W(Lighting, "EnvironmentDiffuseScale", G.eds)
	W(Lighting, "ExposureCompensation", G.exp + 0.3 * fl)
	local g = LFX.grade
	if g then
		W(g, "Enabled", true) W(g, "TintColor", G.tint) W(g, "Saturation", G.sat) W(g, "Contrast", G.con)
		W(g, "Brightness", G.cb + 0.04 * fl)
	end
	if LFX.atmo then W(LFX.atmo, "Density", G.atD) W(LFX.atmo, "Haze", G.atH) W(LFX.atmo, "Color", G.atC) end
	if LFX.bloom then
		W(LFX.bloom, "Enabled", true) W(LFX.bloom, "Intensity", G.bloom + 0.12 * fl)
		W(LFX.bloom, "Size", G.bsz) W(LFX.bloom, "Threshold", G.bth)
	end
	W(LFX.rays, "Intensity", 0)
end

local function part(name, size, color, mat, tr)
	local p = Instance.new("Part")
	p.Name, p.Size, p.Color, p.Material, p.Transparency = name, size, color, mat or Enum.Material.SmoothPlastic, tr or 0
	p.Anchored, p.CanCollide, p.CanTouch, p.CanQuery, p.CastShadow = true, false, false, false, false
	p.CFrame, p.Parent = OFF, FX.folder
	return p
end
local function emitter(p, o)
	local e = Instance.new("ParticleEmitter")
	e.Rate, e.LightInfluence = 0, 0.6
	for k, v in o do e[k] = v end
	e.Parent = p
	return e
end
local function pivotOf(o)
	local p0 = o:GetAttribute("S13Pivot")
	if not p0 then p0 = o:IsA("Model") and o:GetPivot() or o.CFrame o:SetAttribute("S13Pivot", p0) end
	return p0
end
local function addProp(name, o) if o then PROPS[name] = { o = o, p0 = pivotOf(o) } else warn("[Story002] prop missing: " .. name) end end

local function mkPrint(i)
	local p = part("Print", V(0.9, 0.05, 1.6), Color3.new(1, 1, 1), Enum.Material.Neon, 1)
	local m = Instance.new("SpecialMesh") m.MeshType = Enum.MeshType.Sphere m.Parent = p
	local l = Instance.new("PointLight") l.Enabled, l.Shadows, l.Parent = false, false, p
	local e = { p = p, l = l, idx = i }
	if i % 3 == 0 then
		e.em = emitter(p, { Texture = "rbxasset://textures/particles/smoke_main.dds", EmissionDirection = Enum.NormalId.Top, Speed = NumberRange.new(1, 2),
			Lifetime = NumberRange.new(1.2, 1.2), Size = NumberSequence.new(0.6, 1.4), Color = ColorSequence.new(Color3.new(1, 1, 1)),
			Transparency = NumberSequence.new(0.85, 1), Acceleration = V(0, 1.5, 0) })
	end
	return e
end
local function hidePrint(e)
	e.kind = nil
	W(e.p, "Transparency", 1) W(e.l, "Enabled", false)
	if e.em then W(e.em, "Rate", 0) end
end
local function setPrint(e, kind, x, z, yaw, born, s, holdIt, age0)
	local K = PK[kind]
	e.kind, e.born, e.hold, e.age0 = kind, born, holdIt, age0
	e.p.Size = V(0.9 * s, 0.05, 1.6 * s)
	e.p.CFrame = CF(x, groundY(x, z) + 0.03, z) * CFrame.Angles(0, rad(yaw), 0)
	W(e.p, "Color", K.col) W(e.p, "Material", K.mat or Enum.Material.Neon)
	e.lightOK = K.br ~= nil and e.idx % 2 == 0
	if e.lightOK then W(e.l, "Color", K.col) W(e.l, "Range", K.range) end
end
local function updatePrint(e, t, T)
	if not e.kind then return end
	local K = PK[e.kind]
	local age = e.hold and e.age0 or math.max(0, t - e.born)
	local a = age / K.life
	if a >= 1 then hidePrint(e) return end
	W(e.p, "Transparency", lerp(K.tr, 1, a))
	W(e.l, "Enabled", e.lightOK)
	if e.lightOK then e.l.Brightness = K.br * (1 - a) * (0.85 + 0.15 * sin(T * 9 + e.idx)) end
	if e.em then W(e.em, "Rate", K.steam and 5 or 0) end
end
local function clearPrints(list) for _, e in list do hidePrint(e) end end
local function layTrail(tr, bt)
	local kind, pts, n, a0, a1, holdIt, s = tr[1], tr[2], tr[3], tr[4], tr[5], tr[6], tr[7] or 1
	local segs, tot = {}, 0
	for i = 1, #pts - 2, 2 do
		local a, b = V(pts[i], 0, pts[i + 1]), V(pts[i + 2], 0, pts[i + 3])
		table.insert(segs, { a, b, (b - a).Magnitude })
		tot += (b - a).Magnitude
	end
	for i = 1, n do
		local d = n > 1 and tot * (i - 1) / (n - 1) or tot
		local a, b, l = segs[1][1], segs[1][2], segs[1][3]
		for j, sg in segs do a, b, l = sg[1], sg[2], sg[3] if d <= l or j == #segs then break end d -= l end
		local dir = (b - a).Unit
		local p = a + dir * math.min(d, l)
		local sd = V(-dir.Z, 0, dir.X) * 0.45 * s * (i % 2 == 0 and 1 or -1)
		local age = lerp(a0, a1, n > 1 and (i - 1) / (n - 1) or 0)
		PRS.si += 1
		local e = PRS.st[PRS.si]
		if not e then break end
		setPrint(e, kind, p.X + sd.X, p.Z + sd.Z, math.deg(math.atan2(-dir.X, -dir.Z)), bt - age, s, holdIt, age)
	end
end
local function stepPrints(r, t, b)
	if not (r.on and r.loco and r.mode == nil) or r.strider or b.np[r.m.Name] then r.lpp = nil return end
	local p = pos(r)
	local h = V(p.X, 0, p.Z)
	if not r.lpp or (h - r.lpp).Magnitude > 8 then r.lpp = h return end
	if (h - r.lpp).Magnitude < (r.loco == "run" and 2.4 or 1.7) * r.s then return end
	r.lpp = h
	r.foot = -(r.foot or 1)
	local kind = r.loco == "run" and "B" or "A"
	if r == R.Theo and t >= HOT_T and t < HOT_END then kind = "C" end
	if t >= TIMES[57] and kind == "A" then kind = "E" end
	local f = r.fwd
	local sd = V(-f.Z, 0, f.X) * 0.45 * r.s * r.foot
	PRS.di = PRS.di % NDYN + 1
	setPrint(PRS.dyn[PRS.di], kind, p.X + sd.X, p.Z + sd.Z, r.yaw, t, r.s, false)
	if kind == "C" and FX.puff then FX.puff.CFrame = CF(p.X + sd.X, groundY(p.X, p.Z) + 0.2, p.Z + sd.Z) FX.puffE:Emit(6) end
end

function M.setup()
	local street = assert(WS:FindFirstChild("Set_Street002"), "[Story002] Set_Street002 missing")
	local laund = assert(WS:FindFirstChild("Set_Laundromat002"), "[Story002] Set_Laundromat002 missing")
	local folder = WS:FindFirstChild("Cast_002") or Instance.new("Folder")
	folder.Name, folder.Parent = "Cast_002", WS
	table.clear(R)
	CACHE = {}
	for i, n in NAMES do
		local r = register(folder:FindFirstChild(n) or CASTM.build(n:match("^Strider") and "Strider" or n, n, 850 + i * 5, 0, -40, 0, folder))
		r.park = V(848 + i * 5, 0, -40)
		if n:match("^Strider") and not r.m.Torso:FindFirstChild("StriderGlow") then local pl = Instance.new("PointLight") pl.Name, pl.Color, pl.Brightness, pl.Range, pl.Shadows = "StriderGlow", Color3.fromRGB(190, 210, 255), 0.8, 12, false pl.Parent = r.m.Torso end
		if n:match("^Strider") and not r.m:FindFirstChildOfClass("Highlight") then local h = Instance.new("Highlight") h.DepthMode = Enum.HighlightDepthMode.Occluded h.FillTransparency, h.OutlineColor, h.OutlineTransparency, h.Parent = 1, Color3.fromRGB(160, 195, 255), 0.25, r.m end
		if n == "Theo" then for _, a in r.m:GetChildren() do if a:IsA("Accessory") and a.Name:find("Beanie") then local hh = a:FindFirstChild("Handle") local mm = hh and hh:FindFirstChildOfClass("SpecialMesh") if mm then mm.TextureId = "" end if hh then hh.Color = Color3.fromRGB(150, 150, 158) end end end end
	end
	local A = {}
	for k, id in ANIM do A[k] = Instance.new("Animation") A[k].AnimationId = id end
	for _, n in NAMES do
		local r = R[n]
		local hum = r.m:FindFirstChildOfClass("Humanoid")
		if hum then
			local an = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
			for _, tr in an:GetPlayingAnimationTracks() do tr:Stop(0) end
			r.anim, r.tr = an, {}
			for k, a in A do
				local tr = an:LoadAnimation(a)
				tr.Looped = true
				tr.Priority = k == "walk" and Enum.AnimationPriority.Movement or Enum.AnimationPriority.Idle
				r.tr[k] = tr
			end
		else warn("[Story002] " .. n .. " has no Humanoid") end
	end
	local dl, ready = os.clock() + 5, false
	repeat
		ready = true
		for _, r in R do for _, tr in r.tr or {} do if tr.Length <= 0 then ready = false end end end
		if not ready then task.wait() end
	until ready or os.clock() > dl
	if not ready then warn("[Story002] some R6 animation tracks did not load in 5 s") end
	for _, r in R do
		for _, d in r.m:GetDescendants() do
			if d:IsA("MeshPart") then pcall(function() d.RenderFidelity = Enum.RenderFidelity.Precise end) end
		end
	end
	local pt0, list, seen = os.clock(), {}, {}
	for _, e in EMOS do
		for _, r in R do
			pcall(CASTM.setFace, r.m, e)
			for _, d in r.m:GetDescendants() do
				if d:IsA("Decal") and d.Texture ~= "" and not seen[d.Texture] then seen[d.Texture] = true table.insert(list, d.Texture) end
			end
		end
	end
	for _, r in R do r.emo = nil setFace(r, "neutral") table.insert(list, r.m) end
	local pok, perr = pcall(function() game:GetService("ContentProvider"):PreloadAsync(list) end)
	table.clear(WRAPS)
	for _, ln in { "Left Leg", "Right Leg" } do
		local leg = R.Theo.m:FindFirstChild(ln)
		if leg then
			for _, spec in { { "Wrap_", V(1.05, 0.6, 1.05), CF(0, -0.7, 0), Color3.fromRGB(225, 225, 228), Enum.Material.SmoothPlastic }, { "Sole_", V(1, 0.05, 1), CF(0, -1.02, 0), Color3.fromRGB(150, 40, 35), Enum.Material.SmoothPlastic } } do
				local o = R.Theo.m:FindFirstChild(spec[1] .. ln) if o then o:Destroy() end
				local p = Instance.new("Part") p.Name, p.Size, p.Color, p.Material = spec[1] .. ln, spec[2], spec[4], spec[5]
				p.CanCollide, p.CanQuery, p.CanTouch, p.Massless, p.Anchored, p.Transparency = false, false, false, true, false, 1
				p.CFrame = leg.CFrame * spec[3]
				local w = Instance.new("WeldConstraint") w.Part0, w.Part1, w.Parent = leg, p, p
				p.Parent = R.Theo.m
				table.insert(WRAPS, p)
			end
		end
	end
	LK = assert(WS:FindFirstChild("Set_Lake002"), "[Story002] Set_Lake002 missing: run engines/roblox/sets/lake_002.luau"):FindFirstChild("Props")
	assert(WS:FindFirstChild("Set_Home002"), "[Story002] Set_Home002 missing: run engines/roblox/sets/home_002.luau")
	local sp, lm = street:FindFirstChild("Props002"), laund:FindFirstChild("Movable")
	PROPF = sp
	table.clear(PROPS) table.clear(DEBRIS) table.clear(WHEELS)
	for _, n in { "NightVan", "Cat", "HotBottle", "IceBootL", "IceBootR", "Radio", "DriverCap", "CBMic", "Bread" } do addProp(n, sp and sp:FindFirstChild(n)) end
	for _, n in { "Dryer3Door", "Crack", "Dryer3Steam" } do addProp(n, lm and lm:FindFirstChild(n)) end
	for _, n in { "Hand", "CBRadioIce" } do addProp(n, LK and LK:FindFirstChild(n)) end
	if PROPS.CBRadioIce then PROPS.CBRadioIce.led = PROPS.CBRadioIce.o:FindFirstChild("LED") end
	local socks = lm and lm:FindFirstChild("HotSocks")
	addProp("SockL", socks and socks:FindFirstChild("SockL")) addProp("SockR", socks and socks:FindFirstChild("SockR"))
	local deb = sp and sp:FindFirstChild("RoofDebris")
	if deb then
		for i, p in deb:GetChildren() do
			table.insert(DEBRIS, { p = p, p0 = pivotOf(p), v = V(((i * 37) % 9 - 4) * 1.5, 4 + (i % 4) * 2, 5 + (i % 3) * 2.5), spin = 3 + i % 4 })
		end
	end
	local vn = PROPS.NightVan
	if vn then for _, p in vn.o:GetChildren() do if p.Name == "Tyre" or p.Name == "Hubcap" then table.insert(WHEELS, { p = p, rel = vn.p0:Inverse() * pivotOf(p) }) end end end
	if PROPS.Cat then local tl = PROPS.Cat.o:FindFirstChild("Tail") if tl then PROPS.Cat.tail, PROPS.Cat.tailRel = tl, PROPS.Cat.p0:Inverse() * pivotOf(tl) end end
	if PROPS.Radio then PROPS.Radio.led = PROPS.Radio.o:FindFirstChild("LED") end
	if PROPS.HotBottle then PROPS.HotBottle.body = PROPS.HotBottle.o:FindFirstChild("Body") end
	if PROPS.Dryer3Steam then PROPS.Dryer3Steam.em = PROPS.Dryer3Steam.o:FindFirstChildOfClass("ParticleEmitter") end
	if PROPS.Dryer3Door then PROPS.Dryer3Door.hinge = PROPS.Dryer3Door.o:GetAttribute("Hinge") end
	LFX.win = street:FindFirstChild("ShopWindow1", true)
	local old = WS:FindFirstChild("Story002FX")
	if old then old:Destroy() end
	FX.folder = Instance.new("Folder") FX.folder.Name = "Story002FX" FX.folder.Parent = WS
	for _, o in WS:GetChildren() do if o.Name == "Xmas002" then o:Destroy() end end
	if XM then XM:Destroy() end
	XM = Instance.new("Folder") XM.Name = "Xmas002"
	local function xp(name, size, col, mat, cf, shape)
		local p = Instance.new("Part")
		p.Name, p.Size, p.Color, p.Material = name, size, col, mat or Enum.Material.SmoothPlastic
		p.Anchored, p.CanCollide, p.CanTouch, p.CanQuery, p.CastShadow = true, false, false, false, false
		if shape then p.Shape = shape end
		p.CFrame, p.Parent = cf, XM
		return p
	end
	local BC = { Color3.fromRGB(255, 60, 40), Color3.fromRGB(90, 255, 100), Color3.fromRGB(255, 215, 90), Color3.fromRGB(90, 150, 255) }
	local function strand(a, b, n, sag)
		for i = 0, n do
			local k = i / n
			local q = a:Lerp(b, k) - V(0, sag * 4 * k * (1 - k), 0)
			xp("Bulb", V(0.45, 0.45, 0.45), BC[i % 4 + 1], Enum.Material.Neon, CF(q), Enum.PartType.Ball)
		end
	end
	for x = 850, 937, 12.5 do strand(V(x, 14, -16.3), V(x + 12.5, 14, -16.3), 8, 1.3) strand(V(x, 18.5, -16.3), V(x + 12.5, 18.5, -16.3), 8, 1.3) end
	for x = 860, 935, 25 do strand(V(x, 11.2, -8), V(x + 8, 13, 17), 22, 2.5) end
	local up, GRN = CFrame.Angles(0, 0, rad(90)), Color3.fromRGB(22, 92, 42)
	local TX, TZ = 908, 11
	xp("Trunk", V(2, 1.6, 2), Color3.fromRGB(90, 60, 35), nil, CF(TX, 1.5, TZ) * up, Enum.PartType.Cylinder)
	for i, t in { { 2.6, 3.6, 8.4 }, { 2.4, 5.9, 6.6 }, { 2.2, 8.0, 4.8 }, { 2.0, 9.9, 3.0 } } do
		xp("Tier", V(t[1], t[3], t[3]), GRN, nil, CF(TX, t[2] + 0.7, TZ) * up, Enum.PartType.Cylinder)
		for a = 0, 5 do
			local an, rr = rad(a * 60 + i * 25), t[3] / 2 + 0.1
			xp("Orn", V(0.6, 0.6, 0.6), BC[(a + i) % 4 + 1], Enum.Material.Neon, CF(TX + cos(an) * rr, t[2] - 0.1, TZ + math.sin(an) * rr), Enum.PartType.Ball)
		end
	end
	local star = xp("Star", V(1.3, 1.3, 1.3), Color3.fromRGB(255, 225, 110), Enum.Material.Neon, CF(TX, 12.3, TZ) * CFrame.Angles(rad(45), rad(45), 0))
	local sl = Instance.new("PointLight") sl.Color, sl.Range, sl.Brightness, sl.Shadows, sl.Parent = Color3.fromRGB(255, 200, 120), 20, 1.4, false, star
	for i, c in { Color3.fromRGB(200, 40, 40), Color3.fromRGB(40, 110, 200), Color3.fromRGB(230, 190, 50) } do
		xp("Gift", V(1.6, 1.4, 1.6), c, nil, CF(TX - 3.6 + i * 2.2, 1.4, TZ + 3.4) * CFrame.Angles(0, rad(i * 30), 0))
		xp("Ribbon", V(0.4, 1.5, 1.7), Color3.fromRGB(255, 240, 200), nil, CF(TX - 3.6 + i * 2.2, 1.45, TZ + 3.4) * CFrame.Angles(0, rad(i * 30), 0))
	end
	for _, x in { 856, 868, 881, 896, 911, 925, 940 } do
		xp("Wreath", V(0.5, 3.2, 3.2), GRN, nil, CF(x, 16.2, -16.4) * CFrame.Angles(0, rad(90), 0), Enum.PartType.Cylinder)
		xp("Bow", V(1.3, 0.9, 0.4), Color3.fromRGB(210, 30, 40), nil, CF(x, 14.8, -16.1))
		for a = 0, 4 do local an = rad(a * 72 + 20) xp("Berry", V(0.35, 0.35, 0.35), Color3.fromRGB(220, 30, 40), nil, CF(x + cos(an) * 1.5, 16.2 + math.sin(an) * 1.5, -16.1), Enum.PartType.Ball) end
	end
	XMS = false
	XL = {}
	for _, d in street:GetDescendants() do if d:IsA("PointLight") and d.Parent.Name:find("LampBulb") then XL[#XL + 1] = { d, d.Brightness } end end
	local ex = { folder, FX.folder, XM }
	if sp then table.insert(ex, sp) end
	if lm then table.insert(ex, lm) end
	if LK then table.insert(ex, LK) end
	RP = RaycastParams.new() RP.FilterType = Enum.RaycastFilterType.Exclude RP.FilterDescendantsInstances = ex RP.IgnoreWater = true
	RPC = RaycastParams.new() RPC.FilterType = Enum.RaycastFilterType.Exclude RPC.FilterDescendantsInstances = ex RPC.IgnoreWater = true
	local SOFT = "rbxasset://textures/particles/smoke_main.dds"
	FX.snow = part("Snowfall", V(70, 1, 70), Color3.new(1, 1, 1), nil, 1)
	FX.snowE = emitter(FX.snow, { Texture = SOFT, EmissionDirection = Enum.NormalId.Bottom, Speed = NumberRange.new(3, 5), Lifetime = NumberRange.new(6, 8),
		SpreadAngle = Vector2.new(20, 20), Size = NumberSequence.new(0.12), Color = ColorSequence.new(Color3.fromRGB(240, 245, 255)), Transparency = NumberSequence.new(0.25),
		RotSpeed = NumberRange.new(-60, 60) })
	FX.puff = part("Puff", V(1, 0.2, 1), Color3.new(1, 1, 1), nil, 1)
	FX.puffE = emitter(FX.puff, { Texture = SOFT, Speed = NumberRange.new(4, 9), SpreadAngle = Vector2.new(70, 70), Acceleration = V(0, -12, 0), Drag = 2,
		Lifetime = NumberRange.new(0.5, 0.9), Size = NumberSequence.new(0.8, 1.6), Color = ColorSequence.new(Color3.fromRGB(240, 244, 250)), Transparency = NumberSequence.new(0.35, 1) })
	FX.splat = part("Splat", V(1, 0.2, 1), Color3.new(1, 1, 1), nil, 1)
	FX.splatE = emitter(FX.splat, { Texture = SOFT, Speed = NumberRange.new(6, 10), SpreadAngle = Vector2.new(60, 60), Acceleration = V(0, -35, 0),
		Lifetime = NumberRange.new(0.35, 0.6), Size = NumberSequence.new(0.35, 0.15), Color = ColorSequence.new(Color3.fromRGB(120, 180, 240)), Transparency = NumberSequence.new(0.2, 1) })
	FX.steam = part("SteamFX", V(1, 0.2, 1), Color3.new(1, 1, 1), nil, 1)
	FX.steamE = emitter(FX.steam, { Texture = SOFT, EmissionDirection = Enum.NormalId.Top, Speed = NumberRange.new(2, 4), Lifetime = NumberRange.new(1, 1.6),
		SpreadAngle = Vector2.new(25, 25), Size = NumberSequence.new(0.6, 2), Color = ColorSequence.new(Color3.new(1, 1, 1)), Transparency = NumberSequence.new(0.45, 1), Acceleration = V(0, 2, 0) })
	FX.dust = part("Dust", V(6, 1, 3), Color3.new(1, 1, 1), nil, 1)
	FX.dustE = emitter(FX.dust, { Texture = SOFT, Speed = NumberRange.new(1, 2), Lifetime = NumberRange.new(1, 1.6), SpreadAngle = Vector2.new(180, 180),
		Size = NumberSequence.new(1, 2.4), Color = ColorSequence.new(Color3.fromRGB(150, 145, 140)), Transparency = NumberSequence.new(0.5, 1) })
	FX.frost = part("Frost", V(1.5, 1, 1.5), Color3.new(1, 1, 1), nil, 1)
	FX.frostE = emitter(FX.frost, { Texture = "rbxasset://textures/particles/sparkles_main.dds", Speed = NumberRange.new(0.5, 1.5), SpreadAngle = Vector2.new(180, 180),
		Lifetime = NumberRange.new(0.6, 1), LightEmission = 1, LightInfluence = 0, Size = NumberSequence.new(0.18, 0), Color = ColorSequence.new(Color3.fromRGB(200, 230, 255)),
		Transparency = NumberSequence.new(0, 1) })
	FX.shard = part("Shard", V(1, 0.2, 1), Color3.new(1, 1, 1), nil, 1)
	FX.shardE = emitter(FX.shard, { Texture = "rbxasset://textures/particles/sparkles_main.dds", Speed = NumberRange.new(10, 18), SpreadAngle = Vector2.new(40, 40), Acceleration = V(0, -40, 0),
		Lifetime = NumberRange.new(0.3, 0.5), LightEmission = 0.4, Size = NumberSequence.new(0.5, 0.3), Color = ColorSequence.new(Color3.fromRGB(210, 235, 250)), Transparency = NumberSequence.new(0, 1) })
	FX.breath = part("Breath", V(0.3, 0.3, 0.3), Color3.new(1, 1, 1), nil, 1)
	FX.breathE = emitter(FX.breath, { Texture = SOFT, EmissionDirection = Enum.NormalId.Front, Speed = NumberRange.new(1.5, 2.5), Lifetime = NumberRange.new(0.8, 1.2),
		Size = NumberSequence.new(0.3, 1), Color = ColorSequence.new(Color3.new(1, 1, 1)), Transparency = NumberSequence.new(0.5, 1) })
	FX.fill = part("CamFill", V(0.2, 0.2, 0.2), Color3.new(1, 1, 1), nil, 1)
	FX.fillL = Instance.new("PointLight") FX.fillL.Color, FX.fillL.Range, FX.fillL.Brightness, FX.fillL.Shadows, FX.fillL.Parent = Color3.fromRGB(205, 215, 255), 16, 0.5, false, FX.fill
	table.clear(PRS.dyn) table.clear(PRS.st)
	for i = 1, NDYN do PRS.dyn[i] = mkPrint(i) end
	for i = 1, NST do PRS.st[i] = mkPrint(i) end
	PRS.di, PRS.si = 0, 0
	local made = {}
	local function eff(cls, nm)
		local o = Lighting:FindFirstChildOfClass(cls)
		if not o then o = Instance.new(cls) o.Name = nm o.Parent = Lighting table.insert(made, o) end
		return o
	end
	LFX.grade = eff("ColorCorrectionEffect", "Grade002")
	LFX.bloom = eff("BloomEffect", "Bloom002")
	LFX.dof = eff("DepthOfFieldEffect", "DOF002")
	LFX.rays = Lighting:FindFirstChildOfClass("SunRaysEffect")
	LFX.atmo = Lighting:FindFirstChildOfClass("Atmosphere")
	M.S0 = (_G.Story002 and _G.Story002.S0) or nil
	if not M.S0 then
		local s = { L = {} }
		for _, k in LPROPS do s.L[k] = Lighting[k] end
		local g = LFX.grade
		s.g = { g.TintColor, g.Saturation, g.Contrast, g.Brightness, g.Enabled }
		s.bloom = { LFX.bloom.Intensity, LFX.bloom.Size, LFX.bloom.Threshold, LFX.bloom.Enabled }
		s.dof = { LFX.dof.Enabled }
		s.rays = LFX.rays and LFX.rays.Intensity
		s.atmo = LFX.atmo and { LFX.atmo.Density, LFX.atmo.Haze, LFX.atmo.Color }
		M.S0 = s
	end
	if not LFX.atmo then LFX.atmo = Instance.new("Atmosphere") LFX.atmo.Name = "Atmo002" LFX.atmo.Parent = Lighting table.insert(made, LFX.atmo) end
	M.made = made
	inited = true
	for _, r in R do r.mk = nil park(r) end
	stage("ext")
	M.applyGrade("night")
	return true
end
local function init() if inited and R.Theo and R.Theo.m.Parent then return true end return M.setup() end

function M.applyGrade(name)
	local G = GR[name]
	if not G then return end
	CURG = G
	W(FX.snowE, "Rate", G.snow and 140 or 0)
	writeGrade(G)
end

local function setCF(P, cf)
	if P.last ~= cf then P.last = cf if P.o:IsA("Model") then P.o:PivotTo(cf) else P.o.CFrame = cf end end
end
local function world(t, T)
	local pp = F.pp
	local function put(n, cf)
		local P = PROPS[n]
		if not P then return end
		local o = pp[n]
		if o ~= nil then cf = o end
		setCF(P, cf or OFF)
	end
	local theo, june, dr = R.Theo, R.June, R.VanDriver
	local vn = PROPS.NightVan
	local vcf = F.vanCF or (vn and vn.p0) or OFF
	put("NightVan", vcf)
	if F.vanCF then
		local dx = S.vx and (vcf.X - S.vx) or 0
		S.vx = vcf.X
		if abs(dx) < 5 then S.wa = (S.wa or 0) + dx / 1.2 end
		for _, w in WHEELS do w.p.CFrame = vcf * CF(w.rel.Position) * CFrame.Angles(0, 0, -S.wa) * w.rel.Rotation end
	else S.vx = nil end
	local drOn = dr and dr.on and F.vanCF
	put("DriverCap", drOn and partCF(dr, "Head") * CF(0, 0.62 * dr.s, 0) or nil)
	put("CBMic", vcf * CF(6.1, 4.85, 1.5))
	if t < BT(24) then
		put("IceBootL", theo.on and partCF(theo, "Left Leg") * CF(0, -0.1, 0) or PROPS.IceBootL and PROPS.IceBootL.p0)
		put("IceBootR", theo.on and partCF(theo, "Right Leg") * CF(0, -0.1, 0) or PROPS.IceBootR and PROPS.IceBootR.p0)
	else
		put("IceBootL", CF(887.6, 0.9, 2) * CFrame.Angles(0, 0, rad(80)))
		put("IceBootR", CF(888.7, 1.2, 2.4) * CFrame.Angles(0, rad(30), 0))
	end
	local bot = PROPS.HotBottle
	if t < BT(19) then put("HotBottle", june.on and partCF(june, "Torso") * CF(0, -0.55, -0.75 * june.s) or (bot and bot.p0))
	elseif t < BT(27) then put("HotBottle", CF(876.6, 2.4, 14.3) * CFrame.Angles(rad(90), 0, 0))
	else put("HotBottle", CF(896, 2.7, 6.2) * CFrame.Angles(rad(25), rad(40), 0)) end
	if bot and bot.body then
		W(bot.body, "Material", t >= BT(28) + 0.06 and Enum.Material.Neon or Enum.Material.SmoothPlastic)
		W(bot.body, "Color", t >= BT(28) + 0.06 and Color3.fromRGB(110, 200, 245) or Color3.fromRGB(192, 57, 43))
	end
	local cat = PROPS.Cat
	if t < BT(21) + 0.5 then if t < TIMES[18] then put("Cat", cat and cat.p0) else local cx, cz, cyaw, ck = catAt(t) put("Cat", CF(cx, groundY(cx, cz) + 0.75 + 0.45 * abs(sin(ck * 200)), cz) * CFrame.Angles(0, rad(cyaw), 0)) end
	else put("Cat", june.on and partCF(june, "Torso") * CF(0, -0.2 * june.s, -0.95 * june.s) * CFrame.Angles(0, rad(90), 0) or nil) end
	if cat and cat.tail then cat.tail.CFrame = cat.o:GetPivot() * cat.tailRel * CFrame.Angles(0, rad(20 * sin(T * 6)), 0) end
	if t < BT(35) then put("SockL", PROPS.SockL and PROPS.SockL.p0) put("SockR", PROPS.SockR and PROPS.SockR.p0)
	elseif t < BT(42) then
		put("SockL", partCF(theo, "Left Leg") * CF(0, -0.55, -0.1)) put("SockR", partCF(theo, "Right Leg") * CF(0, -0.55, -0.1))
	else put("SockL", vcf * CF(-3.6, 8.05, -0.7) * CFrame.Angles(0, rad(15), 0)) put("SockR", vcf * CF(-3.0, 8.05, 0.6)) end
	local L = t - BT(10)
	for _, dp in DEBRIS do
		local cf
		if L < 0 then cf = dp.p0
		else
			local g, fl, v = 70, 0.7 + dp.p.Size.Y / 2, dp.v
			local tl = (v.Y + math.sqrt(v.Y * v.Y + 2 * g * math.max(0, dp.p0.Y - fl))) / g
			local tt = math.min(L, tl)
			cf = CF(dp.p0.Position + V(v.X * tt, v.Y * tt - 0.5 * g * tt * tt, v.Z * tt)) * CFrame.Angles(tt * dp.spin, tt * dp.spin * 0.7, 0)
		end
		if dp.last ~= cf then dp.last = cf dp.p.CFrame = cf end
	end
	W(LFX.win, "Transparency", L >= 0 and 1 or 0.4)
	put("Bread", L >= 0 and PROPS.Bread and PROPS.Bread.p0 or nil)
	local ck = PROPS.Crack
	if ck then for _, c in ck.o:GetChildren() do W(c, "Transparency", t >= BT(31) + 0.05 and 0 or 1) end end
	local dd = PROPS.Dryer3Door
	if dd and dd.hinge then
		local a = 100 * seg(t, BT(34) + 0.24, BT(34) + 0.62)
		put("Dryer3Door", CF(dd.hinge) * CFrame.Angles(0, rad(-a), 0) * CF(-dd.hinge) * dd.p0)
	end
	put("Crack", ck and ck.p0) put("Dryer3Steam", PROPS.Dryer3Steam and PROPS.Dryer3Steam.p0)
	if PROPS.Dryer3Steam then W(PROPS.Dryer3Steam.em, "Rate", t >= BT(34) + 0.22 and 15 or 0) end
	local rd = PROPS.Radio
	put("Radio", rd and rd.p0)
	if rd and rd.led then W(rd.led, "Transparency", F.led and 0 or 0.75) end
	-- ===== ending: lake + home =====
	if LK then
		local function prog(t0, dur) return clamp((t - t0) / dur, 0, 1) end
		local function crk(nm, t0, dur)
			local m = LK:FindFirstChild(nm)
			if not m then return end
			local kids, k = m:GetChildren(), prog(t0, dur)
			for i, c in kids do W(c, "Transparency", (k > 0 and k * #kids >= i - 0.5) and 0 or 1) end
		end
		local function vis(nm, t0)
			local m = LK:FindFirstChild(nm)
			if not m then return end
			for _, c in m:GetDescendants() do if c:IsA("BasePart") then W(c, "Transparency", t >= t0 and 0 or 1) end end
		end
		crk("CrackS1", BT(45) + 0.05, 0.25) crk("CrackS2", BT(46) + 0.1, 0.25) crk("CrackS3", BT(46) + 0.3, 0.25)
		crk("CrackVan", BT(46) + 0.2, 0.3) crk("CrackDrv", BT(50) + 0.1, 0.3)
		vis("HoleS1", BT(47) + 0.05) vis("HoleS2", BT(47) + 0.32) vis("HoleS3", BT(47) + 0.6) vis("HoleDrv", BT(50) + 0.45)
		W(LK:FindFirstChild("WetS1"), "Transparency", t >= BT(46) and 0.45 or 1) W(LK:FindFirstChild("WetS2"), "Transparency", t >= BT(46) and 0.45 or 1)
		W(LK:FindFirstChild("WetS3"), "Transparency", t >= BT(46) and 0.45 or 1) W(LK:FindFirstChild("WetVan"), "Transparency", t >= BT(46) and 0.45 or 1)
		W(LK:FindFirstChild("WetDrv"), "Transparency", t >= BT(50) + 0.2 and 0.45 or 1)
		local lakeOn = t < BT(54)
		for nm, t0 in { SteamS1 = BT(46), SteamS2 = BT(46), SteamS3 = BT(46), SteamVan = BT(46), SteamDrv = BT(50) } do
			local p = LK:FindFirstChild(nm)
			if p then W(p:FindFirstChildOfClass("ParticleEmitter"), "Rate", (lakeOn and t >= t0) and 20 or 0) end
		end
		local hd = PROPS.Hand
		local hk = prog(BT(50) + 0.45, 0.3)
		if hd and not hd.scaled then hd.scaled = true hd.o:ScaleTo(2.2) end
		put("Hand", (t >= BT(50) + 0.45 and t < BT(52)) and CF(1058.3, lerp(-4, 2.4, hk), 8.3) or nil)
		local ri = PROPS.CBRadioIce
		put("CBRadioIce", (ri and t >= BT(49) + 0.5 and t < BT(54)) and ri.p0 or nil)
		if ri and ri.led then W(ri.led, "Transparency", (F.led or t < BT(53)) and 0 or 0.75) end
	end
	for _, p in WRAPS do W(p, "Transparency", t >= BT(54) and 0 or 1) end
	local xs = t >= TIMES[57]
	if XM and XMS ~= xs then XMS = xs XM.Parent = xs and WS or nil for _, l in XL do l[1].Brightness = l[2] * (xs and 0.8 or 1) end end
end

local function enterBeat(i)
	local b = BEATS[i]
	stage(b.st)
	local G = GR[b.g]
	if G ~= CURG then M.applyGrade(b.g) end
	local loc = b.g == "laundro" and "L" or "S"
	if S.loc ~= loc then clearPrints(PRS.dyn) S.loc = loc end
	clearPrints(PRS.st) PRS.si = 0
	for _, tr in b.tr or {} do layTrail(tr, b.t) end
	if i >= 18 and i <= 21 then layTrail(hold("A", catPts(TIMES[18], math.min(TIMES[i + 1], TIMES[21] + 0.5), 12), 12, 0.35, 0.3), b.t) end -- tiny warm pawprints
	for k, e in b.face or {} do setFace(R[k], e) end
	if S.play and b.ev then
		local kind, p, n = b.ev[1], b.ev[2], b.ev[3]
		local e = kind == "splat" and FX.splatE or FX.puffE
		local pp = kind == "splat" and FX.splat or FX.puff
		pp.CFrame = CF(p) e:Emit(n)
		if kind == "splat" then FX.puff.CFrame = CF(p) FX.puffE:Emit(12) end
		if kind == "steam" then FX.steam.CFrame = CF(p) FX.steamE:Emit(n) end
	end
end

local function animate(r, dt)
	if not r.anim then return end
	if not r.on then
		if r.cur then r.tr[r.cur]:Stop(0) r.cur = nil r.anim:StepAnimations(0) end
		return
	end
	local p, sp = r.m:GetPivot().Position, nil
	if r.lp and dt > 0 then
		local v = (p - r.lp) / dt
		v = V(v.X, 0, v.Z)
		if v.Magnitude < 40 then r.v = (r.v or Vector3.zero):Lerp(v, 0.35) end
	end
	r.lp = p
	local want = r.loco and "walk" or "idle"
	if r.loco then
		local g = (r.v or Vector3.zero):Dot(r.fwd)
		sp = abs(g) < 0.5 and (r.loco == "run" and 1.3 or 0.9) or abs(g) / 16 / r.s
		sp = (r.loco == "run" and clamp(sp, 1.15, 1.4) or clamp(sp, 0.7, 1.1)) * (g < -0.5 and -1 or 1)
	end
	if r.cur ~= want then
		if r.cur then r.tr[r.cur]:Stop(0.15) end
		local tr = r.tr[want]
		tr:Play(0.15)
		if want == "idle" and tr.Length > 0 then tr.TimePosition = (r.ph * 0.73) % tr.Length end
		r.cur, r.sp = want, nil
	end
	sp = sp or 1
	if r.sp ~= sp then r.sp = sp r.tr[want]:AdjustSpeed(sp) end
	r.anim:StepAnimations(dt)
	for k in r.off do if k ~= "RJ" and r.j[k] then r.j[k].m6.Transform = CFrame.identity end end
end

local function step(i, t, T)
	local b = BEATS[i]
	local d = (BEATS[i + 1] and BEATS[i + 1].t or LEN) - b.t
	local L = t - b.t
	local u = clamp(L / d, 0, 1)
	S.frame += 1
	F = { shake = 0, shot = 1, u = u, pp = {} }
	for _, r in R do r.loco, r.idleOK = nil, nil if r.on then idle(r, T) end end
	local ok, ccf, fov, focus = pcall(b.f, L, u, d, T, t)
	if not ok then warn("[Story002] beat " .. i .. ": " .. tostring(ccf)) ccf = nil end
	for _, r in R do
		local gl = r.strider and r.m.Torso:FindFirstChild("StriderGlow")
		if gl then gl.Brightness = F.sg or 0.8 gl.Range = F.sg and 18 or 12 end
		if r.on then
			if r.mode == "sit" then
				if not r.off.RH then P(r, "RH", 0, 0, 90) end
				if not r.off.LH then P(r, "LH", 0, 0, -90) end
			end
			if r.strider and not r.loco and not r.off.RS and not r.off.LS then limb(r, "RS", 15) limb(r, "LS", 15) end
		end
		animate(r, S.dt or 0)
		applyJ(r)
		stepPrints(r, t, b)
	end
	world(t, T)
	for _, e in PRS.dyn do updatePrint(e, t, T) end
	for _, e in PRS.st do updatePrint(e, t, T) end
	S.lastT = t
	return b, ccf, fov, focus
end

local function finish(cam, b, ccf, fov, focus, shotE, T, t)
	writeGrade(CURG, math.max(F.flash or 0, 0.5 * (F.lens or 0)))
	if not ccf then return end
	fov = fov or 50
	if F.raw or shotE == 0 or not S.cc then
		S.cc, S.fv = ccf, fov
	else
		local a = 1 - math.exp(-8 * DT)
		S.cc, S.fv = S.cc:Lerp(ccf, a), lerp(S.fv, fov, a)
	end
	ccf, fov = S.cc, S.fv
	local sh = F.shake
	if b.cam == "snapZoom" then sh += 0.4 * clamp(1 - shotE / 0.15, 0, 1) fov *= 1 + 0.4 * (1 - ease(shotE / 0.16)) end
	local dist = focus and (focus - ccf.Position).Magnitude or 6
	local push = b.cam == "pullOut" and 0 or math.min(dist * 0.05 * shotE * ease(shotE / 0.6), dist * 0.18)
	local shake = CFrame.Angles(math.noise(T * 4, 1) * 0.03 * sh, math.noise(T * 4, 2) * 0.03 * sh, math.noise(T * 4, 3) * 0.015 * sh)
	ccf = ccf * CF(0, 0, -push)
	W(cam, "CameraType", Enum.CameraType.Scriptable)
	cam.CFrame = ccf * shake * (b.cam == "snapZoom" and DUTCH or CFrame.identity) * (S.noroll and CFrame.identity or ROLL)
	cam.FieldOfView = clamp(fov or 50, 20, 80)
	if LFX.dof and focus then
		W(LFX.dof, "Enabled", true)
		LFX.dof.FocusDistance = (focus - ccf.Position).Magnitude
		W(LFX.dof, "InFocusRadius", 10) W(LFX.dof, "NearIntensity", 0.1) W(LFX.dof, "FarIntensity", 0.25)
	end
	if S.play and F.emit then
		S.em = S.em or {}
		if not S.em[F.emit[1]] then S.em[F.emit[1]] = true FX.shard.CFrame = CF(F.emit[2]) FX.shardE:Emit(F.emit[3]) FX.puff.CFrame = CF(F.emit[2]) FX.puffE:Emit(8) end
	end
	local c = cam.CFrame
	FX.fill.CFrame = CF(c.Position + V(0, 1, 0))
	if CURG.snow then FX.snow.CFrame = CF(c.Position + V(0, 22, 0)) end
	W(FX.steam, "CFrame", F.steam and CF(F.steam) or OFF) W(FX.steamE, "Rate", F.steam and 12 or 0)
	W(FX.dust, "CFrame", F.dust and CF(F.dust) or OFF) W(FX.dustE, "Rate", F.dust and 15 or 0)
	W(FX.frost, "CFrame", F.frost and CF(F.frost) or OFF) W(FX.frostE, "Rate", F.frost and 8 or 0)
	if F.breath then FX.breath.CFrame = F.breath.head.CFrame * CF(0, -0.1, -0.7 * F.breath.s) CACHE[FX.breath] = nil end
	W(FX.breath, "CFrame", F.breath and FX.breath.CFrame or OFF) W(FX.breathE, "Rate", F.breath and 3 or 0)
end

function M.play()
	if not init() then return end
	local cam = WS.CurrentCamera
	S = { lastT = -1, frame = 0, play = true }
	CACHE = {}
	clearPrints(PRS.dyn)
	local t0, cur, shotKey, shotT0 = os.clock(), 0, nil, 0
	while true do
		local T = os.clock() - t0
		if T >= LEAD + LEN + TAIL then break end
		local t = math.max(0, T - LEAD)
		S.dt, S.prevT = T - (S.prevT or T), T
		DT = S.dt
		local i = math.max(cur, 1)
		while BEATS[i + 1] and t >= BEATS[i + 1].t do i += 1 end
		if i ~= cur then cur = i enterBeat(i) end
		local b, ccf, fov, focus = step(i, t, T)
		local key = i * 10 + F.shot
		if key ~= shotKey then shotKey, shotT0 = key, T end
		finish(cam, b, ccf, fov, focus, T - shotT0, T, t)
		task.wait()
	end
end

function M.resetCamera()
	local old = WS.CurrentCamera
	local p, lk = old.CFrame.Position, old.CFrame.LookVector
	local cam = Instance.new("Camera")
	cam.FieldOfView = 70
	cam.CFrame = CFrame.lookAt(p, p + lk, Vector3.yAxis)
	cam.Focus = CF(p + lk * 20)
	cam.Parent = WS
	WS.CurrentCamera = cam
	for _, c in old:GetChildren() do c.Parent = cam end
	old:Destroy()
	local s = M.S0
	if s then
		for k, v in s.L do Lighting[k] = v end
		if LFX.grade then LFX.grade.TintColor, LFX.grade.Saturation, LFX.grade.Contrast, LFX.grade.Brightness, LFX.grade.Enabled = table.unpack(s.g) end
		if LFX.bloom then LFX.bloom.Intensity, LFX.bloom.Size, LFX.bloom.Threshold, LFX.bloom.Enabled = table.unpack(s.bloom) end
		if LFX.dof then LFX.dof.Enabled = s.dof[1] end
		if s.rays and LFX.rays then LFX.rays.Intensity = s.rays end
		if LFX.atmo and s.atmo then LFX.atmo.Density, LFX.atmo.Haze, LFX.atmo.Color = table.unpack(s.atmo) end
	end
	if M.made and #M.made > 0 then
		for _, o in M.made do o:Destroy() end
		M.made = {}
		inited = false
	end
	if FX.folder then
		FX.snowE.Rate, FX.steamE.Rate, FX.dustE.Rate, FX.frostE.Rate, FX.breathE.Rate = 0, 0, 0, 0, 0
		for _, p in FX.folder:GetChildren() do if p:IsA("BasePart") and p.Name ~= "Print" then p.CFrame = OFF end end
		clearPrints(PRS.dyn) clearPrints(PRS.st)
	end
	for _, P in PROPS do setCF(P, P.p0) end
	for _, dp in DEBRIS do dp.p.CFrame, dp.last = dp.p0, nil end
	for _, w in WHEELS do w.p.CFrame = PROPS.NightVan.p0 * w.rel end
	if PROPS.Cat and PROPS.Cat.tail then PROPS.Cat.tail.CFrame = PROPS.Cat.p0 * PROPS.Cat.tailRel end
	if PROPS.HotBottle and PROPS.HotBottle.body then PROPS.HotBottle.body.Material, PROPS.HotBottle.body.Color = Enum.Material.SmoothPlastic, Color3.fromRGB(192, 57, 43) end
	if PROPS.Crack then for _, c in PROPS.Crack.o:GetChildren() do c.Transparency = 1 end end
	if PROPS.Dryer3Steam and PROPS.Dryer3Steam.em then PROPS.Dryer3Steam.em.Rate = 0 end
	if PROPS.Radio and PROPS.Radio.led then PROPS.Radio.led.Transparency = 0.75 end
	if LFX.win then LFX.win.Transparency = 0.4 end
	for _, r in R do
		if r.anim then for _, tr in r.tr do tr:Stop(0) end pcall(r.anim.StepAnimations, r.anim, 0) end
		for _, j in r.j do j.m6.Transform, j.m6.C0 = CFrame.identity, j.base end
		r.cur, r.lp, r.v, r.gy, r.gh, r.sp, r.mk, r.lpp = nil, nil, nil, nil, nil, nil, nil, nil
	end
	CACHE = {}
	CURG = nil
	S.loc = nil
	XMS = false
	for _, l in XL do l[1].Brightness = l[2] end
	if XM then XM.Parent = nil end
end

function M.preview(n, uu)
	if not init() then return end
	n = clamp(n or 1, 1, #BEATS)
	local cam = WS.CurrentCamera
	S = { lastT = BEATS[n].t, frame = 0, noroll = true }
	CACHE = {}
	clearPrints(PRS.dyn)
	DT = 1
	enterBeat(n)
	local dd = (BEATS[n+1] and BEATS[n+1].t or LEN) - BEATS[n].t
	local t = BEATS[n].t + (uu and uu * dd or 0.02)
	S.dt = 0.1
	for _ = 1, 12 do step(n, t, t + LEAD) end
	local b, ccf, fov, focus = step(n, t, t + LEAD)
	finish(cam, b, ccf, fov, focus, 0.25, t + LEAD, t)
	local cf, fv = cam.CFrame, cam.FieldOfView
	local fresh = Instance.new("Camera")
	fresh.FieldOfView, fresh.CFrame, fresh.Focus = fv, cf, cf * CF(0, 0, -20)
	fresh.Parent = WS
	WS.CurrentCamera = fresh
	for _, c in cam:GetChildren() do c.Parent = fresh end
	cam:Destroy()
	return b.line
end

M.BEATS, M.R = BEATS, R
_G.Story002 = M
return M
