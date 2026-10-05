:: ============================================================
:: BATLAB | AutoNetworkMonitor.bat | v1.0.0
:: @desc      Monitora a internet e registra quando cai ou volta
:: @category  automation
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoNetworkMonitor
echo ============================================
echo  BATLAB - AutoNetworkMonitor
echo ============================================
setlocal EnableDelayedExpansion
set "SEG=60"
if not "%~1"=="" set "SEG=%~1"
echo(%SEG%| findstr /r "^[1-9][0-9][0-9]?[0-9]?$" >nul
if errorlevel 1 (echo Intervalo invalido: %SEG%. Use 1 a 9999 segundos. & goto :fim)
set "LOG=%~dp0rede_log.txt"
echo [%date% %time%] Inicio do monitoramento >> "%LOG%"
echo Monitorando a rede a cada %SEG%s (ping 8.8.8.8). Ctrl+C para parar.
set "ANT=INDEFINIDO"
:loop
ping -n 1 -w 3000 8.8.8.8 >nul
if errorlevel 1 (set "ST=FALHOU") else (set "ST=OK")
if not "!ST!"=="!ANT!" (
    echo [%time%] Rede: !ANT! para !ST!
    echo [%date% %time%] Rede: !ANT! para !ST! >> "%LOG%"
    set "ANT=!ST!"
)
timeout /t %SEG% /nobreak >nul
goto :loop
echo.
pause