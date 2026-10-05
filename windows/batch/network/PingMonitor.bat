:: ============================================================
:: BATLAB | PingMonitor.bat | v1.0.0
:: @desc      Ping continuo (-t) para um host ate o usuario cancelar
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PingMonitor
echo ============================================
echo  BATLAB - PingMonitor
echo ============================================
set "HOST=%~1"
if not defined HOST set /p "HOST=Host alvo (ex.: 8.8.8.8): "
if not defined HOST set "HOST=8.8.8.8"
echo Ping continuo em %HOST% com a opcao -t.
echo Pressione Ctrl+C para encerrar o monitor.
echo Cada linha mostra tempo de resposta e TTL.
echo.
ping -t %HOST%
echo.
echo Monitoramento encerrado pelo usuario.
echo [i] Para um ping unico use PingTest.bat.
echo Feito.
:fim
echo.
pause
