:: ============================================================
:: BATLAB | TicTacToe.bat | v1.0.0
:: @desc      Jogo da velha 3x3 contra o computador
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TicTacToe
echo ============================================
echo  BATLAB - TicTacToe
echo ============================================
setlocal EnableDelayedExpansion
for /l %%i in (1,1,9) do set "C%%i= "
echo Voce = X  -  Computador = O
:tab
cls
echo.
echo      1 ^| 2 ^| 3
echo     ---+---+---
echo      4 ^| 5 ^| 6
echo     ---+---+---
echo      7 ^| 8 ^| 9
echo.
echo      !C1! ^| !C2! ^| !C3!
echo     ---+---+---
echo      !C4! ^| !C5! ^| !C6!
echo     ---+---+---
echo      !C7! ^| !C8! ^| !C9!
echo.
:vez
set /p "J=Escolha uma casa de 1 a 9: "
if not defined J goto :fim
echo(!J!| findstr /r "^[1-9]$" >nul
if errorlevel 1 (echo Numero invalido. & goto :vez)
if not "!C%J%!"==" " (echo Casa ocupada. & goto :vez)
set "C%J%=X"
call :checa X
if errorlevel 2 (echo PARABENS, VOCE VENCEU. & goto :fim)
call :vazias
if errorlevel 1 goto :pcvai
echo EMPATE.
goto :fim
:pcvai
call :pcmove
call :checa O
if errorlevel 2 (echo O COMPUTADOR VENCEU. & goto :fim)
call :vazias
if errorlevel 1 goto :tab
echo EMPATE.
goto :fim
:pcmove
set /a R=%random% %% 9 + 1
if not "!C%R%!"==" " goto :pcmove
set "C%R%=O"
echo O computador jogou na casa !R!.
exit /b 0
:checa
set "M=%~1"
set "K=!C1!!C2!!C3!"
if "!K!"=="%M%%M%%M%" exit /b 2
set "K=!C4!!C5!!C6!"
if "!K!"=="%M%%M%%M%" exit /b 2
set "K=!C7!!C8!!C9!"
if "!K!"=="%M%%M%%M%" exit /b 2
set "K=!C1!!C4!!C7!"
if "!K!"=="%M%%M%%M%" exit /b 2
set "K=!C2!!C5!!C8!"
if "!K!"=="%M%%M%%M%" exit /b 2
set "K=!C3!!C6!!C9!"
if "!K!"=="%M%%M%%M%" exit /b 2
set "K=!C1!!C5!!C9!"
if "!K!"=="%M%%M%%M%" exit /b 2
set "K=!C3!!C5!!C7!"
if "!K!"=="%M%%M%%M%" exit /b 2
exit /b 0
:vazias
for /l %%i in (1,1,9) do (
    if not "!C%%i!"==" " exit /b 1
)
exit /b 0
:fim
echo.
pause
