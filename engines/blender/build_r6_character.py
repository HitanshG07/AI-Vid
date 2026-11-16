"""Build an authentic-proportion Roblox R6 character in Blender and export FBX for Roblox Studio.

Units = Roblox studs (1 Blender unit = 1 stud). Parts are separate objects named like Roblox R6
(Head, Torso, Left Arm, Right Arm, Left Leg, Right Leg, Hair, Face) so Studio can recolour by name.
Usage:
  blender -b -P engines/blender/build_r6_character.py -- --name hero --shirt 1E2D5A --pants 2D4678 --skin EAB892 --hair 4D2E17
Outputs: assets/rigs/<name>.fbx and assets/rigs/<name>_preview.png
"""
import argparse, math, os, sys
import bpy

argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
p = argparse.ArgumentParser()
p.add_argument("--name", default="hero")
p.add_argument("--shirt", default="1E2D5A"); p.add_argument("--pants", default="2D4678")
p.add_argument("--skin", default="EAB892");  p.add_argument("--hair", default="4D2E17")
p.add_argument("--out", default="C:/AI-Vid/assets/rigs")
a = p.parse_args(argv)

def rgba(h):
    return tuple(int(h[i:i + 2], 16) / 255 for i in (0, 2, 4)) + (1.0,)

def mat(name, hexcol, rough=0.6):
    m = bpy.data.materials.new(name); m.use_nodes = True
    b = m.node_tree.nodes["Principled BSDF"]
    b.inputs["Base Color"].default_value = rgba(hexcol); b.inputs["Roughness"].default_value = rough
    return m

def block(name, size, loc, m, bevel=0.06, cyl=False):
    if cyl:  # classic Roblox head: vertical cylinder, heavily bevelled
        bpy.ops.mesh.primitive_cylinder_add(vertices=32, radius=size[0] / 2, depth=size[2], location=loc)
    else:
        bpy.ops.mesh.primitive_cube_add(size=1, location=loc)
        bpy.context.object.scale = size
    o = bpy.context.object; o.name = name
    bpy.ops.object.transform_apply(scale=True)
    bv = o.modifiers.new("Bevel", "BEVEL"); bv.width = bevel; bv.segments = 4
    bpy.ops.object.modifier_apply(modifier="Bevel")
    bpy.ops.object.shade_smooth()
    o.data.materials.append(m)
    return o

bpy.ops.wm.read_factory_settings(use_empty=True)
skin, shirt, pants, hair = mat("Skin", a.skin), mat("Shirt", a.shirt), mat("Pants", a.pants), mat("Hair", a.hair, 0.8)
black = mat("FaceInk", "111111", 0.3)

# Standard R6 layout (feet at z=0, facing -Y): legs 1x1x2, torso 2x1x2, arms 1x1x2, head ~1.25 dia x 1.2
block("Left Leg",  (1, 1, 2), (-0.5, 0, 1), pants)
block("Right Leg", (1, 1, 2), ( 0.5, 0, 1), pants)
block("Torso",     (2, 1, 2), (0, 0, 3), shirt)
block("Left Arm",  (1, 1, 2), (-1.5, 0, 3), shirt)   # hoodie sleeves
block("Right Arm", (1, 1, 2), ( 1.5, 0, 3), shirt)
head = block("Head", (1.25, 1.25, 1.2), (0, 0, 4.6), skin, bevel=0.22, cyl=True)
# hair cap: flattened bevelled block slightly larger than head, plus a fringe
block("Hair", (1.4, 1.4, 0.45), (0, 0.05, 5.15), hair, bevel=0.18)
block("HairFringe", (1.3, 0.25, 0.35), (0, -0.6, 4.95), hair, bevel=0.1)
# classic smiley face: two eyes + a mouth on the head front (-Y)
r = 0.625
for x in (-0.22, 0.22):
    block("FaceEye", (0.12, 0.05, 0.22), (x, -r + 0.01, 4.72), black, bevel=0.03)
bpy.ops.mesh.primitive_torus_add(major_radius=0.22, minor_radius=0.035, location=(0, -r + 0.02, 4.47),
                                 rotation=(math.pi / 2, 0, 0))
mouth = bpy.context.object; mouth.name = "FaceMouth"
# keep only the lower half of the torus = smile
bpy.ops.object.mode_set(mode="EDIT"); bpy.ops.mesh.select_all(action="DESELECT"); bpy.ops.object.mode_set(mode="OBJECT")
for v in mouth.data.vertices:
    v.select = v.co.y > 0  # torus local Y is world Z after rotation; upper half
bpy.ops.object.mode_set(mode="EDIT"); bpy.ops.mesh.delete(type="VERT"); bpy.ops.object.mode_set(mode="OBJECT")
mouth.data.materials.append(black)

os.makedirs(a.out, exist_ok=True)
fbx = os.path.join(a.out, f"{a.name}.fbx")
bpy.ops.export_scene.fbx(filepath=fbx, use_selection=False, object_types={"MESH"}, apply_unit_scale=True,
                         global_scale=1.0, axis_forward="-Z", axis_up="Y", path_mode="COPY", embed_textures=True)

# preview render
s = bpy.context.scene; s.render.engine = "BLENDER_EEVEE_NEXT" if "BLENDER_EEVEE_NEXT" in [e.identifier for e in s.render.bl_rna.properties["engine"].enum_items] else "BLENDER_EEVEE"
s.render.resolution_x, s.render.resolution_y = 1080, 1350
bpy.ops.mesh.primitive_plane_add(size=30); bpy.context.object.data.materials.append(mat("Floor", "8A8F99", 0.9))
cam = bpy.data.objects.new("Cam", bpy.data.cameras.new("Cam")); s.collection.objects.link(cam); s.camera = cam
cam.location = (3.5, -9, 4.2); cam.rotation_euler = (math.radians(84), 0, math.radians(21))
sun = bpy.data.objects.new("Sun", bpy.data.lights.new("Sun", "SUN")); sun.data.energy = 4
s.collection.objects.link(sun); sun.rotation_euler = (math.radians(45), math.radians(10), math.radians(25))
w = bpy.data.worlds.new("W"); s.world = w; w.color = (0.55, 0.65, 0.8)
s.render.filepath = os.path.join(a.out, f"{a.name}_preview.png")
bpy.ops.render.render(write_still=True)
print("EXPORTED", fbx)
