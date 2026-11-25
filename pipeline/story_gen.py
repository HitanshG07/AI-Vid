"""AI-Vid V6.0 story intake: inbox ingest + (owner 2026-11-25) automatic Gemini writer/judge replenishment.

  python pipeline/story_gen.py --ingest            # owner-dropped pairs from stories/_inbox/ (unchanged)
  python pipeline/story_gen.py --auto 2            # write + independently judge 2 new stories, then ingest them

--auto: the writer model (automation.story_gen.writer_models, first that answers) gets assets/manifest.json,
templates/style_anchors.md and ledger/LEARNING_BRIEF.md; a DIFFERENT judge model scores it. Python enforces the
8-Year-Old First-Try Test + "In This World/Town" title and the Gate 1 manifest checks before and after judging.
Passing pairs are written to the inbox and go through the same --ingest path (writer_model != judge_model).

Antigravity sessions (Gemini / Claude / Codex) write the stories and judge them. The owner drops each pair into
stories/_inbox/:
    <name>.yaml        story.yaml spec
    <name>.judge.json  {"writer_model", "judge_model", "scores", "mean_score", "pass",
                        optional "input_tokens", "output_tokens", "judge_input_tokens", "judge_output_tokens"}

  python pipeline/story_gen.py --ingest

Accepted pairs become stories/<ID>_<slug>/ (status GENERATED in ledger/pipeline.db) and move to _inbox/_done/.
Rejected pairs move to _inbox/_rejected/ with <name>.reason.txt.
"""
from __future__ import annotations
import argparse, hashlib, json, re, shutil
from pathlib import Path
import yaml
from config_loader import ROOT, load_config
from db import PipelineDB


def slugify(s: str) -> str:
    return re.sub(r"[^a-z0-9]+", "-", (s or "story").lower()).strip("-")[:36] or "story"


def highest_used_id(root: Path) -> int:
    """Max 3-digit ID across the story ledger and existing story folders, so a new ID never collides."""
    ids = [int(m.group(1)) for d in (root / "stories").glob("[0-9][0-9][0-9]_*") if (m := re.match(r"(\d{3})_", d.name))]
    ledger = root / "ledger" / "STORY_LEDGER.md"
    if ledger.exists():
        ids += [int(m.group(1)) for line in ledger.read_text(encoding="utf-8").splitlines()
                if (m := re.match(r"^\|\s*(\d{3})\s*\|", line))]
    return max(ids, default=0)


def validate_pair(story_path: Path) -> tuple[dict | None, dict | None, str]:
    judge_path = story_path.with_suffix(".judge.json")
    if not judge_path.exists():
        return None, None, f"missing {judge_path.name}"
    try:
        spec = yaml.safe_load(story_path.read_text(encoding="utf-8"))
        judge = json.loads(judge_path.read_text(encoding="utf-8"))
    except Exception as e:
        return None, None, f"unreadable: {e}"
    if not isinstance(spec, dict) or not spec.get("beats"):
        return None, None, "story yaml has no beats"
    w, j = str(judge.get("writer_model", "")).strip(), str(judge.get("judge_model", "")).strip()
    if not w or not j:
        return None, None, "judge.json needs writer_model and judge_model"
    if w.lower() == j.lower():
        return None, None, f"Judge == Writer ({w}); an independent judge model is required"
    if judge.get("pass") is not True:
        return None, None, f"judge did not pass it (mean_score={judge.get('mean_score')})"
    return spec, judge, ""


def _move(paths: list[Path], dest: Path):
    dest.mkdir(parents=True, exist_ok=True)
    for p in paths:
        if p.exists():
            shutil.move(str(p), str(dest / p.name))


