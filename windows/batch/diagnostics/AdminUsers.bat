:: ============================================================
:: BATLAB | AdminUsers.bat | v1.0.0
:: @desc      Membros do grupo administradores (net localgroup administrators)
:: @category  diagnostics
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AdminUsers
echo ============================================
echo  BATLAB - AdminUsers
echo ============================================
echo Membros do grupo de administradores locais:
echo.
net localgroup administrators
if errorlevel 1 (
    echo [ERRO] Falha ao consultar o grupo administradores.
    goto :fim
)
echo.
echo [!] Qualquer conta da lista pode alterar a maquina inteira.
echo [!] Se aparecer conta desconhecida, investigue: net user NOME
echo [Dica] Em ingles o grupo e "Administrators".
echo Feito.
:fim
echo.
pause