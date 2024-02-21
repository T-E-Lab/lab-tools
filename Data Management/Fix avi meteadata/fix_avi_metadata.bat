@echo off
REM Batch file to run fix_avi_metadata.py

call "%~dp0\..\create_log_file_name.bat" fix_avi_metadata
SET folder="Z:\Live Fly Imaging data\fictrac"
call "%~dp0\..\activate_conda_env.bat" avi_fix
python "%~dp0\fix_avi_metadata.py" %folder% > %log_file%
call conda deactivate
