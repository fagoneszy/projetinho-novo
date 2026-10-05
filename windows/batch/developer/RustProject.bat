:: ============================================================
:: BATLAB | RustProject.bat | v1.0.0
:: @desc      Cria um projeto Rust com cargo new
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RustProject
echo ============================================
echo  BATLAB - RustProject
echo ============================================
set "NAME=%~1"
if not defined NAME set /p "NAME=Nome do projeto: "
if not defined NAME (echo [ERRO] Nenhum nome informado. & goto :fim)
where cargo >nul 2>&1
if errorlevel 1 (echo [ERRO] cargo nao encontrado. Instale o Rust. & goto :fim)
echo Criando projeto Rust: %NAME%
echo Pasta: %CD%\%NAME%
cargo new "%NAME%"
if errorlevel 1 (echo [ERRO] cargo new falhou. & goto :fim)
echo.
echo [OK] Projeto Rust criado em %CD%\%NAME%
echo [i] Proximo: cd %NAME% e depois cargo run.
echo Feito.
:fim
echo.
pause
