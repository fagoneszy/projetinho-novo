:: ============================================================
:: BATLAB | RunningProcesses.bat | v1.0.0
:: @desc      Processos ativos com uso de memoria
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RunningProcesses
echo ============================================
echo  BATLAB - RunningProcesses
echo ============================================
echo Listando os processos ativos (top 30 por memoria)...
echo [INFO] Colunas: PID, nome, memoria em MB e CPU consumida.
echo [INFO] Apenas os 30 que mais consomem memoria sao exibidos.
echo [INFO] A CPU mostra o tempo total consumido desde a inicializacao.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 30 Id,ProcessName,@{n='MemMB';e={[math]::Round($_.WorkingSet64/1MB)}},@{n='CPUs';e={[math]::Round($_.CPU,1)}} | Format-Table -AutoSize"
echo.
if errorlevel 1 (echo [ERRO] Falha ao listar os processos.) else (echo Feito. Processos acima.)
:fim
echo.
pause