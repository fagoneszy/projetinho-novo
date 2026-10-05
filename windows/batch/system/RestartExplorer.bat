:: ============================================================
:: BATLAB | RestartExplorer.bat | v1.0.0
:: @desc      Reinicia o Explorer do Windows
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (o Explorer e recriado pelo proprio Windows)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RestartExplorer
echo ============================================
echo  BATLAB - RestartExplorer
echo ============================================
echo Reiniciando o Explorer do Windows...
echo [INFO] A barra de tarefas e as janelas do Explorer vao piscar.
echo [INFO] Janelas abertas pelo Explorer podem fechar (nada de dados e perdido).
echo [INFO] Se nao reiniciar, abra o Task Manager e rode explorer.exe.
echo.
taskkill /F /IM explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe
timeout /t 2 /nobreak >nul
if errorlevel 1 (echo [!] O Explorer pode nao ter reiniciado - abra o Task Manager e inicie explorer.exe.) else (echo Feito. Explorer reiniciado.)
:fim
echo.
pause
