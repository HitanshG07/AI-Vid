-- Kept character cast (its story was removed 2026-11-21), using the R6 builder and catalog assets from cast_002.
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
	Ash = {
		gender = "boy", scale = 1,
		shirt = 12329928029, pants = 134609569320601, hair = "98588731108499",
		skin = Color3.fromRGB(234, 190, 150), face = "neutral",
	},
	Pip = {
		gender = "girl", scale = 0.7,
		shirt = 90274186166468, pants = 14075581338, hair = "140124368601570",
		skin = Color3.fromRGB(255, 220, 190), face = "grin",
	},
	Bell = {
		gender = "woman", scale = 1.02,
		shirt = 18566797626, pants = 5498774219, hair = "129421843016867",
		skin = Color3.fromRGB(225, 175, 135), face = "grin",
	},
	Baker = {
		gender = "man", scale = 1.08,
		shirt = 3568313512, pants = 12858384874, hair = "139671521768286",
		skin = Color3.fromRGB(176, 124, 92), face = "neutral",
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

function M.build(name, x, floorY, z, yawDeg, parent)
	local o = assert(CAST[name], "unknown cast member " .. name)
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
	local m = Players:CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R6)
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
