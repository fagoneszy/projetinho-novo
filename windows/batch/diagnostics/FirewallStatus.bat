:: ============================================================
:: BATLAB | FirewallStatus.bat | v1.0.0
:: @desc      Estado do firewall por perfil (netsh advfirewall show allprofiles)
:: @category  diagnostics
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FirewallStatus
echo ============================================
echo  BATLAB - FirewallStatus
echo ============================================
echo Estado do firewall por perfil (Domain/Private/Public):
echo.
netsh advfirewall show allprofiles
if errorlevel 1 (
    echo [ERRO] Falha ao consultar o firewall.
    goto :fim
)
echo [OK] Confira a linha "State" de cada perfil (ON = protegido).
echo [Dica] Somente as regras: netsh advfirewall show rule name=all
echo [Dica] Exportar regras: rode FirewallRules.bat
:fim
echo.
pause
