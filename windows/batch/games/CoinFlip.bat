:: ============================================================
:: BATLAB | CoinFlip.bat | v1.0.0
:: @desc      Cara ou coroa
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CoinFlip
echo ============================================
echo  BATLAB - CoinFlip
echo ============================================
set /a R=%random% %% 2
if %R% EQU 0 (echo Resultado: CARA) else (echo Resultado: COROA)
echo.
pause
