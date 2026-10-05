:: ============================================================
:: BATLAB | JavaProject.bat | v1.0.0
:: @desc      Cria a estrutura de projeto Java com src e Main.java
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - JavaProject
echo ============================================
echo  BATLAB - JavaProject
echo ============================================
set "P=%~1"
if not defined P set "P=%CD%"
echo Criando estrutura Java em: %P%
if not exist "%P%" mkdir "%P%"
if not exist "%P%" (echo [ERRO] Falha ao criar a pasta. & goto :fim)
pushd "%P%"
if not exist "src" mkdir src
if exist "src\Main.java" goto mainok
echo public class Main {> "src\Main.java"
echo     public static void main^(String[] args^) {>> "src\Main.java"
echo         System.out.println^("Hello, world!"^);>> "src\Main.java"
echo     }>> "src\Main.java"
echo }>> "src\Main.java"
echo [+] src\Main.java criado.
:mainok
popd
echo.
echo [OK] Estrutura Java criada em %P%
echo [i] Compile com: javac src\Main.java
echo [i] Execute com: java -cp src Main
echo Feito.
:fim
echo.
pause
