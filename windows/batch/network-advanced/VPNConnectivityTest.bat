:: ============================================================
:: BATLAB | VPNConnectivityTest.bat | v1.0.0
:: @desc      Testa se a VPN esta ativa e se o trafego passa por ela
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
title BATLAB - VPNConnectivityTest
echo ============================================
echo  BATLAB - VPNConnectivityTest
echo ============================================
echo Este script checa se a VPN ta ativa e se o trafego sai por ela.
echo.
echo Interfaces de VPN e estado atual:
powershell -NoProfile -Command "Get-NetAdapter -IncludeHidden | Where-Object { $_.Name -match 'VPN|TAP|Tun|WireGuard|OpenVPN|AnyConnect' -or $_.InterfaceDescription -match 'VPN|TAP|Tun|WAN Miniport' } | Format-Table -AutoSize Name,Status,LinkSpeed"
echo.
echo Rotas que passam pela interface de VPN:
powershell -NoProfile -Command "Get-NetRoute | Where-Object { $_.InterfaceAlias -match 'VPN|TAP|Tun|WireGuard' } | Select-Object -First 15 DestinationPrefix,NextHop,RouteMetric | Format-Table -AutoSize"
echo.
echo Testes de saida, True significa que conectou:
powershell -NoProfile -Command "'Porta 53 em 1.1.1.1 : ' + (Test-NetConnection -ComputerName '1.1.1.1' -Port 53 -InformationLevel Quiet); 'Porta 443 em 8.8.8.8 : ' + (Test-NetConnection -ComputerName '8.8.8.8' -Port 443 -InformationLevel Quiet)"
echo.
echo [i] Sem interface de VPN ativa o trafego sai pela conexao normal.
:fim
echo.
pause
