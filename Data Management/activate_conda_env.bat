@echo OFF
rem run a Python script in a given conda environment from a batch file.
rem https://gist.github.com/maximlt/531419545b039fa33f8845e5bc92edd6

rem Define here the path to your conda installation
set CONDAPATH=%UserProfile%\anaconda3
rem Get env name from the batch argument
set ENVNAME=%1

rem The following command activates the base environment.
rem call C:\ProgramData\Miniconda3\Scripts\activate.bat C:\ProgramData\Miniconda3
if %ENVNAME%==base (set ENVPATH=%CONDAPATH%) else (set ENVPATH=%CONDAPATH%\envs\%ENVNAME%)

rem Activate the conda environment
rem Using call is required here, see: https://stackoverflow.com/questions/24678144/conda-environments-and-bat-files
call "%CONDAPATH%\Scripts\activate.bat" "%ENVPATH%"
