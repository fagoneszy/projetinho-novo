:: ============================================================
:: BATLAB | EventLogExport.bat | v1.0.0
:: @desc      Exporta os logs de eventos do sistema para arquivo
:: @category  system
:: @admin     yes
:: @risk      low
:: @undo      Apague o arquivo .evtx exportado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - EventLogExport
echo ============================================
echo  BATLAB - EventLogExport
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "D=%%i"
set "OUT=%~1"
if not defined OUT set "OUT=%CD%\eventlog_%D%.evtx"
echo Exportando o log de eventos do Sistema para:
echo   %OUT%
echo [INFO] Usa wevtutil epl - o arquivo abre no Visualizador de Eventos.
echo [INFO] O arquivo existente sera sobrescrito.
echo.
wevtutil epl System "%OUT%" /ow:true
if errorlevel 1 (echo [ERRO] Falha na exportacao - verifique permissao da pasta.) else (echo Feito. Log exportado: %OUT%)
:fim
echo.
pause