:: ============================================================
:: BATLAB | FolderWatcher.bat | v1.0.0
:: @desc      Monitora uma pasta e avisa quando arquivos mudam
:: @category  automation
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FolderWatcher
echo ============================================
echo  BATLAB - FolderWatcher
echo ============================================
set "ALVO=%~1"
if not defined ALVO set "ALVO=%CD%"
if not exist "%ALVO%" (echo Pasta nao encontrada: %ALVO% & goto :fim)
set "T1=%TEMP%\batlab_watch_a.txt"
set "T2=%TEMP%\batlab_watch_b.txt"
dir /b /a-d "%ALVO%" > "%T1%" 2>nul
echo Monitorando: %ALVO%
echo Uma checagem a cada 5 segundos. Ctrl+C para parar.
:loop
timeout /t 5 /nobreak >nul
dir /b /a-d "%ALVO%" > "%T2%" 2>nul
fc "%T1%" "%T2%" >nul
if errorlevel 1 (
    echo [%time%] Mudancas detectadas:
    fc "%T1%" "%T2%" | findstr "[<>]"
    move /y "%T2%" "%T1%" >nul
)
goto :loop
echo.
pause