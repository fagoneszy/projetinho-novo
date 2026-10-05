:: ============================================================
:: BATLAB | InternetRouteAnalyzer.bat | v1.0.0
:: @desc      Analisa o caminho de rota usado para chegar a Internet
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
title BATLAB - InternetRouteAnalyzer
echo ============================================
echo  BATLAB - InternetRouteAnalyzer
echo ============================================
echo Este script analisa o caminho que o Windows usa para a Internet.
echo Mostra quantos saltos existem e por onde a rota comeca.
echo.
echo Roteamento completo para 1.1.1.1:
powershell -NoProfile -Command "Test-NetConnection -ComputerName '1.1.1.1' -TraceRoute -InformationLevel Detailed"
echo.
echo Rotas padrao e metricas de preferencia:
powershell -NoProfile -Command "Get-NetRoute -AddressFamily IPv4 -DestinationPrefix '0.0.0.0/0' | Sort-Object RouteMetric | Format-Table -AutoSize InterfaceAlias,NextHop,RouteMetric,State"
echo.
echo Roteamento completo para 8.8.8.8:
powershell -NoProfile -Command "Test-NetConnection -ComputerName '8.8.8.8' -TraceRoute -InformationLevel Quiet"
echo.
echo [i] Muitos saltos ou estrelas indicam firewall ou perda no caminho.
:fim
echo.
pause
