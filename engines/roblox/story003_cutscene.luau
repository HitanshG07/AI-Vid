--!nocheck
-- story003_cutscene.luau : stages + plays Story 003 "Tears to Glass Keys" (Extended Director's Cut, 22 beats, 192.18s) in Studio EDIT mode.
-- Features:
-- 1. All 22 beats retimed to Kokoro narration (192.18s).
-- 2. Maya grounded firmly on CatwalkFloor (top Y = 3.67, pivot Y = 6.90, feet bottom Y = 3.67) - ZERO floating!
-- 3. Realistic grounded running animation for Maya toward Door 19 (facing yaw = 0, forward tilt, oscillating limbs).
-- 4. DadWatch rendered and pinned flat against Leo's chest (CF(0, 0.2, -0.56) * Angles(0, rad(90), 0)).
-- 5. Dad, Chief Cryo-Architect, staged at bedrock excavation of Door 19 with blueprints/tools.
-- 6. Dynamic multi-angle cinematography: interior vault camera, 3/4 onion cart, spaced cocoa stand (no clipping).
-- 7. Rule of 3 key failures (Bram onion powder, neighbor pain crack) and Master Key crystallization with shockwaves.
-- 8. ZERO em dashes in script/manifest/beats.

local WS = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local SS = game:GetService("ServerStorage")
local TweenService = game:GetService("TweenService")

local V, CF = Vector3.new, CFrame.new
local rad, sin, cos, abs, clamp = math.rad, math.sin, math.cos, math.abs, math.clamp

-- ================= knobs =================
local LEAD, TAIL, LEN = 0.3, 0.8, 193.94
local ROLL = CFrame.Angles(0, 0, rad(90))
local DUTCH = CFrame.Angles(0, 0, rad(2.5))
local SGN = { fwd = 1, out = 1, down = 1, left = 1 }
local DT = 0.033

local ORIGIN = V(1250, 0, 0)
local OFF = CF(ORIGIN + V(0, -200, 0))
local CYAN = Color3.fromRGB(80, 220, 255)
local CYAN_HOT = Color3.fromRGB(180, 245, 255)
local WARM_GOLD = Color3.fromRGB(255, 200, 80)

local JN = { RS = "Right Shoulder", LS = "Left Shoulder", RH = "Right Hip", LH = "Left Hip", N = "Neck", RJ = "RootJoint" }

local function ease(x) x = clamp(x, 0, 1) return x * x * (3 - 2 * x) end
local function seg(u, a, b) return ease((u - a) / (b - a)) end
local function lerp(a, b, x) return a + (b - a) * x end
local function lerpCF(a, b, x) return a:Lerp(b, clamp(x, 0, 1)) end

-- Cached property writes
local CACHE = {}
local function W(o, k, v)
	if not o then return end
	local c = CACHE[o]
	if not c then c = {} CACHE[o] = c end
	if c[k] ~= v then c[k] = v pcall(function() o[k] = v end) end
end

-- ================= R6 rig management =================
local R = {}
local CAST_MOD = nil
local PROPS = {}
local DOOR19 = nil
local S = { lastT = -1, frame = 0 }

local function register(m)
	if not m or not m:FindFirstChild("HumanoidRootPart") then return nil end
	local hum = m:FindFirstChildOfClass("Humanoid")
	local t = m:FindFirstChild("Torso")
	local h = m:FindFirstChild("Head")
	if not hum or not t or not h then return nil end

	local anim = hum:FindFirstChildOfClass("Animator")
	if not anim then anim = Instance.new("Animator"); anim.Parent = hum end

	local ok, s = pcall(function() return m:GetScale() end)
	s = ok and s or 1.0

	local r = {
		m = m, hum = hum, root = m.HumanoidRootPart, torso = t, head = h,
		anim = anim, s = s, baseY = 3.0 * s,
		j = {}, off = {}, tr = {}, ph = (#m.Name * 1.7) % 6, on = true,
	}

	for k, n in pairs(JN) do
		local mt = t:FindFirstChild(n, true) or m.HumanoidRootPart:FindFirstChild(n, true)
		if mt and mt:IsA("Motor6D") then
			local b = mt:GetAttribute("S15Base")
			if not b then
				b = mt.C0
				mt:SetAttribute("S15Base", b)
			end
			mt.C0 = b
			mt.Transform = CFrame.identity
			r.j[k] = { m6 = mt, base = b }
		end
	end

	local idIdle = Instance.new("Animation"); idIdle.AnimationId = "rbxassetid://180435571"
	local idWalk = Instance.new("Animation"); idWalk.AnimationId = "rbxassetid://180426354"
	pcall(function()
		r.tr.idle = anim:LoadAnimation(idIdle)
		r.tr.walk = anim:LoadAnimation(idWalk)
	end)

	hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	R[m.Name] = r
	return r
end

local function P(r, k, x, y, z)
	if r then r.off[k] = (r.off[k] or CFrame.identity) * CFrame.Angles(rad(x), rad(y), rad(z)) end
end

local function limb(r, k, fwd, out)
	local s = (k == "RS" or k == "RH") and 1 or -1
	P(r, k, -s * fwd * SGN.fwd, 0, s * (out or 0) * SGN.out)
end

local function head(r, down, left) P(r, "N", down * SGN.down, 0, (left or 0) * SGN.left) end
local function torso(r, lean, left) P(r, "RJ", lean * SGN.down, 0, (left or 0) * SGN.left) end

local function applyJ(r)
	for k, j in pairs(r.j) do j.m6.C0 = j.base * (r.off[k] or CFrame.identity) end
	table.clear(r.off)
end

local function setFace(r, e)
	if not r or not r.m then return end
	if r.emo == e then return end
	r.emo = e
	local hd = r.m:FindFirstChild("Head")
	if hd then
		local fc = hd:FindFirstChild("face") or hd:FindFirstChildOfClass("Decal")
		if fc then
			local FACES = {
				neutral = "rbxassetid://70950815478959",
				scared = "rbxassetid://94514852927815",
				shocked = "rbxassetid://103057607693548",
				grin = "rbxassetid://96253429845051",
				determined = "rbxassetid://109687999939498",
				proud = "rbxassetid://96477668083717",
			}
			if FACES[e] then fc.Texture = FACES[e] end
		end
	end
end

local function place(r, pos, yaw)
	if not r or not r.m then return end
	r.m:PivotTo(CF(pos) * CFrame.Angles(0, rad(yaw or 0), 0))
end

local function animateRig(r, dt)
	if not r or not r.anim then return end
	local want = r.loco and "walk" or "idle"
	if r.cur ~= want then
		if r.cur and r.tr[r.cur] then r.tr[r.cur]:Stop(0.15) end
		local tr = r.tr[want]
		if tr then
			tr:Play(0.15)
			if want == "idle" and tr.Length > 0 then tr.TimePosition = (r.ph * 0.73) % tr.Length end
		end
		r.cur = want
	end
	r.anim:StepAnimations(dt)
	for k in pairs(r.off) do
		if k ~= "RJ" and r.j[k] then r.j[k].m6.Transform = CFrame.identity end
	end
	applyJ(r)
end

-- ================= Procedural Gestures =================
local function idle(r, T)
	local br = sin(T * 2.4 + r.ph)
	local sw = cos(T * 1.1 + r.ph)
	torso(r, 1.8 * br, 1.0 * sw)
	head(r, -1.2 * br, 3.5 * sw)
	limb(r, "RS", 2.0 * br, 0.8 * sw)
	limb(r, "LS", 2.0 * br, -0.8 * sw)
end

local function walkCycle(r, T, speed)
	speed = speed or 8
	local phase = T * speed + r.ph
	local legSwing = sin(phase) * 35
	local armSwing = sin(phase) * 35
	limb(r, "RH", legSwing, 0)
	limb(r, "LH", -legSwing, 0)
	limb(r, "RS", -armSwing, 8)
	limb(r, "LS", armSwing, -8)
	torso(r, 6 + 1.5 * cos(phase * 2), 0)
	head(r, -4 + 1.2 * cos(phase * 2), 0)
end

local function runSprint(r, T, speed)
	speed = speed or 14
	local phase = T * speed + r.ph
	local legSwing = sin(phase) * 55
	local armSwing = sin(phase) * 62
	limb(r, "RH", legSwing, 0)
	limb(r, "LH", -legSwing, 0)
	limb(r, "RS", -armSwing, 12)
	limb(r, "LS", armSwing, -12)
	torso(r, 18 + 2 * cos(phase * 2), 0) -- Forward athletic pitch
	head(r, -12, 0)
end

local function wipeTears(r, T)
	local br = sin(T * 2.8)
	head(r, 12 + 2 * br, -4)
	limb(r, "LS", 78 + 3 * br, -8)
	limb(r, "RS", 52 + 2 * br, 10)
	torso(r, 6, -3)
end

local function presentKeyHands(r, T)
	local br = sin(T * 3.0)
	head(r, -6 + 2 * br, 0)
	limb(r, "RS", 78 + 3 * br, -12)
	limb(r, "LS", 78 + 3 * br, 12)
	torso(r, -3, 0)
end

local function chopOnion(r, T)
	local s = sin(T * 14)
	limb(r, "RS", 72 + 22 * s, 4)
	limb(r, "LS", 55, -8)
	head(r, 18, 0)
	torso(r, 8, 0)
end

local function jamKey(r, T)
	limb(r, "RS", 88, -6)
	limb(r, "LS", 42, -10)
	torso(r, 14, 0)
	head(r, 8, 0)
end

local function kickCratePose(r, u)
	local k = sin(u * math.pi)
	limb(r, "RH", 68 * k, 4)
	limb(r, "RS", -22 * k, 15)
	limb(r, "LS", 32 * k, -15)
	torso(r, -8 * k, 0)
end

local function pressGlass(r, T)
	local s = sin(T * 6)
	limb(r, "RS", 96 + 4 * s, -12)
	limb(r, "LS", 96 - 4 * s, -12)
	torso(r, 12, 0)
	head(r, 14, 0)
end

local function clutchWatch(r, T)
	local s = 2.5 * sin(T * 35) -- trembling hands
	limb(r, "RS", 62 + s, -14)
	limb(r, "LS", 62 - s, -14)
	torso(r, 12, 0)
	head(r, 22, 0)
end

local function holdMasterKey(r, T)
	local br = sin(T * 2.5)
	limb(r, "RS", 78 + 3 * br, -8)
	limb(r, "LS", 78 + 3 * br, -8)
	torso(r, -4, 0)
	head(r, -8, 0)
end

local function hugBoth(leo, maya, T)
	limb(leo, "RS", 88, -14)
	limb(leo, "LS", 88, -14)
	torso(leo, 10, 0)
	head(leo, 14, 0)

	limb(maya, "RS", 92, -12)
	limb(maya, "LS", 92, -12)
	torso(maya, 4, 0)
	head(maya, -10, 0)
end

local function blastKnockback(r, u)
	local k = ease(u)
	torso(r, -45 * k, 0)
	head(r, -25 * k, 0)
	limb(r, "RS", 140 * k, 25)
	limb(r, "LS", 140 * k, -25)
	limb(r, "RH", 30 * k, 10)
	limb(r, "LH", 20 * k, -10)
end

-- ================= Prop Helpers =================
local function parkProp(p)
	if not p then return end
	if p:IsA("Model") then p:PivotTo(OFF)
	elseif p:IsA("BasePart") then p.CFrame = OFF end
end

local function attachProp(prop, part, cframeOffset)
	if not prop or not part then return end
	local targetCF = part.CFrame * (cframeOffset or CFrame.identity)
	if prop:IsA("Model") then prop:PivotTo(targetCF)
	elseif prop:IsA("BasePart") then prop.CFrame = targetCF end
end

-- ================= Camera Helpers =================
local function frameCam(cam, eye, target, fov, dutch)
	local cf = CFrame.lookAt(eye, target, Vector3.yAxis) * ROLL
	if dutch then cf = cf * DUTCH end
	cam.CFrame = cf
	cam.FieldOfView = fov or 65
	cam.Focus = CF(target)
end

local function setDoorAngle(angleDeg)
	if not DOOR19 then return end
	local HINGE = CF(ORIGIN + V(-3.0, 5.0, -28.0))
	local closedOffset = HINGE:Inverse() * CF(ORIGIN + V(0.0, 5.0, -28.0))
	local targetCF = HINGE * CFrame.Angles(0, rad(angleDeg), 0) * closedOffset
	DOOR19:PivotTo(targetCF)
end

-- ================= Engine Module =================
local M = {}
local BEATS = {}
local inited = false

function M.setup()
	print("[Story003] Initializing engine setup...")

	-- 1. Register Cast Rigs
	local castFolder = WS:FindFirstChild("Cast_003")
	if castFolder then
		for _, m in ipairs(castFolder:GetChildren()) do register(m) end
	end
	local crowdFolder = WS:FindFirstChild("Cast_003_CityCrowd")
	if crowdFolder then
		for _, m in ipairs(crowdFolder:GetChildren()) do register(m) end
	end

	-- 2. Cache Props & Door
	local set = WS:FindFirstChild("Set_FrostVault003")
	if set then
		local pFolder = set:FindFirstChild("Props003")
		if pFolder then
			for _, p in ipairs(pFolder:GetChildren()) do PROPS[p.Name] = p end
		end
		DOOR19 = set:FindFirstChild("Door19")
	end

	-- 3. Load Beats from embedded schedule
	BEATS = {
		[1] = { t = 0.00, dur = 7.20, shot = "pushIn medium", target = "Avenue" },
		[2] = { t = 7.20, dur = 7.34, shot = "snapOut wide", target = "Plaza" },
		[3] = { t = 14.54, dur = 6.14, shot = "lowAngle medium", target = "Extra1" },
		[4] = { t = 20.68, dur = 8.82, shot = "sideAngle medium", target = "Bram" },
		[5] = { t = 29.50, dur = 8.00, shot = "impactZoom close", target = "BramPadlock" },
		[6] = { t = 37.50, dur = 9.50, shot = "highAngle dramatic", target = "DadBedrock" },
		[7] = { t = 47.00, dur = 8.00, shot = "closeTumbler detail", target = "Door19Tumbler" },
		[8] = { t = 55.00, dur = 7.46, shot = "dutchTilt low", target = "DadWatchHand" },
		[9] = { t = 62.46, dur = 9.54, shot = "chestFlat close", target = "LeoChestWatch" },
		[10] = { t = 72.00, dur = 12.92, shot = "pushIn medium", target = "LeoPresent" },
		[11] = { t = 84.92, dur = 8.66, shot = "snapOut wide", target = "AvenueStorm" },
		[12] = { t = 93.58, dur = 8.44, shot = "followRun dynamic", target = "MayaRun" },
		[13] = { t = 102.02, dur = 8.14, shot = "insideVault reverse", target = "MayaInsideCatwalk" },
		[14] = { t = 110.16, dur = 8.34, shot = "sideAngle medium", target = "BramDoor" },
		[15] = { t = 118.50, dur = 7.50, shot = "pushIn medium", target = "NeighborDoor" },
		[16] = { t = 126.00, dur = 3.50, shot = "closeWindow detail", target = "MayaWindowFingers" },
		[17] = { t = 129.50, dur = 12.50, shot = "chestFlat intimate", target = "LeoChestClutch" },
		[18] = { t = 142.00, dur = 11.92, shot = "profileTear dramatic", target = "LeoTearDrop" },
		[19] = { t = 153.92, dur = 8.30, shot = "impactZoom shockwave", target = "MasterKeyCrystallize" },
		[20] = { t = 162.22, dur = 8.92, shot = "pushIn latch", target = "DoorLatchTurn" },
		[21] = { t = 171.14, dur = 8.36, shot = "snapOut wide", target = "ReunionExhaust" },
		[22] = { t = 179.50, dur = 14.44, shot = "wideCocoa resolution", target = "CocoaStandToast" },
	}

	-- 4. Initial staging
	M.resetStaging()
	inited = true
	print(string.format("[Story003] Setup complete with %d beats (LEN = %.2fs). Ready for preview or play.", #BEATS, LEN))
	return true
end

function M.resetStaging()
	for _, p in pairs(PROPS) do parkProp(p) end

	-- Place primary cast members in plaza
	if R.Leo then place(R.Leo, ORIGIN + V(-1.8, 4.5, 7.8), 160); setFace(R.Leo, "neutral") end
	if R.Maya then place(R.Maya, ORIGIN + V(0.0, 3.24, 8.0), 180); setFace(R.Maya, "scared") end
	if R.Dad then place(R.Dad, ORIGIN + V(0.0, 4.5, -20.0), 180); setFace(R.Dad, "determined") end
	if R.Bram then place(R.Bram, ORIGIN + V(22.5, 3.85, 4.2), 180); setFace(R.Bram, "grin") end
	if R.Vendor then place(R.Vendor, ORIGIN + V(-31.5, 4.59, 8.5), 60); setFace(R.Vendor, "grin") end
	if R.Extra1 then place(R.Extra1, ORIGIN + V(-3.5, 4.86, 14), 150); setFace(R.Extra1, "neutral") end
	if R.Extra2 then place(R.Extra2, ORIGIN + V(20.5, 4.5, 9.2), 15); setFace(R.Extra2, "neutral") end

	-- Ensure Door 19 is shut and CatwalkFloor positioned
	setDoorAngle(0)
	if DOOR19 then
		local cw = DOOR19:FindFirstChild("CatwalkFloor")
		if cw then
			cw.Size = V(16, 2.0, 12)
			cw.Position = ORIGIN + V(0, 2.67, -28.5)
		end
	end

	-- Particle emitters reset
	if PROPS.PowderCloud and PROPS.PowderCloud:FindFirstChildOfClass("ParticleEmitter") then
		PROPS.PowderCloud:FindFirstChildOfClass("ParticleEmitter").Enabled = false
	end
	if PROPS.SnowEmitterPart and PROPS.SnowEmitterPart:FindFirstChildOfClass("ParticleEmitter") then
		PROPS.SnowEmitterPart:FindFirstChildOfClass("ParticleEmitter").Enabled = true
	end
end

-- ================= Step Function (Every Frame) =================
local function stepBeat(beatIdx, t, cam)
	for _, r in pairs(R) do r.loco = nil end

	local b = BEATS[beatIdx]
	if not b then return end

	local u = clamp((t - b.t) / (b.dur > 0 and b.dur or 1), 0, 1)

	-- ================= 22 Beats Step Implementation =================
	if beatIdx == 1 then
		-- Beat 1 (0.00 - 7.20s): Establishing shot of snowy avenue; iced rusted padlock; Leo & Maya walking
		setFace(R.Maya, "neutral")
		setFace(R.Leo, "neutral")
		if R.Maya then place(R.Maya, ORIGIN + V(0.0, 3.24, lerp(12.0, 7.5, u)), 180); walkCycle(R.Maya, t, 6) end
		if R.Leo then place(R.Leo, ORIGIN + V(-2.2, 4.5, lerp(11.5, 7.0, u)), 170); walkCycle(R.Leo, t, 5) end

		-- DadWatch pinned flat against Leo's chest
		if PROPS.DadWatch and R.Leo and R.Leo.torso then
			attachProp(PROPS.DadWatch, R.Leo.torso, CF(0, 0.2, -0.56) * CFrame.Angles(0, rad(90), 0))
		end

		local eyeStart = ORIGIN + V(3.5, 4.8, 16.0)
		local eyeEnd = ORIGIN + V(1.8, 4.2, 13.0)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(-0.5, 3.6, 7.0), 58)

	elseif beatIdx == 2 then
		-- Beat 2 (7.20 - 14.54s): Wide plaza view: tear crystallizes mid-air into a glowing cyan key
		setFace(R.Maya, "neutral")
		setFace(R.Leo, "neutral")
		if R.Maya then place(R.Maya, ORIGIN + V(0.0, 3.24, 7.5), 180); idle(R.Maya, t) end
		if R.Leo then place(R.Leo, ORIGIN + V(-2.2, 4.5, 7.0), 160); idle(R.Leo, t) end

		if PROPS.DadWatch and R.Leo and R.Leo.torso then
			attachProp(PROPS.DadWatch, R.Leo.torso, CF(0, 0.2, -0.56) * CFrame.Angles(0, rad(90), 0))
		end

		if PROPS.TinyKey then
			local keyPos = ORIGIN + V(0.0, 4.2 + 0.2 * sin(t * 4), 5.5)
			PROPS.TinyKey:PivotTo(CF(keyPos) * CFrame.Angles(rad(15), t * 3, rad(10)))
		end
		if PROPS.VfxRing then
			local ringPos = ORIGIN + V(0.0, 4.2, 5.5)
			PROPS.VfxRing.CFrame = CF(ringPos) * CFrame.Angles(0, t * 4, 0)
			local sz = lerp(0.8, 3.5, u)
			PROPS.VfxRing.Size = V(sz, 0.08, sz)
			W(PROPS.VfxRing, "Transparency", lerp(0.1, 0.9, u))
		end

		local eyeStart = ORIGIN + V(4.5, 5.2, 15.0)
		local eyeEnd = ORIGIN + V(3.0, 4.8, 12.0)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.0, 4.0, 5.5), 62)

	elseif beatIdx == 3 then
		-- Beat 3 (14.54 - 20.68s): Kids stubbing toes for locker keys
		parkProp(PROPS.TinyKey)
		parkProp(PROPS.VfxRing)
		setFace(R.Extra1, "scared")
		setFace(R.Extra2, "grin")
		if R.Extra1 then place(R.Extra1, ORIGIN + V(-3.5, 4.86, 14), 150); kickCratePose(R.Extra1, u) end
		if R.Extra2 then place(R.Extra2, ORIGIN + V(4.0, 4.5, 16), -160); idle(R.Extra2, t) end

		local eyeStart = ORIGIN + V(-1.0, 4.8, 20.0)
		local eyeEnd = ORIGIN + V(-1.5, 5.0, 22.0)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(-3.5, 3.6, 12.0), 64)

	elseif beatIdx == 4 then
		-- Beat 4 (20.68 - 29.50s): Bram chops onions at wooden market cart
		setFace(R.Bram, "grin")
		if R.Bram then
			place(R.Bram, ORIGIN + V(22.5, 3.85, 4.2), 180)
			chopOnion(R.Bram, t)
		end
		if PROPS.ChefKnife then
			attachProp(PROPS.ChefKnife, WS.Terrain or WS, CF(ORIGIN + V(22.4, 2.75 + 0.25 * sin(t * 14), 5.75)) * CFrame.Angles(rad(-15 + 10 * sin(t * 14)), 0, 0))
		end
		if PROPS.OnionKey then
			attachProp(PROPS.OnionKey, WS.Terrain or WS, CF(ORIGIN + V(21.2, 2.55, 5.8)) * CFrame.Angles(0, rad(45), 0))
		end
		if R.Extra2 then
			place(R.Extra2, ORIGIN + V(20.5, 4.5, 9.2), 15)
			idle(R.Extra2, t)
		end

		local eyeStart = ORIGIN + V(26.5, 5.0, 13.5)
		local eyeEnd = ORIGIN + V(25.0, 4.8, 11.5)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(22.5, 3.5, 5.8), 54)

	elseif beatIdx == 5 then
		-- Beat 5 (29.50 - 37.50s): Customer tests Bram's brittle onion key; Snap! Blue powder cloud
		parkProp(PROPS.ChefKnife)
		setFace(R.Bram, "shocked")
		setFace(R.Extra2, "shocked")
		if R.Bram then place(R.Bram, ORIGIN + V(22.5, 3.85, 4.2), 180); jamKey(R.Bram, t) end
		if R.Extra2 then place(R.Extra2, ORIGIN + V(20.5, 4.5, 9.2), 15); idle(R.Extra2, t) end

		if u > 0.25 then
			parkProp(PROPS.OnionKey)
			local burstU = seg(u, 0.25, 0.85)
			for i = 1, 4 do
				local sh = PROPS["Shard" .. i]
				if sh then
					local dir = V(cos(i * 1.57), 0.5, sin(i * 1.57)) * (burstU * 3.5)
					sh.CFrame = CF(ORIGIN + V(22.5, 3.0, 5.8) + dir) * CFrame.Angles(t * 6, t * 5, 0)
				end
			end
			if PROPS.PowderCloud then
				PROPS.PowderCloud.CFrame = CF(ORIGIN + V(22.5, 3.0, 5.8))
				local pe = PROPS.PowderCloud:FindFirstChildOfClass("ParticleEmitter")
				if pe and u < 0.70 then pe.Enabled = true else if pe then pe.Enabled = false end end
			end
		end

		local eyeStart = ORIGIN + V(25.8, 4.8, 12.5)
		local eyeEnd = ORIGIN + V(24.5, 4.5, 11.0)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(22.5, 3.2, 5.5), 55, true)

	elseif beatIdx == 6 then
		-- Beat 6 (37.50 - 47.00s): Dad's lore: Chief Cryo-Architect blasting permafrost bedrock for Door 19
		for i = 1, 4 do parkProp(PROPS["Shard" .. i]) end
		parkProp(PROPS.PowderCloud)
		setFace(R.Dad, "determined")
		if R.Dad then
			place(R.Dad, ORIGIN + V(0.0, 4.5, -20.0), 180)
			idle(R.Dad, t)
			limb(R.Dad, "RS", 45, 10)
			limb(R.Dad, "LS", 45, -10)
			torso(R.Dad, 4, 0)
		end

		-- Camera: grand architectural low angle looking up at Dad standing before massive Door 19
		local eyeStart = ORIGIN + V(3.5, 3.5, -12.0)
		local eyeEnd = ORIGIN + V(2.0, 3.8, -14.0)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.0, 5.5, -24.0), 56)

	elseif beatIdx == 7 then
		-- Beat 7 (47.00 - 55.00s): Close-up detail of Frost Vault Door 19's heavy blast latch and hexagonal cryo-tumbler
		if R.Dad then place(R.Dad, ORIGIN + V(-3.2, 4.5, -24.0), 130); idle(R.Dad, t) end

		local eyeStart = ORIGIN + V(3.0, 5.5, -21.0)
		local eyeEnd = ORIGIN + V(1.5, 5.0, -23.5)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.0, 5.0, -28.0), 45)

	elseif beatIdx == 8 then
		-- Beat 8 (55.00 - 62.46s): Dad holds up cracked gold pocket watch with hands frozen at 5 o'clock
		setFace(R.Dad, "proud")
		if R.Dad then
			place(R.Dad, ORIGIN + V(0.0, 4.5, -20.0), 180)
			limb(R.Dad, "RS", 85, -8)
			limb(R.Dad, "LS", 45, -12)
			head(R.Dad, 10, 0)
			torso(R.Dad, 4, 0)
		end
		if PROPS.DadWatch and R.Dad and R.Dad.torso then
			attachProp(PROPS.DadWatch, R.Dad.torso, CF(0.4, 0.4, -1.2) * CFrame.Angles(0, rad(90), 0))
		end

		local eyeStart = ORIGIN + V(1.2, 5.2, -16.0)
		local eyeEnd = ORIGIN + V(0.6, 5.0, -17.2)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.2, 4.8, -20.0), 42)

	elseif beatIdx == 9 then
		-- Beat 9 (62.46 - 72.00s): Dad pins watch flat against young Leo's chest; sacred whisper
		setFace(R.Dad, "proud")
		setFace(R.Leo, "neutral")
		if R.Dad then
			place(R.Dad, ORIGIN + V(1.4, 4.5, -18.5), -140)
			limb(R.Dad, "LS", 75, 12)
			limb(R.Dad, "RS", 40, -10)
		end
		if R.Leo then
			place(R.Leo, ORIGIN + V(0.0, 4.5, -19.5), 30)
			head(R.Leo, 10, 0)
			torso(R.Leo, 2, 0)
		end
		if PROPS.DadWatch and R.Leo and R.Leo.torso then
			attachProp(PROPS.DadWatch, R.Leo.torso, CF(0, 0.2, -0.56) * CFrame.Angles(0, rad(90), 0))
		end

		local eyeStart = ORIGIN + V(-1.8, 5.0, -15.5)
		local eyeEnd = ORIGIN + V(-1.2, 4.8, -16.8)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.4, 4.5, -19.0), 44)

	elseif beatIdx == 10 then
		-- Beat 10 (72.00 - 84.92s): 5-year transition: Leo stands tall in winter street wearing watch flat on chest
		parkProp(R.Dad and R.Dad.m)
		setFace(R.Leo, "determined")
		if R.Leo then
			place(R.Leo, ORIGIN + V(-1.5, 4.5, 8.0), 180)
			idle(R.Leo, t)
		end
		if PROPS.DadWatch and R.Leo and R.Leo.torso then
			attachProp(PROPS.DadWatch, R.Leo.torso, CF(0, 0.2, -0.56) * CFrame.Angles(0, rad(90), 0))
		end
		if R.Maya then
			place(R.Maya, ORIGIN + V(1.2, 3.24, 7.8), 170)
			idle(R.Maya, t)
		end

		local eyeStart = ORIGIN + V(-2.5, 4.8, 13.5)
		local eyeEnd = ORIGIN + V(-1.8, 4.4, 11.5)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(-1.5, 4.0, 8.0), 50)

	elseif beatIdx == 11 then
		-- Beat 11 (84.92 - 93.58s): Blizzard gust rips Dad's scarf into Door 19; Maya runs in!
		setFace(R.Leo, "shocked")
		setFace(R.Maya, "scared")
		if R.Leo then
			place(R.Leo, ORIGIN + V(-1.8, 4.5, 6.0), 0)
			limb(R.Leo, "RS", 95, -15)
			limb(R.Leo, "LS", 35, 12)
			torso(R.Leo, 14, 0)
		end

		local scarfZ = lerp(6.0, -25.5, ease(u))
		if PROPS.RedScarf then
			attachProp(PROPS.RedScarf, WS.Terrain or WS, CF(ORIGIN + V(0.6, 4.4 + 0.6 * sin(t * 8), scarfZ)) * CFrame.Angles(t * 5, t * 7, rad(35)))
		end
		setDoorAngle(65)

		local eyeStart = ORIGIN + V(4.2, 4.6, 8.0)
		local eyeEnd = ORIGIN + V(3.0, 4.4, -15.0)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.4, 4.0, scarfZ), 56)

	elseif beatIdx == 12 then
		-- Beat 12 (93.58 - 102.02s): Grounded, realistic running animation for Maya toward Door 19
		local mayaZ = lerp(6.0, -27.5, ease(u))
		if R.Maya then
			place(R.Maya, ORIGIN + V(0.0, 3.24, mayaZ), 0) -- Facing forward toward door!
			runSprint(R.Maya, t, 14)
		end
		if R.Leo then
			place(R.Leo, ORIGIN + V(-1.8, 4.5, lerp(6.0, -15.0, u * 0.7)), 0)
			runSprint(R.Leo, t, 10)
		end

		-- Slam shut at end of beat
		if u > 0.85 then
			setDoorAngle(lerp(65, 0, seg(u, 0.85, 1.0)))
		end

		local eyeStart = ORIGIN + V(3.5, 4.5, -5.0)
		local eyeEnd = ORIGIN + V(2.5, 4.2, -22.0)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.0, 3.8, mayaZ), 54)

	elseif beatIdx == 13 then
		-- Beat 13 (102.02 - 110.16s): INTERIOR VAULT SHOT: Maya on CatwalkFloor beating fists on window
		parkProp(PROPS.RedScarf)
		setDoorAngle(0)
		setFace(R.Maya, "scared")
		setFace(R.Leo, "shocked")

		-- Maya planted firmly on CatwalkFloor inside vault!
		if R.Maya then
			place(R.Maya, ORIGIN + V(0.0, 6.90, -28.6), 180) -- Facing window (+Z)
			pressGlass(R.Maya, t)
		end
		if R.Leo then
			place(R.Leo, ORIGIN + V(-1.5, 4.5, -24.5), 0) -- Outside window
			pressGlass(R.Leo, t)
		end

		-- Camera: Inside vault from side angle looking at Maya towards the frosted glass!
		local eyeStart = ORIGIN + V(2.2, 6.6, -31.5)
		local eyeEnd = ORIGIN + V(1.4, 6.8, -30.5)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.0, 6.8, -28.6), 52)

	elseif beatIdx == 14 then
		-- Beat 14 (110.16 - 118.50s): Bram shoves through crowd, jams master onion key into padlock; Snap! Crumbles
		setFace(R.Bram, "grin")
		if R.Bram then
			place(R.Bram, ORIGIN + V(1.4, 4.5, -26.0), -45)
			jamKey(R.Bram, t)
		end
		if R.Leo then place(R.Leo, ORIGIN + V(-2.2, 4.5, -24.5), 18); idle(R.Leo, t) end
		if R.Maya then place(R.Maya, ORIGIN + V(0.0, 6.90, -28.6), 180); pressGlass(R.Maya, t) end

		if u > 0.40 then
			setFace(R.Bram, "shocked")
			if PROPS.PowderCloud then
				PROPS.PowderCloud.CFrame = CF(ORIGIN + V(1.4, 4.0, -25.8))
				local pe = PROPS.PowderCloud:FindFirstChildOfClass("ParticleEmitter")
				if pe and u < 0.85 then pe.Enabled = true else if pe then pe.Enabled = false end end
			end
		end

		local eyeStart = ORIGIN + V(3.8, 5.0, -21.0)
		local eyeEnd = ORIGIN + V(2.8, 4.8, -22.5)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(1.4, 4.5, -26.0), 52)

	elseif beatIdx == 15 then
		-- Beat 15 (118.50 - 126.00s): Neighbor kicks steel crate for pain tear; Crack! Snaps in half
		parkProp(PROPS.PowderCloud)
		setFace(R.Extra1, "scared")
		if R.Extra1 then
			place(R.Extra1, ORIGIN + V(1.5, 4.86, -25.5), -45)
			jamKey(R.Extra1, t)
		end
		if R.Bram then place(R.Bram, ORIGIN + V(3.5, 4.5, -24.0), -60); idle(R.Bram, t) end
		if R.Leo then place(R.Leo, ORIGIN + V(-2.2, 4.5, -24.5), 18); idle(R.Leo, t) end

		local eyeStart = ORIGIN + V(3.5, 5.2, -20.5)
		local eyeEnd = ORIGIN + V(2.2, 4.8, -22.2)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(1.4, 4.5, -25.8), 50)

	elseif beatIdx == 16 then
		-- Beat 16 (126.00 - 129.50s): Maya freezing behind glass, breath slowing
		setFace(R.Maya, "scared")
		if R.Maya then
			place(R.Maya, ORIGIN + V(0.0, 6.90, -28.6), 180)
			pressGlass(R.Maya, t * 0.4) -- Slower shivering
		end
		if R.Leo then place(R.Leo, ORIGIN + V(-1.2, 4.5, -24.5), 0); idle(R.Leo, t) end

		-- Over-the-shoulder look into the freezing observation window
		local eyeStart = ORIGIN + V(-1.0, 5.2, -23.0)
		local eyeEnd = ORIGIN + V(-0.6, 5.4, -24.5)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.0, 6.90, -28.6), 46)

	elseif beatIdx == 17 then
		-- Beat 17 (129.50 - 142.00s): Intimate close-up: Leo presses Dad's watch flat against his chest
		setFace(R.Leo, "shocked")
		if R.Leo then
			place(R.Leo, ORIGIN + V(-1.2, 4.5, -23.5), 0)
			clutchWatch(R.Leo, t)
		end
		if PROPS.DadWatch and R.Leo and R.Leo.torso then
			attachProp(PROPS.DadWatch, R.Leo.torso, CF(0, 0.2, -0.56) * CFrame.Angles(0, rad(90), 0))
		end
		if R.Maya then place(R.Maya, ORIGIN + V(0.0, 6.90, -28.6), 180); pressGlass(R.Maya, t * 0.3) end

		local eyeStart = ORIGIN + V(-1.8, 4.8, -20.5)
		local eyeEnd = ORIGIN + V(-1.4, 4.6, -21.8)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(-1.2, 4.4, -23.5), 44)

	elseif beatIdx == 18 then
		-- Beat 18 (142.00 - 153.92s): Profile tear drop: warm tear rolls down cheek onto watch crystal
		setFace(R.Leo, "determined")
		if R.Leo then
			place(R.Leo, ORIGIN + V(-1.2, 4.5, -23.5), 0)
			clutchWatch(R.Leo, t)
		end
		if PROPS.DadWatch and R.Leo and R.Leo.torso then
			attachProp(PROPS.DadWatch, R.Leo.torso, CF(0, 0.2, -0.56) * CFrame.Angles(0, rad(90), 0))
		end

		if PROPS.TearDrop and R.Leo and R.Leo.head then
			local cheekPos = R.Leo.head.CFrame:PointToWorldSpace(V(0.20, -0.15, -0.50))
			local watchPos = R.Leo.torso.CFrame:PointToWorldSpace(V(0.0, 0.2, -0.65))
			local dropPos = lerpCF(CF(cheekPos), CF(watchPos), ease(u)).Position
			PROPS.TearDrop.CFrame = CF(dropPos)
			PROPS.TearDrop.Size = V(0.20, 0.30, 0.20)
			W(PROPS.TearDrop, "Transparency", 0.1)
		end

		local eyeStart = ORIGIN + V(-0.2, 4.8, -21.0)
		local eyeEnd = ORIGIN + V(-0.6, 4.6, -22.0)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(-1.2, 4.4, -23.5), 42)

	elseif beatIdx == 19 then
		-- Beat 19 (153.92 - 162.22s): Climax: Tear freezes into radiant Master Key with shockwaves
		parkProp(PROPS.TearDrop)
		setFace(R.Leo, "determined")
		if R.Leo then
			place(R.Leo, ORIGIN + V(-1.2, 4.5, -23.5), 0)
			holdMasterKey(R.Leo, t)
		end

		if PROPS.MasterKey and R.Leo and R.Leo.torso then
			local handPos = R.Leo.torso.CFrame:PointToWorldSpace(V(0.0, 0.3 + 0.1 * sin(t * 5), -1.1))
			PROPS.MasterKey:PivotTo(CF(handPos) * CFrame.Angles(rad(12), t * 3, rad(15)))
		end
		if PROPS.VfxRing and R.Leo and R.Leo.torso then
			local handPos = R.Leo.torso.CFrame:PointToWorldSpace(V(0.0, 0.3, -1.1))
			PROPS.VfxRing.CFrame = CF(handPos) * CFrame.Angles(0, t * 5, 0)
			local sz = lerp(0.8, 4.5, u)
			PROPS.VfxRing.Size = V(sz, 0.1, sz)
			W(PROPS.VfxRing, "Transparency", lerp(0.05, 0.95, u))
		end

		local eyeStart = ORIGIN + V(-0.5, 4.8, -20.5)
		local eyeEnd = ORIGIN + V(-0.8, 4.6, -21.8)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(-1.2, 4.4, -23.5), 44, true)

	elseif beatIdx == 20 then
		-- Beat 20 (162.22 - 171.14s): Leo drives Master Key into padlock latch; tumblers turn; steam explosion!
		parkProp(PROPS.VfxRing)
		setFace(R.Leo, "determined")
		if R.Leo then
			place(R.Leo, ORIGIN + V(-0.8, 4.5, -24.8), 10)
			jamKey(R.Leo, t)
		end
		if PROPS.MasterKey then
			attachProp(PROPS.MasterKey, WS.Terrain or WS, CF(ORIGIN + V(1.4, 4.0, -25.8)) * CFrame.Angles(0, 0, rad(lerp(0, 90, seg(u, 0.2, 0.6)))))
		end

		-- Door swings open with steam release
		if u > 0.45 then
			setDoorAngle(lerp(0, 75, seg(u, 0.45, 0.9)))
			if PROPS.DoorSteam and PROPS.DoorSteam:FindFirstChildOfClass("ParticleEmitter") then
				PROPS.DoorSteam.CFrame = CF(ORIGIN + V(0.0, 5.0, -27.5))
				PROPS.DoorSteam:FindFirstChildOfClass("ParticleEmitter").Enabled = true
			end
		end

		local eyeStart = ORIGIN + V(2.8, 4.8, -20.5)
		local eyeEnd = ORIGIN + V(1.5, 4.6, -22.5)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.5, 4.5, -27.0), 52)

	elseif beatIdx == 21 then
		-- Beat 21 (171.14 - 179.50s): Maya runs out to Leo's arms; exhaust valve launches Bram into snowbank!
		parkProp(PROPS.MasterKey)
		if PROPS.DoorSteam and PROPS.DoorSteam:FindFirstChildOfClass("ParticleEmitter") then
			PROPS.DoorSteam:FindFirstChildOfClass("ParticleEmitter").Enabled = false
		end
		setDoorAngle(75)

		setFace(R.Maya, "grin")
		setFace(R.Leo, "grin")
		setFace(R.Bram, "shocked")

		-- Smooth exit: Maya runs out from inside to Leo's arms
		local exitZ = lerp(-27.5, -23.5, ease(u))
		if R.Maya then
			place(R.Maya, ORIGIN + V(0.0, 3.24, exitZ), 180)
			if u < 0.65 then
				runSprint(R.Maya, t, 12)
			else
				hugBoth(R.Leo, R.Maya, t)
			end
		end
		if R.Leo then
			place(R.Leo, ORIGIN + V(-0.6, 4.5, -23.0), 20)
			if u >= 0.65 then hugBoth(R.Leo, R.Maya, t) else idle(R.Leo, t) end
		end

		-- Bram launched into snowbank!
		local launchU = seg(u, 0.2, 0.85)
		if R.Bram then
			local bramX = lerp(22.5, 29.0, launchU)
			local bramY = 3.85 + 4.5 * sin(launchU * math.pi)
			local bramZ = lerp(4.2, 14.0, launchU)
			place(R.Bram, ORIGIN + V(bramX, bramY, bramZ), 180 + launchU * 360)
			blastKnockback(R.Bram, launchU)
		end
		local stand = WS:FindFirstChild("Set_FrostVault003") and WS.Set_FrostVault003:FindFirstChild("OnionKeyStand")
		if stand then
			local standX = lerp(22.5, 28.5, launchU)
			local standY = 1.15 + 3.5 * sin(launchU * math.pi)
			local standZ = lerp(6.0, 15.0, launchU)
			stand:PivotTo(CF(ORIGIN + V(standX, standY, standZ)) * CFrame.Angles(launchU * 2, 0, launchU * 1.5))
		end

		local eyeStart = ORIGIN + V(5.0, 5.5, -16.0)
		local eyeEnd = ORIGIN + V(3.5, 5.0, -18.5)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(0.0, 4.2, -23.0), 58)

	elseif beatIdx == 22 then
		-- Beat 22 (179.50 - 192.18s): Spaced cocoa stand: Maya sheds happy tear; sweet caramel key unlocks cocoa
		setDoorAngle(0)
		setFace(R.Maya, "grin")
		setFace(R.Leo, "grin")
		if R.Vendor then
			place(R.Vendor, ORIGIN + V(-31.5, 4.59, 8.5), 60)
			idle(R.Vendor, t)
		end
		-- Leo and Maya comfortably in front of cocoa dispenser with clean spacing
		if R.Leo then
			place(R.Leo, ORIGIN + V(-27.8, 4.5, 11.0), 15)
			idle(R.Leo, t)
		end
		if R.Maya then
			place(R.Maya, ORIGIN + V(-25.8, 3.24, 10.8), -25)
			presentKeyHands(R.Maya, t)
		end

		if PROPS.CocoaMug1 and R.Leo and R.Leo.torso then
			attachProp(PROPS.CocoaMug1, R.Leo.torso, CF(0.3, -0.1, -0.8))
		end
		if PROPS.CocoaMug2 and R.Maya and R.Maya.torso then
			attachProp(PROPS.CocoaMug2, R.Maya.torso, CF(0.2, -0.1, -0.7))
		end

		-- Clear camera angle avoiding lamp post at X = 1223.5, Z = 14
		local eyeStart = ORIGIN + V(-29.5, 4.6, 12.0)
		local eyeEnd = ORIGIN + V(-28.0, 4.4, 12.8)
		local eye = lerpCF(CF(eyeStart), CF(eyeEnd), ease(u)).Position
		frameCam(cam, eye, ORIGIN + V(-26.8, 3.8, 10.0), 52)
	end
