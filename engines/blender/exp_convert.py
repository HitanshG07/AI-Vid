import bpy, sys, math, bmesh
base="C:/AI-Vid/assets/meshes/props/"
for n in ["GrandmaArmchair","TestTubeRack"]:
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.wm.obj_import(filepath=base+n+".obj")
    print(n,[(o.name,[m.name for m in o.data.materials]) for o in bpy.data.objects])
    bpy.ops.export_scene.gltf(filepath=base+"glb/"+n+".glb",export_format='GLB')
# head
bpy.ops.wm.read_factory_settings(use_empty=True)
bm=bmesh.new()
bmesh.ops.create_cube(bm,size=1.0)
for v in bm.verts: v.co.x*=1.2;v.co.y*=1.2;v.co.z*=1.2
bmesh.ops.bevel(bm,geom=list(bm.edges),offset=0.18,segments=3,affect='EDGES')
me=bpy.data.meshes.new("Head");bm.to_mesh(me);bm.free()
ob=bpy.data.objects.new("Head",me);bpy.context.collection.objects.link(ob)
bpy.context.view_layer.objects.active=ob;ob.select_set(True)
# UV: front face is -Y in blender -> glTF +Z? (blender -Y -> gltf... front of glTF is +Z = Blender -Y)
uv=me.uv_layers.new(name="UV")
for p in me.polygons:
    for li in p.loop_indices:
        co=me.vertices[me.loops[li].vertex_index].co
        # planar projection along Y; only front (y<0) meaningful, others sample corner
        u=co.x/1.2+0.5; v=co.z/1.2+0.5
        if p.center.y>-0.45: u,v=0.02,0.02
        uv.data[li].uv=(u,v)
mat=bpy.data.materials.new("HeadMat");mat.use_nodes=True
t=mat.node_tree.nodes.new("ShaderNodeTexImage")
t.image=bpy.data.images.load("C:/AI-Vid/assets/faces/generated_pngs/Hero/Hero_Determined_head.png")
mat.node_tree.links.new(t.outputs[0],mat.node_tree.nodes["Principled BSDF"].inputs[0])
me.materials.append(mat)
bpy.ops.export_scene.gltf(filepath="C:/AI-Vid/assets/meshes/heads/Hero_Determined_blenderhead.glb",export_format='GLB')
