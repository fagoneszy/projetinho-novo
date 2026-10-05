:: ============================================================
:: BATLAB | DHCPDiagnostic.bat | v1.0.0
:: @desc      Diagnostica problemas de DHCP na configuracao dos adaptadores
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
title BATLAB - DHCPDiagnostic
echo ============================================
echo  BATLAB - DHCPDiagnostic
echo ============================================
echo Este script mostra como cada adaptador obtem o endereco IP.
echo Adaptador com Dhcp = Enabled usa servidor DHCP; Disabled usa IP fixo.
echo.
echo Adaptadores e estado do DHCP:
powershell -NoProfile -Command "Get-NetIPInterface -AddressFamily IPv4 | Format-Table -AutoSize InterfaceAlias,Dhcp,ConnectionState"
echo.
echo Configuracao IP atual:
powershell -NoProfile -Command "Get-NetIPConfiguration | Format-List InterfaceAlias,IPv4Address,IPv4DefaultGateway,DNSServer"
echo.
echo Detalhes do lease e dos servidores DHCP:
powershell -NoProfile -Command "ipconfig /all | Select-String -Pattern 'DHCP','Lease','Expira','Servidor DHCP'"
echo.
echo [i] Endereco comecando em 169.254 significa que o DHCP nao respondeu.
:fim
echo.
pause