end

function M.step(t, cam)
	if not inited then M.setup() end
	cam = cam or WS.CurrentCamera

	local beatIdx = 1
	for i = 1, #BEATS do
		local b = BEATS[i]
		if t >= b.t and t < (b.t + b.dur) then
			beatIdx = i
			break
		elseif t >= (b.t + b.dur) and i == #BEATS then
			beatIdx = i
		end
	end

	stepBeat(beatIdx, t, cam)

	for _, r in pairs(R) do
		animateRig(r, DT)
	end
end

function M.preview(beatNum)
	if not inited then M.setup() end
	local b = BEATS[beatNum]
	if not b then print("Invalid beat: " .. tostring(beatNum)); return end
	print(string.format("[Story003] Previewing beat %d (t = %.2f, dur = %.2f, shot = %s)", beatNum, b.t, b.dur, b.shot))
	M.step(b.t + 0.1, WS.CurrentCamera)
end

function M.resetCamera()
	local cam = WS.CurrentCamera
	if cam then
		cam.CameraType = Enum.CameraType.Custom
		cam.FieldOfView = 70
	end
	print("[Story003] Camera reset to Custom.")
end

function M.play(part)
	if not inited then M.setup() end
	local cam = WS.CurrentCamera
	cam.CameraType = Enum.CameraType.Scriptable

	local L = game:GetService("Lighting")
	if L:FindFirstChild("Grade") then L.Grade.Brightness = 0 end

	print(string.format("[Story003] Starting playback (LEN = %.2fs, 30 FPS)...", LEN))
	local startTime = os.clock()
	local totalFrames = math.floor(LEN * 30)

	for frame = 0, totalFrames do
		local t = frame / 30
		M.step(t, cam)
		task.wait(DT)
	end

	M.resetStaging()
	M.resetCamera()
	print("[Story003] Playback finished.")
end

_G.Story003 = M
return M
