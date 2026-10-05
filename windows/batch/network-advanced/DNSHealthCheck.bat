:: ============================================================
:: BATLAB | DNSHealthCheck.bat | v1.0.0
:: @desc      Verifica a saude do servico e dos servidores DNS do Windows
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
title BATLAB - DNSHealthCheck
echo ============================================
echo  BATLAB - DNSHealthCheck
echo ============================================
echo Este script confere os servidores DNS e testa a resolucao de nomes.
echo.
echo Servidores DNS configurados:
powershell -NoProfile -Command "Get-DnsClientServerAddress -AddressFamily IPv4 | Format-Table -AutoSize InterfaceAlias,ServerAddresses"
echo.
echo Servico de DNS do Windows:
powershell -NoProfile -Command "Get-Service -Name Dnscache | Format-Table -AutoSize Name,Status,StartType"
echo.
echo Teste de resolucao de um nome publico:
powershell -NoProfile -Command "if (Resolve-DnsName -Name 'www.microsoft.com' -ErrorAction SilentlyContinue) { 'RESOLUCAO OK' } else { 'FALHA AO RESOLVER - revise os servidores DNS' }"
echo.
echo Teste de um nome inexistente, que deve falhar:
powershell -NoProfile -Command "if (Resolve-DnsName -Name 'dominio-inexistente-batlab.invalid' -ErrorAction SilentlyContinue) { 'RESPOSTA INESPERADA' } else { 'FALHOU COMO ESPERADO' }"
echo.
echo [i] Firewall ou VPN podem bloquear o DNS; compare tambem com 1.1.1.1.
:fim
echo.
pause
