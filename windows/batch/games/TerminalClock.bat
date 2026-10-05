:: ============================================================
:: BATLAB | TerminalClock.bat | v1.0.0
:: @desc      Relogio em tempo real no terminal - Ctrl+C para sair
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TerminalClock
echo ============================================
echo  BATLAB - TerminalClock
echo ============================================
echo Relogio - Ctrl+C para sair.
:loop
cls
echo.
echo      %date%
echo      %time%
timeout /t 1 /nobreak >nul
goto :loop
echo.
pause
