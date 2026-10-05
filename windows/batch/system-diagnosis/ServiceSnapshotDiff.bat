:: ============================================================
:: BATLAB | ServiceSnapshotDiff.bat | v1.0.0
:: @desc      Compara servicos entre momentos
:: @category  system-diagnosis
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes temp
:: @deletes none
:: @registry none
:: @services read
:: @tasks none
:: @network none
:: @restart none
:: @undo      Arquivo temporario na pasta TEMP do usuario (batlab-*.txt)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ServiceSnapshotDiff
echo ============================================
echo  BATLAB - ServiceSnapshotDiff
echo ============================================
powershell -NoProfile -Command "$p=$env:TEMP+'\batlab-servicesnapshot.txt'; $a='%~1'; $b='%~2'; $now=@(); try { Get-Service -ErrorAction Stop | Sort-Object Name | ForEach-Object { $now+=($_.Name+' '+$_.Status) } } catch { $now+=('falha ao capturar servicos') }; if($a -eq ''){ $old=$null; if(Test-Path -LiteralPath $p){ $old=@(Get-Content -LiteralPath $p -ErrorAction SilentlyContinue) }; [IO.File]::WriteAllText($p,($now -join [char]10)); Write-Host ('Snapshot de '+$now.Count+' servico(s) salvo em '+$p); if($old -and $old.Count -gt 0){ Write-Host ''; Write-Host 'Mudancas desde o ultimo snapshot:'; $d=Compare-Object -ReferenceObject $old -DifferenceObject $now; if($d){ foreach($i in $d){ Write-Host ('  '+$i.SideIndicator+' '+$i.InputObject) } } else { Write-Host '  (nenhuma mudanca)' } } else { Write-Host 'Primeiro snapshot gravado. Rode de novo para comparar.' } } elseif($b -eq ''){ if(-not (Test-Path -LiteralPath $a)){ Write-Host ('Arquivo nao encontrado: '+$a) } else { $old=@(Get-Content -LiteralPath $a); $d=Compare-Object -ReferenceObject $old -DifferenceObject $now; Write-Host 'Mudancas entre o arquivo e o snapshot atual:'; if($d){ foreach($i in $d){ Write-Host ('  '+$i.SideIndicator+' '+$i.InputObject) } } else { Write-Host '  (nenhuma mudanca)' } } } else { if(-not (Test-Path -LiteralPath $a) -or -not (Test-Path -LiteralPath $b)){ Write-Host 'Um dos arquivos informados nao existe.' } else { $x=@(Get-Content -LiteralPath $a); $y=@(Get-Content -LiteralPath $b); $d=Compare-Object -ReferenceObject $x -DifferenceObject $y; Write-Host 'Mudancas entre os dois arquivos:'; if($d){ foreach($i in $d){ Write-Host ('  '+$i.SideIndicator+' '+$i.InputObject) } } else { Write-Host '  (nenhuma mudanca)' } } }"
:fim
echo.
pause
endlocal
