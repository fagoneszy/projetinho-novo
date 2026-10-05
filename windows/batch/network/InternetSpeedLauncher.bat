:: ============================================================
:: BATLAB | InternetSpeedLauncher.bat | v1.0.0
:: @desc      Abre o teste de velocidade speedtest.net no navegador
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - InternetSpeedLauncher
echo ============================================
echo  BATLAB - InternetSpeedLauncher
echo ============================================
echo Abrindo o teste de velocidade no navegador...
echo Site: https://www.speedtest.net
echo Host: %COMPUTERNAME%
echo [i] Clique em GO no site para iniciar a medicao.
start "" "https://www.speedtest.net"
if errorlevel 1 (echo [!] Falha ao abrir o navegador padrao. & goto :fim)
echo.
echo [i] Alternativa: use o CLI speedtest se estiver instalado.
echo Feito.
:fim
echo.
pause