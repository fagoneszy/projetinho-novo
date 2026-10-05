:: ============================================================
:: BATLAB | OpenDisplaySettings.bat | v1.0.0
:: @desc      Abre tela (desk.cpl)
:: @category  everyday
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenDisplaySettings
echo ============================================
echo  BATLAB - OpenDisplaySettings
echo ============================================
echo Abrindo as configuracoes de tela...
if not exist "%SystemRoot%\System32\desk.cpl" (
    echo [ERRO] desk.cpl nao encontrado.
    goto :fim
)
start "" control.exe desk.cpl
if errorlevel 1 (
    echo [ERRO] Falha ao abrir as configuracoes de tela.
    goto :fim
)
echo [OK] Configuracoes de display abertas.
echo [Dica] Alternativa moderna: ms-settings:display
echo Feito.
:fim
echo.
pause