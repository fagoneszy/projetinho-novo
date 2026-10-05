:: ============================================================
:: BATLAB | HDDHealthReport.bat | v1.0.0
:: @desc      Saude e setores realocados de HDs
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
title BATLAB - HDDHealthReport
echo ============================================
echo  BATLAB - HDDHealthReport
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] A saude do HD e o SMART exigem administrador.
  echo        O Windows nega os contadores de confiabilidade sem elevacao.
  echo        Clique com botao direito no arquivo e escolha Executar como administrador.
  goto :fim
)
powershell -NoProfile -Command "try { $hdd=@(Get-PhysicalDisk -ErrorAction Stop | Where-Object { $_.MediaType -eq 'HDD' }); if($hdd.Count -eq 0){ Write-Host '  Nenhum HD mecanico encontrado neste PC.' }; foreach($x in $hdd){ Write-Host ('  '+$x.FriendlyName+' | '+[math]::Round($x.Size/1GB,0)+' GB | saude '+$x.HealthStatus); try { $r=$x | Get-StorageReliabilityCounter -ErrorAction Stop; $le = if($null -ne $r.ReadErrorsUncorrected){ [string]$r.ReadErrorsUncorrected } else { '0' }; $we = if($null -ne $r.WriteErrorsUncorrected){ [string]$r.WriteErrorsUncorrected } else { '0' }; $ho = if($null -ne $r.PowerOnHours){ [string]$r.PowerOnHours } else { 'n/d' }; Write-Host ('      erros de leitura sem correcao: '+$le+' | erros de escrita sem correcao: '+$we+' | horas ligado: '+$ho) } catch { Write-Host '      contadores indisponiveis: rode como administrador' } } } catch { Write-Host ('  Falha ao ler discos: '+$_.Exception.Message) }; Write-Host ''; Write-Host 'Setores realocados: o SMART sinaliza falha acima do limite do fabricante.'; try { $s=@(Get-CimInstance -Namespace 'root\wmi' -ClassName 'MSStorageDriver_FailurePredictStatus' -ErrorAction Stop); $s | ForEach-Object { $m = if($_.PredictFailure){ 'FALHA - '+$_.Reason } else { 'nenhum atributo SMART acima do limite' }; Write-Host ('  '+$_.InstanceName+' | '+$m) } } catch { Write-Host '  SMART indisponivel: rode como administrador' }"
:fim
echo.
pause
endlocal
