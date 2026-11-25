-- AI-Vid V5.4 Locked Reusable Roblox Studio Engine
-- PROTECTED ASSET CREATION (UNTOUCHED):
--   * Engine.buildRig(): Real R6 catalog avatars via CreateHumanoidModelFromDescription (zero block statues, zero nameplates)
--   * Engine.setFace(): Flat 2D decals from assets/faces/classic_v1/ids.json
-- V5.4 UPGRADES:
--   * Character-relative camera presets (front, closeup, wide, ots, reverse_ots, side_track, high_angle, low_hero, prop_insert)
--   * Per-beat FieldOfView (default 50) + real Workspace:Raycast() clearShot occlusion guard
--   * Multi-actor movement & face swaps inside `partners` (`with:`)
--   * `fall` action (full-body face-plant with dust) + scene-cut placement of partners
--   * Story props (`props:`) with per-beat attach/hide/show cues; foot_insert camera
--   * Non-blocking hitstop (no task.wait stall inside RenderStepped) + clean opt-in icon badges
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Engine = {}
Engine.FACE_IDS = {
  neutral    = "rbxassetid://70950815478959",
  scared     = "rbxassetid://94514852927815",
  shocked    = "rbxassetid://103057607693548",
  grin       = "rbxassetid://96253429845051",
  determined = "rbxassetid://109687999939498",
  proud      = "rbxassetid://96477668083717",
}

Engine.STARTER_WARDROBE = {
  boy   = { shirt = 86330417861158, pants = 12671481024,  hair = "98588731108499",  skin = Color3.fromRGB(234, 190, 150) },
  girl  = { shirt = 91467779965025, pants = 13979853518,  hair = "100973074711029", skin = Color3.fromRGB(235, 203, 178) },
  man   = { shirt = 8836645430,     pants = 14262996290,  hair = "140624854156017", skin = Color3.fromRGB(230, 185, 140) },
  woman = { shirt = 85435724220934, pants = 18332980667,  hair = "17890789000",     skin = Color3.fromRGB(240, 200, 160) },
}

local ROLL_90 = CFrame.Angles(0, 0, math.rad(90))
local DEFAULT_GRAVITY = 196.2
local DEFAULT_FOV = 50

-- === PROTECTED ASSET METHODS (UNTOUCHED) ===
function Engine.setFace(model, emotion)
  local head = model and model:FindFirstChild("Head")
  local id = Engine.FACE_IDS[emotion] or Engine.FACE_IDS.neutral
  if not head then return end
  local d = head:FindFirstChild("face") or head:FindFirstChildOfClass("Decal") or Instance.new("Decal", head)
  d.Name = "face"; d.Face = Enum.NormalId.Front; d.Texture = id
end

function Engine.buildRig(spec, parent)
  local gender = assert(spec.gender, "Rig '" .. tostring(spec.name) .. "' must declare gender (boy|girl|man|woman)")
  local base = assert(Engine.STARTER_WARDROBE[gender], "Invalid gender: " .. tostring(gender))
  local d = Instance.new("HumanoidDescription")
  d.Shirt, d.Pants, d.HairAccessory = spec.shirt or base.shirt, spec.pants or base.pants, tostring(spec.hair or base.hair)
  if spec.hat then d.HatAccessory = tostring(spec.hat) end
  if spec.waist then d.WaistAccessory = tostring(spec.waist) end
  if spec.neck then d.NeckAccessory = tostring(spec.neck) end
  local skin = spec.skin or base.skin
  for _, k in ipairs({ "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" }) do d[k] = skin end

  local m = Players:CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R6)
  m.Name = spec.name or "Actor"
  local hrp = m:FindFirstChild("HumanoidRootPart")
  if hrp then m.PrimaryPart = hrp end
  local hum = m:FindFirstChildOfClass("Humanoid")
  if hum then
    hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
    hum.DisplayName = ""
  end
  if spec.scale then m:ScaleTo(spec.scale) end

  local pos = spec.pos or Vector3.new(0, 0, 0)
  m:PivotTo(CFrame.new(pos.X, pos.Y + 5, pos.Z) * CFrame.Angles(0, math.rad(spec.yaw or 0), 0))
  local low = math.huge
  for _, p in ipairs(m:GetChildren()) do
    if p:IsA("BasePart") then low = math.min(low, p.Position.Y - p.Size.Y / 2) end
  end
  local FLOOR_Y = 0.2
  m:PivotTo(m:GetPivot() + Vector3.new(0, pos.Y + FLOOR_Y - low, 0))
  for _, p in ipairs(m:GetDescendants()) do
    if p:IsA("BasePart") then p.Anchored = (p.Name == "HumanoidRootPart") end
  end
  m.Parent = parent or Workspace
  Engine.setFace(m, spec.face or "neutral")
  return m
end

-- === LOCOMOTION & POSING ===
function Engine.registerRig(model)
  local torso = model:FindFirstChild("Torso")
  local joints, baseC0 = {}, {}
  if torso then
    for _, jName in ipairs({ "Right Shoulder", "Left Shoulder", "Right Hip", "Left Hip", "Neck" }) do
      local j = torso:FindFirstChild(jName)
      if j and j:IsA("Motor6D") then joints[jName] = j; baseC0[jName] = j.C0 end
    end
  end
  return { m = model, joints = joints, baseC0 = baseC0, phase = math.random() * 6.28, loco = nil, startCF = model:GetPivot() }
