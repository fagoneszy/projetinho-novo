:: ============================================================
:: BATLAB | RockPaperScissors.bat | v1.0.0
:: @desc      Pedra, papel e tesoura contra o computador (melhor de 3)
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RockPaperScissors
echo ============================================
echo  BATLAB - RockPaperScissors
echo ============================================
setlocal EnableDelayedExpansion
set /a V=0, D=0
echo Melhor de 3! S=pedra  P=papel  T=tesoura
:rodada
choice /c SPT /m "Sua jogada"
if errorlevel 3 (set "J=tesoura") else if errorlevel 2 (set "J=papel") else (set "J=pedra")
set /a RND=%random% %% 3
if !RND! EQU 0 (set "C=pedra") else if !RND! EQU 1 (set "C=papel") else (set "C=tesoura")
echo Voce jogou !J! - Computador jogou !C!
if "!J!"=="!C!" (echo Empate. & goto :placar)
if "!J!"=="pedra" if "!C!"=="papel" (echo Voce perdeu! & set /a D+=1 & goto :placar)
if "!J!"=="papel" if "!C!"=="tesoura" (echo Voce perdeu! & set /a D+=1 & goto :placar)
if "!J!"=="tesoura" if "!C!"=="pedra" (echo Voce perdeu! & set /a D+=1 & goto :placar)
echo Voce venceu a rodada.
set /a V+=1
:placar
echo Placar: Voce !V!  x  !D! Computador
if !V! GEQ 2 (echo PARABENS, VOCE VENCEU. & goto :fim)
if !D! GEQ 2 (echo O COMPUTADOR VENCEU. Tente de novo. & goto :fim)
goto :rodada
:fim
echo.
pause
