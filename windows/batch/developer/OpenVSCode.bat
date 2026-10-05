:: ============================================================
:: BATLAB | OpenVSCode.bat | v1.0.0
:: @desc      Abre o VS Code na pasta atual ou na pasta informada
:: @category  developer
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenVSCode
echo ============================================
echo  BATLAB - OpenVSCode
echo ============================================
set "P=%~1"
if not defined P set "P=%CD%"
echo Abrindo o VS Code em: %P%
where code >nul 2>&1
if errorlevel 1 (echo [ERRO] code nao encontrado no PATH. Instale o VS Code. & goto :fim)
if not exist "%P%" (echo [ERRO] Pasta nao existe: %P% & goto :fim)
call code "%P%"
if errorlevel 1 (echo [!] O VS Code retornou erro ao abrir. & goto :fim)
echo.
echo [OK] VS Code aberto em %P%
echo Feito.
:fim
echo.
pause