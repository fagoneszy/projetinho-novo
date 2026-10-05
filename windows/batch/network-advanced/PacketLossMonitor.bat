:: ============================================================
:: BATLAB | PacketLossMonitor.bat | v1.0.0
:: @desc      Monitora a perda de pacotes em um destino de rede
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
title BATLAB - PacketLossMonitor
echo ============================================
echo  BATLAB - PacketLossMonitor
echo ============================================
echo Este script mede a perda de pacotes de uma conexao.
echo Perda alta trava navegador, video e jogos mesmo com sinal bom.
echo.
set "ALVO=%~1"
if not defined ALVO set "ALVO=8.8.8.8"
set "N=%~2"
if not defined N set "N=20"
echo Alvo: %ALVO%   -   quantidade de pings: %N%
echo.
ping -n %N% -w 1000 %ALVO%
echo.
echo Detalhe das respostas de um teste curto:
powershell -NoProfile -Command "Test-Connection -ComputerName '%ALVO%' -Count 4 -ErrorAction SilentlyContinue | Select-Object Address,Status | Format-Table -AutoSize"
echo.
echo [i] Perda em um so destino pode ser do caminho; compare dois alvos.
:fim
echo.
pause
