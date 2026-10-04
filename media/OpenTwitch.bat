:: ============================================================
:: BATLAB | OpenTwitch.bat | v1.0.0
:: @desc      Abre a Twitch no navegador
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenTwitch
echo ============================================
echo  BATLAB - OpenTwitch
echo ============================================
set "URL=https://www.twitch.tv"
echo Abrindo a Twitch no navegador:
echo   %URL%
start "" "%URL%"
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir o navegador.
    goto :fim
)
echo Twitch solicitada.
echo Feito.
:fim
echo.
pause