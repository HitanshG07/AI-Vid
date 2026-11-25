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
  boy   = { shirt = 86330417861158, pants = 12671481024,  hair = "98588731108499",  skin = Color3.fromRGB(234, 190, 150), floral = true },
  girl  = { shirt = 91467779965025, pants = 13979853518,  hair = "100973074711029", skin = Color3.fromRGB(235, 203, 178), floral = true },
  -- V6 (owner 2026-11-24): old man starter was a women's outfit ("Beach aesthetic crop top" 8836645430, "denim shorts"
  -- 14262996290, "Long black hair" 140624854156017). Now: 3011081872 "White Shirt with Blue Tie" + 95836268631148
  -- "Men's dark dress pants" + 99108607984694 "Brown Short Wavy Male Hair v1" (SearchCatalog, rendered in Studio).
  man   = { shirt = 3011081872,     pants = 95836268631148, hair = "99108607984694", skin = Color3.fromRGB(230, 185, 140) },
  -- V6 (owner 2026-11-24): clean Mom look via AvatarEditorService:SearchCatalog (Relevance) -- no red cap, no floral swimwear.
  -- 18566797626 "Black Comfy Womens Sweater" + 5408358678 "women jeans" + 4903952621 "Brown Bun Hair"
  -- (white cardigan 10649652893 rejected: rendered as a bare-looking white top)
  woman = { shirt = 18566797626,    pants = 5408358678,   hair = "4903952621",      skin = Color3.fromRGB(240, 200, 160) },
}

-- V6: extra verified catalog outfits per gender (all used before in our cast files / assets/INDEX.md).
-- compile() hands an unused one to each actor that has no explicit shirt, so same-gender actors never match.
Engine.WARDROBE_VARIANTS = {
  boy   = { { shirt = 12329928029,  pants = 134609569320601, hair = "124340390453001" },   -- red puffer + jeans
            { shirt = 139637579996070, pants = 124776138615892, hair = "94946081980224" } },
  girl  = { { shirt = 5688801027,   pants = 6092144716,      hair = "140124368601570" },   -- Girls Hoodie + Jeans
            { shirt = 90274186166468, pants = 14075581338,   hair = "140124368601570", night = true } },  -- pink pajamas (night scenes)
  man   = { { shirt = 2885430411,   pants = 140429444258386, hair = "120646937583722" },   -- Mens Tracksuit
            { shirt = 3568313512,   pants = 12858384874,     hair = "139671521768286" } },  -- Works shirt + cargo
  woman = { { shirt = 14607774494,  pants = 5498774219,      hair = "129421843016867" },   -- maroon half-tucked blouse + Womens Jeans (SearchCatalog 2026-11-24)
            { shirt = 14607776314,  pants = 9163113404,      hair = "121088051328294" } },  -- peach blouse + black pants + brown low ponytail (SearchCatalog 2026-11-24)
}

