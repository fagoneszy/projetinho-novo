:: ============================================================
:: BATLAB | FileCounter.bat | v1.0.0
:: @desc      Conta arquivos e pastas da pasta atual
:: @category  files
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente contagem)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FileCounter
echo ============================================
echo  BATLAB - FileCounter
echo ============================================
echo Contando arquivos e pastas em %CD%
echo [INFO] Contagem direta = apenas esta pasta.
echo [INFO] Contagem recursiva = esta pasta e todas as subpastas.
echo.
set /a FA=0, PA=0
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do set /a FA+=1
for /f "delims=" %%d in ('dir /b /ad 2^>nul') do set /a PA+=1
echo Direto:    %FA% arquivo(s), %PA% pasta(s)
powershell -NoProfile -Command "$f=@(Get-ChildItem -File -Recurse -Force -EA SilentlyContinue); $d=@(Get-ChildItem -Directory -Recurse -Force -EA SilentlyContinue); Write-Host ('Recursivo: ' + $f.Count + ' arquivo(s), ' + $d.Count + ' pasta(s)'); Write-Host ('Tamanho:  ' + [math]::Round((($f | Measure-Object Length -Sum).Sum)/1MB,2) + ' MB')"
if errorlevel 1 (echo [ERRO] Falha na contagem recursiva.) else (echo Feito. Contagem concluida.)
:fim
echo.
pause
