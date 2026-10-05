:: ============================================================
:: BATLAB | EmergencyDiskReport.bat | v1.0.0
:: @desc      Emergencia: espaco livre dos discos e maiores arquivos da pasta
:: @category  emergency
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
title BATLAB - EmergencyDiskReport
echo ============================================
echo  BATLAB - EmergencyDiskReport
echo ============================================
powershell -NoProfile -Command "Get-Volume | Where-Object { $_.DriveLetter } | ForEach-Object { $pct=if($_.Size){[math]::Round(100*$_.SizeRemaining/$_.Size,0)}else{0}; $tag=if($pct -lt 15){' [ALERTA]'}elseif($pct -lt 30){' [atencao]'}else{''}; Write-Host ('  '+$_.DriveLetter+': livre '+[math]::Round($_.SizeRemaining/1GB,1)+' GB ('+$pct+'%)'+$tag) }; Write-Host ''; Write-Host 'Maiores arquivos desta pasta:'; $top=@(Get-ChildItem -Path . -Recurse -File -ErrorAction SilentlyContinue | Sort-Object Length -Descending | Select-Object -First 5); if($top.Count -eq 0){ Write-Host '  (nenhum arquivo)' } else { $top | ForEach-Object { $rel=$_.FullName.Replace((Get-Location).Path,'.'); Write-Host ('  '+[math]::Round($_.Length/1MB,1)+' MB  '+$rel) } }"
:fim
echo.
pause
