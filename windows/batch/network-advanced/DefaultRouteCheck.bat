:: ============================================================
:: BATLAB | DefaultRouteCheck.bat | v1.0.0
:: @desc      Verifica as rotas padrao e o caminho de saida para a Internet
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
title BATLAB - DefaultRouteCheck
echo ============================================
echo  BATLAB - DefaultRouteCheck
echo ============================================
echo Este script mostra as rotas padrao e testa a saida para a Internet.
echo.
echo Rotas padrao IPv4 em ordem de preferencia:
powershell -NoProfile -Command "Get-NetRoute -AddressFamily IPv4 -DestinationPrefix '0.0.0.0/0' | Sort-Object RouteMetric | Format-Table -AutoSize InterfaceAlias,NextHop,RouteMetric,State"
echo.
echo Tabela de rotas resumida:
powershell -NoProfile -Command "route.exe print -4 | Select-String -Pattern '0.0.0.0','Persist'"
echo.
echo Teste de saida para um endereco publico:
powershell -NoProfile -Command "'Ping para 1.1.1.1:'; ping.exe -n 4 -w 1000 1.1.1.1"
echo.
echo [i] Sem rota 0.0.0.0 o Windows nao acha caminho para a Internet.
:fim
echo.
pause
