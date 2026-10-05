:: ============================================================
:: BATLAB | OpenControlPanel.bat | v1.0.0
:: @desc      Abre o Painel de Controle
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenControlPanel
echo ============================================
echo  BATLAB - OpenControlPanel
echo ============================================
echo Abrindo o Painel de Controle classico...
start "" control.exe
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir o Painel de Controle.
    goto :fim
)
echo Painel de Controle solicitado.
echo [Dica] No Windows 11 alguns itens redirecionam para Configuracoes.
echo Feito.
:fim
echo.
pause
