:: ============================================================
:: BATLAB | OpenLastModified.bat | v1.0.0
:: @desc      Abre o arquivo mais recentemente alterado da pasta
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenLastModified
echo ============================================
echo  BATLAB - OpenLastModified
echo ============================================
powershell -NoProfile -Command "$f=Get-ChildItem -File | Sort-Object LastWriteTime -Descending | Select-Object -First 1; if ($f) { Write-Host ('Abrindo: ' + $f.Name); Start-Process -LiteralPath $f.FullName } else { Write-Host 'Nenhum arquivo nesta pasta.' }"
echo.
pause