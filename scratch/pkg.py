import zipfile,os,glob
R='C:/AI-Vid'
names=set(); 
for z in ['audits/HANDOFF_PACKAGE_V5_2026-11-21.zip','Package/HANDOFF_PACKAGE_V5.3_2026-11-21.zip']:
    for n in zipfile.ZipFile(f'{R}/{z}').namelist():
        if n.endswith('/'): continue
        n=n.split('/',1)[1] if '/' in n else n
        names.add(n)
for d in ['.claude','.agents','.agent','.cursor','engines/roblox/sets','templates/formats','docs/_archive/legacy_v4']:
    for r,_,fs in os.walk(f'{R}/{d}'):
        for f in fs: names.add(os.path.relpath(f'{r}/{f}',R).replace(chr(92),'/'))
for f in 'CORE.md config.yaml AGENTS.md GEMINI.md CLAUDE.md START_HERE.md README.md .claudeignore .cursorignore requirements.txt setup.ps1'.split(): names.add(f)
for f in glob.glob(f'{R}/pipeline/*.py'): names.add('pipeline/'+os.path.basename(f))
ok=lambda n:'__pycache__' not in n and not n.endswith('.pyc')
names=sorted(n for n in names if ok(n))
out=f'{R}/audits/HANDOFF_PACKAGE_V5.3_AUDIT_2026-11-22.zip'
skipped=[]
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
    for n in names:
        p=f'{R}/{n}'
        if os.path.isfile(p): z.write(p,'AI-Vid/'+n)
        else: skipped.append(n)
print('files',len(names)-len(skipped),'size',os.path.getsize(out),'skipped',len(skipped))
open(f'{R}/scratch/skipped.txt','w').write('\n'.join(skipped))
z=zipfile.ZipFile(out); print('testzip',z.testzip())
import tempfile
t=f'{R}/scratch/tmp_verify_pkg'; os.makedirs(t); z.extractall(t)
bad=[m for m in z.namelist() if open(f'{t}/{m}','rb').read()!=open(f'{R}/{m[6:]}','rb').read()]
print('mismatch',bad)
