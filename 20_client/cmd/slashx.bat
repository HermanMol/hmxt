@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Change the path to Unix/Linux using forward slahes
-- #example: slashx thepathtochange
:EndHelp

setlocal
set "org=%~1"
set "new=%org:\=/%
echo *I: org = "%org%"
echo *I: new = "%new%"
endlocal
exit /b
