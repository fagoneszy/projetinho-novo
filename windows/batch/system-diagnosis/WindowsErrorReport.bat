:: ============================================================
:: BATLAB | WindowsErrorReport.bat | v1.0.0
:: @desc      Coleta erros do Windows Error Reporting
:: @category  system-diagnosis
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
title BATLAB - WindowsErrorReport
echo ============================================
echo  BATLAB - WindowsErrorReport
echo ============================================
powershell -NoProfile -Command "Write-Host 'Relatorios do Windows Error Reporting:'; foreach($r in @('ReportArchive','ReportQueue')){ $p='C:\ProgramData\Microsoft\Windows\WER\'+$r; try { $f=@(Get-ChildItem -LiteralPath $p -Directory -ErrorAction Stop); Write-Host ('  '+$r+': '+$f.Count+' relatorio(s)'); $f | Sort-Object LastWriteTime -Descending | Select-Object -First 5 | ForEach-Object { Write-Host ('    '+$_.Name+' | '+$_.LastWriteTime.ToString('dd/MM/yyyy HH:mm')) } } catch { Write-Host ('  '+$r+': (indisponivel)') } }; Write-Host ''; Write-Host 'Eventos do WER nos ultimos 7 dias:'; try { Get-WinEvent -FilterHashtable @{LogName='Application';ProviderName='Windows Error Reporting'; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 8 -ErrorAction Stop | ForEach-Object { $m=($_.Message -split '\n')[0]; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | evento '+$_.Id); Write-Host ('    '+$m) } } catch { Write-Host '  (nenhum evento)' }"
:fim
echo.
pause
endlocal
