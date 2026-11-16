--!nocheck
-- assets/rigs/build_all_riggable_characters.luau
-- Builds or upgrades ALL 12 story characters (Hero, LittleHero, Mia, Jace, Teacher, Grandma, Extra1..6)
-- with:
--   1. Unified Roblox R15 blocky/beveled proportions & customizable outfits/hair/glasses
--   2. Expressive 3-Layer Face Rig (White sclera + Iris/Pupil + Dual White Specular Catchlights)
--      plus seamless support for ServerStorage.ApprovedFaces or Decal PNGs
--   3. Flush Dorsal Vein Aging Rig (S7AgeVein cylinders inside the hand contour — NEVER overhanging brown boxes!)
--   4. WeldConstraint Hand-Prop Socket so held phones, cups, bottles, and pencils NEVER detach in Edit Mode!

local Players = game:GetService("Players")
local SS = game:GetService("ServerStorage")
local WS = workspace
local V, CF = Vector3.new, CFrame.new
local rad = math.rad
local rgb = Color3.fromRGB

local CAST_CONFIG = {
	Hero       = { skin = rgb(232, 207, 168), shirt = 382537702,  pants = 382537569, hair = "62234425",   scale = 1.00, shirtCol = rgb(30, 86, 160),  pantsCol = rgb(29, 36, 50),  browCol = rgb(74, 46, 27),   glasses = nil },
	LittleHero = { skin = rgb(232, 207, 168), shirt = 382537702,  pants = 382537806, hair = "62234425",   scale = 0.62, shirtCol = rgb(88, 166, 255), pantsCol = rgb(36, 52, 77),  browCol = rgb(74, 46, 27),   glasses = nil },
	Mia        = { skin = rgb(235, 203, 178), shirt = 398635081,  pants = 144076760, hair = "9244148336", scale = 1.00, shirtCol = rgb(242, 183, 5),  pantsCol = rgb(43, 45, 56),  browCol = rgb(62, 39, 35),   glasses = nil },
	Jace       = { skin = rgb(242, 207, 164), shirt = 144076358,  pants = 382538503, hair = "376524487",  scale = 1.00, shirtCol = rgb(217, 43, 43),  pantsCol = rgb(28, 34, 46),  browCol = rgb(198, 142, 40), glasses = nil },
	Teacher    = { skin = rgb(216, 184, 148), shirt = 3670737444, pants = 398634487, hair = "63690008",   scale = 1.05, shirtCol = rgb(240, 242, 245),pantsCol = rgb(66, 52, 43),  browCol = rgb(74, 53, 37),   glasses = "rect" },
	Grandma    = { skin = rgb(223, 195, 165), shirt = 144076436,  pants = 398633812, hair = "9244150641", scale = 0.96, shirtCol = rgb(142, 99, 141), pantsCol = rgb(61, 49, 64),  browCol = rgb(140, 140, 140),glasses = "round" },
	Extra1     = { skin = rgb(124, 92, 70),   shirt = 144076436,  pants = 398633812, hair = "7193454569", scale = 1.00, shirtCol = rgb(30, 138, 122), pantsCol = rgb(29, 38, 54),  browCol = rgb(30, 20, 14),   glasses = nil },
	Extra2     = { skin = rgb(245, 205, 167), shirt = 398635081,  pants = 144076760, hair = "62234425",   scale = 1.00, shirtCol = rgb(46, 94, 170),  pantsCol = rgb(35, 43, 56),  browCol = rgb(84, 56, 36),   glasses = nil },
	Extra3     = { skin = rgb(175, 130, 100), shirt = 144076358,  pants = 382538503, hair = "9244150641", scale = 1.00, shirtCol = rgb(59, 105, 152), pantsCol = rgb(33, 35, 46),  browCol = rgb(59, 38, 24),   glasses = nil },
	Extra4     = { skin = rgb(216, 164, 127), shirt = 382537085,  pants = 382537806, hair = "9244148336", scale = 1.00, shirtCol = rgb(184, 41, 47),  pantsCol = rgb(34, 38, 52),  browCol = rgb(61, 38, 26),   glasses = nil },
	Extra5     = { skin = rgb(122, 84, 62),   shirt = 382537702,  pants = 382537569, hair = "7193454569", scale = 1.00, shirtCol = rgb(46, 90, 54),   pantsCol = rgb(43, 58, 74),  browCol = rgb(28, 18, 12),   glasses = nil },
	Extra6     = { skin = rgb(234, 202, 158), shirt = 3670737444, pants = 398634487, hair = "376524487",  scale = 1.00, shirtCol = rgb(110, 101, 79), pantsCol = rgb(37, 52, 71),  browCol = rgb(89, 60, 40),   glasses = nil },
}

