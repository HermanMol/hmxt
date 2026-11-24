@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Return the ESC character (27) in the first argument.
-- #example: call get_esc xchar
--           returns the ESC character in the xchar variable of the calling module
:EndHelp
setlocal
for /F %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
(endlocal & set "%1=%ESC%")
