:: ============================================================
:: BATLAB | ActivateVenv.bat | v1.0.0
:: @desc      Abre um prompt com o ambiente virtual .venv ativo
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ActivateVenv
echo ============================================
echo  BATLAB - ActivateVenv
echo ============================================
echo Ativando o ambiente virtual .venv...
if not exist ".venv\Scripts\activate.bat" (echo [ERRO] .venv nao encontrado. Rode CreateVenv.bat. & goto :fim)
echo Abrindo um novo prompt com o venv ativo...
echo Pasta: %CD%
start "" %ComSpec% /k ".venv\Scripts\activate.bat"
if errorlevel 1 (echo [!] Falha ao abrir o prompt. & goto :fim)
echo.
echo [OK] Prompt aberto com .venv ativo.
echo [i] Feche o prompt para desativar o ambiente.
echo Feito.
:fim
echo.
pause
