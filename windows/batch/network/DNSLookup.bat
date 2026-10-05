:: ============================================================
:: BATLAB | DNSLookup.bat | v1.0.0
:: @desc      Consulta os registros DNS de um dominio informado
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DNSLookup
echo ============================================
echo  BATLAB - DNSLookup
echo ============================================
set "DOM=%~1"
if not defined DOM set /p "DOM=Dominio (ex.: google.com): "
if not defined DOM (echo [ERRO] Nenhum dominio informado. & goto :fim)
echo Consultando registros DNS de %DOM%...
echo Servidor DNS usado pelo sistema.
echo.
nslookup %DOM%
if errorlevel 1 (echo [!] Consulta falhou para %DOM%. & goto :fim)
echo.
echo [i] Registros A, AAAA, MX e CNAME aparecem acima.
echo Feito.
:fim
echo.
pause
