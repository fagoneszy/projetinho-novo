:: ============================================================
:: BATLAB | TaskManager.bat | v1.0.0
:: @desc      Hub para listar, ativar, desativar e excluir tarefas
:: @category  automation
:: @admin     yes
:: @risk      medium
:: @undo      schtasks /delete /f para excluir
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TaskManager
echo ============================================
echo  BATLAB - TaskManager
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
:menu
echo.
echo   1. Listar tarefas do BATLAB
echo   2. Ativar tarefa
echo   3. Desativar tarefa
echo   4. Excluir tarefa
echo   0. Sair
set /p "OP=Opcao: "
if "%OP%"=="1" (call :lista & goto :menu)
if "%OP%"=="2" (call :ativa & goto :menu)
if "%OP%"=="3" (call :desativa & goto :menu)
if "%OP%"=="4" (call :exclui & goto :menu)
if "%OP%"=="0" goto :fim
echo Opcao invalida.
goto :menu
:lista
echo --- Tarefas BATLAB ---
schtasks /query /fo csv 2>nul | findstr /i "batlab"
exit /b 0
:ativa
set /p "TN=Nome da tarefa: "
if not defined TN exit /b 0
schtasks /change /tn "%TN%" /enable
exit /b 0
:desativa
set /p "TN=Nome da tarefa: "
if not defined TN exit /b 0
schtasks /change /tn "%TN%" /disable
exit /b 0
:exclui
set /p "TN=Nome da tarefa: "
if not defined TN exit /b 0
schtasks /query /tn "%TN%" >nul 2>&1
if errorlevel 1 (echo Tarefa nao encontrada: %TN% & exit /b 0)
echo [ATENCAO] Vai excluir a tarefa: %TN%
choice /c SN /m "Excluir? (S/N)"
if errorlevel 2 (echo Cancelado. & exit /b 0)
schtasks /delete /tn "%TN%" /f
echo Excluida.
exit /b 0
:fim
echo.
pause