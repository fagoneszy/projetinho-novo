:: ============================================================
:: BATLAB | BootDiagnostic.bat | v1.0.0
:: @desc      Diagnostica problemas de inicializacao
:: @category  system-diagnosis
:: @platform  windows
:: @admin     yes
:: @risk      low
:: @writes none
:: @deletes none
:: @registry read
:: @services read
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BootDiagnostic
echo ============================================
echo  BATLAB - BootDiagnostic
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [AVISO] Sem administrador o log de diagnostico de boot pode nao abrir.
  echo         Os dados basicos de inicializacao ficam disponiveis.
  echo.
)
powershell -NoProfile -Command "Write-Host 'Inicializacao atual:'; try { $b=(Get-CimInstance Win32_OperatingSystem -ErrorAction Stop).LastBootUpTime; $ts=(Get-Date)-$b; Write-Host ('  ultima inicializacao: '+$b.ToString('dd/MM/yyyy HH:mm')); Write-Host ('  tempo ligado: '+$ts.Days+'d '+$ts.Hours+'h '+$ts.Minutes+'m') } catch { Write-Host '  (indisponivel)' }; Write-Host ''; Write-Host 'Duracao dos ultimos boots:'; try { Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-Diagnostics-Performance/Operational';Id=100} -MaxEvents 5 -ErrorAction Stop | ForEach-Object { $x=[xml]$_.ToXml(); $v='sem dado'; foreach($d in $x.Event.EventData.Data){ if($d.Name -eq 'MainPathBootTime'){ $v=$d.'#text'+' ms' } }; Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | boot '+$v) } } catch { Write-Host '  (indisponivel - rode como administrador)' }; Write-Host ''; Write-Host 'Programas de inicializacao (registro):'; try { (Get-ItemProperty -Path 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -ErrorAction Stop).PSObject.Properties | Where-Object { $_.Name -notlike 'PS*' } | ForEach-Object { Write-Host ('  '+$_.Name) } } catch { Write-Host '  (chave indisponivel)' }; Write-Host ''; Write-Host 'Servicos automaticos parados:'; try { $s=@(Get-Service | Where-Object { $_.StartType -eq 'Automatic' -and $_.Status -eq 'Stopped' }); if($s.Count -eq 0){ Write-Host '  (nenhum)' } else { $s | ForEach-Object { Write-Host ('  '+$_.Name+' - '+$_.DisplayName) } } } catch { Write-Host '  (indisponivel)' }"
:fim
echo.
pause
endlocal
