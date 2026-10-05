:: ============================================================
:: BATLAB | IPInfo.bat | v1.0.0
:: @desc      Exibe o IP local IPv4 e o gateway padrao da rede
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - IPInfo
echo ============================================
echo  BATLAB - IPInfo
echo ============================================
echo === IP local (IPv4) ===
ipconfig | findstr /i "IPv4"
if errorlevel 1 (echo [!] Nenhum IPv4 encontrado. & goto :fim)
echo.
echo === Gateway padrao ===
ipconfig | findstr /i "Gateway"
if errorlevel 1 (echo [!] Nenhum gateway encontrado. & goto :fim)
echo.
echo [i] Use PublicIP.bat para ver o IP visto pela internet.
echo [i] Listagem completa: NetworkInfo.bat.
echo Feito.
:fim
echo.
pause