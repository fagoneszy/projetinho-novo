:: ============================================================
:: BATLAB | HighCPUDetector.bat | v1.0.0
:: @desc      Detecta CPU em uso anormal
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
title BATLAB - HighCPUDetector
echo ============================================
echo  BATLAB - HighCPUDetector
echo ============================================
powershell -NoProfile -Command "Write-Host 'Uso de CPU agora:'; try { $c=Get-CimInstance Win32_PerfFormattedData_PerfOS_Processor -ErrorAction Stop | Where-Object { $_.Name -eq '_Total' }; $v=$c.PercentProcessorTime; Write-Host ('  CPU total (0 a 100): '+$v); if($v -gt 80){ Write-Host '  [ALERTA] uso de CPU acima do normal' } else { Write-Host '  [OK] uso de CPU dentro do esperado' } } catch { Write-Host '  (contador de CPU indisponivel)' }; Write-Host ''; Write-Host 'Processos que mais consomem CPU:'; try { Get-Process -ErrorAction Stop | Sort-Object CPU -Descending | Select-Object -First 5 | ForEach-Object { $c=0; if($_.CPU){ $c=[int]$_.CPU }; Write-Host ('  '+$_.Name+' | PID '+$_.Id+' | '+$c+' s') } } catch { Write-Host '  (indisponivel)' }; Write-Host ''; Write-Host 'Media de CPU dos nucleos:'; try { Get-CimInstance Win32_PerfFormattedData_PerfOS_Processor -ErrorAction Stop | Where-Object { $_.Name -ne '_Total' } | ForEach-Object { Write-Host ('  nucleo '+$_.Name+': '+$_.PercentProcessorTime+' em 100') } } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
