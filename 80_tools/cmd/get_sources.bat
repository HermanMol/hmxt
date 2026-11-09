@echo **** [todo] *** %f0 *** 2023-04-30 12:07:48

rem @echo off
rem echo.
rem echo *I: Get sources into %cd%
rem echo.
rem call ictd_cmd_init.cmd
rem echo.
rem set "dbenv=%~1"
rem if "%dbenv%" equ "" set /p "dbenv=*Q: Please enter database environment (d/t/a/p): "
rem if "%dbenv%" equ "" echo *I: No database environment; exit & exit /b
rem echo.
rem echo *A: example: call xddl %dbenv% vos svw LST_MUTATIES_MAKEN
rem echo.
pause
