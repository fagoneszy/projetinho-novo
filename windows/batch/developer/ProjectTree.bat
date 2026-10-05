:: ============================================================
:: BATLAB | ProjectTree.bat | v1.0.0
:: @desc      Mostra a arvore de arquivos do projeto com tree /f
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ProjectTree
echo ============================================
echo  BATLAB - ProjectTree
echo ============================================
echo Estrutura de arquivos do projeto...
echo Pasta: %CD%
echo Data: %DATE% %TIME%
echo.
tree /f
if errorlevel 1 (echo [!] tree falhou nesta pasta. & goto :fim)
echo.
echo [i] A opcao /f inclui os arquivos de cada pasta.
echo [i] Para ver a estrutura atualizada rode de novo.
echo Feito.
:fim
echo.
pause
