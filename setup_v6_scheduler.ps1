# Register AI-Vid V6.0 Closed-Loop Daemon in Windows Task Scheduler (Run once as standard user)
$Action = New-ScheduledTaskAction -Execute "python.exe" -Argument "C:\AI-Vid\pipeline\daemon.py --mode full" -WorkingDirectory "C:\AI-Vid"
$Trigger = New-ScheduledTaskTrigger -Daily -At 11:00AM
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
Register-ScheduledTask -TaskName "AIVid_V6_DailyLoop" -Action $Action -Trigger $Trigger -Settings $Settings -Force
Write-Host "Registered Windows Task Scheduler job: AIVid_V6_DailyLoop (Daily 11:00 AM)"
