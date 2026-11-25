"""AI-Vid V6.0 Idempotent Private-First YouTube Data API v3 Uploader + Storage Pruner.

Safety invariants:
  1. Always uploads with privacyStatus='private', selfDeclaredMadeForKids=False, and explicit synthetic-media disclosure.
  2. Polls processingDetails until processingStatus == 'succeeded' before scheduling publishAt.
  3. Checks OAuth token age (warns if app is still in Testing mode where refresh tokens expire every 7 days).
  4. Purges raw Studio captures post-upload and expires quarantine MP4s older than N days (keeps failure.json).
"""
from __future__ import annotations
import argparse, datetime as dt, json, re, sys, time
from pathlib import Path
import yaml
from config_loader import ROOT, load_config
from db import PipelineDB


def check_oauth_health(yt_cfg: dict) -> list[str]:
    warns = []
    tok = ROOT / yt_cfg["token_path"]
    if not yt_cfg.get("oauth_published", False):
        warns.append("OAuth app marked unpublished (Testing mode): refresh tokens expire every 7 days! Publish in Google Cloud Console.")
    if tok.exists():
        age_days = (time.time() - tok.stat().st_mtime) / 86400.0
        if not yt_cfg.get("oauth_published", False) and age_days >= 5.5:
            warns.append(f"youtube_token.json is {age_days:.1f} days old — re-authenticate before unattended uploads fail.")
    return warns


