:: ============================================================
:: BATLAB | WifiProfileExport.bat | v1.0.0
:: @desc      Exporta os perfis Wi-Fi para arquivos XML em uma pasta
:: @category  network
:: @admin     no
:: @risk      medium
:: @undo      Apagar a pasta de exportacao com os XMLs
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WifiProfileExport
echo ============================================
echo  BATLAB - WifiProfileExport
echo ============================================
set "DEST=%~1"
if not defined DEST set "DEST=%CD%\wifi-profiles"
echo [ATENCAO] Vai exportar os perfis Wi-Fi (com senha) para XML.
echo Pasta de destino: %DEST%
echo [!] Os XMLs gerados contem credenciais em texto puro.
if exist "%DEST%" echo [!] A pasta ja existe e os arquivos serao sobrescritos.
choice /c SN /m "Exportar os perfis? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if not exist "%DEST%" mkdir "%DEST%"
if not exist "%DEST%" (echo [ERRO] Falha ao criar a pasta %DEST%. & goto :fim)
netsh wlan export profile folder="%DEST%" key=clear
if errorlevel 1 (echo [!] Exportacao retornou erro. & goto :fim)
echo.
echo [OK] Perfis exportados para %DEST%
echo [i] Desfazer: apague a pasta %DEST%
echo Feito.
:fim
echo.
pause