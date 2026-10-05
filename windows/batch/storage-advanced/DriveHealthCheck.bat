:: ============================================================
:: BATLAB | DriveHealthCheck.bat | v1.0.0
:: @desc      Saude dos discos: SMART, tipo, temperatura e espaco livre
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
title BATLAB - DriveHealthCheck
echo ============================================
echo  BATLAB - DriveHealthCheck
echo ============================================
powershell -NoProfile -Command "try { $d=Get-PhysicalDisk -ErrorAction Stop; foreach($x in $d){ Write-Host ('  '+$x.FriendlyName+' | '+$x.MediaType+' | saude: '+$x.HealthStatus+' | '+[math]::Round($x.Size/1GB,0)+' GB'); try { $r=$x | Get-StorageReliabilityCounter -ErrorAction Stop; if($r.Temperature){ Write-Host ('      temperatura: '+$r.Temperature+' C') }; if($null -ne $r.Wear){ Write-Host ('      desgaste: '+$r.Wear+'%') } } catch {} } } catch { Write-Host '  Get-PhysicalDisk indisponivel - usando Win32_DiskDrive'; Get-CimInstance Win32_DiskDrive | ForEach-Object { Write-Host ('  '+$_.Model+' | '+$_.MediaType+' | '+[math]::Round($_.Size/1GB,0)+' GB | '+$_.Status) } }; Write-Host ''; Write-Host 'Espaco livre por volume:'; Get-Volume | Where-Object { $_.DriveLetter } | ForEach-Object { $pct=if($_.Size){[math]::Round(100*$_.SizeRemaining/$_.Size,0)}else{0}; $aviso=if($pct -lt 15){' [ALERTA <15%]'}else{''}; Write-Host ('  '+$_.DriveLetter+': livre '+[math]::Round($_.SizeRemaining/1GB,1)+' GB de '+[math]::Round($_.Size/1GB,1)+' GB ('+$pct+'%) | '+$_.HealthStatus+$aviso) }"
:fim
echo.
pause
