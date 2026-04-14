@echo off
set /p ip=Enter IP / Host: 
set /p port=Enter Port: 

if "%ip%"=="" set ip=127.0.0.1
if "%port%"=="" set port=135

powershell -ExecutionPolicy Bypass -File "ping_gameserv.ps1" -ip %ip% -port %port%

pause