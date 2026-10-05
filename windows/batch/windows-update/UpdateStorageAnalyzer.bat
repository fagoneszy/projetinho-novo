:: ============================================================
:: BATLAB | UpdateStorageAnalyzer.bat | v1.0.0
:: @desc      Espaco usado pelo Windows Update
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
title BATLAB - UpdateStorageAnalyzer
echo ============================================
echo  BATLAB - UpdateStorageAnalyzer
echo ============================================
echo [INFO] Medindo as pastas do Windows Update - aguarde...
powershell -NoProfile -Command "function Sz($p){ if(-not (Test-Path -LiteralPath $p)){ return 0 }; $m=Get-ChildItem -LiteralPath $p -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object Length -Sum; return [math]::Round($m.Sum/1MB,1) }; $sd=$env:SystemRoot+'\SoftwareDistribution'; $s1=Sz $sd; $s2=Sz ($sd+'\Download'); $s3=Sz ($sd+'\DataStore'); $s4=Sz ($env:SystemRoot+'\System32\catroot2'); $s5=Sz ($env:SystemRoot+'\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache'); $s6=0; $lg=Get-Item -LiteralPath ($env:SystemRoot+'\WindowsUpdate.log') -ErrorAction SilentlyContinue; if($lg){ $s6=[math]::Round($lg.Length/1MB,2) }; Write-Host 'Espaco usado pelo Windows Update:'; Write-Host ('  SoftwareDistribution        : '+$s1+' MB'); Write-Host ('  ...Download (pacotes)      : '+$s2+' MB'); Write-Host ('  ...DataStore (indice)      : '+$s3+' MB'); Write-Host ('  Catroot2 (assinaturas)     : '+$s4+' MB'); Write-Host ('  Otimizacao de Entrega      : '+$s5+' MB'); Write-Host ('  WindowsUpdate.log          : '+$s6+' MB'); Write-Host '  ------------------------------------'; Write-Host ('  Soma das pastas            : '+[math]::Round($s1+$s4+$s5+$s6,1)+' MB'); Write-Host 'Dica: para liberar espaco use a Limpeza de Disco do Windows (cleanmgr).'"
:fim
echo.
pause
endlocal
