@echo off
rem get_topic_root_folder.cmd
rem Search up the path from the current path until the folder 95_hmxt is
rem found: THEN you are in the root of the HMXT Topic Work Folder. From there
rem all folders should be addressable relatively...
rem Usage: call get_topic_root_folder myvar
rem ... will return the HMXT root in myvar or empty is none found.
rem Version 2023-04-30 11:04:43
setlocal
set "curdir=%cd%"
set rootdir=
call :getdrive curdrv %curdir%
rem echo *D: Current drive = %curdrv%
:findroot
	rem echo *D: Checking %cd% ...
	if exist 95_hmxt goto :foundbase
	cd ..
	if /i "%curdrv%\" neq "%cd%" goto :findroot
:foundbase
if /i "%curdrv%\" equ "%cd%" echo *A: Not an HMXT Topic Work Folder (the folder 95_hmxt could not be found) &exit /b 1
rem echo *D: Topic Root Folder = %cd%
set "rootdir=%cd%"
cd %curdir%
(endlocal & set "%~1=%rootdir%" & exit /b 0)
rem ******************************** SUBROUTINES *******************************
:getdrive
	(endlocal & set "%~1=%~d2" & exit /b)
