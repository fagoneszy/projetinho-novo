:: ============================================================
:: BATLAB | GitBranchCreator.bat | v1.0.0
:: @desc      Cria e entra em uma nova branch com git checkout -b
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GitBranchCreator
echo ============================================
echo  BATLAB - GitBranchCreator
echo ============================================
set "BR=%~1"
if not defined BR set /p "BR=Nome da nova branch: "
if not defined BR (echo [ERRO] Nenhum nome informado. & goto :fim)
echo Criando e entrando na branch: %BR%
where git >nul 2>&1
if errorlevel 1 (echo [ERRO] git nao encontrado no PATH. & goto :fim)
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo [ERRO] Esta pasta nao e um repositorio Git. & goto :fim)
git checkout -b "%BR%"
if errorlevel 1 (echo [ERRO] Falha ao criar a branch - ela ja existe. & goto :fim)
echo.
echo [OK] Branch %BR% criada e ativada.
echo [i] Voltar: git checkout - ^<branch anterior^>
echo Feito.
:fim
echo.
pause