def next_publish_slot(db: PipelineDB, hour_ist: int = 19) -> str:
    """Returns next open daily ISO-8601 UTC publishAt slot (IST = UTC+5:30)."""
    existing = {r["publish_at"][:10] for r in db.list_by_status("SCHEDULED") if r.get("publish_at")}
    ist = dt.timezone(dt.timedelta(hours=5, minutes=30))
    now_ist = dt.datetime.now(ist)
    cand = now_ist.replace(hour=hour_ist, minute=0, second=0, microsecond=0)
    if cand <= now_ist + dt.timedelta(minutes=30):
        cand += dt.timedelta(days=1)
    while cand.astimezone(dt.timezone.utc).strftime("%Y-%m-%d") in existing:
        cand += dt.timedelta(days=1)
    return cand.astimezone(dt.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def purge_raw_captures(story_dir: Path) -> int:
    """Post-upload: raw + trimmed captures (audit zip kept; shared helper in run_take.py)."""
    from run_take import purge_intermediates
    return purge_intermediates(story_dir)


def prune_quarantine_videos(root: Path, retention_days: int = 14) -> int:
    qroot = root / "quarantine"
    if not qroot.exists():
        return 0
    cutoff = time.time() - retention_days * 86400
    freed = 0
    for mp4 in qroot.rglob("*.mp4"):
        if mp4.stat().st_mtime < cutoff:
            freed += mp4.stat().st_size
            mp4.unlink()
    return freed


def prune_audit_zips(root: Path, retention_days: int = 14) -> int:
    """Deletes stories/*/*_audit.zip older than the retention window; returns bytes freed."""
    cutoff = time.time() - retention_days * 86400
    freed = 0
    for z in (root / "stories").glob("*/*_audit.zip"):
        if z.stat().st_mtime < cutoff:
            freed += z.stat().st_size
            z.unlink()
    return freed


def get_youtube_client(yt_cfg: dict):
    from google.auth.transport.requests import Request
    from google.oauth2.credentials import Credentials
    from google_auth_oauthlib.flow import InstalledAppFlow
    from googleapiclient.discovery import build

    # youtube (full) is needed for videos.update (scheduling publishAt); upload/readonly alone get a 403 there
    scopes = ["https://www.googleapis.com/auth/youtube.upload",
              "https://www.googleapis.com/auth/youtube.readonly",
              "https://www.googleapis.com/auth/youtube"]
    tok_p = ROOT / yt_cfg["token_path"]
    sec_p = ROOT / yt_cfg["client_secrets_path"]
    creds = Credentials.from_authorized_user_file(str(tok_p), scopes) if tok_p.exists() else None
    if creds and not creds.has_scopes(scopes):
        print("[OAUTH] Saved token is missing a required scope; re-running consent once in the browser.")
        creds = None
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(str(sec_p), scopes)
            creds = flow.run_local_server(port=0)
        tok_p.parent.mkdir(parents=True, exist_ok=True)
        tok_p.write_text(creds.to_json(), encoding="utf-8")
    return build("youtube", "v3", credentials=creds)


TAG_BUDGET = 450   # YouTube caps tags at 500 chars (tags with spaces count their quotes, plus a comma between tags)


def tag_cost(tags: list[str]) -> int:
    return sum(len(t) + (2 if " " in t else 0) for t in tags) + max(len(tags) - 1, 0)


def build_metadata(spec: dict, cfg: dict) -> tuple[str, str, list[str]]:
    """(title, description, tags) for snippet, all from story.yaml + config."""
    yt_cfg = cfg["automation"]["youtube"]
    title = re.sub(r"\s*#\w+", "", spec["title"]).strip()[:100]
    hashtags = spec.get("hashtags") or cfg["channel"]["default_hashtags"]
    lines = [spec.get("description", title)]
    if spec.get("cta"):
        lines.append(spec["cta"])
    lines.append("New Roblox 'In This World' story every day on StudVerse Tales.")
    lines.append(" ".join(hashtags[:5]))
    desc = "\n\n".join(lines)

    plain_title = re.sub(r"[^\w\s'-]", " ", title).lower()
    title_words = [w for w in plain_title.split() if len(w) >= 4]
    raw = list(spec.get("tags") or []) + [spec.get("rule_type") or ""] + title_words + list(yt_cfg.get("default_tags") or [])
    tags, seen = [], set()
    for t in raw:
        t = re.sub(r"\s+", " ", str(t).replace("#", "").replace("_", " ")).strip()
        if not t or t.lower() in seen:
            continue
        if tag_cost(tags + [t]) > TAG_BUDGET:
            break
        tags.append(t); seen.add(t.lower())
    return title, desc, tags


def resolve_playlist_id(yt, playlist_name: str, fallback_id: str = "") -> str:
    """The channel's playlist with this exact title (case-insensitive), else the configured id, else ''."""
    req = yt.playlists().list(part="snippet", mine=True, maxResults=50)
    while req is not None:
        resp = req.execute()
        for it in resp.get("items", []):
            if it["snippet"]["title"].strip().lower() == playlist_name.strip().lower():
                return it["id"]
        req = yt.playlists().list_next(req, resp)
    return fallback_id or ""


def add_to_playlist(yt, playlist_id: str, vid_id: str) -> bool:
    """Idempotent: True if added now, False if it was already in the playlist."""
    have = yt.playlistItems().list(part="id", playlistId=playlist_id, videoId=vid_id, maxResults=1).execute()
    if have.get("items"):
        return False
    yt.playlistItems().insert(part="snippet", body={"snippet": {
        "playlistId": playlist_id, "resourceId": {"kind": "youtube#video", "videoId": vid_id}}}).execute()
    return True


def upload_and_schedule(ep: dict, cfg: dict, db: PipelineDB, dry_run: bool = False, refresh_metadata: bool = False,
                        refresh_only: bool = False):
    """refresh_only: already scheduled/published -> update metadata/thumbnail/playlist, never touch the schedule."""
    yt_cfg = cfg["automation"]["youtube"]
    sdir = Path(ep["story_dir"])
    spec = yaml.safe_load((sdir / "story.yaml").read_text(encoding="utf-8"))
    ep_id = ep["episode_id"]
    video_file = sdir / f"{ep_id}_FINAL.mp4"
    thumb_file = sdir / "thumbnail.jpg"
    if not video_file.exists():
        raise FileNotFoundError(f"Missing final MP4: {video_file}")

    title, desc, tags = build_metadata(spec, cfg)
    pub_at = next_publish_slot(db, int(yt_cfg.get("daily_publish_hour_ist", 19)))
    snippet = {"title": title, "description": desc, "tags": tags, "categoryId": "20",   # Gaming
               "defaultLanguage": "en", "defaultAudioLanguage": "en"}

    body = {
        "snippet": snippet,
        "status": {
            "privacyStatus": "private",  # HARD-CODED PRIVATE ON INSERT (Nov 2, 2026 default-public safety)
            "selfDeclaredMadeForKids": bool(yt_cfg.get("self_declared_made_for_kids", False)),
            "containsSyntheticMedia": bool(yt_cfg.get("contains_synthetic_media", False)),
        },
    }

    if dry_run:
        held = cfg["automation"].get("require_human_approval", False) and not ep.get("human_approved")
        if ep.get("youtube_video_id"):
            print(f"[DRY-RUN] {ep_id} already uploaded as {ep['youtube_video_id']}: would skip insert"
                  + (" and refresh title/description/tags/thumbnail:" if refresh_metadata else " + thumbnail"))
            if refresh_metadata:
                print(json.dumps(snippet, indent=2, ensure_ascii=False))
        else:
            print(f"[DRY-RUN] Would upload {video_file.name} ({video_file.stat().st_size / 1e6:.1f} MB) with body:")
            print(json.dumps(body, indent=2, ensure_ascii=False))
        print(f"[DRY-RUN] tags: {len(tags)} ({tag_cost(tags)}/{TAG_BUDGET} chars) | playlist: '{yt_cfg.get('playlist_name', '')}'")
        if refresh_only:
            print(f"[DRY-RUN] {ep_id} is {ep.get('status')}: schedule left untouched"); return
        print(f"[DRY-RUN] then poll processingStatus, then " + ("HOLD PRIVATE (needs --approve)" if held else f"schedule publishAt={pub_at}"))
        return

    from googleapiclient.http import MediaFileUpload
    yt = get_youtube_client(yt_cfg)
    vid_id = ep.get("youtube_video_id") or ""
    if vid_id:
        # idempotent resume: this episode is already on YouTube; never insert a duplicate
        print(f"[RESUME] {ep_id} already uploaded as {vid_id}; skipping insert")
        if refresh_metadata:
            yt.videos().update(part="snippet", body={"id": vid_id, "snippet": snippet}).execute()
            if thumb_file.exists():
                try:
                    yt.thumbnails().set(videoId=vid_id, media_body=MediaFileUpload(str(thumb_file))).execute()
                except Exception as e:
                    print(f"[WARN] Thumbnail refresh skipped: {e}")
            print(f"[REFRESHED] {ep_id} title/description/{len(tags)} tags/thumbnail")
    else:
        media = MediaFileUpload(str(video_file), chunksize=8 * 1024 * 1024, resumable=True, mimetype="video/mp4")
        req = yt.videos().insert(part="snippet,status", body=body, media_body=media)
        resp = None
        while resp is None:
            _, resp = req.next_chunk()
        vid_id = resp["id"]
        db.set_status(ep_id, "UPLOADED_PRIVATE", youtube_video_id=vid_id)

        if thumb_file.exists():
            try:
                yt.thumbnails().set(videoId=vid_id, media_body=MediaFileUpload(str(thumb_file))).execute()
            except Exception as e:
                print(f"[WARN] Thumbnail upload skipped (channel may need phone verification): {e}")

    pname = yt_cfg.get("playlist_name", "")
    if pname or yt_cfg.get("playlist_id"):
        pid = resolve_playlist_id(yt, pname, yt_cfg.get("playlist_id", "")) if pname else yt_cfg.get("playlist_id")
        if pid:
            print(f"[PLAYLIST] {ep_id} -> '{pname}' ({pid}): " + ("added" if add_to_playlist(yt, pid, vid_id) else "already in playlist"))
        else:
            print(f"[WARN] Playlist '{pname}' not found on the channel and no playlist_id set; create it in YouTube Studio.")
    if refresh_only:
        print(f"[STUDIO EDIT / RELATED VIDEO] https://studio.youtube.com/video/{vid_id}/edit")
        return

    # Poll processingStatus before scheduling; not done yet -> stay UPLOADED_PRIVATE, the next run resumes here
    pstat = ""
    for _ in range(30):
        st = yt.videos().list(part="processingDetails", id=vid_id).execute()
        if not st.get("items"):
            raise RuntimeError(f"YouTube video {vid_id} for {ep_id} not found (deleted?). Clear youtube_video_id to re-upload.")
        pstat = st["items"][0].get("processingDetails", {}).get("processingStatus", "")
        if pstat == "succeeded":
            break
        if pstat in ("failed", "terminated"):
            raise RuntimeError(f"YouTube processing failed for {vid_id}: {pstat}")
        time.sleep(10)
    if pstat != "succeeded":
        print(f"[PENDING] {ep_id} ({vid_id}) still processing ({pstat or 'unknown'}); will schedule on the next run")
        return

    # Schedule publishAt only if unattended mode OR human approved
    if not cfg["automation"].get("require_human_approval", False) or ep.get("human_approved"):
        yt.videos().update(part="status", body={
            "id": vid_id,
            "status": {
                "privacyStatus": "private",
                "publishAt": pub_at,
                "selfDeclaredMadeForKids": bool(yt_cfg.get("self_declared_made_for_kids", False)),
                "containsSyntheticMedia": bool(yt_cfg.get("contains_synthetic_media", False)),  # update resets omitted fields
            },
        }).execute()
        db.set_status(ep_id, "SCHEDULED", publish_at=pub_at)
        print(f"[SCHEDULED] {ep_id} -> https://youtube.com/shorts/{vid_id} @ {pub_at}")
    else:
        print(f"[HELD PRIVATE] {ep_id} (awaiting human approval)")
    print(f"[STUDIO EDIT / RELATED VIDEO] https://studio.youtube.com/video/{vid_id}/edit")

    if yt_cfg.get("purge_raw_after_upload", True):
        freed = purge_raw_captures(sdir)
        print(f"[STORAGE] Purged raw captures: {freed / (1024*1024):.1f} MB freed")


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--dry-run", action="store_true")
    p.add_argument("--approve", help="Mark episode_id as human_approved=1")
    p.add_argument("--episode", help="Act on this one episode only (e.g. 007), whatever the daily queue says")
    p.add_argument("--refresh-metadata", action="store_true",
                   help="On already-uploaded episodes, also update title/description/tags + thumbnail")
    a = p.parse_args()

    sys.stdout.reconfigure(encoding="utf-8")  # emoji titles on a cp1252 console
    cfg = load_config()
    yt_cfg = cfg["automation"]["youtube"]
    warns = check_oauth_health(yt_cfg)
    for w in warns:
        print(f"[OAUTH WARN] {w}")
    sec, tok = ROOT / yt_cfg["client_secrets_path"], ROOT / yt_cfg["token_path"]
    print(f"[OAUTH] client_secrets: {'present' if sec.exists() else 'MISSING'} | token: "
          f"{'present' if tok.exists() else 'not yet created (first real upload opens browser consent once)'} | "
          f"published={yt_cfg.get('oauth_published', False)} | warnings={len(warns)}")

    db = PipelineDB(ROOT / "ledger" / "pipeline.db")
    try:
        if a.approve:
            db.set_status(a.approve, "APPROVED", human_approved=1)
            print(f"[APPROVED] Episode {a.approve}")
        if cfg["automation"].get("require_human_approval", False):
            ready = db.list_by_status("APPROVED") + [
                e for e in db.list_by_status("UPLOADED_PRIVATE") if e.get("human_approved")]
        else:
            ready = db.list_by_status("GATE3_PASS", "APPROVED", "UPLOADED_PRIVATE")
        if a.dry_run:  # preview what would go out once approved too; dry-run never changes anything
            ready = db.list_by_status("APPROVED", "GATE3_PASS", "UPLOADED_PRIVATE")
        ready.sort(key=lambda e: e["episode_id"])
        cap = int(yt_cfg.get("uploads_per_day", 1))
        if a.episode:
            ep = db.get_episode(a.episode)
            if not ep:
                raise SystemExit(f"No episode {a.episode} in pipeline.db")
            done = ep["status"] in ("SCHEDULED", "POSTED_MANUAL")
            if done and not (ep.get("youtube_video_id") and a.refresh_metadata):
                raise SystemExit(f"{a.episode} is {ep['status']}; use --refresh-metadata to update its metadata/thumbnail.")
            if not done and ep["status"] not in ("GATE3_PASS", "APPROVED", "UPLOADED_PRIVATE"):
                raise SystemExit(f"{a.episode} is {ep['status']}; it must pass Gate 3 first.")
            upload_and_schedule(ep, cfg, db, dry_run=a.dry_run, refresh_metadata=a.refresh_metadata, refresh_only=done)
            return
        for ep in ready[:cap]:
            upload_and_schedule(ep, cfg, db, dry_run=a.dry_run, refresh_metadata=a.refresh_metadata)
        keep_days = int(yt_cfg.get("quarantine_retention_days", 14))
        freed_q = 0 if a.dry_run else prune_quarantine_videos(ROOT, keep_days) + prune_audit_zips(ROOT, keep_days)
        if freed_q:
            print(f"[STORAGE] Pruned expired quarantine videos + audit zips: {freed_q / (1024*1024):.1f} MB freed")
    finally:
        db.close()


if __name__ == "__main__":
    main()
