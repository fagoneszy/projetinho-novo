:: ============================================================
:: BATLAB | CacheSizeReport.bat | v1.0.0
:: @desc      Tamanho de caches conhecidos
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
title BATLAB - CacheSizeReport
echo ============================================
echo  BATLAB - CacheSizeReport
echo ============================================
echo Mede caches conhecidos: navegador, npm, pip, miniaturas e erros.
echo Somente leitura: nenhum cache e limpo por este script.
powershell -NoProfile -Command "try { $c=@{ 'Miniaturas' = ($env:LOCALAPPDATA+'\Microsoft\Windows\Explorer'); 'Icones' = ($env:LOCALAPPDATA+'\IconCache.db'); 'Cache do Edge' = ($env:LOCALAPPDATA+'\Microsoft\Edge\User Data\Default\Cache'); 'Cache npm' = ($env:LOCALAPPDATA+'\npm-cache'); 'Cache pip' = ($env:LOCALAPPDATA+'\pip\cache'); 'Relatorios de erro' = ($env:ProgramData+'\Microsoft\Windows\WER'); 'Quebras de programa' = ($env:LOCALAPPDATA+'\CrashDumps'); 'Cache D3D' = ($env:LOCALAPPDATA+'\D3DSCache') }; $sum=0; foreach($k in $c.Keys){ $p=$c[$k]; if(Test-Path -LiteralPath $p){ $it=Get-Item -LiteralPath $p -Force; $s=0; if($it.PSIsContainer){ $f=@(Get-ChildItem -LiteralPath $p -Recurse -Force -File -ErrorAction SilentlyContinue); $s=($f | Measure-Object Length -Sum).Sum } else { $s=$it.Length }; if($null -eq $s){ $s=0 }; $sum=$sum+$s; Write-Host ('  '+$k+' | '+[math]::Round($s/1MB,1)+' MB | '+$p) } else { Write-Host ('  '+$k+' | inexistente | '+$p) } }; Write-Host ('  Soma dos caches: '+[math]::Round($sum/1MB,1)+' MB') } catch { Write-Host ('  Falha na leitura: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
