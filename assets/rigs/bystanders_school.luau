-- Dressed school bystanders (Extra1..6) via HumanoidDescription. Rebuildable anywhere; replaces any old Extra models.
-- All items: free Roblox catalog (AvatarEditorService:SearchCatalog, MaxPrice 0, Nov 2026). Face 0 = classic default face.
-- Never clone main characters as extras (audit AUDIT-001: clone classroom).
local Players = game:GetService("Players")
local OUTFITS = { -- { shirt, pants, hair, skin }
	{ 382537702, 382537569, "62234425", Color3.fromRGB(234, 184, 146) },   -- teal shirt, black jeans, brown hair
	{ 398635081, 144076760, "9244148336", Color3.fromRGB(255, 220, 190) }, -- blue plaid, green jeans, blonde braids
	{ 144076436, 398633812, "7193454569", Color3.fromRGB(124, 92, 70) },   -- striped+denim, black jeans, black braids
	{ 382537085, 382537806, "376524487", Color3.fromRGB(245, 205, 170) },  -- pizza shirt, jean shorts, blonde spikes
	{ 144076358, 382538503, "63690008", Color3.fromRGB(175, 130, 100) },   -- moto shirt, jeans+sneakers, pal hair
	{ 3670737444, 398634487, "9244150641", Color3.fromRGB(230, 195, 160) },-- pattern shirt, jeans, brown braids
}
for i, o in OUTFITS do
	local old = workspace:FindFirstChild("Extra" .. i)
	local pivot = old and old:GetPivot() or CFrame.new(0, 3, 0)
	if old then old:Destroy() end
	local d = Instance.new("HumanoidDescription")
	d.Shirt, d.Pants, d.HairAccessory = o[1], o[2], o[3]
	for _, k in { "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" } do d[k] = o[4] end
	local m = Players:CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R15)
	m.Name = "Extra" .. i
	m:PivotTo(pivot)
	for _, p in m:GetDescendants() do if p:IsA("BasePart") then p.Anchored = p.Name == "HumanoidRootPart" end end
	m.Parent = workspace
	task.wait()
end
return "built 6 extras"
