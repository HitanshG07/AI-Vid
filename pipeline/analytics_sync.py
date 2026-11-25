"""AI-Vid V6.0 Analytics Feedback Sync (0 AI tokens).

Pulls 24h & 7d YouTube view/like counts for scheduled/published Shorts via YouTube Data API v3 (1 unit/call)
and writes them back to SQLite so weekly story batches weight winning rule/opening patterns.
"""
from __future__ import annotations
import datetime as dt
from config_loader import ROOT, load_config
from db import PipelineDB
from upload_queue import get_youtube_client


def sync_analytics():
    cfg = load_config()
    db = PipelineDB(ROOT / "ledger" / "pipeline.db")
    try:
        eps = [e for e in db.list_by_status("SCHEDULED") if e.get("youtube_video_id")]
        if not eps:
            print("[SYNC] No scheduled/published episodes with YouTube IDs yet.")
            return
        yt = get_youtube_client(cfg["automation"]["youtube"])
        ids = [e["youtube_video_id"] for e in eps]
        resp = yt.videos().list(part="statistics,snippet", id=",".join(ids[:50])).execute()
        by_id = {item["id"]: item.get("statistics", {}) for item in resp.get("items", [])}
        now = dt.datetime.now(dt.timezone.utc)
        for ep in eps:
            st = by_id.get(ep["youtube_video_id"])
            if not st or not ep.get("publish_at"):
                continue
            pub = dt.datetime.fromisoformat(ep["publish_at"].replace("Z", "+00:00"))
            age_h = (now - pub).total_seconds() / 3600.0
            views = int(st.get("viewCount", 0))
            likes = int(st.get("likeCount", 0))
            if 24 <= age_h < 168 and ep.get("views_24h", 0) == 0:
                db.upsert_episode(ep["episode_id"], ep["slug"], ep["story_dir"], views_24h=views)
            elif age_h >= 168:
                db.upsert_episode(ep["episode_id"], ep["slug"], ep["story_dir"], views_7d=views, likes_7d=likes)
        print(f"[SYNC] Updated stats for {len(by_id)} videos.")
    finally:
        db.close()


if __name__ == "__main__":
    sync_analytics()
