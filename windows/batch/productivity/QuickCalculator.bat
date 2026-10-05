:: ============================================================
:: BATLAB | QuickCalculator.bat | v1.0.0
:: @desc      Calculadora rapida pelo terminal (aceita 1+2*3, parenteses e decimais)
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - QuickCalculator
echo ============================================
echo  BATLAB - QuickCalculator
echo ============================================
if "%~1"=="" (set /p "EXPR=Expressao (ex.: (2+3)*4.5): ") else set "EXPR=%~1"
if not defined EXPR (echo Nada digitado. & goto :fim)
powershell -NoProfile -Command "try { $e='%EXPR%' -replace ',','.'; Write-Host ('= ' + [double]([scriptblock]::Create($e).InvokeReturnAsIs())) } catch { Write-Host 'Expressao invalida. Ex.: 2+2  ou  (10-3)/2' }"
:fim
echo.
pause
