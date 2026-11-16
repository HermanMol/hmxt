@echo off
rem Print a line with colors
rem Inspiration from:
rem - https://stackoverflow.com/questions/2048509/how-to-echo-with-different-colors-in-the-windows-command-line
rem - https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
rem - Osborne Medium Sherry :-)
rem
rem Example: call colortext nB "nB = Text color black on bright blue"
rem More examples in test_colortext.bat
rem
rem ATTENTION: this bat file contains a data table with the color numbers AND the logic!
rem Works on Command Prompt in Microsoft Windows [Version 10.0.19043.1165]
rem hmo, 13-Sep-2021
rem hmo, 2026-11-14 11:37:39 fixed for Windows terminal [Version 1.24.12741.0]
rem
rem # Next section contains the definition of codes and is used FOR statements, below!
rem # *** DATA SECTION ********** DO NOT CHANGE NEXT DATA **********
rem #_____= #Color   BG FG B Color
rem data:n= black    40 30 0 black = none (to not conflict with blue)
rem data:r= red      41 31 4 red
rem data:g= green    42 32 2 green
rem data:y= yellow   43 33 6 yellow
rem data:b= blue     44 34 1 blue
rem data:m= magenta  45 35 5 magenta
rem data:c= cyan     46 36 3 cyan
rem data:w= white    47 37 7 white
rem data:N= Black   100 90 8 Bright Black = Grey = None (to not conflict with Blue or Green)
rem data:R= Red     101 91 C Bright Red
rem data:G= Green   102 92 A Bright Green
rem data:Y= Yellow  103 93 E Bright Yellow
rem data:B= Blue    104 94 9 Bright Blue
rem data:M= Magenta 105 95 D Bright Magenta
rem data:C= Cyan    106 96 B Bright Cyan
rem data:W= White   107 97 F Bright White
rem #Alternatives:
rem data:a= aqua     46 36 3 aqua (cyan)
rem data:p= purple   45 35 5 purple (magenta)
rem data:A= Aqua    106 96 B Bright Aqua (cyan)
rem data:P= Purple  105 95 D Bright Purple (magenta)
rem # *** DATA SECTION ********** DO NOT CHANGE PRIOR DATA **********
rem Styles: Normal=0, Bold=1, Underline=4, Inverse=7 ... does not work yet - yes it does
if "%1" equ "/?" hlp "%~0"
setlocal
rem get the Esc character
for /F %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
if defined hmodebug echo *D: Looking for %*
set "txt=%~2"
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
rem if /I "%st%" equ "N" set "st=;0" & goto :nextstep   -- because removes all settings
:nextstep
if defined hmodebug echo *D: Foreground=%fg%
if defined hmodebug echo *D: Background=%bg%
if defined hmodebug echo *D: Style     =%st%
set "fgnr=."
set "bgnr=."
for /F "usebackq tokens=3-6* delims= " %%H in (`findstr /B /C:"rem data:%fg%=" "%~f0" `) do set "fgnr=%%J"
for /F "usebackq tokens=3-6* delims= " %%H in (`findstr /B /C:"rem data:%bg%=" "%~f0" `) do set "bgnr=%%I"
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
if defined hmodebug echo *D: Foreground nr=%fgnr%
if defined hmodebug echo *D: Background nr=%bgnr%
if defined hmodebug echo *D: Style      nr=%st%
rem Now print the text
echo %ESC%[%fgnr%;%bgnr%%st%m%txt%%ESC%[0m
endlocal
exit /b
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
|
| colortext
| ==========
|
| Purpose: Print a line with a foreground and background color
|
| Syntax: colortext {fbs} {"text"}
|
| Parameters:
|   - fbs = The foreground and background color and text style.
|          The first character is the foreground color, the second character
|          is the background color. [93;40;4mCase sensitive^![0m If the character is a
|          lower case then the lower intensity is applied. If the character is
|          an UPPER CASE then the high intensity is applied.
|          Possible color values:
|             n/N - black (none / bright=dark grey) "None", to avoid conflict with blue"
|             r/R - red (bright)
|             g/G - green (bright)
|             y/Y - yellow (bright)
|             b/B - blue (bright)
|             m/M - magenta (bright)
|             c/C - cyan (bright)
|             w/W - white (light grey / bright=white)
|           Alternative names
|             p/P - purple (bright) = magenta
|             a/A - aqua (bright)   = cyan
|          The third character is the text style:
|             b = Bright, you could also use the upper case character for the foreground.
|                 Example: code "nrb" has the same effect as "Nr".
|             u = Underlined
|             i = Inverse; you can also exchange foreground and background, like:
|                 => "gn" = green text on black background
|                 => "ng" = black text on green background
|   - "text" = the text to be printed. Must be enclosed in double quotes.
|
` !! this line will not be shown in the help !!
|
| Examples:
|    call colortext nBu "nBu = Black text on bright blue background, underlined"
|    call colortext Bnu "Bnu = Bright blue text on black background, underlined"
|    call colortext gn " gn  = Green text, black background "
|    call colortext Gn " Gn  = Bright green text, black background "
|    call colortext ng " ng  = Black text, green background a.k.a. inverse"
|    call colortext nG " nG  = Black text, bright green background a.k.a. inverse   "
|    call colortext wb " wb  = White (light grey) text, blue background "
|    call colortext Wb " Wb  = White  text, blue background "
|    call colortext yb " yb  = Yellow text, blue background "
|    call colortext Yb " Yb  = bright yellow text, blue background "
|    call colortext nn  "nn  = Invisible text: black text on same background"
|
| Live examples: execute colortext_examples.bat
|
| Optionally you have to enable [30;42mANSI colors[0m by adding this to the registry:
| - in HKEY_CURRENT_USER\Console
| - the item "VirtualTerminalLevel"=dword:00000001
|
` Note: the non-printable Esc character (hex: 1B) must be used for the code.
:EndHelp
