:: ============================================================
:: BATLAB | RunTests.bat | v1.0.0
:: @desc      Detecta e roda os testes do projeto (pytest, npm, cargo, go)
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RunTests
echo ============================================
echo  BATLAB - RunTests
echo ============================================
echo Detectando o framework de testes do projeto...
echo Pasta: %CD%
if exist "Cargo.toml" goto rust
if exist "package.json" goto node
if exist "pytest.ini" goto py
if exist "pyproject.toml" goto py
if exist "requirements.txt" if exist "tests" goto py
if exist "go.mod" goto go
if exist "Makefile" goto make
echo [ERRO] Nenhum projeto reconhecido (node, rust, python, go, make).
goto :fim
:rust
echo Rodando: cargo test
cargo test
if errorlevel 1 echo [!] Testes Rust com falha.
goto :fim
:node
echo Rodando: npm test
call npm test
if errorlevel 1 echo [!] Testes Node com falha.
goto :fim
:py
echo Rodando: python -m pytest
python -m pytest -q
if errorlevel 1 echo [!] Testes Python com falha.
goto :fim
:go
echo Rodando: go test ./...
go test ./...
if errorlevel 1 echo [!] Testes Go com falha.
goto :fim
:make
echo Rodando: make test
make test
if errorlevel 1 echo [!] make test retornou erro.
:fim
echo.
pause