def ingest(inbox: Path, root: Path = ROOT, db_path: Path | None = None) -> list[tuple[str, str]]:
    cfg = load_config()
    db = PipelineDB(db_path or (root / "ledger" / "pipeline.db"))
    created = []
    try:
        for story_path in sorted(inbox.glob("*.yaml")):
            judge_path = story_path.with_suffix(".judge.json")
            spec, judge, reason = validate_pair(story_path)
            if reason:
                _move([story_path, judge_path], inbox / "_rejected")
                (inbox / "_rejected" / f"{story_path.stem}.reason.txt").write_text(reason, encoding="utf-8")
                print(f"[INGEST] REJECTED {story_path.name}: {reason}")
                continue

            ep_id = db.next_episode_id(highest_used_id(root))
            slug = slugify(spec.get("slug") or spec.get("title"))
            spec["id"] = ep_id
            spec.setdefault("format", "story")
            spec.setdefault("hashtags", cfg["channel"]["default_hashtags"])
            spec.setdefault("caption_margin_v", cfg["captions"]["margin_v"])

            sdir = root / "stories" / f"{ep_id}_{slug}"
            sdir.mkdir(parents=True, exist_ok=True)
            yaml_txt = yaml.safe_dump(spec, sort_keys=False, allow_unicode=True)
            (sdir / "story.yaml").write_text(yaml_txt, encoding="utf-8")
            (sdir / "judge_result.json").write_text(json.dumps(judge, indent=2), encoding="utf-8")

            db.upsert_episode(
                ep_id, slug, str(sdir), title=spec.get("title", ""), status="GENERATED",
                writer_model=judge["writer_model"], judge_model=judge["judge_model"],
                engine=spec.get("engine", ""), rule_type=spec.get("rule_type", ""),
                opening_variant=spec.get("opening_variant", ""), ending_type=spec.get("ending_type", ""),
                story_hash=hashlib.sha256(yaml_txt.encode("utf-8")).hexdigest()[:16], gate1_json=json.dumps(judge),
            )
            # Tokens come from the Antigravity session if it reported them; otherwise 0 (honest, not estimated).
            db.log_quota(ep_id, "writer", "antigravity", judge["writer_model"],
                         judge.get("input_tokens", 0), judge.get("output_tokens", 0), "inbox")
            db.log_quota(ep_id, "judge", "antigravity", judge["judge_model"],
                         judge.get("judge_input_tokens", 0), judge.get("judge_output_tokens", 0), "inbox")
            _move([story_path, judge_path], inbox / "_done")
            created.append((ep_id, slug))
            print(f"[INGEST] {story_path.name} -> {sdir.name} (GENERATED)")
        return created
    finally:
        db.close()


# === V6 auto replenishment ===========================================================================================
KID_BANNED = ("valedictorian", "intimidation", "intimidate", "corrupt", "disqualified", "official", "officially",
              "enrolled", "percent", "championship", "consequence", "therefore", "however", "approximately", "policy",
              "nevertheless", "furthermore", "regulation", "bureaucracy")
HOOK_TITLE = re.compile(r"^In This (World|Town), \S", re.I)


def _plain(line: str) -> str:
    return re.sub(r"\*([^*]+)\*", r"\1", line or "").strip()


CAPABILITY_CONTRACT = """=== ENGINE CAPABILITY CONTRACT (V6.2) ===
The story's rule MUST visibly happen on screen, staged ONLY with: sets, spots, actions, prop kits, fx,
`scale:` (0.2-2.5, persists until changed: shrinking / growing), `invisible: true/false` (vanishing, popping away),
`counter:` (bold rule number above a head), `face_mid:` (face swap halfway through a beat) and
`overlay:` (sweat | hearts | bubble + overlay_text 2-16 chars | flash_red_blue |
  phone_card + overlay_text "TITLE | short message" (4-64 chars, e.g. "NEW TEXT: SAM | Look behind you!") |
  binary_cta + overlay_text "QUESTION | LIKE = A / COMMENT = B" (4-64 chars); 0-5 per story).
Anything else (magic objects we cannot build, transformations, flying, size changes without scale:, vanishing
without invisible:) cannot be shown and FAILS. Favor tight expressive close-ups with 4-6 face_mid swaps and
2-4 overlays over walks across the room."""

# rule words that need a matching engine field somewhere in the beats/cast (cheap, before any judge tokens)
STAGE_NEEDS = (("scale", re.compile(r"\b(shrink\w*|shrank|grow\w*|grew|smaller|bigger|tiny|taller|shorter|giant)\b", re.I)),
               ("invisible", re.compile(r"\b(vanish\w*|disappear\w*|popped away|invisible)\b", re.I)))


def stage_errors(spec: dict) -> list[str]:
    beats = spec.get("beats") or []
    text = " ".join([str(spec.get("rule", ""))] + [_plain(b.get("line", "")) for b in beats])
    holders = list(spec.get("cast") or []) + beats + [w for b in beats for w in (b.get("with") or []) if isinstance(w, dict)]
    errs = []
    for field, words in STAGE_NEEDS:
        m = words.search(text)
        used = (lambda v: v is True) if field == "invisible" else (lambda v: isinstance(v, (int, float)) and not isinstance(v, bool) and v != 1)
        if m and not any(used(h.get(field)) for h in holders):
            errs.append(f"Rule/lines say '{m.group(0)}' but no beat sets `{field}:` - the rule must happen on screen.")
    return errs


