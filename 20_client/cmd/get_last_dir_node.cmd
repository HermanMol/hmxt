@echo off
rem get the last node of a path returned in variable name in argument 1
rem Example: 
rem   call get_last_dir_node lastnode
rem   title HMX: %lastnode%
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
