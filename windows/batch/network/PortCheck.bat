:: ============================================================
:: BATLAB | PortCheck.bat | v1.0.0
:: @desc      Testa se uma porta TCP esta aberta em um host
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PortCheck
echo ============================================
echo  BATLAB - PortCheck
echo ============================================
set "H=%~1"
set "P=%~2"
if not defined H set /p "H=Host alvo (ex.: google.com): "
if not defined P set /p "P=Porta (ex.: 443): "
if not defined H (echo [ERRO] Nenhum host informado. & goto :fim)
if not defined P (echo [ERRO] Nenhuma porta informada. & goto :fim)
echo Testando conexao em %H% na porta %P%...
echo Aguarde, pode levar alguns segundos.
echo.
powershell -NoProfile -Command "if (Test-NetConnection -ComputerName '%H%' -Port %P% -InformationLevel Quiet -WarningAction SilentlyContinue) { exit 0 } else { exit 1 }"
if errorlevel 1 (echo [X] Porta %P% FECHADA ou bloqueada em %H%. & goto :fim)
echo.
echo [OK] Porta %P% ABERTA em %H%.
echo Feito.
:fim
echo.
pause
