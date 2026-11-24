@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Show the project banner, is it exists. Skip lines starting with # and the esc character as delimiter
-- #alternative: ascii_banner
:EndHelp
rem Hmol 2026-11-07 14:28:50
set "banner=%HMXT_LOCAL%\data\banners\banner_%~1.txt"
call get_esc.cmd esc
rem if exist "%banner%" for /f "eol=# tokens=* delims=%esc%" %%L in (%banner%) do @echo %%L
if exist "%banner%" echo. & type "%banner%" & echo.
set banner=
exit /b
