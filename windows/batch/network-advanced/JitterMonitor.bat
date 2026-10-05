:: ============================================================
:: BATLAB | JitterMonitor.bat | v1.0.0
:: @desc      Monitora a variacao de latencia chamada jitter
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
title BATLAB - JitterMonitor
echo ============================================
echo  BATLAB - JitterMonitor
echo ============================================
echo Este script mede a variacao de latencia, conhecida como jitter.
echo Jitter alto causa video travando e audio cortando em chamadas.
echo.
echo Dez medicoes de latencia para 8.8.8.8:
powershell -NoProfile -Command "1..10 | ForEach-Object { [math]::Round((Measure-Command { Test-Connection -ComputerName '8.8.8.8' -Count 1 -Quiet -ErrorAction SilentlyContinue }).TotalMilliseconds, 1) }"
echo.
echo Minimo, maximo, media e estimativa de jitter:
powershell -NoProfile -Command "$r = 1..10 | ForEach-Object { (Measure-Command { Test-Connection -ComputerName '8.8.8.8' -Count 1 -Quiet -ErrorAction SilentlyContinue }).TotalMilliseconds }; $m = $r | Measure-Object -Minimum -Maximum -Average; 'min={0:N1} ms  max={1:N1} ms  media={2:N1} ms  jitter~={3:N1} ms' -f $m.Minimum, $m.Maximum, $m.Average, ($m.Maximum - $m.Minimum)"
echo.
echo [i] Jitter abaixo de 20 ms e aceitavel; acima de 50 ms ja incomoda.
:fim
echo.
pause
