:: ============================================================
:: BATLAB | GameLauncher.bat | v1.0.0
:: @desc      Menu para abrir seus jogos (lista em games.txt)
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GameLauncher
echo ============================================
echo  BATLAB - GameLauncher
echo ============================================
setlocal EnableDelayedExpansion
set "LISTA=%~dp0games.txt"
if not exist "%LISTA%" (
    >"%LISTA%" echo C:\Caminho\Jogo\jogo.exe
    >>"%LISTA%" echo steam://run/440
    >>"%LISTA%" echo https://store.steampowered.com
    echo Lista criada: %LISTA%
    echo Edite com seus jogos e execute de novo.
    goto :fim
)
set "N=0"
for /f "usebackq delims=" %%A in ("%LISTA%") do (
    set /a N+=1
    set "JOGO_!N!=%%A"
    echo   !N!. %%A
)
if !N! EQU 0 (echo Lista vazia: %LISTA% & goto :fim)
set /p "OPCAO=Escolha o jogo (1-!N!): "
if not defined OPCAO goto :fim
if !OPCAO! LSS 1 goto :fim
if !OPCAO! GTR !N! goto :fim
set "ALVO=!JOGO_%OPCAO%!"
echo Abrindo: !ALVO!
start "" "!ALVO!"
:fim
echo.
pause
