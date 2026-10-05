:: ============================================================
:: BATLAB | OpenSystem32.bat | v1.0.0
:: @desc      Abre a pasta System32
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenSystem32
echo ============================================
echo  BATLAB - OpenSystem32
echo ============================================
set "P=%WINDIR%\System32"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo Abrindo a pasta System32:
echo   %P%
explorer "%P%"
if errorlevel 1 echo [!] Confira se a janela do Explorer abriu.
echo [ATENCAO] Nao mova nem apague arquivos dessa pasta.
echo Feito.
:fim
echo.
pause
