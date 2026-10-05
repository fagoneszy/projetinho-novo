:: ============================================================
:: BATLAB | DNSFlush.bat | v1.0.0
:: @desc      Limpa o cache de resolucao DNS do Windows
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DNSFlush
echo ============================================
echo  BATLAB - DNSFlush
echo ============================================
echo Limpando o cache DNS local do Windows...
echo Antes: consultas podem usar IPs antigos.
echo Depois: novas consultas vao direto ao servidor DNS.
echo.
ipconfig /flushdns
if errorlevel 1 (echo [!] Falha ao limpar o cache DNS. & goto :fim)
echo.
echo [OK] Cache DNS limpo com sucesso.
echo [i] Use DNSLookup.bat para conferir uma resolucao.
echo Feito.
:fim
echo.
pause