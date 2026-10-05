:: ============================================================
:: BATLAB | DesktopRefresh.bat | v1.0.0
:: @desc      Atualiza os icones da area de trabalho
:: @category  customization
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DesktopRefresh
echo ============================================
echo  BATLAB - DesktopRefresh
echo ============================================
echo Atualizando os icones da area de trabalho...
ie4uinit.exe -show
set "RC=%ERRORLEVEL%"
if not "%RC%"=="0" (
    echo [!] ie4uinit retornou o codigo %RC%.
    echo [Dica] Use o clique direito na area de trabalho e Atualizar.
    goto :fim
)
echo Icones atualizados.
echo [Dica] Se faltar icone, atualize de novo apos fechar o Explorer.
echo Feito.
:fim
echo.
pause