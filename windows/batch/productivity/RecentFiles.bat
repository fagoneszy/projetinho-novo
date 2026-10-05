:: ============================================================
:: BATLAB | RecentFiles.bat | v1.0.0
:: @desc      Mostra os arquivos modificados nos ultimos N dias
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RecentFiles
echo ============================================
echo  BATLAB - RecentFiles
echo ============================================
set "DIAS=7"
if not "%~1"=="" set "DIAS=%~1"
echo Arquivos modificados nos ultimos %DIAS% dias:
powershell -NoProfile -Command "Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-%DIAS%) } | Sort-Object LastWriteTime -Descending | Select-Object -First 50 | ForEach-Object { Write-Host ($_.LastWriteTime.ToString('yyyy-MM-dd HH:mm') + '  ' + $_.FullName) }"
echo.
pause