:: ============================================================
:: BATLAB | AutoLogGenerator.bat | v1.0.0
:: @desc      Registra linhas de log com data/hora em arquivo
:: @category  automation
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      Apague o arquivo batlab_log.txt
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoLogGenerator
echo ============================================
echo  BATLAB - AutoLogGenerator
echo ============================================
set "LOG=%~dp0batlab_log.txt"
if /i "%~1"=="/loop" goto :loop
if "%~1"=="" (set /p "MSG=Mensagem: ") else set "MSG=%~1"
if not defined MSG (echo Mensagem vazia. & goto :fim)
>>"%LOG%" echo [%date% %time%] %MSG%
echo Registrado em %LOG%
goto :fim
:loop
echo Modo repetido (vazio encerra). Ctrl+C tambem encerra.
:lp2
set "MSG="
set /p "MSG=Mensagem: "
if not defined MSG goto :fim
>>"%LOG%" echo [%date% %time%] %MSG%
echo [%time%] registrado.
timeout /t 60 /nobreak >nul
goto :lp2
:fim
echo.
pause
