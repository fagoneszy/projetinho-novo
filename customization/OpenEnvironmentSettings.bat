:: ============================================================
:: BATLAB | OpenEnvironmentSettings.bat | v1.0.0
:: @desc      Abre as configuracoes de variaveis de ambiente
:: @category  customization
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenEnvironmentSettings
echo ============================================
echo  BATLAB - OpenEnvironmentSettings
echo ============================================
echo Abrindo as Propriedades do Sistema (sysdm.cpl)...
echo [Dica] Na aba Avancado esta o botao Variaveis de Ambiente.
start "" sysdm.cpl
if errorlevel 1 (
    echo [!] Falha com sysdm.cpl; tentando pelo Painel de Controle...
    control sysdm.cpl
    if errorlevel 1 (echo [ERRO] Nao foi possivel abrir as configuracoes. & goto :fim)
)
echo Propriedades do Sistema solicitadas.
echo Feito.
:fim
echo.
pause