:: ============================================================
:: BATLAB | CriticalEvents.bat | v1.0.0
:: @desc      Mostra eventos criticos recentes
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
title BATLAB - CriticalEvents
echo ============================================
echo  BATLAB - CriticalEvents
echo ============================================
powershell -NoProfile -Command "Write-Host 'Eventos criticos dos ultimos 7 dias:'; try { $e=@(Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 500 -ErrorAction Stop); if($e.Count -eq 0){ Write-Host '  (nenhum evento)' } else { Write-Host ('  amostra: '+$e.Count+' evento(s)'); Write-Host ''; Write-Host 'Por origem (top 10):'; $e | Group-Object ProviderName | Sort-Object Count -Descending | Select-Object -First 10 | ForEach-Object { Write-Host ('  '+$_.Count+' x '+$_.Name) }; Write-Host ''; Write-Host 'Ultimos 10:'; $e | Select-Object -First 10 | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | evento '+$_.Id+' | '+$m) } } } catch { Write-Host '  (log do sistema indisponivel)' }"
:fim
echo.
pause
endlocal
