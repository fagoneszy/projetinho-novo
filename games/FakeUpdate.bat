:: ============================================================
:: BATLAB | FakeUpdate.bat | v1.0.0
:: @desc      Tela falsa de atualizacao do Windows - brincadeira
:: @category  games
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FakeUpdate
echo ============================================
echo  BATLAB - FakeUpdate
echo ============================================
echo [AVISO] ATUALIZACAO FALSA - brincadeira do BATLAB. Nada sera instalado.
setlocal EnableDelayedExpansion
for /l %%i in (0,10,100) do (
    set /a PCT=%%i
    cls
    echo.
    echo      Atualizacao do Windows
    echo      Instalando atualizacoes... !PCT!%% concluido.
    echo      Nao desligue o computador.
    timeout /t 1 /nobreak >nul
)
cls
echo      Atualizacao concluida com sucesso!
echo      Nada foi alterado - era so uma brincadeira.
echo.
pause