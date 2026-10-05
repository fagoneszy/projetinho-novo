:: ============================================================
:: BATLAB | AutoReportGenerator.bat | v1.0.0
:: @desc      Gera relatorio de sistema em arquivo de texto
:: @category  automation
:: @admin     no
:: @risk      low
:: @undo      Apague o arquivo Relatorio_*.txt
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoReportGenerator
echo ============================================
echo  BATLAB - AutoReportGenerator
echo ============================================
set "OUT=%~dp0Relatorio_%date:/=-%_%time::=%.txt"
echo Gerando relatorio (systeminfo demora um pouco)...
> "%OUT%" echo Relatorio gerado em %date% %time%
>> "%OUT%" echo ============================================
systeminfo >> "%OUT%"
echo( >> "%OUT%"
echo --- IP --- >> "%OUT%"
ipconfig /all >> "%OUT%"
echo( >> "%OUT%"
echo --- Discos --- >> "%OUT%"
powershell -NoProfile -Command "Get-CimInstance Win32_LogicalDisk | Format-Table -AutoSize" >> "%OUT%"
echo Relatorio salvo em:
echo    %OUT%
echo.
pause