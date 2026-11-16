import bpy,re
d="C:/AI-Vid/assets/meshes/characters/"
for n in ["Hero","Mia"]:
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.wm.obj_import(filepath=d+n+"_R15_Riggable.obj")
    kd={};cur=None
    for l in open(d+n+"_R15_Riggable.mtl"):
        t=l.split()
        if not t: continue
        if t[0]=="newmtl":cur=t[1]
        elif t[0]=="Kd":kd[cur]=[float(x) for x in t[1:4]]+[1]
    for m in bpy.data.materials:
        m.use_nodes=True
        b=m.node_tree.nodes.get("Principled BSDF")
        if m.name in kd: b.inputs["Base Color"].default_value=kd[m.name]; m.diffuse_color=kd[m.name]
        else: print("NOKD",m.name)
    print(n,[o.name for o in bpy.data.objects])
    bpy.ops.export_scene.gltf(filepath=d+n+"_R15_Riggable.glb",export_format='GLB')
