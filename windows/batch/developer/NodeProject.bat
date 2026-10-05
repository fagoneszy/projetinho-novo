:: ============================================================
:: BATLAB | NodeProject.bat | v1.0.0
:: @desc      Cria um projeto Node.js com npm init, src e index.js
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NodeProject
echo ============================================
echo  BATLAB - NodeProject
echo ============================================
set "P=%~1"
if not defined P set "P=%CD%"
echo Criando projeto Node.js em: %P%
where npm >nul 2>&1
if errorlevel 1 (echo [ERRO] npm nao encontrado no PATH. & goto :fim)
if not exist "%P%" mkdir "%P%"
if not exist "%P%" (echo [ERRO] Falha ao criar a pasta. & goto :fim)
pushd "%P%"
if not exist "src" mkdir src
if exist "src\index.js" goto semmain
echo console.log^('Hello, world!'^);> "src\index.js"
echo [+] src\index.js criado.
:semmain
call npm init -y
if errorlevel 1 (echo [!] npm init falhou. & goto fimlocal)
echo [OK] package.json criado.
:fimlocal
popd
echo.
echo Projeto Node pronto em %P%
echo [i] Rode com: node src\index.js
echo Feito.
:fim
echo.
pause
