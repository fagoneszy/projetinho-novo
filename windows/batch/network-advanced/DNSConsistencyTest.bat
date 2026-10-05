:: ============================================================
:: BATLAB | DNSConsistencyTest.bat | v1.0.0
:: @desc      Compara as respostas do DNS do sistema com um DNS publico
:: @category  network-advanced
:: @platform windows
:: @admin     no
:: @risk      low
:: @writes    none
:: @deletes   none
:: @registry  none
:: @services  none
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DNSConsistencyTest
echo ============================================
echo  BATLAB - DNSConsistencyTest
echo ============================================
echo Este script compara o DNS configurado com o DNS publico 8.8.8.8.
echo Diferenca grande pode ser load balance, cache local ou DNS hijacking.
echo.
echo Resposta do DNS configurado no Windows:
powershell -NoProfile -Command "Resolve-DnsName -Name 'www.microsoft.com' -Type A -ErrorAction SilentlyContinue | Select-Object -ExpandProperty IPAddress"
echo.
echo Resposta do DNS publico 8.8.8.8:
powershell -NoProfile -Command "Resolve-DnsName -Name 'www.microsoft.com' -Type A -Server '8.8.8.8' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty IPAddress"
echo.
echo Diferencas entre as duas respostas, vazio significa identicas:
powershell -NoProfile -Command "Compare-Object (Resolve-DnsName -Name 'www.microsoft.com' -Type A -ErrorAction SilentlyContinue | Select-Object -ExpandProperty IPAddress) (Resolve-DnsName -Name 'www.microsoft.com' -Type A -Server '8.8.8.8' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty IPAddress) | Format-Table -AutoSize InputObject,SideIndicator"
echo.
echo [i] CDNs alternam IPs por design; analise o padrao antes de suspeitar.
:fim
echo.
pause
