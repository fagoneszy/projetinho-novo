:: ============================================================
:: BATLAB | AutoStartupManager.bat | v1.0.0
:: @desc      Lista e remove itens da inicializacao do Windows
:: @category  automation
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry write
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Rode novamente e readicione o valor do registro
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoStartupManager
echo ============================================
echo  BATLAB - AutoStartupManager
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo === Inicializacao do usuario (HKCU) ===
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
echo.
echo === Inicializacao de todos (HKLM) ===
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
echo.
echo   1. Remover um item
echo   0. Sair
set /p "OP=Opcao: "
if "%OP%"=="0" goto :fim
if not "%OP%"=="1" (echo Opcao invalida. & goto :fim)
set /p "HIVE=Qual? (HKCU ou HKLM): "
if /i not "%HIVE%"=="HKCU" if /i not "%HIVE%"=="HKLM" (echo HIVE invalido. Use HKCU ou HKLM. & goto :fim)
set /p "CHAVE=Nome exato da chave (valor): "
if not defined CHAVE goto :fim
echo [ATENCAO] Vai apagar da inicializacao:
echo    %HIVE%\Software\Microsoft\Windows\CurrentVersion\Run
echo    valor: %CHAVE%
echo O programa nao sera desinstalado, so para de iniciar.
choice /c SN /m "Remover? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg delete "%HIVE%\Software\Microsoft\Windows\CurrentVersion\Run" /v "%CHAVE%" /f
if errorlevel 1 (echo [ERRO] Valor nao encontrado ou falha ao apagar.) else (echo Removido da inicializacao.)
:fim
echo.
pause
