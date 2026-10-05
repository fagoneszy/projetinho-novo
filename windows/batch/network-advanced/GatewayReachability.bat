:: ============================================================
:: BATLAB | GatewayReachability.bat | v1.0.0
:: @desc      Testa se o gateway padrao da rede responde ao ping
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
title BATLAB - GatewayReachability
echo ============================================
echo  BATLAB - GatewayReachability
echo ============================================
echo Este script localiza o gateway padrao e testa se ele responde.
echo Gateway sem resposta costuma ser cabo, energia do roteador ou driver.
echo.
powershell -NoProfile -Command "$gw = (Get-NetRoute -DestinationPrefix '0.0.0.0/0' | Sort-Object RouteMetric | Select-Object -First 1).NextHop; if (-not $gw) { 'SEM ROTA PADRAO - o computador esta sem Internet'; exit }; 'Gateway padrao: ' + $gw; ''; 'Rota e interface usadas para sair:'; Get-NetRoute -DestinationPrefix '0.0.0.0/0' | Sort-Object RouteMetric | Format-Table -AutoSize InterfaceAlias,NextHop,RouteMetric,State; ''; 'Testando o gateway:'; ping.exe -n 4 -w 1000 $gw"
echo.
echo Proximos saltos a partir do gateway:
powershell -NoProfile -Command "$gw = (Get-NetRoute -DestinationPrefix '0.0.0.0/0' | Sort-Object RouteMetric | Select-Object -First 1).NextHop; if ($gw) { tracert.exe -d -h 4 -w 800 $gw }"
echo.
echo [i] Se o gateway responde e a Internet nao, o problema e a rota interna.
:fim
echo.
pause
