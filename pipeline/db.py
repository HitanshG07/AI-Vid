"""AI-Vid V6.0 SQLite State Machine & Quota Telemetry (0 external dependencies).

Tracks every episode through:
  GENERATED -> GATE1_PASS -> AUDIO_PASS -> RENDERED -> GATE3_PASS -> APPROVED -> UPLOADED_PRIVATE -> SCHEDULED
  (or QUARANTINED at any failed stage — never published).
"""
from __future__ import annotations
import csv, datetime as dt, json, sqlite3
from pathlib import Path

SCHEMA = """
CREATE TABLE IF NOT EXISTS episodes (
    episode_id TEXT PRIMARY KEY,
    slug TEXT NOT NULL,
    title TEXT DEFAULT '',
    story_dir TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'GENERATED',
    writer_model TEXT DEFAULT '',
    judge_model TEXT DEFAULT '',
    engine TEXT DEFAULT '',
    rule_type TEXT DEFAULT '',
    opening_variant TEXT DEFAULT '',
    ending_type TEXT DEFAULT '',
    story_hash TEXT DEFAULT '',
    render_sha256 TEXT DEFAULT '',
    gate1_json TEXT DEFAULT '{}',
    gate2_json TEXT DEFAULT '{}',
    gate3_json TEXT DEFAULT '{}',
    human_approved INTEGER DEFAULT 0,
    youtube_video_id TEXT DEFAULT '',
    resumable_session_uri TEXT DEFAULT '',
    publish_at TEXT DEFAULT '',
    failure_reason TEXT DEFAULT '',
    views_24h INTEGER DEFAULT 0,
    views_7d INTEGER DEFAULT 0,
    likes_7d INTEGER DEFAULT 0,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS quota_events (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ts TEXT NOT NULL,
    episode_id TEXT NOT NULL,
    role TEXT NOT NULL,
    provider TEXT NOT NULL,
    model TEXT NOT NULL,
    input_tokens INTEGER DEFAULT 0,
    output_tokens INTEGER DEFAULT 0,
    status TEXT NOT NULL
);
"""


def utcnow() -> str:
    return dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat()


class PipelineDB:
    def __init__(self, db_path: Path, quota_csv: Path | None = None):
        self.db_path = Path(db_path)
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self.quota_csv = Path(quota_csv) if quota_csv else self.db_path.parent / "quota_log.csv"
        self.conn = sqlite3.connect(str(self.db_path))
        self.conn.row_factory = sqlite3.Row
        self.conn.executescript(SCHEMA)
        self.conn.commit()

    def close(self):
        self.conn.close()

    def upsert_episode(self, episode_id: str, slug: str, story_dir: str, **fields):
        now = utcnow()
        row = self.conn.execute("SELECT episode_id FROM episodes WHERE episode_id=?", (episode_id,)).fetchone()
        if not row:
            cols = ["episode_id", "slug", "story_dir", "created_at", "updated_at"] + list(fields.keys())
            vals = [episode_id, slug, story_dir, now, now] + list(fields.values())
            placeholders = ",".join("?" for _ in cols)
            self.conn.execute(f"INSERT INTO episodes ({','.join(cols)}) VALUES ({placeholders})", vals)
        else:
            fields["updated_at"] = now
            sets = ",".join(f"{k}=?" for k in fields.keys())
            self.conn.execute(f"UPDATE episodes SET {sets} WHERE episode_id=?", list(fields.values()) + [episode_id])
        self.conn.commit()

    def set_status(self, episode_id: str, status: str, **extra):
        extra["status"] = status
        extra["updated_at"] = utcnow()
        sets = ",".join(f"{k}=?" for k in extra.keys())
        self.conn.execute(f"UPDATE episodes SET {sets} WHERE episode_id=?", list(extra.values()) + [episode_id])
        self.conn.commit()

    def get_episode(self, episode_id: str) -> dict | None:
        r = self.conn.execute("SELECT * FROM episodes WHERE episode_id=?", (episode_id,)).fetchone()
        return dict(r) if r else None

    def previous_episode(self, episode_id: str) -> dict | None:
        """The live episode right before this one (scrapped/quarantined ones don't count)."""
        r = self.conn.execute("""SELECT * FROM episodes WHERE episode_id < ? AND status NOT IN ('SCRAPPED', 'QUARANTINED')
                                 ORDER BY episode_id DESC LIMIT 1""", (episode_id,)).fetchone()
        return dict(r) if r else None

    def list_by_status(self, *statuses: str) -> list[dict]:
        q = f"SELECT * FROM episodes WHERE status IN ({','.join('?' for _ in statuses)}) ORDER BY episode_id ASC"
        return [dict(r) for r in self.conn.execute(q, statuses).fetchall()]

    def recent_published(self, limit: int = 30) -> list[dict]:
        q = """SELECT * FROM episodes
               WHERE status IN ('SCHEDULED', 'UPLOADED_PRIVATE', 'GATE3_PASS', 'APPROVED')
               ORDER BY created_at DESC LIMIT ?"""
        return [dict(r) for r in self.conn.execute(q, (limit,)).fetchall()]

    def next_episode_id(self, ledger_max: int = 0) -> str:
        r = self.conn.execute("SELECT MAX(CAST(episode_id AS INTEGER)) AS m FROM episodes").fetchone()
        db_max = int(r["m"]) if r and r["m"] is not None else 0
        return f"{max(db_max, ledger_max) + 1:03d}"

    def log_quota(self, episode_id: str, role: str, provider: str, model: str,
                  input_tokens: int, output_tokens: int, status: str = "ok"):
        ts = utcnow()
        self.conn.execute(
            "INSERT INTO quota_events (ts, episode_id, role, provider, model, input_tokens, output_tokens, status) "
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
            (ts, episode_id, role, provider, model, int(input_tokens), int(output_tokens), status),
        )
        self.conn.commit()
        write_hdr = not self.quota_csv.exists()
        self.quota_csv.parent.mkdir(parents=True, exist_ok=True)
        with self.quota_csv.open("a", newline="", encoding="utf-8") as f:
            w = csv.writer(f)
            if write_hdr:
                w.writerow(["ts", "episode_id", "role", "provider", "model", "input_tokens", "output_tokens", "status"])
            w.writerow([ts, episode_id, role, provider, model, int(input_tokens), int(output_tokens), status])

    def summarize_quota(self, episode_id: str) -> dict:
        r = self.conn.execute(
            "SELECT COUNT(*) AS calls, COALESCE(SUM(input_tokens),0) AS inp, COALESCE(SUM(output_tokens),0) AS outp "
            "FROM quota_events WHERE episode_id=?",
            (episode_id,),
        ).fetchone()
        return {"calls": r["calls"], "input_tokens": r["inp"], "output_tokens": r["outp"]}
