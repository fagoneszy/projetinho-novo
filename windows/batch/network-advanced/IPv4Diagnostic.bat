:: ============================================================
:: BATLAB | IPv4Diagnostic.bat | v1.0.0
:: @desc      Diagnostica a configuracao IPv4 dos adaptadores
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
title BATLAB - IPv4Diagnostic
echo ============================================
echo  BATLAB - IPv4Diagnostic
echo ============================================
echo Este script mostra a configuracao IPv4 de cada adaptador.
echo Prefixo de origem igual a DHCP significa endereco obtido da rede.
echo.
echo Enderecos IPv4 e origem do prefixo:
powershell -NoProfile -Command "Get-NetIPAddress -AddressFamily IPv4 | Format-Table -AutoSize InterfaceAlias,IPAddress,PrefixLength,PrefixOrigin,SuffixOrigin"
echo.
echo Gateway e DNS por adaptador:
powershell -NoProfile -Command "Get-NetIPConfiguration -AddressFamily IPv4 | Format-List InterfaceAlias,IPv4Address,IPv4DefaultGateway,DNSServer"
echo.
echo Servidores DNS em uso por adaptador:
powershell -NoProfile -Command "Get-DnsClientServerAddress -AddressFamily IPv4 | Format-Table -AutoSize InterfaceAlias,ServerAddresses"
echo.
echo [i] Endereco comecando em 169.254 indica DHCP sem resposta do servidor.
:fim
echo.
pause
