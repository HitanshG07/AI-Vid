-- Story 002 cast: classic R6 avatars, catalog clothing, flat 2D faces (assets/faces/classic_v1)
-- Method: R6 CreateHumanoidModelFromDescription with community catalog items (0 Robux in Studio)
-- Placement: lowest-part floor snap; only HumanoidRootPart anchored
-- Ids found 2026-11-19 via AvatarEditorService:SearchCatalog (Relevance) with gendered terms; catalog names in comments.
local Players = game:GetService("Players")

local FACES = {
	neutral = "rbxassetid://70950815478959",
	scared = "rbxassetid://94514852927815",
	shocked = "rbxassetid://103057607693548",
	grin = "rbxassetid://96253429845051",
	determined = "rbxassetid://109687999939498",
	proud = "rbxassetid://96477668083717",
	-- Striders only: NO decal at all (blank pale head reads eyeless). Not an outside asset; no new face needed.
	eyeless = "",
}

local CAST = {
	Theo = {
		gender = "boy",
		scale = 1.0,
		shirt = 12329928029, -- "red puffer jacket boys gangster"
		pants = 134609569320601, -- "Boy jeans"
		hair = "98588731108499", -- reuse Kai/Marcus (boy)
		hat = "17500690164", -- "Beanie"
		skin = Color3.fromRGB(234, 190, 150), -- #EABE96
		face = "neutral",
	},
	June = {
		gender = "girl",
		scale = 0.7,
		shirt = 90274186166468, -- "pink pajamas cutie nightie meow sweet girls"
		pants = 14075581338, -- "Cloud pajama pants for girls"
		hair = "140124368601570", -- "kawaii cute moe baby pigtails black" (girl)
		skin = Color3.fromRGB(255, 220, 190), -- #FFDCBE
		face = "grin",
	},
	Jogger = {
		gender = "man",
		scale = 1.08,
		shirt = 2885430411, -- "Mens Tracksuit"
		pants = 140429444258386, -- "Balenci Men's Tracksuit Pants Navy"
		hair = "120646937583722", -- "Curly Messy Beach Hair Men Black"
		skin = Color3.fromRGB(205, 150, 110), -- #CD966E
		face = "grin",
	},
	VanDriver = {
		gender = "man",
		scale = 1.08,
		shirt = 3568313512, -- "Billy's Works Shirt (MEN)"
		pants = 12858384874, -- "Beige cargo pants for men"
		hair = "139671521768286", -- "Formal Men Mafia Side Part Curl Hair BLACK"
		hat = nil,
		skin = Color3.fromRGB(176, 124, 92), -- #B07C5C
		face = "neutral",
	},
	Extra_Woman = {
		gender = "woman",
		scale = 1.02,
		shirt = 18566797626, -- "Black Comfy Womens Sweater" (crop-top coat rejected)
		pants = 5498774219, -- "Womens Jeans"
		hair = "129421843016867", -- "Vintage 50s Women's Brown Hair"
		neck = nil,
		skin = Color3.fromRGB(225, 175, 135), -- #E1AF87
		face = "neutral",
	},
	Extra_Man = {
		gender = "man",
		scale = 1.08,
		shirt = 4593507067, -- "424 Yellow Denim Parka" (distinct from Theo red)
		pants = 3234753288, -- "Mens Two-Tone Camo Cargo Pants"
		hair = "124340390453001", -- "Side Part Japanese Boy Men Formal Hair Black"
		skin = Color3.fromRGB(110, 75, 55), -- #6E4B37
		face = "neutral",
	},
	-- Strider1/2/3 share this entry (creatures; identical by design). Build with M.build("Strider", ...) then rename.
	Strider = {
		gender = "man",
		scale = 1.4,
		shirt = 17181790240, -- "Black Trench Coat [+]"
		pants = 122205461150104, -- "Black Pants"
		hair = "", -- bald by design
		skin = Color3.fromRGB(200, 200, 205), -- #C8C8CD pale grey
		face = "eyeless",
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
