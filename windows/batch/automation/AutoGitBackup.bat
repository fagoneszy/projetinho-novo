:: ============================================================
:: BATLAB | AutoGitBackup.bat | v1.0.0
:: @desc      Tarefa diaria que faz commit e push de um repositorio
:: @category  automation
:: @admin     yes
:: @risk      medium
:: @undo      schtasks /delete /tn BATLAB_GitBackup /f
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoGitBackup
echo ============================================
echo  BATLAB - AutoGitBackup
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if "%~1"=="" (set /p "REPO=Caminho do repositorio git: ") else set "REPO=%~1"
if "%~2"=="" (set /p "HORA=Horario HH:MM: ") else set "HORA=%~2"
if not defined REPO goto :fim
if not defined HORA goto :fim
if not exist "%REPO%\.git" (echo Nao parece um repositorio git: %REPO% & goto :fim)
echo(%HORA%| findstr /r "^[0-9][0-9]:[0-9][0-9]$" >nul
if errorlevel 1 (echo Horario invalido. Use HH:MM. & goto :fim)
echo [ATENCAO] Vai criar a tarefa BATLAB_GitBackup diaria as %HORA%:
echo    cd %REPO% ^&^& git add -A ^&^& git commit ^&^& git push
choice /c SN /m "Criar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "H=%TEMP%\batlab_gitbackup_task.bat"
>"%H%" echo @echo off
>>"%H%" echo cd /d "%REPO%"
>>"%H%" echo git add -A
>>"%H%" echo git commit -m "backup automatico %%date%% %%time%%"
>>"%H%" echo git push
>>"%H%" echo echo [%%date%% %%time%%] git backup ok ^>^> "%TEMP%\batlab_git.log"
schtasks /create /tn "BATLAB_GitBackup" /tr "\"%H%\"" /sc daily /st %HORA% /f
if errorlevel 1 (echo [ERRO] Nao foi possivel criar a tarefa.) else (echo Tarefa criada. Gerencie com TaskManager.bat)
:fim
echo.
pause