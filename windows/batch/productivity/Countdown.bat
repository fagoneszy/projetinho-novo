:: ============================================================
:: BATLAB | Countdown.bat | v1.0.0
:: @desc      Contagem regressiva com alerta sonoro no final
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - Countdown
echo ============================================
echo  BATLAB - Countdown
echo ============================================
if "%~1"=="" (set /p "MIN=Minutos: ") else set "MIN=%~1"
if not defined MIN goto :sair
set /a S=%MIN%*60
:loop
if %S% LSS 1 goto :acabou
set /a MM=S/60, SS=S%%60
cls
echo.
echo      Tempo restante: %MM% min %SS% s
timeout /t 1 /nobreak >nul
set /a S-=1
goto :loop
:acabou
powershell -NoProfile -Command "[console]::beep(990,800)"
echo TEMPO ESGOTADO!
:sair
echo.
pause
