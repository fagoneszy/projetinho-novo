:: ============================================================
:: BATLAB | LatencyLogger.bat | v1.0.0
:: @desc      Registra a latencia medida em um arquivo CSV
:: @category  network-advanced
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes    user
:: @deletes   none
:: @registry  none
:: @services  none
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      Apagar o arquivo batlab-logs\latency.csv
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LatencyLogger
echo ============================================
echo  BATLAB - LatencyLogger
echo ============================================
echo Este script registra a latencia atual em um arquivo CSV.
echo O arquivo cresce a cada execucao e ajuda a ver variacoes.
echo.
set "LOG=%USERPROFILE%\batlab-logs\latency.csv"
set "ALVO=%~1"
if not defined ALVO set "ALVO=8.8.8.8"
choice /c SN /m "Registrar a latencia de %ALVO% em %LOG%? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$log = Join-Path $env:USERPROFILE 'batlab-logs\latency.csv'; New-Item -ItemType Directory -Force -Path (Split-Path $log) | Out-Null; $ms = (Measure-Command { Test-Connection -ComputerName '%ALVO%' -Count 4 -Quiet -ErrorAction SilentlyContinue }).TotalMilliseconds; if (-not (Test-Path $log)) { Set-Content -Path $log -Value 'data;hora;alvo;latencia_ms' -Encoding UTF8 }; Add-Content -Path $log -Value ('{0};{1};{2};{3:N1}' -f (Get-Date -Format 'yyyy-MM-dd'), (Get-Date -Format 'HH:mm:ss'), '%ALVO%', $ms) -Encoding UTF8; 'Registro adicionado em ' + $log"
echo.
echo Ultimos registros do arquivo:
powershell -NoProfile -Command "Get-Content (Join-Path $env:USERPROFILE 'batlab-logs\latency.csv') -Tail 10"
echo.
echo [i] Para apagar o historico, remova a pasta batlab-logs do usuario.
:fim
echo.
pause