end

function Engine.applyPose(r, action, t, alpha)
  local j, b = r.joints, r.baseC0
  if not j["Right Shoulder"] then return end
  local p = t + r.phase
  for name, m6d in pairs(j) do m6d.C0 = b[name] end

  if action == "walk" or action == "run" then
    local freq = (action == "run") and 12 or 7
    local amp = (action == "run") and 0.85 or 0.7
    local sw = math.sin(p * freq) * amp
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(0, 0, sw)
    j["Left Shoulder"].C0  = b["Left Shoulder"]  * CFrame.Angles(0, 0, sw)
    j["Right Hip"].C0      = b["Right Hip"]      * CFrame.Angles(0, 0, -sw)
    j["Left Hip"].C0       = b["Left Hip"]       * CFrame.Angles(0, 0, -sw)
  elseif action == "wave" then
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(0, 0, math.rad(145) + math.sin(p * 10) * 0.25)
  elseif action == "point" then
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(0, 0, math.rad(90))
  elseif action == "punch" then
    local strike = math.sin(math.clamp(alpha * 2.2, 0, 1) * math.pi)
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(0, 0, math.rad(105) * strike)
    j["Left Shoulder"].C0  = b["Left Shoulder"]  * CFrame.Angles(0, 0, math.rad(-35) * strike)
  elseif action == "block" then
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(math.rad(-25), 0, math.rad(85))
    j["Left Shoulder"].C0  = b["Left Shoulder"]  * CFrame.Angles(math.rad(25), 0, math.rad(-85))
  elseif action == "knockback" then
    local k = math.sin(math.clamp(alpha, 0, 1) * math.pi)
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(0, 0, math.rad(120) * k)
    j["Left Shoulder"].C0  = b["Left Shoulder"]  * CFrame.Angles(0, 0, math.rad(-120) * k)
  elseif action == "floss" then
    local swing = math.sin(p * 8)
    local cross = math.cos(p * 8)
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(0.95 * swing, 0, 0.25 + 0.7 * cross)
    j["Left Shoulder"].C0  = b["Left Shoulder"]  * CFrame.Angles(-0.95 * swing, 0, -0.25 + 0.7 * cross)
    j["Right Hip"].C0      = b["Right Hip"]      * CFrame.Angles(-0.25 * swing, 0, 0.13)
    j["Left Hip"].C0       = b["Left Hip"]       * CFrame.Angles(0.25 * swing, 0, -0.13)
  elseif action == "wrestler_dance" then
    local step = math.sin(p * 6.5)
    local pump = math.max(0, math.sin(p * 13))
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(0.38, 0, 1.75 + 0.62 * step + 0.25 * pump)
    j["Left Shoulder"].C0  = b["Left Shoulder"]  * CFrame.Angles(-0.38, 0, -1.75 + 0.62 * step - 0.25 * pump)
    j["Right Hip"].C0      = b["Right Hip"]      * CFrame.Angles(0.28 * step, 0, -0.55 * math.max(0, step))
    j["Left Hip"].C0       = b["Left Hip"]       * CFrame.Angles(0.28 * step, 0, 0.55 * math.max(0, -step))
  elseif action == "dance" then
    local beat = math.sin(p * 9.5)
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(math.rad(20), 0, math.rad(110) + beat * 0.45)
    j["Left Shoulder"].C0  = b["Left Shoulder"]  * CFrame.Angles(math.rad(-20), 0, math.rad(-110) + beat * 0.45)
    j["Right Hip"].C0      = b["Right Hip"]      * CFrame.Angles(0, 0, beat * 0.25)
    j["Left Hip"].C0       = b["Left Hip"]       * CFrame.Angles(0, 0, -beat * 0.25)
  else
    local br = math.sin(p * 2.2) * 0.05
    j["Right Shoulder"].C0 = b["Right Shoulder"] * CFrame.Angles(0, 0, br)
    j["Left Shoulder"].C0  = b["Left Shoulder"]  * CFrame.Angles(0, 0, -br)
  end
end

-- === CLEAN OPT-IN ICON / TEXT BADGES (No story-specific emoji hacks) ===
local ICON_PRESETS = {
  red_x       = { text = "✖", color = Color3.fromRGB(239, 68, 68),  bg = false },
  green_check = { text = "✓", color = Color3.fromRGB(34, 197, 94),  bg = false },
  ["✅"] = { text = "✓", color = Color3.fromRGB(34, 197, 94), bg = false },
  skull       = { text = "☠", color = Color3.fromRGB(248, 250, 252), bg = false },
  alert       = { text = "!", color = Color3.fromRGB(250, 204, 21), bg = false },
}

