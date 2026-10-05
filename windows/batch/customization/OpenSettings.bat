:: ============================================================
:: BATLAB | OpenSettings.bat | v1.0.0
:: @desc      Abre as Configuracoes do Windows
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenSettings
echo ============================================
echo  BATLAB - OpenSettings
echo ============================================
echo Abrindo as Configuracoes do Windows...
start "" "ms-settings:"
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir as Configuracoes.
    goto :fim
)
echo Configuracoes solicitadas pelo protocolo ms-settings:.
echo [Dica] Use a barra de pesquisa para achar qualquer opcao.
echo Feito.
:fim
echo.
pause
