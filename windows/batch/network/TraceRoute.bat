:: ============================================================
:: BATLAB | TraceRoute.bat | v1.0.0
:: @desc      Rastreia as rotas ate um host com tracert -d
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TraceRoute
echo ============================================
echo  BATLAB - TraceRoute
echo ============================================
set "HOST=%~1"
if not defined HOST set /p "HOST=Host alvo (ex.: google.com): "
if not defined HOST (echo [ERRO] Nenhum host informado. & goto :fim)
echo Rastreando rotas ate %HOST% com tracert -d...
echo A opcao -d evita resolver nomes (mais rapido).
echo.
tracert -d %HOST%
if errorlevel 1 (echo [!] Rastreamento falhou para %HOST%. & goto :fim)
echo.
echo [i] Cada linha mostra um salto ate o destino.
echo [i] * * * significa que o salto nao respondeu.
echo Feito.
:fim
echo.
pause
