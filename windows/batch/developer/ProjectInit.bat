:: ============================================================
:: BATLAB | ProjectInit.bat | v1.0.0
:: @desc      Inicializa um repo Git com estrutura basica e README
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ProjectInit
echo ============================================
echo  BATLAB - ProjectInit
echo ============================================
set "P=%~1"
if not defined P set "P=%CD%"
echo Inicializando estrutura de projeto em: %P%
if not exist "%P%" mkdir "%P%"
if not exist "%P%" (echo [ERRO] Nao foi possivel criar a pasta. & goto :fim)
pushd "%P%"
if not exist "src" mkdir src
if not exist "docs" mkdir docs
if exist "README.md" goto lerreadme
echo # Projeto> "README.md"
echo.>>"README.md"
echo Estrutura inicial criada pelo BATLAB.>>"README.md"
echo [+] README.md criado.
:lerreadme
if exist ".gitignore" goto semgitignore
echo build/> ".gitignore"
echo node_modules/>>".gitignore"
echo .venv/>>".gitignore"
echo [+] .gitignore criado.
:semgitignore
git init
if errorlevel 1 (echo [!] git init falhou - git esta instalado? & goto fimlocal)
echo [OK] Repositorio Git inicializado.
:fimlocal
popd
echo.
echo Estrutura pronta em %P%
echo Feito.
:fim
echo.
pause
