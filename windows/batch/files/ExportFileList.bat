:: ============================================================
:: BATLAB | ExportFileList.bat | v1.0.0
:: @desc      Exporta a lista de arquivos para TXT
:: @category  files
:: @admin     no
:: @risk      low
:: @undo      Apague o arquivo TXT gerado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ExportFileList
echo ============================================
echo  BATLAB - ExportFileList
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "D=%%i"
set "OUT=%~1"
if not defined OUT set "OUT=%CD%\lista_arquivos_%D%.txt"
echo Gerando a lista de arquivos de %CD%
echo Destino: %OUT%
echo [INFO] O TXT contera todos os caminhos (inclui subpastas).
echo.
dir /s /b > "%OUT%"
if errorlevel 1 (echo [ERRO] Falha ao gravar o arquivo.) else (echo Feito. Lista gravada em %OUT%)
:fim
echo.
pause