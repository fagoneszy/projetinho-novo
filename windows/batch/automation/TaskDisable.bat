:: ============================================================
:: BATLAB | TaskDisable.bat | v1.0.0
:: @desc      Desativa uma tarefa agendada
:: @category  automation
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks write
:: @network none
:: @restart none
:: @undo      schtasks /change /enable para reativar
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TaskDisable
echo ============================================
echo  BATLAB - TaskDisable
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo Tarefas BATLAB:
schtasks /query /fo csv 2>nul | findstr /i "batlab"
echo.
set /p "TN=Nome da tarefa a desativar: "
if not defined TN goto :fim
schtasks /query /tn "%TN%" >nul 2>&1
if errorlevel 1 (echo Tarefa nao encontrada: %TN% & goto :fim)
schtasks /change /tn "%TN%" /disable
if errorlevel 1 (echo [ERRO] Falha ao desativar.) else (echo Tarefa desativada.)
:fim
echo.
pause
