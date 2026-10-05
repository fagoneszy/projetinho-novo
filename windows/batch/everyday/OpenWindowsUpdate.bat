:: ============================================================
:: BATLAB | OpenWindowsUpdate.bat | v1.0.0
:: @desc      Abre atualizacao do Windows (ms-settings:windowsupdate)
:: @category  everyday
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenWindowsUpdate
echo ============================================
echo  BATLAB - OpenWindowsUpdate
echo ============================================
echo Abrindo o Windows Update...
start "" ms-settings:windowsupdate
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir o Windows Update.
    goto :fim
)
echo [OK] Windows Update aberto.
echo [Dica] Historico: ms-settings:windowsupdate-history
echo Feito.
:fim
echo.
pause
