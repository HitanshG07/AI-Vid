"""Build serial-numbered audit packages: only audit-relevant files, each zip <= 100 MB.

Usage: python audits/make_audit_package.py --story stories/007_wrist-rewind --scope story007
Creates audits/AUDIT-NNN_<date>_<scope>_partXofY.zip (split when one zip would exceed 100 MB) and logs it.
"""
import argparse, datetime, glob, os, re, zipfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LIMIT = 100 * 1000 * 1000  # 100 MB per zip

def files(patterns):
    out = []
    for p in patterns:
        out += [f for f in glob.glob(os.path.join(ROOT, p), recursive=True) if os.path.isfile(f)]
    return sorted(set(out))

def main():
    a = argparse.ArgumentParser()
    a.add_argument("--story", required=True)
    a.add_argument("--scope", required=True)
    args = a.parse_args()
    s = args.story.replace("\\", "/").rstrip("/")

    # Package 1: deliverables (what is being audited)
    deliverables = files([f"{s}/*_part*.mp4", f"{s}/PUBLISH.md", f"{s}/script.md", f"{s}/narration_p*.txt",
                          f"{s}/rec/qa_compare/REPORT.md", f"{s}/AUDIT_REPORT*.md", f"{s}/rec/v2/part*.mp4",
                          f"{s}/audit_v2/*"])
    # Package 2: how it was made (rules, code, evidence) -- summary images only, no raw takes / per-frame dumps
    support = files(["AGENTS.md", "CLAUDE.md", "README.md", "docs/*.md", "pipeline/*.py", "engines/roblox/**/*.luau",
                     "engines/roblox/*.md", ".claude/agents/*.md", ".claude/skills/**/SKILL.md",
                     "ledger/STORY_LEDGER.md", f"ledger/verification/{os.path.basename(s)[:3]}.md",
                     "assets/INDEX.md", "assets/faces/*.md", "assets/faces/*.json", "reference/BENCHMARKS.md",
                     f"{s}/beats_p*.json", f"{s}/p*/subs.ass",
                     f"{s}/rec/qa_final/sheet_*.png", f"{s}/rec/qa_compare/sheet_*.png",
                     f"{s}/rec/qa_take_p*_grid.png", "assets/rigs/*.luau", "assets/sfx/*.wav", f"{s}/rec/v2/qa_p*.png"])
    support = [f for f in support if f not in deliverables]

    # greedy-pack each group into <=LIMIT zips (compressed size estimated by file size: mp4/png don't compress)
    def pack(group):
        bins, cur, size = [], [], 0
        for f in group:
            fs = os.path.getsize(f)
            if fs > LIMIT:
                raise SystemExit(f"file too big for one package: {f}")
            if cur and size + fs > LIMIT:
                bins.append(cur); cur, size = [], 0
            cur.append(f); size += fs
        if cur: bins.append(cur)
        return bins
    bins = pack(deliverables) + pack(support)

    os.makedirs(os.path.join(ROOT, "audits"), exist_ok=True)
    serial = len({m.group(1) for f in os.listdir(os.path.join(ROOT, "audits"))
                  for m in [re.match(r"AUDIT-(\d{3})_", f)] if m}) + 1
    date = datetime.date.today().isoformat()
    made = []
    for i, b in enumerate(bins, 1):
        name = f"AUDIT-{serial:03d}_{date}_{args.scope}_part{i}of{len(bins)}.zip"
        path = os.path.join(ROOT, "audits", name)
        with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as z:
            for f in b:
                z.write(f, "AI-Vid/" + os.path.relpath(f, ROOT).replace(os.sep, "/"))
        mb = os.path.getsize(path) / 1e6
        assert mb <= 100, f"{name} is {mb:.1f} MB"
        made.append((name, len(b), mb))
        print(f"{name}: {len(b)} files, {mb:.1f} MB")

    log = os.path.join(ROOT, "audits", "AUDIT_LOG.md")
    if not os.path.exists(log):
        open(log, "w", encoding="utf-8").write("# Audit packages\n\nSerial AUDIT-NNN; each zip ≤ 100 MB, split into parts if needed. Only audit-relevant files.\n\n| Serial | Date | Files | Scope |\n|---|---|---|---|\n")
    with open(log, "a", encoding="utf-8") as fh:
        fh.write(f"| {serial:03d} | {date} | " + "<br>".join(f"{n} ({c} files, {m:.1f} MB)" for n, c, m in made)
                 + f" | {args.scope}: part 1 = deliverables (videos, publish sheet, script, QA report); later parts = rules, code, evidence |\n")

if __name__ == "__main__":
    main()
