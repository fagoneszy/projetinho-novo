:: ============================================================
:: BATLAB | DualStackTest.bat | v1.0.0
:: @desc      Testa a conectividade IPv4 e IPv6 lado a lado
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
title BATLAB - DualStackTest
echo ============================================
echo  BATLAB - DualStackTest
echo ============================================
echo Este script testa as duas familias de endereco, IPv4 e IPv6.
echo Ajuda a descobrir se a conexao dual stack esta valendo a pena.
echo.
echo Resolucao de tipo A, que e IPv4:
powershell -NoProfile -Command "Resolve-DnsName -Name 'www.microsoft.com' -Type A -ErrorAction SilentlyContinue | Select-Object -First 3 Name,IPAddress | Format-Table -AutoSize"
echo.
echo Resolucao de tipo AAAA, que e IPv6:
powershell -NoProfile -Command "Resolve-DnsName -Name 'www.microsoft.com' -Type AAAA -ErrorAction SilentlyContinue | Select-Object -First 3 Name,IPAddress | Format-Table -AutoSize"
echo.
echo Conectividade das duas familias, True significa que deu certo:
powershell -NoProfile -Command "'IPv4 em 1.1.1.1 : ' + (Test-NetConnection -ComputerName '1.1.1.1' -InformationLevel Quiet); 'IPv6 em ipv6.google.com : ' + (Test-NetConnection -ComputerName 'ipv6.google.com' -InformationLevel Quiet)"
echo.
echo [i] IPv4 True e IPv6 False e comum em redes domesticas sem IPv6.
:fim
echo.
pause
