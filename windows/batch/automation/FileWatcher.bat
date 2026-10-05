:: ============================================================
:: BATLAB | FileWatcher.bat | v1.0.0
:: @desc      Monitora um arquivo e avisa quando ele muda
:: @category  automation
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FileWatcher
echo ============================================
echo  BATLAB - FileWatcher
echo ============================================
setlocal EnableDelayedExpansion
set "ALVO=%~1"
if not defined ALVO (echo Uso: FileWatcher.bat caminho\do\arquivo & goto :fim)
if not exist "%ALVO%" (echo Arquivo nao encontrado: %ALVO% & goto :fim)
set "ANT="
echo Monitorando: %ALVO%
echo Checagem a cada 3 segundos. Ctrl+C para parar.
:loop
for %%A in ("%ALVO%") do set "NOW=%%~zA bytes - %%~tA"
if not defined ANT set "ANT=!NOW!"
if not "!ANT!"=="!NOW!" (
    echo [%time%] O arquivo mudou:
    echo    !NOW!
    set "ANT=!NOW!"
)
timeout /t 3 /nobreak >nul
goto :loop
:fim
echo.
pause
