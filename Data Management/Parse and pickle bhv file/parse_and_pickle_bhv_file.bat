@echo off
REM Batch file to run parse_and_pickle_bhv_file.py

SET log_file="Z:\Data Management\Logs"
SET folder="Z:\Live Fly Imaging data\fictrac"
call %~dp0\..\activate_conda_env.bat avi_fix gulp2p
python %~dp0\parse_and_pickle_bhv_file.py > %log_file%
call conda deactivate
