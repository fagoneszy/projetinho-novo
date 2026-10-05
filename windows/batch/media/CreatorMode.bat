:: ============================================================
:: BATLAB | CreatorMode.bat | v1.0.0
:: @desc      Abre o ambiente de criador de conteudo (OBS, Discord, pasta do projeto)
:: @category  media
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CreatorMode
echo ============================================
echo  BATLAB - CreatorMode
echo ============================================
set "OBS=C:\Program Files\obs-studio\bin\64bit\obs64.exe"
set "PROJ=%USERPROFILE%\Videos\Projetos"
if not "%~1"=="" set "PROJ=%~1"
echo Abrindo o ambiente de criador de conteudo:
echo   - OBS Studio: %OBS%
echo   - Discord
echo   - Pasta do projeto: %PROJ%
echo.
if exist "%OBS%" (start "" "%OBS%") else (echo [!] OBS nao encontrado em %OBS%.)
if exist "%LOCALAPPDATA%\Discord\Update.exe" (start "" "%LOCALAPPDATA%\Discord\Update.exe" --processStart Discord.exe) else (echo [!] Discord nao encontrado.)
if not exist "%PROJ%" md "%PROJ%" 2>nul
if exist "%PROJ%" (start "" explorer "%PROJ%") else (echo [ERRO] Nao foi possivel abrir a pasta do projeto.)
echo Ambiente solicitado.
echo Feito.
echo.
pause
