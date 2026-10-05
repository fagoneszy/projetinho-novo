:: ============================================================
:: BATLAB | ComponentStoreReport.bat | v1.0.0
:: @desc      Saude do component store (WinSxS)
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
title BATLAB - ComponentStoreReport
echo ============================================
echo  BATLAB - ComponentStoreReport
echo ============================================
echo [INFO] Lendo a pasta WinSxS - pode levar alguns segundos...
powershell -NoProfile -Command "$p=$env:SystemRoot+'\WinSxS'; if(-not (Test-Path -LiteralPath $p)){ Write-Host 'Pasta WinSxS nao encontrada.' } else { $d=@(Get-ChildItem -LiteralPath $p -Directory -Force -ErrorAction SilentlyContinue); $m=Get-ChildItem -LiteralPath $p -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object Length -Sum -Count; Write-Host 'Component store (WinSxS):'; Write-Host ('  Pasta: '+$p); Write-Host ('  Pastas de componentes: '+$d.Count); Write-Host ('  Arquivos: '+$m.Count); Write-Host ('  Tamanho: '+[math]::Round($m.Sum/1GB,2)+' GB'); $px=Test-Path -LiteralPath ($p+'\pending.xml'); Write-Host ('  pending.xml - atualizacao aguardando reinicio: '+$(if($px){'SIM'}else{'nao'})); Write-Host ''; Write-Host 'Para a verificacao de integridade rode ComponentStoreCheck.bat e SystemImageHealthCheck.bat.' }"
:fim
echo.
pause
endlocal
