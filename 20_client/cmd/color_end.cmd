@echo off
rem Change the foreground and background color back
rem Use color_begin.cmd to set a different screen color.
rem Use colortext.bat to show only one line.
setlocal
for /F %%a in ('echo prompt $E^| cmd ') do set "ESC=%%a"
echo %ESC%[0m
endlocal
exit /b 0
