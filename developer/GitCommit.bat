:: ============================================================
:: BATLAB | GitCommit.bat | v1.0.0
:: @desc      Pede uma mensagem e cria um commit no repositorio
:: @category  developer
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GitCommit
echo ============================================
echo  BATLAB - GitCommit
echo ============================================
echo Preparando um novo commit em %CD%...
where git >nul 2>&1
if errorlevel 1 (echo [ERRO] git nao encontrado no PATH. & goto :fim)
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo [ERRO] Esta pasta nao e um repositorio Git. & goto :fim)
set "MSG=%~1"
if not defined MSG set /p "MSG=Mensagem do commit: "
if not defined MSG (echo [ERRO] Mensagem vazia; nada foi commitado. & goto :fim)
echo Adicionando todos os arquivos...
git add -A
if errorlevel 1 (echo [ERRO] Falha no git add. & goto :fim)
git commit -m "%MSG%"
if errorlevel 1 (echo [ERRO] Commit falhou - confira o git config. & goto :fim)
echo.
echo [OK] Commit criado: %MSG%
echo [i] Desfazer: git reset --soft HEAD~1
:fim
echo.
pause