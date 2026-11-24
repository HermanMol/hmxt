@echo off
rem Change the path to Unix/Linux using forward slahes
setlocal
set "org=%~1"
set "new=%org:\=/%
echo *I: org = "%org%"
echo *I: new = "%new%"
endlocal
exit /b
