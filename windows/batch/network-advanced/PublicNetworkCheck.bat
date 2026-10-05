:: ============================================================
:: BATLAB | PublicNetworkCheck.bat | v1.0.0
:: @desc      Verifica se algum perfil de rede esta como Publico
:: @category  network-advanced
:: @platform windows
:: @admin     no
:: @risk      low
:: @writes    none
:: @deletes   none
:: @registry  read
:: @services  none
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PublicNetworkCheck
echo ============================================
echo  BATLAB - PublicNetworkCheck
echo ============================================
echo Este script verifica se algum perfil esta marcado como Publico.
echo Perfil publico ativa bloqueios de descoberta e firewall restrito.
echo.
echo Perfis de rede e suas categorias:
powershell -NoProfile -Command "$p = Get-NetConnectionProfile -ErrorAction SilentlyContinue; if ($p) { $p | Format-Table -AutoSize Name,InterfaceAlias,NetworkCategory,IPv4Connectivity } else { 'Nenhum perfil de rede ativo detectado' }"
echo.
echo Existe perfil ativo em rede Publica:
powershell -NoProfile -Command "$p = @(Get-NetConnectionProfile -ErrorAction SilentlyContinue | Where-Object { $_.NetworkCategory -eq 'Public' }); if ($p.Count -gt 0) { 'ATENCAO: ' + $p.Count + ' perfil em rede Publica' } else { 'Nenhum perfil ativo em rede Publica' }"
echo.
echo Estado do firewall por perfil:
powershell -NoProfile -Command "Get-NetFirewallProfile | Format-Table -AutoSize Name,Enabled,DefaultInboundAction"
echo.
echo [i] Rede publica e a escolha segura para Wi-Fi de lugares publicos.
:fim
echo.
pause
