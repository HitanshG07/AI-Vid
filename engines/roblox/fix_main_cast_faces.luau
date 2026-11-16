--!nocheck
-- engines/roblox/fix_main_cast_faces.luau
-- Fixes the 3D human nose/mouth on Studio generate_avatar characters (like current_mia)
-- WITHOUT bleeding onto their 3D hair! Welds a curved, skin-colored Faceplate mask
-- (0.76 x 0.66 x 0.14) strictly over the front facial region below the bangs, hiding
-- the 3D nose/lips and displaying the crisp 3-layer 2D cartoon face on top.

local WS = workspace
local V, CF = Vector3.new, CFrame.new
local rgb = Color3.fromRGB

local SKIN_HEX = {
	Hero       = rgb(232, 207, 168),
	LittleHero = rgb(232, 207, 168),
	Mia        = rgb(235, 203, 178),
	Jace       = rgb(242, 207, 164),
	Teacher    = rgb(216, 184, 148),
	Grandma    = rgb(223, 195, 165),
}

local function applyCleanFaceMask(charName: string)
	local m = WS:FindFirstChild(charName)
	if not m then return end
	local head = m:FindFirstChild("Head")
	if not head or not head:IsA("BasePart") then return end

	local old = head:FindFirstChild("S7CleanFaceMask")
	if old then old:Destroy() end

	local mask = Instance.new("Part")
	mask.Name = "S7CleanFaceMask"
	mask.Size = V(head.Size.X * 0.66, head.Size.Y * 0.56, 0.14)
	mask.Color = SKIN_HEX[charName] or head.Color
	mask.Material = Enum.Material.SmoothPlastic
	mask.TopSurface = Enum.SurfaceType.Smooth
	mask.BottomSurface = Enum.SurfaceType.Smooth
	mask.Anchored = false
	mask.CanCollide = false
	mask.CanQuery = false
	mask.Massless = true
	mask.CastShadow = false

	-- Softly rounded bevel mesh so the mask blends into the cheeks seamlessly
	local sm = Instance.new("SpecialMesh")
	sm.MeshType = Enum.MeshType.Head
	sm.Scale = V(1.05, 1.05, 0.45)
	sm.Parent = mask

	-- Position strictly over the nose/mouth/eyes (below the bangs, in front of the human nose!)
	mask.CFrame = head.CFrame * CF(0, -head.Size.Y * 0.07, -head.Size.Z * 0.43)
	local w = Instance.new("WeldConstraint")
	w.Part0 = head
	w.Part1 = mask
	w.Parent = mask
	mask.Parent = head

	-- If _G.RigBuilder is loaded, attach the 3-layer 2D face GUI onto the mask
	if _G.RigBuilder and _G.RigBuilder.attachFaceToPart then
		_G.RigBuilder.attachFaceToPart(mask, charName, "Happy")
	end
	return mask
end

for name, _ in SKIN_HEX do
	applyCleanFaceMask(name)
end
return "Applied clean 2D faceplate masks to main cast without touching 3D hair"