def kid_simple_errors(spec: dict) -> list[str]:
    """The 8-Year-Old First-Try Test, mechanical part (the judge scores the rest)."""
    errs = []
    title = str(spec.get("title", ""))
    if not HOOK_TITLE.match(title):
        errs.append(f"Title must start with 'In This World, ' or 'In This Town, ' (got '{title}').")
    if len(title) > 60:
        errs.append("Title longer than 60 characters.")
    beats = spec.get("beats") or []
    if not 20 <= len(beats) <= 24:
        errs.append(f"Needs about 22 beats (got {len(beats)}).")
    text = " ".join([title, str(spec.get("rule", ""))] + [_plain(b.get("line", "")) for b in beats]).lower()
    bad = sorted({w for w in KID_BANNED if re.search(rf"\b{w}\b", text)})
    if bad:
        errs.append(f"Adult/essay words: {', '.join(bad)}.")
    for i, b in enumerate(beats, 1):
        n = len(_plain(b.get("line", "")).split())
        if n > 9 or n < 2:
            errs.append(f"Beat {i}: {n} words (keep spoken lines 2-9 words, mostly 5-9).")
    if beats:
        narr = sum(1 for b in beats if b.get("speaker", "narrator") == "narrator") / len(beats)
        if narr > 0.30:
            errs.append(f"Narrator speaks {narr:.0%} of beats; at least 70% must be dialogue/reactions.")
    if len(str(spec.get("rule", "")).split()) > 14:
        errs.append("Rule must be one short line (max 14 words).")
    return errs + stage_errors(spec)


def gemini_generate(model: str, prompt: str, key: str, json_mode: bool = False) -> tuple[str, dict]:
    """One generateContent call (stdlib). Returns (text, usageMetadata)."""
    import urllib.request
    body = {"contents": [{"parts": [{"text": prompt}]}],
            "generationConfig": {"temperature": 0.2 if json_mode else 0.9,
                                 **({"responseMimeType": "application/json"} if json_mode else {})}}
    req = urllib.request.Request(f"https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent",
                                 data=json.dumps(body).encode(), headers={"Content-Type": "application/json", "x-goog-api-key": key})
    with urllib.request.urlopen(req, timeout=180) as r:
        resp = json.loads(r.read())
    return resp["candidates"][0]["content"]["parts"][0]["text"], resp.get("usageMetadata", {})


def _first_ok(models: list[str], prompt: str, generate, json_mode: bool) -> tuple[str, str, dict]:
    errors = []
    for m in models:
        try:
            text, usage = generate(m, prompt, json_mode)
            return m, text, usage
        except Exception as e:  # overloaded / unavailable -> next model
            errors.append(f"{m}: {str(e)[:100]}")
    raise RuntimeError("all models failed: " + " | ".join(errors))


