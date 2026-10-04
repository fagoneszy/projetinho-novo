:: ============================================================
:: BATLAB | ConnectionLogger.bat | v1.0.0
:: @desc      Registra em log o status da conexao com o DNS do Google
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ConnectionLogger
echo ============================================
echo  BATLAB - ConnectionLogger
echo ============================================
set "LOG=%~1"
if not defined LOG set "LOG=%CD%\conexao.log"
echo Registrando status da conexao em: %LOG%
echo Destino fixo: 8.8.8.8 (uma tentativa a cada 5 segundos).
echo Pressione Ctrl+C para encerrar o logger.
echo.
:loop
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd HH:mm:ss"') do set "TS=%%i"
ping -n 1 -w 2000 8.8.8.8 >nul
if errorlevel 1 (echo [%TS%] FALHA>>"%LOG%" & echo [%TS%] FALHA) else (echo [%TS%] OK>>"%LOG%" & echo [%TS%] OK)
timeout /t 5 /nobreak >nul
goto :loop
echo.
pause