:: ============================================================
:: BATLAB | SystemInfo.bat | v1.0.0
:: @desc      Informacoes completas do computador
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SystemInfo
echo ============================================
echo  BATLAB - SystemInfo
echo ============================================
echo Coletando informacoes completas do computador...
echo [INFO] Pode demorar de 5 a 30 segundos.
echo [INFO] Inclui nome do host, sistema, rede, memoria e dominio.
echo [INFO] Os nomes de rede podem demorar mais para aparecer.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
systeminfo
echo.
if errorlevel 1 (echo [ERRO] Falha ao executar systeminfo.) else (echo Feito. Informacoes acima.)
:fim
echo.
pause