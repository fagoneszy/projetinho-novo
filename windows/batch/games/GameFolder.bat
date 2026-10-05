:: ============================================================
:: BATLAB | GameFolder.bat | v1.0.0
:: @desc      Cria a estrutura de uma pasta de jogo
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta criada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GameFolder
echo ============================================
echo  BATLAB - GameFolder
echo ============================================
if "%~1"=="" (set /p "NOME=Nome do jogo: ") else set "NOME=%~1"
if not defined NOME set "NOME=NovoJogo"
for %%D in (Assets Screenshots Saves Builds) do if not exist "%NOME%\%%D" mkdir "%NOME%\%%D"
echo Estrutura criada em: %CD%\%NOME%
echo.
pause
