@echo off
REM Batch file to run parse_and_pickle_bhv_file.py
REM Run in windows task scheduler with: 
REM Program: Wscript
REM Args: "C:\Users\remoteuser\Documents\GitHub\lab-tools\Data Management\launchquiet.vbs" "C:\Users\remoteuser\Documents\GitHub\lab-tools\Data Management\Parse and pickle bhv file\parse_and_pickle_bhv_file.bat"

SET folder="\\TurnerEvans-NAS\Lab Storage\Live Fly Imaging data\fictrac"
REM Create log file name
call "%~dp0\..\create_log_file_name.bat" parse_and_pickle_bhv_file

REM Run script
call "%~dp0\..\activate_conda_env.bat" gulp2p
python "%~dp0\parse_and_pickle_bhv_file.py" > %log_file% 2>&1
call conda deactivate
