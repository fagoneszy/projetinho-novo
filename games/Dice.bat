:: ============================================================
:: BATLAB | Dice.bat | v1.0.0
:: @desc      Rola um dado de 6 lados
:: @category  games
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - Dice
echo ============================================
echo  BATLAB - Dice
echo ============================================
set /a R=%random% %% 6 + 1
echo   +-------+
echo   ^|   %R%   ^|
echo   +-------+
echo Voce tirou: %R%
echo.
pause