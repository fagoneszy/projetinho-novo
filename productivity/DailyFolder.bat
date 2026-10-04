:: ============================================================
:: BATLAB | DailyFolder.bat | v1.0.0
:: @desc      Cria a pasta do dia (AAAA-MM-DD) e abre
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta criada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DailyFolder
echo ============================================
echo  BATLAB - DailyFolder
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
if not exist "%D%" mkdir "%D%"
echo Pasta: %CD%\%D%
start "" explorer "%CD%\%D%"
echo.
pause