:: ============================================================
:: BATLAB | OpenYouTube.bat | v1.0.0
:: @desc      Abre o YouTube no navegador
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenYouTube
echo ============================================
echo  BATLAB - OpenYouTube
echo ============================================
set "URL=https://www.youtube.com"
echo Abrindo o YouTube no navegador:
echo   %URL%
start "" "%URL%"
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir o navegador.
    goto :fim
)
echo YouTube solicitado.
echo Feito.
:fim
echo.
pause