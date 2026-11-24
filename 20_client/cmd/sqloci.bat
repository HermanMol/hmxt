@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Execute SQLcl on my database schema given proper credentials.
-- #example: sqloci dbuser password
:EndHelp
setlocal
set "dbu=%~1"
set "dbp=%~2"
rem
call prep_sqlcl_java.cmd
rem
rem Change Character Code Page to UTF8 (https://ss64.com/nt/chcp.html)
rem * The 65000/1 code pages are encoded as UTF-7/8 to allow to working with unicode data in 7-bit and 8-bit environments.
rem get current code page
For /f "tokens=2 delims=:." %%G in ('chcp') Do set _codepage=%%G
echo *I: Setting code page to UTF-8
chcp 65001
rem
sql -cloudconfig %MYLOCALDATA%\oracle\oci_herman96\Wallet_TDQ02CEI7GIKC7J5.zip %dbu%/%dbp%@tdq02cei7gikc7j5_medium
rem
rem restore original Character Code Page
echo *I: Restoring original code page %_codepage%
chcp %_codepage%
rem
endlocal
exit /b
