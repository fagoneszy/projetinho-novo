:: ============================================================
:: BATLAB | ServiceDependencyCheck.bat | v1.0.0
:: @desc      Verifica dependencias de servicos
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
title BATLAB - ServiceDependencyCheck
echo ============================================
echo  BATLAB - ServiceDependencyCheck
echo ============================================
powershell -NoProfile -Command "Write-Host 'Servicos com dependentes:'; try { $n=0; Get-Service | ForEach-Object { $dep=@($_.DependentServices); if($dep.Count -gt 0){ $n++; if($n -le 15){ $nomes=(($dep | ForEach-Object { $_.Name }) -join ', '); Write-Host ('  '+$_.Name+' -> '+$nomes) } } }; if($n -eq 0){ Write-Host '  (nenhum)' } elseif($n -gt 15){ Write-Host ('  ... e mais '+($n-15)+' servico(s)') } } catch { Write-Host '  (indisponivel)' }; Write-Host ''; Write-Host 'Servicos automaticos parados (podem afetar dependentes):'; try { $s=@(Get-Service | Where-Object { $_.StartType -eq 'Automatic' -and $_.Status -eq 'Stopped' }); if($s.Count -eq 0){ Write-Host '  (nenhum)' } else { $s | ForEach-Object { Write-Host ('  '+$_.Name+' - '+$_.DisplayName) } } } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
