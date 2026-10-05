:: ============================================================
:: BATLAB | StorageEmergencyReport.bat | v1.0.0
:: @desc      Relatorio de emergencia de armazenamento
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
title BATLAB - StorageEmergencyReport
echo ============================================
echo  BATLAB - StorageEmergencyReport
echo ============================================
echo Junta volumes criticos, saude dos discos e temporarios.
echo Somente leitura: nada e apagado nem alterado.
powershell -NoProfile -Command "Write-Host '== Volumes =='; try { $v=@(Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter }); $a=0; $tf=0; $v | ForEach-Object { $p=0; if($_.Size -gt 0){ $p=[math]::Round(100*$_.SizeRemaining/$_.Size) }; $tf=$tf+$_.SizeRemaining; if($p -lt 15){ $a=$a+1; $n='AVISO'; if($p -lt 5){ $n='CRITICO' }; Write-Host ('  ['+$n+'] '+$_.DriveLetter+': livre '+[math]::Round($_.SizeRemaining/1GB,1)+' GB | livre '+$p+' em 100') } }; Write-Host ('  Livre somado: '+[math]::Round($tf/1GB,1)+' GB | volumes com alerta: '+$a) } catch { Write-Host ('  Falha: '+$_.Exception.Message) }; Write-Host '== Discos =='; try { Get-PhysicalDisk -ErrorAction Stop | ForEach-Object { $s='  '+$_.FriendlyName+' | '+$_.MediaType+' | '+$_.HealthStatus; if($_.HealthStatus -ne 'Healthy'){ $s='  [AVISO] '+$_.FriendlyName+' | '+$_.MediaType+' | '+$_.HealthStatus }; Write-Host $s } } catch { Write-Host ('  Falha: '+$_.Exception.Message) }; Write-Host '== Temporarios =='; try { $f=@(Get-ChildItem -LiteralPath $env:TEMP -Recurse -Force -File -ErrorAction SilentlyContinue); $s=($f | Measure-Object Length -Sum).Sum; if($null -eq $s){ $s=0 }; Write-Host ('  Temp do usuario: '+[math]::Round($s/1MB,1)+' MB em '+$f.Count+' arquivos') } catch { Write-Host '  indisponivel' }"
echo.
echo Se algum volume estiver CRITICO: esvazie a lixeira e apague temporarios.
echo Depois mova arquivos grandes para outra unidade ou libere espaco.
:fim
echo.
pause
endlocal
