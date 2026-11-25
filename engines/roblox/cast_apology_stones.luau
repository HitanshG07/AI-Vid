-- Kept character cast (its story was removed 2026-11-21): classic R6 avatars, catalog clothing, flat 2D faces (assets/faces/classic_v1)
-- Method: R6 CreateHumanoidModelFromDescription with community catalog items (0 Robux in Studio)
-- Placement: lowest-part floor snap; only HumanoidRootPart anchored
local Players = game:GetService("Players")

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
		scale = 0.85,
		shirt = 139637579996070,
		pants = 124776138615892,
		hair = "94946081980224",
		skin = Color3.fromRGB(234, 190, 150),
		face = "neutral",
	},
	Marcus = {
		gender = "boy",
		scale = 1.0,
		shirt = 86330417861158,
		pants = 12671481024,
		hair = "98588731108499",
		skin = Color3.fromRGB(234, 190, 150),
		face = "scared",
	},
	Mom = {
		gender = "woman",
		scale = 1.02,
		shirt = 3670737444,
		pants = 398634487,
		hair = "100973074711029",
		skin = Color3.fromRGB(234, 190, 150),
		face = "shocked",
	},
	Bystander_Bully = {
		gender = "boy",
		scale = 1.05,
		shirt = 382537085,
		pants = 382537806,
		hair = "376524487",
		skin = Color3.fromRGB(245, 205, 170),
		face = "scared",
	},
	Bystander_Girl = {
		gender = "girl",
		scale = 1.0,
		shirt = 398635081,
		pants = 144076760,
		hair = "100973074711029", -- was 62234425 (male "Man" body hair); Black Ponytail
		skin = Color3.fromRGB(255, 220, 190),
		face = "scared",
	},
	Bridge_Pedestrian = {
		gender = "woman",
		scale = 1.0,
		shirt = 93684471979859,
		pants = 89518846190037,
		hair = "74528752688799",
		skin = Color3.fromRGB(225, 175, 135),
		face = "shocked",
	},
}

local M = { FACES = FACES, CAST = CAST }

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
	local o = assert(CAST[name], "unknown cast member " .. name)
	rig = rig or Enum.HumanoidRigType.R6
	local d = Instance.new("HumanoidDescription")
	assert(o.gender, "cast entry missing gender (owner rule 2026-11-19)")
	d.Shirt = o.shirt
	d.Pants = o.pants
	d.HairAccessory = o.hair
	if o.waist then d.WaistAccessory = o.waist end
	if o.neck then d.NeckAccessory = o.neck end
	if o.hat then d.HatAccessory = o.hat end
	if o.face_acc then d.FaceAccessory = o.face_acc end
	local colors = { "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" }
	for _, k in ipairs(colors) do
		d[k] = o.skin
	end
	local m = Players:CreateHumanoidModelFromDescription(d, rig)
	m.Name = name
	if o.scale then
		m:ScaleTo(o.scale)
	end
	m:PivotTo(CFrame.new(x, floorY + 5, z) * CFrame.Angles(0, math.rad(yawDeg or 0), 0))
	local low = math.huge
	for _, p in ipairs(m:GetChildren()) do
		if p:IsA("BasePart") then
			low = math.min(low, p.Position.Y - p.Size.Y / 2)
		end
	end
	m:PivotTo(m:GetPivot() + Vector3.new(0, floorY - low, 0))
	for _, p in ipairs(m:GetDescendants()) do
		if p:IsA("BasePart") then
			p.Anchored = (p.Name == "HumanoidRootPart")
		end
	end
	m.Parent = parent or workspace
	M.setFace(m, o.face)
	return m
end

return M
