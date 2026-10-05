:: ============================================================
:: BATLAB | Pomodoro.bat | v1.0.0
:: @desc      Temporizador Pomodoro (25 min foco / 5 min pausa, com alerta sonoro)
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - Pomodoro
echo ============================================
echo  BATLAB - Pomodoro
echo ============================================
set "FOCO=25"
set "PAUSA=5"
if not "%~1"=="" set "FOCO=%~1"
set /a FOCOS=%FOCO%*60
set /a PAUSAS=%PAUSA%*60
echo Pomodoro: %FOCO% min de foco / %PAUSA% min de pausa. Ctrl+C para parar.
:loop
echo.
echo [%TIME%] === FOCO %FOCO% min ===
timeout /t %FOCOS% /nobreak >nul
powershell -NoProfile -Command "[console]::beep(880,600)"
echo [%TIME%] === PAUSA %PAUSA% min ===
timeout /t %PAUSAS% /nobreak >nul
powershell -NoProfile -Command "[console]::beep(660,600)"
goto :loop
echo.
pause
