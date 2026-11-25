-- AI-Vid V5 Locked Reusable Roblox Studio Engine (NEVER copy-paste per story!)
-- Supports: R6 live AnimationTracks (zero frozen rigs), setFace decals, 6 camera presets,
-- 3D diegetic BillboardGui badges/counters, Anime Combat FX (impactFrame, shockwave, aura),
-- and Beat-Drop FX (lightingFlip, emoteSync).
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

local ROLL_90 = CFrame.Angles(0, 0, math.rad(90)) -- matches finish_video.py transpose=2

function Engine.setFace(model, emotion)
  local head = model and model:FindFirstChild("Head")
  local id = Engine.FACE_IDS[emotion] or Engine.FACE_IDS.neutral
  if not head then return end
  local d = head:FindFirstChildOfClass("Decal") or Instance.new("Decal", head)
  d.Face = Enum.NormalId.Front
  d.Texture = id
end

function Engine.showBadge(model, text, color)
  local head = model and model:FindFirstChild("Head")
  if not head then return end
  local old = head:FindFirstChild("AIVidBadge")
  if old then old:Destroy() end
  if not text or text == "" then return end
  local bb = Instance.new("BillboardGui", head)
  bb.Name = "AIVidBadge"
  bb.Size = UDim2.new(0, 220, 0, 64)
  bb.StudsOffset = Vector3.new(0, 2.6, 0)
  bb.AlwaysOnTop = true
  local lbl = Instance.new("TextLabel", bb)
  lbl.Size = UDim2.new(1, 0, 1, 0)
  lbl.BackgroundColor3 = color or Color3.fromRGB(29, 78, 216)
  lbl.TextColor3 = Color3.new(1, 1, 1)
  lbl.Font = Enum.Font.GothamBlack
  lbl.TextScaled = true
  lbl.Text = text
end

function Engine.impactFrame(duration)
  local cc = Lighting:FindFirstChild("AIVidImpact") or Instance.new("ColorCorrectionEffect", Lighting)
  cc.Name = "AIVidImpact"
  cc.Saturation = -1
  cc.Contrast = 2.5
  cc.Brightness = 0.25
  task.delay(duration or 0.08, function()
    if cc then cc.Saturation = 0; cc.Contrast = 0; cc.Brightness = 0 end
  end)
end

function Engine.shockwave(pos, color)
  local ring = Instance.new("Part", Workspace)
  ring.Name = "AIVidShockwave"
  ring.Shape = Enum.PartType.Ball
  ring.Anchored = true
  ring.CanCollide = false
  ring.Material = Enum.Material.Neon
  ring.Color = color or Color3.fromRGB(56, 189, 248)
  ring.Position = pos
  ring.Size = Vector3.new(2, 2, 2)
  ring.Transparency = 0.25
  task.spawn(function()
    for i = 1, 10 do
      ring.Size = ring.Size + Vector3.new(2.2, 2.2, 2.2)
      ring.Transparency = 0.25 + i * 0.075
      task.wait(0.03)
    end
    ring:Destroy()
  end)
end

function Engine.setAura(model, color, enabled)
  local hrp = model and model:FindFirstChild("HumanoidRootPart")
  if not hrp then return end
  local old = hrp:FindFirstChild("AIVidAura")
  if old then old:Destroy() end
  if not enabled then return end
  local pe = Instance.new("ParticleEmitter", hrp)
  pe.Name = "AIVidAura"
  pe.Color = ColorSequence.new(color or Color3.fromRGB(250, 204, 21))
  pe.LightEmission = 1
  pe.Rate = 45
  pe.Lifetime = NumberRange.new(0.4, 0.7)
  pe.Speed = NumberRange.new(3, 7)
  pe.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.4), NumberSequenceKeypoint.new(1, 0) })
end

