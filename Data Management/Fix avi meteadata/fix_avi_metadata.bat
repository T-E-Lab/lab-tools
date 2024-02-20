@echo off
REM Batch file to run fix_avi_metadata.py

SET log_file="Z:\Data Management\Logs"
SET folder="Z:\Live Fly Imaging data\fictrac"
call %UserProfile%\Anaconda3\Scripts\activate.bat
call conda activate avi_fix
python fix_avi_metadata.py %folder% > %log_file%
call conda deactivate
