@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Get the last node of a path and returns it in the first argument.
-- #example: call get_last_dir_node lastnode
             title HMX: %lastnode%
:EndHelp
rem Hmol 2026-11-07 14:28:50
setlocal enabledelayedexpansion
set "here=%cd:~2%"
pushd ..
set "parent=%cd:~2%\"
popd
(set "last=!here:%parent%=!")
rem echo *D: here   = "%here%"
rem echo *D: parent = "%parent%"
rem echo *D: last   = "%last%"
(endlocal & set "%1=%last%")
exit /b
