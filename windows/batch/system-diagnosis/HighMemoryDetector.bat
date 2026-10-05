:: ============================================================
:: BATLAB | HighMemoryDetector.bat | v1.0.0
:: @desc      Detecta consumo anormal de RAM
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
title BATLAB - HighMemoryDetector
echo ============================================
echo  BATLAB - HighMemoryDetector
echo ============================================
powershell -NoProfile -Command "Write-Host 'Memoria fisica:'; try { $o=Get-CimInstance Win32_OperatingSystem -ErrorAction Stop; $t=[math]::Round($o.TotalVisibleMemorySize/1MB,1); $l=[math]::Round($o.FreePhysicalMemory/1MB,1); $p=[math]::Round($o.FreePhysicalMemory/$o.TotalVisibleMemorySize*100); Write-Host ('  total: '+$t+' GB | livre: '+$l+' GB ('+$p+' em 100)'); if($p -lt 15){ Write-Host '  [ALERTA] memoria livre baixa' } else { Write-Host '  [OK] memoria livre suficiente' } } catch { Write-Host '  (indisponivel)' }; Write-Host ''; Write-Host 'Processos que mais usam memoria:'; try { Get-Process -ErrorAction Stop | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 | ForEach-Object { Write-Host ('  '+$_.Name+' | '+[math]::Round($_.WorkingSet64/1MB)+' MB') } } catch { Write-Host '  (indisponivel)' }; Write-Host ''; Write-Host 'Memoria de arquivo (swap):'; try { $c=Get-CimInstance Win32_PageFileUsage -ErrorAction Stop; if($c){ $c | ForEach-Object { Write-Host ('  '+$_.Name+' | usado '+$_.CurrentUsage+' MB de '+$_.AllocatedBaseSize+' MB') } } else { Write-Host '  (sem pagina de arquivo ativa)' } } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
