:: ============================================================
:: BATLAB | StorageDeviceInventory.bat | v1.0.0
:: @desc      Inventario de dispositivos de armazenamento
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
title BATLAB - StorageDeviceInventory
echo ============================================
echo  BATLAB - StorageDeviceInventory
echo ============================================
echo Lista discos fisicos, discos logicos e volumes montados.
echo Nenhuma configuracao e alterada.
powershell -NoProfile -Command "Write-Host 'Discos fisicos:'; try { Get-PhysicalDisk -ErrorAction Stop | ForEach-Object { Write-Host ('  ['+$_.DeviceId+'] '+$_.FriendlyName+' | '+$_.MediaType+' | '+$_.BusType+' | saude '+$_.HealthStatus+' | '+[math]::Round($_.Size/1GB,0)+' GB') } } catch { Write-Host ('  Falha: '+$_.Exception.Message) }; Write-Host ''; Write-Host 'Discos, numero e serie:'; try { Get-Disk -ErrorAction Stop | ForEach-Object { Write-Host ('  disco '+$_.Number+' | '+$_.FriendlyName+' | serie '+$_.SerialNumber+' | '+$_.OperationalStatus+' | '+[math]::Round($_.Size/1GB,0)+' GB') } } catch { Write-Host '  indisponivel' }; Write-Host ''; Write-Host 'Volumes montados:'; try { Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter } | ForEach-Object { Write-Host ('  '+$_.DriveLetter+': | '+$_.FileSystem+' | '+$_.HealthStatus+' | '+[math]::Round($_.Size/1GB,1)+' GB') } } catch { Write-Host '  indisponivel' }"
:fim
echo.
pause
endlocal
