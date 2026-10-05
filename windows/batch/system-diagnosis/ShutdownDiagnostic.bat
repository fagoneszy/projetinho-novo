:: ============================================================
:: BATLAB | ShutdownDiagnostic.bat | v1.0.0
:: @desc      Analisa desligamentos lentos
:: @category  system-diagnosis
:: @platform  windows
:: @admin     yes
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
title BATLAB - ShutdownDiagnostic
echo ============================================
echo  BATLAB - ShutdownDiagnostic
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [AVISO] Sem administrador o log de desligamento pode nao abrir.
  echo         O historico de desligamentos continua disponivel.
  echo.
)
powershell -NoProfile -Command "Write-Host 'Desligamentos registrados:'; try { Get-WinEvent -FilterHashtable @{LogName='System';Id=6006} -MaxEvents 6 -ErrorAction Stop | ForEach-Object { Write-Host ('  '+$_.TimeCreated.ToString('dd/MM/yyyy HH:mm')+' | desligamento do sistema') } } catch { Write-Host '  (historico indisponivel)' }; Write-Host ''; Write-Host 'Tempo de desligamento (log de diagnostico):'; try { Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-Diagnostics-Performance/Operational';Id=200} -MaxEvents 3 -ErrorAction Stop | ForEach-Object { $x=[xml]$_.ToXml(); foreach($d in $x.Event.EventData.Data){ if($d.Name -match 'Shutdown|Degradation'){ Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | '+$d.Name+' = '+$d.'#text') } } } } catch { Write-Host '  (indisponivel - rode como administrador)' }; Write-Host ''; Write-Host 'Servicos que demoraram a encerrar (7 dias):'; try { $e=@(Get-WinEvent -FilterHashtable @{LogName='System';ProviderName='Service Control Manager';Id=7011,7022; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 5 -ErrorAction Stop); if($e.Count -eq 0){ Write-Host '  (nenhum)' } else { $e | ForEach-Object { Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | evento '+$_.Id) } } } catch { Write-Host '  (nenhum nos ultimos 7 dias)' }"
:fim
echo.
pause
endlocal
