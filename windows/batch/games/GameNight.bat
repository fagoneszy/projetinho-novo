:: ============================================================
:: BATLAB | GameNight.bat | v1.0.0
:: @desc      Prepara a noite de jogos: abre Steam, Discord e a pasta de jogos
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GameNight
echo ============================================
echo  BATLAB - GameNight
echo ============================================
set "PASTA_JOGOS=%USERPROFILE%\Games"
echo Iniciando a noite de jogos...
start "" steam://open/games
start "" discord://
if exist "%PASTA_JOGOS%" (start "" explorer "%PASTA_JOGOS%") else echo   [!] Pasta nao encontrada: %PASTA_JOGOS%
echo Pronto. Bom jogo!
echo.
pause
