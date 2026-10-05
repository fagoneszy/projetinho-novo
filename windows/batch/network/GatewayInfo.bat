:: ============================================================
:: BATLAB | GatewayInfo.bat | v1.0.0
:: @desc      Exibe o gateway padrao usado para saida da rede
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GatewayInfo
echo ============================================
echo  BATLAB - GatewayInfo
echo ============================================
set "GW="
for /f "tokens=1,* delims=:" %%a in ('ipconfig ^| findstr /i "Gateway"') do set "GW=%%b"
if not defined GW (echo [ERRO] Nenhum gateway encontrado. & goto :fim)
echo.
echo Gateway padrao:%GW%
echo Host: %COMPUTERNAME%
echo.
echo [i] E o roteador usado para sair da rede local.
echo [i] Rotas completas: RouteTable.bat.
echo Feito.
:fim
echo.
pause