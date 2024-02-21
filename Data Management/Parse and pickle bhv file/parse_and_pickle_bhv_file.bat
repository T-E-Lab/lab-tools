@echo off
REM Batch file to run parse_and_pickle_bhv_file.py

SET folder="Z:\Live Fly Imaging data\fictrac"
REM Create log file name
call "%~dp0\..\create_log_file_name.bat" parse_and_pickle_bhv_file

REM Run script
call "%~dp0\..\activate_conda_env.bat" gulp2p
python "%~dp0\parse_and_pickle_bhv_file.py" > %log_file%
call conda deactivate
