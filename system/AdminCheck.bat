:: ============================================================
:: BATLAB | AdminCheck.bat | v1.0.0
:: @desc      Verifica se o script esta rodando como administrador
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AdminCheck
echo ============================================
echo  BATLAB - AdminCheck
echo ============================================
echo Verificando os privilegios do processo atual...
echo [INFO] Teste rapido: net session (funciona so para administradores).
echo [INFO] Nada sera alterado - apenas leitura.
echo.
net session >nul 2>&1
if errorlevel 1 (echo [RESULTADO] NAO esta rodando como Administrador.) else (echo [RESULTADO] Esta rodando como Administrador.)
echo.
echo Identidade detalhada:
powershell -NoProfile -Command "$p=New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent()); Write-Host ('Usuario:  ' + $p.Identity.Name); Write-Host ('Elevado:  ' + $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))"
echo.
if errorlevel 1 (echo [ERRO] Falha ao consultar a identidade.) else (echo Feito. Verificacao concluida.)
:fim
echo.
pause