:: ============================================================
:: BATLAB | VPNInterfaceDetector.bat | v1.0.0
:: @desc      Detecta interfaces e servicos de VPN instalados
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
title BATLAB - VPNInterfaceDetector
echo ============================================
echo  BATLAB - VPNInterfaceDetector
echo ============================================
echo Este script procura interfaces de VPN instaladas no Windows.
echo Ajuda a saber se a VPN existe e qual nome ela usa no sistema.
echo.
echo Adaptadores de rede, incluindo os ocultos:
powershell -NoProfile -Command "Get-NetAdapter -IncludeHidden | Format-Table -AutoSize Name,InterfaceDescription,Status,MacAddress"
echo.
echo Interfaces que parecem ser de VPN:
powershell -NoProfile -Command "Get-NetAdapter -IncludeHidden | Where-Object { $_.Name -match 'VPN|TAP|Tun|WireGuard|OpenVPN|AnyConnect|GlobalProtect|Fortinet' -or $_.InterfaceDescription -match 'VPN|TAP|Tun|WireGuard|OpenVPN|WAN Miniport' } | Format-Table -AutoSize Name,InterfaceDescription,Status"
echo.
echo Perfis de VPN do proprio Windows:
powershell -NoProfile -Command "$v = Get-VpnConnection -ErrorAction SilentlyContinue; if ($v) { $v | Format-Table -AutoSize Name,ServerAddress,TunnelType,SplitTunneling } else { 'Nenhum perfil de VPN do Windows' }"
echo.
echo [i] Servicos de VPN instalados no computador:
powershell -NoProfile -Command "Get-Service | Where-Object { $_.Name -match 'vpn|tap|wg' -or $_.DisplayName -match 'VPN|OpenVPN|WireGuard|AnyConnect' } | Format-Table -AutoSize Name,Status,StartType"
:fim
echo.
pause
