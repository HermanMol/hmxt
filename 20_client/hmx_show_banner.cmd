@echo off
rem Show the project banner, is it exists. Skip lines starting with # and the esc character as delimiter
set "banner=H:\80_programs\hmxt_local\data\banners\banner_%~1.txt"
call get_esc.cmd esc
rem if exist "%banner%" for /f "eol=# tokens=* delims=%esc%" %%L in (%banner%) do @echo %%L
if exist "%banner%" echo. & type "%banner%" & echo.
set banner=
exit /b
