:: ============================================================
:: BATLAB | OpenBluetoothSettings.bat | v1.0.0
:: @desc      Abre Bluetooth (ms-settings:bluetooth)
:: @category  everyday
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenBluetoothSettings
echo ============================================
echo  BATLAB - OpenBluetoothSettings
echo ============================================
echo Abrindo as configuracoes de Bluetooth...
start "" ms-settings:bluetooth
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir as configuracoes de Bluetooth.
    goto :fim
)
echo [OK] Configuracoes de Bluetooth abertas.
echo [Dica] Dispositivo nao aparece? Verifique se o adaptador existe.
echo Feito.
:fim
echo.
pause
