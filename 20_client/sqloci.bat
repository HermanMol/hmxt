@echo off
setlocal
set "dbu=%~1"
set "dbp=%~2"
rem hmol, 2026-10-21 15:22:00
rem https://forums.oracle.com/ords/apexds/post/sqlcl-release-25-1-jre-24-warning-a-restricted-method-in-ja-9589#comment_82909068402697175290840244404527711447
echo **************************************************************************************
echo *A: Setting Java enable-native-acces and enable-final-field-mutation to ALL-UNNAMED
echo.    because using Java 24 and SQLcl requires only 17 or 21 (21 is preferred).
echo **************************************************************************************
set "JAVA_TOOL_OPTIONS=--enable-native-access=ALL-UNNAMED --enable-final-field-mutation=ALL-UNNAMED"
sql -cloudconfig H:\70_data\oracle\oci_herman96\Wallet_TDQ02CEI7GIKC7J5.zip %dbu%/%dbp%@tdq02cei7gikc7j5_medium
endlocal
exit /b
