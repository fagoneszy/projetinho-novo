:: ============================================================
:: BATLAB | AutoSystemReport.bat | v1.0.0
:: @desc      Tarefa diaria que salva relatorio de sistema em log
:: @category  automation
:: @admin     yes
:: @risk      medium
:: @undo      schtasks /delete /tn BATLAB_SystemReport /f
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoSystemReport
echo ============================================
echo  BATLAB - AutoSystemReport
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if "%~1"=="" (set /p "HORA=Horario HH:MM: ") else set "HORA=%~1"
if not defined HORA goto :fim
echo(%HORA%| findstr /r "^[0-9][0-9]:[0-9][0-9]$" >nul
if errorlevel 1 (echo Horario invalido. Use HH:MM. & goto :fim)
echo [ATENCAO] Vai criar a tarefa BATLAB_SystemReport diaria as %HORA%.
echo Cada execucao acrescenta systeminfo e ipconfig em:
echo    %TEMP%\batlab_systemreport.txt
choice /c SN /m "Criar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "H=%TEMP%\batlab_sysreport_task.bat"
>"%H%" echo @echo off
>>"%H%" echo echo === Relatorio %%date%% %%time%% === ^>^> "%TEMP%\batlab_systemreport.txt"
>>"%H%" echo systeminfo ^>^> "%TEMP%\batlab_systemreport.txt"
>>"%H%" echo ipconfig /all ^>^> "%TEMP%\batlab_systemreport.txt"
>>"%H%" echo. ^>^> "%TEMP%\batlab_systemreport.txt"
schtasks /create /tn "BATLAB_SystemReport" /tr "\"%H%\"" /sc daily /st %HORA% /f
if errorlevel 1 (echo [ERRO] Nao foi possivel criar a tarefa.) else (echo Tarefa criada. Gerencie com TaskManager.bat)
:fim
echo.
pause