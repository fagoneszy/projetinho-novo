:: ============================================================
:: BATLAB | PublicIP.bat | v1.0.0
:: @desc      Consulta o IP publico via servidor ifconfig.me
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PublicIP
echo ============================================
echo  BATLAB - PublicIP
echo ============================================
echo Consultando o IP publico via ifconfig.me...
echo Aguarde alguns segundos...
echo.
curl -s https://ifconfig.me
if errorlevel 1 (echo [!] Falha na consulta. Verifique a internet ou o curl. & goto :fim)
echo.
echo.
echo [i] Este e o IP publico visto por servidores externos.
echo [i] Se vazio, o curl nao esta disponivel neste sistema.
echo Feito.
:fim
echo.
pause