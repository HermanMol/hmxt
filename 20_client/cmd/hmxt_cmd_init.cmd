@echo off
rem hmxt_cmd_init.cmd
rem Initialize the CMD session for HMXT
rem a. Set the Title to the last directory node
rem b. Set your favourite prompt

rem d. If the current folder is for the current company, then add the company
rem    command and SQL script folders to the PATH and SQLPATH (if not already
rem    in those patchs)
rem HMXT 2023-07-30 12:13:28
rem HMXT 2026-11-07 12:52:10
cd %cd%
rem
:already_set
call get_last_dir_node lastnode
rem title HMX - %cd:~-15%
title HMX: %lastnode%
set lastnode=
call myprompt.bat
call get_topic_root_folder hmxwrkroot
set "err=%ERRORLEVEL%"
rem echo *D: Error = %err%
rem echo *D: HMX Work root folder = %hmxwrkroot%
if "%err%" equ "0" set "SQLPATH=%SQLPATH%;%hmxwrkroot%\10_wrk\80_tools\sql"
if "%err%" equ "0" set "PATH=%PATH%;%hmxwrkroot%\10_wrk\80_tools\cmd"
rem Show the project banner, is it exists. Skip lines starting with # and the esc character as delimiter
set "banner=%hmxwrkroot%\10_wrk\60_data\banners\project_banner.txt"
call get_esc.cmd esc
if exist "%banner%" for /f "eol=# tokens=* delims=%esc%" %%L in (%banner%) do @echo %%L
set banner=
set esc=
echo *I: Current HMXT settings:
set HMXT
echo.
echo *I: HMXT Command Prompt has been initialized.
exit /b
