--!nocheck
-- home_002.luau : builds Set_Home002 (story 002 beat 54, MANIFEST B4): Theo's living room, WORLD origin (900, 0, 140).
-- Interior X 890..910, Z 132..148, floor top Y 0.5, ceiling underside Y 12.5. Couch seat top Y 2.1 = footstool top Y 2.1
-- (Theo sits at (900, 144.7) facing -Z with his bandaged feet on the stool at (900, 142.2)); June stands at (902.8, 141.5).
-- Window on the south wall (dusk snow), lamp + ceiling light. Idempotent. Part names avoid the engine SKIP words except "ceiling"
-- (the ground ray ignores the ceiling so the floor is found).
local V, CF = Vector3.new, CFrame.new
local rad = math.rad
local C = Color3.fromRGB
local M = Enum.Material
local old = workspace:FindFirstChild("Set_Home002")
if old then old:Destroy() end
local set = Instance.new("Model")
set.Name = "Set_Home002"
set.Parent = workspace
local function part(name, sz, cf, mat, col, o)
	local p = Instance.new("Part")
	p.Name, p.Size, p.CFrame = name, sz, cf
	p.Material, p.Color, p.Anchored = mat or M.SmoothPlastic, col or C(150, 150, 150), true
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	if o then for k, v in o do p[k] = v end end
	p.Parent = set
	return p
end
local WALL, WHITE = C(201, 162, 126), C(240, 236, 228)
part("Floor", V(22, 0.5, 18), CF(900, 0.25, 140), M.WoodPlanks, C(122, 85, 54))
part("WallS", V(22, 13, 1), CF(900, 6.5, 131.5), M.SmoothPlastic, WALL)
part("WallN", V(22, 13, 1), CF(900, 6.5, 148.5), M.SmoothPlastic, WALL)
part("WallW", V(1, 13, 18), CF(889.5, 6.5, 140), M.SmoothPlastic, WALL)
part("WallE", V(1, 13, 18), CF(910.5, 6.5, 140), M.SmoothPlastic, WALL)
part("Ceiling", V(22, 1, 18), CF(900, 13, 140), M.SmoothPlastic, C(236, 232, 224))
part("WainS", V(20, 3, 0.2), CF(900, 2, 132.1), M.WoodPlanks, WHITE)
part("WainN", V(20, 3, 0.2), CF(900, 2, 147.9), M.WoodPlanks, WHITE)
part("WainW", V(0.2, 3, 16), CF(890.1, 2, 140), M.WoodPlanks, WHITE)
part("WainE", V(0.2, 3, 16), CF(909.9, 2, 140), M.WoodPlanks, WHITE)
-- window (south wall, dusk snow outside)
part("WinPane", V(6, 4.4, 0.2), CF(900, 6.5, 131.9), M.Neon, C(120, 105, 150))
for _, d in { { 6.6, 0.3, 0, 8.8 }, { 6.6, 0.3, 0, 4.2 } } do part("WinFrame", V(d[1], d[2], 0.4), CF(900, d[4], 131.85), M.Wood, WHITE) end
for _, x in { 896.8, 903.2 } do part("WinFrame", V(0.3, 4.9, 0.4), CF(x, 6.5, 131.85), M.Wood, WHITE) end
part("WinBar", V(0.2, 4.4, 0.3), CF(900, 6.5, 131.8), M.Wood, WHITE)
-- couch (seat top 2.1), footstool (top 2.1)
local GREEN = C(63, 107, 74)
part("CouchSeat", V(8, 1.6, 3), CF(900, 1.3, 145), M.Fabric, GREEN)
part("CouchBack", V(8, 3.4, 1), CF(900, 2.2, 146), M.Fabric, GREEN)
part("CouchArmL", V(1, 2.6, 3), CF(896.5, 1.8, 145), M.Fabric, GREEN)
part("CouchArmR", V(1, 2.6, 3), CF(903.5, 1.8, 145), M.Fabric, GREEN)
part("Footstool", V(1.6, 2.4, 2.4), CF(900, 1.3, 142.2) * CFrame.Angles(0, 0, rad(90)), M.Fabric, C(138, 90, 58), { Shape = Enum.PartType.Cylinder })
-- lamp + ceiling light + small rug (off to the side) + wall picture
part("LampPole", V(0.4, 5, 0.4), CF(906.5, 3, 146.3), M.Metal, C(60, 50, 40))
local sh = part("LampShade", V(1.8, 1.3, 1.8), CF(906.5, 6, 146.3), M.Neon, C(255, 215, 160))
local pl = Instance.new("PointLight") pl.Color, pl.Range, pl.Brightness, pl.Parent = C(255, 200, 140), 16, 2, sh
local cl = part("CeilFixture", V(4, 0.3, 1), CF(900, 12.3, 140), M.Neon, C(255, 240, 215))
local cp = Instance.new("PointLight") cp.Color, cp.Range, cp.Brightness, cp.Parent = C(255, 235, 205), 22, 1.4, cl
part("Rug", V(7, 0.06, 5), CF(894, 0.53, 138), M.Fabric, C(130, 70, 62))
part("Picture", V(4, 3, 0.2), CF(893, 7, 147.85), M.Wood, C(90, 65, 45))
part("PictureArt", V(3.4, 2.4, 0.1), CF(893, 7, 147.75), M.SmoothPlastic, C(110, 150, 170))
print("[Set_Home002] built")
return true