function Engine.showBadge(model, text, color)
  local head = model and model:FindFirstChild("Head")
  if not head then return end
  local old = head:FindFirstChild("AIVidBadge")
  if old then old:Destroy() end
  if not text or text == "" then return end

  if text == "dot_red" or text == "🔴" then
    local dot = Instance.new("Part")
    dot.Name = "AIVidBadge"; dot.Shape = Enum.PartType.Ball; dot.Size = Vector3.new(0.72, 0.72, 0.72)
    dot.Material = Enum.Material.Neon; dot.Color = Color3.fromRGB(255, 26, 38)
    dot.CanCollide = false; dot.CanTouch = false; dot.CanQuery = false; dot.CastShadow = false; dot.Massless = true
    dot.CFrame = head.CFrame * CFrame.new(0, 1.6, 0)
    local weld = Instance.new("WeldConstraint", dot); weld.Part0, weld.Part1 = head, dot
    dot.Parent = head
    return
  end

  local bb = Instance.new("BillboardGui", head)
  bb.Name = "AIVidBadge"; bb.Size = UDim2.new(0, 220, 0, 64); bb.StudsOffset = Vector3.new(0, 2.5, 0); bb.AlwaysOnTop = true
  local lbl = Instance.new("TextLabel", bb)
  lbl.Size = UDim2.new(1, 0, 1, 0); lbl.Font = Enum.Font.GothamBlack; lbl.TextScaled = true
  lbl.TextStrokeTransparency = 0.15; lbl.TextStrokeColor3 = Color3.new(0, 0, 0)

  local preset = ICON_PRESETS[text]
  if preset then
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = preset.color
    lbl.Text = preset.text
  else
    lbl.BackgroundColor3 = color or Color3.fromRGB(29, 78, 216)
    lbl.BackgroundTransparency = 0.1
    lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.Text = text
  end
end

function Engine.spawnPropStack(pos, count, color)
  local folder = Workspace:FindFirstChild("AIVidProps") or Instance.new("Folder", Workspace)
  folder.Name = "AIVidProps"
  for i = 1, (count or 4) do
    local p = Instance.new("Part", folder)
    p.Size = Vector3.new(1.8, 0.7, 1.8); p.Anchored = true; p.Material = Enum.Material.Neon
    p.Color = color or Color3.fromRGB(239, 68, 68)
    p.Position = pos + Vector3.new(0, 4.5 + i * 0.9, 0)
  end
end

function Engine.impactFrame(duration)
  local cc = Lighting:FindFirstChild("AIVidImpact") or Instance.new("ColorCorrectionEffect", Lighting)
  cc.Name = "AIVidImpact"; cc.Saturation = -1; cc.Contrast = 2.5; cc.Brightness = 0.25
  task.delay(duration or 0.08, function()
    if cc then cc.Saturation = 0; cc.Contrast = 0; cc.Brightness = 0 end
  end)
end

function Engine.shockwave(pos, color)
  local ring = Instance.new("Part", Workspace)
  ring.Name = "AIVidShockwave"; ring.Shape = Enum.PartType.Ball; ring.Anchored = true; ring.CanCollide = false
  ring.Material = Enum.Material.Neon; ring.Color = color or Color3.fromRGB(56, 189, 248)
  ring.Position = pos; ring.Size = Vector3.new(2, 2, 2); ring.Transparency = 0.25
  task.spawn(function()
    for i = 1, 10 do
      ring.Size = ring.Size + Vector3.new(2.2, 2.2, 2.2); ring.Transparency = 0.25 + i * 0.075; task.wait(0.03)
    end
    ring:Destroy()
  end)
end

function Engine.dustPuff(pos)  -- small ground-level dust ring (shockwave is too big for a body fall)
  local d = Instance.new("Part")
  d.Name = "AIVidDust"; d.Shape = Enum.PartType.Cylinder; d.Anchored = true; d.CanCollide = false; d.CanQuery = false
  d.Material = Enum.Material.SmoothPlastic; d.Color = Color3.fromRGB(170, 145, 115); d.Transparency = 0.35
  d.Size = Vector3.new(0.3, 1.5, 1.5); d.CFrame = CFrame.new(pos.X, 0.35, pos.Z) * CFrame.Angles(0, 0, math.rad(90))
  d.Parent = Workspace
  task.spawn(function()
    for i = 1, 12 do
      d.Size = Vector3.new(0.3, 1.5 + i * 0.35, 1.5 + i * 0.35); d.Transparency = 0.35 + i * 0.054; task.wait(0.03)
    end
    d:Destroy()
  end)
end

function Engine.setAura(model, color, enabled)
  local hrp = model and model:FindFirstChild("HumanoidRootPart")
  if not hrp then return end
  local old = hrp:FindFirstChild("AIVidAura")
  if old then old:Destroy() end
  if not enabled then return end
  local pe = Instance.new("ParticleEmitter", hrp)
  pe.Name = "AIVidAura"; pe.Color = ColorSequence.new(color or Color3.fromRGB(250, 204, 21))
  pe.LightEmission = 1; pe.Rate = 45; pe.Lifetime = NumberRange.new(0.4, 0.7); pe.Speed = NumberRange.new(3, 7)
  pe.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.4), NumberSequenceKeypoint.new(1, 0) })
end