-- Fills shirt/pants/hair on cast entries without an explicit shirt, skipping any outfit already in the cast.
-- seed (the story id) rotates the option order (story_id % options) so consecutive episodes don't star the same lead look.
function Engine.assignDistinctWardrobes(cast, seed)
  local used = {}
  local floralUsed = false
  local function isFloral(shirt)
    for _, w in pairs(Engine.STARTER_WARDROBE) do if w.shirt == shirt and w.floral then return true end end
    for _, list in pairs(Engine.WARDROBE_VARIANTS) do for _, w in ipairs(list) do if w.shirt == shirt and w.floral then return true end end end
    return false
  end
  for _, c in ipairs(cast) do if c.shirt then used[c.shirt] = true; floralUsed = floralUsed or isFloral(c.shirt) end end
  for _, c in ipairs(cast) do
    if not c.shirt and c.gender and Engine.STARTER_WARDROBE[c.gender] then
      local options = { Engine.STARTER_WARDROBE[c.gender] }
      local night = {}
      for _, v in ipairs(Engine.WARDROBE_VARIANTS[c.gender] or {}) do table.insert(v.night and night or options, v) end
      local k = math.floor(tonumber(seed) or 0) % #options     -- night looks stay last, outside the rotation
      for _ = 1, k do table.insert(options, table.remove(options, 1)) end
      for _, v in ipairs(night) do table.insert(options, v) end
      for _, o in ipairs(options) do
        if not used[o.shirt] and not (o.floral and floralUsed) then  -- one floral print per cast, any gender
          c.shirt, c.pants, c.hair = o.shirt, o.pants, c.hair or o.hair
          used[o.shirt] = true
          floralUsed = floralUsed or (o.floral == true)
          break
        end
      end
      if not c.shirt then
        -- every option is taken: mix one non-floral option's shirt with the next option's pants + hair, so the
        -- overflow actor never clones anyone head to toe (combo count = options^2)
        -- ponytail: mixed outfits can repeat a shirt; add more verified variants when big crowds need them
        local mixes = used.__mix or {}; used.__mix = mixes
        for i, o in ipairs(options) do
          local q = options[(i % #options) + 1]
          local key = tostring(o.shirt) .. "/" .. tostring(q.pants)
          if not o.floral and not mixes[key] then
            c.shirt, c.pants, c.hair = o.shirt, q.pants, c.hair or q.hair
            mixes[key] = true
            break
          end
        end
      end
    end
  end
end

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
  -- V6: RootJoint lives in HumanoidRootPart (drives torso lean / bounce / twist)
  local rj = model:FindFirstChild("HumanoidRootPart") and model.HumanoidRootPart:FindFirstChild("RootJoint")
  if rj and rj:IsA("Motor6D") then joints["RootJoint"] = rj; baseC0["RootJoint"] = rj.C0 end
  return { m = model, joints = joints, baseC0 = baseC0, phase = math.random() * 6.28, loco = nil, startCF = model:GetPivot() }
end

-- V6 full-body acting. Joints: shoulders/hips swing on local Z (forward/back) and X (out to the side);
-- RootJoint and Neck share the R6 basis where local X = pitch (lean / nod) and local Z = yaw (turn).
-- r.lookAt (set by the play loop) turns the head toward the speaker/partner. Ends with a lerp blend (no snapping).
local function ease(x) x = math.clamp(x, 0, 1); return x * x * (3 - 2 * x) end

function Engine.applyPose(r, action, t, alpha)
  local j, b = r.joints, r.baseC0
  if not j["Right Shoulder"] then return end
  local p = t + r.phase
  local prev = {}
  for name, m6d in pairs(j) do prev[name] = m6d.C0; m6d.C0 = b[name] end

  local function set(name, cf) if j[name] then j[name].C0 = b[name] * cf end end
  local lean, bob, twist = 0, 0, 0          -- torso pitch (+ = forward), vertical bounce (studs), torso yaw
  local nod, turn = 0, 0                     -- head pitch / yaw

  if action == "walk" or action == "run" then
    local run = (action == "run")
    local freq, amp = run and 12 or 7, run and 0.85 or 0.7
    local sw = math.sin(p * freq) * amp
    set("Right Shoulder", CFrame.Angles(0, 0, sw))
    set("Left Shoulder",  CFrame.Angles(0, 0, sw))
    set("Right Hip",      CFrame.Angles(0, 0, -sw))
    set("Left Hip",       CFrame.Angles(0, 0, -sw))
    lean = run and 0.16 or 0.05
    bob = math.abs(math.sin(p * freq)) * (run and 0.18 or 0.08)
    twist = math.sin(p * freq) * (run and 0.10 or 0.06)
  elseif action == "talk" then
    -- conversational beat gestures: alternating hands rise and open, small torso and head emphasis
    local g = math.sin(p * 4.6)
    local g2 = math.sin(p * 3.1 + 1.3)
    set("Right Shoulder", CFrame.Angles(0.15, 0, math.rad(38) + g * 0.32))
    set("Left Shoulder",  CFrame.Angles(-0.12, 0, math.rad(-22) + g2 * 0.22))
    lean = 0.05 + math.max(0, g) * 0.05
    nod = math.sin(p * 9.2) * 0.06
    twist = g2 * 0.07
  elseif action == "slam_desk" then
    -- wind-up (both arms high, lean back) -> slam (arms drive down-forward, torso pitches in) -> hold on the desk
    local up, down = ease(alpha / 0.35), ease((alpha - 0.35) / 0.15)
    local arm = math.rad(150) * up * (1 - down) + math.rad(62) * down
    set("Right Shoulder", CFrame.Angles(0, 0, arm))
    set("Left Shoulder",  CFrame.Angles(0, 0, -arm))
    lean = -0.08 * up * (1 - down) + 0.21 * down   -- RootJoint tilts the whole R6 body; >0.25 reads as falling
    nod = 0.30 * down
    bob = -0.10 * down
  elseif action == "recoil" then
    -- startled: snap back fast, arms up and out, then settle a little
    local k = ease(alpha / 0.18) * (1 - 0.25 * ease((alpha - 0.5) / 0.5))
    set("Right Shoulder", CFrame.Angles(-0.35 * k, 0, math.rad(115) * k))
    set("Left Shoulder",  CFrame.Angles(0.35 * k, 0, math.rad(-115) * k))
    lean = -0.30 * k
    nod = -0.18 * k
    bob = 0.05 * k
  elseif action == "cheer" then
    -- both arms up, pumping on the beat
    local pump = math.sin(p * 9)
    set("Right Shoulder", CFrame.Angles(0.2, 0, math.rad(150) + pump * 0.3))
    set("Left Shoulder",  CFrame.Angles(-0.2, 0, math.rad(-150) - pump * 0.3))
    bob = math.abs(pump) * 0.12; nod = -0.12
  elseif action == "downed" then
    -- lying face-down (the play loop tips the whole body); limbs slack, slow shallow breathing
    -- face-down, "forward" swings point INTO the floor: rest the limbs slightly back so hands/feet lie on it
    set("Right Shoulder", CFrame.Angles(0, 0, math.rad(-10)))
    set("Left Shoulder",  CFrame.Angles(0, 0, math.rad(10)))
    set("Right Hip",      CFrame.Angles(0, 0, -0.06))
    set("Left Hip",       CFrame.Angles(0, 0, 0.06))
    nod = -0.25 + math.sin(p * 1.6) * 0.02
  elseif action == "wave" then
    set("Right Shoulder", CFrame.Angles(0, 0, math.rad(145) + math.sin(p * 10) * 0.25))
    twist = 0.08; nod = math.sin(p * 5) * 0.05
  elseif action == "point" then
    set("Right Shoulder", CFrame.Angles(0, 0, math.rad(90)))
    lean = 0.08; twist = 0.12
  elseif action == "punch" then
    local strike = math.sin(math.clamp(alpha * 2.2, 0, 1) * math.pi)
    set("Right Shoulder", CFrame.Angles(0, 0, math.rad(105) * strike))
    set("Left Shoulder",  CFrame.Angles(0, 0, math.rad(-35) * strike))
    lean = 0.22 * strike; twist = 0.35 * strike
  elseif action == "block" then
    set("Right Shoulder", CFrame.Angles(math.rad(-25), 0, math.rad(85)))
    set("Left Shoulder",  CFrame.Angles(math.rad(25), 0, math.rad(-85)))
    lean = -0.10; nod = 0.15
  elseif action == "knockback" then
    local k = math.sin(math.clamp(alpha, 0, 1) * math.pi)
    set("Right Shoulder", CFrame.Angles(0, 0, math.rad(120) * k))
    set("Left Shoulder",  CFrame.Angles(0, 0, math.rad(-120) * k))
    lean = -0.35 * k; nod = -0.2 * k
  elseif action == "floss" then
    local swing, cross = math.sin(p * 8), math.cos(p * 8)
    set("Right Shoulder", CFrame.Angles(0.95 * swing, 0, 0.25 + 0.7 * cross))
    set("Left Shoulder",  CFrame.Angles(-0.95 * swing, 0, -0.25 + 0.7 * cross))
    set("Right Hip",      CFrame.Angles(-0.25 * swing, 0, 0.13))
    set("Left Hip",       CFrame.Angles(0.25 * swing, 0, -0.13))
    twist = 0.15 * swing
  elseif action == "wrestler_dance" then
    local step, pump = math.sin(p * 6.5), math.max(0, math.sin(p * 13))
    set("Right Shoulder", CFrame.Angles(0.38, 0, 1.75 + 0.62 * step + 0.25 * pump))
    set("Left Shoulder",  CFrame.Angles(-0.38, 0, -1.75 + 0.62 * step - 0.25 * pump))
    set("Right Hip",      CFrame.Angles(0.28 * step, 0, -0.55 * math.max(0, step)))
    set("Left Hip",       CFrame.Angles(0.28 * step, 0, 0.55 * math.max(0, -step)))
    bob = 0.12 * pump
  elseif action == "dance" then
    local beat = math.sin(p * 9.5)
    set("Right Shoulder", CFrame.Angles(math.rad(20), 0, math.rad(110) + beat * 0.45))
    set("Left Shoulder",  CFrame.Angles(math.rad(-20), 0, math.rad(-110) + beat * 0.45))
    set("Right Hip",      CFrame.Angles(0, 0, beat * 0.25))
    set("Left Hip",       CFrame.Angles(0, 0, -beat * 0.25))
    bob = math.abs(beat) * 0.15; twist = beat * 0.12
  elseif action == "sit" then
    -- seated (the play loop pins the body on the seat): thighs forward, hands resting on the knees
    set("Right Hip",      CFrame.Angles(0, 0, math.rad(90)))
    set("Left Hip",       CFrame.Angles(0, 0, math.rad(-90)))
    set("Right Shoulder", CFrame.Angles(0, 0, math.rad(28)))
    set("Left Shoulder",  CFrame.Angles(0, 0, math.rad(-28)))
    nod = math.sin(p * 2.2) * 0.03
  elseif action == "kick" then
    -- wind-up, right leg swings forward (peak ~35% of the beat = the moment Engine.kickShake rattles the prop)
    local k = math.sin(math.clamp(alpha * 1.45, 0, 1) * math.pi)
    set("Right Hip",      CFrame.Angles(0, 0, math.rad(95) * k))
    set("Left Hip",       CFrame.Angles(0, 0, math.rad(-8) * k))
    set("Right Shoulder", CFrame.Angles(0, 0, math.rad(-35) * k))
    set("Left Shoulder",  CFrame.Angles(0, 0, math.rad(35) * k))
    lean = -0.16 * k
  else
    -- idle: breathing in shoulders + chest, slow weight shift
    local br = math.sin(p * 2.2) * 0.05
    set("Right Shoulder", CFrame.Angles(0, 0, br))
    set("Left Shoulder",  CFrame.Angles(0, 0, -br))
    lean = math.sin(p * 2.2) * 0.02
    twist = math.sin(p * 0.7) * 0.04
    nod = math.sin(p * 2.2) * 0.035
  end

  -- head tracking: turn toward r.lookAt (speaker / partner), clamped so the neck never over-rotates
  if r.lookAt then
    local d = r.m:GetPivot():PointToObjectSpace(r.lookAt)
    if Vector2.new(d.X, d.Z).Magnitude > 0.5 then
      turn = math.clamp(math.atan2(-d.X, -d.Z), -0.9, 0.9)
    end
  end
  set("Neck", CFrame.Angles(nod, 0, -turn))
  set("RootJoint", CFrame.new(0, 0, bob) * CFrame.Angles(lean, 0, -(twist + turn * 0.25)))

  local BLEND = 0.35  -- ease each joint toward this frame's target (~3 frames to settle at 30 fps)
  for name, m6d in pairs(j) do
    m6d.C0 = prev[name]:Lerp(m6d.C0, BLEND)
  end
end

-- V6: body lying face-down, tipped around the feet from a standing pivot (k = 0 standing .. 1 on the ground)
function Engine.floorY(pos, ignore)
  local params = RaycastParams.new()
  params.FilterType = Enum.RaycastFilterType.Exclude
  params.FilterDescendantsInstances = ignore or {}
  local hit = Workspace:Raycast(Vector3.new(pos.X, pos.Y + 2, pos.Z), Vector3.new(0, -12, 0), params)
  return hit and hit.Position.Y or 0.2
end

-- tips around the feet on the real floor under the actor (sidewalk 0.5, road 0.2, stage 1.4 ...)
function Engine.lyingCF(standCF, k, ignore)
  local h = standCF.Position.Y - Engine.floorY(standCF.Position, ignore)
  -- tipping around the feet leaves the torso centre only h*cos(86deg) ~ 0.2 above the floor, i.e. the 1-stud-thick body
  -- half sunk into it; lift it as it tips so it lands resting ON the floor (stage / sidewalk / yard alike)
  local lift = math.max(0, 0.55 - h * math.cos(math.rad(86))) * (k * k)
  return (standCF * CFrame.new(0, -h, 0) * CFrame.Angles(-(k * k) * math.rad(86), 0, 0) * CFrame.new(0, h, 0)) + Vector3.new(0, lift, 0)
end

-- V6 shove travel: `fall` / `knockback` with move_to launches the actor to move_to over the first 0.6 s of the
-- beat (ease-out slide + small hop), keeping their facing. Returns the standing CFrame on the floor and the hop.
local LAUNCH_SEC, LAUNCH_HOP = 0.6, 1.3
function Engine.launchStep(r, tb, ignore)
  local from, to = r.launchFrom, r.launchTo
  local k = math.clamp(tb / LAUNCH_SEC, 0, 1)
  local e = 1 - (1 - k) * (1 - k)
  local flat = Vector3.new(from.X, 0, from.Z):Lerp(Vector3.new(to.X, 0, to.Z), e)
  local f0 = r.launchFloor0 or Engine.floorY(from.Position, ignore)
  r.launchFloor0 = f0
  local f1 = Engine.floorY(Vector3.new(flat.X, from.Y, flat.Z), ignore)
  local base = CFrame.new(flat.X, from.Y + (f1 - f0), flat.Z) * (from - from.Position)
  return base, math.sin(math.pi * k) * LAUNCH_HOP
end

-- V6: actor-to-actor separation. Two actors sent to the same spot stop side by side instead of merging.
-- Each actor moves half the overlap (the other one moves the other half on its own turn).
local MIN_ACTOR_DIST = 3.8   -- V6.2.2: >= 3.5 so two overhead counter signs on a shared spot never stack
function Engine.separate(r, rigs)
  local p = r.m:GetPivot().Position
  local push = Vector3.zero
  for _, o in pairs(rigs) do
    if o ~= r and not (o.fallCF or o.down) then
      local q = o.m:GetPivot().Position
      local d = Vector3.new(p.X - q.X, 0, p.Z - q.Z)
      local dist = d.Magnitude
      if dist < MIN_ACTOR_DIST then
        -- exactly on top of each other: split along the actor's own right vector, opposite ways by name
        local dir = dist > 0.05 and d.Unit or (r.m:GetPivot().RightVector * ((r.m.Name < o.m.Name) and 1 or -1))
        push = push + Vector3.new(dir.X, 0, dir.Z) * ((MIN_ACTOR_DIST - dist) / 2)
      end
    end
  end
  if push.Magnitude > 0.01 then r.m:PivotTo(r.m:GetPivot() + push) end
end

-- V6.2.2: if a ~1.2-stud box at the lens overlaps set geometry, step the lens toward `aim` (0.5 studs a step,
-- never closer than 2.5) until clear. Same orientation, so the framing only tightens.
local CAM_BOX = Vector3.new(1.2, 1.2, 1.2)
function Engine.unclipCamera(cf, aim, ignore)
  local op = OverlapParams.new(); op.FilterType = Enum.RaycastFilterType.Exclude; op.FilterDescendantsInstances = ignore or {}
  local p = cf.Position
  local d = aim - p
  for _ = 1, 40 do
    local hit = false
    for _, part in ipairs(Workspace:GetPartBoundsInBox(CFrame.new(p), CAM_BOX, op)) do
      -- floor slabs under the lens (top below the lens) are not "inside"
      if part.Transparency < 0.95 and part.Position.Y + part.Size.Y * 0.5 > p.Y then hit = true; break end
    end
    if not hit or (aim - p).Magnitude <= 2.5 then break end
    p = p + d.Unit * 0.5
  end
  return CFrame.new(p) * cf.Rotation
end

-- V6: consecutive beats carrying the same fx form one event; returns (first beat dur, total dur)
function Engine.fxSpan(spec, active, fx)
  local idx, total = 1, 0
  for i, bb in ipairs(spec.beats) do if bb == active then idx = i end end
  for i = idx, #spec.beats do
    if spec.beats[i].fx ~= fx then break end
    total = total + spec.beats[i].dur
  end
  return active.dur, total
end

-- V6 fx `ball_swish`: an orange basketball flies in at the target's face (arrives at the end of the first beat),
-- deflects up off the rim, then drops through the net and bounces on the court.
local function bez(a, c, b, u) return a:Lerp(c, u):Lerp(c:Lerp(b, u), u) end
function Engine.ballSwish(model, hitAt, total)
  local set = Workspace:FindFirstChild("Set_SchoolYard")
  local rimC, n = Vector3.zero, 0
  for _, d in ipairs(set and set:GetChildren() or {}) do
    if d.Name == "BasketRim" then rimC = rimC + d.Position; n = n + 1 end
  end
  if n == 0 then warn("[AI-Vid] ball_swish: no Set_SchoolYard.BasketRim"); return end
  rimC = rimC / n
  local ball = Instance.new("Part"); ball.Name = "FxBasketball"; ball.Shape = Enum.PartType.Ball
  ball.Size = Vector3.new(1.1, 1.1, 1.1); ball.Color = Color3.fromRGB(232, 110, 30); ball.Material = Enum.Material.Leather
  ball.Anchored = true; ball.CanCollide = false; ball.CanQuery = false; ball.Parent = Workspace
  local cf = model:GetPivot()
  local face = cf.Position + Vector3.new(0, 1.6, 0) + cf.LookVector * 0.9
  local spawn = face + cf.LookVector * 14 + cf.RightVector * 6 + Vector3.new(0, 4, 0)
  local toRim = (Vector3.new(rimC.X, 0, rimC.Z) - Vector3.new(face.X, 0, face.Z)).Unit
  local rimHit = rimC - toRim * 0.6 + Vector3.new(0, 0.2, 0)            -- front of the rim
  local above, below = rimC + Vector3.new(0, 1.8, 0), rimC - Vector3.new(0, 1.5, 0)
  local floor = Vector3.new(rimC.X + 1.2, 0.75, rimC.Z + 1.5)
  local rest = math.max(total - hitAt, 1.0)
  task.spawn(function()
    local t0 = os.clock()
    while true do
      local t = os.clock() - t0
      local pos
      if t < hitAt then                                                  -- in at the (live) face
        local now = model:GetPivot()
        face = now.Position + Vector3.new(0, 1.6, 0) + now.LookVector * 0.9
        pos = bez(spawn, (spawn + face) / 2 + Vector3.new(0, 2, 0), face, t / hitAt)
        toRim = (Vector3.new(rimC.X, 0, rimC.Z) - Vector3.new(face.X, 0, face.Z)).Unit
        rimHit = rimC - toRim * 0.6 + Vector3.new(0, 0.2, 0)
      else
        local u = (t - hitAt) / rest
        if u < 0.40 then pos = bez(face, (face + rimHit) / 2 + Vector3.new(0, 4.5, 0), rimHit, u / 0.40)
        elseif u < 0.62 then pos = bez(rimHit, rimHit + Vector3.new(0, 2.2, 0), above, (u - 0.40) / 0.22)   -- deflect up
        elseif u < 0.80 then pos = above:Lerp(below, ((u - 0.62) / 0.18) ^ 2)                              -- swish
        elseif u < 1.0 then pos = bez(below, (below + floor) / 2 + Vector3.new(0, 0.8, 0), floor, (u - 0.80) / 0.20)
        else break end
      end
      ball.CFrame = CFrame.new(pos) * CFrame.Angles(t * 9, t * 4, 0)
      task.wait()
    end
    task.wait(0.6); ball:Destroy()
  end)
end

-- V6 fx `crowd_cheer`: 5 background R6 students jump and cheer near the school entrance (EntryWalk) for the span.
-- Built in setup() (avatar loading yields ~1 s, which would freeze frames mid-take) and kept out of Workspace;
-- the fx only parents them in and animates. They stay standing after the span until the next setup().
Engine._crowds = {}
function Engine.prepareCrowd(spec)
  local name = "Crowd_" .. spec.id
  local folder = Instance.new("Folder"); folder.Name = name
  local set = Workspace:FindFirstChild("Set_SchoolYard")
  local walk = set and set:FindFirstChild("EntryWalk")
  local anchor = walk and Vector3.new(walk.Position.X, 0, walk.Position.Z - 3) or Vector3.new(-14, 0, -18)
  local specs, used = {}, {}
  for _, c in ipairs(spec.cast or {}) do table.insert(used, { shirt = c.shirt, gender = c.gender }) end
  local genders = { "boy", "girl", "boy", "girl", "boy" }
  for i, g in ipairs(genders) do
    local x = anchor.X + (i - 3) * 2.9
    table.insert(specs, { name = "Cheer" .. i, gender = g, face = "grin", yaw = 180,
      pos = Vector3.new(x, 0, anchor.Z - math.abs(i - 3) * 0.8) })
  end
  local all = {}; for _, u in ipairs(used) do table.insert(all, u) end
  for _, c in ipairs(specs) do table.insert(all, c) end
  Engine.assignDistinctWardrobes(all, spec.wardrobe_seed or spec.id) -- ponytail: >3 per gender (cast + crowd) reuse the starter look
  local rigs = {}
  for _, c in ipairs(specs) do
    local m = Engine.buildRig(c, folder)
    for _, bp in ipairs(m:GetDescendants()) do if bp:IsA("BasePart") then bp.CanCollide = false end end
    table.insert(rigs, { r = Engine.registerRig(m), base = m:GetPivot() })
  end
  Engine._crowds[spec.id] = { folder = folder, rigs = rigs }
end

function Engine.crowdCheer(spec, total)
  local c = Engine._crowds[spec.id]
  if not c then Engine.prepareCrowd(spec); c = Engine._crowds[spec.id] end
  if c.folder.Parent == Workspace then return end
  c.folder.Parent = Workspace
  local rigs = c.rigs
  task.spawn(function()
    local t0 = os.clock()
    while os.clock() - t0 < total do
      local t = os.clock() - t0
      for i, e in ipairs(rigs) do
        local hop = math.max(0, math.sin(t * 7 + i * 1.3)) * 0.9
        e.r.m:PivotTo(e.base + Vector3.new(0, hop, 0))
        Engine.applyPose(e.r, "cheer", t, 0)
      end
      task.wait()
    end
    for _, e in ipairs(rigs) do e.r.m:PivotTo(e.base) end
  end)
end

-- V6 fx `truck_pass`: Set_StreetDay.StreetTruck drives down the road (along +Z) through the target's X,
-- reaching the target after `hitAt` seconds, keeps going for the rest of `total`, then parks again.
function Engine.truckPass(targetPos, hitAt, total)
  local set = Workspace:FindFirstChild("Set_StreetDay")
  local truck = set and set:FindFirstChild("StreetTruck")
  if not truck then warn("[AI-Vid] truck_pass: no Set_StreetDay.StreetTruck"); return end
  Engine.truck, Engine.truckBusy = truck, true
  local parked = truck:GetPivot()
  local SPEED = 40                                   -- studs/s (fast enough to read as dangerous)
  local frontHalf = truck:GetExtentsSize().Z / 2
  local startZ = targetPos.Z - SPEED * hitAt - frontHalf
  local y = parked.Position.Y
  task.spawn(function()
    local t0 = os.clock()
    while os.clock() - t0 < total + 1.0 do
      local z = startZ + SPEED * (os.clock() - t0)
      truck:PivotTo(CFrame.new(targetPos.X, y, z))   -- built facing +Z
      task.wait()
    end
    truck:PivotTo(parked)
    Engine.truckBusy = false
  end)
end

-- V6: keep actors out of desks, beds, walls. XZ push-out from every set part the body overlaps,
-- ignoring floors/rugs (top below knee height) and anything overhead (lamps, ceiling).
local PUSH_R = 1.1                         -- half body width (R6 torso 2 studs) + a little air
function Engine.pushOut(r, ignore)
  local hrp = r.m.PrimaryPart
  if not hrp then return end
  local p = hrp.Position
  -- V6.2.2: root height above the feet shrinks with scale; a fixed 3 made the ground slab a "wall" for tiny Rex
  -- and pushed him out the yard's back edge (z 46.6)
  local feetY = p.Y - 3 * (r.scale or 1)
  local op = OverlapParams.new()
  op.FilterType = Enum.RaycastFilterType.Exclude
  op.FilterDescendantsInstances = ignore or { r.m }
  for _ = 1, 3 do -- largest push per pass (summing desk + legs + keyboard overshot); 3 passes settle corners
  p = hrp.Position
  local push = Vector3.zero
  for _, part in ipairs(Workspace:GetPartBoundsInBox(CFrame.new(p), Vector3.new(PUSH_R * 2, 5, PUSH_R * 2), op)) do
    local top, bottom = part.Position.Y + part.Size.Y / 2, part.Position.Y - part.Size.Y / 2
    if part.CanCollide and part.Transparency < 1 and top > feetY + 0.9 and bottom < p.Y + 1.5 then
      local lp = part.CFrame:PointToObjectSpace(p)
      local hx, hz = part.Size.X / 2, part.Size.Z / 2
      local cx, cz = math.clamp(lp.X, -hx, hx), math.clamp(lp.Z, -hz, hz)
      local dx, dz = lp.X - cx, lp.Z - cz
      local dist = math.sqrt(dx * dx + dz * dz)
      local localPush
      if dist < 1e-3 then -- centre inside the part: leave by the shallowest side
        local ox, oz = hx - math.abs(lp.X), hz - math.abs(lp.Z)
        if ox < oz then localPush = Vector3.new((lp.X >= 0 and 1 or -1) * (ox + PUSH_R), 0, 0)
        else localPush = Vector3.new(0, 0, (lp.Z >= 0 and 1 or -1) * (oz + PUSH_R)) end
      elseif dist < PUSH_R then
        localPush = Vector3.new(dx, 0, dz) / dist * (PUSH_R - dist)
      end
      if localPush then
        local w = part.CFrame:VectorToWorldSpace(localPush)
        w = Vector3.new(w.X, 0, w.Z)
        if w.Magnitude > push.Magnitude then push = w end
      end
    end
  end
  if push.Magnitude <= 0.01 then return end
  r.m:PivotTo(r.m:GetPivot() + push)
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

-- V6 fx `light_flash_red`: every CeilingLamp in the set pulses red (part + its PointLight) for the beat, then restores.
function Engine.lightFlashRed(duration)
  local lamps = {}
  for _, d in ipairs(Workspace:GetDescendants()) do
    if d:IsA("BasePart") and d.Name == "CeilingLamp" then
      local light = d:FindFirstChildOfClass("PointLight")
      table.insert(lamps, { part = d, color = d.Color, light = light,
        lcolor = light and light.Color, lbright = light and light.Brightness })
    end
  end
  local red = Color3.fromRGB(255, 40, 40)
  task.spawn(function()
    local t0, dur = os.clock(), math.max(0.6, duration or 1.2)
    while os.clock() - t0 < dur do
      local on = math.floor((os.clock() - t0) / 0.18) % 2 == 0   -- ~2.8 pulses per second
      for _, l in ipairs(lamps) do
        l.part.Color = on and red or l.color
        if l.light then l.light.Color = on and red or l.lcolor; l.light.Brightness = on and 3.2 or l.lbright end
      end
      task.wait()
    end
    for _, l in ipairs(lamps) do
      l.part.Color = l.color
      if l.light then l.light.Color = l.lcolor; l.light.Brightness = l.lbright end
    end
  end)
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
    if eff:IsA("BloomEffect") then  -- even if re-enabled later: skin/clothes must never bloom to pure white
      eff.Intensity = math.min(eff.Intensity, 0.15); eff.Threshold = math.max(eff.Threshold, 1.8)
    end
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
function Engine.clearShot(lookAtPos, camPos, ignoreList, actors, sticky, faceDir, facePos)
  local dir = camPos - lookAtPos
  local dist = dir.Magnitude
  if dist < 0.5 then return camPos end
  -- V6 actor occlusion: `actors` = every cast model except the shot's target (face shots only). The target's face
  -- must have a clear line to the lens and no actor may sit within 2.5 studs of the camera.
  local ap, aop
  if actors and #actors > 0 then
    ap = RaycastParams.new(); ap.FilterType = Enum.RaycastFilterType.Include; ap.FilterDescendantsInstances = actors
    aop = OverlapParams.new(); aop.FilterType = Enum.RaycastFilterType.Include; aop.FilterDescendantsInstances = actors
  end
  local ACTOR_LENS_GAP = 3.0   -- 2.5 still let a foreground torso fill a third of a closeup
  -- actor checks run from the TARGET's real head, not the aim point: with `with:` partners the camera aims at the
  -- group midpoint, and rays from there slipped past a partner standing right in front of the target (009 beat 16)
  local face = facePos or lookAtPos
  local chestPos = face - Vector3.new(0, math.clamp(face.Y - 0.6, 0, 1.3), 0)
  local function faceVisible(camP)    -- face AND chest must be unobstructed by other actors
    return not ap or (not Workspace:Raycast(face, camP - face, ap)
      and not Workspace:Raycast(chestPos, camP - chestPos, ap))
  end
  -- face shots: the lens must stay within 45 deg of where the target faces (66 deg already read as a profile)
  local FACE_CONE = math.cos(math.rad(45))
  local function inFaceCone(camP)
    if not faceDir then return true end
    local v = Vector3.new(camP.X - face.X, 0, camP.Z - face.Z)
    return v.Magnitude < 0.05 or v.Unit:Dot(faceDir) >= FACE_CONE
  end
  local function actorsClear(camP)
    if not ap then return true end
    if not faceVisible(camP) then return false end
    -- lens bubble: only actor parts in FRONT of (or beside) the lens can fill the frame; parts behind it never show
    local fwd = (face - camP).Unit
    for _, p in ipairs(Workspace:GetPartBoundsInRadius(camP, ACTOR_LENS_GAP, aop)) do
      if (p.Position - camP):Dot(fwd) > -0.6 then return false end
    end
    return true
  end
  local params = RaycastParams.new()
  params.FilterType = Enum.RaycastFilterType.Exclude
  params.FilterDescendantsInstances = ignoreList or {}
  local op = OverlapParams.new()
  op.FilterType = Enum.RaycastFilterType.Exclude
  op.FilterDescendantsInstances = ignoreList or {}
  -- torso probe sits 1.5 below the aim point, but never below the floor (low aims would always "hit" the ground)
  local torsoPos = lookAtPos - Vector3.new(0, math.clamp(lookAtPos.Y - 0.6, 0, 1.5), 0)
  -- clear only if BOTH the head ray (lookAt -> cam) and the torso ray (cam -> torso) are unblocked
  local function worldClear(camP)
    -- V6: a torso hit within 1 stud of the torso is furniture the actor stands against (desk, counter),
    -- not an obstruction between camera and actor; counting it blocked every angle and forced 1.5-stud face shots.
    local tHit = Workspace:Raycast(camP, torsoPos - camP, params)
    return not Workspace:Raycast(lookAtPos, camP - lookAtPos, params)
      and (not tHit or (tHit.Position - torsoPos).Magnitude < 1.0)
      and #Workspace:GetPartBoundsInRadius(camP, 0.3, op) == 0
  end
  local function isClear(camP) return worldClear(camP) and inFaceCone(camP) and actorsClear(camP) end
  local fdir = camPos - face                     -- pull-ins run along the face->camera axis (lands between a partner
  local fdist = fdir.Magnitude                   -- and the target, not through the partner via the group midpoint)
  -- V6 sticky framing: a fallback chosen earlier in this beat is re-applied to this frame's base position while it
  -- stays clear, so tiny actor movements can't flip the camera between solutions (jump cuts inside one beat)
  local side = Vector3.new(-dir.Z, 0, dir.X)
  side = side.Magnitude > 0.01 and side.Unit or Vector3.new(1, 0, 0)
  local function apply(t)
    if t.kind == "direct" then return camPos
    elseif t.kind == "lateral" then return camPos + side * t.off
    elseif t.kind == "pull" then return face + fdir * t.r
    else return lookAtPos + CFrame.Angles(0, math.rad(t.deg), 0):VectorToWorldSpace(dir * t.k) end
  end
  local function choose(t, pos)
    if sticky then sticky.t = t end
    return pos
  end
  if sticky and sticky.t then
    -- hysteresis: keep this beat's framing while the face/chest stay visible; the lens bubble only gates new picks
    local pos = apply(sticky.t)
    if worldClear(pos) and inFaceCone(pos) and faceVisible(pos) then return pos end
  end
  if isClear(camPos) then return choose({ kind = "direct" }, camPos) end
  if ap then
    -- 0) another actor blocks the face or crowds the lens: slide sideways first (same distance and height)
    for _, off in ipairs({ 3.5, -3.5, 4.0, -4.0 }) do
      local alt = camPos + side * off
      if isClear(alt) then return choose({ kind = "lateral", off = off }, alt) end
    end
    -- 0b) still blocked: move in front of the blocking actor, toward the target (tighter, but the face reads)
    local hitA = Workspace:Raycast(face, fdir, ap)
    if hitA and fdist > 0.05 then
      local d = (hitA.Position - face):Dot(fdir.Unit) - 1.0
      local alt = face + fdir.Unit * math.max(d, 3.5)
      -- tighter than 3.5 studs = the face fills the frame, so skip to the angle swings instead
      if d >= 3.5 and worldClear(alt) and actorsClear(alt) then return choose({ kind = "pull", r = d / fdist }, alt) end
    end
  end
  -- 1) yaw swings around lookAtPos at the full distance (same height)
  for _, deg in ipairs({35, -35, 65, -65, 90, -90}) do  -- V6: 180 (back view) moved after the closer retries
    local alt = lookAtPos + CFrame.Angles(0, math.rad(deg), 0):VectorToWorldSpace(dir)
    if isClear(alt) then return choose({ kind = "swing", deg = deg, k = 1 }, alt) end
  end
  -- 1b) V6: small rooms rarely clear at full distance; retry the swings closer before giving up on framing
  for _, k in ipairs({0.8, 0.6, 0.45}) do
    for _, deg in ipairs({0, 35, -35, 65, -65, 90, -90}) do
      local alt = lookAtPos + CFrame.Angles(0, math.rad(deg), 0):VectorToWorldSpace(dir * k)
      if isClear(alt) then return choose({ kind = "swing", deg = deg, k = k }, alt) end
    end
  end
  local back = lookAtPos + CFrame.Angles(0, math.pi, 0):VectorToWorldSpace(dir)
  if isClear(back) then return choose({ kind = "swing", deg = 180, k = 1 }, back) end
  -- 1c) face shots: nothing framed cleanly, so push straight in on the frontal axis until no actor blocks the face
  --     (floor 2.2 studs; a tight frontal shot beats a blocked face). The lens bubble is waived here on purpose.
  if ap then
    for _, k in ipairs({ 0.85, 0.7, 0.55, 0.45, 0.38, 0.32, 0.27 }) do
      local alt = face + fdir * k
      if fdist * k >= 2.2 and worldClear(alt) and faceVisible(alt) then
        return choose({ kind = "pull", r = k }, alt)
      end
    end
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
-- V6 hard floor clamp: the lens can never dip under the ground (low_hero on a fall showed the skybox below the floor).
-- The probe starts 2.5 studs above the camera so a camera slightly under the floor still finds the floor surface.
local CAM_FLOOR_CLEARANCE = 1.5
-- V6 indoor clamp (used by every camera path via clampCamAboveFloor):
--  * ceiling: stay CEIL_CLEARANCE below the underside of any set "Ceiling" slab whose footprint is over the lens
--    (high_angle / pull_out in hallway, classroom, living room, auditorium never poke into the slab)
--  * inside solid geometry: a ray that starts inside a part can't hit that part, so a lens buried in a solid block
--    (the auditorium stage deck read as a black frame) is lifted above that block's top first
local CEIL_CLEARANCE = 1.5
local PARTNER_FRAME_MAX = 14  -- studs: partners farther than this from the target don't steer group / OTS framing
function Engine.clampCamIndoor(pos, ignore)
  local op = OverlapParams.new()
  op.FilterType = Enum.RaycastFilterType.Exclude
  op.FilterDescendantsInstances = ignore or {}
  for _, q in ipairs(Workspace:GetPartBoundsInBox(CFrame.new(pos), Vector3.new(0.2, 0.2, 0.2), op)) do
    local lp = q.CFrame:PointToObjectSpace(pos)
    local inside = math.abs(lp.X) < q.Size.X / 2 and math.abs(lp.Y) < q.Size.Y / 2 and math.abs(lp.Z) < q.Size.Z / 2
    local top = q.Position.Y + q.Size.Y / 2
    if inside and q.CanCollide and q.Transparency < 1 and q.Size.Y <= 6 and top - pos.Y < 4 then
      pos = Vector3.new(pos.X, top + CAM_FLOOR_CLEARANCE, pos.Z)
    end
  end
  for _, c in ipairs(Engine._ceilings or {}) do
    if c.Parent then
      local lp = c.CFrame:PointToObjectSpace(pos)
      local under = c.Position.Y - c.Size.Y / 2
      if math.abs(lp.X) < c.Size.X / 2 and math.abs(lp.Z) < c.Size.Z / 2 and pos.Y > under - CEIL_CLEARANCE and pos.Y < under + 30 then
        pos = Vector3.new(pos.X, under - CEIL_CLEARANCE, pos.Z)
      end
    end
  end
  return pos
