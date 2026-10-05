:: ============================================================
:: BATLAB | ProxyDetector.bat | v1.0.0
:: @desc      Detecta se existe proxy configurado no Windows
:: @category  network-advanced
:: @platform windows
:: @admin     no
:: @risk      low
:: @writes    none
:: @deletes   none
:: @registry  read
:: @services  none
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ProxyDetector
echo ============================================
echo  BATLAB - ProxyDetector
echo ============================================
echo Este script detecta se existe proxy configurado no Windows.
echo Proxy mal configurado e causa comum de pagina que nao abre.
echo.
echo Proxy do usuario atual, chamado de WinINET:
powershell -NoProfile -Command "Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -ErrorAction SilentlyContinue | Select-Object ProxyEnable,ProxyServer,AutoConfigURL | Format-List"
echo.
echo Proxy do sistema, chamado de WinHTTP:
netsh winhttp show proxy
echo.
echo Resumo rapido do proxy do usuario:
powershell -NoProfile -Command "$p = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -ErrorAction SilentlyContinue; if ($p.ProxyEnable -eq 1) { 'PROXY ATIVO: ' + $p.ProxyServer } else { 'PROXY DO USUARIO DESLIGADO' }; if ($p.AutoConfigURL) { 'CONFIGURACAO AUTOMATICA: ' + $p.AutoConfigURL }"
echo.
echo [i] Proxy ativo encontrado aqui pode explicar falhas de navegacao.
:fim
echo.
pause
