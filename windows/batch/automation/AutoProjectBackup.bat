:: ============================================================
:: BATLAB | AutoProjectBackup.bat | v1.0.0
:: @desc      Backup versionado (pasta por data) de um projeto
:: @category  automation
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes user
:: @deletes none
:: @registry none
:: @services none
:: @tasks write
:: @network none
:: @restart none
:: @undo      Apague as pastas de backup em DESTINO
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoProjectBackup
echo ============================================
echo  BATLAB - AutoProjectBackup
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if "%~1"=="" (set /p "SRC=Pasta do projeto: ") else set "SRC=%~1"
if "%~2"=="" (set /p "DEST=Pasta dos backups: ") else set "DEST=%~2"
if "%~3"=="" (set /p "HORA=Horario HH:MM: ") else set "HORA=%~3"
if not defined SRC goto :fim
if not defined DEST goto :fim
if not exist "%SRC%" (echo Pasta nao encontrada: %SRC% & goto :fim)
echo(%HORA%| findstr /r "^[0-9][0-9]:[0-9][0-9]$" >nul
if errorlevel 1 (echo Horario invalido. Use HH:MM. & goto :fim)
echo [ATENCAO] Vai criar a tarefa BATLAB_ProjectBackup diaria as %HORA%.
echo Cada execucao cria em %DEST% uma pasta com data/hora e copia o projeto.
choice /c SN /m "Criar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "H=%TEMP%\batlab_projbackup_task.bat"
>"%H%" echo @echo off
>>"%H%" echo powershell -NoProfile -Command "$d=Get-Date -Format yyyy-MM-dd_HHmm; $dst=Join-Path '%DEST%' $d; New-Item -ItemType Directory -Force -Path $dst | Out-Null; & robocopy '%SRC%' $dst /E /XO /NP /NFL /NDL /R:1 /W:1 | Out-Null"
>>"%H%" echo echo [%%date%% %%time%%] projeto backup ok ^>^> "%TEMP%\batlab_projeto.log"
schtasks /create /tn "BATLAB_ProjectBackup" /tr "\"%H%\"" /sc daily /st %HORA% /f
if errorlevel 1 (echo [ERRO] Nao foi possivel criar a tarefa.) else (echo Tarefa criada. Gerencie com TaskManager.bat)
:fim
echo.
pause
