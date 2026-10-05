:: ============================================================
:: BATLAB | BuildProject.bat | v1.0.0
:: @desc      Detecta e roda o build do projeto (make, npm, cargo, cmake)
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BuildProject
echo ============================================
echo  BATLAB - BuildProject
echo ============================================
echo Detectando o sistema de build do projeto...
echo Pasta: %CD%
if exist "Cargo.toml" goto rust
if exist "package.json" goto node
if exist "CMakeLists.txt" goto cmake
if exist "Makefile" goto make
if exist "pom.xml" goto maven
echo [ERRO] Nenhum projeto reconhecido (make, npm, cargo, cmake, maven).
goto :fim
:make
echo Rodando: make
make
if errorlevel 1 (echo [!] make retornou erro. & goto :fim)
echo [OK] Build concluido via make.
goto :fim
:node
echo Rodando: npm run build
call npm run build
if errorlevel 1 (echo [!] npm run build falhou. & goto :fim)
echo [OK] Build concluido via npm.
goto :fim
:rust
echo Rodando: cargo build
cargo build
if errorlevel 1 (echo [!] cargo build falhou. & goto :fim)
echo [OK] Build concluido via cargo.
goto :fim
:cmake
if not exist "build" mkdir "build"
cmake -S . -B build
if errorlevel 1 (echo [!] Falha na configuracao do CMake. & goto :fim)
cmake --build build
if errorlevel 1 (echo [!] Falha no build do CMake. & goto :fim)
echo [OK] Build CMake concluido.
goto :fim
:maven
echo Rodando: mvn -q package
mvn -q package
if errorlevel 1 (echo [!] mvn retornou erro. & goto :fim)
echo [OK] Build Maven concluido.
:fim
echo.
pause
