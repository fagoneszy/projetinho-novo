:: ============================================================
:: BATLAB | EpicLauncher.bat | v1.0.0
:: @desc      Abre a Epic Games Launcher
:: @category  games
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - EpicLauncher
echo ============================================
echo  BATLAB - EpicLauncher
echo ============================================
echo Abrindo a Epic Games Launcher...
start "" "com.epicgames.launcher://apps"
echo Se a Epic estiver instalada, ela vai abrir.
echo.
pause