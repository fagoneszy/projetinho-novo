:: ============================================================
:: BATLAB | RecentFilesAudit.bat | v1.0.0
:: @desc      Arquivos recentes do usuario (%APPDATA%\Microsoft\Windows\Recent)
:: @category  diagnostics
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RecentFilesAudit
echo ============================================
echo  BATLAB - RecentFilesAudit
echo ============================================
set "RECENT=%APPDATA%\Microsoft\Windows\Recent"
if not exist "%RECENT%" (
    echo [ERRO] Pasta de itens recentes nao encontrada:
    echo   %RECENT%
    goto :fim
)
echo Arquivos recentes do usuario (mais novos primeiro):
echo   %RECENT%
echo.
dir /a /o-d "%RECENT%"
if errorlevel 1 (
    echo [AVISO] Pasta vazia ou sem permissao de leitura.
    goto :fim
)
echo.
echo [OK] Cada .lnk aponta para o documento realmente aberto.
echo [Dica] Destino do atalho: botao direito > Propriedades.
echo Feito.
:fim
echo.
pause