@echo off
REM Batch file to run parse_and_pickle_bhv_file.py

SET log_file="Z:\Data Management\Logs"
SET folder="Z:\Live Fly Imaging data\fictrac"
call %UserProfile%\Anaconda3\Scripts\activate.bat
call conda activate gulp2p
python parse_and_pickle_bhv_file.py > %log_file%
call conda deactivate
