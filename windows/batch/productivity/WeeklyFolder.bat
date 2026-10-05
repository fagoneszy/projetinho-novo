:: ============================================================
:: BATLAB | WeeklyFolder.bat | v1.0.0
:: @desc      Cria a pasta da semana com subpastas Seg..Dom
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta criada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WeeklyFolder
echo ============================================
echo  BATLAB - WeeklyFolder
echo ============================================
powershell -NoProfile -Command "$m=(Get-Date).Date.AddDays(-(((([int](Get-Date).DayOfWeek)+6)%%7))); $n=$m.ToString('yyyy-MM-dd'); New-Item -ItemType Directory -Force -Path $n | Out-Null; 0..6 | ForEach-Object { New-Item -ItemType Directory -Force -Path (Join-Path $n $m.AddDays($_).ToString('dddd')) | Out-Null }; Write-Host ('Pasta criada: ' + (Join-Path (Get-Location) $n))"
echo.
pause
