:: ============================================================
:: BATLAB | NetworkReport.bat | v1.0.0
:: @desc      Gera um relatorio TXT com todas as informacoes de rede
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NetworkReport
echo ============================================
echo  BATLAB - NetworkReport
echo ============================================
set "OUT=%~1"
if not defined OUT set "OUT=%CD%\relatorio-rede.txt"
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd HH:mm:ss"') do set "DATA=%%i"
echo Gerando relatorio de rede do host %COMPUTERNAME%...
echo Destino: %OUT%
echo Data: %DATA%
> "%OUT%" echo ============================================================
>>"%OUT%" echo  RELATORIO DE REDE - %COMPUTERNAME%
>>"%OUT%" echo  Gerado em: %DATA%
>>"%OUT%" echo ============================================================
ipconfig /all >>"%OUT%"
echo.>>"%OUT%"
netsh interface show interface >>"%OUT%"
echo.>>"%OUT%"
route print >>"%OUT%"
echo.>>"%OUT%"
ping -n 2 8.8.8.8 >>"%OUT%"
echo.
echo [OK] Relatorio salvo em %OUT%
echo Feito.
echo.
pause
