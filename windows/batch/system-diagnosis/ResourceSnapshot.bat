:: ============================================================
:: BATLAB | ResourceSnapshot.bat | v1.0.0
:: @desc      Tira snapshot de CPU/RAM/disco
:: @category  system-diagnosis
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes temp
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Arquivo temporario na pasta TEMP do usuario (batlab-*.txt)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ResourceSnapshot
echo ============================================
echo  BATLAB - ResourceSnapshot
echo ============================================
powershell -NoProfile -Command "$p=$env:TEMP+'\batlab-resource.txt'; $l=@(); $l+=('captura: '+(Get-Date).ToString('dd/MM/yyyy HH:mm:ss')); try { $c=Get-CimInstance Win32_PerfFormattedData_PerfOS_Processor -ErrorAction Stop | Where-Object { $_.Name -eq '_Total' }; $l+=('cpu: '+$c.PercentProcessorTime+' em 100') } catch { $l+=('cpu: indisponivel') }; try { $o=Get-CimInstance Win32_OperatingSystem -ErrorAction Stop; $l+=('memoria livre: '+[math]::Round($o.FreePhysicalMemory/1MB,1)+' GB de '+[math]::Round($o.TotalVisibleMemorySize/1MB,1)+' GB') } catch { $l+=('memoria: indisponivel') }; try { Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' -ErrorAction Stop | ForEach-Object { $l+=('disco '+$_.DeviceID+' livre '+[math]::Round($_.FreeSpace/1GB,1)+' GB de '+[math]::Round($_.Size/1GB,1)+' GB') } } catch { $l+=('disco: indisponivel') }; [IO.File]::WriteAllText($p,($l -join [char]10)); Write-Host 'Snapshot de recursos:'; $l | ForEach-Object { Write-Host ('  '+$_) }; Write-Host ''; Write-Host ('Salvo em: '+$p)"
:fim
echo.
pause
endlocal
