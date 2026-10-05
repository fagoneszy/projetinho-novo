:: ============================================================
:: BATLAB | NetworkDiagnostics.bat | v1.0.0
:: @desc      Menu de diagnostico de rede: ping, DNS, IP e adaptadores
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NetworkDiagnostics
echo ============================================
echo  BATLAB - NetworkDiagnostics
echo ============================================
echo Selecione um diagnostico de rede:
echo   [1] Ping em 8.8.8.8
echo   [2] Consulta DNS de google.com
echo   [3] Informacoes de IP (ipconfig)
echo   [4] Lista de adaptadores de rede
choice /c 1234 /m "Opcao"
if errorlevel 4 goto op4
if errorlevel 3 goto op3
if errorlevel 2 goto op2
goto op1

:op1
echo === Ping 8.8.8.8 ===
ping -n 4 8.8.8.8
if errorlevel 1 echo [!] Host 8.8.8.8 nao respondeu.
goto :fim
:op2
echo === Consulta DNS google.com ===
nslookup google.com
if errorlevel 1 echo [!] Consulta DNS falhou.
goto :fim
:op3
echo === Informacoes de IP ===
ipconfig
if errorlevel 1 echo [!] ipconfig retornou erro.
goto :fim
:op4
echo === Adaptadores de rede ===
netsh interface show interface
if errorlevel 1 echo [!] Falha ao listar adaptadores.
goto :fim
:fim
echo.
pause