:: ============================================================
:: BATLAB | UserAccounts.bat | v1.0.0
:: @desc      Contas locais (net user)
:: @category  diagnostics
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - UserAccounts
echo ============================================
echo  BATLAB - UserAccounts
echo ============================================
echo Contas locais desta maquina:
echo.
net user
if errorlevel 1 (
    echo [ERRO] Falha ao listar as contas locais.
    goto :fim
)
echo.
echo [OK] Contas acima; conta desativada nao aparece como ativa.
echo [Dica] Detalhes de uma conta: net user NOME
echo [Dica] Criar/remover conta exige Administrador.
echo Feito.
:fim
echo.
pause
