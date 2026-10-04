:: ============================================================
:: BATLAB | ListeningPorts.bat | v1.0.0
:: @desc      Portas em escuta (netstat -ano -p tcp | findstr LISTENING)
:: @category  diagnostics
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ListeningPorts
echo ============================================
echo  BATLAB - ListeningPorts
echo ============================================
echo Portas TCP em escuta nesta maquina:
echo.
netstat -ano -p tcp | findstr LISTENING
if errorlevel 1 (
    echo [AVISO] Nenhuma porta TCP em escuta foi encontrada.
    goto :fim
)
echo.
echo [OK] 0.0.0.0:PORTA aceita conexoes de qualquer interface.
echo [Dica] Descubra o dono: tasklist /fi "PID eq 1234"
echo [Dica] Conexoes ja abertas: rode OpenConnections.bat
echo Feito.
:fim
echo.
pause