"""AI-Vid V6.0 Closed-Loop Orchestrator (Windows Task Scheduler entry point).

Modes:
  --mode sync      : Pull 24h/7d YouTube metrics into SQLite
  --mode batch     : Ingest Antigravity-written stories from stories/_inbox/ (no API calls)
  --mode produce   : Run Gate 1 -> Kokoro TTS -> Gate 2 -> Compile -> Studio Capture -> Finish -> Gate 3 (1 episode)
  --mode upload    : Upload & schedule approved episodes + purge raw captures & old quarantine MP4s
  --mode full      : Run sync -> ingest -> produce (1 ep) -> upload
"""
from __future__ import annotations
import argparse, json, os, re, subprocess, sys, time
import yaml
from pathlib import Path
from config_loader import ROOT, load_config
from db import PipelineDB


def run_py(script: str, *args: str, check: bool = True) -> subprocess.CompletedProcess:
    cmd = [sys.executable, str(ROOT / "pipeline" / script), *args]
    print("[DAEMON]", " ".join(cmd))
    # UTF-8 for children: titles carry emoji, and the Windows console default (cp1252) crashes on them
    return subprocess.run(cmd, check=check, env={**os.environ, "PYTHONUTF8": "1", "PYTHONIOENCODING": "utf-8"})


class StudioMCP:
    """Minimal stdio JSON-RPC client for the Roblox Studio MCP proxy (mcp.bat). stdlib only."""

    def __init__(self, cmd: str):
        self.p = subprocess.Popen(os.path.expandvars(cmd), stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                  stderr=subprocess.DEVNULL, text=True, encoding="utf-8", shell=True)
        self.n = 0
        self.rpc("initialize", {"protocolVersion": "2025-11-25", "capabilities": {},
                                "clientInfo": {"name": "aivid-daemon", "version": "6.0"}})
        self._send({"jsonrpc": "2.0", "method": "notifications/initialized", "params": {}})
        # Tools register asynchronously after the Studio websocket connects; retry until Studio answers.
        for _ in range(20):
            res = self.call("list_roblox_studios", {}, raise_on_error=False)
            ids = re.findall(r'"id"\s*:\s*"([^"]+)"', res)
            if ids:
                self.studio_id = ids[0]
                return
            time.sleep(1)
        raise RuntimeError(f"No Roblox Studio instance reachable via MCP: {res[:300]}")

    def _send(self, msg: dict):
        self.p.stdin.write(json.dumps(msg) + "\n")
        self.p.stdin.flush()

    def rpc(self, method: str, params: dict) -> dict:
        self.n += 1
        my_id = self.n
        self._send({"jsonrpc": "2.0", "id": my_id, "method": method, "params": params})
        while True:  # skip notifications and unrelated replies
            line = self.p.stdout.readline()
            if not line:
                raise RuntimeError(f"MCP proxy closed during {method}")
            try:
                msg = json.loads(line)
            except json.JSONDecodeError:
                continue
            if msg.get("id") == my_id:
                return msg

    def call(self, tool: str, args: dict, raise_on_error: bool = True) -> str:
        msg = self.rpc("tools/call", {"name": tool, "arguments": args})
        res = msg.get("result") or {}
        text = "".join(c.get("text", "") for c in res.get("content", []))
        if raise_on_error and (msg.get("error") or res.get("isError")):
            raise RuntimeError(f"MCP {tool} failed: {msg.get('error') or text[:500]}")
        return text or json.dumps(msg.get("error", ""))

    def luau(self, code: str) -> str:
        return self.call("execute_luau", {"code": code, "datamodel_type": "Edit", "studio_id": self.studio_id})

    def close(self):
        try:
            self.p.stdin.close()
            self.p.wait(timeout=10)
        except Exception:
            self.p.kill()


