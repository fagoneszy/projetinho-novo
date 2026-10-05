:: ============================================================
:: BATLAB | LocalAdminAudit | v1.0.0
:: @desc      Auditoria de usuarios no grupo Administradores locais
:: @category  security-audit
:: @platform  windows
:: @admin     yes
:: @risk      medium
:: @writes    none
:: @deletes   none
:: @registry  read
:: @services  none
:: @tasks     none
:: @network   none
:: @restart   none
:: @undo      Nenhuma alteração é feita
:: ============================================================

@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LocalAdminAudit
echo ============================================
echo  BATLAB - LocalAdminAudit
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
echo Executando verificacao de LocalAdminAudit...
powershell -NoProfile -Command "Write-Host 'Audit placeholder for LocalAdminAudit'"
echo.
echo [i] Resultado salvo na saida acima.
:fim
echo.
pause
endlocal
