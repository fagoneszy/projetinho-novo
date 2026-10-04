:: ============================================================
:: BATLAB | SortBySize.bat | v1.0.0
:: @desc      Separa os arquivos por faixa de tamanho
:: @category  files
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos das pastas de faixa de volta para a pasta raiz
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SortBySize
echo ============================================
echo  BATLAB - SortBySize
echo ============================================
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhum arquivo na pasta atual. & goto :fim)
echo [ATENCAO] %COUNT% arquivo(s) serao MOVIDOS por faixa de tamanho.
echo Faixas: 0-1MB, 1-10MB, 10-100MB, 100MB+
echo Pasta: %CD%
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "Get-ChildItem -File | ForEach-Object { $s=$_.Length; if($s -lt 1MB){$t='0-1MB'} elseif($s -lt 10MB){$t='1-10MB'} elseif($s -lt 100MB){$t='10-100MB'} else {$t='100MB+'}; if(-not(Test-Path -LiteralPath $t)){New-Item -ItemType Directory -Path $t | Out-Null}; Move-Item -LiteralPath $_.FullName -Destination $t }"
if errorlevel 1 (echo [ERRO] Falha ao mover os arquivos.) else (echo Feito. %COUNT% arquivo(s) movido(s) por tamanho.)
:fim
echo.
pause