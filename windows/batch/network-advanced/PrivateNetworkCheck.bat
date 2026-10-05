:: ============================================================
:: BATLAB | PrivateNetworkCheck.bat | v1.0.0
:: @desc      Verifica se o perfil de rede atual esta como Privado
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
title BATLAB - PrivateNetworkCheck
echo ============================================
echo  BATLAB - PrivateNetworkCheck
echo ============================================
echo Este script informa se o perfil de rede atual esta como Privado.
echo Perfil privado permite descobrir impressoras e outros dispositivos.
echo.
echo Perfil de rede em uso, com detalhes de conectividade:
powershell -NoProfile -Command "$p = Get-NetConnectionProfile -ErrorAction SilentlyContinue; if ($p) { $p | Format-Table -AutoSize Name,InterfaceAlias,NetworkCategory,IPv4Connectivity,IPv6Connectivity } else { 'Nenhum perfil de rede ativo detectado' }"
echo.
echo Situacao de cada perfil ativo:
powershell -NoProfile -Command "$p = Get-NetConnectionProfile -ErrorAction SilentlyContinue; if ($p) { $p | ForEach-Object { $_.InterfaceAlias + ' - categoria ' + $_.NetworkCategory } } else { 'Sem perfil ativo para avaliar' }"
echo.
echo Para marcar como privado, comando apenas exibido e nao executado:
echo   Set-NetConnectionProfile -InterfaceIndex 12 -NetworkCategory Private
echo.
echo [i] Em Wi-Fi de hotel ou cafeteria, mantenha a categoria Publica.
:fim
echo.
pause
