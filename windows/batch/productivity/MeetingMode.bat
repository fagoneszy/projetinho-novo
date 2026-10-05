:: ============================================================
:: BATLAB | MeetingMode.bat | v1.0.0
:: @desc      Prepara os aplicativos para uma reuniao
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MeetingMode
echo ============================================
echo  BATLAB - MeetingMode
echo ============================================
echo Preparando ambiente de reuniao...
start "" "ms-teams:"
start "" calc
echo Dica: use FocusMode.bat para fechar distracoes antes da chamada.
echo.
pause