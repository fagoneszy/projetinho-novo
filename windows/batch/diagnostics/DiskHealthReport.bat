:: ============================================================
:: BATLAB | DiskHealthReport.bat | v1.0.0
:: @desc      Status e SMART dos discos (Get-PhysicalDisk / Win32_DiskDrive)
:: @category  diagnostics
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DiskHealthReport
echo ============================================
echo  BATLAB - DiskHealthReport
echo ============================================
echo == Discos fisicos e saude ==
powershell -NoProfile -Command "Get-PhysicalDisk | Format-Table FriendlyName,MediaType,HealthStatus,OperationalStatus,BusType -AutoSize -Wrap"
if errorlevel 1 echo [AVISO] Get-PhysicalDisk indisponivel nesta maquina.
echo.
echo == Discos via WMI ==
powershell -NoProfile -Command "Get-CimInstance Win32_DiskDrive | Select-Object Model,InterfaceType,Status,Size | Format-Table -AutoSize -Wrap"
if errorlevel 1 echo [AVISO] Falha ao consultar Win32_DiskDrive.
echo.
echo == Espaco em volume ==
powershell -NoProfile -Command "Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Select-Object DeviceID,@{n='LivreGB';e={[math]::Round($_.FreeSpace/1GB,1)}},@{n='TotalGB';e={[math]::Round($_.Size/1GB,1)}} | Format-Table -AutoSize"
if errorlevel 1 echo [AVISO] Falha ao consultar os volumes.
echo.
echo [OK] HealthStatus deve ser "Healthy" e Status do WMI "OK".
echo [!] Qualquer outro valor indica disco em falha.
echo Feito.
echo.
pause
