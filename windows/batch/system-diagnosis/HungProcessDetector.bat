:: ============================================================
:: BATLAB | HungProcessDetector.bat | v1.0.0
:: @desc      Identifica processos travados
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
title BATLAB - HungProcessDetector
echo ============================================
echo  BATLAB - HungProcessDetector
echo ============================================
powershell -NoProfile -Command "Write-Host 'Janelas sem resposta:'; try { $h=@(Get-Process -ErrorAction Stop | Where-Object { -not $_.Responding -and $_.MainWindowTitle -ne '' }); if($h.Count -eq 0){ Write-Host '  (nenhuma)' } else { $h | ForEach-Object { Write-Host ('  '+$_.Name+' | PID '+$_.Id+' | '+$_.MainWindowTitle) } } } catch { Write-Host '  (indisponivel)' }; Write-Host ''; Write-Host 'Maior tempo de CPU acumulado:'; try { Get-Process -ErrorAction Stop | Sort-Object CPU -Descending | Select-Object -First 5 | ForEach-Object { $c=0; if($_.CPU){ $c=[int]$_.CPU }; Write-Host ('  '+$_.Name+' | PID '+$_.Id+' | '+$c+' s de CPU') } } catch { Write-Host '  (indisponivel)' }; Write-Host ''; Write-Host 'Processos sem janela e sem resposta:'; try { $a=@(Get-Process -ErrorAction Stop | Where-Object { -not $_.Responding -and $_.MainWindowTitle -eq '' }); if($a.Count -eq 0){ Write-Host '  (nenhum)' } else { $a | Select-Object -First 10 | ForEach-Object { Write-Host ('  '+$_.Name+' | PID '+$_.Id) } } } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
