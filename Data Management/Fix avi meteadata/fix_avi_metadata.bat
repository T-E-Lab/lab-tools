@echo off
REM Batch file to run fix_avi_metadata.py

SET folder="Z:\Live Fly Imaging data\fictrac"
REM Create log file name
call "%~dp0\..\create_log_file_name.bat" fix_avi_metadata

REM Run script
call "%~dp0\..\activate_conda_env.bat" avi_fix
python "%~dp0\fix_avi_metadata.py" %folder% > %log_file% 2>&1
call conda deactivate
