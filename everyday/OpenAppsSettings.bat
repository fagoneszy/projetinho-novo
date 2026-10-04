:: ============================================================
:: BATLAB | OpenAppsSettings.bat | v1.0.0
:: @desc      Abre apps instalados (ms-settings:appsfeatures)
:: @category  everyday
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenAppsSettings
echo ============================================
echo  BATLAB - OpenAppsSettings
echo ============================================
echo Abrindo a lista de apps instalados...
start "" ms-settings:appsfeatures
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir Apps e Recursos.
    goto :fim
)
echo [OK] Apps e Recursos abertos.
echo [Dica] Lista em CSV: rode InstalledPrograms.bat
echo Feito.
:fim
echo.
pause