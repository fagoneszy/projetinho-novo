:: ============================================================
:: BATLAB | NetworkAdapters.bat | v1.0.0
:: @desc      Lista as interfaces de rede com netsh interface show
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NetworkAdapters
echo ============================================
echo  BATLAB - NetworkAdapters
echo ============================================
echo Listando interfaces de rede do Windows...
echo Host: %COMPUTERNAME%
echo.
netsh interface show interface
if errorlevel 1 (echo [!] Falha ao listar as interfaces. & goto :fim)
echo.
echo [i] Colunas: Admin State, State, Type, Interface Name.
echo [i] Para reiniciar um adaptador use RestartNetwork.bat.
echo Feito.
:fim
echo.
pause
