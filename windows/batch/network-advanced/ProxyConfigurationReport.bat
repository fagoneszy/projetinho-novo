:: ============================================================
:: BATLAB | ProxyConfigurationReport.bat | v1.0.0
:: @desc      Relatorio completo das configuracoes de proxy do sistema
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
title BATLAB - ProxyConfigurationReport
echo ============================================
echo  BATLAB - ProxyConfigurationReport
echo ============================================
echo Este script junta todas as configuracoes de proxy em um relatorio.
echo Inclui WinINET, WinHTTP, variaveis de ambiente e IP publico.
echo.
echo 1. Proxy do usuario, chamado de WinINET:
powershell -NoProfile -Command "Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -ErrorAction SilentlyContinue | Select-Object ProxyEnable,ProxyServer,AutoConfigURL,ProxyOverride | Format-List"
echo.
echo 2. Proxy do sistema, chamado de WinHTTP:
netsh winhttp show proxy
echo.
echo 3. Variaveis de ambiente com a palavra PROXY:
powershell -NoProfile -Command "Get-ChildItem Env: | Where-Object { $_.Name -match 'PROXY' } | Format-Table -AutoSize Name,Value"
echo.
echo 4. Endereco IP publico visto de fora:
powershell -NoProfile -Command "(Invoke-RestMethod -Uri 'https://api.ipify.org' -TimeoutSec 8)"
echo.
echo [i] Se 1, 2 e 3 divergirem, cada aplicacao usa um caminho diferente.
:fim
echo.
pause
