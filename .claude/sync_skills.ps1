# Source of truth: .claude/skills (read-only on disk). Owner edits there, then runs: powershell -File .claude\sync_skills.ps1
$src = Join-Path $PSScriptRoot 'skills'
$dsts = '..\.agents\skills', '..\.agent\skills' | ForEach-Object { Join-Path $PSScriptRoot $_ }
foreach ($d in @($src) + $dsts) { if (Test-Path $d) { attrib -R "$d\*" /S /D } }
foreach ($d in $dsts) { New-Item -ItemType Directory -Force $d | Out-Null; robocopy $src $d /MIR /NFL /NDL /NJH /NJS | Out-Null }
foreach ($d in @($src) + $dsts) { attrib +R "$d\*" /S }
Write-Host 'skills synced + locked read-only'
