:: ============================================================
:: BATLAB | FirewallRules.bat | v1.0.0
:: @desc      Exporta as regras do firewall (netsh advfirewall export)
:: @category  diagnostics
:: @admin     yes
:: @risk      low
:: @undo      netsh advfirewall import <arquivo exportado>
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FirewallRules
echo ============================================
echo  BATLAB - FirewallRules
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
set "OUTDIR=%TEMP%\BATLAB"
set "OUT=%OUTDIR%\firewall-regras.wfw"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
echo Exportando todas as regras do firewall para:
echo   %OUT%
netsh advfirewall export "%OUT%"
if errorlevel 1 (
    echo [ERRO] Falha na exportacao das regras.
    goto :fim
)
echo [OK] Exportacao concluida.
echo [OK] Restaurar nesta maquina: netsh advfirewall import "%OUT%"
echo [OK] Listar regras em texto:  netsh advfirewall show rule name=all
:fim
echo.
pause