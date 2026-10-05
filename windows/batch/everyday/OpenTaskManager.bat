:: ============================================================
:: BATLAB | OpenTaskManager.bat | v1.0.0
:: @desc      Abre o Gerenciador de Tarefas (taskmgr)
:: @category  everyday
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenTaskManager
echo ============================================
echo  BATLAB - OpenTaskManager
echo ============================================
echo Abrindo o Gerenciador de Tarefas...
if not exist "%SystemRoot%\System32\taskmgr.exe" (
    echo [ERRO] taskmgr.exe nao encontrado.
    goto :fim
)
start "" taskmgr.exe
if errorlevel 1 (
    echo [ERRO] Falha ao abrir o Gerenciador de Tarefas.
    goto :fim
)
echo [OK] Gerenciador de Tarefas aberto.
echo [Dica] Abas: Processos, Desempenho, Inicializacao.
echo Feito.
:fim
echo.
pause
