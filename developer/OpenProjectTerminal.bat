:: ============================================================
:: BATLAB | OpenProjectTerminal.bat | v1.0.0
:: @desc      Abre um terminal na pasta do projeto com git status
:: @category  developer
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenProjectTerminal
echo ============================================
echo  BATLAB - OpenProjectTerminal
echo ============================================
set "P=%~1"
if not defined P set "P=%CD%"
echo Abrindo terminal do projeto em: %P%
if not exist "%P%" (echo [ERRO] Pasta nao existe: %P% & goto :fim)
where git >nul 2>&1
if errorlevel 1 goto semgit
pushd "%P%"
start "" cmd /k "git status"
popd
echo [OK] Terminal com git status aberto em %P%
goto :fim
:semgit
pushd "%P%"
start "" cmd /k
popd
echo [OK] Terminal aberto em %P% (git nao encontrado no PATH)
:fim
echo.
pause