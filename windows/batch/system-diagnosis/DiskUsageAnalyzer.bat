:: ============================================================
:: BATLAB | DiskUsageAnalyzer.bat | v1.0.0
:: @desc      Analisa uso do armazenamento
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
title BATLAB - DiskUsageAnalyzer
echo ============================================
echo  BATLAB - DiskUsageAnalyzer
echo ============================================
powershell -NoProfile -Command "Write-Host 'Espaco dos discos logicos:'; try { Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' -ErrorAction Stop | ForEach-Object { $t=[math]::Round($_.Size/1GB,1); $l=[math]::Round($_.FreeSpace/1GB,1); $p=0; if($_.Size -gt 0){ $p=[math]::Round($_.FreeSpace/$_.Size*100) }; Write-Host ('  '+$_.DeviceID+' total '+$t+' GB | livre '+$l+' GB ('+$p+' em 100)'); if($p -lt 15){ Write-Host '    [ALERTA] menos de 15 em 100 livres' } } } catch { Write-Host '  (indisponivel)' }; Write-Host ''; Write-Host 'Volumes removiveis:'; try { $r=@(Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=2' -ErrorAction Stop); if($r.Count -eq 0){ Write-Host '  (nenhum conectado)' } else { $r | ForEach-Object { $l=[math]::Round($_.FreeSpace/1GB,1); Write-Host ('  '+$_.DeviceID+' | livre '+$l+' GB') } } } catch { Write-Host '  (nenhum conectado)' }; Write-Host ''; Write-Host 'Resumo:'; try { $d=@(Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' -ErrorAction Stop); $s=0; $f=0; $d | ForEach-Object { $s=$s+$_.Size; $f=$f+$_.FreeSpace }; Write-Host ('  total '+[math]::Round($s/1GB,1)+' GB | livre '+[math]::Round($f/1GB,1)+' GB') } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
