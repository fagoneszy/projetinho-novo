:: ============================================================
:: BATLAB | VolumeReport.bat | v1.0.0
:: @desc      Relatorio de volumes e espaco
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
title BATLAB - VolumeReport
echo ============================================
echo  BATLAB - VolumeReport
echo ============================================
echo Mostra cada volume com tamanho, espaco livre e saude.
echo Nenhuma configuracao e alterada.
powershell -NoProfile -Command "try { $v=@(Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter }); if($v.Count -eq 0){ Write-Host '  Nenhum volume com letra de unidade.' }; $ts=0; $tf=0; $v | ForEach-Object { $p=0; if($_.Size -gt 0){ $p=[math]::Round(100*$_.SizeRemaining/$_.Size) }; $ts=$ts+$_.Size; $tf=$tf+$_.SizeRemaining; $a='OK'; if($p -lt 15){ $a='ALERTA' }; if($p -lt 5){ $a='CRITICO' }; Write-Host ('  '+$_.DriveLetter+': '+$_.FileSystemLabel+' | '+$_.FileSystem+' | '+$_.HealthStatus); Write-Host ('      total '+[math]::Round($_.Size/1GB,1)+' GB | livre '+[math]::Round($_.SizeRemaining/1GB,1)+' GB | livre '+$p+' em 100 | '+$a) }; Write-Host ''; Write-Host ('  Soma dos volumes: total '+[math]::Round($ts/1GB,1)+' GB | livre '+[math]::Round($tf/1GB,1)+' GB') } catch { Write-Host ('  Falha ao ler volumes: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
