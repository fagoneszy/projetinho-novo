:: ============================================================
:: BATLAB | MTUTest.bat | v1.0.0
:: @desc      Testa o maior pacote que passa sem fragmentacao na conexao
:: @category  network-advanced
:: @platform windows
:: @admin     no
:: @risk      low
:: @writes    none
:: @deletes   none
:: @registry  none
:: @services  none
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MTUTest
echo ============================================
echo  BATLAB - MTUTest
echo ============================================
echo Este script acha o maior pacote ICMP que passa sem fragmentacao.
echo MTU baixa demais derruba conexoes; o padrao costuma ser 1500 bytes.
echo Uso opcional: MTUTest.bat 1.1.1.1
echo.
set "ALVO=%~1"
if not defined ALVO set "ALVO=8.8.8.8"
set "MELHOR=nenhum"
echo Testando de 1500 ate 1100 bytes com a opcao -f:
for %%s in (1500 1400 1300 1200 1100) do (
    ping -n 1 -f -l %%s %ALVO% >nul 2>&1
    if errorlevel 1 (echo   %%s bytes: FALHOU) else (echo   %%s bytes: OK & set "MELHOR=%%s")
)
echo.
echo Maior MTU que passou: %MELHOR% bytes
echo.
echo [i] Ajuste a MTU correta em Adaptador, Propriedades, Protocolo IPv4.
:fim
echo.
pause
