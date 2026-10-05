:: ============================================================
:: BATLAB | PartitionReport.bat | v1.0.0
:: @desc      Relatorio de particoes do disco
:: @category  storage-advanced
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
title BATLAB - PartitionReport
echo ============================================
echo  BATLAB - PartitionReport
echo ============================================
echo Lista as particoes de cada disco com tipo, tamanho e papel.
echo Nenhuma particao e criada, removida ou formatada.
powershell -NoProfile -Command "try { Get-Partition -ErrorAction Stop | ForEach-Object { $l = if($_.DriveLetter){ [string]$_.DriveLetter+':' } else { 'sem letra' }; $b = if($_.IsBoot){ 'sim' } else { 'nao' }; $a = if($_.IsActive){ 'sim' } else { 'nao' }; Write-Host ('  disco '+$_.DiskNumber+' part '+$_.PartitionNumber+' | '+$_.Type+' | '+$l+' | '+[math]::Round($_.Size/1GB,1)+' GB | boot '+$b+' | ativa '+$a) } } catch { Write-Host ('  Falha ao ler particoes: '+$_.Exception.Message) }; Write-Host ''; Write-Host 'Quantidade de particoes por disco:'; try { Get-Disk -ErrorAction Stop | ForEach-Object { $n=(Get-Partition -DiskNumber $_.Number -ErrorAction SilentlyContinue | Measure-Object).Count; Write-Host ('  disco '+$_.Number+' | '+$_.FriendlyName+' | '+$n+' particoes') } } catch { Write-Host '  indisponivel' }"
:fim
echo.
pause
endlocal
