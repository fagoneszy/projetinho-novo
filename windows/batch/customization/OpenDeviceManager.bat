:: ============================================================
:: BATLAB | OpenDeviceManager.bat | v1.0.0
:: @desc      Abre o Gerenciador de Dispositivos
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenDeviceManager
echo ============================================
echo  BATLAB - OpenDeviceManager
echo ============================================
echo Abrindo o Gerenciador de Dispositivos...
start "" "%WINDIR%\System32\devmgmt.msc"
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir o Gerenciador de Dispositivos.
    goto :fim
)
echo Gerenciador de Dispositivos solicitado.
echo [Dica] Use a seta ao lado de cada categoria para ver os dispositivos.
echo Feito.
:fim
echo.
pause
