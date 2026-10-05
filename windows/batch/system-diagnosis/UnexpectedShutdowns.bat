:: ============================================================
:: BATLAB | UnexpectedShutdowns.bat | v1.0.0
:: @desc      Identifica desligamentos inesperados
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
title BATLAB - UnexpectedShutdowns
echo ============================================
echo  BATLAB - UnexpectedShutdowns
echo ============================================
powershell -NoProfile -Command "Write-Host 'Desligamentos inesperados (30 dias):'; try { Get-WinEvent -FilterHashtable @{LogName='System';Id=6008; StartTime=(Get-Date).AddDays(-30)} -MaxEvents 10 -ErrorAction Stop | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM/yyyy HH:mm')); Write-Host ('    '+$m) } } catch { Write-Host '  (nenhum nos ultimos 30 dias)' }; Write-Host ''; Write-Host 'Sistema reiniciou sem desligamento limpo:'; try { $k=@(Get-WinEvent -FilterHashtable @{LogName='System';Id=41; StartTime=(Get-Date).AddDays(-30)} -MaxEvents 5 -ErrorAction Stop); if($k.Count -eq 0){ Write-Host '  (nenhum)' } else { $k | ForEach-Object { Write-Host ('  '+$_.TimeCreated.ToString('dd/MM/yyyy HH:mm')+' | evento 41 de energia') } } } catch { Write-Host '  (nenhum)' }; Write-Host ''; Write-Host 'Ultima inicializacao:'; try { Write-Host ('  '+(Get-CimInstance Win32_OperatingSystem -ErrorAction Stop).LastBootUpTime.ToString('dd/MM/yyyy HH:mm')) } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
