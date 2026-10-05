:: ============================================================
:: BATLAB | AutoGitCommit.bat | v1.0.0
:: @desc      Commit periodico automatico de um repositorio
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
:: @undo      schtasks /delete /tn BATLAB_GitCommit /f
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoGitCommit
echo ============================================
echo  BATLAB - AutoGitCommit
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if "%~1"=="" (set /p "REPO=Caminho do repositorio git: ") else set "REPO=%~1"
if "%~2"=="" (set /p "INTER=Intervalo em minutos (1 a 999): ") else set "INTER=%~2"
if not defined REPO goto :fim
if not defined INTER goto :fim
if not exist "%REPO%\.git" (echo Nao parece um repositorio git: %REPO% & goto :fim)
echo(%INTER%| findstr /r "^[1-9][0-9][0-9]?[0-9]?$" >nul
if errorlevel 1 (echo Intervalo invalido: %INTER%. Use 1 a 999. & goto :fim)
echo [ATENCAO] Vai criar a tarefa BATLAB_GitCommit a cada %INTER% min:
echo    cd %REPO% ^&^& git add -A ^&^& git commit
echo Obs: sem mudancas o git commit falha (sem dano).
choice /c SN /m "Criar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "H=%TEMP%\batlab_gitcommit_task.bat"
>"%H%" echo @echo off
>>"%H%" echo cd /d "%REPO%"
>>"%H%" echo git add -A
>>"%H%" echo git commit -m "commit periodico %%date%% %%time%%"
>>"%H%" echo echo [%%date%% %%time%%] git commit ok ^>^> "%TEMP%\batlab_git.log"
schtasks /create /tn "BATLAB_GitCommit" /tr "\"%H%\"" /sc minute /mo %INTER% /f
if errorlevel 1 (echo [ERRO] Nao foi possivel criar a tarefa.) else (echo Tarefa criada. Gerencie com TaskManager.bat)
:fim
echo.
pause
