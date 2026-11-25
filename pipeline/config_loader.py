"""Load config.yaml with safe defaults (works even if PyYAML is not installed yet)."""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

DEFAULTS = {
    "channel": {"handle": "@studversetales", "name": "StudVerse Tales", "default_hashtags": ["#roblox", "#rblx", "#stories", "#shorts"]},
    "video": {"width": 1080, "height": 1920, "fps": 30, "transpose": "2", "lead_in_seconds": 0.3, "max_shot_seconds": 2.2},
    "voice": {
        "engine": "kokoro", "kokoro_voice": "am_michael:0.65,am_fenrir:0.35", "kokoro_fallback": "am_adam",
        "kokoro_speed": 1.10, "edge_voice": "en-US-ChristopherNeural", "edge_rate": "+20%", "edge_pitch": "+2Hz",
        "silence_threshold_db": -42, "silence_trigger_sec": 0.14, "silence_keep_sec": 0.05,
        "twist_pause_sec": 0.30, "target_wpm_min": 175,
        "speakers": {"narrator": {"kokoro": "am_michael", "edge": "en-US-ChristopherNeural", "speed": 1.10}}, "target_wpm_max": 205,
    },
    "captions": {"style": "SafeCenterPop", "font": "Arial Black", "font_size": 96, "margin_v": 560, "max_words_per_card": 2, "max_chars_per_card": 12, "min_card_sec": 0.55},
    "audio": {"bgm_gain": 0.14, "climax_bgm_gain": 0.22, "duck_bgm_gain": 0.02, "bgm_moods": {"mystery": "roblox-story-bg.mp3", "action": "bgm_action.mp3", "wholesome": "bgm_wholesome.mp3", "dark": "bgm_dark.mp3", "none": ""}},
    "playlists": {
        "story": "In This World Stories", "anime_fight": "Roblox Anime Fights", "spot_the_lie": "Spot The Lie Mysteries",
        "beat_drop": "Beat-Drop Edits", "psychology": "Roblox Mind Rules", "thought_sim": "What If Simulations",
    },
}

def load_config(path: Path | None = None) -> dict:
    cfg_path = path or (ROOT / "config.yaml")
    if cfg_path.exists():
        try:
            import yaml
            loaded = yaml.safe_load(cfg_path.read_text(encoding="utf-8")) or {}
            merged = {k: (dict(v) if isinstance(v, dict) else v) for k, v in DEFAULTS.items()}
            for k, v in loaded.items():
                if isinstance(v, dict) and isinstance(merged.get(k), dict):
                    merged[k].update(v)
                else:
                    merged[k] = v
            return merged
        except ImportError:
            pass
    return DEFAULTS
