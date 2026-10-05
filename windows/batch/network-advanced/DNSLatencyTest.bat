:: ============================================================
:: BATLAB | DNSLatencyTest.bat | v1.0.0
:: @desc      Mede a latencia de resolucao do DNS em varios testes
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
title BATLAB - DNSLatencyTest
echo ============================================
echo  BATLAB - DNSLatencyTest
echo ============================================
echo Este script mede quanto tempo cada resolucao DNS leva.
echo Latencia alta indica servidor DNS lento ou rota ruim ate ele.
echo.
echo Cinco medicoes de www.microsoft.com:
powershell -NoProfile -Command "1..5 | ForEach-Object { '{0} - {1:N1} ms' -f $_, (Measure-Command { Resolve-DnsName -Name 'www.microsoft.com' -ErrorAction SilentlyContinue }).TotalMilliseconds }"
echo.
echo Cinco medicoes de www.google.com:
powershell -NoProfile -Command "1..5 | ForEach-Object { '{0} - {1:N1} ms' -f $_, (Measure-Command { Resolve-DnsName -Name 'www.google.com' -ErrorAction SilentlyContinue }).TotalMilliseconds }"
echo.
echo [i] Compare o DNS do roteador com 1.1.1.1: rota lenta pesa no total.
:fim
echo.
pause