function Engine.applyLighting(preset)
  for _, eff in ipairs(Lighting:GetChildren()) do
    if eff:IsA("BloomEffect") or eff:IsA("SunRaysEffect") then eff.Enabled = false end
  end
  if preset == "day_bright" then Lighting.ClockTime = 16.8; Lighting.Brightness = 2.2; Lighting.ExposureCompensation = -0.15
  elseif preset == "neon_drop" then Lighting.ClockTime = 21.5; Lighting.Brightness = 1.6; Lighting.Ambient = Color3.fromRGB(70, 50, 120)
  elseif preset == "anime_clash" then Lighting.ClockTime = 17.5; Lighting.Brightness = 2.6; Lighting.ExposureCompensation = -0.1
  elseif preset == "dark_mystery" then Lighting.ClockTime = 20.0; Lighting.Brightness = 1.5; Lighting.Ambient = Color3.fromRGB(95, 105, 130)
  end
end

function Engine.resetCamera()
  local cam = Workspace.CurrentCamera
  if cam then cam.CameraType = Enum.CameraType.Custom; cam.FieldOfView = 70 end
  Workspace.Gravity = DEFAULT_GRAVITY
end

-- === V5.4 RAYCAST OCCLUSION GUARD (clearShot) ===
function Engine.clearShot(lookAtPos, camPos, ignoreList)
  local dir = camPos - lookAtPos
  local dist = dir.Magnitude
  if dist < 0.5 then return camPos end
  local params = RaycastParams.new()
  params.FilterType = Enum.RaycastFilterType.Exclude
  params.FilterDescendantsInstances = ignoreList or {}
  local op = OverlapParams.new()
  op.FilterType = Enum.RaycastFilterType.Exclude
  op.FilterDescendantsInstances = ignoreList or {}
  -- torso probe sits 1.5 below the aim point, but never below the floor (low aims would always "hit" the ground)
  local torsoPos = lookAtPos - Vector3.new(0, math.clamp(lookAtPos.Y - 0.6, 0, 1.5), 0)
  -- clear only if BOTH the head ray (lookAt -> cam) and the torso ray (cam -> torso) are unblocked
  local function isClear(camP)
    return not Workspace:Raycast(lookAtPos, camP - lookAtPos, params)
      and not Workspace:Raycast(camP, torsoPos - camP, params)
      and #Workspace:GetPartBoundsInRadius(camP, 0.3, op) == 0
  end
  if isClear(camPos) then return camPos end
  -- 1) yaw swings around lookAtPos at the full distance (same height)
  for _, deg in ipairs({35, -35, 65, -65, 90, -90, 180}) do
    local alt = lookAtPos + CFrame.Angles(0, math.rad(deg), 0):VectorToWorldSpace(dir)
    if isClear(alt) then return alt end
  end
  -- 2) all blocked: pull in in front of the nearest obstruction (head or torso ray)
  local u, near = dir.Unit, dist
  local hitH = Workspace:Raycast(lookAtPos, dir, params)
  local hitT = Workspace:Raycast(camPos, torsoPos - camPos, params)
  if hitH then near = math.min(near, (hitH.Position - lookAtPos):Dot(u)) end
  if hitT then near = math.min(near, (hitT.Position - lookAtPos):Dot(u)) end
  return lookAtPos + u * math.max(near - 0.6, 1.5)
end

-- === V5.4 CHARACTER-RELATIVE CAMERA PRESETS ===
function Engine.computeCamera(targetCF, centerPos, camPreset, motion, alpha, groupWidth, ignoreList, partnerPos)
  -- Use target's facing basis (LookVector / RightVector) so shots rotate WITH the actor!
  local fwd = Vector3.new(targetCF.LookVector.X, 0, targetCF.LookVector.Z)
  if fwd.Magnitude < 0.01 then fwd = Vector3.new(0, 0, -1) else fwd = fwd.Unit end
  local right = Vector3.new(-fwd.Z, 0, fwd.X)
  local up = Vector3.new(0, 1, 0)

  local localOff, lookY, dutch = fwd * 7.2 + up * 1.7, 1.4, 0
  if camPreset == "wide" then
    localOff = fwd * 13.5 + up * 3.8
  elseif camPreset == "closeup" or camPreset == "front" then
    localOff = fwd * 5.2 + up * 1.65
  elseif camPreset == "ots" then
    localOff = fwd * 6.2 + right * 2.8 + up * 2.0
  elseif camPreset == "reverse_ots" then
    localOff = fwd * 6.2 - right * 2.8 + up * 2.0
  elseif camPreset == "side_track" then
    localOff = right * 8.0 + fwd * 1.5 + up * 1.8
  elseif camPreset == "high_angle" then
    localOff = fwd * 8.5 + up * 6.5; lookY = 1.0
  elseif camPreset == "low_hero" then
    localOff = fwd * 6.8 + up * 0.45; dutch = math.rad(2.5)
  elseif camPreset == "prop_insert" then
    localOff = fwd * 4.2 + up * 1.2; lookY = 0.6
  elseif camPreset == "foot_insert" then  -- shoe/floor-level detail shot
    localOff = fwd * 3.4 + right * 0.8 - up * 2.0; lookY = -2.75
  end

  -- base = point the camera offset is measured from; lookPos = point the camera aims at
  local base, lookPos = centerPos, centerPos + Vector3.new(0, lookY, 0)
  local otsPartner = partnerPos and (camPreset == "ots" or camPreset == "reverse_ots")
  if otsPartner then
    -- camera behind the partner's outer shoulder, looking at the subject's face
    local d = Vector3.new(targetCF.Position.X - partnerPos.X, 0, targetCF.Position.Z - partnerPos.Z)
    d = d.Magnitude > 0.05 and d.Unit or fwd
    local side = Vector3.new(-d.Z, 0, d.X) * (camPreset == "ots" and 4.0 or -4.0)
    base = targetCF.Position
    lookPos = targetCF.Position + Vector3.new(0, lookY, 0)
    localOff = (partnerPos - d * 3.4 + side + up * 2.1) - base
  elseif groupWidth then
    localOff = localOff + localOff.Unit * math.max(0, groupWidth - 4.5) * 0.85
  end

  if motion == "push_in" then localOff = localOff * (1.07 - 0.14 * alpha)
  elseif motion == "pull_out" then localOff = localOff * (0.93 + 0.16 * alpha)
  elseif motion == "orbit360" then
    local ang = alpha * math.pi * 1.15
    local rad = Vector3.new(localOff.X, 0, localOff.Z).Magnitude
    localOff = Vector3.new(math.sin(ang) * rad, localOff.Y, math.cos(ang) * rad)
  elseif motion == "shake" then
    local j = (1 - alpha) * 0.30
    localOff = localOff + right * (math.sin(alpha * 48) * j) + up * (math.cos(alpha * 54) * j)
    dutch = math.rad(2.5)
  end

  -- foot_insert skips clearShot: its torso probe would sit below the floor and always "hit" it
  local camPos = (camPreset == "foot_insert") and (base + localOff) or Engine.clearShot(lookPos, base + localOff, ignoreList)
  return CFrame.lookAt(camPos, lookPos) * CFrame.Angles(0, 0, dutch) * ROLL_90
