:: ============================================================
:: BATLAB | ASCIIArt.bat | v1.0.0
:: @desc      Exibe banners ASCII aleatorios
:: @category  games
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ASCIIArt
echo ============================================
echo  BATLAB - ASCIIArt
echo ============================================
set /a R=%random% %% 4 + 1
if %R% EQU 1 goto :a1
if %R% EQU 2 goto :a2
if %R% EQU 3 goto :a3
goto :a4
:a1
echo.
echo    ####  ####  ####  ####
echo    #     #  #  #  #  #  #
echo    ####  ####  #  #  ####
echo       #  #  #  #  #  #  #
echo    ####  #  #  ####  #  #
echo.
goto :fim
:a2
echo.
echo         *
echo        ***
echo       *****
echo      *******
echo       *****
echo        ***
echo         *
echo.
goto :fim
:a3
echo.
echo    ****   ****
echo    ****   ****
echo     **** ****
echo      *****
echo       ***
echo        *
echo.
goto :fim
:a4
echo.
echo         *
echo        **
echo       ***
echo      ****
echo     *****
echo      ****
echo       ***
echo        **
echo         *
echo.
:fim
echo.
pause