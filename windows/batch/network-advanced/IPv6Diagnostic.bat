:: ============================================================
:: BATLAB | IPv6Diagnostic.bat | v1.0.0
:: @desc      Diagnostica a configuracao IPv6 dos adaptadores
:: @category  network-advanced
:: @platform windows
:: @admin     no
:: @risk      low
:: @writes    none
:: @deletes   none
:: @registry  read
:: @services  read
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - IPv6Diagnostic
echo ============================================
echo  BATLAB - IPv6Diagnostic
echo ============================================
echo Este script mostra a configuracao IPv6 do computador.
echo IPv6 ativo melhora as rotas e evita intermediarios quebrados.
echo.
echo Enderecos IPv6 por adaptador:
powershell -NoProfile -Command "Get-NetIPAddress -AddressFamily IPv6 | Format-Table -AutoSize InterfaceAlias,IPAddress,PrefixLength,PrefixOrigin"
echo.
echo Estado e MTU das interfaces IPv6:
powershell -NoProfile -Command "Get-NetIPInterface -AddressFamily IPv6 | Format-Table -AutoSize InterfaceAlias,Dhcp,ConnectionState,NlMtu"
echo.
echo Rotas IPv6 registradas no sistema:
powershell -NoProfile -Command "Get-NetRoute -AddressFamily IPv6 -ErrorAction SilentlyContinue | Sort-Object RouteMetric | Select-Object -First 15 DestinationPrefix,NextHop,InterfaceAlias,RouteMetric | Format-Table -AutoSize"
echo.
echo [i] Sem endereco IPv6 global a Internet ainda funciona por IPv4.
:fim
echo.
pause
