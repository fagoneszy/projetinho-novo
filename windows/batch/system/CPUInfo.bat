:: ============================================================
:: BATLAB | CPUInfo.bat | v1.0.0
:: @desc      Processador: modelo, nucleos e frequencia
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CPUInfo
echo ============================================
echo  BATLAB - CPUInfo
echo ============================================
echo Lendo informacoes do processador...
echo [INFO] Modelo, nucleos, threads e frequencia maxima.
echo [INFO] CPUs com varios soquetes aparecem repetidos na lista.
echo [INFO] A frequencia mostrada e a de projeto, nao a atual.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "$c=@(Get-CimInstance Win32_Processor); foreach($x in $c){ Write-Host ('Modelo:    ' + $x.Name); Write-Host ('Nucleos:   ' + $x.NumberOfCores); Write-Host ('Logicos:   ' + $x.NumberOfLogicalProcessors); Write-Host ('Frequencia:' + $x.MaxClockSpeed + ' MHz'); Write-Host ('Socket:    ' + $x.SocketDesignation); Write-Host '---' }"
echo.
if errorlevel 1 (echo [ERRO] Falha ao ler o processador.) else (echo Feito. Processador acima.)
:fim
echo.
pause
