:: ============================================================
:: BATLAB | MeetingFolder.bat | v1.0.0
:: @desc      Cria a pasta de uma reuniao com Ata, Pauta e Apresentacao
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta criada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MeetingFolder
echo ============================================
echo  BATLAB - MeetingFolder
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "TS=%%i"
set "P=Reuniao_%TS%"
if not exist "%P%" mkdir "%P%"
if not exist "%P%\Ata" mkdir "%P%\Ata"
if not exist "%P%\Pauta" mkdir "%P%\Pauta"
if not exist "%P%\Apresentacao" mkdir "%P%\Apresentacao"
echo Pasta da reuniao criada: %CD%\%P%
echo.
pause