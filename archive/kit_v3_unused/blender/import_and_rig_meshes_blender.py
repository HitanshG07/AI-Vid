#!/usr/bin/env python3
"""
engines/blender/import_and_rig_meshes_blender.py
Imports any multi-part riggable character (.obj) or prop (.obj) from
`assets/meshes/characters/` and `assets/meshes/props/` into Blender 4.x,
automatically constructs a full R15 Armature from `rig_joints_metadata.json`,
parents each mesh group to its corresponding bone, and attaches the 512x512
face decal PNGs from `assets/faces/generated_pngs/`.

Usage:
  blender -b -P engines/blender/import_and_rig_meshes_blender.py -- --char Hero --emotion Determined
"""
import json
import math
import pathlib
import sys

try:
    import bpy
    import mathutils
except ImportError:
    print("Run this script inside Blender 4.x: blender -b -P engines/blender/import_and_rig_meshes_blender.py")
    sys.exit(0)

REPO_ROOT = pathlib.Path(__file__).resolve().parent.parent.parent
META_PATH = REPO_ROOT / "assets/meshes/characters/rig_joints_metadata.json"
CHAR_MESH_DIR = REPO_ROOT / "assets/meshes/characters"
PROP_MESH_DIR = REPO_ROOT / "assets/meshes/props"
FACE_PNG_DIR = REPO_ROOT / "assets/faces/generated_pngs"


def import_and_rig_character(char_name="Hero", emotion="Determined", location=(0.0, 0.0, 0.0)):
    meta = json.loads(META_PATH.read_text(encoding="utf-8"))
    joints = meta["joints"]
    spec = meta["characters"][char_name]
    sc = spec.get("scale", 1.0)

    obj_path = CHAR_MESH_DIR / f"{char_name}_R15_Riggable.obj"
    bpy.ops.wm.obj_import(filepath=str(obj_path), use_split_objects=True, use_split_groups=True)
    imported_objs = list(bpy.context.selected_objects)

    # Create Armature at character root
    arm_data = bpy.data.armatures.new(f"{char_name}_ArmatureData")
    arm_obj = bpy.data.objects.new(f"{char_name}_Rig", arm_data)
    bpy.context.collection.objects.link(arm_obj)
    arm_obj.location = location

    bpy.context.view_layer.objects.active = arm_obj
    bpy.ops.object.mode_set(mode="EDIT")

    # Root bone
    root_bone = arm_data.edit_bones.new("HumanoidRootPart")
    root_bone.head = (0.0, 0.0, 2.0 * sc)
    root_bone.tail = (0.0, 0.0, 2.5 * sc)

    for jname, jinfo in joints.items():
        px, py, pz = [v * sc for v in jinfo["pivot"]]
        cx, cy, cz = [v * sc for v in jinfo["center"]]
        eb = arm_data.edit_bones.new(jname)
        # Convert Y-up OBJ coordinates to Blender Z-up coordinates
        eb.head = (px, -pz, py)
        eb.tail = (cx, -cz, cy + 0.25 * sc)
        parent_name = jinfo["parent"]
        if parent_name in arm_data.edit_bones:
            eb.parent = arm_data.edit_bones[parent_name]

    bpy.ops.object.mode_set(mode="OBJECT")

    # Parent each imported sub-mesh object to its matching R15 bone
    for mobj in imported_objs:
        base_name = mobj.name.split(".")[0]
        target_bone = base_name if base_name in joints else ("Head" if "Hair" in base_name else "UpperTorso")
        mobj.parent = arm_obj
        mobj.parent_type = "BONE"
        mobj.parent_bone = target_bone

    # Assign the 512x512 face PNG texture to Head
    set_character_face_png(arm_obj, char_name, emotion)
    return arm_obj


def set_character_face_png(arm_obj, char_name, emotion):
    png_path = FACE_PNG_DIR / char_name / f"{char_name}_{emotion}_head.png"
    if not png_path.exists():
        return
    for child in arm_obj.children:
        if child.name.startswith("Head"):
            mat = bpy.data.materials.new(name=f"{char_name}_Face_{emotion}")
            mat.use_nodes = True
            bsdf = mat.node_tree.nodes.get("Principled BSDF")
            tex = mat.node_tree.nodes.new("ShaderNodeTexImage")
            tex.image = bpy.data.images.load(str(png_path))
            mat.node_tree.links.new(bsdf.inputs["Base Color"], tex.outputs["Color"])
            if child.data.materials:
                child.data.materials[0] = mat
            else:
                child.data.materials.append(mat)


def import_prop(prop_name="AcidBottle", location=(0.0, 0.0, 0.0)):
    obj_path = PROP_MESH_DIR / f"{prop_name}.obj"
    bpy.ops.wm.obj_import(filepath=str(obj_path), use_split_objects=False, use_split_groups=True)
    prop_obj = bpy.context.selected_objects[0]
    prop_obj.name = f"Prop_{prop_name}"
    prop_obj.location = location
    return prop_obj


def pose_bone_deg(arm_obj, bone_name, rx=0.0, ry=0.0, rz=0.0):
    pb = arm_obj.pose.bones.get(bone_name)
    if pb:
        pb.rotation_mode = "XYZ"
        pb.rotation_euler = (math.radians(rx), math.radians(ry), math.radians(rz))


if __name__ == "__main__":
    print("Blender 4.x Riggable Mesh Importer ready.")
