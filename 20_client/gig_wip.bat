@echo off
rem gig_wip.bat git check ignore with various options
setlocal
rem ------------------------------
echo.
echo 01) Expected not ignored (w/index) 
@echo on
git check-ignore -v ./40_database/db_admin/installers/!about.txt
@set "err=%ERRORLEVEL%
@echo off
echo *I: ErrorLevel=%err%
if %err% equ 0 echo *I: --^> Will be ignored
if %err% equ 1 echo *I: --^> Will NOT be ignored
if %err% equ 128 echo *A: --^> Fatal error during git check-ignore

rem ------------------------------
echo.
echo 02) Expected not ignored (no-index)
@echo on
git check-ignore -v -- no-index ./40_database/db_admin/installers/!about.txt
@set "err=%ERRORLEVEL%
@echo off
echo *I: ErrorLevel=%err%
if %err% equ 0 echo *I: --^> Will be ignored
if %err% equ 1 echo *I: --^> Will NOT be ignored
if %err% equ 128 echo *A: --^> Fatal error during git check-ignore

rem ------------------------------
echo.
echo 03) Expected ignored (w/index) 
@echo on
git check-ignore -v ./10_doc/!about_10_doc.txt
@set "err=%ERRORLEVEL%
@echo off
echo *I: ErrorLevel=%err%
if %err% equ 0 echo *I: --^> Will be ignored
if %err% equ 1 echo *I: --^> Will NOT be ignored
if %err% equ 128 echo *A: --^> Fatal error during git check-ignore

rem ------------------------------
echo.
echo 04) Expected ignored (no-index)
@echo on
git check-ignore -v -- no-index ./10_doc/!about_10_doc.txt
@set "err=%ERRORLEVEL%
@echo off
echo *I: ErrorLevel=%err%
if %err% equ 0 echo *I: --^> Will be ignored
if %err% equ 1 echo *I: --^> Will NOT be ignored
if %err% equ 128 echo *A: --^> Fatal error during git check-ignore



set "checkthis=./40_database/db_admin/templates/hmx_templates.txt"
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
