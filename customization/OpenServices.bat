:: ============================================================
:: BATLAB | OpenServices.bat | v1.0.0
:: @desc      Abre o console de Servicos
:: @category  customization
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenServices
echo ============================================
echo  BATLAB - OpenServices
echo ============================================
echo Abrindo o console de Servicos do Windows...
start "" "%WINDIR%\System32\services.msc"
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir o console de Servicos.
    goto :fim
)
echo Console de Servicos solicitado.
echo [Dica] Alteracoes em servicos podem exigir executar como administrador.
echo Feito.
:fim
echo.
pause