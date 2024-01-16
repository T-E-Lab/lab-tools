:: Script to wake from sleep or hibernate
@echo off

:: User Variables
set "rdpfile=C:\Users\ahshenas\Desktop\LabWorkstation.rdp"
set "wolcmd=C:\Users\ahshenas\Desktop\WolCmd.exe"

:: PC info
set "macaddress=F02F74A67A5F"
set "ipaddress=128.114.151.6"
set "submask=255.255.254.0"

:: Need to add vpn connection

:: Wake on lan
%wolcmd% F02F74A67A5F 128.114.151.6 255.255.254.0

:: Sleep for 29 to 30 seconds
timeout /t 30 /nobreak 
:: > NUL

:: Remote Desktop
mstsc %rdpfile%

:: Close cmd
exit