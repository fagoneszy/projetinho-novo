:: ============================================================
:: BATLAB | TerminalMusic.bat | v1.0.0
:: @desc      Toca uma melodia simples no terminal
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TerminalMusic
echo ============================================
echo  BATLAB - TerminalMusic
echo ============================================
echo Tocando uma melodia simples...
powershell -NoProfile -Command "[console]::Beep(660,300); [console]::Beep(784,300); [console]::Beep(880,300); [console]::Beep(784,300); [console]::Beep(660,300); [console]::Beep(587,300); [console]::Beep(523,600)"
echo Fim da melodia.
echo.
pause
