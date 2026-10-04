:: ============================================================
:: BATLAB | DiskSpace.bat | v1.0.0
:: @desc      Espaco total e livre por unidade
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DiskSpace
echo ============================================
echo  BATLAB - DiskSpace
echo ============================================
echo Calculando o espaco livre por unidade...
echo [INFO] Mostra total, livre e percentual de uso das unidades fixas.
echo [INFO] Pen drives e discos externos nao entram nesta lista.
echo [INFO] Unidade de DVD sem disco pode nao aparecer.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | ForEach-Object { $t=[math]::Round($_.Size/1GB,1); $f=[math]::Round($_.FreeSpace/1GB,1); $p=[math]::Round(($_.FreeSpace/$_.Size)*100,1); Write-Host ($_.DeviceID + '  Total: ' + $t + ' GB | Livre: ' + $f + ' GB | Percentual livre: ' + $p) }"
echo.
if errorlevel 1 (echo [ERRO] Falha ao ler o espaco em disco.) else (echo Feito. Espaco acima.)
:fim
echo.
pause