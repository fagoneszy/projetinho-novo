:: ============================================================
:: BATLAB | SystemReport.bat | v1.0.0
:: @desc      Gera um relatorio completo do sistema em TXT
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      Apague o arquivo TXT do relatorio
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SystemReport
echo ============================================
echo  BATLAB - SystemReport
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "D=%%i"
set "OUT=%~1"
if not defined OUT set "OUT=%CD%\relatorio_sistema_%D%.txt"
echo Gerando relatorio completo do sistema...
echo Destino: %OUT%
echo [INFO] Inclui systeminfo, ipconfig, discos, memoria, CPU e processos.
echo.
echo ========== RELATORIO DE SISTEMA ========== > "%OUT%"
echo Data: %DATE% %TIME% >> "%OUT%"
echo. >> "%OUT%"
echo ---------- SYSTEMINFO ---------- >> "%OUT%"
systeminfo >> "%OUT%" 2>&1
echo. >> "%OUT%"
echo ---------- IPCONFIG /ALL ---------- >> "%OUT%"
ipconfig /all >> "%OUT%" 2>&1
echo. >> "%OUT%"
echo ---------- DISCOS ---------- >> "%OUT%"
powershell -NoProfile -Command "Get-CimInstance Win32_LogicalDisk | Select-Object DeviceID,Size,FreeSpace | Format-Table -AutoSize" >> "%OUT%" 2>&1
echo. >> "%OUT%"
echo ---------- MEMORIA ---------- >> "%OUT%"
powershell -NoProfile -Command "Get-CimInstance Win32_PhysicalMemory | Select-Object BankLabel,Capacity,Speed | Format-Table -AutoSize" >> "%OUT%" 2>&1
echo. >> "%OUT%"
echo ---------- PROCESSADOR ---------- >> "%OUT%"
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object Name,NumberOfCores,NumberOfLogicalProcessors | Format-Table -AutoSize" >> "%OUT%" 2>&1
echo. >> "%OUT%"
echo ---------- TOP 20 PROCESSOS ---------- >> "%OUT%"
powershell -NoProfile -Command "Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 20 Id,ProcessName | Format-Table -AutoSize" >> "%OUT%" 2>&1
if exist "%OUT%" (echo Feito. Relatorio gerado: %OUT%) else (echo [ERRO] Falha ao gravar o relatorio.)
:fim
echo.
pause
