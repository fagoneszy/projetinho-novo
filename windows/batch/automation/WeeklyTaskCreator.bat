:: ============================================================
:: BATLAB | WeeklyTaskCreator.bat | v1.0.0
:: @desc      Assistente para criar uma tarefa semanal no Agendador
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
:: @undo      schtasks /delete /tn NOME /f
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WeeklyTaskCreator
echo ============================================
echo  BATLAB - WeeklyTaskCreator
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
set /p "TN=Nome da tarefa (letras, numeros, _ e -): "
if not defined TN goto :fim
echo(%TN%| findstr /r "^[A-Za-z0-9_-][A-Za-z0-9_-]*$" >nul
if errorlevel 1 (echo Nome invalido. & goto :fim)
set /p "CMDL=Caminho do comando (ex.: C:\app\meu.exe): "
if not defined CMDL goto :fim
set /p "DIA=Dia (MON,TUE,WED,THU,FRI,SAT,SUN): "
if not defined DIA goto :fim
echo %DIA%| findstr /i "mon tue wed thu fri sat sun" >nul
if errorlevel 1 (echo Dia invalido. Use MON a SUN. & goto :fim)
set /p "HORA=Horario HH:MM: "
if not defined HORA goto :fim
echo(%HORA%| findstr /r "^[0-9][0-9]:[0-9][0-9]$" >nul
if errorlevel 1 (echo Horario invalido. Use HH:MM. & goto :fim)
echo [ATENCAO] Vai criar a tarefa semanal:
echo    Nome: %TN%  |  Dia: %DIA%  |  Hora: %HORA%
echo    Comando: %CMDL%
choice /c SN /m "Criar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "H=%TEMP%\batlab_task_%TN%.bat"
>"%H%" echo @echo off
>>"%H%" echo start "" "%CMDL%"
schtasks /create /tn "%TN%" /tr "\"%H%\"" /sc weekly /d %DIA% /st %HORA% /f
if errorlevel 1 (echo [ERRO] Nao foi possivel criar a tarefa.) else (echo Tarefa criada com sucesso.)
:fim
echo.
pause
