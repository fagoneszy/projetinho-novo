:: ============================================================
:: BATLAB | TimestampNote.bat | v1.0.0
:: @desc      Cria uma nota com data e hora no nome do arquivo
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TimestampNote
echo ============================================
echo  BATLAB - TimestampNote
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "TS=%%i"
set "ARQ=%USERPROFILE%\Desktop\Nota_%TS%.txt"
echo Criando: %ARQ%
start "" notepad "%ARQ%"
echo.
pause