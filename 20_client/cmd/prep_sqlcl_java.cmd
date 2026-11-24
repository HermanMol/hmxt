@echo off
if "%~1" equ "/?" hlp "%~0"
goto :EndHelp
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
:StartHelp
-- #desc: This file prepares the Java environment for running Oracle SQLcl.
:EndHelp
rem THIS FILE IS MEANT FOR RUNNING ORACLE SQLCL
rem hmo, 2026-11-16 09:38:19
rem ================================================================================================
rem set environment to accomodate the SQLcl with the proper Java environment
rem Current 2026-11-16 09:42:27 in the PATH:
rem   + C:\Program Files\Common Files\Oracle\Java\javapath
rem   + C:\Program Files (x86)\Common Files\Oracle\Java\java8path
rem   + C:\Program Files (x86)\Common Files\Oracle\Java\javapath
rem Older, used before:
rem set "JAVA_HOME=C:\Program Files\Java\jdk-23\bin"
rem set "PATH=%JAVA_HOME%;%PATH%"
rem ================================================================================================
rem hmol, 2026-10-21 15:22:00
rem https://forums.oracle.com/ords/apexds/post/sqlcl-release-25-1-jre-24-warning-a-restricted-method-in-ja-9589#comment_82909068402697175290840244404527711447
call color_begin rB
echo **************************************************************************************
echo *A: Setting Java enable-native-acces and enable-final-field-mutation to ALL-UNNAMED
echo.    because using Java 24 and SQLcl requires only 17 or 21 (21 is preferred).
echo **************************************************************************************
set "JAVA_TOOL_OPTIONS=--enable-native-access=ALL-UNNAMED --enable-final-field-mutation=ALL-UNNAMED"
call color_end
