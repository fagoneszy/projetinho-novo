:: ============================================================
:: BATLAB | GitStatus.bat | v1.0.0
:: @desc      Mostra o status e o resumo de diferencas do repositorio
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GitStatus
echo ============================================
echo  BATLAB - GitStatus
echo ============================================
echo Verificando o status do repositorio em %CD%...
where git >nul 2>&1
if errorlevel 1 (echo [ERRO] git nao encontrado no PATH. & goto :fim)
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo [ERRO] Esta pasta nao e um repositorio Git. & goto :fim)
echo.
git status -sb
if errorlevel 1 (echo [!] git status retornou erro. & goto :fim)
echo.
git diff --stat
echo.
echo [i] Branch atual e alteracoes resumidas acima.
echo Feito.
:fim
echo.
pause
