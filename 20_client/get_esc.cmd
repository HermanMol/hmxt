@echo off
rem Return the ESC character (27) in the first argument
setlocal
for /F %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
(endlocal & set "%1=%ESC%")
