:: ============================================================
:: BATLAB | RandomGame.bat | v1.0.0
:: @desc      Sorteia e abre um jogo da lista games.txt
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RandomGame
echo ============================================
echo  BATLAB - RandomGame
echo ============================================
setlocal EnableDelayedExpansion
set "LISTA=%~dp0games.txt"
if not exist "%LISTA%" (echo Lista nao encontrada: %LISTA% & goto :fim)
set "N=0"
for /f "usebackq delims=" %%A in ("%LISTA%") do (
    set /a N+=1
    set "JOGO_!N!=%%A"
)
if !N! EQU 0 (echo Lista vazia. & goto :fim)
set /a R=%random% %% N + 1
set "ALVO=!JOGO_%R%!"
echo Sorteado !R! de !N!: !ALVO!
start "" "!ALVO!"
:fim
echo.
pause
