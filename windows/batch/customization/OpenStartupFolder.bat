:: ============================================================
:: BATLAB | OpenStartupFolder.bat | v1.0.0
:: @desc      Abre a pasta de inicializacao (shell:startup)
:: @category  customization
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenStartupFolder
echo ============================================
echo  BATLAB - OpenStartupFolder
echo ============================================
echo Abrindo a pasta de inicializacao (shell:startup)...
explorer "shell:startup"
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir a pasta de inicializacao.
    goto :fim
)
echo Pasta aberta.
echo [Dica] Coloque atalhos .lnk nessa pasta para iniciar com o Windows.
echo Feito.
:fim
echo.
pause