:: ============================================================
:: BATLAB | IOLatencyReport.bat | v1.0.0
:: @desc      Diagnostico de latencia de I/O
:: @category  system-diagnosis
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - IOLatencyReport
echo ============================================
echo  BATLAB - IOLatencyReport
echo ============================================
powershell -NoProfile -Command "Write-Host 'Latencia de E/S (disco total):'; try { $d=Get-CimInstance Win32_PerfFormattedData_PerfDisk_PhysicalDisk -ErrorAction Stop | Where-Object { $_.Name -eq '_Total' }; if(-not $d){ Write-Host '  (contador indisponivel)' } else { $r=[math]::Round($d.AvgDisksecPerRead*1000,1); $w=[math]::Round($d.AvgDisksecPerWrite*1000,1); $t=[math]::Round($d.AvgDisksecPerTransfer*1000,1); Write-Host ('  leitura '+$r+' ms | escrita '+$w+' ms | transferencia '+$t+' ms'); Write-Host ('  atividade '+$d.PercentDiskTime+' em 100'); if($r -gt 10 -or $w -gt 10){ Write-Host '  [ALERTA] latencia alta (acima de 10 ms)' } else { Write-Host '  [OK] latencia normal' } } } catch { Write-Host '  (contador indisponivel)' }; Write-Host ''; Write-Host 'Latencia por volume:'; try { Get-CimInstance Win32_PerfFormattedData_PerfDisk_PhysicalDisk -ErrorAction Stop | Where-Object { $_.Name -like '0_*' } | ForEach-Object { $r=[math]::Round($_.AvgDisksecPerRead*1000,1); $w=[math]::Round($_.AvgDisksecPerWrite*1000,1); Write-Host ('  '+$_.Name+' | leitura '+$r+' ms | escrita '+$w+' ms') } } catch { Write-Host '  (contador indisponivel)' }; Write-Host ''; Write-Host 'Discos fixos:'; try { Get-PhysicalDisk -ErrorAction Stop | ForEach-Object { Write-Host ('  '+$_.FriendlyName+' | '+$_.HealthStatus+' | '+$_.MediaType) } } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
