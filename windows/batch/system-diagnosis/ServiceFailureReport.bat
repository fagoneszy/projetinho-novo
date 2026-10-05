:: ============================================================
:: BATLAB | ServiceFailureReport.bat | v1.0.0
:: @desc      Servicos que falharam recentemente
:: @category  system-diagnosis
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes none
:: @deletes none
:: @registry none
:: @services read
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ServiceFailureReport
echo ============================================
echo  BATLAB - ServiceFailureReport
echo ============================================
powershell -NoProfile -Command "Write-Host 'Falhas de servicos (7 dias):'; try { $e=@(Get-WinEvent -FilterHashtable @{LogName='System';ProviderName='Service Control Manager';Id=7000,7001,7009,7011,7022,7023,7024,7026; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 20 -ErrorAction Stop); if($e.Count -eq 0){ Write-Host '  (nenhuma falha registrada)' } else { $e | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | evento '+$_.Id); Write-Host ('    '+$m) } } } catch { Write-Host '  (nenhuma falha registrada)' }; Write-Host ''; Write-Host 'Servicos automaticos parados agora:'; try { $s=@(Get-Service | Where-Object { $_.StartType -eq 'Automatic' -and $_.Status -eq 'Stopped' }); if($s.Count -eq 0){ Write-Host '  (nenhum)' } else { $s | ForEach-Object { Write-Host ('  '+$_.Name+' - '+$_.DisplayName) } } } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
