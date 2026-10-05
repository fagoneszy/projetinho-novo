:: ============================================================
:: BATLAB | HardwareInfo.bat | v1.0.0
:: @desc      Hardware: placas, modulos e perifericos
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - HardwareInfo
echo ============================================
echo  BATLAB - HardwareInfo
echo ============================================
echo Coletando informacoes de hardware...
echo [INFO] Mostra placa-mae, modulos de memoria e perifericos.
echo [INFO] A lista de perifericos traz USB, teclado, mouse e audio.
echo [INFO] Itens desconectados podem nao aparecer na listagem.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "Get-CimInstance Win32_BaseBoard | Select-Object Manufacturer,Product,SerialNumber | Format-List; Write-Host '--- Memoria (modulos) ---'; Get-CimInstance Win32_PhysicalMemory | Select-Object BankLabel,Capacity,Speed,Manufacturer | Format-Table -AutoSize; Write-Host '--- Perifericos ---'; Get-CimInstance Win32_PnPEntity | Where-Object { $_.PNPClass -match 'USB|HID|Keyboard|Mouse|Monitor|Audio|Net|Bluetooth' } | Select-Object Name,PNPClass | Format-Table -AutoSize"
echo.
if errorlevel 1 (echo [ERRO] Falha ao coletar o hardware.) else (echo Feito. Hardware listado acima.)
:fim
echo.
pause
