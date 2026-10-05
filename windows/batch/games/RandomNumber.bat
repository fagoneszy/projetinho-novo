:: ============================================================
:: BATLAB | RandomNumber.bat | v1.0.0
:: @desc      Sorteia um numero entre 1 e N (padrao 100)
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RandomNumber
echo ============================================
echo  BATLAB - RandomNumber
echo ============================================
set "N=100"
if not "%~1"=="" set "N=%~1"
set /a R=%random% %% N + 1
echo Numero sorteado de 1 a %N%: %R%
echo.
pause
