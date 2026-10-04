:: ============================================================
:: BATLAB | OpenMouseSettings.bat | v1.0.0
:: @desc      Abre as configuracoes do mouse (main.cpl)
:: @category  everyday
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenMouseSettings
echo ============================================
echo  BATLAB - OpenMouseSettings
echo ============================================
echo Abrindo as configuracoes do mouse...
if not exist "%SystemRoot%\System32\main.cpl" (
    echo [ERRO] main.cpl nao encontrado.
    goto :fim
)
start "" control.exe main.cpl
if errorlevel 1 (
    echo [ERRO] Falha ao abrir o painel do mouse.
    goto :fim
)
echo [OK] Painel de propriedades do mouse aberto.
echo [Dica] Alternativa moderna: ms-settings:mouse
echo Feito.
:fim
echo.
pause