end

function Engine.clampCamAboveFloor(pos, ignore)
  pos = Engine.clampCamIndoor(pos, ignore)
  local params = RaycastParams.new()
  params.FilterType = Enum.RaycastFilterType.Exclude
  params.FilterDescendantsInstances = ignore or {}
  local hit = Workspace:Raycast(pos + Vector3.new(0, 2.5, 0), Vector3.new(0, -40, 0), params)
  local floorY = hit and hit.Position.Y or 0.2
  if pos.Y < floorY + CAM_FLOOR_CLEARANCE then
    return Vector3.new(pos.X, floorY + CAM_FLOOR_CLEARANCE, pos.Z)
  end
  return pos
end

-- V6 non-actor camera targets. Motion: push_in / pull_out scale the distance; tilt_up eases the aim upward.
local function motionScale(motion, alpha)
  if motion == "push_in" then return 1.07 - 0.14 * alpha
  elseif motion == "pull_out" then return 0.93 + 0.16 * alpha end
  return 1
end

-- `target: Crowd`: the cheering students (and the entrance behind them) framed head-on from ~18-22 studs.
function Engine.frameCrowd(spec, motion, alpha, fov)
  local folder = Workspace:FindFirstChild("Crowd_" .. spec.id) or (Engine._crowds[spec.id] and Engine._crowds[spec.id].folder)
  local models = folder and folder:GetChildren() or {}
  if #models == 0 then return nil end
  local sum, front, minX, maxX = Vector3.zero, Vector3.zero, math.huge, -math.huge
  for _, m in ipairs(models) do
    local cf = m:GetPivot(); sum = sum + cf.Position; front = front + cf.LookVector
  end
  local center = sum / #models
  front = Vector3.new(front.X, 0, front.Z)
  front = front.Magnitude > 0.05 and front.Unit or Vector3.new(0, 0, 1)
  local side = Vector3.new(-front.Z, 0, front.X)
  for _, m in ipairs(models) do
    local x = (m:GetPivot().Position - center):Dot(side); minX = math.min(minX, x); maxX = math.max(maxX, x)
  end
  local spread = (maxX - minX) + 4                                   -- + one body width of air each side
  local fit = spread / (2 * math.tan(math.rad(fov) / 2)) * 1.25
  local dist = math.clamp(math.max(fit, 18), 18, 22) * motionScale(motion, alpha)
  local look = Vector3.new(center.X, 3.2, center.Z)                  -- aim between the students and the doors
  local camPos = look + front * dist + Vector3.new(0, 1.3, 0)
  return CFrame.lookAt(camPos, look) * ROLL_90