def writer_prompt(root: Path, recent_titles: list[str], prev_set: str | None, feedback: str = "") -> str:
    m = json.loads((root / "assets" / "manifest.json").read_text(encoding="utf-8"))
    cfg = load_config()
    moods = [k for k, f in cfg["audio"]["bgm_moods"].items() if f and (root / "assets" / "sfx" / f).exists()] or ["mystery"]
    sets = "\n".join(f"  {n}: spots {sorted(v.get('spots', {}))}; props {v.get('props', [])}"
                     for n, v in m["sets"].items() if n in ("school_yard", "school_hallway", "classroom", "auditorium", "living_room", "street"))
    anchors = (root / "templates" / "style_anchors.md").read_text(encoding="utf-8")
    brief_f = root / "ledger" / "LEARNING_BRIEF.md"
    brief = brief_f.read_text(encoding="utf-8") if brief_f.exists() else "(no performance data yet)"
    return f"""You write ONE new original Roblox Short as a story.yaml document for the StudVerse Tales channel.
Follow the gold-standard anchors and the 8-Year-Old First-Try Test EXACTLY (simple, spoken, emotional, visual).

=== STYLE ANCHORS (match this simplicity and voice; do NOT copy their premises) ===
{anchors}

=== WHAT WE CAN SHOW (use ONLY these exact values) ===
sets (top-level `set`, optional per-beat `set:` to cut rooms; spot names belong to their set):
{sets}
cameras: {m['cameras']}
motions: {m['motions']}
actions: {m['actions']}  (fall only when the line says fell/trip/slam/shove/crash)
faces: {m['faces']}   speakers: {m['speakers']}   genders: {m['genders']}
sfx: {m['active_sfx']}
fx: {[f for f in m['fx'] if f]}   prop kits: {m['prop_kits']}
bgm_mood: one of {moods}   lighting: {m['lightings']}
engine: {m['engines']}   opening_variant: {m['opening_variants']}   ending_type: {m['ending_types']}
overhead `counter:` on cast entries / beats / `with:` partners: bold rule number, max 18 chars, A-Z 0-9 : = + - / ! ? . % only.

{CAPABILITY_CONTRACT}

=== WHAT IS WORKING ON THE CHANNEL ===
{brief}

=== HARD RULES ===
- Title: "In This World, ..." or "In This Town, ..." + the rule, max 60 chars. Not one of: {recent_titles[:30]}
- Top-level set must NOT be "{prev_set or ''}" (never repeat the previous episode's set).
- Exactly 22 beats, dur 2.4. Lines 5-9 words (max 9), 4th-grade spoken English, max 6 narrator beats.
- Required top-level fields: title, description, set, bgm_mood, lighting, engine, rule_type, opening_variant,
  ending_type, rule, visible_proof, personal_stake, motivated_choice, rule_payoff, cta, cast, beats.
- No emojis anywhere. Every narrated object must be visible (set prop, prop kit or fx).
- Beats 1-3 = WORLD-RULE MONTAGE: rapid, different on-screen proofs of the town's rule (other people, other
  places) BEFORE the protagonist's personal stake starts at beat 4.
- Final beat (beat 22) carries a diegetic `overlay: binary_cta` whose overlay_text asks the story's own dilemma,
  e.g. "WOULD YOU TELL? | LIKE = TELL / COMMENT = HIDE". Overlay text: letters, digits, spaces, | = / : , . ! ? - ' only.
{('- FIX THESE PROBLEMS FROM YOUR LAST DRAFT: ' + feedback) if feedback else ''}
Return ONLY the YAML document (no code fences, no commentary).
"""


JUDGE_PROMPT = """You are an independent, strict judge for kid-friendly Roblox Shorts. Score this story.yaml 0-10 on:
  rule_simplicity  - one visual rule an 8-year-old gets in 2 seconds; no math, no multi-step logic
  spoken_english   - everyday 4th-grade spoken lines, 5-9 words, no adult/essay vocabulary
  emotional_stakes - family / friendship / survival / betrayal / greed backfiring (not school policy)
  hook_title       - "In This World/Town, <rule>" and instantly clickable
  visual_clarity   - the rule and every narrated thing are shown on screen; clear payoff
  stageable        - the core rule can be staged with the contract below (0 if it cannot be shown on screen)
Hard-reject (pass=false) any story whose core rule cannot be shown on screen with the contract below
(e.g. shrinking without scale:, vanishing without invisible: true, magic objects we cannot build).
""" + CAPABILITY_CONTRACT + """
Also hard-reject (pass=false) any dry or complex rule, multi-step math, adult vocabulary or narrator-heavy telling.
Return STRICT JSON: {"scores": {"rule_simplicity": n, "spoken_english": n, "emotional_stakes": n, "hook_title": n,
"visual_clarity": n, "stageable": n}, "pass": true|false, "reason": "<one sentence>"}

STORY:
"""


def _strip_fences(t: str) -> str:
    t = t.strip()
    m = re.search(r"```(?:yaml)?\s*\n(.*?)```", t, re.S)
    return m.group(1) if m else t


