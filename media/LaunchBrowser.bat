:: ============================================================
:: BATLAB | LaunchBrowser.bat | v1.0.0
:: @desc      Abre o navegador padrao
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LaunchBrowser
echo ============================================
echo  BATLAB - LaunchBrowser
echo ============================================
set "URL=https://www.google.com"
echo Abrindo o navegador padrao do Windows:
echo   %URL%
start "" "%URL%"
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir o navegador padrao.
    goto :fim
)
echo Navegador solicitado.
echo [Dica] O Windows usa o navegador definido como padrao.
echo Feito.
:fim
echo.
pause