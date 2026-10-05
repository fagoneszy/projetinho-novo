:: ============================================================
:: BATLAB | DevEnvironment.bat | v1.0.0
:: @desc      Abre editor, terminal e navegador do projeto atual
:: @category  developer
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DevEnvironment
echo ============================================
echo  BATLAB - DevEnvironment
echo ============================================
set "P=%~1"
if not defined P set "P=%CD%"
echo Abrindo ambiente de dev em: %P%
echo.
echo [1/3] Editor (VS Code)...
where code >nul 2>&1
if errorlevel 1 (echo [!] VS Code nao encontrado no PATH.) else call code "%P%"
echo [2/3] Terminal...
pushd "%P%"
where wt >nul 2>&1
if errorlevel 1 (start "" cmd /k) else start "" wt
popd
echo [3/3] Navegador do projeto...
start "" "https://github.com"
echo.
echo [OK] Ambiente de dev aberto em %P%
echo Feito.
echo.
pause