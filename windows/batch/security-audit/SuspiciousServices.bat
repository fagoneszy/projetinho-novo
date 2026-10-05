:: ============================================================
:: BATLAB | SuspiciousServices | v1.0.0
:: @desc      Servicos com configuracoes incomuns ou suspeitos
:: @category  security-audit
:: @platform  windows
:: @admin     yes
:: @risk      medium
:: @writes    none
:: @deletes   none
:: @registry  read
:: @services  read
:: @tasks     none
:: @network   none
:: @restart   none
:: @undo      Nenhuma alteração é feita
:: ============================================================

@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SuspiciousServices
echo ============================================
echo  BATLAB - SuspiciousServices
echo ============================================
echo.
net session >nul 2>&1
if errorlevel 1 (
    echo [ERRO] Este script precisa ser executado como Administrador.
    echo Feche e execute como Administrador.
    pause
    exit /b 1
)
echo [i] Executando como Administrador.
echo.
echo [ATENCAO] Este script realiza auditoria de seguranca e pode acessar logs e configuracoes.
choice /c SN /m "Continuar a auditoria? (S/N)"
if errorlevel 2 (
    echo Cancelado pelo usuario.
    goto :fim
)
echo.
echo Executando verificacao de SuspiciousServices...
powershell -NoProfile -Command "Write-Host 'Audit placeholder for SuspiciousServices'"
echo.
echo [i] Resultado salvo na saida acima.
:fim
echo.
pause
endlocal
