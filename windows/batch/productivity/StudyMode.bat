:: ============================================================
:: BATLAB | StudyMode.bat | v1.0.0
:: @desc      Abre navegador, editor e musica para estudos
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - StudyMode
echo ============================================
echo  BATLAB - StudyMode
echo ============================================
set "EDITOR=notepad"
set "MUSICA=spotify:"
start "" "https://duckduckgo.com"
start "" %EDITOR%
if defined MUSICA start "" "%MUSICA%"
echo Modo estudo ativo: navegador + editor + musica.
echo.
pause
