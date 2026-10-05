:: ============================================================
:: BATLAB | NetworkIncidentReport.bat | v1.0.0
:: @desc      Relatorio de erros e avisos de rede dos ultimos 7 dias
:: @category  network-advanced
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes    user
:: @deletes   none
:: @registry  none
:: @services  none
:: @tasks     none
:: @network   none
:: @restart   none
:: @undo      Apagar o arquivo batlab-logs\incident-report.txt
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NetworkIncidentReport
echo ============================================
echo  BATLAB - NetworkIncidentReport
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador para ler o log de eventos. & pause & exit /b 1)
echo Este script junta erros e avisos de rede dos ultimos 7 dias.
echo O resultado e gravado em um arquivo de texto para analise.
echo.
set "LOG=%USERPROFILE%\batlab-logs\incident-report.txt"
choice /c SN /m "Gerar o relatorio de incidentes de rede? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$log = Join-Path $env:USERPROFILE 'batlab-logs\incident-report.txt'; New-Item -ItemType Directory -Force -Path (Split-Path $log) | Out-Null; $e = @(Get-WinEvent -FilterHashtable @{LogName='System'; Level=2,3; StartTime=(Get-Date).AddDays(-7)} -ErrorAction SilentlyContinue | Where-Object { $_.ProviderName -match 'Tcpip|Dhcp|DNS|NetworkProfile|WLAN|NlaSvc|Netwtw|Service Control Manager' }); $e | Select-Object TimeCreated,ProviderName,Id,LevelDisplayName,Message | Out-File -Encoding utf8 $log; 'Eventos de rede encontrados: ' + $e.Count; 'Arquivo: ' + $log"
echo.
echo Primeiras linhas do relatorio:
powershell -NoProfile -Command "Get-Content (Join-Path $env:USERPROFILE 'batlab-logs\incident-report.txt') -TotalCount 25"
echo.
echo [i] Erros de Dhcp-Client e DNS Client Events apontam o servico de rede.
:fim
echo.
pause
