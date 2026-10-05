:: ============================================================
:: BATLAB | ClearDNSCache.bat | v1.0.0
:: @desc      Limpa o cache de DNS
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      N/A - o cache DNS e reconstruido nas proximas consultas
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ClearDNSCache
echo ============================================
echo  BATLAB - ClearDNSCache
echo ============================================
echo Limpando o cache de DNS local do Windows...
echo [INFO] O Windows volta a consultar os servidores de DNS.
echo [INFO] Util quando voce mudou de rede ou o DNS nao resolve.
echo [INFO] Nenhum dado de configuracao e alterado.
echo [INFO] Servidores DNS das configuracoes continuam os mesmos.
echo.
ipconfig /flushdns
echo.
if errorlevel 1 (echo [ERRO] Falha ao limpar o cache DNS.) else (echo Feito. Cache de DNS esvaziado.)
:fim
echo.
pause