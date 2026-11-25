-- roblox_look.luau : one-shot "classic Roblox, cinematic" look for AI-Vid sets.
-- Run once via execute_luau (Edit mode). Safe to re-run.
local Lighting = game:GetService("Lighting")

pcall(function() Lighting.Technology = Enum.Technology.Future end) -- not writable from plugin scripts; set manually in Properties if needed
Lighting.ClockTime = 17.3
Lighting.GeographicLatitude = 30
Lighting.Brightness = 2.6
Lighting.Ambient = Color3.fromRGB(92, 78, 70)
Lighting.OutdoorAmbient = Color3.fromRGB(150, 128, 110)
Lighting.ColorShift_Top = Color3.fromRGB(255, 214, 160)
Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
Lighting.EnvironmentDiffuseScale = 0.6
Lighting.EnvironmentSpecularScale = 0.4
Lighting.GlobalShadows = true
Lighting.ShadowSoftness = 0.25
Lighting.ExposureCompensation = 0.1

local function get(class, name)
	local o = Lighting:FindFirstChild(name)
	if o and not o:IsA(class) then o:Destroy() o = nil end
	if not o then o = Instance.new(class) o.Name = name o.Parent = Lighting end
	return o
end

-- one default Roblox sky (a fresh Sky instance uses the stock Roblox skybox)
for _, s in Lighting:GetChildren() do if s:IsA("Sky") then s:Destroy() end end
local sky = Instance.new("Sky") sky.Name = "Sky" sky.SunAngularSize = 14 sky.Parent = Lighting

local atm = get("Atmosphere", "Atmosphere")
atm.Density = 0.28 atm.Offset = 0.1 atm.Haze = 1.2 atm.Glare = 0.6
atm.Color = Color3.fromRGB(255, 214, 170) atm.Decay = Color3.fromRGB(120, 90, 80)

local bloom = get("BloomEffect", "Bloom")
bloom.Intensity = 0.6 bloom.Size = 30 bloom.Threshold = 1.6

local rays = get("SunRaysEffect", "SunRays")
rays.Intensity = 0.06 rays.Spread = 0.7

local grade = get("ColorCorrectionEffect", "Grade")
grade.TintColor = Color3.fromRGB(255, 244, 230) grade.Saturation = 0.08 grade.Contrast = 0.08 grade.Brightness = 0.02
grade.Enabled = true

local dof = get("DepthOfFieldEffect", "DOF")
dof.FocusDistance = 12 dof.InFocusRadius = 6 dof.NearIntensity = 0.3 dof.FarIntensity = 0.35
dof.Enabled = true

-- Normalise set materials to stock Roblox ones (no MaterialVariants / realistic materials).
local OK = {
	[Enum.Material.SmoothPlastic] = true, [Enum.Material.Plastic] = true, [Enum.Material.Wood] = true,
	[Enum.Material.WoodPlanks] = true, [Enum.Material.Neon] = true, [Enum.Material.Glass] = true,
	[Enum.Material.Metal] = true, [Enum.Material.Fabric] = true, [Enum.Material.Brick] = true,
	[Enum.Material.Concrete] = true, [Enum.Material.Marble] = true, [Enum.Material.ForceField] = true,
}
local n = 0
for _, setName in { "Set_ChemLab", "Set_Hallway", "Set_GrandmaRoom" } do
	local set = workspace:FindFirstChild(setName)
	if set then
		for _, p in set:GetDescendants() do
			if p:IsA("BasePart") then
				if p.MaterialVariant ~= "" then p.MaterialVariant = "" n += 1 end
				if not OK[p.Material] then p.Material = Enum.Material.SmoothPlastic n += 1 end
			elseif p:IsA("Texture") then
				p:Destroy() n += 1
			end
		end
	end
end
-- ponytail: MeshParts with SurfaceAppearance are left alone (removing SA turns them grey); swap them out by hand if they look too realistic.
print(("[roblox_look] Future lighting set, %d material fixes"):format(n))
