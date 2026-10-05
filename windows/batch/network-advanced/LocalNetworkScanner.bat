:: ============================================================
:: BATLAB | LocalNetworkScanner.bat | v1.0.0
:: @desc      Varre a faixa de enderecos da rede local e lista os ativos
:: @category  network-advanced
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes    none
:: @deletes   none
:: @registry  none
:: @services  none
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      N/A - somente leitura; o scan apenas envia pacotes de ping
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LocalNetworkScanner
echo ============================================
echo  BATLAB - LocalNetworkScanner
echo ============================================
echo Este script varre a faixa local do seu IP e lista quem responde.
echo Ele envia um pacote ICMP para cada endereco de 1 a 254.
echo Nao abre portas, nao altera nada e nao acessa arquivos alheios.
echo.
choice /c SN /m "Varrer a rede local agora? Pode levar ate 1 minuto. (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Procurando dispositivos ativos na rede local...
powershell -NoProfile -Command "$p = New-Object System.Net.NetworkInformation.Ping; $a = Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue | Where-Object { $_.IPAddress -notlike '169.254.*' -and $_.InterfaceAlias -notmatch 'Loopback' } | Select-Object -First 1; if (-not $a) { 'SEM IP LOCAL - conecte-se a uma rede'; exit }; 'Faixa testada: ' + $a.IPAddress + ' pela interface ' + $a.InterfaceAlias; ''; 1..254 | ForEach-Object { $ip = $a.IPAddress.Substring(0, $a.IPAddress.LastIndexOf('.')) + '.' + $_; try { if ($p.Send($ip, 150).Status -eq 'Success') { $ip } } catch { } }"
echo.
echo Tabela ARP com os vizinhos conhecidos:
arp -a
echo.
echo [i] Quem nao responde pode ter firewall bloqueando o ping.
:fim
echo.
pause
