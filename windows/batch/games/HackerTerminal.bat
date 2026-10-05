:: ============================================================
:: BATLAB | HackerTerminal.bat | v1.0.0
:: @desc      Simulacao visual de hack - apenas enfeite, nao faz nada
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - HackerTerminal
echo ============================================
echo  BATLAB - HackerTerminal
echo ============================================
echo [AVISO] Isto e apenas uma simulacao visual. Nada e acessado de verdade.
echo.
setlocal EnableDelayedExpansion
for /l %%i in (1,1,6) do (
    echo  [%time%] conectando ao servidor %%i...
    timeout /t 1 /nobreak >nul
)
echo  Bypassing firewall...
timeout /t 2 /nobreak >nul
echo  Acesso concedido ao banco de dados...
timeout /t 2 /nobreak >nul
echo  Exfiltrando dados...
timeout /t 2 /nobreak >nul
echo.
echo  Pronto! (brincadeira - nada foi feito)
echo.
pause
