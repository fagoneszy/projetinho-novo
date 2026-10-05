:: ============================================================
:: BATLAB | WifiNetworks.bat | v1.0.0
:: @desc      Lista as redes Wi-Fi visiveis no ambiente
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WifiNetworks
echo ============================================
echo  BATLAB - WifiNetworks
echo ============================================
echo Escaneando redes Wi-Fi visiveis...
echo Isso pode levar alguns segundos.
echo.
netsh wlan show networks
if errorlevel 1 (echo [!] Falha ao listar redes - Wi-Fi desligado. & goto :fim)
echo.
echo [i] Colunas: SSID, Tipo, Autenticacao, Sinal.
echo [i] Detalhes da conexao atual: WifiInfo.bat.
echo Feito.
:fim
echo.
pause