def trigger_studio_capture(ep: dict, cfg: dict):
    """Unattended take: load engine + set + scenes over Studio MCP, black screen, record_take.py, play, reset camera.
    Needs an unlocked desktop with Studio open. Fails closed if rec/raw.mp4 is not produced."""
    sdir = Path(ep["story_dir"])
    ep_id = ep["episode_id"]
    raw_mp4 = sdir / "rec" / "raw.mp4"
    raw_mp4.parent.mkdir(parents=True, exist_ok=True)
    if raw_mp4.exists():
        raw_mp4.unlink()  # never let a stale take pass as this one

    eng = ROOT / "engines" / "roblox"
    spec = yaml.safe_load((sdir / "story.yaml").read_text(encoding="utf-8"))
    manifest = json.loads((ROOT / "assets" / "manifest.json").read_text(encoding="utf-8"))
    names = [spec.get("set")] + [b.get("set") for b in spec.get("beats", []) if b.get("set")]
    set_files = list(dict.fromkeys(ROOT / manifest["sets"][n]["luau"] for n in names if n in manifest["sets"]))
    beats = json.loads((sdir / "beats.json").read_text(encoding="utf-8"))
    beats = beats.get("beats", beats) if isinstance(beats, dict) else beats
    dur = sum(float(b.get("dur", 0)) for b in beats) or 60.0

    mcp = StudioMCP(cfg["automation"]["studio_mcp_cmd"])
    try:
        print("[CAPTURE]", mcp.luau((eng / "core_engine.luau").read_text(encoding="utf-8")))
        for set_file in set_files:  # V6: every set the story cuts to (per-beat `set:`)
            print("[CAPTURE]", mcp.luau(set_file.read_text(encoding="utf-8")))
        print("[CAPTURE]", mcp.luau((eng / f"scenes_{ep_id}.luau").read_text(encoding="utf-8")))
        # Build rigs before recording so play() starts without a setup hitch; black the screen for the trim marker.
        mcp.luau(f'game:GetService("Selection"):Set({{}}); _G["Story{ep_id}"].setup(); game.Lighting.Grade.Brightness = -1')
        rec = subprocess.Popen([sys.executable, str(ROOT / "pipeline" / "record_take.py"),
                                "--seconds", f"{dur + 3:.1f}", "--out", str(raw_mp4)])
        time.sleep(2)
        # V5.4 engine never writes Grade, so un-black in the same call that starts play (first lit frame = start).
        mcp.luau(f'game.Lighting.Grade.Brightness = 0; task.spawn(_G["Story{ep_id}"].play)')
        rc = rec.wait(timeout=dur + 60)
        mcp.luau('game.Lighting.Grade.Brightness = 0; if _G.AIVidCore then _G.AIVidCore.resetCamera() end')
    finally:
        mcp.close()
    if rc != 0 or not raw_mp4.exists():
        raise RuntimeError(f"Unattended Studio capture failed (record_take rc={rc}); {raw_mp4} missing.")


def produce_one(cfg: dict, db: PipelineDB, skip_studio: bool = False) -> str | None:
    """Produces the lowest pending episode; returns its id (None when nothing is pending)."""
    cands = db.list_by_status("GENERATED", "GATE1_PASS", "AUDIO_PASS")
    if not cands:
        print("[DAEMON] No pending stories to produce.")
        return None
    ep = cands[0]
    ep_id, sdir = ep["episode_id"], Path(ep["story_dir"])
    story_yaml = sdir / "story.yaml"

    # 1. Gate 1 (Pre-render manifest + sameness + judge + preflight_lint)
    if ep["status"] == "GENERATED":
        r = run_py("qa_gate.py", "--story-dir", str(sdir), "--stage", "pre", check=False)
        if r.returncode != 0:
            return ep_id

    # 2. Compile initial narration -> Kokoro beat-first TTS + Whisper timestamps -> Gate 2 -> Recompile synced
    if db.get_episode(ep_id)["status"] == "GATE1_PASS":
        run_py("compile_story.py", "--story", str(story_yaml))
        run_py("voice_subs.py", "--story-dir", str(sdir))
        r = run_py("qa_gate.py", "--story-dir", str(sdir), "--stage", "audio", check=False)
        if r.returncode != 0:
            return ep_id
        run_py("compile_story.py", "--story", str(story_yaml), "--sync-words")

    # 3. One-shot Studio capture -> Finish 1080p -> Gate 3
    if db.get_episode(ep_id)["status"] == "AUDIO_PASS":
        if skip_studio:
            print(f"[DAEMON] --skip-studio set; stopping {ep_id} at AUDIO_PASS ready for Studio render.")
            return ep_id
        trigger_studio_capture(ep, cfg)
        run_py("run_take.py", "--story-dir", str(sdir), "--final")
        run_py("qa_gate.py", "--story-dir", str(sdir), "--stage", "render", "--video", str(sdir / f"{ep_id}_FINAL.mp4"), check=False)

    # 4. Gate 4: Gemini vision QA on the beat contact sheet (one auto-fix re-capture, then fail closed)
    if db.get_episode(ep_id)["status"] == "GATE3_PASS" and not skip_studio:
        def recapture() -> bool:
            run_py("compile_story.py", "--story", str(story_yaml), "--sync-words")
            trigger_studio_capture(ep, cfg)
            run_py("run_take.py", "--story-dir", str(sdir), "--final")
            r = run_py("qa_gate.py", "--story-dir", str(sdir), "--stage", "render",
                       "--video", str(sdir / f"{ep_id}_FINAL.mp4"), check=False)
            return r.returncode == 0   # a render-gate failure quarantines itself
        vision_with_retry(ep_id, sdir, cfg, db, recapture)
    return ep_id


