:: ============================================================
:: BATLAB | SortByDate.bat | v1.0.0
:: @desc      Organiza os arquivos em pastas por ano e mes
:: @category  files
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos das pastas Ano\Mes de volta para a pasta raiz
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SortByDate
echo ============================================
echo  BATLAB - SortByDate
echo ============================================
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhum arquivo na pasta atual. & goto :fim)
echo [ATENCAO] %COUNT% arquivo(s) serao MOVIDOS por data de modificacao.
echo Estrutura criada: Ano\Mes   Exemplo: 2026\2026-10
echo Pasta: %CD%
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "Get-ChildItem -File | ForEach-Object { $y=$_.LastWriteTime.ToString('yyyy'); $m=$_.LastWriteTime.ToString('yyyy-MM'); if(-not(Test-Path -LiteralPath $y)){New-Item -ItemType Directory -Path $y | Out-Null}; if(-not(Test-Path -LiteralPath $m)){New-Item -ItemType Directory -Path $m | Out-Null}; Move-Item -LiteralPath $_.FullName -Destination $m }"
if errorlevel 1 (echo [ERRO] Falha ao mover os arquivos.) else (echo Feito. %COUNT% arquivo(s) movido(s) por data.)
:fim
echo.
pause