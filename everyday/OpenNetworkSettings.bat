:: ============================================================
:: BATLAB | OpenNetworkSettings.bat | v1.0.0
:: @desc      Abre rede nas Configuracoes (ms-settings:network)
:: @category  everyday
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenNetworkSettings
echo ============================================
echo  BATLAB - OpenNetworkSettings
echo ============================================
echo Abrindo as configuracoes de rede...
start "" ms-settings:network
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir as configuracoes de rede.
    goto :fim
)
echo [OK] Configuracoes de rede abertas.
echo [Dica] Diagnostico rapido: ipconfig /all
echo Feito.
:fim
echo.
pause