def auto_generate(count: int, root: Path = ROOT, db_path: Path | None = None, generate=None, key: str | None = None) -> list:
    """Write + judge `count` stories into the inbox, then ingest them. `generate(model, prompt, json_mode)` is
    injectable (tests). Returns ingest() results."""
    import qa_gate
    cfg = load_config()
    sg = cfg["automation"].get("story_gen", {})
    writers, judges = list(sg.get("writer_models", [])), list(sg.get("judge_models", []))
    qa = cfg["automation"]["qa"]
    manifest = json.loads((root / "assets" / "manifest.json").read_text(encoding="utf-8"))
    inbox = root / cfg["automation"].get("inbox_dir", "stories/_inbox")
    inbox.mkdir(parents=True, exist_ok=True)
    if generate is None:
        key = key or qa_gate.gemini_api_key(root)
        generate = lambda m, prompt, js: gemini_generate(m, prompt, key, js)
    db = PipelineDB(db_path or (root / "ledger" / "pipeline.db"))
    try:
        rows = db.conn.execute("SELECT episode_id, title, story_dir FROM episodes ORDER BY episode_id DESC").fetchall()
    finally:
        db.close()
    recent = [r["title"] for r in rows if r["title"]]
    prev_set = None
    for r in rows:  # newest episode's set
        f = (Path(r["story_dir"]) if Path(r["story_dir"]).is_absolute() else root / r["story_dir"]) / "story.yaml"
        if f.exists():
            prev_set = (yaml.safe_load(f.read_text(encoding="utf-8")) or {}).get("set"); break
    made = 0
    for n in range(count):
        feedback, spec, wmodel, wusage = "", None, None, {}
        for _attempt in range(2):  # one rewrite with the exact problems fed back
            wmodel, text, wusage = _first_ok(writers, writer_prompt(root, recent, prev_set, feedback), generate, False)
            try:
                spec = yaml.safe_load(_strip_fences(text))
            except Exception as e:
                spec, feedback = None, f"YAML did not parse: {e}"
                continue
            if not isinstance(spec, dict):
                spec, feedback = None, "Return one YAML mapping."; continue
            spec.setdefault("id", "NEW")
            errs = kid_simple_errors(spec) + qa_gate.check_manifest_and_sameness(spec, manifest, [], qa) \
                + qa_gate.check_action_sanity(spec, prev_set)
            errs = [e for e in errs if "Premise too close" not in e]
            if not errs:
                break
            spec, feedback = None, " ".join(errs[:12])
        if spec is None:
            print(f"[AUTO] story {n + 1}: writer could not pass the rules: {feedback[:300]}")
            continue
        jmodels = [j for j in judges if j.lower() != (wmodel or "").lower()]  # strictly an independent judge
        jmodel, jtext, jusage = _first_ok(jmodels, JUDGE_PROMPT + yaml.safe_dump(spec, sort_keys=False, allow_unicode=True), generate, True)
        verdict = json.loads(_strip_fences(jtext))
        scores = {k: float(v) for k, v in (verdict.get("scores") or {}).items()}
        mean = sum(scores.values()) / len(scores) if scores else 0.0
        ok = bool(verdict.get("pass")) and len(scores) >= 6 and "stageable" in scores and min(scores.values()) >= float(qa.get("judge_min_dim", 7.0)) \
            and mean >= float(qa.get("judge_min_avg", 8.0))
        judge = {"writer_model": wmodel, "judge_model": jmodel, "scores": scores, "mean_score": round(mean, 2),
                 "pass": ok, "reason": verdict.get("reason", ""),
                 "input_tokens": wusage.get("promptTokenCount", 0), "output_tokens": wusage.get("candidatesTokenCount", 0),
                 "judge_input_tokens": jusage.get("promptTokenCount", 0), "judge_output_tokens": jusage.get("candidatesTokenCount", 0)}
        name = f"auto_{slugify(spec.get('title'))}"
        spec.pop("id", None)
        (inbox / f"{name}.yaml").write_text(yaml.safe_dump(spec, sort_keys=False, allow_unicode=True), encoding="utf-8")
        (inbox / f"{name}.judge.json").write_text(json.dumps(judge, indent=2), encoding="utf-8")
        recent.insert(0, spec.get("title", ""))
        made += 1
        print(f"[AUTO] {name}: writer={wmodel} judge={jmodel} mean={mean:.2f} pass={ok}")
    return ingest(inbox, root=root, db_path=db_path) if made else []


if __name__ == "__main__":
    p = argparse.ArgumentParser()
    g = p.add_mutually_exclusive_group(required=True)
    g.add_argument("--ingest", action="store_true")
    g.add_argument("--auto", type=int, metavar="N", help="write + judge N new stories with Gemini, then ingest")
    p.add_argument("--inbox", default=None)
    a = p.parse_args()
    if a.auto:
        print("Auto-generated:", auto_generate(a.auto))
    else:
        inbox = Path(a.inbox) if a.inbox else ROOT / load_config()["automation"].get("inbox_dir", "stories/_inbox")
        inbox.mkdir(parents=True, exist_ok=True)
        print("Ingested:", ingest(inbox))
