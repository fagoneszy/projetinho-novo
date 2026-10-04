:: ============================================================
:: BATLAB | OpenRecycleBin.bat | v1.0.0
:: @desc      Abre a Lixeira (explorer shell:RecycleBinFolder)
:: @category  everyday
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenRecycleBin
echo ============================================
echo  BATLAB - OpenRecycleBin
echo ============================================
echo Abrindo a Lixeira...
start "" explorer.exe shell:RecycleBinFolder
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir a Lixeira.
    goto :fim
)
echo [OK] Lixeira aberta no Explorador de Arquivos.
echo [Dica] Esvaziar: rode EmptyRecycleBin.bat com /dryrun antes.
echo Feito.
:fim
echo.
pause