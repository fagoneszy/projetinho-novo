:: ============================================================
:: BATLAB | WebsiteMonitor.bat | v1.0.0
:: @desc      Monitora uma URL a cada N segundos ate o usuario cancelar
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WebsiteMonitor
echo ============================================
echo  BATLAB - WebsiteMonitor
echo ============================================
set "URL=%~1"
if not defined URL set /p "URL=URL para monitorar (ex.: https://google.com): "
if not defined URL set "URL=https://google.com"
set /p "SEG=Intervalo em segundos [10]: "
if not defined SEG set "SEG=10"
echo Monitorando: %URL%
echo Intervalo:   %SEG% segundos
echo Pressione Ctrl+C para encerrar o monitor.
echo.
:loop
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format HH:mm:ss"') do set "TS=%%i"
curl -Is -m 5 "%URL%" | findstr /i /b "HTTP" >nul
if errorlevel 1 (echo [%TS%] [X] %URL% nao respondeu) else (echo [%TS%] [OK] %URL% respondendo)
timeout /t %SEG% /nobreak >nul
goto :loop
echo.
pause