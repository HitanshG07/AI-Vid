# One-time setup for AI-Vid V5 (Windows 11, no Blender needed)
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) { winget install -e --id Gyan.FFmpeg }
python -m pip install -r requirements.txt
python pipeline/make_sfx.py
Write-Host "AI-Vid V5 ready. Read START_HERE.md." -ForegroundColor Green
