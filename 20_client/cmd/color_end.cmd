@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Change the foreground and background color back
:EndHelp
rem Use color_begin.cmd to set a different screen color.
rem Use colortext.bat to show only one line.
setlocal
for /F %%a in ('echo prompt $E^| cmd ') do set "ESC=%%a"
echo %ESC%[0m
endlocal
exit /b 0
