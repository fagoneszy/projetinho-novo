:: ============================================================
:: BATLAB | PingTest.bat | v1.0.0
:: @desc      Ping parametrizado para o host informado como argumento
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PingTest
echo ============================================
echo  BATLAB - PingTest
echo ============================================
set "HOST=%~1"
if not defined HOST set /p "HOST=Host alvo (ex.: google.com): "
if not defined HOST (echo [ERRO] Nenhum host informado. & goto :fim)
echo Ping com 4 pacotes em %HOST%...
echo Aguarde a resposta de cada pacote.
echo.
ping -n 4 %HOST%
if errorlevel 1 (echo [!] %HOST% nao respondeu ao ping. & goto :fim)
echo.
echo [OK] %HOST% respondeu ao ping.
echo Feito.
:fim
echo.
pause