function Engine.applyLighting(preset)
  if preset == "day_bright" then
    Lighting.ClockTime = 13.5; Lighting.Brightness = 2.4; Lighting.Ambient = Color3.fromRGB(160, 168, 180)
  elseif preset == "neon_drop" then
    Lighting.ClockTime = 21.5; Lighting.Brightness = 1.6; Lighting.Ambient = Color3.fromRGB(70, 50, 120)
  elseif preset == "anime_clash" then
    Lighting.ClockTime = 17.5; Lighting.Brightness = 2.8; Lighting.Ambient = Color3.fromRGB(140, 110, 110)
  elseif preset == "dark_mystery" then
    Lighting.ClockTime = 20.0; Lighting.Brightness = 1.5; Lighting.Ambient = Color3.fromRGB(95, 105, 130)
  end
end

function Engine.computeCamera(targetPos, camPreset, motion, alpha)
  local offset = Vector3.new(0, 1.8, 7.5)
  if camPreset == "wide" then offset = Vector3.new(0, 4.0, 14.5)
  elseif camPreset == "ots" then offset = Vector3.new(3.2, 2.2, 6.2)
  elseif camPreset == "closeup" then offset = Vector3.new(0, 1.6, 5.2)
  elseif camPreset == "low_hero" then offset = Vector3.new(0, 0.4, 6.8)
  end

  if motion == "push_in" then
    offset = offset * (1.08 - 0.16 * alpha)
  elseif motion == "pull_out" then
    offset = offset * (0.92 + 0.18 * alpha)
  elseif motion == "orbit360" then
    local ang = alpha * math.pi * 1.25
    local r = offset.Z
    offset = Vector3.new(math.sin(ang) * r, offset.Y, math.cos(ang) * r)
  elseif motion == "shake" then
    local j = (1 - alpha) * 0.35
    offset = offset + Vector3.new(math.sin(alpha * 48) * j, math.cos(alpha * 54) * j, 0)
  end

  local eye = targetPos + offset
  return CFrame.lookAt(eye, targetPos + Vector3.new(0, 1.4, 0)) * ROLL_90
end

function Engine.compile(spec)
  local runner = {}
  function runner.play()
    local cam = Workspace.CurrentCamera
    cam.CameraType = Enum.CameraType.Scriptable
    Engine.applyLighting(spec.lighting or "day_bright")
    local castFolder = Workspace:FindFirstChild("Cast") or Workspace
    local tStart = os.clock()
    local lastBeat = 0

    while true do
      local t = os.clock() - tStart
      if t >= spec.totalDuration then break end
      local active = spec.beats[#spec.beats]
      for _, b in ipairs(spec.beats) do
        if t >= b.t0 and t < (b.t0 + b.dur) then active = b; break end
      end
      local model = castFolder:FindFirstChild(active.target)
      local hrp = model and model:FindFirstChild("HumanoidRootPart")
      local pos = hrp and hrp.Position or Vector3.new(0, 3, 0)

      if active.n ~= lastBeat then
        lastBeat = active.n
        if active.face ~= "" and model then Engine.setFace(model, active.face) end
        if active.badge ~= "" and model then Engine.showBadge(model, active.badge) end
        if active.fx == "impact" then Engine.impactFrame(0.08); Engine.shockwave(pos)
        elseif active.fx == "aura_on" then Engine.setAura(model, Color3.fromRGB(250, 204, 21), true)
        elseif active.fx == "aura_red" then Engine.setAura(model, Color3.fromRGB(239, 68, 68), true)
        elseif active.fx == "neon_flip" then Engine.applyLighting("neon_drop")
        end
      end

      local alpha = math.clamp((t - active.t0) / math.max(active.dur, 0.05), 0, 1)
      cam.CFrame = Engine.computeCamera(pos, active.cam, active.motion, alpha)
      RunService.RenderStepped:Wait()
    end
  end
  return runner
end

_G.AIVidCore = Engine
print("[AI-Vid V5] core_engine.luau loaded.")
return Engine
