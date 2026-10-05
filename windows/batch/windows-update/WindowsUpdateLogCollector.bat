:: ============================================================
:: BATLAB | WindowsUpdateLogCollector.bat | v1.0.0
:: @desc      Coleta o log do Windows Update
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
title BATLAB - WindowsUpdateLogCollector
echo ============================================
echo  BATLAB - WindowsUpdateLogCollector
echo ============================================
echo [DICA] Para o log completo rode como administrador: powershell Get-WindowsUpdateLog
powershell -NoProfile -Command "$l=$env:SystemRoot+'\WindowsUpdate.log'; Write-Host 'WindowsUpdate.log (ultimas linhas):'; $t=@(Get-Content -LiteralPath $l -Tail 25 -ErrorAction SilentlyContinue); if($t.Count -le 4){ Write-Host '  (so o aviso do ETW - rode Get-WindowsUpdateLog como administrador para gerar o log completo)' } else { $t | ForEach-Object { Write-Host ('  '+$_) } }; Write-Host ''; Write-Host 'Eventos recentes do Windows Update:'; $e=@(Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-WindowsUpdateClient/Operational'} -MaxEvents 15 -ErrorAction SilentlyContinue); if($e.Count -eq 0){ Write-Host '  (nenhum evento registrado)' } else { $e | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | '+$_.Id+' | '+$m) } }"
:fim
echo.
pause
endlocal
