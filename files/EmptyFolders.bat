:: ============================================================
:: BATLAB | EmptyFolders.bat | v1.0.0
:: @desc      Lista pastas vazias
:: @category  files
:: @admin     no
:: @risk      low
:: @undo      N/A (somente listagem)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - EmptyFolders
echo ============================================
echo  BATLAB - EmptyFolders
echo ============================================
echo Procurando pastas vazias em %CD%
echo [INFO] Pastas com arquivos ocultos nao sao consideradas vazias.
echo [INFO] A busca inclui subpastas ate o fim da arvore.
echo [INFO] Nada sera removido - a listagem e somente leitura.
echo [INFO] Use o resultado para limpar pastas manualmente.
echo.
powershell -NoProfile -Command "Get-ChildItem -Directory -Recurse -Force -EA SilentlyContinue | Where-Object { @(Get-ChildItem -LiteralPath $_.FullName -Force -EA SilentlyContinue).Count -eq 0 } | ForEach-Object { $_.FullName }"
echo.
if errorlevel 1 (echo [ERRO] Falha ao listar pastas vazias.) else (echo Feito. Pastas acima podem ser removidas manualmente.)
:fim
echo.
pause