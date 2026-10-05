:: ============================================================
:: BATLAB | GuessNumber.bat | v1.0.0
:: @desc      Jogo: adivinhe o numero de 1 a 100 com dicas
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GuessNumber
echo ============================================
echo  BATLAB - GuessNumber
echo ============================================
setlocal EnableDelayedExpansion
set /a ALVO=%random% %% 100 + 1, T=0
echo Pensei em um numero de 1 a 100...
:loop
set /p "G=Seu palpite: "
if not defined G goto :fim
echo(!G!| findstr /r "^[0-9][0-9]?[0-9]?$" >nul
if errorlevel 1 (echo Apenas numeros, de 1 a 100. & goto :loop)
set /a T+=1
if !G! LSS 1 goto :loop
if !G! GTR 100 goto :loop
if !G! LSS !ALVO! (echo Mais: O numero e maior. & goto :loop)
if !G! GTR !ALVO! (echo Menor: O numero e menor. & goto :loop)
echo ACERTOU em !T! tentativas. O numero era !ALVO!.
goto :fim
echo.
pause
