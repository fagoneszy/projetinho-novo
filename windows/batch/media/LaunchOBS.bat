:: ============================================================
:: BATLAB | LaunchOBS.bat | v1.0.0
:: @desc      Abre o OBS Studio (caminho configuravel no script)
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LaunchOBS
echo ============================================
echo  BATLAB - LaunchOBS
echo ============================================
set "OBS=C:\Program Files\obs-studio\bin\64bit\obs64.exe"
echo Caminho configurado do OBS:
echo   %OBS%
echo [Dica] Edite a variavel OBS neste script se o OBS estiver em outro local.
if not exist "%OBS%" (
    echo [ERRO] OBS nao encontrado nesse caminho.
    echo [Dica] Procure obs64.exe na pasta de instalacao do OBS.
    goto :fim
)
echo Iniciando o OBS Studio...
start "" "%OBS%"
if errorlevel 1 (echo [ERRO] Falha ao iniciar o OBS.) else (echo OBS solicitado.)
echo Feito.
:fim
echo.
pause