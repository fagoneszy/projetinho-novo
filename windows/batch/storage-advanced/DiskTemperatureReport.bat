:: ============================================================
:: BATLAB | DiskTemperatureReport.bat | v1.0.0
:: @desc      Temperatura dos discos
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
title BATLAB - DiskTemperatureReport
echo ============================================
echo  BATLAB - DiskTemperatureReport
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] A temperatura dos discos exige administrador.
  echo        O Windows nega Get-StorageReliabilityCounter sem elevacao.
  echo        Clique com botao direito no arquivo e escolha Executar como administrador.
  goto :fim
)
powershell -NoProfile -Command "Write-Host 'Temperatura dos discos:'; try { $d=@(Get-PhysicalDisk -ErrorAction Stop); if($d.Count -eq 0){ Write-Host '  Nenhum disco encontrado.' }; foreach($x in $d){ $t='sem leitura'; try { $r=$x | Get-StorageReliabilityCounter -ErrorAction Stop; if($null -ne $r.Temperature){ $t=[string]$r.Temperature+' C' } } catch { }; Write-Host ('  '+$x.FriendlyName+' | '+$x.MediaType+' | temperatura: '+$t+' | saude '+$x.HealthStatus) } } catch { Write-Host ('  Falha ao ler discos: '+$_.Exception.Message) }; Write-Host ''; Write-Host 'Faixa confortavel de operacao: 25 C a 45 C.'
:fim
echo.
pause
endlocal
