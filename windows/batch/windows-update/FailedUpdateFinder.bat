:: ============================================================
:: BATLAB | FailedUpdateFinder.bat | v1.0.0
:: @desc      Localiza atualizacoes que falharam
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
title BATLAB - FailedUpdateFinder
echo ============================================
echo  BATLAB - FailedUpdateFinder
echo ============================================
powershell -NoProfile -Command "Write-Host 'Atualizacoes que falharam (eventos de erro dos ultimos 30 dias):'; try { $e=@(Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-WindowsUpdateClient/Operational'; Level=1,2; StartTime=(Get-Date).AddDays(-30)} -MaxEvents 200 -ErrorAction SilentlyContinue); if($e.Count -eq 0){ Write-Host '  (nenhuma falha registrada no periodo)' } else { Write-Host ('  '+$e.Count+' evento(s) de erro encontrado(s)'); Write-Host ''; $e | Select-Object -First 12 | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | erro '+$_.Id+' | '+$m) } } } catch { Write-Host '  (log do Windows Update indisponivel)' }; Write-Host ''; Write-Host 'Dica: confira o significado dos codigos em UpdateErrorCodes.bat'"
:fim
echo.
pause
endlocal
