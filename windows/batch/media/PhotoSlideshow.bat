:: ============================================================
:: BATLAB | PhotoSlideshow.bat | v1.0.0
:: @desc      Inicia um visualizador da pasta de imagens
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PhotoSlideshow
echo ============================================
echo  BATLAB - PhotoSlideshow
echo ============================================
set "P=%USERPROFILE%\Pictures"
if not "%~1"=="" set "P=%~1"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo Iniciando o visualizador da pasta de imagens:
echo   %P%
echo [Dica] Use as setas do teclado para passar as imagens.
start "" explorer "%P%"
if errorlevel 1 echo [!] Confira se a janela do Explorer abriu.
echo Pasta aberta para visualizacao.
echo [Dica] Para um slideshow completo use o app Fotografia.
:fim
echo.
pause