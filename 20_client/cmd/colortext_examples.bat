@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: Show examples of the HMX colortext statement
-- #example: colortext_examples
:EndHelp
rem n - black (none / bright=dark grey) "None", to avoid conflict with blue"
rem r - red (bright)
rem g - green (bright)
rem y - yellow (bright)
rem b - blue (bright)
rem m - magenta (bright)
rem c - cyan (bright)
rem w - white (light grey / bright=white)

call colortext nBu " nBu = Black text on bright blue background, underlined"
call colortext Bnu " Bnu = Bright blue text on black background, underlined"
call colortext gn  " gn  = Green text, black background "
call colortext Gn  " Gn  = Bright green text, black background "
call colortext ng  " ng  = Black text, green background a.k.a. inverse"
call colortext nG  " nG  = Black text, bright green background a.k.a. inverse"
call colortext wb  " wb  = White (light grey) text, blue background "
call colortext Wb  " Wb  = White  text, blue background "
call colortext yb  " yb  = Yellow text, blue background "
call colortext Yb  " Yb  = bright yellow text, blue background "
call colortext Ynu " Attention, next line has invisible text..."
call colortext nn  " nn  = Invisible text: black text on same background"
call colortext nYu " Did you see that!?"
colortext /?

exit /b