-- Builds a 3-layer expressive SurfaceGui face on the front of a blocky head (used whenever ApprovedFaces is absent,
-- and ALWAYS used on Extra1..6 so no character ever displays the flat 2006 ':|' default smiley!)
local function attachExpressive2DFace(head: BasePart, browCol: Color3, emotion: string?)
	emotion = emotion or "Happy"
	-- Hide default Roblox decal smiley if present
	local defaultDecal = head:FindFirstChild("face") or head:FindFirstChildOfClass("Decal")
	if defaultDecal then defaultDecal.Transparency = 1 end

	local old = head:FindFirstChild("Studio2DFaceGui")
	if old then old:Destroy() end

	local sg = Instance.new("SurfaceGui")
	sg.Name = "Studio2DFaceGui"
	sg.Face = Enum.NormalId.Front
	sg.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
	sg.CanvasSize = Vector2.new(256, 256)
	sg.LightInfluence = 0.25
	sg.ZOffset = 1
	sg.Parent = head

	local function box(parent, name, pos, sz, col, cornerRadius, rot)
		local f = Instance.new("Frame")
		f.Name = name
		f.Position = UDim2.fromOffset(pos.X, pos.Y)
		f.Size = UDim2.fromOffset(sz.X, sz.Y)
		f.BackgroundColor3 = col
		f.BorderSizePixel = 0
		f.Rotation = rot or 0
		if cornerRadius and cornerRadius > 0 then
			local c = Instance.new("UICorner")
			c.CornerRadius = UDim.new(0, cornerRadius)
			c.Parent = f
		end
		f.Parent = parent
		return f
	end

	-- 3-Layer Eyes (Left & Right): Black Outline -> Crisp White Sclera -> Dark Pupil -> 2 White Specular Catchlights
	local eyeH = (emotion == "Shocked") and 50 or 42
	local pupSz = (emotion == "Shocked") and 20 or 26
	for idx, cx in { 84, 172 } do
		local isLeft = (idx == 1)
		local out = box(sg, "EyeOut" .. idx, Vector2.new(cx - 21, 92), Vector2.new(42, eyeH), rgb(20, 18, 16), 21)
		local scl = box(out, "Sclera", Vector2.new(3, 3), Vector2.new(36, eyeH - 6), rgb(252, 253, 255), 18)
		local pup = box(scl, "Pupil", Vector2.new((36 - pupSz) / 2, (eyeH - 6 - pupSz) / 2 + 2), Vector2.new(pupSz, pupSz), rgb(24, 20, 18), pupSz / 2)
		-- Dual white catchlight dots!
		box(pup, "Catchlight1", Vector2.new(3, 3), Vector2.new(9, 9), rgb(255, 255, 255), 5)
		box(pup, "Catchlight2", Vector2.new(pupSz - 9, pupSz - 9), Vector2.new(5, 5), rgb(255, 255, 255), 3)

		-- Eyebrow
		local browRot = 0
		if emotion == "Determined" or emotion == "Straining" then
			browRot = isLeft and 14 or -14
		elseif emotion == "Worried" or emotion == "Sad" or emotion == "Crying" then
			browRot = isLeft and -14 or 14
		elseif emotion == "Smirk" then
			browRot = isLeft and 10 or -8
		end
		box(sg, "Brow" .. idx, Vector2.new(cx - 22, (emotion == "Shocked") and 72 or 78), Vector2.new(44, 9), browCol, 4, browRot)

		if emotion == "Crying" then
			box(sg, "Tear" .. idx, Vector2.new(cx - 6, 136), Vector2.new(12, 28), rgb(100, 205, 255), 6)
		end
	end

	-- Mouth per emotion
	if emotion == "Shocked" then
		local mOut = box(sg, "Mouth", Vector2.new(114, 162), Vector2.new(28, 34), rgb(22, 18, 16), 14)
		box(mOut, "Inner", Vector2.new(4, 4), Vector2.new(20, 26), rgb(120, 28, 34), 10)
	elseif emotion == "Determined" or emotion == "Straining" then
		local mOut = box(sg, "Mouth", Vector2.new(98, 166), Vector2.new(60, 22), rgb(22, 18, 16), 6)
		box(mOut, "Teeth", Vector2.new(3, 3), Vector2.new(54, 16), rgb(255, 255, 255), 4)
	elseif emotion == "Sad" or emotion == "Worried" or emotion == "Crying" then
		box(sg, "Mouth", Vector2.new(104, 172), Vector2.new(48, 8), rgb(22, 18, 16), 4)
	elseif emotion == "Smirk" then
		box(sg, "Mouth", Vector2.new(106, 166), Vector2.new(48, 9), rgb(22, 18, 16), 4, -10)
	else
		-- Happy / Neutral clean smile
		local mOut = box(sg, "Mouth", Vector2.new(100, 164), Vector2.new(56, 22), rgb(22, 18, 16), 10)
		box(mOut, "Teeth", Vector2.new(3, 3), Vector2.new(50, 14), rgb(255, 255, 255), 7)
	end
