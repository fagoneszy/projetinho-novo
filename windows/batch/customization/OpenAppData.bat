:: ============================================================
:: BATLAB | OpenAppData.bat | v1.0.0
:: @desc      Abre a pasta AppData
:: @category  customization
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenAppData
echo ============================================
echo  BATLAB - OpenAppData
echo ============================================
set "P=%APPDATA%"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo Abrindo a pasta AppData (Roaming):
echo   %P%
explorer "%P%"
if errorlevel 1 echo [!] Confira se a janela do Explorer abriu.
echo [Dica] %LOCALAPPDATA% e a pasta AppData\Local.
echo Feito.
:fim
echo.
pause