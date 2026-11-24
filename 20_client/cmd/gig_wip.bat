@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Git Ignore checker, wrapper for git check-ignore (experimental)
-- #example: gig_wip filetocheck 
:EndHelp
rem Hmol 2026-11-07 14:28:50
setlocal
rem ------------------------------
set "checkthis=%~1"
rem ------------------------------
echo.
echo 05) ?Expected ignored (w/index) 
@echo on
git check-ignore -v %checkthis%

@set "err=%ERRORLEVEL%
@echo off
echo *I: ErrorLevel=%err%
if %err% equ 0 echo *I: --^> Will be ignored
if %err% equ 1 echo *I: --^> Will NOT be ignored
if %err% equ 128 echo *A: --^> Fatal error during git check-ignore

rem ------------------------------
echo.
echo 06) ?Expected ignored (no-index)
@echo on
git check-ignore -v -- no-index %checkthis%
@set "err=%ERRORLEVEL%
@echo off
echo *I: ErrorLevel=%err%
if %err% equ 0 echo *I: --^> Will be ignored
if %err% equ 1 echo *I: --^> Will NOT be ignored
if %err% equ 128 echo *A: --^> Fatal error during git check-ignore

endlocal
exit /b
