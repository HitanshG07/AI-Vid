from PIL import Image
d='C:/AI-Vid/assets/meshes/characters/'
kd={};cur=None
for l in open(d+'Mia_R15_Riggable.mtl'):
    t=l.split()
    if not t: continue
    if t[0]=='newmtl':cur=t[1]
    elif t[0]=='Kd':kd[cur]=[float(x) for x in t[1:4]]
names=list(kd)
# atlas: face 512x512 at left, 32px swatches on the right (16 cols)
at=Image.new("RGBA",(1024,512),(255,255,255,255))
at.paste(Image.open("C:/AI-Vid/assets/faces/generated_pngs/Mia/Mia_Happy_head.png").convert("RGBA"),(0,0))
cell={}
for i,n in enumerate(names):
    c,r=i%16,i//16; cell[n]=(c,r)
    col=tuple(int(round(x*255)) for x in kd[n])+(255,)
    at.paste(Image.new("RGBA",(32,32),col),(512+c*32,r*32))
at.save(d+"Mia_atlas.png")
