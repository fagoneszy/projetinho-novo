:: ============================================================
:: BATLAB | CreateVenv.bat | v1.0.0
:: @desc      Cria um ambiente virtual Python na pasta .venv
:: @category  developer
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CreateVenv
echo ============================================
echo  BATLAB - CreateVenv
echo ============================================
echo Criando ambiente virtual Python (.venv) em %CD%...
where python >nul 2>&1
if errorlevel 1 (echo [ERRO] python nao encontrado no PATH. & goto :fim)
if exist ".venv" (echo [!] A pasta .venv ja existe; nada sera alterado. & goto :fim)
echo Pasta alvo: %CD%\.venv
python -m venv .venv
if errorlevel 1 (echo [ERRO] Falha ao criar o ambiente virtual. & goto :fim)
if not exist ".venv\Scripts\activate.bat" (echo [ERRO] activate.bat ausente apos criar. & goto :fim)
echo.
echo [OK] Ambiente virtual criado em .venv
echo [i] Proximo passo: ActivateVenv.bat
echo Feito.
:fim
echo.
pause