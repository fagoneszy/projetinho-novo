:: ============================================================
:: BATLAB | ExportFileListCSV.bat | v1.0.0
:: @desc      Exporta nome;tamanho;data para CSV
:: @category  files
:: @admin     no
:: @risk      low
:: @undo      Apague o arquivo CSV gerado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ExportFileListCSV
echo ============================================
echo  BATLAB - ExportFileListCSV
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "D=%%i"
set "OUT=%~1"
if not defined OUT set "OUT=%CD%\lista_arquivos_%D%.csv"
echo Gerando CSV com nome, tamanho e data em %CD%
echo Destino: %OUT%
echo [INFO] Colunas: Nome (caminho completo), TamanhoKB, Modificado.
echo.
powershell -NoProfile -Command "Get-ChildItem -File -Recurse -Force -EA SilentlyContinue | Select-Object @{n='Nome';e={$_.FullName}}, @{n='TamanhoKB';e={[math]::Round($_.Length/1KB,2)}}, @{n='Modificado';e={$_.LastWriteTime.ToString('yyyy-MM-dd HH:mm')}} | Export-Csv -LiteralPath '%OUT%' -NoTypeInformation -Encoding UTF8"
if errorlevel 1 (echo [ERRO] Falha ao gravar o CSV.) else (echo Feito. CSV gravado em %OUT%)
:fim
echo.
pause