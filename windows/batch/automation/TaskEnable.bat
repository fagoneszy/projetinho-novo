:: ============================================================
:: BATLAB | TaskEnable.bat | v1.0.0
:: @desc      Ativa uma tarefa agendada
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
:: @undo      schtasks /change /disable para desativar
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TaskEnable
echo ============================================
echo  BATLAB - TaskEnable
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo Tarefas BATLAB:
schtasks /query /fo csv 2>nul | findstr /i "batlab"
echo.
set /p "TN=Nome da tarefa a ativar: "
if not defined TN goto :fim
schtasks /query /tn "%TN%" >nul 2>&1
if errorlevel 1 (echo Tarefa nao encontrada: %TN% & goto :fim)
schtasks /change /tn "%TN%" /enable
if errorlevel 1 (echo [ERRO] Falha ao ativar.) else (echo Tarefa ativada.)
:fim
echo.
pause