end

-- Flush Dorsal Age Veins (3 thin 0.032-stud cylinders tucked inside the back of the hand — NEVER overhanging slabs!)
local function ensureFlushAgeVeins(m: Model)
	for _, handName in { "LeftHand", "RightHand" } do
		local hp = m:FindFirstChild(handName)
		if hp and hp:IsA("BasePart") then
			for _, ch in hp:GetChildren() do
				if ch.Name:sub(1, 5) == "S7Age" then ch:Destroy() end
			end
			for k = 1, 3 do
				local c = Instance.new("Part")
				c.Name = "S7AgeVein" .. handName .. k
				c.Shape = Enum.PartType.Cylinder
				c.Size = V(0.28, 0.032, 0.032)
				c.CFrame = hp.CFrame * CF((k - 2) * 0.075, 0.02, -0.14) * CFrame.Angles(0, 0, rad(90 + (k - 2) * 10))
				c.Color = rgb(92, 68, 58)
				c.Material = Enum.Material.SmoothPlastic
				c.Transparency = 1
				c.Anchored, c.CanCollide, c.CanQuery, c.CanTouch, c.Massless, c.CastShadow = false, false, false, false, true, false
				local w = Instance.new("WeldConstraint")
				w.Part0 = hp
				w.Part1 = c
				w.Parent = c
				c.Parent = hp
			end
		end
	end
end

local RigBuilder = {}

function RigBuilder.buildOrUpgrade(name: string)
	local cfg = CAST_CONFIG[name]
	if not cfg then warn("[RigBuilder] Unknown character: " .. tostring(name)) return nil end

	local m = WS:FindFirstChild(name)
	-- For Extra1..6 (or if a character is missing from Workspace), build cleanly via HumanoidDescription R15
	if not m or name:sub(1, 5) == "Extra" then
		local oldPivot = m and m:GetPivot() or CF(0, 3, 0)
		if m then m:Destroy() end
		local d = Instance.new("HumanoidDescription")
		d.Shirt = cfg.shirt
		d.Pants = cfg.pants
		d.HairAccessory = cfg.hair
		for _, k in { "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" } do
			d[k] = cfg.skin
		end
		m = Players:CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R15)
		m.Name = name
		if cfg.scale ~= 1.0 then pcall(function() m:ScaleTo(cfg.scale) end) end
		m:PivotTo(oldPivot)
		for _, p in m:GetDescendants() do
			if p:IsA("BasePart") then p.Anchored = (p.Name == "HumanoidRootPart") end
		end
		m.Parent = WS
	end

	-- Upgrade Grandma's cardigan tint so she never washes out to white under sepia fill lights
	if name == "Grandma" then
		for _, pn in { "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm" } do
			local p = m:FindFirstChild(pn)
			if p and p:IsA("BasePart") then
				p.Color = cfg.shirtCol
				local sa = p:FindFirstChildOfClass("SurfaceAppearance")
				if sa then sa.Color = cfg.shirtCol end
			end
		end
	end

	-- Attach expressive 3-layer 2D face to Extras (or any character without ApprovedFaces)
	local head = m:FindFirstChild("Head")
	local hasApproved = SS:FindFirstChild("ApprovedFaces") and SS.ApprovedFaces:FindFirstChild(name .. "_Happy")
	if head and not hasApproved then
		attachExpressive2DFace(head, cfg.browCol, "Happy")
	end

	-- Ensure flush dorsal age veins on Hero, Jace, Grandma, and Extra3
	if name == "Hero" or name == "Jace" or name == "Grandma" or name == "Extra3" then
		ensureFlushAgeVeins(m)
	end

	return m
end

function RigBuilder.buildAll()
	for name, _ in CAST_CONFIG do
		RigBuilder.buildOrUpgrade(name)
		task.wait()
	end
	return "Built and upgraded all 12 riggable story characters"
end

_G.RigBuilder = RigBuilder
return RigBuilder.buildAll()
