@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Create an ASCII-art banner from text using ascii_XX.txt character definition files.
-- #example: ascii_banner "Hello World"
:EndHelp
powershell -File %HMXT_LOCAL%\cmd\ascii_banner.ps1 %1
