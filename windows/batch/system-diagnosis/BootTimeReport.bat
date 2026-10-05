:: ============================================================
:: BATLAB | BootTimeReport.bat | v1.0.0
:: @desc      Ultimos boots, hora da inicializacao e tempo ligado
:: @category  system-diagnosis
:: @platform  windows
:: @admin     yes
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
title BATLAB - BootTimeReport
echo ============================================
echo  BATLAB - BootTimeReport
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [AVISO] Sem administrador o log de diagnostico pode nao abrir.
  echo         Os dados basicos de inicializacao ficam disponiveis.
  echo.
)
powershell -NoProfile -Command "$b=(Get-CimInstance Win32_OperatingSystem).LastBootUpTime; $ts=(Get-Date)-$b; Write-Host ('Ultima inicializacao: '+$b.ToString('dd/MM/yyyy HH:mm')); Write-Host ('Tempo ligado: '+$ts.Days+'d '+$ts.Hours+'h '+$ts.Minutes+'m'); Write-Host ''; Write-Host 'Boots recentes (registro do sistema):'; try { Get-WinEvent -FilterHashtable @{LogName='System';Id=6005} -MaxEvents 5 -ErrorAction Stop | ForEach-Object { Write-Host ('  '+$_.TimeCreated.ToString('dd/MM/yyyy HH:mm')) } } catch { Write-Host '  (historico indisponivel)' }; Write-Host ''; Write-Host 'Duracao de boot (log de diagnostico):'; try { Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-Diagnostics-Performance/Operational';Id=100} -MaxEvents 3 -ErrorAction Stop | ForEach-Object { $x=[xml]$_.ToXml(); foreach($d in $x.Event.EventData.Data){ if($d.Name -match 'MainPathBootTime|BootPostBootTime|BootTime'){ Write-Host ('  '+$_.TimeCreated.ToString('dd/MM HH:mm')+' | '+$d.Name+' = '+$d.'#text'+' ms') } } } } catch { Write-Host '  (indisponivel - rode como administrador)' }"
:fim
echo.
pause
