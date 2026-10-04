:: ============================================================
:: BATLAB | CreateScreenshotFolder.bat | v1.0.0
:: @desc      Cria a pasta de capturas do dia e abre
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta do dia criada em Pictures\Screenshots
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CreateScreenshotFolder
echo ============================================
echo  BATLAB - CreateScreenshotFolder
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
if not defined D (
    echo [ERRO] Nao foi possivel obter a data atual.
    goto :fim
)
set "P=%USERPROFILE%\Pictures\Screenshots\%D%"
echo Criando a pasta de capturas do dia:
echo   %P%
md "%P%" 2>nul
if not exist "%P%" (
    echo [ERRO] Nao foi possivel criar a pasta.
    goto :fim
)
echo Pasta criada com sucesso.
start "" explorer "%P%"
if errorlevel 1 echo [!] Confira se a janela do Explorer abriu.
echo Pronto para capturar (Win + Shift + S).
:fim
echo.
pause