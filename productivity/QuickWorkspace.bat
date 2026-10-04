:: ============================================================
:: BATLAB | QuickWorkspace.bat | v1.0.0
:: @desc      Abre todos os programas de trabalho de uma vez
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - QuickWorkspace
echo ============================================
echo  BATLAB - QuickWorkspace
echo ============================================
echo Abrindo aplicativos de trabalho...
set "APPS=notepad calc explorer"
for %%A in (%APPS%) do (
    where %%A >nul 2>&1
    if errorlevel 1 (echo   [!] Nao encontrado: %%A) else (start "" %%A)
)
echo Pronto.
echo.
pause