:: ============================================================
:: BATLAB | AutoWebsiteMonitor.bat | v1.0.0
:: @desc      Monitora se um site esta no ar e registra mudancas
:: @category  automation
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoWebsiteMonitor
echo ============================================
echo  BATLAB - AutoWebsiteMonitor
echo ============================================
setlocal EnableDelayedExpansion
set "URL=%~1"
if not defined URL set "URL=https://www.google.com"
set "SEG=60"
if not "%~2"=="" set "SEG=%~2"
echo(%SEG%| findstr /r "^[1-9][0-9][0-9]?[0-9]?$" >nul
if errorlevel 1 (echo Intervalo invalido: %SEG%. Use 1 a 9999 segundos. & goto :fim)
set "LOG=%~dp0site_log.txt"
echo [%date% %time%] Inicio do monitoramento de %URL% >> "%LOG%"
echo Monitorando %URL% a cada %SEG%s. Ctrl+C para parar.
set "ANT=INDEFINIDO"
:loop
curl -Isf -m 10 -o nul "%URL%"
if errorlevel 1 (set "ST=FORA DO AR") else (set "ST=NO AR")
if not "!ST!"=="!ANT!" (
    echo [%time%] %URL%: !ST!
    echo [%date% %time%] %URL%: !ST! >> "%LOG%"
    set "ANT=!ST!"
)
timeout /t %SEG% /nobreak >nul
goto :loop
echo.
pause