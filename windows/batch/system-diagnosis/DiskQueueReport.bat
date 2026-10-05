:: ============================================================
:: BATLAB | DiskQueueReport.bat | v1.0.0
:: @desc      Relatorio de fila de disco
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
title BATLAB - DiskQueueReport
echo ============================================
echo  BATLAB - DiskQueueReport
echo ============================================
powershell -NoProfile -Command "Write-Host 'Fila de disco (leitura atual):'; try { Get-CimInstance Win32_PerfFormattedData_PerfDisk_PhysicalDisk -ErrorAction Stop | Where-Object { $_.Name -eq '_Total' -or $_.Name -like '0_*' } | ForEach-Object { Write-Host ('  '+$_.Name+' | fila atual '+$_.CurrentDiskQueueLength+' | fila media '+$_.AvgDiskQueueLength+' | atividade '+$_.PercentDiskTime+' em 100') } } catch { Write-Host '  (contador indisponivel)' }; Write-Host ''; Write-Host 'Amostras do disco total (3 leituras):'; try { 1..3 | ForEach-Object { $t=Get-CimInstance Win32_PerfFormattedData_PerfDisk_PhysicalDisk -ErrorAction Stop | Where-Object { $_.Name -eq '_Total' }; Write-Host ('  leitura '+$_+': fila '+$t.CurrentDiskQueueLength+' | atividade '+$t.PercentDiskTime+' em 100'); Start-Sleep -Seconds 1 } } catch { Write-Host '  (contador indisponivel)' }; Write-Host ''; Write-Host 'Interpretacao:'; try { $t=Get-CimInstance Win32_PerfFormattedData_PerfDisk_PhysicalDisk -ErrorAction Stop | Where-Object { $_.Name -eq '_Total' }; if($t.CurrentDiskQueueLength -gt 2){ Write-Host '  [ALERTA] fila acima de 2: disco sobrecarregado' } else { Write-Host '  [OK] fila dentro do normal' } } catch { Write-Host '  (contador indisponivel)' }"
:fim
echo.
pause
endlocal
