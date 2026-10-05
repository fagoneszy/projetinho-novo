:: ============================================================
:: BATLAB | FreeSpaceThreshold.bat | v1.0.0
:: @desc      Verifica espaco livre contra limites
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
title BATLAB - FreeSpaceThreshold
echo ============================================
echo  BATLAB - FreeSpaceThreshold
echo ============================================
set "LIM=%~1"
if "%LIM%"=="" set "LIM=15"
echo Compara o espaco livre de cada volume com o limite desejado.
echo Limite atual: %LIM% em 100 livres. Menos de 5 em 100 e critico.
echo Para mudar: FreeSpaceThreshold.bat 20 - padrao 15.
powershell -NoProfile -Command "try { $lim=15; if($env:LIM -match '^[0-9]+$'){ $lim=[int]$env:LIM }; Write-Host ('Limite usado: '+$lim+' em 100 livres'); $v=@(Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter }); if($v.Count -eq 0){ Write-Host '  Nenhum volume com letra de unidade.' }; $v | ForEach-Object { $p=0; if($_.Size -gt 0){ $p=[math]::Round(100*$_.SizeRemaining/$_.Size) }; $s='DENTRO DO LIMITE'; if($p -lt $lim){ $s='ABAIXO DO LIMITE' }; if($p -lt 5){ $s='CRITICO' }; Write-Host ('  '+$_.DriveLetter+': livre '+[math]::Round($_.SizeRemaining/1GB,1)+' GB de '+[math]::Round($_.Size/1GB,1)+' GB | livre '+$p+' em 100 | '+$s) } } catch { Write-Host ('  Falha ao ler volumes: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
