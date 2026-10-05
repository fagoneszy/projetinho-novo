:: ============================================================
:: BATLAB | SteamLauncher.bat | v1.0.0
:: @desc      Abre a Steam
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SteamLauncher
echo ============================================
echo  BATLAB - SteamLauncher
echo ============================================
echo Abrindo a Steam...
start "" "steam://open/games"
echo Pronto.
echo.
pause
