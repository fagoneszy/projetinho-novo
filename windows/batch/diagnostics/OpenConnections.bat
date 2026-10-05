:: ============================================================
:: BATLAB | OpenConnections.bat | v1.0.0
:: @desc      Conexoes abertas (netstat -ano)
:: @category  diagnostics
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenConnections
echo ============================================
echo  BATLAB - OpenConnections
echo ============================================
echo Conexoes de rede abertas (TCP/UDP) e o PID dono:
echo.
netstat -ano
if errorlevel 1 (
    echo [ERRO] Falha ao executar netstat.
    goto :fim
)
echo.
echo [OK] A ultima coluna de cada linha e o PID do processo.
echo [Dica] Nome do processo: tasklist /fi "PID eq 1234"
echo [Dica] Sockets em escuta: rode ListeningPorts.bat
echo Feito.
:fim
echo.
pause