:: ============================================================
:: BATLAB | LoggedUsers.bat | v1.0.0
:: @desc      Usuarios logados (query user)
:: @category  diagnostics
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LoggedUsers
echo ============================================
echo  BATLAB - LoggedUsers
echo ============================================
echo Usuarios com sessao ativa nesta maquina:
echo.
query user
if errorlevel 1 (
    echo [ERRO] Falha ao consultar as sessoes (query user).
    goto :fim
)
echo.
echo [OK] SESSIONNAME console = local; rdp-tcp# = acesso remoto.
echo [Dica] Sessoes incluindo desconectadas: rode ActiveSessions.bat
echo Feito.
:fim
echo.
pause
