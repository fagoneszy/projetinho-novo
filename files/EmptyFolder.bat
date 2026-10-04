:: ============================================================
:: BATLAB | EmptyFolder.bat | v1.0.0
:: @desc      Esvazia o conteudo da pasta atual
:: @category  files
:: @admin     no
:: @risk      high
:: @undo      Irreversivel - use /dryrun antes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - EmptyFolder
echo ============================================
echo  BATLAB - EmptyFolder
echo ============================================
set "DRY="
if /i "%~1"=="/dryrun" set "DRY=1"
echo [ATENCAO] Todo o conteudo abaixo sera APAGADO permanentemente:
echo    %CD%
echo Itens que serao afetados:
dir /a /-c
if defined DRY (echo [/dryrun] Nenhuma alteracao feita. & goto :fim)
choice /c SN /m "Esvaziar esta pasta? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo [ATENCAO] CONFIRMACAO FINAL: apagar todos os arquivos e pastas daqui.
choice /c SN /m "Excluir de vez? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "Get-ChildItem -LiteralPath . -Force -EA SilentlyContinue | Remove-Item -Recurse -Force -EA SilentlyContinue"
set /a LEFT=0
for /f "delims=" %%f in ('dir /b /a 2^>nul') do if /i not "%%f"=="." if /i not "%%f"==".." set /a LEFT+=1
if %LEFT% gtr 0 (echo [!] Restaram %LEFT% item(ns) - em uso ou protegidos.) else (echo Feito. Pasta esvaziada.)
:fim
echo.
pause