:: ============================================================
:: BATLAB | ScheduledBackup.bat | v1.0.0
:: @desc      Cria tarefa agendada diaria de backup (schtasks)
:: @category  automation
:: @admin     yes
:: @risk      medium
:: @undo      schtasks /delete /tn BATLAB_Backup /f
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ScheduledBackup
echo ============================================
echo  BATLAB - ScheduledBackup
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if "%~1"=="" (set /p "ORIG=Pasta de origem: ") else set "ORIG=%~1"
if "%~2"=="" (set /p "DEST=Pasta de destino: ") else set "DEST=%~2"
if "%~3"=="" (set /p "HORA=Horario HH:MM (ex.: 18:00): ") else set "HORA=%~3"
if not defined ORIG goto :fim
if not defined DEST goto :fim
echo(%HORA%| findstr /r "^[0-9][0-9]:[0-9][0-9]$" >nul
if errorlevel 1 (echo Horario invalido. Use o formato HH:MM. & goto :fim)
echo [ATENCAO] Vai criar a tarefa BATLAB_Backup diaria as %HORA%:
echo    %ORIG%  ->  %DEST%
choice /c SN /m "Criar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "H=%TEMP%\batlab_backup_task.bat"
>"%H%" echo @echo off
>>"%H%" echo robocopy "%ORIG%" "%DEST%" /E /XO /NP /NFL /NDL /R:1 /W:1
>>"%H%" echo echo [%%date%% %%time%%] backup ok ^>^> "%TEMP%\batlab_backup.log"
schtasks /create /tn "BATLAB_Backup" /tr "\"%H%\"" /sc daily /st %HORA% /f
if errorlevel 1 (echo [ERRO] Nao foi possivel criar a tarefa.) else (echo Tarefa criada. Gerencie com TaskManager.bat)
:fim
echo.
pause