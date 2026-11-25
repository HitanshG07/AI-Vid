-- texture_keepers.luau : keep every cast member's hair/clothing textures loaded during a take, invisibly.
-- Why: textures of characters not drawn for a while get unloaded; when they cut into a close-up the hair renders
-- WHITE for ~0.4 s (story 001: Kai ~33.9 s, Rosa ~16.8 s). Visible tiny 3D copies fixed it but showed in frame;
-- 97%-transparent copies did not keep textures loaded.
-- Fix (v3, 2026-11-18): draw tiny copies inside a 3x3-pixel ViewportFrame pinned to the far-left edge of the editor
-- viewport. The vertical 9:16 crop removes that edge (~80 px), so the copies are drawn every frame but never recorded.
-- Usage (Studio MCP execute_luau, Edit): run this file's text right before starting the recorder.
local SECONDS = 75
local cast = assert(workspace:FindFirstChild("Cast_003") or workspace:FindFirstChild("Cast_002") or workspace:FindFirstChild("Cast_001"), "Cast missing")
local SG = game:GetService("StarterGui")
local old = SG:FindFirstChild("TextureKeeperGui")
if old then old:Destroy() end
local gui = Instance.new("ScreenGui")
gui.Name = "TextureKeeperGui"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = -100
local vf = Instance.new("ViewportFrame")
vf.Name = "Keepers"
vf.Size = UDim2.fromOffset(3, 3)
vf.Position = UDim2.new(0, 2, 0.5, -1)
vf.BackgroundTransparency = 1
vf.Parent = gui
local vcam = Instance.new("Camera")
vcam.FieldOfView = 70
vcam.Parent = vf
vf.CurrentCamera = vcam
local n = 0
for _, m in cast:GetChildren() do
	if m:IsA("Model") then
		m.Archivable = true
		local c = m:Clone()
		for _, d in c:GetDescendants() do
			if d:IsA("Highlight") or d:IsA("LuaSourceContainer") or d:IsA("BillboardGui") then d:Destroy() end
		end
		for _, p in c:GetDescendants() do
			if p:IsA("BasePart") then p.Anchored = true end
		end
		c:PivotTo(CFrame.new(n * 4, 0, 0))
		c.Parent = vf
		n += 1
	end
end
vcam.CFrame = CFrame.lookAt(Vector3.new(n * 2, 2, 30), Vector3.new(n * 2, 0, 0))
gui.Parent = SG
task.delay(SECONDS, function() if gui.Parent then gui:Destroy() end end)
return ("texture keepers v3: %d rigs in a 3px ViewportFrame at the left edge for %d s"):format(n, SECONDS)
