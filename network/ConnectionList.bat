:: ============================================================
:: BATLAB | ConnectionList.bat | v1.0.0
:: @desc      Mostra conexoes TCP ativas e os processos do sistema
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ConnectionList
echo ============================================
echo  BATLAB - ConnectionList
echo ============================================
echo Conexoes ativas (TCP) e processos em execucao...
echo Host: %COMPUTERNAME%
echo.
netstat -ano | findstr /i "TCP"
if errorlevel 1 (echo [!] Nenhuma conexao encontrada. & goto :fim)
echo.
echo ============================================================
echo  Processos em execucao
echo ============================================================
tasklist
echo.
echo [i] Relacione o PID do netstat com a coluna PID do tasklist.
echo Feito.
:fim
echo.
pause