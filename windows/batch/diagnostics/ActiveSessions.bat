:: ============================================================
:: BATLAB | ActiveSessions.bat | v1.0.0
:: @desc      Sessoes ativas (qwinsta)
:: @category  diagnostics
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ActiveSessions
echo ============================================
echo  BATLAB - ActiveSessions
echo ============================================
echo Sessoes registradas no servidor de terminal:
echo.
qwinsta
if errorlevel 1 (
    echo [ERRO] Falha ao executar qwinsta.
    goto :fim
)
echo.
echo [OK] Active = em uso; Disc = desconectada (ainda ocupa memoria).
echo [Dica] Encerrar sessao: rwinsta ID (requer Administrador)
echo Feito.
:fim
echo.
pause