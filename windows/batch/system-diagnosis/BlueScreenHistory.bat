:: ============================================================
:: BATLAB | BlueScreenHistory.bat | v1.0.0
:: @desc      Localiza evidencias de BSOD
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
title BATLAB - BlueScreenHistory
echo ============================================
echo  BATLAB - BlueScreenHistory
echo ============================================
powershell -NoProfile -Command "Write-Host 'Registros de BSOD no evento do sistema:'; try { Get-WinEvent -FilterHashtable @{LogName='System';ProviderName='Microsoft-Windows-WER-SystemErrorReporting'} -MaxEvents 10 -ErrorAction Stop | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM/yyyy HH:mm')); Write-Host ('    '+$m) } } catch { Write-Host '  (nenhum registro encontrado)' }; Write-Host ''; Write-Host 'Arquivos de minidump:'; try { $f=@(Get-ChildItem -LiteralPath 'C:\Windows\Minidump' -Filter '*.dmp' -ErrorAction Stop | Sort-Object LastWriteTime -Descending); if($f.Count -eq 0){ Write-Host '  (pasta vazia)' } else { $f | Select-Object -First 10 | ForEach-Object { Write-Host ('  '+$_.Name+' | '+$_.LastWriteTime.ToString('dd/MM/yyyy HH:mm')+' | '+[math]::Round($_.Length/1KB)+' KB') } } } catch { Write-Host '  (pasta de minidumps indisponivel)' }; Write-Host ''; Write-Host 'Falhas de hardware registradas:'; try { $l=@(Get-WinEvent -FilterHashtable @{LogName='System';ProviderName='Microsoft-Windows-LiveKernelEvent'} -MaxEvents 5 -ErrorAction Stop); if($l.Count -eq 0){ Write-Host '  (nenhuma)' } else { $l | ForEach-Object { Write-Host ('  '+$_.TimeCreated.ToString('dd/MM/yyyy')+' | evento '+$_.Id) } } } catch { Write-Host '  (nenhuma)' }"
:fim
echo.
pause
endlocal
