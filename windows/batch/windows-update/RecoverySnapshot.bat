:: ============================================================
:: BATLAB | RecoverySnapshot.bat | v1.0.0
:: @desc      Exporta configuracoes antes de reparo
:: @category  windows-update
:: @platform  windows
:: @admin     no
:: @risk      medium
:: @writes user
:: @deletes none
:: @registry read
:: @services read
:: @tasks none
:: @network none
:: @restart none
:: @undo      Apague o arquivo gerado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RecoverySnapshot
echo ============================================
echo  BATLAB - RecoverySnapshot
echo ============================================
echo [ATENCAO] Vai gravar um arquivo de texto com as configuracoes atuais do PC.
echo O arquivo sera criado nesta pasta: %CD%
echo Conteudo: sistema, hotfixes, servicos, particoes e reinicio pendente.
echo Nenhuma configuracao sera alterada.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$f='recovery-snapshot-'+(Get-Date -Format 'yyyyMMdd-HHmm')+'.txt'; $l=@(); $o=Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue; if($o){ $l+='Sistema: '+$o.Caption+' | '+$o.Version+' | '+$o.OSArchitecture }; $c=Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue; if($c){ $l+='Maquina: '+$c.Name+' | '+$c.Manufacturer+' '+$c.Model }; $l+='Data: '+(Get-Date -Format 'dd/MM/yyyy HH:mm'); $l+=''; $l+='== Hotfixes (10 mais recentes) =='; Get-HotFix -ErrorAction SilentlyContinue | Sort-Object InstalledOn -Descending | Select-Object -First 10 | ForEach-Object { $l+='  '+$_.HotFixID+' | '+$_.InstalledOn+' | '+$_.Description }; $l+=''; $l+='== Servicos do Windows Update =='; foreach($n in @('wuauserv','bits','cryptsvc','msiserver','TrustedInstaller')){ $s=Get-Service -Name $n -ErrorAction SilentlyContinue; if($s){ $l+='  '+$n+' = '+$s.Status+' (inicio '+$s.StartType+')' } else { $l+='  '+$n+' = nao instalado' } }; $l+=''; $l+='== Particoes =='; Get-Partition -ErrorAction SilentlyContinue | ForEach-Object { $l+='  disco '+$_.DiskNumber+' part '+$_.PartitionNumber+' | '+$_.Type+' | '+[math]::Round($_.Size/1GB,1)+' GB' }; $l+=''; $l+='== Reinicio pendente =='; if(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending'){ $l+='  CBS: reinicio pendente' } else { $l+='  CBS: nada pendente' }; if(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'){ $l+='  Windows Update: reinicio pendente' } else { $l+='  Windows Update: nada pendente' }; $l+=''; $l+='== Pontos de restauracao =='; try { $rp=@(Get-CimInstance -Namespace 'root/default' -ClassName 'SystemRestore' -ErrorAction Stop); if($rp.Count -eq 0){ $l+='  (nenhum)' } else { $l+='  '+$rp.Count+' ponto(s) cadastrado(s)' } } catch { $l+='  (indisponivel - precisa de administrador)' }; try { $alvo=Join-Path (Get-Location) $f; [IO.File]::WriteAllText($alvo,($l -join [char]10)); Write-Host ('[OK] Arquivo criado: '+$alvo); Write-Host ('Linhas gravadas: '+$l.Count) } catch { Write-Host ('[ERRO] Falha ao gravar: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
