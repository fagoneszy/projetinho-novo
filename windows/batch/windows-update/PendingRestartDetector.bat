:: ============================================================
:: BATLAB | PendingRestartDetector.bat | v1.0.0
:: @desc      Detecta reinicio pendente do Windows
:: @category  windows-update
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes none
:: @deletes none
:: @registry read
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PendingRestartDetector
echo ============================================
echo  BATLAB - PendingRestartDetector
echo ============================================
powershell -NoProfile -Command "$r=@(); if(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending'){ $r+='CBS: reinicio pendente (Component Based Servicing)' }; if(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'){ $r+='Windows Update pediu reinicio' }; $pf=(Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' -Name PendingFileRenameOperations -ErrorAction SilentlyContinue).PendingFileRenameOperations; if($pf){ $r+='Mudancas de arquivos pendentes (renomear na reiniciada)' }; if(Test-Path ($env:SystemRoot+'\WinSxS\pending.xml')){ $r+='Componentes pendentes (WinSxS pending.xml)' }; if($r.Count -eq 0){ Write-Host 'Nenhum reinicio pendente detectado. Tudo em ordem.' } else { Write-Host ('Reinicio PENDENTE - '+$r.Count+' indicador(es):'); $r | ForEach-Object { Write-Host ('  - '+$_) }; Write-Host ''; Write-Host 'Reinicie o PC quando puder para concluir as alteracoes.' }"
:fim
echo.
pause
endlocal
