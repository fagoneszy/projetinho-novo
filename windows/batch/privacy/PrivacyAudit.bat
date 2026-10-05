:: ============================================================
:: BATLAB | PrivacyAudit.bat | v1.0.0
:: @desc      Auditoria de privacidade: telemetria, anuncios e atividades
:: @category  privacy
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
title BATLAB - PrivacyAudit
echo ============================================
echo  BATLAB - PrivacyAudit
echo ============================================
echo  [i] Telemetria: 0/1 = menor coleta, 3 = completa.
echo  [i] Em anuncios/atividades: 1 = ligado, 0 = desligado.
echo.
powershell -NoProfile -Command "$r=@(@('Telemetria','HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection','AllowTelemetry'),@('ID de publicidade','HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo','Enabled'),@('Experiencias personalizadas','HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy','TailoredExperiencesWithDiagnosticDataEnabled'),@('Historico de atividades','HKLM:\SOFTWARE\Policies\Microsoft\Windows\System','PublishUserActivities'),@('Upload de atividades','HKLM:\SOFTWARE\Policies\Microsoft\Windows\System','UploadUserActivities'),@('Frequency de feedback','HKCU:\SOFTWARE\Microsoft\Siuf\Rules','NumberOfSIUFInPeriod')); foreach($e in $r){ $v=Get-ItemPropertyValue -Path $e[1] -Name $e[2] -ErrorAction SilentlyContinue; if($null -eq $v){ Write-Host ('  [padrao] '+$e[0]+': nao configurado') } else { Write-Host ('  [valor ] '+$e[0]+': '+$v) } }"
:fim
echo.
pause