end

-- === STORY PROPS (story.yaml `props:` + per-beat `prop:` cues) ===
-- attach = "Actor/Part" welds the prop to that body part at offset/rot (degrees); hide/show toggle visibility.
local function placeProp(p, cue, rigs)
  local rot = cue.rot and CFrame.Angles(math.rad(cue.rot.X), math.rad(cue.rot.Y), math.rad(cue.rot.Z)) or CFrame.new()
  for _, c in ipairs(p:GetChildren()) do if c:IsA("WeldConstraint") then c:Destroy() end end
  if cue.attach then
    local actor, partName = string.match(cue.attach, "^([^/]+)/(.+)$")
    local r = rigs[actor]
    local bp = r and r.m:FindFirstChild(partName)
    if not bp then warn("[AI-Vid] prop attach target missing: " .. cue.attach); return end
    p.Anchored = false; p.Massless = true
    p.CFrame = bp.CFrame * CFrame.new(cue.offset or Vector3.new()) * rot
    local w = Instance.new("WeldConstraint"); w.Part0, w.Part1 = bp, p; w.Parent = p
  elseif cue.pos then
    p.Anchored = true
    p.CFrame = CFrame.new(cue.pos) * rot
  end
end

function Engine.spawnProps(spec, rigs)
  local name = "Props_" .. spec.id
  local old = Workspace:FindFirstChild(name)
  if old then old:Destroy() end
  local folder = Instance.new("Folder", Workspace); folder.Name = name
  for _, d in ipairs(spec.props or {}) do
    local p = Instance.new("Part")
    p.Name = d.name; p.CanCollide = false; p.CastShadow = true
    if d.shape == "cylinder" then p.Shape = Enum.PartType.Cylinder elseif d.shape == "ball" then p.Shape = Enum.PartType.Ball end
    p.Size = d.size or Vector3.new(1, 1, 1)
    p.Color = d.color or Color3.fromRGB(200, 200, 200)
    p.Material = (d.material and Enum.Material[d.material]) or Enum.Material.Plastic
    p.Parent = folder
    placeProp(p, d, rigs)
    if d.hide then p.Transparency = 1 end
  end
  return folder
end

function Engine.applyPropCue(spec, cue, rigs)
  local folder = Workspace:FindFirstChild("Props_" .. spec.id)
  local p = folder and folder:FindFirstChild(cue.name)
  if not p then return end
  if cue.attach or cue.pos then placeProp(p, cue, rigs) end
  if cue.hide then p.Transparency = 1 elseif cue.show then p.Transparency = 0 end
end

local function moveRigToward(rig, startPos, dest, alpha)
  if not rig or not dest then return end
  local p0 = startPos or rig.m:GetPivot().Position
  local p1 = Vector3.new(dest.X, p0.Y, dest.Z)
  local cur = p0:Lerp(p1, alpha)
  local dir = (p1 - p0)
  if dir.Magnitude > 0.05 then
    rig.m:PivotTo(CFrame.lookAt(cur, cur + dir.Unit))
  end
end

