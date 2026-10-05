:: ============================================================
:: BATLAB | BreakReminder.bat | v1.0.0
:: @desc      Lembrete de pausa periodico (padrao: 20 min)
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BreakReminder
echo ============================================
echo  BATLAB - BreakReminder
echo ============================================
set /a SEG=1200
if not "%~1"=="" set /a SEG=%~1*60
echo Lembrete a cada %SEG% segundos. Ctrl+C para parar.
:loop
timeout /t %SEG% /nobreak >nul
powershell -NoProfile -Command "$w=New-Object -ComObject WScript.Shell; $w.Popup('Hora de fazer uma pausa! Levante-se e descanse os olhos.',8,'BATLAB - Pausa',64)"
goto :loop
echo.
pause
