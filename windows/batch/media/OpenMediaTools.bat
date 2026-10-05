:: ============================================================
:: BATLAB | OpenMediaTools.bat | v1.0.0
:: @desc      Menu que abre as ferramentas de midia do sistema
:: @category  media
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenMediaTools
echo ============================================
echo  BATLAB - OpenMediaTools
echo ============================================
echo Escolha a ferramenta de midia do Windows:
echo   1 - Paint (desenho e edicao rapida)
echo   2 - Fotografia (visualizador e editor de imagens)
echo   3 - Reprodutor de medios do Windows
echo.
choice /c 123 /m "Opcao"
if errorlevel 3 goto :op3
if errorlevel 2 goto :op2
if errorlevel 1 goto :op1
goto :fim
:op1
echo Abrindo o Paint...
start "" mspaint.exe
if errorlevel 1 (echo [ERRO] Paint nao encontrado.) else (echo Paint solicitado.)
goto :fim
:op2
echo Abrindo o app Fotografia...
start "" ms-photos:
if errorlevel 1 (echo [ERRO] App Fotografia nao encontrado.) else (echo Fotografia solicitada.)
goto :fim
:op3
echo Abrindo o Reprodutor de medios...
start "" wmplayer.exe
if errorlevel 1 (echo [ERRO] Reprodutor nao encontrado.) else (echo Reprodutor solicitado.)
goto :fim
:fim
echo.
pause
