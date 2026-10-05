:: ============================================================
:: BATLAB | FakeLoading.bat | v1.0.0
:: @desc      Barra de progresso falsa - brincadeira
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FakeLoading
echo ============================================
echo  BATLAB - FakeLoading
echo ============================================
echo [AVISO] Barra de progresso falsa - brincadeira do BATLAB.
setlocal EnableDelayedExpansion
for /l %%i in (0,10,100) do (
    set /a PCT=%%i
    cls
    echo.
    echo      Carregando componentes... !PCT!%%
    timeout /t 1 /nobreak >nul
)
cls
echo      Concluido!
echo.
pause
