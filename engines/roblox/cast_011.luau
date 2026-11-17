-- Story 011 cast: classic R6 avatars, catalog clothing, own flat 2D faces (assets/faces/classic_v1).
-- Method under test 2026-11-17 (ADOPTION_GUIDE D1 option a). Catalog items render in Studio without owning them (0 Robux).
-- Usage (Studio MCP execute_luau, Edit): paste and run, or require from a ModuleScript. Returns the cast table.
-- Placement: root-based floor snap; only HumanoidRootPart is anchored (anchoring accessory handles detaches hair).
local Players = game:GetService("Players")

local FACES = { -- assets/faces/classic_v1/ids.json
	neutral = "rbxassetid://70950815478959", scared = "rbxassetid://94514852927815",
	shocked = "rbxassetid://103057607693548", grin = "rbxassetid://96253429845051",
	determined = "rbxassetid://109687999939498", proud = "rbxassetid://96477668083717",
}

local CAST = { -- catalog asset ids (AvatarEditorService:SearchCatalog, 2026-11-17)
	Kai  = { shirt = 86330417861158, pants = 12671481024, hair = "98588731108499", skin = Color3.fromRGB(234, 190, 150), face = "neutral" },
	Milo = { scale = 0.75, shirt = 139637579996070, pants = 124776138615892, hair = "94946081980224", waist = "7172656303", skin = Color3.fromRGB(234, 190, 150), face = "grin" },
	Rosa = { shirt = 133484080647039, pants = 389857088, hair = "100973074711029", neck = "28672417", skin = Color3.fromRGB(176, 124, 92), face = "determined" },
	YoungRosa = { scale = 0.85, shirt = 91467779965025, pants = 13979853518, hair = "100973074711029", skin = Color3.fromRGB(176, 124, 92), face = "scared" }, -- flashback, unlit
	Kid  = { scale = 0.75, shirt = 9583523089, pants = 140104955076438, hair = "94946081980224", skin = Color3.fromRGB(205, 150, 110), face = "scared" },  -- swept-away kid
	-- beachgoer extras (all glowing): varied skin, hair and outfits so the crowd never looks cloned
	E1 = { shirt = 17424992678, pants = 13864024636, hair = "138332213451880", face_acc = "132447033477670", skin = Color3.fromRGB(245, 205, 170), face = "grin" },
	E2 = { shirt = 8836645430, pants = 14262996290, hair = "140624854156017", hat = "14873143034", skin = Color3.fromRGB(230, 185, 140), face = "neutral" },
	E3 = { shirt = 78421295651694, pants = 12574395860, hair = "71343213020367", hat = "12400948539", skin = Color3.fromRGB(150, 100, 70), face = "grin" },
	E4 = { shirt = 85435724220934, pants = 18332980667, hair = "17890789000", skin = Color3.fromRGB(240, 200, 160), face = "proud" },
	E5 = { shirt = 93684471979859, pants = 89518846190037, hair = "74528752688799", skin = Color3.fromRGB(225, 175, 135), face = "neutral" },
	E6 = { shirt = 7817471255, pants = 12068155904, hair = "84948868072722", skin = Color3.fromRGB(110, 75, 55), face = "grin" },
}

local M = { FACES = FACES, CAST = CAST }

function M.setFace(model, emotion)
	local head = model:FindFirstChild("Head")
	local d = head:FindFirstChild("face") or head:FindFirstChildOfClass("Decal")
	if not d then d = Instance.new("Decal") d.Name = "face" d.Face = Enum.NormalId.Front d.Parent = head end
	d.Texture = assert(FACES[emotion], "unknown face " .. tostring(emotion))
end

-- Build one character standing on floorY at (x, z), facing yawDeg. rig defaults to R6.
function M.build(name, x, floorY, z, yawDeg, parent, rig)
	local o = assert(CAST[name], "unknown cast member " .. name)
	rig = rig or Enum.HumanoidRigType.R6
	local d = Instance.new("HumanoidDescription")
	d.Shirt, d.Pants, d.HairAccessory = o.shirt, o.pants, o.hair
	if o.waist then d.WaistAccessory = o.waist end
	if o.neck then d.NeckAccessory = o.neck end
	if o.hat then d.HatAccessory = o.hat end
	if o.face_acc then d.FaceAccessory = o.face_acc end
	for _, k in { "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" } do d[k] = o.skin end
	local m = Players:CreateHumanoidModelFromDescription(d, rig)
	m.Name = name
	if o.scale then m:ScaleTo(o.scale) end -- children: R6 has no height setting, ScaleTo scales body, clothes, hair and joints
	m:PivotTo(CFrame.new(x, floorY + 5, z) * CFrame.Angles(0, math.rad(yawDeg or 0), 0))
	local low = math.huge
	for _, p in m:GetChildren() do if p:IsA("BasePart") then low = math.min(low, p.Position.Y - p.Size.Y / 2) end end
	m:PivotTo(m:GetPivot() + Vector3.new(0, floorY - low, 0))
	for _, p in m:GetDescendants() do if p:IsA("BasePart") then p.Anchored = p.Name == "HumanoidRootPart" end end
	m.Parent = parent or workspace
	M.setFace(m, o.face)
	return m
end

return M
