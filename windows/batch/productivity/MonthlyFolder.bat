:: ============================================================
:: BATLAB | MonthlyFolder.bat | v1.0.0
:: @desc      Cria a estrutura do mes (AAAA-MM com 31 pastas de dias)
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta criada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MonthlyFolder
echo ============================================
echo  BATLAB - MonthlyFolder
echo ============================================
powershell -NoProfile -Command "$n=Get-Date -Format yyyy-MM; New-Item -ItemType Directory -Force -Path $n | Out-Null; 1..31 | ForEach-Object { New-Item -ItemType Directory -Force -Path (Join-Path $n ('{0:d2}' -f $_)) | Out-Null }; Write-Host ('Pasta criada: ' + (Join-Path (Get-Location) $n))"
echo.
pause