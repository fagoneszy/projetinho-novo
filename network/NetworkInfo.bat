:: ============================================================
:: BATLAB | NetworkInfo.bat | v1.0.0
:: @desc      Exibe todas as configuracoes de rede com ipconfig /all
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NetworkInfo
echo ============================================
echo  BATLAB - NetworkInfo
echo ============================================
echo Exibindo todas as configuracoes de rede do host...
echo Host: %COMPUTERNAME%
echo Data: %DATE% %TIME%
echo.
ipconfig /all
if errorlevel 1 (echo [!] ipconfig /all retornou erro. & goto :fim)
echo.
echo [i] Adaptadores, IPv4, IPv6, MAC e DNS aparecem acima.
echo [i] Resumo rapido: IPInfo.bat e GatewayInfo.bat.
echo Feito.
:fim
echo.
pause