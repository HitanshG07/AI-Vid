import bpy,bmesh,os
d="C:/AI-Vid/assets/meshes/characters/"
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.wm.obj_import(filepath=d+"Mia_R15_Riggable.obj")
kd={};cur=None
for l in open(d+"Mia_R15_Riggable.mtl"):
    t=l.split()
    if not t: continue
    if t[0]=="newmtl":cur=t[1]
    elif t[0]=="Kd":kd[cur]=[float(x) for x in t[1:4]]
names=list(kd)
cell={n:(i%16,i//16) for i,n in enumerate(names)}
img=bpy.data.images.load(d+"Mia_atlas.png"); img.pack()
mat=bpy.data.materials.new("MiaAtlas");mat.use_nodes=True
tn=mat.node_tree.nodes.new("ShaderNodeTexImage");tn.image=img;tn.interpolation='Closest'
b=mat.node_tree.nodes["Principled BSDF"];mat.node_tree.links.new(tn.outputs[0],b.inputs["Base Color"])
b.inputs["Roughness"].default_value=0.8
for o in bpy.data.objects:
    if o.type!='MESH':continue
    if o.name=="Hair_Ponytail":
        print("PONY y",sum(v.co.y for v in o.data.vertices)/len(o.data.vertices))
    me=o.data;uv=me.uv_layers.get("UVMap") or me.uv_layers.new(name="UVMap")
    slotnames=[m.name if m else None for m in me.materials]
    fp=[]
    if o.name=="Head":
        fp=[p for p in me.polygons if p.normal.z>0.9]
        xs=[me.vertices[i].co.x for p in fp for i in p.vertices];zs=[me.vertices[i].co.y for p in fp for i in p.vertices]
        x0,x1,z0,z1=min(xs),max(xs),min(zs),max(zs);print("HEADFRONT",len(fp),x0,x1,z0,z1)
        fs={p.index for p in fp}
    else: fs=set()
    for p in me.polygons:
        for li in p.loop_indices:
            if p.index in fs:
                co=me.vertices[me.loops[li].vertex_index].co
                # image-left is character's left as seen from front; viewer at +Y(blender) sees +X on the left
                u=(co.x-x0)/(x1-x0)*0.5; v=(co.y-z0)/(z1-z0)
                uv.data[li].uv=(u,v)
            else:
                c,r=cell[slotnames[p.material_index]]
                uv.data[li].uv=((512+c*32+16)/1024,1-(r*32+16)/512)
    me.materials.clear();me.materials.append(mat)
bpy.ops.wm.save_as_mainfile(filepath=d+"Mia_full.blend")
bpy.ops.export_scene.gltf(filepath=d+"Mia_full.glb",export_format='GLB')
bpy.ops.wm.obj_export(filepath=d+"Mia_full.obj",export_materials=True,path_mode='COPY')
