# AI-Vid V6.4 Lean Craft Mode scheduler (run once as standard user).
# ONLY publishing is automated: Claude crafts + visually verifies each Short, the owner says "approve",
# and these tasks upload APPROVED episodes and sync analytics. Nothing here records, renders or calls vision QA.

# Retire the old closed-loop produce/full job if it was ever registered.
Unregister-ScheduledTask -TaskName "AIVid_V6_DailyLoop" -Confirm:$false -ErrorAction SilentlyContinue

$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

# 1. Publish approved episodes (upload, thumbnail, tags, playlist, 19:00 IST slot, post-upload MP4 cleanup).
$Pub = New-ScheduledTaskAction -Execute "python.exe" -Argument "C:\AI-Vid\pipeline\upload_queue.py" -WorkingDirectory "C:\AI-Vid"
Register-ScheduledTask -TaskName "AIVid_Publish" -Action $Pub -Trigger (New-ScheduledTaskTrigger -Daily -At 10:00AM) -Settings $Settings -Force

# 2. Lightweight YouTube analytics sync (no Gemini, no Studio).
$Sync = New-ScheduledTaskAction -Execute "python.exe" -Argument "C:\AI-Vid\pipeline\daemon.py --mode sync" -WorkingDirectory "C:\AI-Vid"
Register-ScheduledTask -TaskName "AIVid_AnalyticsSync" -Action $Sync -Trigger (New-ScheduledTaskTrigger -Daily -At 10:30PM) -Settings $Settings -Force

Write-Host "Registered: AIVid_Publish (daily 10:00 AM) + AIVid_AnalyticsSync (daily 10:30 PM). No produce/full job."
