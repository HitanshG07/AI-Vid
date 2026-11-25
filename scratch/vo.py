t=open('scratch/tmp_extract_v5/AI-Vid/.claude/skills/verify-originality/SKILL.md',encoding='utf-8').read()
t=t.replace("# Verify Originality\n","# Verify Originality\n**Non-Claude AIs:** where this says \"spawn an agent\" (researcher = low tier, verifier = mid tier), do that step yourself on a model of that tier; role files are in `.claude/agents/`. Read `CORE.md` and `config.yaml` first; beat_drop is exempt from the gate.\n\n",1)
t=t.replace("(haiku)","(low tier)").replace("(sonnet)","(mid tier)")
t+="\nOn PASS of the chosen premise, also write the receipt `ledger/verification/<ID>.md`.\n"
open('.claude/skills/verify-originality/SKILL.md','w',encoding='utf-8',newline='\n').write(t)
