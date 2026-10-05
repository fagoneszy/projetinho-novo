:: ============================================================
:: BATLAB | MinecraftLauncher.bat | v1.0.0
:: @desc      Abre o Minecraft
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MinecraftLauncher
echo ============================================
echo  BATLAB - MinecraftLauncher
echo ============================================
echo Abrindo o Minecraft...
start "" "minecraft://"
echo Se o Minecraft estiver instalado, ele vai abrir.
echo.
pause
