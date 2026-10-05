:: ============================================================
:: BATLAB | LowDiskSpaceAlert.bat | v1.0.0
:: @desc      Alerta de volumes com pouco espaco
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
title BATLAB - LowDiskSpaceAlert
echo ============================================
echo  BATLAB - LowDiskSpaceAlert
echo ============================================
echo A verificacao e feita agora, sem criar tarefa agendada.
echo Aviso quando o volume estiver com menos de 15 em 100 livres.
echo Critico quando o volume estiver com menos de 5 em 100 livres.
powershell -NoProfile -Command "try { $v=@(Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter }); if($v.Count -eq 0){ Write-Host '  Nenhum volume com letra de unidade.' }; $a=0; $v | ForEach-Object { $p=0; if($_.Size -gt 0){ $p=[math]::Round(100*$_.SizeRemaining/$_.Size) }; if($p -lt 15){ $a=$a+1; $n='AVISO'; if($p -lt 5){ $n='CRITICO' }; Write-Host ('  ['+$n+'] '+$_.DriveLetter+': livre '+[math]::Round($_.SizeRemaining/1GB,1)+' GB | livre '+$p+' em 100') } }; if($a -eq 0){ Write-Host '  Nenhum volume abaixo do limite. Espaco suficiente em todos.' } else { Write-Host ('  '+$a+' volume(s) com pouco espaco livre.') } } catch { Write-Host ('  Falha ao ler volumes: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
