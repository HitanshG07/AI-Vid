--[[
================================================================================
  MOVIE-GRADE ROBLOX STUDIO CUTSCENE & VFX ENGINE (SUPPORTS ALL 10 STORIES)
================================================================================
  Built for:
  - Official Roblox Studio MCP / LocalScript in StarterPlayerScripts
  - Future Lighting + Bloom + DepthOfField + Atmosphere + Volumetric Beams
  - Off-Center Subtitles ONLY (Lower-Third Y=0.82 or Upper-Third Y=0.16 — NEVER dead-center)
  - Articulated R6/R15 Motor6D Rigs + Face Decal Reactions + Holographic Stat Badges
================================================================================
--]]

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- 1. MOVIE-GRADE CINEMATIC POST-PROCESSING
Lighting.GlobalShadows = true
Lighting.Brightness = 2.4
Lighting.ExposureCompensation = 0.15

local function ensureEffect(className, props)
	local eff = Lighting:FindFirstChildOfClass(className) or Instance.new(className, Lighting)
	for k, v in pairs(props) do
		eff[k] = v
	end
	return eff
end

local atmo = ensureEffect("Atmosphere", {Density = 0.30, Offset = 0.2, Glare = 0.15, Haze = 1.2})
local bloom = ensureEffect("BloomEffect", {Intensity = 1.1, Size = 26, Threshold = 1.75})
local dof = ensureEffect("DepthOfFieldEffect", {FarIntensity = 0.35, FocusDistance = 18, InFocusRadius = 24, NearIntensity = 0.15})
local cc = ensureEffect("ColorCorrectionEffect", {Contrast = 0.14, Saturation = 0.16})

-- 2. OFF-CENTER WORD-BY-WORD SUBTITLE OVERLAY (LOWER-THIRD 0.82 OR UPPER-THIRD 0.16)
local gui = Instance.new("ScreenGui")
gui.Name = "CinemaSubtitlesGui"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = localPlayer:WaitForChild("PlayerGui")

local subLabel = Instance.new("TextLabel")
subLabel.Name = "WordCaption"
subLabel.Size = UDim2.new(0.88, 0, 0, 110)
subLabel.AnchorPoint = Vector2.new(0.5, 0.5)
subLabel.Position = UDim2.new(0.5, 0, 0.82, 0) -- Strictly Lower-Third (or 0.16 for Upper-Third)
subLabel.BackgroundTransparency = 1
subLabel.Font = Enum.Font.GothamBlack
subLabel.RichText = true
subLabel.TextSize = 44
subLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
subLabel.TextWrapped = true
subLabel.Text = ""
subLabel.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 0, 0)
stroke.Thickness = 3.8
stroke.LineJoinMode = Enum.LineJoinMode.Round
stroke.Parent = subLabel

local function setSubtitlePlacement(mode)
	if mode == "UPPER_THIRD" then
		subLabel.Position = UDim2.new(0.5, 0, 0.16, 0)
	else
		subLabel.Position = UDim2.new(0.5, 0, 0.82, 0)
	end
end

-- Helper to attach a glowing Holographic Counter Badge (noctaru.story style)
local function attachHoloCounter(rigTorso, textValue, colorRGB)
	local bg = Instance.new("BillboardGui")
	bg.Name = "HoloCounter"
	bg.Adornee = rigTorso
	bg.Size = UDim2.new(3.2, 0, 1.4, 0)
	bg.StudsOffset = Vector3.new(0, 0.2, -0.85)
	bg.AlwaysOnTop = false
	bg.Parent = rigTorso

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 1, 0)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamBlack
	lbl.TextScaled = true
	lbl.TextColor3 = colorRGB or Color3.fromRGB(56, 235, 255)
	lbl.Text = tostring(textValue)
	lbl.Parent = bg

	local st = Instance.new("UIStroke", lbl)
	st.Thickness = 2.5
	st.Color = Color3.fromRGB(0, 20, 40)
	return lbl
end

return {
	setSubtitlePlacement = setSubtitlePlacement,
	subLabel = subLabel,
	attachHoloCounter = attachHoloCounter,
	Effects = {Atmosphere = atmo, Bloom = bloom, DepthOfField = dof, ColorCorrection = cc},
}
