:: ============================================================
:: BATLAB | WindowsUpdateCheck.bat | v1.0.0
:: @desc      Forca a busca de atualizacoes do Windows
:: @category  system
:: @platform windows
:: @admin     yes
:: @risk      low
:: @undo      N/A - apenas dispara uma busca de atualizacoes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WindowsUpdateCheck
echo ============================================
echo  BATLAB - WindowsUpdateCheck
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo Forcando a busca de atualizacoes do Windows...
echo [INFO] Usa o UsoClient StartScan do Windows Update.
echo [INFO] A busca roda em segundo plano.
echo Acompanhe em: Configuracoes ^> Atualizacao do Windows ^> Verificar atualizacoes.
echo.
UsoClient StartScan
if errorlevel 1 (echo [!] UsoClient retornou codigo %ERRORLEVEL%.) else (echo Feito. Busca de atualizacoes iniciada.)
:fim
echo.
pause
