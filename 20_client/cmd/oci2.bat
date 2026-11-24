@echo off
echo *** %~0 is deprecated.
echo Now using OCI3
echo.
pause
oci3 %*
exit /b 3

if "%~1" equ "/?" hlp "%~0"
setlocal
call hmx_show_banner.cmd oci2
call hmx_init.bat
rem echo *D: SQLPATH = %SQLPATH%
rem Try to get the HMX Work folder with work-related tools and if found add to the SQLPATH
call get_topic_root_folder.cmd hmxwrkroot
set "err1=%ERRORLEVEL%"
rem *D: err1 = %err1%
rem *D: HMX Work root folder = %hmxwrkroot%
set "new=%hmxwrkroot%\10_wrk\80_tools\sql"
if "%err1%" equ "0" (
    if not exist "%new%" echo *A: Work root folder not found. & goto :part02
    rem echo *D: new = "%new%"
    echo ;%SQLPATH%; | find /I ";%new%;" 1>nul
    if ERRORLEVEL 1 (
        echo *I: Adding %new% to the SQLPATH.
        set "SQLPATH=%SQLPATH%;%new%"
    ) else (
        echo *I: %new% already in the SQLPATH.
    )
)
:part02
echo SQLPATH = %SQLPATH%
pause
rem rem if "%err%" equ "0" set "SQLPATH=%SQLPATH%;%hmxwrkroot%\10_wrk\80_tools\sql"
call hmx_get_parm database herman96 %1 pwd
set "pwd=%pwd:~0,20%
call tiesrever.cmd "%pwd%" pwd
(set pwd= & call sqloci.bat %1 %pwd%)
endlocal
exit /b
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
 :StartHelp
| 
| OCI2
| ====
|
| Purpose: Run SQLcl in my Oracle Cloud Infrastructure
|
| Syntax: oci2 #1
|
| Parameters:
|   #1 is the user to log in into the database
|
| What happens:
| o the SQLPATH is set to the HMX SQL folder
| o When found the project SQL folder is added to the SQLPATH
| o The credentials are collected
| o SQLcl is started (using HMX sqloci.bat)
| 
` !! this line will not be shown in the help !!
| 
| 
:EndHelp
