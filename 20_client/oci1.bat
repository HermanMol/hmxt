@echo off
setlocal
call hmx_init
call hmx_get_parm database herman96 %1 pwd
call tiesrever.cmd "%pwd%" pwd
(set pwd= & call sqloci.bat %1 %pwd%)
endlocal
exit /b
