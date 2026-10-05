:: ============================================================
:: BATLAB | OpenProject.bat | v1.0.0
:: @desc      Abre a pasta do projeto no Explorer, VS Code e terminal
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenProject
echo ============================================
echo  BATLAB - OpenProject
echo ============================================
echo Abrindo o projeto em %CD%...
start "" explorer "%CD%"
where code >nul 2>&1 && (code "%CD%" >nul 2>&1) || echo   [!] VS Code nao esta no PATH
where wt >nul 2>&1 && (start "" wt -d "%CD%") || start "" cmd /k "title Terminal do projeto"
echo Pronto.
echo.
pause
