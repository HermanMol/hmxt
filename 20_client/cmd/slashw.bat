@echo off
rem Change the path to Windows using backward slahes
setlocal
set "org=%~1"
set "new=%org:/=\%
echo *I: org = "%org%"
echo *I: new = "%new%"
endlocal
exit /b
