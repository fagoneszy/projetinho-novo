:: ============================================================
:: BATLAB | WifiSignal.bat | v1.0.0
:: @desc      Exibe apenas o nivel de sinal do Wi-Fi atual
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WifiSignal
echo ============================================
echo  BATLAB - WifiSignal
echo ============================================
echo Exibindo apenas o nivel de sinal do Wi-Fi...
echo Host: %COMPUTERNAME%
echo.
netsh wlan show interfaces | findstr /i "Sinal Signal"
if errorlevel 1 (echo [!] Nenhum sinal encontrado - Wi-Fi desligado. & goto :fim)
echo.
echo [i] Referencia: 80+ excelente, 50 a 79 medio, abaixo de 50 fraco.
echo [i] Detalhes completos: WifiInfo.bat.
echo Feito.
:fim
echo.
pause