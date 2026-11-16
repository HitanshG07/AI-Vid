-- grandma_room.luau : replaces Set_GrandmaRoom with a classic part-built cozy living room.
-- Same spot: center (200,7,-400), 24x14x24, floor top y≈0.05. Open top (sunlight + camera room).
-- Armchair faces +Z at (200,_, -408.5); story007_cutscene seats Grandma there.
local old = workspace:FindFirstChild("Set_GrandmaRoom")
if old then old:Destroy() end
local room = Instance.new("Model") room.Name = "Set_GrandmaRoom" room.Parent = workspace

local M = Enum.Material
local function rgb(r, g, b) return Color3.fromRGB(r, g, b) end
local function block(name, size, pos, color, mat, extra)
	local p = Instance.new("Part")
	p.Name = name p.Size = size p.Color = color p.Material = mat or M.SmoothPlastic
	p.CFrame = typeof(pos) == "CFrame" and pos or CFrame.new(pos)
	p.Anchored = true p.TopSurface = Enum.SurfaceType.Smooth p.BottomSurface = Enum.SurfaceType.Smooth
	if extra then for k, v in extra do p[k] = v end end
	p.Parent = room
	return p
end
local V = Vector3.new
local X0, Z0 = 200, -400 -- room center; walls at x 188/212, z 412/388
local WALL = rgb(205, 160, 150)   -- dusty rose wallpaper
local WAIN = rgb(120, 78, 48)     -- wood wainscot
local TRIM = rgb(245, 235, 215)

-- floor + baseboard rug
block("Floor", V(24, 1, 24), V(X0, -0.45, Z0), rgb(150, 100, 60), M.WoodPlanks)
block("Rug", V(10, 0.1, 7), V(X0, 0.1, -402), rgb(150, 45, 45), M.Fabric)
block("RugBorder", V(10.6, 0.08, 7.6), V(X0, 0.08, -402), rgb(230, 190, 110), M.Fabric)
for i = -1, 1 do block("RugStripe", V(10, 0.12, 0.35), V(X0, 0.11, -402 + i * 2), rgb(230, 190, 110), M.Fabric) end

-- walls: lower wainscot (0..3.5) + wallpaper (3.5..14) + trim rail
local function wall(name, size, pos)
	local lower = V(size.X, 3.5, size.Z)
	block(name .. "_Wain", lower, V(pos.X, 1.75, pos.Z), WAIN, M.Wood)
	block(name .. "_Paper", V(size.X, 10.5, size.Z), V(pos.X, 8.75, pos.Z), WALL)
	block(name .. "_Rail", V(size.X + (size.X > 1 and 0 or 0.2), 0.3, size.Z + (size.Z > 1 and 0 or 0.2)), V(pos.X, 3.6, pos.Z), TRIM)
end
wall("BackWall", V(24, 14, 1), V(X0, 7, -412.5))
wall("FrontWall", V(24, 14, 1), V(X0, 7, -387.5))
wall("WestWall", V(1, 14, 24), V(187.5, 7, Z0))
-- east wall with a window hole (z -403..-397, y 4..10)
block("East_Wain", V(1, 3.5, 24), V(212.5, 1.75, Z0), WAIN, M.Wood)
block("East_A", V(1, 10.5, 9), V(212.5, 8.75, -407.5), WALL)
block("East_B", V(1, 10.5, 9), V(212.5, 8.75, -392.5), WALL)
block("East_Under", V(1, 0.5, 6), V(212.5, 3.75, Z0), WALL)
block("East_Over", V(1, 4, 6), V(212.5, 12, Z0), WALL)
block("WinGlass", V(0.2, 6, 6), V(212.5, 7, Z0), rgb(200, 230, 255), M.Glass, { Transparency = 0.7, CastShadow = false })
block("WinSill", V(1.6, 0.3, 6.8), V(211.9, 3.95, Z0), TRIM, M.Wood)
block("WinBarV", V(0.3, 6, 0.25), V(212.3, 7, Z0), TRIM, M.Wood)
block("WinBarH", V(0.3, 0.25, 6), V(212.3, 7, Z0), TRIM, M.Wood)
block("CurtainL", V(0.3, 7, 1.4), V(211.6, 7.3, -403.6), rgb(190, 70, 70), M.Fabric)
block("CurtainR", V(0.3, 7, 1.4), V(211.6, 7.3, -396.4), rgb(190, 70, 70), M.Fabric)

-- armchair (faces +Z)
local CH = rgb(110, 140, 95) -- sage fabric
block("Chair_Base", V(4, 1, 3.6), V(X0, 0.5, -408.5), rgb(90, 60, 40), M.Wood)
block("Chair_Seat", V(3.4, 0.9, 3.2), V(X0, 1.45, -408.3), CH, M.Fabric)
block("Chair_Back", V(4, 3.6, 0.9), V(X0, 3.4, -410.1), CH, M.Fabric)
block("Chair_ArmL", V(0.8, 1.4, 3.6), V(X0 - 2.0, 2.0, -408.5), CH, M.Fabric)
block("Chair_ArmR", V(0.8, 1.4, 3.6), V(X0 + 2.0, 2.0, -408.5), CH, M.Fabric)
block("Chair_Cushion", V(1.6, 1.2, 0.5), V(X0, 2.6, -409.5), rgb(235, 200, 120), M.Fabric)
block("Blanket", V(0.1, 1.6, 2.6), V(X0 + 2.42, 1.6, -408.5), rgb(200, 90, 90), M.Fabric)

