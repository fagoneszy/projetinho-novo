:: ============================================================
:: BATLAB | FolderTree.bat | v1.0.0
:: @desc      Gera a arvore de diretorios
:: @category  files
:: @admin     no
:: @risk      low
:: @undo      N/A (somente listagem)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FolderTree
echo ============================================
echo  BATLAB - FolderTree
echo ============================================
echo Arvore de diretorios de %CD%
echo [INFO] Usa tree /f /a: mostra pastas, arquivos e ligacoes graficas.
echo [INFO] Apenas leitura - nada e alterado.
echo [INFO] Para salvar em arquivo use: tree /f /a ^> arvore.txt
echo [INFO] Pastas ocultas nao aparecem na arvore.
echo.
tree /f /a
echo.
if errorlevel 1 (echo [ERRO] Falha ao gerar a arvore.) else (echo Feito. Arvore concluida.)
:fim
echo.
pause