--!nocheck
-- story001_cutscene.luau : stages + plays Story 001 "The Glow You Get for Being Brave" (standalone, 48 beats) in Studio EDIT mode.
-- Run once via execute_luau -> _G.Story001 = { setup(), play(), preview(n), resetCamera() }.
-- play() blocks for the take: task.spawn(_G.Story001.play, 1). ALWAYS call _G.Story001.resetCamera() after a take.
-- Beat t = start of the FIRST word of the beat's line in stories/001_brave-glow/words.json (audio seconds; video = audio + LEAD).
-- R6 rigs from ServerStorage.Cast001 (cast_001.luau, which scales Milo/Kid 0.75, YoungRosa 0.85). PrimaryPart = Head (pivot = head).
-- audit3 rework (2026-11-17): no sit/crate/lying poses; every on-stage rig plays a real R6 track; upright chest-deep water;
-- rigs never hidden (parked behind the huts instead); outline-only glow; camera occlusion guard; low DOF/bloom; cached writes.
local SS = game:GetService("ServerStorage")
local Lighting = game:GetService("Lighting")
local WS = workspace
local V, CF = Vector3.new, CFrame.new
local rad, sin, cos, abs, clamp = math.rad, math.sin, math.cos, math.abs, math.clamp

-- ================= knobs =================
local LEAD, TAIL, LEN = 0.3, 0.8, 52.1          -- voice.mp3 = 52.1 s; last image holds TAIL s (no fade: standalone ending)
local ROLL = CFrame.Angles(0, 0, rad(90))        -- vertical-video roll
local DUTCH = CFrame.Angles(0, 0, rad(2.5))      -- snapZoom tilt
local WATER, SAND = 5.4, 8.02
local GOLD, GOLD_HOT = Color3.fromRGB(255, 200, 60), Color3.fromRGB(255, 236, 150)
local SGN = { fwd = 1, out = 1, down = 1, left = 1 } -- flip one if a limb/head bends the wrong way in preview()
local OFF = CF(600, -300, -380)                  -- FX parking + rig measuring only (rigs park behind the huts, see park())
local SWIM_TILT = -30                           -- swim lean about the head pivot (deg); negative = body trails behind, face slightly down
local DT = 1 -- frame dt, set by play(); 1 = snap (preview)
local HINGE = V(550.5, 15.2, -380)               -- ShoreBell hinge (HingeY attribute overrides Y)
local BELL_T = 37.6                              -- bell starts swinging ("shore bell")
local IGNITE_K, IGNITE_Y = 39.75, 24.9           -- Kai ignites on "down."; YoungRosa on "screamed"
local ANIM = { walk = "rbxassetid://180426354", idle = "rbxassetid://180435571" } -- default R6 Animate
local EMOS = { "neutral", "grin", "scared", "shocked", "determined", "proud" }
local NAMES = { "Kai", "Milo", "Rosa", "YoungRosa", "Kid", "E1", "E2", "E3", "E4", "E5", "E6" }
-- ground ray skips thin pier furniture so nobody stands on a rail / post
local SKIP = { "rail", "post", "rope", "bell", "lamp", "sign", "fence" }

local function ease(x) x = clamp(x, 0, 1) return x * x * (3 - 2 * x) end
local function seg(u, a, b) return ease((u - a) / (b - a)) end
local function lerp(a, b, x) return a + (b - a) * x end
local function lerpA(a, b, x) return a + (((b - a + 180) % 360) - 180) * x end -- shortest-way yaw lerp
local function flashAt(u, at) return clamp(1 - abs(u - at) / 0.08, 0, 1) end
local function yawTo(a, b) return math.deg(math.atan2(-(b.X - a.X), -(b.Z - a.Z))) end -- yaw 0 faces -Z
local function fwdOf(y) return V(-sin(rad(y)), 0, -cos(rad(y))) end

-- cached property writes: only touch an Instance property when the value really changes (beat-entry stutters)
local CACHE = {}
local function W(o, k, v)
	if not o then return end
	local c = CACHE[o]
	if not c then c = {} CACHE[o] = c end
	if c[k] ~= v then c[k] = v o[k] = v end
end

-- ================= rigs =================
local R, CAST, RP, RPC, F = {}, nil, nil, nil, {} -- F = per-frame flags, rebuilt every step()
local S = { lastT = -1, frame = 0 }
local JN = { RS = "Right Shoulder", LS = "Left Shoulder", RH = "Right Hip", LH = "Left Hip", N = "Neck", RJ = "RootJoint" }

local function skipHit(inst)
	local n = (inst.Name .. " " .. (inst.Parent and inst.Parent.Name or "")):lower()
	for _, s in SKIP do if n:find(s, 1, true) then return true end end
	return false
end
local function groundY(x, z) -- sand / seabed / pier deck (water, cast, rails, posts, bell ignored)
	if not RP then return SAND end
	local y = 60
	for _ = 1, 4 do
		local hit = WS:Raycast(V(x, y, z), V(0, -(y + 20), 0), RP)
		if not hit then return SAND end
		if not skipHit(hit.Instance) then return hit.Position.Y end
		y = hit.Position.Y - 0.05
	end
	return SAND
end

