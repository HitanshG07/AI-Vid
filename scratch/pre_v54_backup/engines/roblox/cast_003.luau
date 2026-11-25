-- Story 003 ("Tears to Glass Keys") cast: classic R6 avatars, winter catalog clothing, flat 2D faces (assets/faces/classic_v1).
-- Method: R6 Players:CreateHumanoidModelFromDescription with verified, gender-locked winter catalog items.
-- Placement: lowest-part floor snap; only HumanoidRootPart anchored.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local ORIGIN = Vector3.new(1250, 0, 0)

local FACES = {
	neutral = "rbxassetid://70950815478959",
	scared = "rbxassetid://94514852927815",
	shocked = "rbxassetid://103057607693548",
	grin = "rbxassetid://96253429845051",
	determined = "rbxassetid://109687999939498",
	proud = "rbxassetid://96477668083717",
}

local CAST = {
	Leo = {
		gender = "boy",
		scale = 1.0,
		shirt = 12329928029,
		pants = 134609569320601,
		hair = "98588731108499",
		hat = "17500690164",
		skin = Color3.fromRGB(234, 190, 150),
		face = "neutral",
	},
	Maya = {
		gender = "girl",
		scale = 0.72,
		shirt = 90274186166468,
		pants = 14075581338,
		hair = "140124368601570",
		skin = Color3.fromRGB(255, 220, 190),
		face = "grin",
	},
	Bram = {
		gender = "boy",
		scale = 1.04,
		shirt = 17181790240,
		pants = 122205461150104,
		hair = "124340390453001",
		skin = Color3.fromRGB(205, 150, 110),
		face = "determined",
	},
	Vendor = {
		gender = "woman",
		scale = 1.02,
		shirt = 18566797626,
		pants = 5498774219,
		hair = "129421843016867",
		skin = Color3.fromRGB(225, 175, 135),
		face = "grin",
	},
	Extra1 = {
		gender = "man",
		scale = 1.08,
		shirt = 4593507067,
		pants = 3234753288,
		hair = "120646937583722",
		skin = Color3.fromRGB(176, 124, 92),
		face = "neutral",
	},
	Extra2 = {
		gender = "woman",
		scale = 1.0,
		shirt = 18566797626,
		pants = 5498774219,
		hair = "100973074711029",
		skin = Color3.fromRGB(150, 100, 70),
		face = "neutral",
	},
	Dad = {
		gender = "man",
		scale = 1.08,
		shirt = 3568313512, -- "Billy's Works Shirt (MEN)" Chief Architect heavy winter coat
		pants = 140429444258386, -- "Balenci Men's Pants Navy"
		hair = "120646937583722", -- "Curly Messy Beach Hair Men Black"
		skin = Color3.fromRGB(234, 190, 150),
		face = "determined",
	},
}

local M = { ORIGIN = ORIGIN, FACES = FACES, CAST = CAST }

function M.setFace(model, emotion)
	local head = model:FindFirstChild("Head")
	if not head then return end
	local d = head:FindFirstChild("face") or head:FindFirstChildOfClass("Decal")
	if not d then
		d = Instance.new("Decal")
		d.Name = "face"
		d.Face = Enum.NormalId.Front
		d.Parent = head
	end
	d.Texture = assert(FACES[emotion], "unknown face " .. tostring(emotion))
end

function M.build(name, x, floorY, z, yawDeg, parent, rig)
	local o = assert(CAST[name], "unknown cast member " .. tostring(name))
	assert(o.gender, "cast entry missing gender: " .. tostring(name))
	rig = rig or Enum.HumanoidRigType.R6
	local desc = Instance.new("HumanoidDescription")
	desc.Shirt = o.shirt
	desc.Pants = o.pants
	desc.HairAccessory = o.hair
	if o.hat then desc.HatAccessory = o.hat end
	if o.neck then desc.NeckAccessory = o.neck end
	for _, propName in ipairs({ "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" }) do
		desc[propName] = o.skin
	end
	local m = Players:CreateHumanoidModelFromDescription(desc, rig)
	m.Name = name
	if o.scale and o.scale ~= 1.0 then m:ScaleTo(o.scale) end
	m:PivotTo(CFrame.new(x, floorY + 5, z) * CFrame.Angles(0, math.rad(yawDeg or 0), 0))
	local low = math.huge
	for _, p in ipairs(m:GetChildren()) do
		if p:IsA("BasePart") then low = math.min(low, p.Position.Y - p.Size.Y / 2) end
	end
	m:PivotTo(m:GetPivot() + Vector3.new(0, floorY - low, 0))
	for _, p in ipairs(m:GetDescendants()) do
		if p:IsA("BasePart") then p.Anchored = (p.Name == "HumanoidRootPart") end
	end
	m.Parent = parent or Workspace
	M.setFace(m, o.face)
	return m
end

function M.buildAll(parent)
	local targetParent = parent or Workspace
	local existing = targetParent:FindFirstChild("Cast_003")
	if existing then existing:Destroy() end
	local folder = Instance.new("Folder")
	folder.Name = "Cast_003"
	folder.Parent = targetParent
	local placements = {
		{ name = "Bram", dx = -7.5, dy = 0, dz = 5.5, yaw = 170 },
		{ name = "Extra1", dx = -4.5, dy = 0, dz = 5.5, yaw = 175 },
		{ name = "Leo", dx = -1.5, dy = 0, dz = 5.5, yaw = 180 },
		{ name = "Maya", dx = 1.2, dy = 0, dz = 5.8, yaw = 180 },
		{ name = "Vendor", dx = 4.0, dy = 0, dz = 5.5, yaw = 185 },
		{ name = "Extra2", dx = 7.0, dy = 0, dz = 5.5, yaw = 190 },
	}
	local built = {}
	for _, entry in ipairs(placements) do
		built[entry.name] = M.build(entry.name, ORIGIN.X + entry.dx, ORIGIN.Y + entry.dy, ORIGIN.Z + entry.dz, entry.yaw, folder)
		task.wait()
	end
	return folder, built
end

return M
