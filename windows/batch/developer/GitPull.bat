:: ============================================================
:: BATLAB | GitPull.bat | v1.0.0
:: @desc      Atualiza o repositorio com git pull e reporta erro claro
:: @category  developer
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GitPull
echo ============================================
echo  BATLAB - GitPull
echo ============================================
echo Atualizando o repositorio (git pull) em %CD%...
where git >nul 2>&1
if errorlevel 1 (echo [ERRO] git nao encontrado no PATH. & goto :fim)
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo [ERRO] Esta pasta nao e um repositorio Git. & goto :fim)
echo.
git pull
if errorlevel 1 (echo [ERRO] git pull falhou. Conflito ou sem remoto. & goto :fim)
echo.
echo [OK] Pull concluido.
echo Feito.
:fim
echo.
pause