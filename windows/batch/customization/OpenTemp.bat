:: ============================================================
:: BATLAB | OpenTemp.bat | v1.0.0
:: @desc      Abre a pasta de temporarios
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenTemp
echo ============================================
echo  BATLAB - OpenTemp
echo ============================================
set "P=%TEMP%"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo Abrindo a pasta de temporarios:
echo   %P%
explorer "%P%"
if errorlevel 1 echo [!] Confira se a janela do Explorer abriu.
echo [Dica] Voce pode apagar arquivos antigos para liberar espaco.
echo Feito.
:fim
echo.
pause
