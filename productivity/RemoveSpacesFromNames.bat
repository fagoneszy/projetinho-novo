:: ============================================================
:: BATLAB | RemoveSpacesFromNames.bat | v1.0.0
:: @desc      Remove os espacos dos nomes dos arquivos
:: @category  productivity
:: @admin     no
:: @risk      medium
:: @undo      Renomeie manualmente para voltar ao original
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RemoveSpacesFromNames
echo ============================================
echo  BATLAB - RemoveSpacesFromNames
echo ============================================
echo [ATENCAO] Vai remover os espacos dos nomes dos arquivos desta pasta.
powershell -NoProfile -Command "Get-ChildItem -File | Where-Object { $_.Name -match ' ' } | Select-Object -ExpandProperty Name"
choice /c SN /m "Remover espacos? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "Get-ChildItem -File | Where-Object { $_.Name -match ' ' } | ForEach-Object { Rename-Item -LiteralPath $_.FullName -NewName ($_.Name -replace ' ','') }"
echo Pronto.
:fim
echo.
pause