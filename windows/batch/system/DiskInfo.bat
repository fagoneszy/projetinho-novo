:: ============================================================
:: BATLAB | DiskInfo.bat | v1.0.0
:: @desc      Informacoes dos discos fisicos
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DiskInfo
echo ============================================
echo  BATLAB - DiskInfo
echo ============================================
echo Lendo informacoes dos discos fisicos...
echo [INFO] Modelo, tamanho, interface e particoes de cada disco.
echo [INFO] A segunda tabela mostra os volumes logicos (letras).
echo [INFO] Discos USB desconectados nao aparecem.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "Get-CimInstance Win32_DiskDrive | Select-Object Model,InterfaceType,Partitions,@{n='TamanhoGB';e={[math]::Round($_.Size/1GB)}} | Format-Table -AutoSize; Write-Host '--- Volumes logicos ---'; Get-CimInstance Win32_LogicalDisk | Select-Object DeviceID,DriveType,FileSystem,@{n='TamanhoGB';e={[math]::Round($_.Size/1GB)}} | Format-Table -AutoSize"
echo.
if errorlevel 1 (echo [ERRO] Falha ao ler os discos.) else (echo Feito. Discos listados acima.)
:fim
echo.
pause
