:: ============================================================
:: BATLAB | MountPointReport.bat | v1.0.0
:: @desc      Pontos de montagem e discos
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
title BATLAB - MountPointReport
echo ============================================
echo  BATLAB - MountPointReport
echo ============================================
echo Mostra o caminho GUID de cada volume e de qual disco ele veio.
echo Nenhum ponto de montagem e criado ou removido.
powershell -NoProfile -Command "try { Get-Volume -ErrorAction Stop | ForEach-Object { if($_.DriveLetter){ Write-Host ('  '+$_.DriveLetter+': -> '+$_.Path+' | '+$_.FileSystem) } else { Write-Host ('  sem letra -> '+$_.Path+' | '+$_.FileSystem) } } } catch { Write-Host ('  Falha ao ler volumes: '+$_.Exception.Message) }; Write-Host ''; Write-Host 'Volume de cada letra de unidade:'; try { Get-Partition -ErrorAction Stop | Where-Object { $_.DriveLetter } | ForEach-Object { Write-Host ('  '+$_.DriveLetter+': vem do disco '+$_.DiskNumber+' particao '+$_.PartitionNumber+' tipo '+$_.Type) } } catch { Write-Host '  indisponivel' }; Write-Host ''; Write-Host 'Volumes sem ponto de montagem visivel:'; try { $s=@(Get-Volume -ErrorAction Stop | Where-Object { -not $_.DriveLetter }); if($s.Count -eq 0){ Write-Host '  nenhum' } else { $s | ForEach-Object { Write-Host ('  '+$_.Path+' | '+[math]::Round($_.Size/1GB,1)+' GB') } } } catch { Write-Host '  indisponivel' }"
:fim
echo.
pause
endlocal
