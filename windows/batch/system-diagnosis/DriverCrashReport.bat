:: ============================================================
:: BATLAB | DriverCrashReport.bat | v1.0.0
:: @desc      Procura indicios de falha de driver
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
title BATLAB - DriverCrashReport
echo ============================================
echo  BATLAB - DriverCrashReport
echo ============================================
powershell -NoProfile -Command "Write-Host 'Dispositivos com problema de driver:'; try { $d=@(Get-CimInstance Win32_PnPEntity -ErrorAction Stop | Where-Object { $_.ConfigManagerErrorCode -ne 0 }); if($d.Count -eq 0){ Write-Host '  (nenhum)' } else { $d | ForEach-Object { Write-Host ('  '+$_.Name+' | codigo '+$_.ConfigManagerErrorCode) } } } catch { Write-Host '  (indisponivel)' }; Write-Host ''; Write-Host 'Driver que falhou ao carregar (evento 219):'; try { Get-WinEvent -FilterHashtable @{LogName='System';Id=219; StartTime=(Get-Date).AddDays(-30)} -MaxEvents 10 -ErrorAction Stop | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM/yyyy HH:mm')+' | '+$m) } } catch { Write-Host '  (nenhum nos ultimos 30 dias)' }; Write-Host ''; Write-Host 'Ultimos drivers instalados:'; try { $p=@(Get-CimInstance Win32_PnPSignedDriver -ErrorAction Stop | Where-Object { $_.DeviceName } | Sort-Object DriverDate -Descending | Select-Object -First 5); if($p.Count -eq 0){ Write-Host '  (indisponivel)' } else { $p | ForEach-Object { Write-Host ('  '+$_.DeviceName+' | '+$_.DriverVersion) } } } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
