:: ============================================================
:: BATLAB | WindowsQuickTools.bat | v1.0.0
:: @desc      Menu estilo Win+X: Tarefas, Dispositivos, Disco, Terminal, Configuracoes
:: @category  everyday
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre ferramentas
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WindowsQuickTools
echo ============================================
echo  BATLAB - WindowsQuickTools
echo ============================================
echo Escolha a ferramenta:
echo   [1] Gerenciador de Tarefas
echo   [2] Gerenciador de Dispositivos
echo   [3] Gerenciamento de Disco
echo   [4] Terminal (PowerShell)
echo   [5] Configuracoes do Windows
choice /c 12345 /m "Opcao"
if errorlevel 6 (echo [ERRO] Entrada invalida. & goto :fim)
if errorlevel 5 goto :op5
if errorlevel 4 goto :op4
if errorlevel 3 goto :op3
if errorlevel 2 goto :op2
if errorlevel 1 goto :op1
goto :fim
:op1
start "" taskmgr.exe
echo [OK] Gerenciador de Tarefas aberto.
goto :fim
:op2
start "" devmgmt.msc
echo [OK] Gerenciador de Dispositivos aberto.
goto :fim
:op3
start "" diskmgmt.msc
echo [OK] Gerenciamento de Disco aberto.
goto :fim
:op4
where wt.exe >nul 2>&1
if errorlevel 1 (start "" powershell.exe) else (start "" wt.exe)
echo [OK] Terminal aberto.
goto :fim
:op5
start "" ms-settings:
echo [OK] Configuracoes abertas.
:fim
echo.
pause
