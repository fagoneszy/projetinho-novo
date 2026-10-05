:: ============================================================
:: BATLAB | TaskDelete.bat | v1.0.0
:: @desc      Exclui uma tarefa agendada
:: @category  automation
:: @platform windows
:: @admin     yes
:: @risk      high
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks write
:: @network none
:: @restart none
:: @undo      Recrie a tarefa via TaskManager.bat ou DailyTaskCreator.bat
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TaskDelete
echo ============================================
echo  BATLAB - TaskDelete
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if /i "%~1"=="/dryrun" (
    echo [DRYRUN] Tarefas que existem agora:
    schtasks /query /fo csv 2>nul | findstr /i "batlab"
    goto :fim
)
echo Tarefas BATLAB:
schtasks /query /fo csv 2>nul | findstr /i "batlab"
echo.
set /p "TN=Nome da tarefa a excluir: "
if not defined TN goto :fim
schtasks /query /tn "%TN%" >nul 2>&1
if errorlevel 1 (echo Tarefa nao encontrada: %TN% & goto :fim)
echo [ATENCAO] Vai EXCLUIR em definitivo a tarefa: %TN%
echo Nada sera executado mais por ela.
choice /c SN /m "Tem certeza? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
choice /c SN /m "Ultima confirmacao - excluir mesmo? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
schtasks /delete /tn "%TN%" /f
if errorlevel 1 (echo [ERRO] Falha ao excluir.) else (echo Tarefa excluida.)
:fim
echo.
pause
