:: ============================================================
:: BATLAB | LaunchSpotify.bat | v1.0.0
:: @desc      Abre o Spotify
:: @category  media
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LaunchSpotify
echo ============================================
echo  BATLAB - LaunchSpotify
echo ============================================
echo Iniciando o Spotify pelo protocolo spotify://...
start "" "spotify:"
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir o Spotify.
    echo [Dica] Instale o Spotify da Microsoft Store ou do site oficial.
    goto :fim
)
echo Spotify solicitado.
echo [Dica] Se nada abrir, abra o app Spotify uma vez e tente de novo.
echo Feito.
:fim
echo.
pause
