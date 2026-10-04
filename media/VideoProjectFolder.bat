:: ============================================================
:: BATLAB | VideoProjectFolder.bat | v1.0.0
:: @desc      Cria a estrutura de um projeto de video (Raw, Edicao, Assets, Export)
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta do projeto criada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - VideoProjectFolder
echo ============================================
echo  BATLAB - VideoProjectFolder
echo ============================================
set "BASE=%USERPROFILE%\Videos\Projetos"
if not "%~1"=="" set "BASE=%~1"
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
if not defined D (
    echo [ERRO] Nao foi possivel obter a data atual.
    goto :fim
)
set "P=%BASE%\Projeto_%D%"
echo Criando a estrutura do projeto de video em:
echo   %P%
for %%d in (Raw Edicao Assets Export) do md "%P%\%%d" 2>nul
if not exist "%P%\Export" (
    echo [ERRO] Nao foi possivel criar a estrutura.
    goto :fim
)
echo Estrutura criada: Raw, Edicao, Assets, Export.
start "" explorer "%P%"
if errorlevel 1 echo [!] Confira se a janela do Explorer abriu.
echo Pronto.
:fim
echo.
pause