:: ============================================================
:: BATLAB | UpdateHistoryReport.bat | v1.0.0
:: @desc      Historico de atualizacoes instaladas
:: @category  windows-update
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
title BATLAB - UpdateHistoryReport
echo ============================================
echo  BATLAB - UpdateHistoryReport
echo ============================================
powershell -NoProfile -Command "Write-Host 'Atualizacoes instaladas (hotfixes, mais recentes primeiro):'; try { $h=@(Get-HotFix -ErrorAction Stop | Sort-Object InstalledOn -Descending); if($h.Count -eq 0){ Write-Host '  (nenhum hotfix registrado)' } else { $h | Select-Object -First 15 | ForEach-Object { Write-Host ('  '+$_.HotFixID+' | '+$_.InstalledOn+' | '+$_.Description) } } } catch { Write-Host '  (falha ao ler hotfixes)' }; Write-Host ''; Write-Host 'Ultimas atualizacoes aplicadas (log do Windows Update):'; try { $e=@(Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-WindowsUpdateClient/Operational'; Id=19} -MaxEvents 10 -ErrorAction SilentlyContinue); if($e.Count -eq 0){ Write-Host '  (nenhum evento de instalacao registrado)' } else { $e | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | '+$m) } } } catch { Write-Host '  (log indisponivel)' }"
:fim
echo.
pause
endlocal
