:: ============================================================
:: BATLAB | WiFiAdapterReset.bat | v1.0.0
:: @desc      Reinicia o servico e o adaptador Wi-Fi para destravar conexao
:: @category  network-advanced
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes    none
:: @deletes   none
:: @registry  none
:: @services  write
:: @tasks     none
:: @network   write
:: @restart   none
:: @undo      O Windows reinicia o WlanSvc ao religar o adaptador, so reconecte a rede
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WiFiAdapterReset
echo ============================================
echo  BATLAB - WiFiAdapterReset
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo Este script reinicia o servico de Wi-Fi e reabilita o adaptador.
echo Serve para conexao travada que nao volta so reconectando.
echo.
echo Adaptadores sem fio antes do reinicio:
powershell -NoProfile -Command "Get-NetAdapter -Physical | Where-Object { $_.NdisPhysicalMedium -eq 9 -or $_.InterfaceDescription -match 'Wireless|Wi-Fi|802.11' } | Format-Table -AutoSize Name,Status,LinkSpeed"
echo.
choice /c SN /m "Reiniciar o servico WlanSvc e o adaptador sem fio? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Desconectando as redes sem fio:
netsh wlan disconnect
echo Reiniciando o servico WlanSvc...
powershell -NoProfile -Command "Restart-Service -Name WlanSvc -Force -ErrorAction Stop"
if errorlevel 1 (echo [!] Falha ao reiniciar o WlanSvc. & goto :fim)
echo Reabilitando os adaptadores sem fio:
powershell -NoProfile -Command "Get-NetAdapter -Physical | Where-Object { $_.NdisPhysicalMedium -eq 9 -or $_.InterfaceDescription -match 'Wireless|Wi-Fi|802.11' } | Enable-NetAdapter -Confirm:$false -ErrorAction SilentlyContinue"
echo.
echo Adaptadores depois do reinicio:
powershell -NoProfile -Command "Get-NetAdapter | Format-Table -AutoSize Name,Status,LinkSpeed"
echo.
echo [i] Se continuar travado, o problema pode ser driver e nao servico.
:fim
echo.
pause
