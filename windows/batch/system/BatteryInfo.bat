:: ============================================================
:: BATLAB | BatteryInfo.bat | v1.0.0
:: @desc      Status e carga da bateria
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BatteryInfo
echo ============================================
echo  BATLAB - BatteryInfo
echo ============================================
echo Verificando a bateria do notebook...
echo [INFO] Mostra carga, estado e tempo estimado restante.
echo [INFO] Em desktops a mensagem sera "nenhuma bateria detectada".
echo [INFO] O tempo restante e uma estimativa do proprio Windows.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "$b=@(Get-CimInstance Win32_Battery); if($b.Count -eq 0){ Write-Host 'Nenhuma bateria detectada (computador de mesa ou bateria ausente).' } else { foreach($x in $b){ $st='Desconhecido'; switch([int]$x.BatteryStatus){ 1 {$st='Descarregando'} 2 {$st='Ligado na tomada'} 3 {$st='Sem uso'} 4 {$st='Carregando'} 5 {$st='Carregando (bateria cheia)'} 6 {$st='Carregando (pausado)'} 7 {$st='Carregando parcial'} 8 {$st='Carregando parcial (desligado)'} 10 {$st='Bateria nao instalada'} }; Write-Host ('Estado:  ' + $st); Write-Host ('Carga:   ' + $x.EstimatedChargeRemaining + '%%'); Write-Host ('Restante:' + $x.EstimatedRunTime + ' minutos (estimado)') } }"
echo.
if errorlevel 1 (echo [ERRO] Falha ao ler a bateria.) else (echo Feito. Status acima.)
:fim
echo.
pause