:: ============================================================
:: BATLAB | SSDHealthReport.bat | v1.0.0
:: @desc      Saude e desgaste de SSDs
:: @category  storage-advanced
:: @platform  windows
:: @admin     yes
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
title BATLAB - SSDHealthReport
echo ============================================
echo  BATLAB - SSDHealthReport
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] O desgaste do SSD exige administrador.
  echo        O Windows nega Get-StorageReliabilityCounter sem elevacao.
  echo        Clique com botao direito no arquivo e escolha Executar como administrador.
  goto :fim
)
powershell -NoProfile -Command "try { $ssd=@(Get-PhysicalDisk -ErrorAction Stop | Where-Object { $_.MediaType -eq 'SSD' }); if($ssd.Count -eq 0){ Write-Host '  Nenhum SSD encontrado neste PC.' }; foreach($x in $ssd){ Write-Host ('  '+$x.FriendlyName+' | '+[math]::Round($x.Size/1GB,0)+' GB | saude '+$x.HealthStatus+' | '+$x.BusType); try { $r=$x | Get-StorageReliabilityCounter -ErrorAction Stop; if($null -ne $r.Wear){ $w=[int]$r.Wear; Write-Host ('      desgaste: '+$w+' de 100 | vida util restante: '+(100-$w)+' de 100') } else { Write-Host '      desgaste: nao informado pelo fabricante' }; if($null -ne $r.PowerOnHours){ Write-Host ('      horas ligado: '+$r.PowerOnHours) }; if($null -ne $r.Temperature){ Write-Host ('      temperatura: '+$r.Temperature+' C') } } catch { Write-Host '      contadores indisponiveis: rode como administrador' } } } catch { Write-Host ('  Falha ao ler discos: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
