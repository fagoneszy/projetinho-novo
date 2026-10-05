:: ============================================================
:: BATLAB | WiFiDisconnectLogger.bat | v1.0.0
:: @desc      Registra as quedas e reconexoes do Wi-Fi em um relatorio
:: @category  network-advanced
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes    user
:: @deletes   none
:: @registry  none
:: @services  read
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      Apagar o arquivo batlab-logs\wifi-disconnects.txt
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WiFiDisconnectLogger
echo ============================================
echo  BATLAB - WiFiDisconnectLogger
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador para ler o log do Wi-Fi. & pause & exit /b 1)
echo Este script coleta eventos de queda e reconexao do Wi-Fi.
echo O resultado fica em um arquivo de texto para analise posterior.
echo.
set "LOG=%USERPROFILE%\batlab-logs\wifi-disconnects.txt"
choice /c SN /m "Coletar os ultimos 50 eventos do Wi-Fi em %LOG%? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$log = Join-Path $env:USERPROFILE 'batlab-logs\wifi-disconnects.txt'; New-Item -ItemType Directory -Force -Path (Split-Path $log) | Out-Null; $e = Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-WLAN-AutoConfig/Operational'; Id=8001,8002,11004,11005} -MaxEvents 50 -ErrorAction SilentlyContinue; $e | Select-Object TimeCreated,Id,Message | Out-File -Encoding utf8 $log; 'Eventos gravados: ' + @($e).Count + ' em ' + $log"
echo.
if not exist "%LOG%" (echo [!] Nenhum evento foi coletado. & goto :fim)
echo Conteudo gerado:
type "%LOG%"
echo.
echo [i] Os IDs 8001 e 8002 sao desconexao e reconexao do Wi-Fi.
:fim
echo.
pause
