:: ============================================================
:: BATLAB | ScheduledShutdown.bat | v1.0.0
:: @desc      Agenda o desligamento do PC em N minutos
:: @category  automation
:: @admin     no
:: @risk      medium
:: @undo      shutdown /a
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ScheduledShutdown
echo ============================================
echo  BATLAB - ScheduledShutdown
echo ============================================
set "MIN=30"
if not "%~1"=="" set "MIN=%~1"
echo(%MIN%| findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (echo Valor invalido: %MIN%. Use apenas numeros. & goto :fim)
echo [ATENCAO] O computador sera DESLIGADO em %MIN% minutos.
echo Depois voce pode cancelar com: shutdown /a
choice /c SN /m "Agendar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$m=[int]('%MIN%'); if($m -lt 1 -or $m -gt 10080){ Write-Host 'Valor fora do intervalo: 1 a 10080 minutos.' } else { shutdown.exe /s /t ($m*60); Write-Host ('Desligamento agendado: ' + $m + ' minutos. Cancelar: shutdown /a') }"
:fim
echo.
pause