local function register(m)
	local r = { m = m, j = {}, off = {}, ph = (#m.Name * 1.7) % 6 }
	for k, n in JN do
		local mt = m:FindFirstChild(n, true)
		if mt and mt:IsA("Motor6D") then
			local b = mt:GetAttribute("S11Base")
			if not b then b = mt.C0 mt:SetAttribute("S11Base", b) end -- live (already scaled) C0, captured once
			mt.C0 = b
			mt.Transform = CFrame.identity
			r.j[k] = { m6 = mt, base = b }
		end
	end
	m:PivotTo(OFF) -- upright + neutral joints before measuring baseY
	r.head = m:FindFirstChild("Head")
	local ok, s = pcall(function() return m:GetScale() end)
	r.s = ok and s or 1
	local low = math.huge
	for _, p in m:GetChildren() do if p:IsA("BasePart") then low = math.min(low, p.Position.Y - p.Size.Y / 2) end end
	r.baseY = m:GetPivot().Y - low
	local hl = m:FindFirstChild("Glow001") or Instance.new("Highlight")
	-- outline only: the fill tint washed faces out / darkened hair (audit3)
	hl.Name, hl.FillTransparency, hl.FillColor, hl.OutlineColor = "Glow001", 1, GOLD, GOLD
	hl.DepthMode, hl.Adornee, hl.Enabled, hl.Parent = Enum.HighlightDepthMode.Occluded, m, false, m
	r.hl = hl
	local hum = m:FindFirstChildOfClass("Humanoid")
	if hum then hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
	R[m.Name] = r
	return r
end

local function P(r, k, x, y, z) if r then r.off[k] = (r.off[k] or CFrame.identity) * CFrame.Angles(rad(x), rad(y), rad(z)) end end
-- limb: fwd = swing forward (deg), out = raise sideways (deg). R6 right/left joints are mirrored about Z.
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

-- off-stage: park VISIBLE, standing, behind the huts (x~755, spread out, <200 studs from the action). Never hidden by
-- transparency or parked far away: both made Studio reload hair/clothing textures (white hair / missing swimsuit pops).
local function park(r)
	if r.mk == "park" then return end
	r.on, r.mode, r.mk, r.gy, r.gh, r.lp = false, nil, "park", nil, nil, nil
	local p = r.park
	r.m:PivotTo(CF(p.X, groundY(p.X, p.Z) + r.baseY, p.Z) * CFrame.Angles(0, rad(90), 0))
	W(r.hl, "Enabled", false)
end
-- modes: nil stand · "float" upright chest-deep (struggling) · "swim" upright chest-deep crawl
local function place(r, x, z, yaw, mode, dy)
	if not r then return end
	if not x then park(r) return end
	r.mode, r.mk, r.pf = mode, nil, S.frame
	r.on, r.x, r.z, r.yaw, r.fwd = true, x, z, yaw or 0, fwdOf(yaw or 0)
	local rot = CFrame.Angles(0, rad(r.yaw), 0)
	if mode == "swim" then
		-- head pivot just above the water, body trails behind/below by SWIM_TILT, small roll from the stroke
		local y = WATER + 0.7 * r.s + 0.06 * r.s * sin(os.clock() * 3 + r.ph) + (dy or 0)
		r.m:PivotTo(CF(x, y, z) * rot * CFrame.Angles(rad(SWIM_TILT), 0, 0) * CFrame.Angles(0, 0, rad(0.5 * (r.roll or 0))))
		return
	end
	local y
	if mode == "float" then
		y = WATER + 1.12 * r.s + 0.08 * r.s * sin(os.clock() * 2.4 + r.ph)
	else
		-- ground height smoothed (~10/s) while moving; snaps on teleports (> 3 studs)
		local gy, h = groundY(x, z), V(x, 0, z)
		if r.gy and r.gh and (h - r.gh).Magnitude < 3 then gy = lerp(r.gy, gy, math.min(1, 10 * DT)) end
		r.gy, r.gh = gy, h
		y = gy + r.baseY
	end
	r.m:PivotTo(CF(x, y + (dy or 0), z) * rot)
end
local function pos(r) return r.m:GetPivot().Position end
local function setFace(r, e)
	if r and r.emo ~= e then
		r.emo = e
		pcall(CAST.setFace, r.m, e)
	end
end

-- ================= gestures (degrees) =================
-- walk / run / idle = real R6 AnimationTracks (animate()); gestures below override single joints via C0, max one per beat.
local function idle(r, T) r.idleOK = true head(r, 0, 6 * sin(T * 0.31 + r.ph) * sin(T * 0.13 + 2 * r.ph)) end
local function walk(r) r.loco = "walk" end
local function run(r) r.loco = "run" torso(r, 4, 0) end
local function swim(r, T) -- upright crawl: alternating strokes 20..160 deg, flutter kick, small roll, splash per hand entry
	-- owner 2026-11-18: the 110-170 deg arm sway read as waving. Front crawl: each arm makes a full circle
	-- (hip -> back -> overhead -> forward entry -> pull down), arms opposite; the opaque water hides the underwater half.
	local w = T * 5 + r.ph
	local a = (360 - math.deg(w) % 360) % 360
	limb(r, "RS", a, 8) limb(r, "LS", (a + 180) % 360, 8)
	limb(r, "RH", 10 * sin(T * 12)) limb(r, "LH", -10 * sin(T * 12))
	head(r, SWIM_TILT, 0)
	r.roll = 6 * sin(w)
	local n, f = math.floor(w / math.pi), r.fwd
	if r.stk and n ~= r.stk then
		local p = pos(r) + f * 1.6 * r.s + V(-f.Z, 0, f.X) * (n % 2 == 0 and 0.8 or -0.8) * r.s
		F.stroke = V(p.X, WATER, p.Z)
	end
	r.stk = n
end
-- struggling in water: both arms up above the surface, short alternating splashes, head up (face readable)
local function struggle(r, T)
	local w = T * 9 + r.ph
	limb(r, "RS", 150 + 18 * sin(w), 25) limb(r, "LS", 150 + 18 * sin(w + math.pi), 25)
	head(r, -10, 0)
end
local function wave1(r, k, L, T, dur) -- one short wave, then the arm drops back to idle
	local a = 1 - seg(L, (dur or 0.8) - 0.2, dur or 0.8)
	if a > 0 then limb(r, k, (8 + 10 * sin(T * 11)) * a, 125 * a) end
end
local function point(r, k) limb(r, k or "RS", 90, 0) end
local function bothWave(r, T) limb(r, "RS", 150 + 18 * sin(T * 9), 25) limb(r, "LS", 150 + 18 * sin(T * 9 + math.pi), 25) end
local function hug(r) limb(r, "RS", 85, -12) limb(r, "LS", 85, -12) end
local function lookHands(r, k) limb(r, "RS", 55 * k, -6 * k) limb(r, "LS", 55 * k, -6 * k) head(r, 30 * k, 0) end
local function clap(r, T) local o = 14 - 14 * abs(sin(T * 12)) limb(r, "RS", 75, o) limb(r, "LS", 75, o) end
-- hands loosely in front (standing), small shake
local function tremble(r, T) limb(r, "RS", 28 + 3 * sin(T * 45), -6) limb(r, "LS", 28 + 3 * sin(T * 47 + 1), -6) end
local function ears(r) limb(r, "RS", 170, 25) limb(r, "LS", 170, 25) end
local function pullRope(r, T) local p = math.max(0, sin(T * 7)) limb(r, "RS", 165 - 45 * p, -6) limb(r, "LS", 165 - 45 * p, -6) end
local function huddle(r) limb(r, "RS", 35, -6) limb(r, "LS", 35, -6) head(r, 10, 0) end

-- ================= camera helpers =================
local function safe(p) return V(p.X, math.max(p.Y, groundY(p.X, p.Z) + 1.2, WATER + 1), p.Z) end -- never under water / in sand / deck
-- occlusion guard: if set geometry (posts, rails, towers, huts, props) sits on/near the subject->camera line,
-- pull the camera to 1.5 studs in front of the hit
local function guard(p, tg)
	if not RPC then return p end
	local d = p - tg
	local m = d.Magnitude
	if m < 0.5 then return p end
	local hit = WS:Raycast(tg, d.Unit * (m + 1.5), RPC)
	if not hit then return p end
	local hd = (hit.Position - tg).Magnitude
	if hd < 2 then return p end
	return tg + d.Unit * math.min(m, hd - 1.5)
end
local function look(p, tg) return CFrame.lookAt(guard(safe(p), tg), tg) end
-- front-of-face camera: d studs (scaled for kids), side offset, target below the head so the head sits in the upper third
local function faceP(r, d, side, up, low)
	local h, f, s = r.head.Position, r.fwd, r.s
	return h + f * d * s + V(-f.Z, 0, f.X) * (side or 0.8) * s + V(0, (up or 0.3) * s, 0), h - V(0, (low or 0.9) * s, 0)
end
local function faceCam(r, d, side, up, fov, low) local p, tg = faceP(r, d, side, up, low) return look(p, tg), fov or 48, r.head.Position end
local function shot(p, tg, fov) return look(p, tg), fov or 50, tg end
-- side-on two-shot: both faces in profile/3-4, facing each other, camera pitched slightly down
local function twoP(a, b, dist, side)
	local pa, pb = a.head.Position, b.head.Position
	local mid = (pa + pb) / 2
	local dir = V(pb.X - pa.X, 0, pb.Z - pa.Z).Unit
	return mid + V(-dir.Z, 0, dir.X) * (dist or 7) * (side or 1) + V(0, 1.2, 0), mid - V(0, 0.9, 0)
end
local function two(a, b, dist, side, fov) local p, tg = twoP(a, b, dist, side) return look(p, tg), fov or 44, tg end
-- camera just beside a's eyeline looking at b: b looks at a, just off-lens (never into it)
local function eyeline(a, b, side, fov, low)
	local pa, pb = a.head.Position, b.head.Position
	local dir = V(pb.X - pa.X, 0, pb.Z - pa.Z).Unit
	local p = pa - dir * 1.0 + V(-dir.Z, 0, dir.X) * (side or 1.4) + V(0, 1.0, 0)
	return look(p, pb - V(0, low or 0.8, 0)), fov or 44, pb
end
-- POV from a's eyes toward b (no blurred shoulder in frame)
local function pov(a, b, fov)
	local pa, pb = a.head.Position, b.head.Position
	return look(pa + (pb - pa).Unit * 1.0 + V(0, 0.2, 0), pb), fov or 30, pb
end
-- close swim tracking: 3/4 front-side, just above the water (deterministic head pivot: F.raw)
local function swimCam(r, fov)
	local h, f = pos(r), r.fwd
	local p = V(h.X, WATER, h.Z) + f * 7 + V(-f.Z, 0, f.X) * 5 + V(0, 3.5, 0)
	F.raw = true
	return look(p, V(h.X, WATER + 1.5, h.Z) + f * 0.8), fov or 46, h
end
-- snap pull-out: close -> wide inside the first 35% of the beat
local function pull(u, p1, t1, p2, t2, f1, f2) local k = ease(u / 0.35) local tg = t1:Lerp(t2, k) return look(p1:Lerp(p2, k), tg), lerp(f1, f2, k), tg end

-- ================= stages (default marks per beat group: {x, z, yaw, mode}) =================
local YR_Y = yawTo(V(604, 0, -440), V(566, 0, -446))          -- YoungRosa faces the drowning swimmer
local FIN_R = yawTo(V(607.5, 0, -366), V(609.8, 0, -364.2))   -- finale: Rosa <-> rescued Kid face each other
local ST = {
	beach = { Kai = { 620, -386, 90 }, Milo = { 622.5, -389.5, 90 }, Rosa = { 611, -414, 90 }, E1 = { 626, -378, 180 }, E2 = { 629, -395, 0 },
		E3 = { 650, -371, 90 }, E4 = { 656, -366, 90 }, E5 = { 641, -375, -90 }, E6 = { 648, -375, 90 } },
	storm = { Kai = { 603, -390, 90 }, Milo = { 588, -392, -90, "float" }, Rosa = { 620, -399, 90 }, E1 = { 624, -401, 90 }, E2 = { 627, -404, 90 },
		E3 = { 629, -399, 90 }, E4 = { 631, -405, 90 }, E5 = { 626, -408, 90 } },
	-- night: Rosa stands by the tower leg facing Kai (no crate), lantern at her feet
	night = { Rosa = { 609, -405, 145 }, Kai = { 605.5, -400, -35 } },
	flash = { YoungRosa = { 604, -440, YR_Y }, E3 = { 566, -446, -90, "float" }, E1 = { 624, -436, 90 }, E2 = { 626, -444, 90 } },
	climax = { Kai = { 603, -364, 90 }, Kid = { 586, -372, -90, "float" }, Rosa = { 612, -455, 0 }, E1 = { 612, -466, 180 }, E2 = { 615.5, -468, 180 },
		E3 = { 650, -371, 90 }, E4 = { 656, -366, 90 }, E5 = { 554.2, -381.6, 90 }, E6 = { 586, -377.2, 180 }, Milo = { 640, -372, 90 } },
	finale = { Kai = { 598, -380, -90 }, Milo = { 599.6, -380, 90 }, Rosa = { 607.5, -366, FIN_R }, Kid = { 609.8, -364.2, FIN_R + 180 },
		E1 = { 624, -363, 90 }, E2 = { 625, -367.5, 90 }, E3 = { 624.5, -372, 90 }, E4 = { 627.5, -370, 90 }, E5 = { 562, -381.6, 90 }, E6 = { 586, -377.6, -90 } },
}
-- re-place only rigs whose mark changed or that a beat moved since (cheap beat entry)
local function stage(name)
	local s = ST[name]
	for n, r in R do
		local e = s[n]
		if not e then park(r)
		elseif r.mk ~= e then place(r, e[1], e[2], e[3], e[4]) r.mk = e end
	end
end

-- drift paths (audio time t)
local function miloX(t) return clamp(588 - 4.2 * (t - 11.86), 566, 588) end
local function kidX(t) return clamp(586 - 1.5 * (t - 29.5), 566, 586) end
local function strollZ(r, x, z1, z2, u) place(r, x, lerp(z1, z2, u), z2 < z1 and 0 or 180) walk(r) end

-- ================= beats =================
local function cut2(u, at) if u >= at then F.shot = 2 return true end return false end
local function kaiAtRope() place(R.Kai, 552.4, -378.2, 46.5) end -- Kai 2.6 studs from the rope, facing it
-- pier run tracking: ahead of Kai, inside the rails, 2.2 studs to his side (no rail between lens and Kai)
local function pierCam(minX, dx)
	local kp = pos(R.Kai)
	F.raw = true
	return shot(V(math.max(kp.X - (dx or 9), minX or -1e9), kp.Y + 1.3, -382.2), kp - V(0, 0.6, 0), 50)
end

local BEATS = {
	{ t = 0.00, line = "In this beach town,", set = "sunny_beach", st = "beach", cam = "snapZoom", vfx = { "gold_outline_shimmer" },
		face = { Kai = "shocked", E = "grin", Milo = "grin", Rosa = "neutral" },
		f = function(L, u, d, T) lookHands(R.Kai, 1) strollZ(R.E1, 626, -376, -394, u) strollZ(R.E2, 629, -396, -378, u)
			return faceCam(R.Kai, 4.8, 0.9, 0.3, 46) end },
	{ t = 1.40, line = "the first time", set = "sunny_beach", st = "beach", cam = "pullOut", vfx = { "gold_outline_shimmer" }, face = { Kai = "neutral" },
		f = function(L, u) strollZ(R.E1, 626, -378, -382, u) strollZ(R.E2, 629, -394, -390, u)
			local p, tg = faceP(R.Kai, 4.5) return pull(u, p, tg, V(596, 20, -388), V(628, 9, -384), 46, 56) end },
	{ t = 1.98, line = "you're truly brave,", set = "sunny_beach", st = "beach", cam = "pushIn", vfx = { "splash" }, face = { E1 = "determined" },
		f = function(L, u) local x = lerp(612, 599.5, u) place(R.E1, x, -372, 90) run(R.E1)
			-- runs to the waterline only (no sinking into the drop-off); spray at the edge, front 3/4 camera
			if x < 600.5 then F.splash = V(596.6, WATER, -372) end
			return shot(V(593.5, 10.8, -366), V(x, 9.2, -372), 50) end },
	{ t = 3.22, line = "your outline glows gold.", set = "sunny_beach", st = "beach", cam = "pushIn", vfx = { "gold_outline_shimmer" }, face = { E5 = "grin", E6 = "grin" },
		f = function(L, u, d, T) place(R.E5, 640, -374, 90) place(R.E6, 640, -379, 90) wave1(R.E5, "LS", L, T)
			if u > 0.35 then place(R.E6, 640, -379, lerpA(90, 180, seg(u, 0.35, 0.55))) point(R.E6, "RS") end
			return shot(V(626, 12.6, -376.5), V(640, 11.2, -376.5), 52) end },
	{ t = 4.86, line = "Forever.", set = "sunny_beach", st = "beach", cam = "pushIn", face = { Kai = "neutral" },
		f = function(L, u) head(R.Kai, 15, 0) strollZ(R.E1, 627, -380, -392, u) strollZ(R.E2, 630, -394, -382, u)
			return faceCam(R.Kai, 6.5, 1.4, 0.4, 50) end },
	{ t = 5.68, line = "Everyone glows.", set = "sunny_beach", st = "beach", cam = "pullOut", vfx = { "gold_outline_shimmer" },
		f = function(L, u, d, T) head(R.E5, -15, 0) head(R.E6, -15, 0)
			local k = (T * 0.9) % 1
			local a, b = V(641.8, 11.5, -375), V(647.2, 11.5, -375)
			local odd = math.floor(T * 0.9) % 2 == 1
			if k < 0.25 then limb(odd and R.E6 or R.E5, "RS", 120 * (1 - k / 0.25), 0) end
			if odd then a, b = b, a end
			F.ball = a:Lerp(b, k) + V(0, 4 * sin(math.pi * k), 0)
			local p, tg = faceP(R.Kai, 4.5) return pull(u, p, tg, V(596, 24, -404), V(634, 8, -381), 46, 58) end },
	{ t = 6.76, line = "Even my little brother, Milo.", set = "sunny_beach", st = "beach", cam = "pushIn", face = { Milo = "grin" },
		f = function(L, u, d, T) wave1(R.Milo, "RS", L, T, 0.9) return faceCam(R.Milo, 6, 2.2, 0.3, 50) end },
	{ t = 8.50, line = "I'm sixteen,", set = "sunny_beach", st = "beach", cam = "pushIn", face = { Kai = "scared", Milo = "grin" },
		f = function(L, u) local k, m = seg(u, 0, 0.4), R.Milo
			place(R.Kai, 620, -386, lerpA(90, yawTo(V(620, 0, -386), V(622.5, 0, -389.5)), k))
			place(m, 622.5, -389.5, yawTo(V(622.5, 0, -389.5), V(620, 0, -386))) head(m, -20, 0)
			return two(R.Kai, m, 14, -1, 55) end },
	{ t = 9.54, line = "and I've never lit up.", set = "sunny_beach", st = "beach", cam = "snapZoom", face = { Kai = "scared" },
		f = function() return faceCam(R.Kai, 4.6, 1.2, 0.3, 50) end },
	{ t = 10.74, line = "Then the storm came.", set = "stormy_beach", st = "storm", cam = "pullOut", vfx = { "rain", "lightning_flash" },
		face = { Kai = "scared", Milo = "grin", E = "scared" },
		f = function(L, u, d, T) place(R.Milo, 588, -392, -90, "float", 0.15 * sin(T * 3)) F.lightning = flashAt(u, 0.25)
			return pull(u, V(594, 9.5, -397), V(588, 6.8, -392), V(586, 16, -406), V(604, 9, -391), 46, 56) end },
	{ t = 11.86, line = "A rip current", set = "stormy_beach", st = "storm", cam = "pushIn", vfx = { "rain", "rip_current_foam" }, face = { Milo = "scared" },
		f = function(L, u, d, T, t) local x = miloX(t) place(R.Milo, x, -392, -90, "float", 0.15 * sin(T * 3))
			struggle(R.Milo, T) F.foam = V(x - 2, WATER + 0.1, -392)
			return shot(V(x + 9.5, WATER + 3.4, -388), R.Milo.head.Position - V(0, 1, 0), 46) end },
	{ t = 12.40, line = "dragged Milo out.", set = "stormy_beach", st = "storm", cam = "pushIn", vfx = { "rain", "splash" }, face = { Milo = "scared" },
		f = function(L, u, d, T, t) local x = miloX(t) place(R.Milo, x, -392, -90, "float", 0.2 * sin(T * 4)) struggle(R.Milo, T)
			F.splash = V(x, WATER, -392) return shot(V(x + 10.5, WATER + 3.6, -388), R.Milo.head.Position - V(0, 1, 0), 46) end },
	{ t = 13.90, line = "He screamed my name.", set = "stormy_beach", st = "storm", cam = "snapZoom", vfx = { "rain", "splash" }, face = { Milo = "shocked" },
		f = function(L, u, d, T, t) local x = miloX(t) place(R.Milo, x, -392, -90, "float", 0.2 * sin(T * 4))
			struggle(R.Milo, T) F.splash = V(x, WATER, -392)
			return faceCam(R.Milo, 11, 3, 1.2, 46, 1.0) end },
	{ t = 15.06, line = "And I froze.", set = "stormy_beach", st = "storm", cam = "snapZoom", vfx = { "rain" }, face = { Kai = "scared", Milo = "scared" },
		f = function(L, u, d, T, t) place(R.Milo, miloX(t), -392, -90, "float", 0.2 * sin(T * 4)) struggle(R.Milo, T)
			-- reverse: Kai's POV of glowing Milo far out (no blurred shoulder)
			if cut2(u, 0.55) then return pov(R.Kai, R.Milo, 30) end
			return faceCam(R.Kai, 5.2, -1.4, 0.3, 54) end },
	{ t = 16.46, line = "Rosa, the brightest glow", set = "stormy_beach", st = "storm", cam = "pushIn", vfx = { "rain", "gold_outline_bright_rosa" },
		face = { Rosa = "determined", Kai = "scared" },
		f = function(L, u, d, T, t) place(R.Milo, miloX(t), -392, -90, "float")
			local a, b = V(620, 0, -399), V(604, 0, -395.5)
			local p = a:Lerp(b, u)
			place(R.Rosa, p.X, p.Z, yawTo(a, b)) run(R.Rosa)
			return shot(V(p.X - 8, 11.6, p.Z - 5), V(p.X, 11, p.Z), 48) end },
	{ t = 17.50, line = "on the beach,", set = "stormy_beach", st = "storm", cam = "pullOut", vfx = { "rain", "gold_outline_bright_rosa" }, face = { E = "scared" },
		f = function(L, u, d, T, t) place(R.Milo, miloX(t), -392, -90, "float")
			-- runs to the waterline only (x >= 597.8); the swim starts in deep water next beat
			local x = lerp(604, 597.8, u) place(R.Rosa, x, -395.5, 90) run(R.Rosa)
			if x < 599.5 then F.splash = V(596.5, WATER, -395.5) end
			for _, n in { "E1", "E2", "E3", "E4", "E5" } do huddle(R[n]) end
			local p, tg = faceP(R.Rosa, 4, 4.8) return pull(u, p, tg, V(584, 18, -378), V(606, 8, -398), 46, 58) end },
	{ t = 18.62, line = "swam past me", set = "stormy_beach", st = "storm", cam = "pushIn", vfx = { "rain", "splash" }, face = { Rosa = "determined" },
		f = function(L, u, d, T, t) place(R.Milo, miloX(t), -392, -90, "float", 0.2 * sin(T * 4))
			local x = 588 - 12 * (t - 18.62) place(R.Rosa, x, -394, 90, "swim") swim(R.Rosa, T)
			F.splash = V(x + 1.6, WATER, -394)
			return swimCam(R.Rosa) end },
	{ t = 19.40, line = "and saved him.", set = "stormy_beach", st = "storm", cam = "pullOut", vfx = { "rain" },
		face = { Rosa = "determined", Milo = "scared", Kai = "scared" },
		f = function(L, u) local x = lerp(598.5, 604, u)
			-- time-compressed: both walk up the sand side by side, Milo catching his breath (head down)
			place(R.Rosa, x, -393.5, -90) walk(R.Rosa)
			place(R.Milo, x - 2.6, -394.4, -90) walk(R.Milo) head(R.Milo, 15, 0)
			place(R.Kai, 610, -387, yawTo(V(610, 0, -387), V(x, 0, -394.5)))
			local mid = (R.Rosa.head.Position + R.Milo.head.Position) / 2
			return pull(u, V(612, 9.6, -400), mid, V(616, 16, -404), mid, 48, 56) end },
	{ t = 20.56, line = "I asked how", set = "tower_night", st = "night", cam = "pushIn", vfx = { "hand_tremble" }, face = { Rosa = "scared", Kai = "neutral" },
		f = function(L, u, d, T) tremble(R.Rosa, T) head(R.Kai, 10, 0)
			return faceCam(R.Rosa, 5.5, 2.8, 0.3, 48, 1.8) end },
	{ t = 21.02, line = "she got so bright.", set = "tower_night", st = "night", cam = "pushIn", vfx = { "hand_tremble" }, face = { Rosa = "scared" },
		f = function(L, u, d, T) tremble(R.Rosa, T) return eyeline(R.Kai, R.Rosa, 3.0, 44, 1.8) end },
	{ t = 22.14, line = "\"I didn't swim out.", set = "flashback_beach", st = "flash", cam = "pushIn", vfx = { "flashback_vignette" },
		face = { YoungRosa = "scared", E = "scared" },
		f = function()
			-- profile: YoungRosa looking toward the struggling swimmer (E3 struggles by default in float mode)
			return faceCam(R.YoungRosa, 6.5, 5, 0.4, 48) end },
	{ t = 23.22, line = "I was too scared.", set = "flashback_beach", st = "flash", cam = "pushIn", vfx = { "flashback_vignette" }, face = { YoungRosa = "scared" },
		f = function(L, u) place(R.YoungRosa, 606, -440, YR_Y)
			return faceCam(R.YoungRosa, 5, 4.6, 0.3, 46) end },
	{ t = 24.44, line = "So I screamed for help", set = "flashback_beach", st = "flash", cam = "snapZoom", vfx = { "flashback_vignette", "gold_ignite_pulse" },
		face = { YoungRosa = "determined" },
		f = function(L, u, d, T) place(R.YoungRosa, 606, -440, YR_Y) bothWave(R.YoungRosa, T) head(R.YoungRosa, -10, 0)
			return faceCam(R.YoungRosa, 5, 4.6, 0.2, 46) end },
	{ t = 25.40, line = "until someone came.\"", set = "flashback_beach", st = "flash", cam = "pushIn", vfx = { "flashback_vignette" },
		face = { YoungRosa = "scared", E1 = "determined", E2 = "determined" },
		f = function(L, u) local r = R.YoungRosa
			place(r, 606, -440, YR_Y)
			-- helpers run in from behind her (stay > 4 studs from the lens)
			place(R.E1, lerp(624, 612, u), -437, 90) run(R.E1) place(R.E2, lerp(626, 613, u), -444, 90) run(R.E2)
			local h, f = r.head.Position, r.fwd
			return look(h + f * 5.5 + V(-f.Z, 0, f.X) * 3.5 + V(0, 0.4, 0), h - V(0, 0.8, 0)), 46, h end },
	{ t = 26.72, line = "Her glow came", set = "tower_night", st = "night", cam = "pushIn", face = { Rosa = "proud" },
		f = function() return faceCam(R.Rosa, 5.5, 2.8, 0.3, 46, 1.8) end },
	{ t = 27.40, line = "while she was shaking.", set = "tower_night", st = "night", cam = "pullOut", vfx = { "hand_tremble" }, face = { Rosa = "proud", Kai = "shocked" },
		f = function(L, u, d, T) tremble(R.Rosa, T)
			local p1, t1 = faceP(R.Rosa, 5, 2.8, 0.3, 1.8)
			return pull(u, p1, t1, p1 + (p1 - t1).Unit * 3 + V(0, 1.5, 0), t1, 48, 56) end },
	{ t = 28.50, line = "A week later,", set = "sunny_beach", st = "climax", cam = "pullOut", face = { E = "grin", Kid = "scared", Kai = "neutral", Rosa = "neutral" },
		f = function(L, u, d, T, t) place(R.Kid, kidX(t), -372, -90, "float", 0.15 * sin(T * 3))
			return pull(u, V(572, 19.5, -362), V(556, 11.5, -381), V(592, 21, -401), V(566, 9, -379), 50, 56) end },
	{ t = 29.50, line = "a kid got swept out", set = "sunny_beach", st = "climax", cam = "pushIn", vfx = { "splash", "rip_current_foam" }, face = { Kid = "scared" },
		f = function(L, u, d, T, t) local x = kidX(t) place(R.Kid, x, -372, -90, "float", 0.2 * sin(T * 4)) struggle(R.Kid, T)
			F.splash, F.foam = V(x, WATER, -372), V(x - 2, WATER + 0.1, -372)
			return shot(V(x + 8.5, WATER + 3.4, -373.5), R.Kid.head.Position - V(0, 1, 0), 46) end },
	{ t = 30.50, line = "near the pier.", set = "sunny_beach", st = "climax", cam = "pushIn", vfx = { "splash" }, face = { Kid = "shocked" },
		f = function(L, u, d, T, t) local x = kidX(t) place(R.Kid, x, -372, 135, "float", 0.2 * sin(T * 4)) struggle(R.Kid, T)
			F.splash = V(x, WATER, -372) return shot(V(x - 7, WATER + 3.5, -365.5), R.Kid.head.Position - V(0, 1, 0), 46) end },
	{ t = 31.68, line = "Rosa was far off,", set = "sunny_beach", st = "climax", cam = "pullOut", face = { Rosa = "neutral" },
		f = function(L, u) head(R.Rosa, 0, 25) local p, tg = faceP(R.Rosa, 4.8, 2.2)
			return pull(u, p, tg, V(600, 18, -479), V(614, 12, -460), 46, 56) end },
	{ t = 32.64, line = "looking away.", set = "sunny_beach", st = "climax", cam = "pushIn", face = { Rosa = "grin", E1 = "grin", E2 = "grin" },
		f = function(L, u, d, T) wave1(R.Rosa, "RS", L, T, 0.9) head(R.E1, 0, 15)
			return shot(V(612.8, 12.4, -446.5), V(612, 11, -457), 50) end },
	{ t = 33.56, line = "I couldn't swim out there.", set = "sunny_beach", st = "climax", cam = "pushIn", face = { Kai = "scared", Kid = "scared" },
		f = function(L, u, d, T, t) place(R.Kai, lerp(603, 605, seg(u, 0, 0.5)), -364, 90) place(R.Kid, kidX(t), -372, -90, "float", 0.2 * sin(T * 4)) struggle(R.Kid, T)
			if cut2(u, 0.55) then return pov(R.Kai, R.Kid, 30) end
			return faceCam(R.Kai, 4.8, 0.8, 0.3, 46) end },
	{ t = 34.76, line = "But I could run.", set = "sunny_beach", st = "climax", cam = "pushIn", face = { Kai = "determined", E2 = "shocked" },
		f = function(L, u) place(R.Kai, 605, -364, lerpA(90, yawTo(V(605, 0, -364), V(605, 0, -380)), seg(u, 0, 0.45)))
			place(R.E2, 608.5, -361.5, yawTo(V(608.5, 0, -361.5), V(605, 0, -364)))
			return faceCam(R.Kai, 5, -1.0, 0.3, 48) end },
	{ t = 35.80, line = "I sprinted down the pier", set = "sunny_beach", st = "climax", cam = "pushIn", face = { Kai = "determined", E5 = "shocked", E6 = "shocked" },
		f = function(L, u, d, T, t) local x = 606 - 26 * (t - 35.80) place(R.Kai, x, -380, 90) run(R.Kai)
			place(R.E6, 586, -377.2, yawTo(V(586, 0, -377.2), V(x, 0, -380)))
			return pierCam(-1e9, 9) end },
	{ t = 36.90, line = "and rang the shore bell.", set = "sunny_beach", st = "climax", cam = "pushIn", face = { Kai = "determined", E5 = "shocked" }, noSun = true,
		f = function(L, u, d, T, t) local k = clamp((t - 36.90) / 0.95, 0, 1)
			if k < 1 then local p = V(577.4, 0, -380):Lerp(V(552.4, 0, -378.2), k) place(R.Kai, p.X, p.Z, 90) run(R.Kai)
			else kaiAtRope() limb(R.Kai, "RS", 160, -6) limb(R.Kai, "LS", 160, -6) end
			-- sun is low toward -X (measured dir -0.94,0.31,0.11): film from the -Z side off the pier looking toward +Z/+X, so the sun is behind-left of camera; extras stay off the camera line
			place(R.E5, 556, -376.2, 180) place(R.E6, 559, -376.2, 180)
			F.raw = true
			local kp = pos(R.Kai)
			return shot(V(kp.X - 1.5, 16.5, -390), V(kp.X + 0.5, 10.4, -378.6), 48) end }, -- above the handrail (top y 11) so the camera guard never snaps it onto Kai
	{ t = 38.00, line = "(bell, no words)", set = "sunny_beach", st = "climax", cam = "snapZoom", vfx = {}, noSun = true,
		face = { Kai = "scared", E5 = "shocked", E6 = "shocked" },
		f = function(L, u, d, T, t) kaiAtRope() pullRope(R.Kai, T) place(R.E5, 554.2, -375.5, 90) place(R.E6, 557.5, -375, 90) ears(R.E5) ears(R.E6)
			F.shake = 0.2
			-- side-on across the pier from the -Z deck edge (sun is along X, out of frame); extras on the far side of Kai
			F.raw = true
			return shot(V(551.2, 10.6, -386.2), V(550.5, 13.6, -379.5), 55) end }, -- low angle up at the swinging bell + shockwave against the sky (looking +Z/up, sun at -X stays out of frame); glowing E5/E6 behind on the deck -- above the handrail (top y 11)
	{ t = 38.54, line = "Rosa turned.", set = "sunny_beach", st = "climax", cam = "pullOut", noSun = true, face = { Rosa = "shocked" },
		f = function(L, u) local y1 = yawTo(V(612, 0, -455), V(560, 0, -380))
			place(R.Rosa, 612, -455, y1)
			if u > 0.3 then limb(R.Rosa, "RS", 150, -20) end -- whistle to mouth
			local h, f = R.Rosa.head.Position, fwdOf(y1)
			local sd = V(-f.Z, 0, f.X) * 3.6
			local tg = h - V(0, 0.9, 0)
			return pull(u, h + f * 4.8 + sd + V(0, 0.3, 0), tg, h + f * 26 + sd * 3 + V(0, 8, 0), tg, 46, 54) end },
	{ t = 39.40, line = "I looked down.", set = "sunny_beach", st = "climax", cam = "pushIn", vfx = { "gold_ignite_pulse", "sparkle_burst" }, face = { Kai = "shocked" },
		f = function(L, u, d, T, t) local kp = V(552.4, 0, -379.2) place(R.E5, 563, -382, 90)
			place(R.Kai, kp.X, kp.Z, yawTo(kp, V(kidX(t), 0, -372))) limb(R.Kai, "RS", 80, -8) limb(R.Kai, "LS", 80, -8) head(R.Kai, 28, 0)
			return faceCam(R.Kai, 5, 3, 3.5, 48, 1.6) end },
	{ t = 40.40, line = "My hands were gold.", set = "sunny_beach", st = "climax", cam = "snapZoom", vfx = { "gold_outline_shimmer", "lens_flare" }, face = { Kai = "proud" },
		f = function(L, u, d, T, t) local kp = V(552.4, 0, -379.2) place(R.E5, 563, -382, 90)
			place(R.Kai, kp.X, kp.Z, yawTo(kp, V(kidX(t), 0, -372))) limb(R.Kai, "RS", 70, -8) limb(R.Kai, "LS", 70, -8) head(R.Kai, -15, 0)
			return faceCam(R.Kai, 6.2, -3.2, 0.7, 48, 1.4) end },
	{ t = 41.58, line = "She swam.", set = "sunny_beach", st = "climax", cam = "pushIn", vfx = { "splash", "gold_outline_bright_rosa" }, face = { Rosa = "determined" },
		f = function(L, u, d, T, t) local p = V(578, 0, -440):Lerp(V(576, 0, -424), u)
			place(R.Rosa, p.X, p.Z, yawTo(p, V(kidX(t), 0, -372)), "swim") swim(R.Rosa, T)
			local b = p - R.Rosa.fwd * 1.8
			F.splash = V(b.X, WATER, b.Z)
			return swimCam(R.Rosa) end },
	{ t = 42.50, line = "The kid was safe.", set = "sunny_beach", st = "finale", cam = "pushIn", face = { Kid = "grin", Rosa = "grin", E = "grin" },
		f = function(L, u, d, T)
			for _, n in { "E1", "E2", "E3", "E4" } do clap(R[n], T + #n) end
			local tg = V(608.6, 10.4, -365) return shot(V(596, 12.5, -358), tg, 36) end },
	{ t = 43.94, line = "Milo hugged me", set = "sunny_beach", st = "finale", cam = "pushIn", vfx = { "gold_outline_shimmer" }, face = { Milo = "grin", Kai = "grin" },
		f = function(L, u) local k = seg(u, 0, 0.6) place(R.Milo, lerp(611, 599.6, k), -380, 90)
			if k < 1 then run(R.Milo) else hug(R.Milo) hug(R.Kai) end
			return shot(V(617, 12.6, -381), V(601, 10.6, -380), 46) end },
	{ t = 44.46, line = "on the pier,", set = "sunny_beach", st = "finale", cam = "pushIn", vfx = { "gold_outline_shimmer" },
		f = function() hug(R.Milo) hug(R.Kai) head(R.Kai, 10, 0) head(R.Milo, -15, 0)
			return shot(V(613, 13.2, -383), V(599, 10.8, -380), 42) end },
	{ t = 45.40, line = "both of us glowing,", set = "sunny_beach", st = "finale", cam = "pullOut", vfx = { "gold_outline_shimmer" },
		f = function(L, u) hug(R.Milo) hug(R.Kai) place(R.Rosa, 632, -366, FIN_R) place(R.Kid, 634.2, -364.2, FIN_R + 180)
			return pull(u, V(613, 13.2, -383), V(599, 10.8, -380), V(613, 20, -362), V(598, 9.5, -380), 42, 54) end },
	{ t = 46.56, line = "the bell still swinging.", set = "sunny_beach", st = "finale", cam = "pullOut", vfx = { "gold_outline_shimmer" }, face = { Kai = "proud", Milo = "grin" },
		f = function(L, u) place(R.Kai, 557.5, -381.5, -90) place(R.Milo, 557.5, -378, -90) place(R.E5, 577, -378.5, 90) -- lit pair beside the bell (sound-off rule)
			return pull(u, V(570, 12.8, -380), V(552.5, 12.2, -380), V(614, 16, -368), V(580, 10, -380), 40, 52) end },
	{ t = 48.22, line = "Brave isn't not being scared.", set = "sunny_beach", st = "finale", cam = "pushIn", vfx = { "gold_outline_shimmer" }, face = { Kai = "proud", Milo = "grin" },
		f = function() place(R.Kai, 598, -380.8, 180) place(R.Milo, 600.3, -382.3, 180)
			return faceCam(R.Kai, 5, 0, 0.3, 46) end },
	{ t = 49.82, line = "It's being scared,", set = "sunny_beach", st = "finale", cam = "pushIn", vfx = { "gold_outline_shimmer" }, face = { Kai = "neutral", Milo = "proud" },
		f = function() place(R.Kai, 598, -380.8, 180) place(R.Milo, 600.3, -380.8, 180)
			head(R.Milo, -20, 25)
			return shot(V(599.2, 13.6, -374.4), V(599.2, 10.2, -380.8), 50) end },
	{ t = 50.54, line = "and doing it anyway.", set = "sunny_beach", st = "finale", cam = "pushIn", vfx = { "gold_outline_shimmer" },
		face = { Kai = "determined", Milo = "proud", E = "grin" },
		f = function() place(R.Kai, 598, -381.6, -90) place(R.Milo, 598, -378.4, -90)
			return shot(V(607.5, 13.7, -380), V(590, 10.2, -380), 50) end }, -- tighter: pair readable, bell swinging far behind; last image holds
}
for i, b in BEATS do
	b.n = i
	b.fx = {}
	for _, v in b.vfx or {} do b.fx[v] = true end
end

-- ================= grade presets (bloom <= 0.35 everywhere; storm/night lifted so faces read) =================
local GR = {
	sunny_beach = { clock = 16.8, bright = 2.4, exp = 0, amb = Color3.fromRGB(140, 130, 120), tint = Color3.fromRGB(255, 240, 222), sat = 0.12, con = 0.08, cb = 0.02,
		atD = 0.28, atH = 1.2, atC = Color3.fromRGB(205, 225, 245), bloom = 0.3, rays = 0.05 },
	stormy_beach = { clock = 15.0, bright = 1.0, exp = -0.1, amb = Color3.fromRGB(122, 130, 145), tint = Color3.fromRGB(190, 205, 228), sat = -0.35, con = 0.1, cb = 0.01,
		atD = 0.5, atH = 2.5, atC = Color3.fromRGB(135, 145, 160), bloom = 0.25, rays = 0, rain = true },
	-- night: hazy dark-blue atmosphere so the sky never reads as a pure-black band
	tower_night = { clock = 21.0, bright = 0.6, exp = 0.3, amb = Color3.fromRGB(80, 90, 128), tint = Color3.fromRGB(180, 198, 255), sat = -0.1, con = 0.08, cb = 0.01,
		atD = 0.42, atH = 2.2, atC = Color3.fromRGB(50, 66, 112), bloom = 0.3, rays = 0, lantern = true },
	flashback_beach = { clock = 16.8, bright = 2.0, exp = 0, amb = Color3.fromRGB(140, 125, 105), tint = Color3.fromRGB(255, 222, 175), sat = -0.65, con = 0.06, cb = 0,
		atD = 0.3, atH = 1.5, atC = Color3.fromRGB(220, 200, 170), bloom = 0.3, rays = 0.03 },
}
local LPROPS = { "ClockTime", "Brightness", "ExposureCompensation", "OutdoorAmbient" }
local function mix(a, b, k)
	local o = {}
	for key, v in b do
		local av = a[key]
		if type(v) == "number" and type(av) == "number" then o[key] = lerp(av, v, k)
		elseif typeof(v) == "Color3" and typeof(av) == "Color3" then o[key] = av:Lerp(v, k)
		else o[key] = v end
	end
	return o
end

-- ================= setup: cast, FX, lighting =================
local M = {}
local FX, LFX, BELL, BALL, CURG = {}, {}, nil, nil, nil
local inited = false

local function writeGrade(G, fl, pulse, lens, clock)
	fl, pulse = fl or 0, pulse or 0
	W(Lighting, "ClockTime", clock or G.clock)
	W(Lighting, "Brightness", G.bright)
	W(Lighting, "OutdoorAmbient", G.amb)
	W(Lighting, "ExposureCompensation", G.exp + 0.6 * fl)
	local g = LFX.grade
	if g then
		W(g, "Enabled", true) W(g, "TintColor", G.tint) W(g, "Saturation", G.sat) W(g, "Contrast", G.con)
		W(g, "Brightness", G.cb + 0.04 * fl)
	end
	if LFX.atmo then W(LFX.atmo, "Density", G.atD) W(LFX.atmo, "Haze", G.atH) W(LFX.atmo, "Color", G.atC) end
	W(LFX.bloom, "Intensity", math.min(0.35, G.bloom + 0.1 * math.max(fl, pulse)))
	W(LFX.rays, "Intensity", G.rays + (lens and 0.03 or 0))
end

local function part(name, size, color, mat, tr, shape)
	local p = Instance.new("Part")
	p.Name, p.Size, p.Color, p.Material, p.Transparency = name, size, color, mat or Enum.Material.SmoothPlastic, tr or 0
	if shape then p.Shape = shape end
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

function M.setup()
	local set = assert(WS:FindFirstChild("Set_Beach001"), "[Story001] Set_Beach001 missing")
	CAST = require(assert(SS:FindFirstChild("Cast001"), "[Story001] ServerStorage.Cast001 missing"))
	local folder = WS:FindFirstChild("Cast_001") or Instance.new("Folder")
	folder.Name, folder.Parent = "Cast_001", WS
	table.clear(R)
	CACHE = {}
	for i, n in NAMES do
		local r = register(folder:FindFirstChild(n) or CAST.build(n, 600, -300, -380, 0, folder)) -- build() applies the kid scales
		r.park = V(753 + (i % 3) * 3.5, 0, -394 + i * 2.6)
	end
	-- R6 walk/idle tracks for EVERY rig in NAMES (incl. ones that start off-stage, e.g. YoungRosa); stepped by animate()
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
		else warn("[Story001] " .. n .. " has no Humanoid: no animation tracks") end
	end
	local dl, ready = os.clock() + 5, false
	repeat
		ready = true
		for _, r in R do for _, tr in r.tr or {} do if tr.Length <= 0 then ready = false end end end
		if not ready then task.wait() end
	until ready or os.clock() > dl
	if not ready then warn("[Story001] some R6 animation tracks did not load in 5 s") end
	-- force full-detail meshes so hair/accessories never drop to an untextured LOD
	for _, r in R do
		for _, d in r.m:GetDescendants() do
			if d:IsA("MeshPart") then pcall(function() d.RenderFidelity = Enum.RenderFidelity.Precise end) end
		end
	end
	-- preload every cast texture + every face decal (faces swap at beat entries -> no mid-take texture loads)
	local pt0, list, seen = os.clock(), {}, {}
	for _, e in EMOS do
		for _, r in R do
			pcall(CAST.setFace, r.m, e)
			for _, d in r.m:GetDescendants() do
				if d:IsA("Decal") and d.Texture ~= "" and not seen[d.Texture] then seen[d.Texture] = true table.insert(list, d.Texture) end
			end
		end
	end
	for _, r in R do r.emo = nil setFace(r, "neutral") table.insert(list, r.m) end
	local pok, perr = pcall(function() game:GetService("ContentProvider"):PreloadAsync(list) end)
	print(("[Story001] PreloadAsync cast+faces (%d): %.2f s%s"):format(#list, os.clock() - pt0, pok and "" or (" (failed: " .. tostring(perr) .. ")")))
	-- ground ray ignores everything except terrain, sand/set geometry and the pier deck
	local props = set:FindFirstChild("Props")
	local ex = { folder }
	if props then for _, c in props:GetChildren() do if c.Name ~= "Pier" then table.insert(ex, c) end end end
	if set:FindFirstChild("Huts") then table.insert(ex, set.Huts) end
	-- engine FX
	local old = WS:FindFirstChild("Story001FX")
	if old then old:Destroy() end
	FX.folder = Instance.new("Folder") FX.folder.Name = "Story001FX" FX.folder.Parent = WS
	table.insert(ex, FX.folder)
	RP = RaycastParams.new() RP.FilterType = Enum.RaycastFilterType.Exclude RP.FilterDescendantsInstances = ex RP.IgnoreWater = true
	-- camera occlusion ray: everything solid in the set counts, except cast + engine FX
	RPC = RaycastParams.new() RPC.FilterType = Enum.RaycastFilterType.Exclude RPC.FilterDescendantsInstances = { folder, FX.folder } RPC.IgnoreWater = true
	local SOFT = "rbxasset://textures/particles/smoke_main.dds" -- soft puffs/streaks (the default sparkle read as stars)
	FX.rain = part("Rain", V(60, 1, 60), Color3.new(1, 1, 1), nil, 1)
	FX.rainE = emitter(FX.rain, { Texture = SOFT, EmissionDirection = Enum.NormalId.Bottom, Speed = NumberRange.new(70, 80), Lifetime = NumberRange.new(0.45, 0.6),
		Size = NumberSequence.new(0.07), Color = ColorSequence.new(Color3.fromRGB(190, 200, 215)), Transparency = NumberSequence.new(0.55),
		Orientation = Enum.ParticleOrientation.VelocityParallel })
	pcall(function() FX.rainE.Squash = NumberSequence.new(4) end)
	FX.splash = part("Splash", V(1.5, 0.2, 1.5), Color3.new(1, 1, 1), nil, 1)
	local spl = { Texture = SOFT, Speed = NumberRange.new(6, 10), SpreadAngle = Vector2.new(35, 35), Acceleration = V(0, -35, 0), Lifetime = NumberRange.new(0.35, 0.6),
		Size = NumberSequence.new(0.6, 0.25), Color = ColorSequence.new(Color3.fromRGB(225, 238, 248)), Transparency = NumberSequence.new(0.45, 1) }
	FX.splashE = emitter(FX.splash, spl)
	FX.stroke = part("StrokeSplash", V(0.6, 0.2, 0.6), Color3.new(1, 1, 1), nil, 1)
	FX.strokeE = emitter(FX.stroke, spl) -- one burst per swim hand entry (F.stroke)
	FX.foam = part("Foam", V(4, 0.2, 3), Color3.new(1, 1, 1), nil, 1)
	FX.foamE = emitter(FX.foam, { Texture = SOFT, EmissionDirection = Enum.NormalId.Left, Speed = NumberRange.new(4, 6), Lifetime = NumberRange.new(1.5, 2.2),
		Size = NumberSequence.new(0.8, 0.3), Color = ColorSequence.new(Color3.new(1, 1, 1)), Transparency = NumberSequence.new(0.3, 1) })
	FX.spark = part("Sparkle", V(1, 1, 1), Color3.new(1, 1, 1), nil, 1)
	FX.sparkE = emitter(FX.spark, { Texture = "rbxasset://textures/particles/sparkles_main.dds", Speed = NumberRange.new(4, 8), SpreadAngle = Vector2.new(180, 180),
		Drag = 3, Lifetime = NumberRange.new(0.5, 0.9), LightEmission = 1, LightInfluence = 0, Size = NumberSequence.new(0.3, 0),
		Color = ColorSequence.new(GOLD_HOT, GOLD), Transparency = NumberSequence.new(0, 1) })
	FX.ring = part("BellRing", V(0.15, 2, 2), GOLD_HOT, Enum.Material.Neon, 0.5, Enum.PartType.Cylinder)
	FX.lantern = part("Lantern", V(0.8, 1.2, 0.8), Color3.fromRGB(214, 150, 84), Enum.Material.SmoothPlastic)
	FX.lamp = Instance.new("PointLight") FX.lamp.Color, FX.lamp.Range, FX.lamp.Brightness, FX.lamp.Parent = Color3.fromRGB(255, 190, 110), 16, 1.2, FX.lantern
	-- bell + ball
	local sb = props and props:FindFirstChild("ShoreBell")
	if sb then
		HINGE = V(HINGE.X, sb:GetAttribute("HingeY") or HINGE.Y, HINGE.Z)
		local sw = sb:FindFirstChild("Swing")
		if sw then
			local p0 = sw:GetAttribute("S11Pivot")
			if not p0 then p0 = sw:GetPivot() sw:SetAttribute("S11Pivot", p0) end
			BELL = { m = sw, p0 = p0 }
		end
	end
	local bb = props and props:FindFirstChild("BeachBall")
	if bb then
		local p0 = bb:GetAttribute("S11Pivot")
		if not p0 then p0 = bb:GetPivot() bb:SetAttribute("S11Pivot", p0) end
		BALL = { m = bb, p0 = p0 }
	end
	-- lighting (originals saved once per Studio session in _G so a module re-run never snapshots a graded state)
	LFX.grade = Lighting:FindFirstChild("Grade") LFX.bloom = Lighting:FindFirstChild("Bloom")
	LFX.rays = Lighting:FindFirstChild("SunRays") LFX.dof = Lighting:FindFirstChild("DOF")
	M.S0 = (_G.Story001 and _G.Story001.S0) or nil
	if not M.S0 then
		local s = { L = {} }
		for _, k in LPROPS do s.L[k] = Lighting[k] end
		local g = LFX.grade
		if g then s.g = { g.TintColor, g.Saturation, g.Contrast, g.Brightness } end
		s.bloom = LFX.bloom and LFX.bloom.Intensity
		s.rays = LFX.rays and LFX.rays.Intensity
		local at = Lighting:FindFirstChildOfClass("Atmosphere")
		s.atmo = at and { at.Density, at.Haze, at.Color }
		M.S0 = s
	end
	LFX.atmo = Lighting:FindFirstChildOfClass("Atmosphere")
	if not LFX.atmo then LFX.atmo = Instance.new("Atmosphere") LFX.atmo.Name = "Atmo001" LFX.atmo.Parent = Lighting end
	inited = true
	for _, r in R do r.mk = nil park(r) end
	stage("beach")
	M.applyGrade("sunny_beach")
	print("[Story001] setup done: " .. #NAMES .. " cast (off-stage parked behind huts), FX built, sunny_beach grade")
	return true
end
local function init() if inited and R.Kai and R.Kai.m.Parent then return true end return M.setup() end

function M.applyGrade(name)
	local G = GR[name]
	if not G then return end
	CURG = G
	W(FX.rainE, "Rate", G.rain and 700 or 0)
	W(FX.lamp, "Enabled", G.lantern or false)
	local gy = G.lantern and groundY(613, -409.5) or nil
	W(FX.lantern, "CFrame", gy and CF(613, gy + 0.6, -409.5) or OFF)
	writeGrade(G)
end

-- ================= per-frame =================
local function enterBeat(i)
	local b = BEATS[i]
	stage(b.st)
	local G = GR[b.set]
	if G ~= CURG then
		-- ease into the storm over 0.4 s (no hard grade pop at 10.74)
		if b.set == "stormy_beach" and CURG then S.gb = { a = CURG, t0 = os.clock() } else S.gb = nil end
		M.applyGrade(b.set)
	end
	for k, e in b.face or {} do
		if k == "E" then for j = 1, 6 do setFace(R["E" .. j], e) end else setFace(R[k], e) end
	end
end

-- AnimationTracks write Motor6D.Transform; gestures write C0. On stage -> idle track, walk/run -> walk track scaled to ground speed.
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
		if v.Magnitude < 40 then r.v = (r.v or Vector3.zero):Lerp(v, 0.35) end -- ignore teleports (stage / mark jumps)
	end
	r.lp = p
	local want = r.loco and "walk" or "idle"
	if r.loco then
		local g = (r.v or Vector3.zero):Dot(r.fwd) -- signed: stepping backwards plays the cycle in reverse
		sp = abs(g) < 0.5 and (r.loco == "run" and 1.3 or 0.9) or abs(g) / 16 / r.s
		-- owner 2026-11-18: runs looked distorted at 1.9-2.2x (scissor legs, flung arms); classic R6 cycle reads best <= 1.4x
		sp = (r.loco == "run" and clamp(sp, 1.15, 1.4) or clamp(sp, 0.7, 1.1)) * (g < -0.5 and -1 or 1)
	end
	if r.cur ~= want then
		if r.cur then r.tr[r.cur]:Stop(0.15) end
		local tr = r.tr[want]
		tr:Play(0.15)
		if want == "idle" and tr.Length > 0 then tr.TimePosition = (r.ph * 0.73) % tr.Length end -- breathe out of sync
		r.cur, r.sp = want, nil
	end
	sp = sp or 1
	if r.sp ~= sp then r.sp = sp r.tr[want]:AdjustSpeed(sp) end
	r.anim:StepAnimations(dt)
	for k in r.off do if k ~= "RJ" and r.j[k] then r.j[k].m6.Transform = CFrame.identity end end -- gestured joints: procedural pose wins
end

local function step(i, t, T)
	local b = BEATS[i]
	local d = (BEATS[i + 1] and BEATS[i + 1].t or LEN) - b.t
	local L = t - b.t
	local u = clamp(L / d, 0, 1)
	S.frame += 1
	F = { shake = 0, shot = 1, u = u }
	for _, r in R do r.loco, r.idleOK = nil, nil if r.on then idle(r, T) end end
	local ok, ccf, fov, focus = pcall(b.f, L, u, d, T, t)
	if not ok then warn("[Story001] beat " .. i .. ": " .. tostring(ccf)) ccf = nil end
	local tremb = b.fx.hand_tremble
	for _, r in R do
		if r.on and (r.mode == "float" or r.mode == "swim") then
			-- water rigs keep bobbing even when the beat didn't move them; floaters always struggle (never plank arms)
			if r.pf ~= S.frame then place(r, r.x, r.z, r.yaw, r.mode) end
			if r.mode == "float" then
				if not r.off.RS then struggle(r, T) end
				limb(r, "RH", 10 * sin(T * 5)) limb(r, "LH", -10 * sin(T * 5))
			end
		end
		if tremb and r == R.Rosa then P(r, "RS", 0, 0, 2 * sin(T * 53)) end
		animate(r, S.dt or 0)
		applyJ(r)
	end
	-- bell: swing about the hinge (Z axis), ±25° decaying, still visibly swinging at the end
	if BELL then
		local e = t - BELL_T
		local a = e > 0 and 25 * math.exp(-e * 0.12) * sin(e * 4.2) or 0
		BELL.m:PivotTo(CF(HINGE) * CFrame.Angles(0, 0, rad(a)) * CF(-HINGE) * BELL.p0)
	end
	if BALL then
		local bc = F.ball and CF(F.ball) or BALL.p0
		if S.ballc ~= bc then S.ballc = bc BALL.m:PivotTo(bc) end
	end
	-- world rule: gold OUTLINE (never fill) on everyone on stage except Kai (until IGNITE_K) and YoungRosa (until IGNITE_Y)
	F.pulse = 0
	local shimmer, bright = b.fx.gold_outline_shimmer, b.fx.gold_outline_bright_rosa
	for n, r in R do
		local on = r.on
		if n == "Kai" then on = on and t >= IGNITE_K elseif n == "YoungRosa" then on = on and t >= IGNITE_Y end
		on = on and true or false
		W(r.hl, "Enabled", on)
		if on then
			local ig = (n == "Kai" and t - IGNITE_K) or (n == "YoungRosa" and t - IGNITE_Y) or nil
			local pulse = ig and ig < 0.8 and 1 - ig / 0.8 or 0
			local hot = n == "Rosa" and bright
			F.pulse = math.max(F.pulse, pulse)
			W(r.hl, "OutlineTransparency", (hot or pulse > 0) and 0 or (shimmer and 0.12 + 0.12 * sin(T * 7 + r.ph) or 0))
			W(r.hl, "OutlineColor", (hot or pulse > 0) and GOLD_HOT or GOLD)
		end
	end
	for n, x in { Kai = IGNITE_K, YoungRosa = IGNITE_Y } do -- one sparkle burst per ignite
		if S.lastT < x and t >= x and R[n] then FX.spark.CFrame = R[n].m:GetPivot() FX.sparkE:Emit(45) end
	end
	S.lastT = t
	return b, ccf, fov, focus
end

-- camera + per-frame light; b.cam: pushIn (slow push) / pullOut (no push; beat does the snap) / snapZoom (FOV snap + Dutch + shake)
local function finish(cam, b, ccf, fov, focus, shotE, T, t)
	local G = CURG
	if S.gb then
		local k = (os.clock() - S.gb.t0) / 0.4
		if k >= 1 then S.gb = nil else G = mix(S.gb.a, CURG, ease(k)) end
	end
	local clock = b.n >= 45 and lerp(16.8, 17.5, clamp((t - 46.56) / 5.5, 0, 1)) or nil -- sun lowers into the ending
	writeGrade(G, F.lightning or 0, F.pulse or 0, b.fx.lens_flare, clock)
	if b.noSun then W(LFX.rays, "Intensity", 0) W(LFX.bloom, "Intensity", math.min(0.25, G.bloom)) end
	-- hide the sun disc itself on noSun beats (bell sequence): camera aiming alone kept catching it
	local sky = Lighting:FindFirstChildOfClass("Sky")
	if sky then
		if not sky:GetAttribute("S11Sun") then sky:SetAttribute("S11Sun", sky.SunAngularSize) end
		W(sky, "SunAngularSize", b.noSun and 0 or sky:GetAttribute("S11Sun"))
	end
	if not ccf then return end
	fov = fov or 50
	-- smooth head-following targets (~8/s); snap on cuts; F.raw = deterministic tracking shot, no lag
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
	cam.CFrame = ccf * shake * (b.cam == "snapZoom" and DUTCH or CFrame.identity) * ROLL
	cam.FieldOfView = clamp(fov or 50, 20, 80)
	if LFX.dof and focus then
		-- light DOF only: faces never heavily blurred
		W(LFX.dof, "Enabled", true)
		LFX.dof.FocusDistance = (focus - ccf.Position).Magnitude
		W(LFX.dof, "InFocusRadius", 4) W(LFX.dof, "NearIntensity", 0.1) W(LFX.dof, "FarIntensity", 0.15)
	end
	-- FX that follow the camera / points
	local c = cam.CFrame
	if CURG.rain then FX.rain.CFrame = CF(c.Position + V(0, 16, 0)) end
	W(FX.splash, "CFrame", F.splash and CF(F.splash) or OFF) W(FX.splashE, "Rate", F.splash and 45 or 0)
	W(FX.foam, "CFrame", F.foam and CF(F.foam) or OFF) W(FX.foamE, "Rate", F.foam and 35 or 0)
	if F.stroke then FX.stroke.CFrame = CF(F.stroke) FX.strokeE:Emit(14) end
	local rk = F.ring
	if rk and rk >= 0 and rk <= 1 then
		local bp = HINGE - V(0, 2, 0)
		FX.ring.Size = V(0.15, 2 + 22 * rk, 2 + 22 * rk)
		FX.ring.CFrame = CFrame.lookAt(bp, c.Position) * CFrame.Angles(0, rad(90), 0) -- disc faces the camera
		FX.ring.Transparency = 0.5 + 0.5 * rk
		CACHE[FX.ring] = nil
	else W(FX.ring, "CFrame", OFF) end
end

-- ================= public =================
function M.play()
	if not init() then return end
	local cam = WS.CurrentCamera -- re-fetched every take (resetCamera swaps the camera)
	S = { lastT = -1, frame = 0 }
	CACHE = {}
	print(("[Story001] take: %d beats, %.1f s audio + %.1f lead + %.1f hold"):format(#BEATS, LEN, LEAD, TAIL))
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
	print(("[Story001] done in %.2fs (last image held, no fade)"):format(os.clock() - t0))
end

-- Run after EVERY take: swap in a fresh, free editor camera (roll 0, FOV 70) and clear the take's lighting/FX.
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
		if s.g and LFX.grade then LFX.grade.TintColor, LFX.grade.Saturation, LFX.grade.Contrast, LFX.grade.Brightness = table.unpack(s.g) end
		if s.bloom and LFX.bloom then LFX.bloom.Intensity = s.bloom end
		if s.rays and LFX.rays then LFX.rays.Intensity = s.rays end
		if LFX.atmo then
			if s.atmo then LFX.atmo.Density, LFX.atmo.Haze, LFX.atmo.Color = table.unpack(s.atmo)
			elseif LFX.atmo.Name == "Atmo001" then LFX.atmo:Destroy() LFX.atmo = nil inited = false end
		end
	end
	if FX.folder then
		FX.rainE.Rate, FX.splashE.Rate, FX.foamE.Rate, FX.lamp.Enabled = 0, 0, 0, false
		for _, p in FX.folder:GetChildren() do if p:IsA("BasePart") then p.CFrame = OFF end end
	end
	if BELL then BELL.m:PivotTo(BELL.p0) end
	if BALL then BALL.m:PivotTo(BALL.p0) end
	for _, r in R do -- stop tracks, flush Transform, joints back to rest (rigs stay visible where they are)
		if r.anim then for _, tr in r.tr do tr:Stop(0) end pcall(r.anim.StepAnimations, r.anim, 0) end
		for _, j in r.j do j.m6.Transform, j.m6.C0 = CFrame.identity, j.base end
		r.cur, r.lp, r.v, r.stk, r.roll, r.gy, r.gh, r.sp, r.mk = nil, nil, nil, nil, nil, nil, nil, nil, nil
	end
	CACHE = {}
	CURG = nil
	print("[Story001] camera reset: fresh camera, roll 0, FOV 70, lighting restored")
end

-- Pose the scene + camera at the START of beat n (no playback), then hand back a fresh camera holding that rolled view.
function M.preview(n)
	if not init() then return end
	n = clamp(n or 1, 1, #BEATS)
	local cam = WS.CurrentCamera
	S = { lastT = BEATS[n].t, frame = 0 } -- no sparkle bursts on preview
	CACHE = {}
	DT = 1
	enterBeat(n)
	S.gb = nil
	local t = BEATS[n].t + 0.02
	step(n, t, t + LEAD) -- twice: heads read last frame's joints
	local b, ccf, fov, focus = step(n, t, t + LEAD)
	finish(cam, b, ccf, fov, focus, 0.25, t + LEAD, t)
	local cf, fv = cam.CFrame, cam.FieldOfView
	local fresh = Instance.new("Camera") -- free camera (Custom) at the framed, rolled view
	fresh.FieldOfView, fresh.CFrame, fresh.Focus = fv, cf, cf * CF(0, 0, -20)
	fresh.Parent = WS
	WS.CurrentCamera = fresh
	for _, c in cam:GetChildren() do c.Parent = fresh end
	cam:Destroy()
	print(("[Story001] preview beat %d t=%.2f %s (%s, %s) - resetCamera() when done"):format(n, b.t, b.line, b.cam, b.set))
end

M.BEATS, M.R = BEATS, R
_G.Story001 = M
print("[Story001] loaded: _G.Story001.setup(); .preview(n); task.spawn(_G.Story001.play, 1); .resetCamera() after every take")
return M
