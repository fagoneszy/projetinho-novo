:: ============================================================
:: BATLAB | QuickSearch.bat | v1.0.0
:: @desc      Pesquisa arquivos por nome na pasta atual
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - QuickSearch
echo ============================================
echo  BATLAB - QuickSearch
echo ============================================
if "%~1"=="" (set /p "PADRAO=Buscar (ex.: *.pdf ou nota*): ") else set "PADRAO=%~1"
if not defined PADRAO (echo Nada digitado. & goto :fim)
echo Buscando "%PADRAO%" em %CD%...
echo ----------------------------------------
dir /s /b "%PADRAO%" 2>nul
echo ----------------------------------------
echo Fim da busca.
:fim
echo.
pause