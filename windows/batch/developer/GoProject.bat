:: ============================================================
:: BATLAB | GoProject.bat | v1.0.0
:: @desc      Cria um modulo Go com go mod init e main.go
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GoProject
echo ============================================
echo  BATLAB - GoProject
echo ============================================
set "NAME=%~1"
if not defined NAME set /p "NAME=Nome do modulo (ex.: meuapp): "
if not defined NAME (echo [ERRO] Nenhum nome informado. & goto :fim)
where go >nul 2>&1
if errorlevel 1 (echo [ERRO] go nao encontrado. Instale o Go. & goto :fim)
echo Criando modulo Go: %NAME%
if not exist "%NAME%" mkdir "%NAME%"
if not exist "%NAME%" (echo [ERRO] Falha ao criar a pasta. & goto :fim)
pushd "%NAME%"
go mod init "%NAME%"
if errorlevel 1 (echo [!] go mod init falhou - a pasta ja e modulo. & goto fimlocal)
if exist "main.go" goto semmain
echo package main> "main.go"
echo.>>"main.go"
echo import "fmt">>"main.go"
echo.>>"main.go"
echo func main^(^) {>>"main.go"
echo	fmt.Println^("Hello, world!"^)>>"main.go"
echo }>>"main.go"
echo [+] main.go criado.
:semmain
:fimlocal
popd
echo.
echo [OK] Modulo Go criado em %CD%\%NAME%
echo [i] Proximo: go run .
echo Feito.
:fim
echo.
pause
