@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Show the current remote git repositoty.
:EndHelp
rem Hmol 2026-11-07 14:28:50

echo.
echo Current remote repository:
git config get remote.origin.url
