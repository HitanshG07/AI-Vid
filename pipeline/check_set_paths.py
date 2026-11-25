"""Studio walkway check: for every set in assets/manifest.json, sweep a body-sized sphere (r=0.8, centre 1.6 studs
above the feet) along the straight line between every pair of spots; a blocked line passes only if the engine's
PathfindingService agent (radius 2.5, no jumping) can route around it.

Usage: python pipeline/check_set_paths.py [--set school_yard]   (exit 1 if any path is blocked)
Sets it loads that weren't already in Workspace are moved to ServerStorage._Old/path_check afterwards (never deleted).
"""
import argparse, json, re, sys
from config_loader import ROOT, load_config
from daemon import StudioMCP

PROBE = r'''
local spots = game:GetService("HttpService"):JSONDecode([==[%s]==])
local before = {}
for _, c in ipairs(workspace:GetChildren()) do before[c] = true end
_G.AIVidSets["%s"]()
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = {}
local names, out, routed = {}, {}, 0
for n in pairs(spots) do table.insert(names, n) end
table.sort(names)
for i = 1, #names do for j = i + 1, #names do
  local a, b = spots[names[i]], spots[names[j]]
  local pa, pb = Vector3.new(a[1], a[2] + 1.6, a[3]), Vector3.new(b[1], b[2] + 1.6, b[3])
  local hit = workspace:Spherecast(pa, 0.8, pb - pa, params)
  if (hit and hit.Instance.CanCollide) or math.abs(a[2] - b[2]) > 0.5 then  -- blocked, or a level change (stage ramp)
    -- not a straight walk: fine as long as the engine's PathfindingService agent can route around it
    local path = game:GetService("PathfindingService"):CreatePath({ AgentRadius = 2.5, AgentHeight = 5, AgentCanJump = false })
    local fa, fb = Vector3.new(a[1], a[2] + 0.2, a[3]), Vector3.new(b[1], b[2] + 0.2, b[3])
    local ok = pcall(function() path:ComputeAsync(fa, fb) end)
    if ok and path.Status == Enum.PathStatus.Success then
      routed += 1
    else
      table.insert(out, names[i] .. " -> " .. names[j] .. " : " .. (hit and hit.Instance:GetFullName() or "level change") .. " (no path)")
    end
  end
end end
local old = game.ServerStorage:FindFirstChild("_Old") or Instance.new("Folder", game.ServerStorage)
old.Name = "_Old"
local bin = old:FindFirstChild("path_check") or Instance.new("Folder", old)
bin.Name = "path_check"
for _, c in ipairs(workspace:GetChildren()) do if not before[c] then c.Parent = bin end end
local r = { "PATHS " .. #names .. " spots, " .. routed .. " routed around furniture, " .. #out .. " blocked" }
for _, l in ipairs(out) do table.insert(r, "BLOCKED " .. l) end
return table.concat(r, " | ")
'''


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--set")
    a = ap.parse_args()
    cfg = load_config()
    sets = json.loads((ROOT / "assets" / "manifest.json").read_text(encoding="utf-8"))["sets"]
    mcp = StudioMCP(cfg["automation"]["studio_mcp_cmd"])
    blocked = 0
    try:
        for name, s in sets.items():
            if (a.set and name != a.set) or len(s.get("spots", {})) < 2:
                continue
            src = (ROOT / s["luau"]).read_text(encoding="utf-8")
            src = re.sub(r"\nreturn [^\n]*\s*$", "\n", src)  # the set file ends with `return fn`; we call it ourselves
            out = mcp.luau(src + PROBE % (json.dumps(s["spots"]), name))
            lines = [l.strip() for l in out.replace("\n", "|").split("|") if "PATHS" in l or "BLOCKED" in l]
            print(f"[{name}]", *lines, sep="\n  ")
            blocked += sum("BLOCKED" in l for l in lines)
    finally:
        mcp.close()
    sys.exit(1 if blocked else 0)


if __name__ == "__main__":
    main()
