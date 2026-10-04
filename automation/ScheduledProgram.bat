:: ============================================================
:: BATLAB | ScheduledProgram.bat | v1.0.0
:: @desc      Agenda qualquer programa para rodar todo dia
:: @category  automation
:: @admin     yes
:: @risk      medium
:: @undo      schtasks /delete /tn BATLAB_Programa /f
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ScheduledProgram
echo ============================================
echo  BATLAB - ScheduledProgram
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if "%~1"=="" (set /p "PROG=Caminho do programa (ex.: C:\app\meu.exe): ") else set "PROG=%~1"
if "%~2"=="" (set /p "HORA=Horario HH:MM: ") else set "HORA=%~2"
if not defined PROG goto :fim
if not defined HORA goto :fim
echo(%HORA%| findstr /r "^[0-9][0-9]:[0-9][0-9]$" >nul
if errorlevel 1 (echo Horario invalido. Use HH:MM. & goto :fim)
echo [ATENCAO] Vai agendar diariamente as %HORA%:
echo    %PROG%
choice /c SN /m "Agendar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "H=%TEMP%\batlab_programa_task.bat"
>"%H%" echo @echo off
>>"%H%" echo start "" "%PROG%"
schtasks /create /tn "BATLAB_Programa" /tr "\"%H%\"" /sc daily /st %HORA% /f
if errorlevel 1 (echo [ERRO] Nao foi possivel criar a tarefa.) else (echo Tarefa criada. Gerencie com TaskManager.bat)
:fim
echo.
pause