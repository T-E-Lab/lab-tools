@echo off

setlocal enabledelayedexpansion

REM Append time and date to given filename
REM https://stackoverflow.com/questions/11037831/filename-timestamp-in-windows-cmd-batch-script-getting-truncated
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set "log_name=%1"

endlocal & SET log_file="Z:\Data Management\Logs\%log_name%_%fullstamp%.log"
