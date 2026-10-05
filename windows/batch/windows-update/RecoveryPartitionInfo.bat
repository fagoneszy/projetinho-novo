:: ============================================================
:: BATLAB | RecoveryPartitionInfo.bat | v1.0.0
:: @desc      Informacoes da particao de recuperacao
:: @category  windows-update
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
title BATLAB - RecoveryPartitionInfo
echo ============================================
echo  BATLAB - RecoveryPartitionInfo
echo ============================================
powershell -NoProfile -Command "Write-Host 'Particoes de disco:'; $off=[int64]0; try { $r=[xml](Get-Content -LiteralPath (Join-Path $env:SystemRoot 'System32\Recovery\ReAgent.xml') -ErrorAction Stop); $off=[int64](''+$r.WindowsRE.WinreLocation.offset) } catch { }; try { Get-Partition -ErrorAction Stop | ForEach-Object { $m=''; if($off -gt 0 -and $_.Offset -eq $off){ $m='  <= WinRE (ambiente de recuperacao)' }; $dl=''+$_.DriveLetter; if($dl -eq ''){ $dl='-' }; Write-Host ('  disco '+$_.DiskNumber+' part '+$_.PartitionNumber+' | '+$dl+' | '+[math]::Round($_.Size/1GB,1)+' GB | '+$_.Type+$m) } } catch { Write-Host '  (Get-Partition indisponivel)' }; Write-Host ''; Write-Host 'Volumes:'; try { Get-Volume -ErrorAction Stop | ForEach-Object { $dl=''+$_.DriveLetter; if($dl -eq ''){ $dl='-' }; $lb=$_.FileSystemLabel; if(-not $lb){ $lb='(sem rotulo)' }; Write-Host ('  '+$dl+' | '+$lb+' | '+[math]::Round($_.Size/1GB,1)+' GB - livre '+[math]::Round($_.SizeRemaining/1GB,1)+' GB') } } catch { Write-Host '  (Get-Volume indisponivel)' }"
:fim
echo.
pause
endlocal
