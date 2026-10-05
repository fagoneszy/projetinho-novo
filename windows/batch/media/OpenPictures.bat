:: ============================================================
:: BATLAB | OpenPictures.bat | v1.0.0
:: @desc      Abre a pasta de imagens
:: @category  media
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenPictures
echo ============================================
echo  BATLAB - OpenPictures
echo ============================================
set "P=%USERPROFILE%\Pictures"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo Abrindo a pasta de imagens:
echo   %P%
explorer "%P%"
if errorlevel 1 echo [!] Confira se a janela do Explorer abriu.
echo Feito.
:fim
echo.
pause
