@echo off
echo ===========================================================================
echo *I: Listing all lines containing "-- #desc:" 
echo.    in all files in folder 
echo     %cd%
echo ===========================================================================
findstr /P /C:"-- #desc:" *
echo ===========================================================================
echo.
echo Done.
pause
