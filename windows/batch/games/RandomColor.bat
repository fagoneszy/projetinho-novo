:: ============================================================
:: BATLAB | RandomColor.bat | v1.0.0
:: @desc      Muda a cor do console para uma aleatoria
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RandomColor
echo ============================================
echo  BATLAB - RandomColor
echo ============================================
setlocal EnableDelayedExpansion
set "HEX=123456789ABCDEF"
set /a IDX=%random% %% 15 + 1
set "C=!HEX:~%IDX%,1!"
color !C!
echo Nova cor do console: !C!
echo.
pause
