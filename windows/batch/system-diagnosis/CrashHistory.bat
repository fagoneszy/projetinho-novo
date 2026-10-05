:: ============================================================
:: BATLAB | CrashHistory.bat | v1.0.0
:: @desc      Historico de falhas do sistema
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
title BATLAB - CrashHistory
echo ============================================
echo  BATLAB - CrashHistory
echo ============================================
powershell -NoProfile -Command "Write-Host 'Falhas de sistema (30 dias):'; try { Get-WinEvent -FilterHashtable @{LogName='System';Id=1001; StartTime=(Get-Date).AddDays(-30)} -MaxEvents 10 -ErrorAction Stop | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | '+$_.ProviderName); Write-Host ('    '+$m) } } catch { Write-Host '  (nenhuma falha registrada)' }; Write-Host ''; Write-Host 'Reinicios sem desligamento limpo (30 dias):'; try { $k=@(Get-WinEvent -FilterHashtable @{LogName='System';Id=41; StartTime=(Get-Date).AddDays(-30)} -MaxEvents 10 -ErrorAction Stop); Write-Host ('  '+$k.Count+' ocorrencia(s)'); $k | ForEach-Object { Write-Host ('  '+$_.TimeCreated.ToString('dd/MM/yyyy HH:mm')) } } catch { Write-Host '  (nenhuma ocorrencia)' }; Write-Host ''; Write-Host 'Quedas de aplicativos (7 dias):'; try { $a=@(Get-WinEvent -FilterHashtable @{LogName='Application';Id=1000; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 5 -ErrorAction Stop); if($a.Count -eq 0){ Write-Host '  (nenhuma)' } else { $a | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | '+$m) } } } catch { Write-Host '  (nenhuma)' }"
:fim
echo.
pause
endlocal
