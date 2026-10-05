:: ============================================================
:: BATLAB | OpenStorageSettings.bat | v1.0.0
:: @desc      Abre armazenamento (ms-settings:storagesense)
:: @category  everyday
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenStorageSettings
echo ============================================
echo  BATLAB - OpenStorageSettings
echo ============================================
echo Abrindo as configuracoes de armazenamento...
start "" ms-settings:storagesense
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir as configuracoes de armazenamento.
    goto :fim
)
echo [OK] Armazenamento e Limpeza de Disco abertos.
echo [Dica] Espaco por disco tambem: DiskHealthReport.bat
echo Feito.
:fim
echo.
pause
