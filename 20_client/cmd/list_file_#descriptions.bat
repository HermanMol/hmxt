@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: List all lines atrting with "-- #desc: " in all files in the current folder
:EndHelp
rem Hmol 2026-11-07 14:28:50
echo ===========================================================================
echo *I: Listing all lines starting with "-- #desc: " 
echo.    in all files in folder 
echo     %cd%
echo ===========================================================================
findstr /B /I /P /C:"-- #desc: " *
echo ===========================================================================
echo.
echo Done.
pause
