:: ============================================================
:: BATLAB | NormalizeFileNames.bat | v1.0.0
:: @desc      Padroniza nomes: minusculas e sem espacos (usa underscore)
:: @category  productivity
:: @admin     no
:: @risk      medium
:: @undo      Renomeie manualmente para voltar ao original
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NormalizeFileNames
echo ============================================
echo  BATLAB - NormalizeFileNames
echo ============================================
echo [ATENCAO] Vai padronizar os nomes: minusculas e espacos viram _.
powershell -NoProfile -Command "Get-ChildItem -File | Where-Object { $_.Name -cne $_.Name.ToLower() -or $_.Name -match ' ' } | Select-Object -ExpandProperty Name"
choice /c SN /m "Padronizar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "Get-ChildItem -File | ForEach-Object { $n=$_.Name.ToLower() -replace ' ','_'; if ($n -ne $_.Name) { Rename-Item -LiteralPath $_.FullName -NewName $n } }"
echo Pronto.
:fim
echo.
pause