:: ============================================================
:: BATLAB | WifiInfo.bat | v1.0.0
:: @desc      Exibe os detalhes da conexao Wi-Fi ativa
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WifiInfo
echo ============================================
echo  BATLAB - WifiInfo
echo ============================================
echo Lendo a interface Wi-Fi ativa...
echo Host: %COMPUTERNAME%
echo.
netsh wlan show interfaces
if errorlevel 1 (echo [!] Falha: nenhuma interface Wi-Fi ativa. & goto :fim)
echo.
echo [i] Campos uteis: SSID, Sinal, Velocidade, Canal, BSSID.
echo [i] Redes visiveis: WifiNetworks.bat. Sinal: WifiSignal.bat.
echo Feito.
:fim
echo.
pause
