@echo off
REM Batch file to run fix_avi_metadata.py

SET log_file="Z:\Data Management\Logs"
SET folder="Z:\Live Fly Imaging data\fictrac"
call %~dp0\..\activate_conda_env.bat avi_fix
python %~dp0\fix_avi_metadata.py %folder% > %log_file%
call conda deactivate
