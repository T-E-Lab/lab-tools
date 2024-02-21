REM Batch file to connect to NAS
REM Scheduled to run on Lab Workstation startup

if exist z:\ (
    net use z: /delete /y
)
net use z: "\\TurnerEvans-NAS\Lab Storage"
