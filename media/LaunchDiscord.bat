:: ============================================================
:: BATLAB | LaunchDiscord.bat | v1.0.0
:: @desc      Abre o Discord
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LaunchDiscord
echo ============================================
echo  BATLAB - LaunchDiscord
echo ============================================
set "UPD=%LOCALAPPDATA%\Discord\Update.exe"
if exist "%UPD%" (
    echo Iniciando o Discord pelo instalador local...
    start "" "%UPD%" --processStart Discord.exe
    if errorlevel 1 (echo [!] Nao foi possivel iniciar pelo instalador local.)
    goto :fim
)
echo [!] Discord nao encontrado em:
echo   %UPD%
echo Tentando abrir pelo protocolo discord://...
start "" "discord://"
if errorlevel 1 (echo [ERRO] Discord nao encontrado no sistema.) else (echo Protocolo discord:// enviado.)
echo Feito.
:fim
echo.
pause