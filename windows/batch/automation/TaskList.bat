:: ============================================================
:: BATLAB | TaskList.bat | v1.0.0
:: @desc      Lista as tarefas agendadas do Windows
:: @category  automation
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TaskList
echo ============================================
echo  BATLAB - TaskList
echo ============================================
echo Tarefas agendadas (aguarde a lista):
echo ----------------------------------------
schtasks /query 2>nul
if errorlevel 1 (echo [ERRO] Nao foi possivel listar as tarefas.)
echo.
pause
