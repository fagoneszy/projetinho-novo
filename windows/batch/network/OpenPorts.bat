:: ============================================================
:: BATLAB | OpenPorts.bat | v1.0.0
:: @desc      Lista as portas em escuta no sistema com netstat
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenPorts
echo ============================================
echo  BATLAB - OpenPorts
echo ============================================
echo Listando portas em escuta (LISTENING)...
echo Host: %COMPUTERNAME%
echo.
netstat -ano | findstr /i "LISTENING"
if errorlevel 1 (echo [!] Nenhuma porta em escuta encontrada. & goto :fim)
echo.
echo [i] A ultima coluna e o PID do processo dono da porta.
echo [i] Use ConnectionList.bat para ver os processos.
echo Feito.
:fim
echo.
pause
