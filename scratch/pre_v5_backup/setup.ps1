# One-time setup for AI-Vid (run from C:\AI-Vid)
if (-not (Get-Command blender -ErrorAction SilentlyContinue)) { winget install -e --id BlenderFoundation.Blender }
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) { winget install -e --id Gyan.FFmpeg }
python -m pip install -r requirements.txt
Write-Host "Done. Roblox Studio: enable Assistant > ... > Manage MCP Servers > 'Enable Studio as MCP server'." -ForegroundColor Green
