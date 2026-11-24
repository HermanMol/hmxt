@echo off
rem Change the foreground and background color on the screen for next text line(s)
rem Use color_end.cmd to revert to normal
rem Use colortext.bat to show only one line
setlocal
rem get the Esc character
for /F %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
set "rq=%~1..."
rem foreground is first character
set "fg=%rq:~0,1%"
rem background is second character, default black = none
set "bg=%rq:~1,1%"
if "%bg%" equ "." set "bg=n"
rem style is third character, default = normal = none
rem Note the semicolon leading the value!
set "st=%rq:~2,1%"
if /I "%st%" equ "B" set "st=;1" & goto :nextstep
if /I "%st%" equ "U" set "st=;4" & goto :nextstep
if /I "%st%" equ "I" set "st=;7" & goto :nextstep
rem Looks like no an invalid style was requested.
set st=
:nextstep
set "fgnr=."
set "bgnr=."
for /F "usebackq tokens=3-6* delims= " %%H in (`findstr /B /C:"rem data:%fg%=" "%HMXT_LOCAL%\data\color_definitions.cfg" `) do set "fgnr=%%J"
for /F "usebackq tokens=3-6* delims= " %%H in (`findstr /B /C:"rem data:%bg%=" "%HMXT_LOCAL%\data\color_definitions.cfg" `) do set "bgnr=%%I"
rem if any of the colors is not found, a message is displayed and a default foreground and background color are assigned
if "%fgnr%" equ "." (
	echo *W: No color for foreground color "%fg%"; use: n,r,g,y,b,m/p,c/a,w uppercase for bright.
	set "fgnr=101"
	set "bgnr=93"
	rem exit /b 1
	)
if "%bgnr%" equ "." (
	echo *W: No color for background color "%bg%"; use: n,r,g,y,b,m/p,c/a,w uppercase for bright.
	set "fgnr=101"
	set "bgnr=93"
	rem exit /b 1
	)
rem Swith the screen color
echo %ESC%[%fgnr%;%bgnr%%st%m
endlocal
exit /b 0
