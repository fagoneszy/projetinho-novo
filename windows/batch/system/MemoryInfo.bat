:: ============================================================
:: BATLAB | MemoryInfo.bat | v1.0.0
:: @desc      Modulos de memoria e total de RAM
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MemoryInfo
echo ============================================
echo  BATLAB - MemoryInfo
echo ============================================
echo Lendo os modulos de memoria...
echo [INFO] Cada modulo: slot, capacidade, velocidade e fabricante.
echo [INFO] A memoria total vem da placa-mae (pode diferir do somatorio).
echo [INFO] Slots vazios nao aparecem na listagem.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "Get-CimInstance Win32_PhysicalMemory | Select-Object BankLabel,Capacity,Speed,Manufacturer | Format-Table -AutoSize; $t=(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory; Write-Host ('Total de RAM: ' + [math]::Round($t/1GB,1) + ' GB')"
echo.
if errorlevel 1 (echo [ERRO] Falha ao ler a memoria.) else (echo Feito. Memoria listada acima.)
:fim
echo.
pause