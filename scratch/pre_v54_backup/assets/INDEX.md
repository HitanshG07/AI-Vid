# Asset Index — reusable across all stories (reference by path in beats.json)
| Path | Type | Description | How generated (tool + prompt) | Source / License |
|---|---|---|---|---|
| reference/design_bible/01..05_*.jpg | style refs | cast sheets, extras/props sheet, 9:16 framing, DO/DON'T board | external kit v3 | kit (update/kit_v3) |
| assets/faces/skin_tones.json | style data | locked skin hex per character | external kit v3 | kit |
| archive/kit_v3_unused/ | unused | kit character .obj + Blender rigger (banned: no Blender characters) | external kit v3 | kit |
| assets/faces/classic_v1/*.png (neutral, scared, shocked, grin, determined, proud) + _sheet.png | face decals | LOCKED 2026-11-17: flat 2D transparent decals for R6 heads; swap = Head `face` Decal Texture | engines/faces/classic_faces.py | own |
| assets/faces/classic_v1/ids.json | face ids | uploaded Roblox image ids per emotion for classic_v1 | upload of the PNGs above | own |
| engines/faces/classic_faces.py | face generator | draws the classic_v1 PNGs; add new emotions here | written by AI | own |
| engines/roblox/cast_001.luau | cast builder | story 001 CAST (catalog ids + skin + default face), `build(...)`, `setFace(model, emotion)`; pattern for every `cast_<ID>.luau` | written by AI; R6 `CreateHumanoidModelFromDescription` + `SearchCatalog` items | own |
| engines/roblox/sets/street_002_winter.luau | map builder | story 002 `Set_Street002`: winter Main Street at night (snow road/sidewalks, bakery, laundromat with glass door + dryer vent, Theo's porch + boot rack, 6 streetlamps, snowbanks, bare trees) + `Props002` (NightVan with cab, Cat, HotBottle, IceBootL/R, Radio with LED, DriverCap, CBMic, RoofDebris, Bread). World origin (900,0,0); yields every 200 parts | written by AI (Opus); Studio Parts only | own |
| engines/roblox/sets/laundromat_002.luau | map builder | story 002 `Set_Laundromat002`: 24h laundromat interior (checker floor, 10 dryers, hollow dryer #3, table, chairs, coin machine, glass front door, street backdrop) + `Movable` (Dryer3Door with Hinge attribute, HotSocks, Crack, Dryer3Steam). World origin (900,0,70); yields every 200 parts | written by AI (Opus); Studio Parts only | own |
| engines/roblox/sets/lake_002.luau | Story 002 frozen lake (Set_Lake002: round ice, pines, THIN ICE sign, hidden holes/cracks/steam/hand/CB radio props) | Studio-built Luau, WORLD (1030,0,0) | Roblox-native parts |
| engines/roblox/sets/home_002.luau | Story 002 living room (Set_Home002: couch, footstool, lamp, window) at WORLD (900,0,140) | Studio-built Luau | Roblox-native parts |
| engines/roblox/cast_memory_doors.luau | cast builder (kept character assets of a removed story) | Ash, Pip, Bell and the Baker. Classic R6 rigs, existing catalog outfits and in-house face decals. | R6 CreateHumanoidModelFromDescription, reusing checked catalog assets | Roblox catalog and in-house face decals |
| engines/roblox/cast_apology_stones.luau | cast builder (kept character assets of a removed story) | The characters of the removed apology-stones story. Classic R6 rigs, catalog outfits, in-house face decals. | R6 CreateHumanoidModelFromDescription, catalog items | Roblox catalog and in-house face decals |
| assets/sfx/roblox-story-bg.mp3 | audio (BGM) | Locked standard background music bed for all reels (continuous loop, --bgm-gain 0.14) | owner-provided (2026-11-20) | own |
