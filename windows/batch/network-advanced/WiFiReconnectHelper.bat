:: ============================================================
:: BATLAB | WiFiReconnectHelper.bat | v1.0.0
:: @desc      Desconecta e reconecta o Wi-Fi em uma rede ja salva
:: @category  network-advanced
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes    none
:: @deletes   none
:: @registry  none
:: @services  none
:: @tasks     none
:: @network   write
:: @restart   none
:: @undo      Conectar manualmente pela lista do Windows ou por netsh wlan connect
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WiFiReconnectHelper
echo ============================================
echo  BATLAB - WiFiReconnectHelper
echo ============================================
echo Este script desconecta e reconecta o Wi-Fi em uma rede salva.
echo A conexao cai por alguns segundos enquanto e reconfigurada.
echo.
echo Redes salvas neste computador:
netsh wlan show profiles
echo.
set "SSID=%~1"
if not defined SSID set /p "SSID=Nome da rede (SSID): "
if not defined SSID (echo [ERRO] Nenhuma rede informada. & goto :fim)
choice /c SN /m "Reconectar na rede %SSID%? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Desconectando a interface Wi-Fi atual...
netsh wlan disconnect
echo Esperando 3 segundos...
timeout /t 3 /nobreak >nul
echo Reconectando em %SSID%...
netsh wlan connect name="%SSID%"
if errorlevel 1 (echo [!] Falha ao conectar. Confira o nome exato da rede. & goto :fim)
echo.
echo Estado atual da interface sem fio:
netsh wlan show interfaces
echo.
echo [i] Se a rede nao estava salva, conecte-se pela barra de tarefas.
:fim
echo.
pause
