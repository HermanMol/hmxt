@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Get the topi/project root folder and returns it in the first argument.
-- #example: call get_topic_root_folder myvar
             echo Project root folder = %myvar%
:EndHelp
rem Hmol 2026-11-07 14:28:50
rem Search up the path from the current path until the folder 95_hmxt is
rem found: THEN you are in the root of the HMXT Topic Work Folder. From there
rem all folders should be addressable relatively...
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
