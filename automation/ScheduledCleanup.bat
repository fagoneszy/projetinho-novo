:: ============================================================
:: BATLAB | ScheduledCleanup.bat | v1.0.0
:: @desc      Cria tarefa agendada semanal de limpeza de temporarios
:: @category  automation
:: @admin     yes
:: @risk      medium
:: @undo      schtasks /delete /tn BATLAB_Cleanup /f
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ScheduledCleanup
echo ============================================
echo  BATLAB - ScheduledCleanup
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if "%~1"=="" (set /p "DIA=Dia (MON,TUE,WED,THU,FRI,SAT,SUN): ") else set "DIA=%~1"
if "%~2"=="" (set /p "HORA=Horario HH:MM: ") else set "HORA=%~2"
if not defined DIA goto :fim
if not defined HORA goto :fim
echo %DIA%| findstr /i "mon tue wed thu fri sat sun" >nul
if errorlevel 1 (echo Dia invalido. Use MON a SUN. & goto :fim)
echo(%HORA%| findstr /r "^[0-9][0-9]:[0-9][0-9]$" >nul
if errorlevel 1 (echo Horario invalido. Use HH:MM. & goto :fim)
echo [ATENCAO] Vai criar a tarefa BATLAB_Cleanup (%DIA% as %HORA%)
echo limpando arquivos com mais de 7 dias em %TEMP%.
choice /c SN /m "Criar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "H=%TEMP%\batlab_cleanup_task.bat"
>"%H%" echo @echo off
>>"%H%" echo powershell -NoProfile -Command "Get-ChildItem $env:TEMP -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | ForEach-Object { Remove-Item -LiteralPath $_.FullName -Force -ErrorAction SilentlyContinue }"
>>"%H%" echo echo [%%date%% %%time%%] cleanup ok ^>^> "%TEMP%\batlab_cleanup.log"
schtasks /create /tn "BATLAB_Cleanup" /tr "\"%H%\"" /sc weekly /d %DIA% /st %HORA% /f
if errorlevel 1 (echo [ERRO] Nao foi possivel criar a tarefa.) else (echo Tarefa criada. Gerencie com TaskManager.bat)
:fim
echo.
pause