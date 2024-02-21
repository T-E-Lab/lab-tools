@echo off
REM Batch file to transfer behavioral data to the NAS

SET src="C:\Users\exx\AppData\LocalLow\Default company\Fly Virtual Reality - 3D Rotating test world"
SET dst="Z:\Live Fly Imaging data\unity\raw data\Backups"
SET exclude="SessionParameters.json"

REM Append time and date to filename
REM https://stackoverflow.com/questions/11037831/filename-timestamp-in-windows-cmd-batch-script-getting-truncated
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

SET log_file="Z:\Data Management\Logs\move_bhv_data_to_nas_%fullstamp%.log"

REM Move files from source to destination and create a log file
robocopy %src% %dst% *.json /S /E /DCOPY:DAT /MOV /IS /IM /IT /XF %exclude% /LOG+:%log_file% /NP
