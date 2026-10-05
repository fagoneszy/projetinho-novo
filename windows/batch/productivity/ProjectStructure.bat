:: ============================================================
:: BATLAB | ProjectStructure.bat | v1.0.0
:: @desc      Cria a estrutura basica de um projeto (src, docs, tests)
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta criada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ProjectStructure
echo ============================================
echo  BATLAB - ProjectStructure
echo ============================================
if "%~1"=="" (set /p "NOME=Nome do projeto: ") else set "NOME=%~1"
if not defined NOME set "NOME=NovoProjeto"
for %%D in (src docs tests assets) do if not exist "%NOME%\%%D" mkdir "%NOME%\%%D"
if not exist "%NOME%\README.md" >"%NOME%\README.md" echo # %NOME%
if not exist "%NOME%\.gitignore" >"%NOME%\.gitignore" echo.
echo Estrutura criada em: %CD%\%NOME%
echo.
pause
