:: ============================================================
:: BATLAB | OpenDownloads.bat | v1.0.0
:: @desc      Abre a pasta Downloads
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenDownloads
echo ============================================
echo  BATLAB - OpenDownloads
echo ============================================
set "P=%USERPROFILE%\Downloads"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo Abrindo a pasta Downloads:
echo   %P%
explorer "%P%"
if errorlevel 1 echo [!] Confira se a janela do Explorer abriu.
echo Feito.
:fim
echo.
pause