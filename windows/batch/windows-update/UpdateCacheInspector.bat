:: ============================================================
:: BATLAB | UpdateCacheInspector.bat | v1.0.0
:: @desc      Inspeciona a cache do Windows Update
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
title BATLAB - UpdateCacheInspector
echo ============================================
echo  BATLAB - UpdateCacheInspector
echo ============================================
powershell -NoProfile -Command "function Sz($p){ if(-not (Test-Path -LiteralPath $p)){ return 'pasta nao existe' }; $m=Get-ChildItem -LiteralPath $p -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object Length -Sum -Count; return ([string][math]::Round($m.Sum/1MB,1)+' MB | '+$m.Count+' arquivos') }; $sd=$env:SystemRoot+'\SoftwareDistribution'; Write-Host 'Cache do Windows Update:'; Write-Host ('  SoftwareDistribution       : '+(Sz $sd)); Write-Host ('  ...Download (pacotes)     : '+(Sz ($sd+'\Download'))); Write-Host ('  ...DataStore (indice)     : '+(Sz ($sd+'\DataStore'))); Write-Host ('  Catroot2 (assinaturas)    : '+(Sz ($env:SystemRoot+'\System32\catroot2'))); $t=Get-Item -LiteralPath ($sd+'\DataStore\DataStore.edb') -ErrorAction SilentlyContinue; if($t){ Write-Host ('Ultima escrita no indice: '+$t.LastWriteTime.ToString('dd/MM/yyyy HH:mm')) } else { Write-Host 'Base DataStore.edb nao encontrada.' }; Write-Host 'Dica: para limpar a cache use UpdateServiceRepair.bat antes de reiniciar as buscas.'"
:fim
echo.
pause
endlocal
