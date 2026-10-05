:: ============================================================
:: BATLAB | StorageCleanupPreview.bat | v1.0.0
:: @desc      Previa do que a limpeza apagaria
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
title BATLAB - StorageCleanupPreview
echo ============================================
echo  BATLAB - StorageCleanupPreview
echo ============================================
echo Mostra o tamanho do que uma limpeza comum apagaria.
echo [ATENCAO] Nada e apagado aqui: este script so mede e lista.
echo Areas protegidas aparecem como inexistente ou sem acesso.
powershell -NoProfile -Command "try { function Sz($p){ if(-not (Test-Path -LiteralPath $p)){ return $null }; $f=@(Get-ChildItem -LiteralPath $p -Recurse -Force -File -ErrorAction SilentlyContinue); $s=($f | Measure-Object Length -Sum).Sum; if($null -eq $s){ $s=0 }; return [math]::Round($s/1MB,1) }; $pares=@(); $pares+=,@('Temp do usuario', $env:TEMP); $pares+=,@('Temp do Windows', ($env:windir+'\Temp')); $pares+=,@('Cache do Windows Update', ($env:windir+'\SoftwareDistribution\Download')); $pares+=,@('Otimizacao de entrega', ($env:windir+'\SoftwareDistribution\DeliveryOptimization')); $pares+=,@('Miniaturas', ($env:LOCALAPPDATA+'\Microsoft\Windows\Explorer')); $pares+=,@('Relatorios de erro', ($env:ProgramData+'\Microsoft\Windows\WER')); $t=0; foreach($x in $pares){ $v=Sz $x[1]; if($null -eq $v){ Write-Host ('  '+$x[0]+' | inexistente ou sem acesso') } else { $t=$t+$v; Write-Host ('  '+$x[0]+' | '+$v+' MB | '+$x[1]) } }; try { $sh=New-Object -ComObject Shell.Application; $rb=$sh.Namespace(10); $it=@($rb.Items()); $sum=0; $it | ForEach-Object { $sum=$sum+$_.Size }; $mb=[math]::Round($sum/1MB,1); $t=$t+$mb; Write-Host ('  Lixeira | '+$it.Count+' itens | '+$mb+' MB') } catch { Write-Host '  Lixeira | indisponivel' }; Write-Host ('  Total estimado que a limpeza liberaria: '+[math]::Round($t,1)+' MB') } catch { Write-Host ('  Falha na leitura: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
