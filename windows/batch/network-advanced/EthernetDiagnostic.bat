:: ============================================================
:: BATLAB | EthernetDiagnostic.bat | v1.0.0
:: @desc      Diagnostica a conexao de rede com cabo e o estado do link
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
title BATLAB - EthernetDiagnostic
echo ============================================
echo  BATLAB - EthernetDiagnostic
echo ============================================
echo Este script mostra o estado da conexao de rede com cabo.
echo Erros de pacote e descarte indicam problema de cabo ou de porta.
echo.
echo Adaptadores, estado e velocidade do link:
powershell -NoProfile -Command "Get-NetAdapter -Physical | Format-Table -AutoSize Name,Status,MediaType,LinkSpeed"
echo.
echo Estatisticas de erro e descarte por adaptador:
powershell -NoProfile -Command "Get-NetAdapterStatistics | Format-Table -AutoSize Name,ReceivedPacketErrors,ReceivedDiscardedPackets,OutboundPacketErrors,OutboundDiscardedPackets"
echo.
echo Driver de cada adaptador fisico:
powershell -NoProfile -Command "Get-NetAdapter -Physical | Format-Table -AutoSize Name,DriverDescription,DriverVersion,DriverDate"
echo.
echo [i] Cabo defeituoso derruba a velocidade para 100 Mbps sem erro.
:fim
echo.
pause
