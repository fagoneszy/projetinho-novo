:: ============================================================
:: BATLAB | NetworkProfileReport.bat | v1.0.0
:: @desc      Relatorio dos perfis de rede guardados pelo Windows
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
title BATLAB - NetworkProfileReport
echo ============================================
echo  BATLAB - NetworkProfileReport
echo ============================================
echo Este script lista os perfis de rede guardados pelo Windows.
echo Cada perfil guarda nome, categoria e data da ultima conexao.
echo.
echo Perfis de rede registrados no sistema:
powershell -NoProfile -Command "Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles' -ErrorAction SilentlyContinue | ForEach-Object { Get-ItemProperty -Path $_.PSPath | Select-Object ProfileName,Category,DateLastConnected,Managed } | Format-Table -AutoSize"
echo.
echo Redes Wi-Fi salvas neste computador:
netsh wlan show profiles
echo.
echo Perfil de rede em uso agora:
powershell -NoProfile -Command "$p = Get-NetConnectionProfile -ErrorAction SilentlyContinue; if ($p) { $p | Format-Table -AutoSize Name,InterfaceAlias,NetworkCategory,IPv4Connectivity } else { 'Nenhum perfil de rede ativo' }"
echo.
echo [i] Categoria Publica bloqueia descoberta de rede e compartilhamento.
:fim
echo.
pause
