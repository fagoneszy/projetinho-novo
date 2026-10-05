:: ============================================================
:: BATLAB | SMARTInfo.bat | v1.0.0
:: @desc      Informacoes SMART dos discos
:: @category  storage-advanced
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
title BATLAB - SMARTInfo
echo ============================================
echo  BATLAB - SMARTInfo
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] A leitura do SMART exige administrador.
  echo        O Windows nega a classe root wmi de SMART sem elevacao.
  echo        Clique com botao direito no arquivo e escolha Executar como administrador.
  goto :fim
)
powershell -NoProfile -Command "Write-Host 'Status SMART:'; try { $s=@(Get-CimInstance -Namespace 'root\wmi' -ClassName 'MSStorageDriver_FailurePredictStatus' -ErrorAction Stop); if($s.Count -eq 0){ Write-Host '  Nenhum disco expoe SMART para este sistema.' }; $s | ForEach-Object { $m = if($_.PredictFailure){ 'FALHA - '+$_.Reason } else { 'sem atributos acima do limite' }; Write-Host ('  '+$_.InstanceName+' | '+$m) } } catch { Write-Host ('  SMART indisponivel: '+$_.Exception.Message) }; Write-Host ''; Write-Host 'Discos e status geral:'; try { Get-CimInstance Win32_DiskDrive -ErrorAction Stop | ForEach-Object { Write-Host ('  '+$_.Model+' | '+$_.InterfaceType+' | '+$_.Status+' | '+[math]::Round($_.Size/1GB,0)+' GB') } } catch { Write-Host '  indisponivel' }"
:fim
echo.
pause
endlocal
