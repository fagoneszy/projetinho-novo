:: ============================================================
:: BATLAB | WindowsHealthScore.bat | v1.0.0
:: @desc      Cria um score de saude do Windows
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
title BATLAB - WindowsHealthScore
echo ============================================
echo  BATLAB - WindowsHealthScore
echo ============================================
powershell -NoProfile -Command "$s=100; Write-Host 'Verificacoes:'; try { $st=@(Get-Service -ErrorAction Stop | Where-Object { $_.StartType -eq 'Automatic' -and $_.Status -eq 'Stopped' }); if($st.Count -eq 0){ Write-Host '  [ok] servicos automaticos em execucao' } else { $p=[Math]::Min(20,$st.Count*5); $s=$s-$p; Write-Host ('  [-'+$p+'] '+$st.Count+' servico(s) automatico(s) parado(s)') } } catch { Write-Host '  [?] servicos indisponiveis' }; try { $o=Get-CimInstance Win32_OperatingSystem -ErrorAction Stop; $p=[math]::Round($o.FreePhysicalMemory/$o.TotalVisibleMemorySize*100); if($p -lt 20){ $s=$s-15; Write-Host ('  [-15] memoria livre baixa: '+$p+' em 100') } else { Write-Host ('  [ok] memoria livre: '+$p+' em 100') } } catch { Write-Host '  [?] memoria indisponivel' }; try { $d=@(Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' -ErrorAction Stop); $baixo=0; $d | ForEach-Object { if($_.Size -gt 0 -and ($_.FreeSpace/$_.Size*100) -lt 15){ $baixo++ } }; if($baixo -gt 0){ $s=$s-10; Write-Host ('  [-10] '+$baixo+' volume(s) com pouco espaco livre') } else { Write-Host '  [ok] espaco livre em todos os volumes' } } catch { Write-Host '  [?] discos indisponiveis' }; try { $e=@(Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 200 -ErrorAction Stop); if($e.Count -gt 50){ $s=$s-10; Write-Host ('  [-10] '+$e.Count+' eventos criticos em 7 dias') } else { Write-Host ('  [ok] '+$e.Count+' evento(s) critico(s) em 7 dias') } } catch { Write-Host '  [ok] nenhum evento critico em 7 dias' }; if($s -lt 0){ $s=0 }; Write-Host ''; Write-Host '============================================'; Write-Host ('  SCORE DE SAUDE: '+$s+' de 100'); Write-Host '============================================'; if($s -ge 80){ Write-Host '  Situacao: boa' } elseif($s -ge 50){ Write-Host '  Situacao: atencao' } else { Write-Host '  Situacao: critica' }"
:fim
echo.
pause
endlocal
