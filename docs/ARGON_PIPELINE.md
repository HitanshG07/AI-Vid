# Argon Asset Pipeline (all AIs follow this)

From 2026-11-16, **Argon builds every asset**: characters, extras, props, sets, materials, lighting and grade presets.
It also keeps **one locked theme/style** across all stories. AIs do not hand-build assets any more. They write a complete
**Production Manifest** (`stories/<ID>/MANIFEST.md`, from `templates/production_manifest_template.md`) and an
**Argon handover package**. Argon builds from those, and the engine animates and records.

## Who does what
| Who | Does |
|---|---|
| Showrunner AI (Opus/best) | Story + script + **MANIFEST.md** (every character action, emotion, asset, mesh, animation, VFX, beat by beat) |
| Haiku/low tier | Builds the Argon handover package (`audits/ARGON-<NNN>_<date>_<story>_part1of1.zip`) |
| **Argon** | Builds/syncs all assets into Roblox Studio to the style lock below, using the build prompt from the package |
| Engine AI (Sonnet/Opus) | Loads Argon assets, animates from MANIFEST section G, records **only when the user says "record"** |
| Verifier (Sonnet) | Rejects a MANIFEST that leaves any section or beat incomplete |

Fallback: if Argon can't make something, use Studio MCP (`generate_avatar`, `generate_mesh`, etc.), as in the AGENTS.md Asset process.

## Style lock (every asset, every story)
1. **Blocky Roblox only.** Main cast, kids, aged variants and extras share one R15/R6 silhouette:
   - 2x2x1 torso, 1x2x1 fingerless limbs, beveled 1.2 head
   - Layered Roblox hair and clothing
   - No realistic sculpted bodies, and **never Blender-built characters**
2. **Faces:** v1 style with 3-layer eyes:
   - White sclera with a dark outline
   - Iris and pupil
   - 2 white catchlights
   Skin hex is locked per character in `assets/faces/skin_tones.json` across every emotion, so the head never mismatches the neck. Never use the default `:|` face, including on extras.
3. **Standard emotion set** (make only the ones the manifest lists): Determined, Happy, Shocked, Worried, Crying, Smirk, Sad, Straining.
4. **Props:**
   - `CanQuery = true`, because the clearShot occlusion guard raycasts them.
   - A `Root` plus a `GripAttachment`. Held props are welded (WeldConstraint) to LeftHand/RightHand.
   - Real-world scale against a 5-stud character.
5. **Body overlays** (aging, scars, glow marks) sit flush inside the limb, as thin bands or decals. Never use oversized boxes that hover off the hand.
6. **Power VFX:** thin neon rings (~0.05 stud) or soft particles. They never hide a face or hand.
   Flash caps: brightness +0.04, bloom +0.12, light 2.5 with range 8.
7. **Sets:** signs and posters sit ≥1.2 studs below the ceiling (safe for 9:16). Walls and ceiling are closed, so nothing leaks into frame.
8. **Grade presets**, kept in Lighting as named presets:
   | Key | Use | Look |
   |---|---|---|
   | `G.n` | present / golden hour | warm #FFF4E6, contrast +0.08, sun rays, DOF on extras |
   | `G.r` | rewind / power | cool cyan #A8C8FF, saturation −0.25 |
   | `G.s` | memory / flashback | sepia #FFDCAA, saturation −0.65, fill ≤0.8 |
   | `G.h` | horror / night | indigo #182038, SpotLight + Beam cones |
   New stories may add a preset (e.g. `G.w` winter). Name it in MANIFEST section B, and Argon adds it.

Visual reference: `reference/design_bible/01..05_*.jpg`. Treat 05 as the DO/DON'T board.

## Storage (repo is the source of truth)
Every Argon output gets exported or saved into the repo:
- `assets/rigs/` for characters (.rbxm)
- `assets/maps/` for sets (.rbxm / Luau / .rbxl)
- `assets/meshes/props/` for props
- `assets/faces/` for faces
- `assets/sfx/` for sound

Each one gets a row in `assets/INDEX.md` with: path, what it is, "Argon", the prompt used, and the story. **Reuse before building**: the manifest marks each asset `REUSE <path>` or `NEW`.

## Studio rules (unchanged)
- One Studio job at a time. A timeout doesn't mean failure, so check Workspace before retrying.
- Do non-Studio work in parallel.
- Never record until the user says "record".
- Capture runs at 30 fps.

---

## PROMPT 1: Argon theme lock (paste once, re-paste if Argon forgets)
```text
You are the Lead 3D Asset & Theme Architect for my Roblox story studio (C:\AI-Vid). From now on you build and sync ALL assets
(characters, bystanders, props, sets, materials, lighting/grade presets) for every story. Lock this standard on every asset:

1. UNIFIED BLOCKY ROBLOX STYLE: every character (leads, kid/aged variants, all extras) uses the same beveled blocky R15 silhouette
   (2x2x1 torso, 1x2x1 fingerless limbs, beveled 1.2 head) with layered Roblox hair + clothing. No realistic bodies. No default :| faces.
   Extras are fully dressed and varied (never clones).
2. FACES: v1 2D style with 3-layer eyes (white sclera + dark outline, iris/pupil, TWO white catchlights). One skin hex per character,
   identical across all emotion variants (Determined, Happy, Shocked, Worried, Crying, Smirk, Sad, Straining) so head swaps never
   change skin colour vs the neck.
3. PROPS: real scale vs a 5-stud character, CanQuery = true, a Root part + GripAttachment so held props WeldConstraint to
   LeftHand/RightHand. Named sub-parts for anything that animates (clock hands, liquid, cracks, labels).
4. OVERLAYS/VFX: aging/scars/glow sit flush inside the limb (thin bands/decals), never boxes larger than the limb.
   Power effects are thin neon rings (~0.05 stud) or soft particles; never hide faces or hands.
5. LIGHTING PRESETS: G.n golden present (#FFF4E6, contrast +0.08, rays, DOF), G.r rewind cyan (#A8C8FF, sat -0.25),
   G.s sepia memory (#FFDCAA, sat -0.65, fill <=0.8), G.h horror night (#182038, spot+beam). Add new presets only when a manifest asks.
6. SETS: closed walls/ceiling, signs >=1.2 studs below the ceiling, framed for vertical 9:16.
7. NAMING: models named exactly as the manifest says (e.g. Hero, Mia, Extra1, PR.Acid, Set_ChemLab) so our engine finds them.
Confirm the lock, then wait for the story build prompt.
```

## PROMPT 2: per-story build (generated per story inside the handover package)
The per-story build prompt is `02_ARGON_BUILD_PROMPT_<ID>.txt` in the handover package. It is built from MANIFEST sections B–F:
- every set
- every character with its emotions
- every NEW asset with its size, material, colour and socket
- every grade

It ends with "export each to the listed repo path and report back the list".
