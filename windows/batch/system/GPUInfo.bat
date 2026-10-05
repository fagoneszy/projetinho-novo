:: ============================================================
:: BATLAB | GPUInfo.bat | v1.0.0
:: @desc      Placas de video instaladas
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GPUInfo
echo ============================================
echo  BATLAB - GPUInfo
echo ============================================
echo Lendo informacoes das placas de video...
echo [INFO] Nome, memoria de video, driver e processador grafico.
echo [INFO] Notebooks podem mostrar a grafica integrada e a dedicada.
echo [INFO] VRAM acima de 4 GB pode aparecer errada (limite do WMI).
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | ForEach-Object { Write-Host ('Nome:      ' + $_.Name); Write-Host ('VRAM:      ' + [math]::Round($_.AdapterRAM/1MB) + ' MB'); Write-Host ('Driver:    ' + $_.DriverVersion); Write-Host ('Grafico:   ' + $_.VideoProcessor); Write-Host '---' }"
echo.
if errorlevel 1 (echo [ERRO] Falha ao ler as placas de video.) else (echo Feito. Placas listadas acima.)
:fim
echo.
pause