def produce_until_ok(cfg: dict, db: PipelineDB, skip_studio: bool = False, produce=None) -> list[str]:
    """A quarantined episode must not leave the day empty: move on to the next pending episode, up to
    automation.max_produce_attempts per run. Returns the episode ids attempted (`produce` injectable for tests)."""
    produce = produce or (lambda: produce_one(cfg, db, skip_studio=skip_studio))
    tried = []
    for _ in range(int(cfg["automation"].get("max_produce_attempts", 3))):
        ep_id = produce()
        if not ep_id:
            break
        tried.append(ep_id)
        if (db.get_episode(ep_id) or {}).get("status") != "QUARANTINED":
            break
        print(f"[DAEMON] {ep_id} quarantined; trying the next pending episode.")
    return tried


def vision_with_retry(ep_id: str, sdir: Path, cfg: dict, db: PipelineDB, recapture, judge=None, root: Path = ROOT) -> bool:
    """Vision gate with at most ONE automatic fix: if the judge flags 1..vision_max_fix_beats fixable camera/staging
    beats with valid cam/spot/motion patches, patch story.yaml, re-capture once and judge again. Anything else (or a
    second failure, or a crashed re-capture) quarantines the episode, so it can never be uploaded.
    `judge` / `recapture` are injectable for tests."""
    import qa_gate
    from run_take import make_audit_zip
    manifest = json.loads((root / "assets" / "manifest.json").read_text(encoding="utf-8"))
    max_fix = int(cfg["automation"]["qa"].get("vision_max_fix_beats", 3))
    for attempt in (1, 2):
        ok, errs, verdict = qa_gate.run_vision_gate(sdir, cfg, root, judge=judge)
        print("AUDIT ZIP:", make_audit_zip(sdir, ep_id))   # fresh vision_qa.json + qa_beats.png (before any quarantine copy)
        if ok:
            from run_take import purge_intermediates
            freed = purge_intermediates(sdir)   # passed: raw/trimmed captures go; the audit zip stays
            print(f"[VISION] {ep_id} PASS (attempt {attempt}); purged {freed / 1048576:.0f} MB of intermediates")
            return True
        spec = yaml.safe_load((sdir / "story.yaml").read_text(encoding="utf-8"))
        patches = qa_gate.plan_vision_patches(verdict, spec, manifest, max_fix) if attempt == 1 else None
        qa_gate.log_vision_failures(root, ep_id, spec, verdict, "retry" if patches else "quarantine")
        if not patches:
            qa_gate.quarantine_episode(sdir, root, "vision", errs, db, ep_id)
            return False
        print(f"[VISION] {ep_id} auto-fix retry with patches {patches}")
        qa_gate.apply_vision_patches(sdir / "story.yaml", patches)
        try:
            if not recapture():
                return False
        except Exception as e:
            qa_gate.quarantine_episode(sdir, root, "vision", errs + [f"re-capture failed: {e}"], db, ep_id)
            return False
    return False


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--mode", default="full", choices=["sync", "batch", "produce", "upload", "full"])
    p.add_argument("--dry-run", action="store_true")
    p.add_argument("--skip-studio", action="store_true")
    a = p.parse_args()

    cfg = load_config()
    db = PipelineDB(ROOT / "ledger" / "pipeline.db")
    try:
        if a.mode in ("sync", "full") and not a.dry_run:
            run_py("analytics_sync.py", check=False)
            run_py("learning_brief.py", check=False)   # 0 tokens: ranks what works -> ledger/LEARNING_BRIEF.md

        if a.mode in ("batch", "full"):
            run_py("story_gen.py", "--ingest", check=False)  # free: just reads stories/_inbox/
            ready = len(db.list_by_status("GENERATED", "GATE1_PASS", "AUDIO_PASS"))
            need = int(cfg["automation"].get("story_gen", {}).get("min_ready_queue", 3)) - ready
            if need > 0 and not a.dry_run:   # top up the ready queue with Gemini writer + independent judge
                run_py("story_gen.py", "--auto", str(need), check=False)

        if a.mode in ("produce", "full"):
            produce_until_ok(cfg, db, skip_studio=a.skip_studio)

        if a.mode in ("upload", "full"):
            args = ["--dry-run"] if a.dry_run else []
            run_py("upload_queue.py", *args)
    finally:
        db.close()


if __name__ == "__main__":
    main()
