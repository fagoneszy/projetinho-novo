:: ============================================================
:: BATLAB | PythonProject.bat | v1.0.0
:: @desc      Cria estrutura Python com requirements.txt e main.py
:: @category  developer
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PythonProject
echo ============================================
echo  BATLAB - PythonProject
echo ============================================
set "P=%~1"
if not defined P set "P=%CD%"
echo Criando estrutura Python em: %P%
if not exist "%P%" mkdir "%P%"
if not exist "%P%" (echo [ERRO] Falha ao criar a pasta. & goto :fim)
pushd "%P%"
if not exist "src" mkdir src
if exist "requirements.txt" goto reqok
echo # dependencias do projeto> "requirements.txt"
echo [+] requirements.txt criado.
:reqok
if exist "src\main.py" goto mainok
echo print^("Hello, world!"^);> "src\main.py"
echo [+] src\main.py criado.
:mainok
popd
echo.
echo [OK] Estrutura Python criada em %P%
echo [i] Proximo: CreateVenv.bat e InstallRequirements.bat.
echo Feito.
:fim
echo.
pause