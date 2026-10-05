:: ============================================================
:: BATLAB | SystemHealthReport.bat | v1.0.0
:: @desc      Relatorio de saude consolidado (disco, RAM, uptime, servicos) em TXT
:: @category  diagnostics
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SystemHealthReport
echo ============================================
echo  BATLAB - SystemHealthReport
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
set "OUTDIR=%TEMP%\BATLAB"
set "OUT=%OUTDIR%\saude-sistema-%D%.txt"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
echo Gerando relatorio consolidado de saude...
echo BATLAB - Relatorio de saude %D% > "%OUT%"
echo. >> "%OUT%"
echo == Disco == >> "%OUT%"
powershell -NoProfile -Command "Get-PhysicalDisk | Format-Table FriendlyName,HealthStatus,OperationalStatus -AutoSize -Wrap" >> "%OUT%"
echo == Memoria == >> "%OUT%"
powershell -NoProfile -Command "$o=Get-CimInstance Win32_OperatingSystem; 'TotalGB: {0:N1}' -f ($o.TotalVisibleMemorySize/1MB); 'LivreGB: {0:N1}' -f ($o.FreePhysicalMemory/1MB)" >> "%OUT%"
echo == Uptime == >> "%OUT%"
powershell -NoProfile -Command "$b=(Get-CimInstance Win32_OperatingSystem).LastBootUpTime; 'Boot: ' + $b.ToString('yyyy-MM-dd HH:mm'); 'Dias ligado: {0:N1}' -f ((New-TimeSpan -Start $b).TotalDays)" >> "%OUT%"
echo == Servicos automaticos parados == >> "%OUT%"
powershell -NoProfile -Command "Get-Service | Where-Object { $_.StartType -eq 'Automatic' -and $_.Status -eq 'Stopped' } | Format-Table Name,DisplayName -AutoSize" >> "%OUT%"
if errorlevel 1 echo [AVISO] Alguma secao nao pode ser lida. >> "%OUT%"
echo [OK] Relatorio gravado em:
echo   %OUT%
echo.
type "%OUT%"
echo.
pause
