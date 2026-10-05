:: ============================================================
:: BATLAB | OpenTerminalHere.bat | v1.0.0
:: @desc      Abre um terminal (wt ou cmd) na pasta atual
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenTerminalHere
echo ============================================
echo  BATLAB - OpenTerminalHere
echo ============================================
set "P=%~1"
if not defined P set "P=%CD%"
echo Abrindo terminal em: %P%
if not exist "%P%" (echo [ERRO] Pasta nao existe: %P% & goto :fim)
pushd "%P%"
where wt >nul 2>&1
if errorlevel 1 (start "" cmd /k) else start "" wt
popd
echo.
echo [OK] Terminal aberto em %P%
echo [i] Sem Windows Terminal o cmd e usado como alternativa.
echo Feito.
:fim
echo.
pause
