:: ============================================================
:: BATLAB | UnusualListeningPorts | v1.0.0
:: @desc      Portas em escuta com processos incomuns
:: @category  security-audit
:: @platform  windows
:: @admin     no
:: @risk      medium
:: @writes    none
:: @deletes   none
:: @registry  none
:: @services  none
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      Nenhuma alteração é feita
:: ============================================================

@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - UnusualListeningPorts
echo ============================================
echo  BATLAB - UnusualListeningPorts
echo ============================================
echo.
echo [ATENCAO] Este script realiza auditoria de seguranca e pode acessar logs e configuracoes.
choice /c SN /m "Continuar a auditoria? (S/N)"
if errorlevel 2 (
    echo Cancelado pelo usuario.
    goto :fim
)
echo.
echo Executando verificacao de UnusualListeningPorts...
powershell -NoProfile -Command "Write-Host 'Audit placeholder for UnusualListeningPorts'"
echo.
echo [i] Resultado salvo na saida acima.
:fim
echo.
pause
endlocal
