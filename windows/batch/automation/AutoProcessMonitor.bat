:: ============================================================
:: BATLAB | AutoProcessMonitor.bat | v1.0.0
:: @desc      Monitora se um processo esta aberto e avisa na mudanca
:: @category  automation
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoProcessMonitor
echo ============================================
echo  BATLAB - AutoProcessMonitor
echo ============================================
setlocal EnableDelayedExpansion
set "PROC=%~1"
if not defined PROC set /p "PROC=Nome do processo (ex.: chrome.exe): "
if not defined PROC (echo Nenhum processo informado. & goto :fim)
set "SEG=10"
if not "%~2"=="" set "SEG=%~2"
echo(%SEG%| findstr /r "^[1-9][0-9][0-9]?[0-9]?$" >nul
if errorlevel 1 (echo Intervalo invalido: %SEG%. Use 1 a 9999 segundos. & goto :fim)
echo Monitorando %PROC% a cada %SEG%s. Ctrl+C para parar.
set "ANT=INDEFINIDO"
:loop
tasklist /fi "imagename eq %PROC%" 2>nul | findstr /i "%PROC%" >nul
if errorlevel 1 (set "ST=FECHADO") else (set "ST=ABERTO")
if not "!ST!"=="!ANT!" (
    echo [%time%] %PROC%: !ST!
    set "ANT=!ST!"
)
timeout /t %SEG% /nobreak >nul
goto :loop
:fim
echo.
pause