:: ============================================================
:: BATLAB | LargeFiles.bat | v1.0.0
:: @desc      Lista arquivos maiores que N MB (padrao 100)
:: @category  files
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente listagem)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LargeFiles
echo ============================================
echo  BATLAB - LargeFiles
echo ============================================
set "MB=%~1"
if not defined MB set /p "MB=Tamanho minimo em MB (padrao 100): "
if not defined MB set "MB=100"
echo(%MB%| findstr /r /c:"^[0-9][0-9]*$" >nul || set "MB=100"
echo Listando arquivos maiores que %MB% MB em %CD%
echo [INFO] Inclui subpastas. Nada sera alterado.
echo.
powershell -NoProfile -Command "Get-ChildItem -File -Recurse -Force -EA SilentlyContinue | Where-Object { $_.Length -gt (%MB% * 1MB) } | Sort-Object Length -Descending | ForEach-Object { '{0,12:N0} KB  {1}' -f ($_.Length/1KB), $_.FullName }"
if errorlevel 1 (echo [ERRO] Falha ao listar os arquivos.) else (echo Feito. Listagem concluida.)
:fim
echo.
pause