-- side table + lamp
block("Table_Top", V(2.4, 0.25, 2.4), V(195.5, 2.6, -409), rgb(130, 85, 50), M.Wood)
for _, o in { V(-1, 0, -1), V(1, 0, -1), V(-1, 0, 1), V(1, 0, 1) } do
	block("Table_Leg", V(0.25, 2.5, 0.25), V(195.5 + o.X, 1.25, -409 + o.Z), rgb(110, 70, 40), M.Wood)
end
block("Lamp_Base", V(0.9, 0.25, 0.9), V(195.5, 2.85, -409.4), rgb(200, 170, 90), M.Metal)
block("Lamp_Pole", V(0.2, 2, 0.2), V(195.5, 3.9, -409.4), rgb(200, 170, 90), M.Metal)
local shade = block("Lamp_Shade", V(1.6, 1.2, 1.6), V(195.5, 5.3, -409.4), rgb(255, 225, 170), M.Neon, { Transparency = 0.15, CastShadow = false })
local pl = Instance.new("PointLight") pl.Color = rgb(255, 190, 120) pl.Range = 16 pl.Brightness = 1.6 pl.Shadows = true pl.Parent = shade
block("Teacup", V(0.35, 0.3, 0.35), V(196.3, 2.88, -408.5), rgb(250, 250, 250))
block("SmallFrame", V(0.6, 0.8, 0.1), V(194.8, 3.15, -408.6), rgb(200, 160, 60), M.Wood)

-- picture frames on back wall
local photo = { rgb(140, 180, 220), rgb(230, 190, 140), rgb(170, 210, 150) }
for i, x in { 195, 200.5, 205.5 } do
	local w, h = (i == 2) and 3 or 2.2, (i == 2) and 2.4 or 2.8
	block("Frame" .. i, V(w, h, 0.2), V(x, 8.2 + (i == 2 and 0.6 or 0), -411.9), rgb(170, 120, 50), M.Wood)
	block("Photo" .. i, V(w - 0.5, h - 0.5, 0.05), V(x, 8.2 + (i == 2 and 0.6 or 0), -411.78), photo[i])
end
-- wall clock (classic round, west wall)
local clock = block("WallClock", V(0.2, 2, 2), V(188.1, 9, -400), rgb(250, 248, 240), M.SmoothPlastic, { Shape = Enum.PartType.Cylinder })

-- bookshelf (west wall) with books
block("Shelf", V(1.6, 7, 5), V(188.9, 3.5, -394), rgb(120, 78, 48), M.Wood)
local bookCol = { rgb(180, 60, 60), rgb(60, 100, 170), rgb(220, 180, 70), rgb(80, 140, 90), rgb(150, 90, 160) }
for row = 0, 2 do
	for k = 0, 7 do
		block("Book", V(1, 1.2 + (k % 3) * 0.15, 0.45), V(189.6, 1.4 + row * 2.2, -396.1 + k * 0.55), bookCol[(k + row) % 5 + 1])
	end
	block("ShelfBoard", V(1.4, 0.15, 4.8), V(189.7, 0.7 + row * 2.2, -394), rgb(100, 65, 40), M.Wood)
end

-- knitting basket + yarn by the chair
block("Basket", V(1.4, 0.9, 1.4), V(203.4, 0.45, -407.5), rgb(170, 120, 70), M.Wood)
block("Yarn", V(0.8, 0.8, 0.8), V(203.4, 1.1, -407.5), rgb(220, 120, 160), M.Fabric, { Shape = Enum.PartType.Ball })

-- sofa against front wall for depth
block("Sofa_Base", V(8, 1.6, 3), V(X0, 0.8, -390), rgb(150, 100, 70), M.Fabric)
block("Sofa_Back", V(8, 2.4, 0.9), V(X0, 2.6, -388.6), rgb(150, 100, 70), M.Fabric)

-- ceiling + warm ceiling lamp (no open sky in shots)
block("Ceiling", V(26.2, 0.5, 26.2), V(X0, 14.25, Z0), rgb(245, 236, 222), M.SmoothPlastic)
local cl = Instance.new("Part") cl.Name = "CeilingLamp" cl.Anchored = true cl.Shape = Enum.PartType.Cylinder
cl.Size = V(0.3, 2.2, 2.2) cl.CFrame = CFrame.new(X0, 13.85, Z0) * CFrame.Angles(0, 0, math.rad(90))
cl.Material = M.Neon cl.Color = rgb(255, 236, 200) cl.Parent = room
local pl = Instance.new("PointLight") pl.Range = 22 pl.Brightness = 0.8 pl.Color = rgb(255, 220, 180) pl.Parent = cl

print("[grandma_room] rebuilt Set_GrandmaRoom from classic parts")