end

-- `target: <PropName>`: frame a story prop centred, face-on, sized so its full width fits the 9:16 frame with 25%
-- margin. The camera's FieldOfView spans the final video's width (the rolled capture is cropped to 9:16).
-- The prop is viewed from whichever face points toward the cast (a banner's LookVector faces the wall it hangs on).
function Engine.frameProp(spec, name, motion, alpha, fov, castCenter)
  local folder = Workspace:FindFirstChild("Props_" .. spec.id)
  local part = folder and folder:FindFirstChild(name)
  if not part then return nil end
  local n = part.CFrame.LookVector
  if castCenter and (castCenter - part.Position):Dot(n) < 0 then n = -n end
  local width = math.max(part.Size.X, 0.4)
  local dist = math.max(width / (2 * math.tan(math.rad(fov) / 2)) * 1.25, 2.0) * motionScale(motion, alpha)
  local center = part.Position
  local aim = center
  if motion == "tilt_up" then aim = center - Vector3.new(0, width * 0.18 * (1 - alpha), 0) end
  return CFrame.lookAt(center + n * dist, aim) * ROLL_90
end

function Engine.computeCamera(targetCF, centerPos, camPreset, motion, alpha, groupWidth, ignoreList, partnerPos, actors, sticky, minDist)
  -- Use target's facing basis (LookVector / RightVector) so shots rotate WITH the actor!
  local fwd = Vector3.new(targetCF.LookVector.X, 0, targetCF.LookVector.Z)
  if fwd.Magnitude < 0.01 then fwd = Vector3.new(0, 0, -1) else fwd = fwd.Unit end
  local right = Vector3.new(-fwd.Z, 0, fwd.X)
  local up = Vector3.new(0, 1, 0)

  local localOff, lookY, dutch = fwd * 7.2 + up * 1.7, 1.4, 0
  if camPreset == "wide" then
    localOff = fwd * 13.5 + up * 3.8
  elseif camPreset == "closeup" or camPreset == "front" then
    localOff = fwd * 7.0 + up * 1.75  -- V6: was 5.2; +1.8 studs so faces no longer fill the whole frame
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
  -- V6: face shots also treat the other actors as obstacles (wide/group shots frame everyone on purpose)
  local FACE_SHOT = { closeup = true, front = true, ots = true, reverse_ots = true, low_hero = true }
  local camPos = (camPreset == "foot_insert") and (base + localOff)
    or Engine.clearShot(lookPos, base + localOff, ignoreList, FACE_SHOT[camPreset] and actors or nil, sticky,
         FACE_SHOT[camPreset] and fwd or nil, targetCF.Position + Vector3.new(0, 1.5, 0))
  if minDist and (camPos - lookPos).Magnitude < minDist then
    local away = camPos - lookPos
    away = away.Magnitude > 0.05 and away.Unit or Vector3.new(fwd.X, 0.15, fwd.Z).Unit
    camPos = lookPos + away * minDist
  end
  camPos = Engine.clampCamAboveFloor(camPos, ignoreList)
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

-- hide/show a prop including its kit extras (screen gui, banner text, glow)
local function setPropVisible(p, visible)
  p.Transparency = visible and (p:GetAttribute("BaseTransparency") or 0) or 1
  for _, d in ipairs(p:GetDescendants()) do
    if d:IsA("SurfaceGui") or d:IsA("SurfaceLight") or d:IsA("PointLight") then d.Enabled = visible
    elseif d:IsA("BasePart") then d.Transparency = visible and 0 or 1 end  -- kit extras (mic, handle)
  end
end

local function surfaceText(p, face, text, fg, bg, font)
  local g = Instance.new("SurfaceGui"); g.Face = face; g.LightInfluence = 0; g.Brightness = 2
  g.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud; g.PixelsPerStud = 60; g.Parent = p
  local l = Instance.new("TextLabel"); l.Size = UDim2.fromScale(1, 1)
  if bg then l.BackgroundColor3 = bg; l.BackgroundTransparency = 0 else l.BackgroundTransparency = 1 end
  l.TextColor3 = fg; l.Font = font or Enum.Font.GothamBlack
  l.TextScaled = true; l.Text = text or ""; l.Parent = g
  local pad = Instance.new("UIPadding"); pad.PaddingLeft = UDim.new(0.04, 0); pad.PaddingRight = UDim.new(0.04, 0)
  pad.PaddingTop = UDim.new(0.08, 0); pad.PaddingBottom = UDim.new(0.08, 0); pad.Parent = l
  return l
end

-- V6 prop kits: story.yaml `props: - {name: Phone, kit: phone, attach: "Dex/Right Arm"}` or
-- `{name: Banner, kit: banner, text: "FAREWELL DEX!"}` (banner defaults to the school entrance when no pos).
local KITS = {
  phone = function(p, d)
    p.Size = d.size or Vector3.new(0.45, 0.85, 0.08); p.Color = Color3.fromRGB(24, 26, 30)
    p.Material = Enum.Material.SmoothPlastic
    for _, face in ipairs({ Enum.NormalId.Front, Enum.NormalId.Back }) do
      surfaceText(p, face, d.text or "", Color3.fromRGB(255, 255, 255), Color3.fromRGB(70, 170, 255), Enum.Font.GothamBold)
    end
    local glow = Instance.new("PointLight"); glow.Range = 4; glow.Brightness = 1.2
    glow.Color = Color3.fromRGB(110, 190, 255); glow.Parent = p
    -- held in the right hand, screen tilted up toward the face (R6 hand = bottom of the arm)
    d.offset = d.offset or Vector3.new(0, -1.05, -0.55)
    d.rot = d.rot or Vector3.new(-55, 0, 0)
  end,
  banner = function(p, d)
    p.Size = d.size or Vector3.new(13, 2.6, 0.25); p.Color = Color3.fromRGB(250, 246, 236)
    p.Material = Enum.Material.Fabric
    for _, face in ipairs({ Enum.NormalId.Front, Enum.NormalId.Back }) do
      surfaceText(p, face, d.text or "", Color3.fromRGB(200, 30, 40), nil, Enum.Font.GothamBlack)
    end
    -- default: school_yard entrance, in the clear band above SchoolSign (top y 11.1) and below the 2nd-floor
    -- sills (y 14.1), in the sign's plane so the sign never covers it from a low camera
    if not d.pos and not d.attach then d.pos = Vector3.new(-14, 12.6, -19.6) end
  end,
  -- V6 `kit: paper`: a sheet (exam, score card, note). Text on both faces; held like the phone when attached,
  -- `rot: [-90, 0, 0]` lays it flat on a desk.
  paper = function(p, d)
    p.Size = d.size or Vector3.new(1, 1.3, 0.03); p.Color = Color3.fromRGB(250, 250, 246)
    p.Material = Enum.Material.SmoothPlastic
    for _, face in ipairs({ Enum.NormalId.Front, Enum.NormalId.Back }) do
      surfaceText(p, face, d.text or "", Color3.fromRGB(200, 30, 40), nil, Enum.Font.GothamBlack)
    end
    if d.attach then d.offset = d.offset or Vector3.new(0, -1.05, -0.6); d.rot = d.rot or Vector3.new(-55, 0, 0) end
  end,
  -- V6 `kit: podium`: wooden lectern + mic. Front (text side) is the part's -Z face; the speaker stands behind it.
  podium = function(p, d)
    p.Size = d.size or Vector3.new(2.6, 3.6, 1.6); p.Color = Color3.fromRGB(150, 104, 64)
    p.Material = Enum.Material.WoodPlanks
    if d.text then surfaceText(p, Enum.NormalId.Front, d.text, Color3.fromRGB(216, 173, 93), nil, Enum.Font.GothamBlack) end
    d.after = function(pp)
      local top = pp.CFrame * CFrame.new(0, pp.Size.Y / 2, pp.Size.Z / 2 - 0.35)
      local stand = Instance.new("Part"); stand.Name = "MicStand"; stand.Size = Vector3.new(0.12, 1.3, 0.12)
      stand.CFrame = top * CFrame.new(0, 0.65, 0); stand.Color = Color3.fromRGB(34, 36, 42)
      stand.Material = Enum.Material.Metal; stand.Anchored = true; stand.CanCollide = false; stand.Parent = pp
      local mic = Instance.new("Part"); mic.Name = "Mic"; mic.Shape = Enum.PartType.Ball; mic.Size = Vector3.new(0.35, 0.35, 0.35)
      mic.CFrame = top * CFrame.new(0, 1.4, -0.15); mic.Color = Color3.fromRGB(34, 36, 42)
      mic.Material = Enum.Material.Metal; mic.Anchored = true; mic.CanCollide = false; mic.Parent = pp
    end
  end,
  -- V6 `kit: locker`: a single school locker (text = name tag on the door, -Z face).
  locker = function(p, d)
    p.Size = d.size or Vector3.new(2, 7, 1.9); p.Color = Color3.fromRGB(52, 98, 160); p.Material = Enum.Material.Metal
    if d.text then surfaceText(p, Enum.NormalId.Front, d.text, Color3.fromRGB(255, 255, 255), nil, Enum.Font.GothamBold) end
    d.after = function(pp)
      local h = Instance.new("Part"); h.Name = "LockerHandle"; h.Size = Vector3.new(0.18, 0.6, 0.12)
      h.CFrame = pp.CFrame * CFrame.new(pp.Size.X / 2 - 0.4, 0, -pp.Size.Z / 2 - 0.06)
      h.Color = Color3.fromRGB(200, 200, 205); h.Material = Enum.Material.Metal
      h.Anchored = true; h.CanCollide = false; h.Parent = pp
    end
  end,
}

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
    if d.kit then
      if KITS[d.kit] then KITS[d.kit](p, d) else warn("[AI-Vid] unknown prop kit: " .. tostring(d.kit)) end
    end
    p.Parent = folder
    placeProp(p, d, rigs)
    if d.after then d.after(p) end
    if d.hide then setPropVisible(p, false) end
  end
  return folder
end

function Engine.applyPropCue(spec, cue, rigs)
  local folder = Workspace:FindFirstChild("Props_" .. spec.id)
  local p = folder and folder:FindFirstChild(cue.name)
  if not p then return end
  if cue.attach or cue.pos then placeProp(p, cue, rigs) end
  if cue.hide then setPropVisible(p, false) elseif cue.show then setPropVisible(p, true) end
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

-- === V6 MULTI-SET STAGING ===
local PFS = game:GetService("PathfindingService")
Engine.SET_ALIAS = { street = "street_day", living_room = "cozy_room" }
Engine._setRoots, Engine._seats = {}, {}

-- One set at `offset` (compile_story.py spaces a story's sets 400 studs apart on X). A custom model at
-- ServerStorage.Sets.<name> or Workspace.Sets.<name> replaces the procedural builder: a Model is pivoted to the offset
-- (its pivot = set origin at floor level), a Folder keeps its coordinates as set-local. A Workspace template is moved
-- to ServerStorage.Sets on first use so it never shows twice. Spots still come from assets/manifest.json.
function Engine.buildSet(name, offset)
  offset = offset or Vector3.zero
  local SS = game:GetService("ServerStorage")
  local wsSets, ssSets = Workspace:FindFirstChild("Sets"), SS:FindFirstChild("Sets")
  local tpl = (ssSets and ssSets:FindFirstChild(name)) or (wsSets and wsSets:FindFirstChild(name))
  local root
  if tpl then
    if wsSets and tpl.Parent == wsSets then
      if not ssSets then ssSets = Instance.new("Folder"); ssSets.Name = "Sets"; ssSets.Parent = SS end
      tpl.Parent = ssSets
    end
    local clone = tpl:Clone()
    root = clone
    if not clone:IsA("Model") then
      root = Instance.new("Model")
      for _, c in ipairs(clone:GetChildren()) do c.Parent = root end
      clone:Destroy()
    end
    root.Name = "Set_" .. (string.gsub(name, "_", ""))
    local prev = Workspace:FindFirstChild(root.Name); if prev then prev:Destroy() end
    root.Parent = Workspace
    if tpl:IsA("Model") then root:PivotTo(CFrame.new(offset) * tpl:GetPivot().Rotation) else root:TranslateBy(offset) end
  else
    local fn = _G.AIVidSets and (_G.AIVidSets[name] or _G.AIVidSets[Engine.SET_ALIAS[name] or ""])
    if not fn then warn("[AI-Vid] set not loaded: " .. tostring(name)); return nil end
    local before = {}
    for _, c in ipairs(Workspace:GetChildren()) do before[c] = true end
    fn()
    for _, c in ipairs(Workspace:GetChildren()) do
      if not before[c] and string.sub(c.Name, 1, 4) == "Set_" then root = c end
    end
    if root and offset.Magnitude > 0 then
      if not root:IsA("Model") then
        local m = Instance.new("Model"); m.Name = root.Name
        for _, c in ipairs(root:GetChildren()) do c.Parent = m end
        root:Destroy(); m.Parent = Workspace; root = m
      end
      root:TranslateBy(offset)
    end
  end
  Engine._setRoots[name] = root
  return root
end

-- V6 overhead RULE counter (story `counter:` on cast / beats / partners, e.g. "10 WORDS", "LIES: 99"). Never a
-- nameplate. Built as a SurfaceGui sign on an invisible part that faces the camera every frame (yaw only): a
-- screen-space BillboardGui would come out sideways because the capture camera is rolled 90 degrees and the video
-- is transposed upright afterwards; a world-space sign is rotated with the scene and reads upright in the Short.
function Engine.setCounter(r, text)
  local old = r.m:FindFirstChild("AIVidCounter")
  if old then old:Destroy() end
  r.counterPart = nil
  if not text or text == "" then return end
  text = string.upper(text)
  local p = Instance.new("Part")
  p.Name = "AIVidCounter"; p.Size = Vector3.new(math.max(1.8, #text * 0.42 + 0.7), 0.95, 0.05)
  p.Transparency = 1; p.Anchored = true; p.CanCollide = false; p.CanQuery = false; p.CanTouch = false; p.CastShadow = false
  p:SetAttribute("BaseT", 1)
  p:SetAttribute("BaseSize", p.Size)
  local g = Instance.new("SurfaceGui"); g.Name = "CounterGui"; g.Face = Enum.NormalId.Front; g.LightInfluence = 0
  g.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud; g.PixelsPerStud = 120; g.Parent = p
  local l = Instance.new("TextLabel")
  l.Size = UDim2.fromScale(1, 1); l.BackgroundColor3 = Color3.fromRGB(16, 18, 26); l.BackgroundTransparency = 0.15
  l.TextColor3 = Color3.fromRGB(255, 255, 255); l.Font = Enum.Font.GothamBlack; l.TextScaled = true; l.Text = text
  l.TextStrokeColor3 = Color3.new(0, 0, 0); l.TextStrokeTransparency = 0.5; l.Parent = g
  local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0.35, 0); corner.Parent = l
  local pad = Instance.new("UIPadding"); pad.PaddingLeft = UDim.new(0.07, 0); pad.PaddingRight = UDim.new(0.07, 0)
  pad.PaddingTop = UDim.new(0.12, 0); pad.PaddingBottom = UDim.new(0.12, 0); pad.Parent = l
  p.Parent = r.m
  r.counterPart = p
end

-- V6.2 per-beat `scale:` (0.2-2.5). Joints go back to their base C0 first so ScaleTo scales the rest pose, then
-- the base C0s are re-captured (poses blend from them every frame). Feet stay planted: the lowest part is put back
-- on the same floor height, and r.hip (walk waypoint height) follows the pivot.
function Engine.setScale(r, s)
  s = math.clamp(tonumber(s) or 1, 0.2, 2.5)
  if math.abs((r.scale or 1) - s) < 1e-3 then return end
  local function lowest()
    local low = math.huge
    for _, q in ipairs(r.m:GetChildren()) do
      if q:IsA("BasePart") and q.Name ~= "AIVidCounter" then low = math.min(low, q.Position.Y - q.Size.Y / 2) end
    end
    return low
  end
  for jn, m6d in pairs(r.joints) do m6d.C0 = r.baseC0[jn] end
  -- V6.2.2: ScaleTo scales about WorldPivot, which can lag the root after walks / set offsets and threw Rex into
  -- the void. Pin the pivot to the root, keep the counter sign out of the model, and restore X/Z/rotation exactly.
  local hrp = r.m:FindFirstChild("HumanoidRootPart") or r.m.PrimaryPart
  if hrp then r.m.PrimaryPart = hrp end
  local prevCF = hrp and hrp.CFrame or r.m:GetPivot()
  r.m.WorldPivot = prevCF
  local sign = r.counterPart; if sign and sign.Parent == r.m then sign.Parent = nil end
  local low0, piv0 = lowest(), r.m:GetPivot().Position.Y
  r.m:ScaleTo(s)
  local cur = hrp and hrp.Position or r.m:GetPivot().Position
  r.m:PivotTo(CFrame.new(prevCF.X, cur.Y, prevCF.Z) * prevCF.Rotation)
  r.m:PivotTo(r.m:GetPivot() + Vector3.new(0, low0 - lowest(), 0))   -- Y-only foot plant
  if sign then sign.Parent = r.m end
  for jn, m6d in pairs(r.joints) do r.baseC0[jn] = m6d.C0 end
  local dy = r.m:GetPivot().Position.Y - piv0
  r.hip = (r.hip or 3) + dy
  if r.startCF then r.startCF = r.startCF + Vector3.new(0, dy, 0) end
  r.scale = s
end

function Engine.updateCounters(rigs, camPos)
  for _, r in pairs(rigs) do
    local p = r.counterPart
    if p and p.Parent then
      -- V6.2.1: a sign within 5.5 studs of the lens is the foreground actor in an OTS/close shot -> hide it
      p.CounterGui.Enabled = not (r.hidden or r.invisible) and (p.Position - camPos).Magnitude >= 5.5
      local head = r.m:FindFirstChild("Head")
      if head and not r.hidden then
        -- V6.2: the sign shrinks with a scaled actor (floor 0.35) so a close-up on a tiny Rex isn't all sign
        local k = math.max(r.scale or 1, 0.20)
        local bs = p:GetAttribute("BaseSize")
        if bs then p.Size = bs * k end
        local at = head.Position + Vector3.new(0, head.Size.Y * 0.5 + 1.4 * k, 0)
        local look = Vector3.new(camPos.X, at.Y, camPos.Z)
        p.CFrame = (look - at).Magnitude > 0.05 and CFrame.lookAt(at, look) or CFrame.new(at)
      end
    end
  end
  -- V6.2.2: two signs that overlap on screen (actors lined up in depth) -> only the nearer one shows
  local cam, shown = Workspace.CurrentCamera, {}
  for _, r in pairs(rigs) do
    local p = r.counterPart
    if p and p.Parent and p.CounterGui.Enabled then
      local v, on = cam:WorldToViewportPoint(p.Position)
      local e = cam:WorldToViewportPoint(p.Position + p.CFrame.RightVector * p.Size.X * 0.5)
      local sv = Vector2.new(v.X, v.Y)
      local rad = (Vector2.new(e.X, e.Y) - sv).Magnitude
      -- V6.2.2: a sign the frame edge would cut ("IGHT: 5 FT") or a huge foreground sign -> hidden
      local vs = cam.ViewportSize
      local m = math.min(vs.X, vs.Y) * 0.02
      local cut = sv.X - rad < m or sv.X + rad > vs.X - m or sv.Y - rad < m or sv.Y + rad > vs.Y - m
      if not on or cut or rad > math.min(vs.X, vs.Y) * 0.45 then p.CounterGui.Enabled = false
      else table.insert(shown, { p = p, v = sv, d = v.Z, rad = rad }) end
    end
  end
  for i = 1, #shown do
    for j = i + 1, #shown do
      local a, b = shown[i], shown[j]
      if (a.v - b.v).Magnitude < (a.rad + b.rad) * 1.1 then (a.d > b.d and a or b).p.CounterGui.Enabled = false end
    end
  end
end

-- `invisible: true/false`: the whole character (body, accessories, face) goes fully transparent, and back.
function Engine.setInvisible(r, on)
  r.invisible = on and true or false
  for _, d in ipairs(r.m:GetDescendants()) do
    if d:IsA("BasePart") or d:IsA("Decal") then
      if d:GetAttribute("BaseT") == nil then d:SetAttribute("BaseT", d.Transparency) end
      d.Transparency = on and 1 or d:GetAttribute("BaseT")
    end
  end
end

-- `action: sit`: nearest seat part (name contains "Seat", not "Back"/"Base") within 10 studs of the actor.
function Engine.findSeat(pos)
  local best, bd
  for _, seat in ipairs(Engine._seats) do
    local d = Vector2.new(seat.Position.X - pos.X, seat.Position.Z - pos.Z).Magnitude
    if d < 10 and (not bd or d < bd) then best, bd = seat, d end
  end
  return best
end

-- seated pivot: torso on the seat top, facing away from the seat's back rest (or keeping the actor's facing)
function Engine.seatCF(seat, look)
  local back, bdist
  for _, q in ipairs(seat.Parent:GetChildren()) do
    if q:IsA("BasePart") and string.find(q.Name, "Back") then
      local d = (q.Position - seat.Position).Magnitude
      if d < 2.5 and (not bdist or d < bdist) then back, bdist = q, d end
    end
  end
  local fwd = back and Vector3.new(seat.Position.X - back.Position.X, 0, seat.Position.Z - back.Position.Z)
  if not fwd or fwd.Magnitude < 0.05 then fwd = Vector3.new(look.X, 0, look.Z) end
  fwd = fwd.Magnitude > 0.05 and fwd.Unit or Vector3.new(0, 0, -1)
  local top = seat.Position.Y + seat.Size.Y / 2
  local pos = Vector3.new(seat.Position.X, top + 1.0, seat.Position.Z) + fwd * 0.15
  return CFrame.lookAt(pos, pos + fwd)
end

-- `action: kick`: rattle the nearest solid object in front of the kicker (a whole Model like a locker, else the part)
function Engine.kickShake(r, exclude, delay)
  local cf = r.m:GetPivot()
  local op = OverlapParams.new()
  op.FilterType = Enum.RaycastFilterType.Exclude
  op.FilterDescendantsInstances = exclude
  local best, bd
  for _, q in ipairs(Workspace:GetPartBoundsInRadius(cf.Position + cf.LookVector * 2.5, 3, op)) do
    local top = q.Position.Y + q.Size.Y / 2
    if q.Anchored and top > cf.Position.Y - 2.2 and q.Size.X < 12 and q.Size.Z < 12 and q.Size.Y > 0.15 then
      local d = (q.Position - cf.Position).Magnitude
      if not bd or d < bd then best, bd = q, d end
    end
  end
  if not best then return end
  local target = best
  local m = best.Parent
  if m and m:IsA("Model") and string.sub(m.Name, 1, 4) ~= "Set_" and not m:FindFirstChildOfClass("Humanoid") then target = m end
  task.delay(delay, function()
    local base = target:GetPivot()
    for i = 1, 9 do
      local k = (1 - i / 9) * 0.14
      target:PivotTo(base * CFrame.new((math.random() - 0.5) * k * 2, 0, (math.random() - 0.5) * k * 2)
        * CFrame.Angles(0, 0, (math.random() - 0.5) * k))
      task.wait(1 / 30)
    end
    target:PivotTo(base)
  end)
end

-- V6 walks: PathfindingService routes around benches, desks, lockers and stages (ramps included). Computed on a
-- background thread so the beat cut never stalls; the walker holds its first frames until the route is ready.
-- Fallbacks: a slimmer agent, then one clear detour waypoint beside the straight line, then the straight line.
local function legClear(a, b, ignore)
  local params = RaycastParams.new()
  params.FilterType = Enum.RaycastFilterType.Exclude
  params.FilterDescendantsInstances = ignore
  local hit = Workspace:Spherecast(a + Vector3.new(0, -1.4, 0), 0.8, b - a, params)
  return not (hit and hit.Instance.CanCollide)
end

function Engine.planWalk(r, from, to, ignore)
  local token = {}
  r.walkToken, r.walkPath, r.walkA0 = token, nil, nil
  local hip = r.hip or 3
  task.spawn(function()
    local pts
    for _, rad in ipairs({ 2.5, 1.2 }) do
      local path = PFS:CreatePath({ AgentRadius = rad, AgentHeight = 5, AgentCanJump = false })
      local ok = pcall(function()
        path:ComputeAsync(from - Vector3.new(0, hip - 0.2, 0), Vector3.new(to.X, to.Y + 0.2, to.Z))
      end)
      if ok and path.Status == Enum.PathStatus.Success then
        -- waypoint heights vary: stand each one on the real floor under it (ramps/stages climb correctly)
        pts = {}
        for _, w in ipairs(path:GetWaypoints()) do
          local q = w.Position
          table.insert(pts, Vector3.new(q.X, Engine.floorY(q, ignore) - 0.2 + hip, q.Z))
        end
        if #pts >= 2 then pts[1] = from else pts = nil end
        if pts then break end
      end
    end
    if not pts then
      local dest = Vector3.new(to.X, from.Y, to.Z)
      pts = { from, dest }
      if not legClear(from, dest, ignore) then
        local side = Vector3.new(-(dest - from).Z, 0, (dest - from).X)
        side = side.Magnitude > 0.05 and side.Unit or Vector3.new(1, 0, 0)
        for _, o in ipairs({ 3, -3, 6, -6 }) do
          local mid = (from + dest) / 2 + side * o
          if legClear(from, mid, ignore) and legClear(mid, dest, ignore) then pts = { from, mid, dest }; break end
        end
      end
    end
    if r.walkToken ~= token then return end
    local len = 0
    for i = 2, #pts do len += (pts[i] - pts[i - 1]).Magnitude end
    r.walkPath, r.walkLen = pts, len
  end)
end

function Engine.followWalk(r, alpha)
  local pts = r.walkPath
  if not pts then return end
  r.walkA0 = r.walkA0 or alpha
  local d = math.clamp((alpha - r.walkA0) / math.max(1 - r.walkA0, 0.05), 0, 1) * r.walkLen
  for i = 2, #pts do
    local a, b = pts[i - 1], pts[i]
    local L = (b - a).Magnitude
    if d <= L or i == #pts then
      local cur = a:Lerp(b, L > 0 and math.clamp(d / L, 0, 1) or 1)
      local dir = Vector3.new(b.X - a.X, 0, b.Z - a.Z)
      if dir.Magnitude > 0.05 then r.m:PivotTo(CFrame.lookAt(cur, cur + dir.Unit))
      else r.m:PivotTo(CFrame.new(cur) * r.m:GetPivot().Rotation) end
      return
    end
    d -= L
  end
end

function Engine.compile(spec)
  local runner = {}
  local rigs = {}
  local castFolder

  function runner.setup()
    local bp = Workspace:FindFirstChild("Baseplate"); if bp then bp.Transparency = 1; bp.CanCollide = true end
    -- V6 clean slate: every other story's actors/props/crowds leave Workspace (moved to ServerStorage._Old/<id>,
    -- owner hygiene rule: never delete), this story's old copies and every generated set are destroyed (sets are
    -- rebuilt from code), and fx state is reset. No downed rigs or trucks from earlier takes can appear in shot.
    local SS = game:GetService("ServerStorage")
    local oldRoot = SS:FindFirstChild("_Old") or Instance.new("Folder", SS); oldRoot.Name = "_Old"
    for _, c in ipairs(Workspace:GetChildren()) do
      local kind, sid = string.match(c.Name, "^(%a+)_(%w+)$")
      if kind == "Set" then
        c:Destroy()
      elseif (kind == "Cast" or kind == "Props" or kind == "Crowd" or kind == "EventProps") then
        if sid == spec.id then c:Destroy()
        else
          local dst = oldRoot:FindFirstChild(sid) or Instance.new("Folder", oldRoot); dst.Name = sid
          local prevCopy = dst:FindFirstChild(c.Name); if prevCopy then prevCopy:Destroy() end
          c.Parent = dst
        end
      elseif c.Name == "FxBasketball" then
        c:Destroy()
      end
    end
    Engine.truck, Engine.truckBusy = nil, false
    Engine._setRoots, Engine._seats, Engine._ceilings = {}, {}, {}
    for _, st in ipairs(spec.sets or { { name = spec.set, offset = Vector3.zero } }) do
      if st.name then Engine.buildSet(st.name, st.offset) end
    end
    for _, root in pairs(Engine._setRoots) do
      for _, q in ipairs(root:GetDescendants()) do
        if q:IsA("BasePart") and string.find(q.Name, "Seat") and not string.find(q.Name, "Back") and not string.find(q.Name, "Base") then
          table.insert(Engine._seats, q)
        elseif q:IsA("BasePart") and q.Name == "Ceiling" then
          table.insert(Engine._ceilings, q)
        end
      end
    end
    local old = Workspace:FindFirstChild("Cast_" .. spec.id)
    if old then old:Destroy() end
    castFolder = Instance.new("Folder", Workspace)
    castFolder.Name = "Cast_" .. spec.id
    rigs = {}
    Engine.assignDistinctWardrobes(spec.cast or {}, spec.wardrobe_seed or spec.id)
    for _, c in ipairs(spec.cast or {}) do
      local m = Engine.buildRig(c, castFolder)
      local r = Engine.registerRig(m)
      rigs[c.name] = r
      r.set = spec.set
      r.hip = m:GetPivot().Position.Y - (c.pos and c.pos.Y or 0)   -- pivot height above the spot (spot y = floor - 0.2)
      for _, q in ipairs(m:GetDescendants()) do if q:IsA("BasePart") then q.CanCollide = false end end  -- not a wall to pathfinding
      if c.invisible then Engine.setInvisible(r, true) end
      if c.counter then Engine.setCounter(r, c.counter) end
      if c.scale then Engine.setScale(r, c.scale) end
    end
    Engine.spawnProps(spec, rigs)
    Engine._crowds[spec.id] = nil
    for _, b in ipairs(spec.beats or {}) do
      if b.fx == "crowd_cheer" then Engine.prepareCrowd(spec); break end
    end
    Engine.applyLighting(spec.lighting or "day_bright")
    return castFolder
  end

  function runner.play()
    local cam = Workspace.CurrentCamera
    cam.CameraType = Enum.CameraType.Scriptable
    cam.FieldOfView = DEFAULT_FOV
    if not next(rigs) then runner.setup() end
    for _, c in ipairs(spec.cast or {}) do   -- a re-take starts from the cast scale, not the last beat's
      if rigs[c.name] then Engine.setScale(rigs[c.name], c.scale or 1) end
    end
    local tStart = os.clock()
    local lastBeat = 0
    local beatStartPos = {}
    local hitstopUntil = 0
    local warnedTarget = {}
    local camSticky, camStickyBeat = {}, nil
    local fallCamBeat, fallCamCF = nil, nil
    local faceMidDone = true
    local setOffsets = {}
    for _, st in ipairs(spec.sets or {}) do setOffsets[st.name] = st.offset end

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
        local function place(m, at, yaw, hip)
          if not m or (not at and yaw == nil) then return end
          local cf = m:GetPivot()
          local p = at and Vector3.new(at.X, hip and (at.Y + hip) or cf.Position.Y, at.Z) or cf.Position
          local rot = (yaw ~= nil) and CFrame.Angles(0, math.rad(yaw), 0) or (cf - cf.Position)
          m:PivotTo(CFrame.new(p) * rot)
        end
        -- V6 per-actor fall/downed: a finished `fall` leaves the actor lying down; they stay down (also when not in
        -- the beat) until a beat gives them an explicit action other than downed/fall.
        local function actionOf(name)
          if name == active.target then return active.action end
          for _, cue in ipairs(active.partners or {}) do
            if cue.name == name then return cue.action or active.action end
          end
          return nil
        end
        -- V6 isolated staging: only this beat's actors stand on this beat's set; everyone else is parked off-stage
        -- (never blocks a camera or a walk). Actors entering a new set keep their set-relative position unless the
        -- beat snaps them to a spot; a downed/seated actor gets up when the story changes room.
        local bset = active.set or spec.set
        local boff = setOffsets[bset] or Vector3.zero
        local inBeat = {}
        if targetRig then inBeat[active.target] = true end
        for _, cue in ipairs(active.partners or {}) do if rigs[cue.name] then inBeat[cue.name] = true end end
        local anyActor = next(inBeat) ~= nil
        for name, r in pairs(rigs) do
          if inBeat[name] or not anyActor then
            if r.hidden then r.m:PivotTo(r.parkCF); r.hidden, r.parkCF = false, nil end
            if r.set ~= bset then
              local cf = r.standCF or r.fallCF or r.m:GetPivot()
              r.down, r.fallCF, r.seated, r.standCF = false, nil, false, nil
              r.m:PivotTo(cf + (boff - (setOffsets[r.set] or Vector3.zero))); r.set = bset
            end
          elseif not r.hidden then
            r.parkCF, r.hidden = r.m:GetPivot(), true
            r.m:PivotTo(CFrame.new(0, -500, 0))
          end
        end
        -- clean pose per beat: an actor whose action changes starts from the rest pose (downed/sit continue)
        for name, r in pairs(rigs) do
          if inBeat[name] then
            local act = actionOf(name) or "idle"
            if act ~= r.lastAct and act ~= "downed" and act ~= "sit" then
              for jn, m6d in pairs(r.joints) do m6d.C0 = r.baseC0[jn] end
            end
            r.lastAct = act
          end
        end
        -- `sit` pins the actor on the nearest seat until a beat gives them another action
        for name, r in pairs(rigs) do
          local act = actionOf(name)
          if act == "sit" and not r.seated and not r.down then
            local seat = Engine.findSeat(r.m:GetPivot().Position)
            if seat then
              r.standCF, r.seated = r.m:GetPivot(), true
              r.seatCF = Engine.seatCF(seat, r.m:GetPivot().LookVector)
            else
              warn("[AI-Vid] sit: no seat within 10 studs of " .. name)
            end
          elseif r.seated and act ~= nil and act ~= "sit" then
            r.m:PivotTo(r.standCF); r.seated, r.standCF = false, nil
          end
        end
        if targetRig and active.counter ~= nil then Engine.setCounter(targetRig, active.counter) end
        for _, cue in ipairs(active.partners or {}) do
          if rigs[cue.name] and cue.counter ~= nil then Engine.setCounter(rigs[cue.name], cue.counter) end
        end
        if targetRig and active.scale then Engine.setScale(targetRig, active.scale) end
        for _, cue in ipairs(active.partners or {}) do
          if rigs[cue.name] and cue.scale then Engine.setScale(rigs[cue.name], cue.scale) end
        end
        faceMidDone = false
        if targetRig and active.invisible ~= nil then Engine.setInvisible(targetRig, active.invisible) end
        for _, cue in ipairs(active.partners or {}) do
          local pr = rigs[cue.name]
          if pr and cue.invisible ~= nil then Engine.setInvisible(pr, cue.invisible) end
        end
        for name, r in pairs(rigs) do
          local act = actionOf(name)
          if r.fallCF then r.standCF, r.fallCF, r.down = r.fallCF, nil, true end
          if act == "downed" and not r.down then r.standCF, r.down = r.m:GetPivot(), true end
          if r.down and act ~= nil and act ~= "downed" and act ~= "fall" then
            r.m:PivotTo(r.standCF); r.down, r.standCF = false, nil
          end
        end
        place(model, active.snap_to, active.yaw, targetRig and targetRig.hip)
        for _, cue in ipairs(active.partners or {}) do
          local pr = rigs[cue.name]
          if pr then place(pr.m, cue.snap_to, cue.yaw, pr.hip) end
        end
        for name, r in pairs(rigs) do beatStartPos[name] = r.m:GetPivot().Position end
        -- V6: a walk/run that ends within 4 studs of another actor stops 4 studs short along the approach,
        -- so actors walk up and stop face-to-face instead of shoving (others' planned move_to counts too)
        local WALK_GAP = 4.0
        local planned = {}
        if active.target and active.move_to then planned[active.target] = active.move_to end
        for _, cue in ipairs(active.partners or {}) do if cue.move_to then planned[cue.name] = cue.move_to end end
        for name, r in pairs(rigs) do
          r.walkDest = planned[name]
          if r.walkDest then
            local start = beatStartPos[name]
            for oname, o in pairs(rigs) do
              if oname ~= name then
                local occ = planned[oname] or beatStartPos[oname]
                local d = Vector3.new(r.walkDest.X - occ.X, 0, r.walkDest.Z - occ.Z)
                if d.Magnitude < WALK_GAP then
                  local approach = Vector3.new(occ.X - start.X, 0, occ.Z - start.Z)
                  approach = approach.Magnitude > 0.05 and approach.Unit or Vector3.new(0, 0, 1)
                  r.walkDest = occ - approach * WALK_GAP
                end
              end
            end
          end
        end
        local function destOf(name)
          if name == active.target then return active.move_to end
          for _, cue in ipairs(active.partners or {}) do if cue.name == name then return cue.move_to end end
          return nil
        end
        for name, r in pairs(rigs) do
          local act = actionOf(name)
          r.launchFrom, r.launchTo, r.launchFloor0 = nil, nil, nil
          if act == "fall" and not r.down then r.fallCF = r.m:GetPivot(); r.fallDust = false end
          if (act == "fall" or act == "knockback") and not r.down and destOf(name) then
            r.launchFrom, r.launchTo = r.m:GetPivot(), destOf(name)
          end
        end
        for name, r in pairs(rigs) do
          r.walkToken, r.walkPath, r.walkA0 = nil, nil, nil
          if r.walkDest and not r.launchTo and not r.down and not r.seated then
            Engine.planWalk(r, beatStartPos[name], r.walkDest, { castFolder })
          end
        end
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
        local autoFace = active.face_partner
        if autoFace == nil and active.partners and active.partners[1] then
          -- V6 default: talking actors look at each other, unless either is walking/running away, falling,
          -- downed, or travelling to a move_to this beat
          local MOVING = { walk = true, run = true, fall = true, knockback = true, downed = true }
          local p1 = active.partners[1]
          local pr1 = rigs[p1.name]
          autoFace = not (MOVING[active.action or "idle"] or MOVING[p1.action or active.action or "idle"]
            or active.move_to or p1.move_to or (targetRig and (targetRig.down or targetRig.fallCF))
            or (pr1 and (pr1.down or pr1.fallCF)))
        end
        if model and autoFace and active.partners and active.partners[1] then
          local partner = rigs[active.partners[1].name]
          if partner then
            local a, b = model:GetPivot().Position, partner.m:GetPivot().Position
            if Vector2.new(a.X - b.X, a.Z - b.Z).Magnitude > 0.05 then
              model:PivotTo(CFrame.lookAt(a, Vector3.new(b.X, a.Y, b.Z)))
              partner.m:PivotTo(CFrame.lookAt(b, Vector3.new(a.X, b.Y, a.Z)))
            end
          end
        end
        if active.action == "kick" and targetRig then Engine.kickShake(targetRig, { castFolder }, active.dur * 0.35) end
        for _, cue in ipairs(active.partners or {}) do
          if cue.action == "kick" and rigs[cue.name] then Engine.kickShake(rigs[cue.name], { castFolder }, active.dur * 0.35) end
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
        elseif active.fx == "light_flash_red" then Engine.lightFlashRed(active.dur)
        elseif active.fx == "truck_pass" and model and not Engine.truckBusy then
          -- consecutive truck_pass beats form one pass; the truck reaches the target at the end of the first one
          local first, total = Engine.fxSpan(spec, active, "truck_pass")
          Engine.truckPass(model:GetPivot().Position, first, total)
        elseif active.fx == "ball_swish" and model then
          local prev = spec.beats[table.find(spec.beats, active) - 1]
          if not (prev and prev.fx == "ball_swish") then          -- only the first beat of a span launches
            local first, total = Engine.fxSpan(spec, active, "ball_swish")
            Engine.ballSwish(model, first, total)
          end
        elseif active.fx == "crowd_cheer" then
          local _, total = Engine.fxSpan(spec, active, "crowd_cheer")
          Engine.crowdCheer(spec, total)
        end
      end

      -- Non-blocking hitstop: freezes rig poses briefly without stalling RenderStepped
      local frozenForHitstop = (t < hitstopUntil)
      if not frozenForHitstop then
        local tb = t - active.t0
        local groundIgnore = { castFolder, Engine.truck }
        if targetRig and not targetRig.down and not targetRig.fallCF then
          targetRig.loco = active.action or "idle"
          if targetRig.launchTo then
            local base, hop = Engine.launchStep(targetRig, tb, groundIgnore)
            targetRig.m:PivotTo(base + Vector3.new(0, hop, 0))
          else
            Engine.followWalk(targetRig, alpha)
          end
        end
        if active.partners then
          for _, cue in ipairs(active.partners) do
            local pr = rigs[cue.name]
            if pr and not pr.down and not pr.fallCF then
              pr.loco = cue.action or active.action or "idle"
              if pr.launchTo then
                local base, hop = Engine.launchStep(pr, tb, groundIgnore)
                pr.m:PivotTo(base + Vector3.new(0, hop, 0))
              else
                Engine.followWalk(pr, alpha)
              end
            end
          end
        end
        for _, r in pairs(rigs) do
          if r.hidden then continue end
          if r.seated then
            r.m:PivotTo(r.seatCF); r.loco = "sit"
          elseif r.fallCF then
            -- `fall`: whole body tips forward around the feet (ease-in), lands face-down at ~55% of the beat;
            -- with move_to it first flies there (launchStep) and lands at the destination
            local k = math.clamp(alpha * 1.8, 0, 1)
            local hop = 0
            if r.launchTo then r.fallCF, hop = Engine.launchStep(r, tb, groundIgnore) end
            r.m:PivotTo(Engine.lyingCF(r.fallCF, k, groundIgnore) + Vector3.new(0, hop, 0)); r.loco = "knockback"
            if k >= 1 and not r.fallDust then
              r.fallDust = true
              local h = r.fallCF.Position.Y - 0.2
              Engine.impactFrame(0.07); Engine.dustPuff((r.fallCF * CFrame.new(0, -h + 0.3, -2.5)).Position)
            end
          elseif r.down then
            r.m:PivotTo(Engine.lyingCF(r.standCF, 1, groundIgnore)); r.loco = "downed"
          end
        end
        -- V6: heads track the scene's focus (others look at the beat's target; the target looks at its first
        -- partner), and every actor is pushed out of furniture/walls before posing.
        local focus = model and model:GetPivot().Position + Vector3.new(0, 1.5, 0)
        local firstPartner = active.partners and active.partners[1] and rigs[active.partners[1].name]
        for _, r in pairs(rigs) do
          if r.hidden then continue end
          if r == targetRig then
            r.lookAt = firstPartner and (firstPartner.m:GetPivot().Position + Vector3.new(0, 1.5, 0)) or nil
          else
            r.lookAt = focus
          end
          if not (r.fallCF or r.down or r.seated) then
            Engine.separate(r, rigs)
            if not r.walkPath then Engine.pushOut(r, { castFolder }) end  -- a planned route already avoids furniture
          end
          Engine.applyPose(r, r.loco or "idle", t, alpha)
        end
      end

      -- camera follows the live HumanoidRootPart (model pivot); a missing target falls back to a partner or any
      -- actor instead of aiming at the world origin (an empty wall)
      local camModel = model
      if not camModel then
        local fb = active.partners and active.partners[1] and rigs[active.partners[1].name]
        if not fb then for _, r in pairs(rigs) do if not r.hidden then fb = r; break end end end
        camModel = fb and fb.m
        local special = active.target == "Crowd"
          or (Workspace:FindFirstChild("Props_" .. spec.id) and Workspace["Props_" .. spec.id]:FindFirstChild(active.target or ""))
        if not special and not warnedTarget[active] then
          warnedTarget[active] = true; warn("[AI-Vid] beat target missing: " .. tostring(active.target))
        end
      end
      local targetCF = camModel and camModel:GetPivot() or CFrame.new(0, 3, 0)
      local pos = targetCF.Position
      local groupWidth
      if model and active.partners then
        local left, rightX, nearZ, farZ = pos.X, pos.X, pos.Z, pos.Z
        for _, cue in ipairs(active.partners) do
          local pr = rigs[cue.name]
          local pp = pr and pr.m:GetPivot().Position
          -- V6: a partner far away (other end of a hallway) stays in the scene but doesn't drag the framing to an
          -- empty midpoint; the camera frames the target
          if pp and Vector2.new(pp.X - pos.X, pp.Z - pos.Z).Magnitude <= PARTNER_FRAME_MAX then
            left, rightX = math.min(left, pp.X), math.max(rightX, pp.X)
            nearZ, farZ = math.min(nearZ, pp.Z), math.max(farZ, pp.Z)
          end
        end
        pos = Vector3.new((left + rightX) / 2, pos.Y, (nearZ + farZ) / 2)
        groupWidth = rightX - left
      end

      local camCF = targetCF
      local groundCF = targetRig and (targetRig.fallCF or (targetRig.down and targetRig.standCF))
      if groundCF then
        -- frame the body on the ground: aim at its midpoint, oriented by the standing pose
        local h = groundCF.Position.Y - 0.2
        camCF = groundCF
        pos = (groundCF * CFrame.new(0, -h - 0.3, -2.6)).Position
      end
      local ignoreList = castFolder and { castFolder } or {}
      if Engine.truck then table.insert(ignoreList, Engine.truck) end
      local crowd = Workspace:FindFirstChild("Crowd_" .. spec.id); if crowd then table.insert(ignoreList, crowd) end  -- a passing truck must not yank the camera
      local partnerPos
      if active.partners and active.partners[1] and rigs[active.partners[1].name] then
        partnerPos = rigs[active.partners[1].name].m:GetPivot().Position
        local tp = targetCF.Position
        if Vector2.new(partnerPos.X - tp.X, partnerPos.Z - tp.Z).Magnitude > PARTNER_FRAME_MAX then partnerPos = nil end
      end
      local others = {}
      for _, r in pairs(rigs) do if r.m ~= camModel and not r.hidden and not r.invisible then table.insert(others, r.m) end end
      local crowdF = Workspace:FindFirstChild("Crowd_" .. spec.id)
      if crowdF then for _, cm in ipairs(crowdF:GetChildren()) do table.insert(others, cm) end end
      if camStickyBeat ~= active then camStickyBeat, camSticky = active, {} end  -- fresh framing choice per beat
      -- falls: low_hero keeps the head >= ~9 after easing; every other fall >= 7 so the lens never ends inside the body
      local minDist = active.action == "fall" and (active.cam == "low_hero" and 10.5 or 7) or nil
      -- a fall frames a body on the ground: face-shot rules (face cone / sticky re-picks) would flip mid-tip
      if active.action == "fall" then others, camSticky = nil, {} end
      cam.CFrame = Engine.computeCamera(camCF, pos, active.cam, active.motion, alpha, groupWidth, ignoreList, partnerPos, others, camSticky, minDist)
      local head = minDist and model and model:FindFirstChild("Head")
      if head then
        -- the aim point is the body's ground midpoint; the head sweeps closer while tipping, so also keep the
        -- live head >= minDist away (slide back along head->camera, same orientation)
        local away = cam.CFrame.Position - head.Position
        if away.Magnitude < minDist and away.Magnitude > 0.05 then
          cam.CFrame = CFrame.new(head.Position + away.Unit * minDist) * cam.CFrame.Rotation
        end
      end
      -- V6.2.1 tiny actors (scale < 0.5): a face-height close shot would aim into the sky. Lift the lens to
      -- floor + 3.5, keep >= 5.5 studs back and pitch DOWN at the torso so body + ground stay framed.
      if model and targetRig and (targetRig.scale or 1) < 0.5
        and (active.cam == "closeup" or active.cam == "ots" or active.cam == "reverse_ots") then
        local torso = model:FindFirstChild("Torso") or model.PrimaryPart
        if torso then
          local aim = torso.Position
          local fy = Engine.floorY(aim, ignoreList)
          local d = cam.CFrame.Position - aim
          local flat = Vector3.new(d.X, 0, d.Z)
          if flat.Magnitude < 0.05 then flat = model:GetPivot().LookVector * Vector3.new(1, 0, 1) end
          local p2 = aim + flat.Unit * math.max(flat.Magnitude, 5.5)
          p2 = Vector3.new(p2.X, math.max(cam.CFrame.Position.Y, fy + 3.5), p2.Z)
          cam.CFrame = CFrame.lookAt(p2, aim) * ROLL_90
        end
      end
      -- V6.2.1 outdoor sets: never look out past the perimeter into empty sky. If the lens points away from the
      -- set centre, mirror it to the other side of the target (only when that side has a clear line of sight).
      local setName = active.set or spec.set
      -- V6.2.2 school_yard: the brick building is at -Z, so the lens stays on the courtyard (+Z) side of the target
      local yardCams = { front = true, side_track = true, high_angle = true, ots = true, reverse_ots = true, wide = true }
      if model and ((setName == "school_yard" and yardCams[active.cam]) or (setName == "street"
        and (active.cam == "side_track" or active.cam == "ots" or active.cam == "wide"))) then
        local center = setOffsets[setName] or Vector3.zero
        local cp, aim = cam.CFrame.Position, targetCF.Position
        local look = (aim - cp) * Vector3.new(1, 0, 1)
        local toC = (center - cp) * Vector3.new(1, 0, 1)
        local wrongSide
        if setName == "school_yard" then wrongSide = cp.Z < aim.Z - 0.5
        else wrongSide = look.Magnitude > 0.05 and toC.Magnitude > 0.05 and look.Unit:Dot(toC.Unit) < -0.2 end
        if wrongSide then
          local m2 = Vector3.new(2 * aim.X - cp.X, cp.Y, 2 * aim.Z - cp.Z)
          local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Exclude; rp.FilterDescendantsInstances = ignoreList
          if not Workspace:Raycast(m2, aim - m2, rp) then
            local lookAt = cp + cam.CFrame.LookVector * (aim - cp).Magnitude
            cam.CFrame = CFrame.lookAt(m2, Vector3.new(2 * aim.X - lookAt.X, lookAt.Y, 2 * aim.Z - lookAt.Z)) * ROLL_90
          end
        end
      end
      if not model then
        -- non-actor targets: the crowd or a story prop (falls back to the actor framing above if not found)
        local framed
        if active.target == "Crowd" then
          cam.FieldOfView = 54
          framed = Engine.frameCrowd(spec, active.motion, alpha, cam.FieldOfView)
        else
          local sum, n = Vector3.zero, 0
          for _, r in pairs(rigs) do if not r.hidden then sum = sum + r.m:GetPivot().Position; n = n + 1 end end
          framed = Engine.frameProp(spec, active.target or "", active.motion, alpha, cam.FieldOfView, n > 0 and sum / n or nil)
        end
        if framed then cam.CFrame = framed end
      end
      -- V6.2.2 never spawn the lens inside a hedge/tree/wall (011 beat 12 went black): pull it toward the aim point
      cam.CFrame = Engine.unclipCamera(cam.CFrame, model and targetCF.Position or pos, ignoreList)
      -- final floor clamp after every override (prop/crowd framing, fall min-distance push-back)
      local clamped = Engine.clampCamAboveFloor(cam.CFrame.Position, ignoreList)
      if clamped ~= cam.CFrame.Position then cam.CFrame = CFrame.new(clamped) * cam.CFrame.Rotation end
      -- fall beats: the head sweeps down fastest at landing, so the head-distance push + floor clamp could snap the
      -- lens several studs in a frame; ease toward the target instead (the cut into the beat still snaps)
      if active.action == "fall" then
        if fallCamBeat == active and fallCamCF then
          cam.CFrame = fallCamCF:Lerp(cam.CFrame, 0.18)
          local c2 = Engine.clampCamAboveFloor(cam.CFrame.Position, ignoreList)
          if c2 ~= cam.CFrame.Position then cam.CFrame = CFrame.new(c2) * cam.CFrame.Rotation end
        end
        fallCamBeat, fallCamCF = active, cam.CFrame
      end
      -- V6.2 `face_mid:` swaps the face once, halfway through the beat (reaction mid-sentence)
      if not faceMidDone and t >= active.t0 + active.dur * 0.5 then
        faceMidDone = true
        if targetRig and active.face_mid and active.face_mid ~= "" then Engine.setFace(targetRig.m, active.face_mid) end
        for _, cue in ipairs(active.partners or {}) do
          if rigs[cue.name] and cue.face_mid and cue.face_mid ~= "" then Engine.setFace(rigs[cue.name].m, cue.face_mid) end
        end
      end
      Engine.updateCounters(rigs, cam.CFrame.Position)
      RunService.RenderStepped:Wait()
    end
    Engine.resetCamera()
  end
  return runner
end

_G.AIVidCore = Engine
print("[AI-Vid V5.4] core_engine.luau loaded (R6 catalog + relative cameras + clearShot + multi-actor locomotion).")
return Engine
