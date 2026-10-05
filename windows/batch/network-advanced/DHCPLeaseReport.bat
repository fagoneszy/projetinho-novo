:: ============================================================
:: BATLAB | DHCPLeaseReport.bat | v1.0.0
:: @desc      Mostra os leases DHCP e os servidores de cada adaptador
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
title BATLAB - DHCPLeaseReport
echo ============================================
echo  BATLAB - DHCPLeaseReport
echo ============================================
echo Este script lista os servidores DHCP e os leases obtidos.
echo Lease expirado ou ausente aponta falha de comunicacao com o DHCP.
echo.
echo Adaptadores e estado do DHCP:
powershell -NoProfile -Command "Get-NetIPInterface -AddressFamily IPv4 | Format-Table -AutoSize InterfaceAlias,Dhcp,ConnectionState"
echo.
echo Gateway e servidores DNS por adaptador:
powershell -NoProfile -Command "Get-NetIPConfiguration | Format-List InterfaceAlias,IPv4DefaultGateway,DNSServer"
echo.
echo Leases e servidores DHCP informados pelo Windows:
powershell -NoProfile -Command "ipconfig /all | Select-String -Pattern 'Servidor DHCP','Lease','Expira'"
echo.
echo [i] Confira se o lease ainda tem tempo antes de expirar.
:fim
echo.
pause
