:: ============================================================
:: BATLAB | OpenWindowsFolder.bat | v1.0.0
:: @desc      Abre a pasta do Windows
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenWindowsFolder
echo ============================================
echo  BATLAB - OpenWindowsFolder
echo ============================================
set "P=%WINDIR%"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo Abrindo a pasta do Windows:
echo   %P%
explorer "%P%"
if errorlevel 1 echo [!] Confira se a janela do Explorer abriu.
echo [ATENCAO] Nao altere arquivos dessa pasta.
echo Feito.
:fim
echo.
pause
