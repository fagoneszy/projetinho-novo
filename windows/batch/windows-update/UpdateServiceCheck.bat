:: ============================================================
:: BATLAB | UpdateServiceCheck.bat | v1.0.0
:: @desc      Status dos servicos do Windows Update
:: @category  windows-update
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes none
:: @deletes none
:: @registry none
:: @services read
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - UpdateServiceCheck
echo ============================================
echo  BATLAB - UpdateServiceCheck
echo ============================================
powershell -NoProfile -Command "Write-Host 'Servicos do Windows Update:'; foreach($n in @('wuauserv','bits','cryptsvc','msiserver','TrustedInstaller','UsoSvc','WaaSMedicSvc','DoSvc')){ $s=Get-Service -Name $n -ErrorAction SilentlyContinue; if($s){ $st=''+$s.Status; $st=$st.Replace('Running','Em execucao').Replace('Stopped','Parado'); Write-Host ('  '+$n.PadRight(16)+' | '+$st+' | inicio '+$s.StartType) } else { Write-Host ('  '+$n.PadRight(16)+' | (nao instalado)') } }; Write-Host ''; $w=(Get-Service -Name wuauserv -ErrorAction SilentlyContinue).Status; if($w -ne 'Running'){ Write-Host '[AVISO] wuauserv parado - atualizacoes nao funcionam. Rode UpdateServiceRepair.bat.' } else { Write-Host 'Servico principal (wuauserv) em execucao.' }"
:fim
echo.
pause
endlocal
