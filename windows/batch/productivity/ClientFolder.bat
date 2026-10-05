:: ============================================================
:: BATLAB | ClientFolder.bat | v1.0.0
:: @desc      Cria a estrutura de pastas de um cliente
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta criada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ClientFolder
echo ============================================
echo  BATLAB - ClientFolder
echo ============================================
if "%~1"=="" (set /p "NOME=Nome do cliente: ") else set "NOME=%~1"
if not defined NOME (echo Nada digitado. & goto :fim)
for %%D in (Propostas Faturas Entregas Reunioes Contratos) do if not exist "%NOME%\%%D" mkdir "%NOME%\%%D"
echo Estrutura criada em: %CD%\%NOME%
:fim
echo.
pause