function Engine.compile(spec)
  local runner = {}
  local rigs = {}
  local castFolder

  function runner.setup()
    local bp = Workspace:FindFirstChild("Baseplate"); if bp then bp.Transparency = 1; bp.CanCollide = true end
    if spec.set and _G.AIVidSets and _G.AIVidSets[spec.set] then
      _G.AIVidSets[spec.set]()
    end
    local old = Workspace:FindFirstChild("Cast_" .. spec.id)
    if old then old:Destroy() end
    castFolder = Instance.new("Folder", Workspace)
    castFolder.Name = "Cast_" .. spec.id
    rigs = {}
    for _, c in ipairs(spec.cast or {}) do
      local m = Engine.buildRig(c, castFolder)
      rigs[c.name] = Engine.registerRig(m)
    end
    Engine.spawnProps(spec, rigs)
    Engine.applyLighting(spec.lighting or "day_bright")
    return castFolder
  end

  function runner.play()
    local cam = Workspace.CurrentCamera
    cam.CameraType = Enum.CameraType.Scriptable
    cam.FieldOfView = DEFAULT_FOV
    if not next(rigs) then runner.setup() end
    local tStart = os.clock()
    local lastBeat = 0
    local beatStartPos = {}
    local hitstopUntil = 0

    while true do
      local t = os.clock() - tStart
      if t >= spec.totalDuration then break end
      local active = spec.beats[#spec.beats]
      for _, b in ipairs(spec.beats) do
        if t >= b.t0 and t < (b.t0 + b.dur) then active = b; break end
      end

      for _, r in pairs(rigs) do r.loco = nil end

      local targetRig = rigs[active.target]
      local model = targetRig and targetRig.m
      local alpha = math.clamp((t - active.t0) / math.max(active.dur, 0.05), 0, 1)

      if active.n ~= lastBeat then
        lastBeat = active.n
        cam.FieldOfView = active.fov or ((active.cam == "ots" or active.cam == "reverse_ots") and active.partners and active.partners[1] and 48) or DEFAULT_FOV
        -- scene cuts: snap_to teleports, yaw sets facing (degrees, same convention as cast yaw); target and partners
        local function place(m, at, yaw)
          if not m or (not at and yaw == nil) then return end
          local cf = m:GetPivot()
          local p = at and Vector3.new(at.X, cf.Position.Y, at.Z) or cf.Position
          local rot = (yaw ~= nil) and CFrame.Angles(0, math.rad(yaw), 0) or (cf - cf.Position)
          m:PivotTo(CFrame.new(p) * rot)
        end
        for _, r in pairs(rigs) do  -- stand back up after a `fall` beat
          if r.fallCF then r.m:PivotTo(r.fallCF); r.fallCF = nil end
        end
        place(model, active.snap_to, active.yaw)
        for _, cue in ipairs(active.partners or {}) do
          local pr = rigs[cue.name]
          if pr then place(pr.m, cue.snap_to, cue.yaw) end
        end
        for name, r in pairs(rigs) do beatStartPos[name] = r.m:GetPivot().Position end
        if active.action == "fall" and targetRig then targetRig.fallCF = model:GetPivot(); targetRig.fallDust = false end
        if active.face and active.face ~= "" and model then Engine.setFace(model, active.face) end
        if model then
          if active.clear_badge then Engine.showBadge(model, "")
          elseif active.badge and active.badge ~= "" then Engine.showBadge(model, active.badge)
          end
        end
        if active.partners then
          for _, cue in ipairs(active.partners) do
            local pr = rigs[cue.name]
            if pr and cue.face and cue.face ~= "" then Engine.setFace(pr.m, cue.face) end
          end
        end
        if model and active.face_partner and active.partners and active.partners[1] then
          local partner = rigs[active.partners[1].name]
          if partner then
            local a, b = model:GetPivot().Position, partner.m:GetPivot().Position
            if Vector2.new(a.X - b.X, a.Z - b.Z).Magnitude > 0.05 then
              model:PivotTo(CFrame.lookAt(a, Vector3.new(b.X, a.Y, b.Z)))
              partner.m:PivotTo(CFrame.lookAt(b, Vector3.new(a.X, b.Y, a.Z)))
            end
          end
        end
        if active.props then
          for _, cue in ipairs(active.props) do Engine.applyPropCue(spec, cue, rigs) end
        end
        if active.gravity ~= nil then Workspace.Gravity = active.gravity end
        if active.prop_stack and model then Engine.spawnPropStack(model:GetPivot().Position, active.prop_stack) end
        if active.fx == "impact" and model then Engine.impactFrame(0.08); Engine.shockwave(model:GetPivot().Position)
        elseif active.fx == "hitstop" and model then Engine.impactFrame(0.10); Engine.shockwave(model:GetPivot().Position); hitstopUntil = t + 0.08
        elseif active.fx == "aura_on" and model then Engine.setAura(model, Color3.fromRGB(250, 204, 21), true)
        elseif active.fx == "aura_red" and model then Engine.setAura(model, Color3.fromRGB(239, 68, 68), true)
        elseif active.fx == "neon_flip" then Engine.applyLighting("neon_drop")
        end
      end

      -- Non-blocking hitstop: freezes rig poses briefly without stalling RenderStepped
      local frozenForHitstop = (t < hitstopUntil)
      if not frozenForHitstop then
        if targetRig then
          targetRig.loco = (active.action == "fall") and "knockback" or active.action or "idle"
          moveRigToward(targetRig, beatStartPos[active.target], active.move_to, alpha)
          if active.action == "fall" and targetRig.fallCF then
            -- `fall`: whole body tips forward around the feet (ease-in), lands face-down at ~55% of the beat
            local k = math.clamp(alpha * 1.8, 0, 1)
            local h = targetRig.fallCF.Position.Y - 0.2
            model:PivotTo(targetRig.fallCF * CFrame.new(0, -h, 0) * CFrame.Angles(-(k * k) * math.rad(86), 0, 0) * CFrame.new(0, h, 0))
            if k >= 1 and not targetRig.fallDust then
              targetRig.fallDust = true
              local landing = (targetRig.fallCF * CFrame.new(0, -h + 0.3, -2.5)).Position
              Engine.impactFrame(0.07); Engine.dustPuff(landing)
            end
          end
        end
        if active.partners then
          for _, cue in ipairs(active.partners) do
            local pr = rigs[cue.name]
            if pr then
              pr.loco = cue.action or active.action or "idle"
              moveRigToward(pr, beatStartPos[cue.name], cue.move_to, alpha)
            end
          end
        end
        for _, r in pairs(rigs) do
          Engine.applyPose(r, r.loco or "idle", t, alpha)
        end
      end

      local targetCF = model and model:GetPivot() or CFrame.new(0, 3, 0)
      local pos = targetCF.Position
      local groupWidth
      if model and active.partners then
        local left, rightX, nearZ, farZ = pos.X, pos.X, pos.Z, pos.Z
        for _, cue in ipairs(active.partners) do
          local pr = rigs[cue.name]
          if pr then
            local pp = pr.m:GetPivot().Position
            left, rightX = math.min(left, pp.X), math.max(rightX, pp.X)
            nearZ, farZ = math.min(nearZ, pp.Z), math.max(farZ, pp.Z)
          end
        end
        pos = Vector3.new((left + rightX) / 2, pos.Y, (nearZ + farZ) / 2)
        groupWidth = rightX - left
      end

      local camCF = targetCF
      if active.action == "fall" and targetRig and targetRig.fallCF then
        -- frame the whole fall: aim at the body's midpoint on the ground, oriented by the standing pose
        local h = targetRig.fallCF.Position.Y - 0.2
        camCF = targetRig.fallCF
        pos = (targetRig.fallCF * CFrame.new(0, -h - 0.3, -2.6)).Position
      end
      local ignoreList = castFolder and { castFolder } or {}
      local partnerPos
      if active.partners and active.partners[1] and rigs[active.partners[1].name] then
        partnerPos = rigs[active.partners[1].name].m:GetPivot().Position
      end
      cam.CFrame = Engine.computeCamera(camCF, pos, active.cam, active.motion, alpha, groupWidth, ignoreList, partnerPos)
      RunService.RenderStepped:Wait()
    end
    Engine.resetCamera()
  end
  return runner
end

_G.AIVidCore = Engine
print("[AI-Vid V5.4] core_engine.luau loaded (R6 catalog + relative cameras + clearShot + multi-actor locomotion).")

-- Auto-compiled by pipeline/compile_story.py (V5.4) — do not hand-edit
-- Story 006: You Cut the Wrong Line 😈 | Format: story | Set: street_day
local Engine = _G.AIVidCore
assert(Engine, "Load engines/roblox/core_engine.luau first!")

local SceneSpec = {
  id = "006",
  format = "story",
  set = "street_day",
  lighting = "day_bright",
  totalDuration = 42.040,
  cast = {
  { name = "Leo", gender = "boy", face = "neutral", pos = Vector3.new(20, 0, -4), yaw = 0.0, shirt = 398633584, pants = 144076760, hair = 17877340 },
  { name = "Chad", gender = "boy", face = "grin", pos = Vector3.new(20, 0, -10), yaw = 0.0, scale = 1.20, shirt = 144076358, pants = 398635338, hair = 376524487 },
  { name = "Zoe", gender = "girl", face = "neutral", pos = Vector3.new(20, 0, 4), yaw = 0.0, scale = 0.96, shirt = 91467779965025, pants = 13979853518, hair = 10084548738 },
  { name = "Milo", gender = "boy", face = "neutral", pos = Vector3.new(20, 0, 12), yaw = 0.0, scale = 0.98, shirt = 382538295, pants = 398633812, hair = 98588731108499 },
  { name = "Vendor", gender = "man", face = "neutral", pos = Vector3.new(20, 0, 18), yaw = 0.0, scale = 1.08, shirt = 607785314, pants = 144076760, hair = 62234425 },
  },
  props = {
  { name = "PrizeCrate", shape = "block", material = "Metal", size = Vector3.new(2.00, 1.60, 2.00), pos = Vector3.new(18.20, 2.75, 17.00), color = Color3.fromRGB(225, 180, 45) },
  { name = "SodaCup", shape = "cylinder", material = "SmoothPlastic", attach = "Leo/Right Arm", size = Vector3.new(0.60, 0.80, 0.60), pos = Vector3.new(20.80, 2.50, -4.00), offset = Vector3.new(0.00, -0.80, 0.00), color = Color3.fromRGB(220, 40, 40) },
  },
  beats = {
  { n = 1, t0 = 0.000, dur = 1.685, cam = "closeup", fov = 44, motion = "push_in", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Chad", action = "punch", face = "grin" }} },
  { n = 2, t0 = 1.685, dur = 1.475, cam = "side_track", fov = 48, motion = "push_in", target = "Chad", action = "punch", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "knockback", face = "shocked" }} },
  { n = 3, t0 = 3.160, dur = 2.480, cam = "wide", fov = 54, motion = "static", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", props = {{ name = "SodaCup", hide = true }} },
  { n = 4, t0 = 5.640, dur = 1.980, cam = "side_track", fov = 48, motion = "push_in", target = "Chad", action = "run", move_to = Vector3.new(20.00, 0.00, 0.00), snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Zoe", action = "block", face = "scared" }} },
  { n = 5, t0 = 7.620, dur = 2.100, cam = "closeup", fov = 44, motion = "push_in", target = "Zoe", action = "point", move_to = nil, snap_to = nil, face = "determined", fx = "", badge = "", partners = {{ name = "Chad", action = "idle", face = "grin" }} },
  { n = 6, t0 = 9.720, dur = 1.680, cam = "closeup", fov = 44, motion = "push_in", target = "Chad", action = "wave", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 7, t0 = 11.400, dur = 1.880, cam = "side_track", fov = 48, motion = "push_in", target = "Chad", action = "run", move_to = Vector3.new(20.00, 0.00, 8.00), snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Milo", action = "block", face = "scared" }} },
  { n = 8, t0 = 13.280, dur = 1.840, cam = "closeup", fov = 44, motion = "push_in", target = "Milo", action = "point", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "" },
  { n = 9, t0 = 15.120, dur = 2.260, cam = "wide", fov = 54, motion = "push_in", target = "Chad", action = "point", move_to = Vector3.new(19.00, 0.00, 16.00), snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Vendor", action = "idle", face = "neutral" }} },
  { n = 10, t0 = 17.380, dur = 2.140, cam = "closeup", fov = 44, motion = "push_in", target = "Chad", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "" },
  { n = 11, t0 = 19.520, dur = 2.560, cam = "closeup", fov = 44, motion = "push_in", target = "Vendor", action = "point", move_to = nil, snap_to = nil, face = "neutral", fx = "", badge = "" },
  { n = 12, t0 = 22.080, dur = 1.280, cam = "wide", fov = 54, motion = "static", target = "Chad", action = "dance", move_to = nil, snap_to = nil, face = "proud", fx = "", badge = "", partners = {{ name = "Milo", action = "idle", face = "scared" }, { name = "Zoe", action = "idle", face = "scared" }} },
  { n = 13, t0 = 23.360, dur = 2.960, cam = "side_track", fov = 48, motion = "push_in", target = "Vendor", action = "walk", move_to = Vector3.new(20.00, 0.00, 10.00), snap_to = nil, face = "neutral", fx = "", badge = "", partners = {{ name = "Chad", action = "block", face = "neutral" }} },
  { n = 14, t0 = 26.320, dur = 2.720, cam = "ots", fov = 46, motion = "push_in", target = "Vendor", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "idle", face = "shocked", yaw = 180.0 }} },
  { n = 15, t0 = 29.040, dur = 0.940, cam = "closeup", fov = 44, motion = "push_in", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", yaw = 180.0 },
  { n = 16, t0 = 29.980, dur = 2.800, cam = "wide", fov = 54, motion = "push_in", target = "Vendor", action = "wave", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Leo", action = "idle", face = "proud", yaw = 180.0 }} },
  { n = 17, t0 = 32.780, dur = 1.680, cam = "closeup", fov = 44, motion = "shake", target = "Chad", action = "idle", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "alert" },
  { n = 18, t0 = 34.460, dur = 2.980, cam = "side_track", fov = 48, motion = "push_in", target = "Vendor", action = "point", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "", partners = {{ name = "Chad", action = "knockback", face = "shocked" }} },
  { n = 19, t0 = 37.440, dur = 2.300, cam = "wide", fov = 54, motion = "static", target = "Chad", action = "fall", move_to = nil, snap_to = nil, face = "shocked", fx = "", badge = "", partners = {{ name = "Zoe", action = "point", face = "grin" }, { name = "Milo", action = "point", face = "grin" }} },
  { n = 20, t0 = 39.740, dur = 2.300, cam = "closeup", fov = 42, motion = "static", target = "Leo", action = "idle", move_to = nil, snap_to = nil, face = "grin", fx = "", badge = "green_check", yaw = 180.0 },
  },
}

_G["Story" .. SceneSpec.id] = Engine.compile(SceneSpec)
print(string.format("[AI-Vid V5.4] Story %s ready (set=%s, %.2fs, %d beats)", SceneSpec.id, SceneSpec.set, SceneSpec.totalDuration, #SceneSpec.beats))


_G.Story006 = Engine.compile(SceneSpec)
return string.format("[READY] Story006 compiled: %s", tostring(type(_G.Story006.play) == "function"))
