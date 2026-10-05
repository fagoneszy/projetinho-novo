:: ============================================================
:: BATLAB | SystemLoadMonitor.bat | v1.0.0
:: @desc      Monitor de carga do sistema
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
title BATLAB - SystemLoadMonitor
echo ============================================
echo  BATLAB - SystemLoadMonitor
echo ============================================
powershell -NoProfile -Command "Write-Host 'Carga do sistema:'; try { $c=Get-CimInstance Win32_PerfFormattedData_PerfOS_Processor -ErrorAction Stop | Where-Object { $_.Name -eq '_Total' }; Write-Host ('  CPU: '+$c.PercentProcessorTime+' em 100'); if($c.PercentProcessorTime -gt 80){ Write-Host '    [ALERTA] CPU alta' } else { Write-Host '    [OK] CPU normal' } } catch { Write-Host '  CPU: (contador indisponivel)' }; try { $o=Get-CimInstance Win32_OperatingSystem -ErrorAction Stop; $p=[math]::Round($o.FreePhysicalMemory/$o.TotalVisibleMemorySize*100); Write-Host ('  memoria livre: '+$p+' em 100'); if($p -lt 15){ Write-Host '    [ALERTA] memoria baixa' } else { Write-Host '    [OK] memoria normal' } } catch { Write-Host '  memoria: (indisponivel)' }; try { $d=Get-CimInstance Win32_PerfFormattedData_PerfDisk_PhysicalDisk -ErrorAction Stop | Where-Object { $_.Name -eq '_Total' }; Write-Host ('  fila de disco: '+$d.CurrentDiskQueueLength+' | atividade '+$d.PercentDiskTime+' em 100'); if($d.CurrentDiskQueueLength -gt 2){ Write-Host '    [ALERTA] disco sobrecarregado' } else { Write-Host '    [OK] disco normal' } } catch { Write-Host '  disco: (contador indisponivel)' }; Write-Host ''; Write-Host 'Top 5 processos por memoria:'; try { Get-Process -ErrorAction Stop | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 | ForEach-Object { Write-Host ('  '+$_.Name+' | '+[math]::Round($_.WorkingSet64/1MB)+' MB') } } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
