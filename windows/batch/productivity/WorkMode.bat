:: ============================================================
:: BATLAB | WorkMode.bat | v1.0.0
:: @desc      Configura o ambiente de trabalho (pasta + aplicativos)
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WorkMode
echo ============================================
echo  BATLAB - WorkMode
echo ============================================
set "PASTA=%USERPROFILE%\Documents\Trabalho"
if not exist "%PASTA%" mkdir "%PASTA%"
start "" explorer "%PASTA%"
for %%A in (notepad calc) do start "" %%A
echo Ambiente de trabalho pronto: %PASTA%
echo.
pause