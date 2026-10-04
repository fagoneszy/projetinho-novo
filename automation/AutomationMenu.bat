:: ============================================================
:: BATLAB | AutomationMenu.bat | v1.0.0
:: @desc      Menu com os utilitarios de automatizacao
:: @category  automation
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutomationMenu
echo ============================================
echo  BATLAB - AutomationMenu
echo ============================================
:menu
cls
echo ============================================
echo  BATLAB - Automatizacao
echo ============================================
echo   1. AutoBackup          7. AutoLogGenerator
echo   2. AutoArchive         8. AutoReportGenerator
echo   3. AutoCleanup         9. AutoNetworkMonitor
echo   4. AutoOrganize       10. AutoWebsiteMonitor
echo   5. FolderWatcher      11. AutoProcessMonitor
echo   6. TaskList            0. Sair
echo ============================================
set /p "OP=Opcao: "
if "%OP%"=="1" (call "%~dp0AutoBackup.bat" & goto :menu)
if "%OP%"=="2" (call "%~dp0AutoArchive.bat" & goto :menu)
if "%OP%"=="3" (call "%~dp0AutoCleanup.bat" & goto :menu)
if "%OP%"=="4" (call "%~dp0AutoOrganize.bat" & goto :menu)
if "%OP%"=="5" (call "%~dp0FolderWatcher.bat" & goto :menu)
if "%OP%"=="6" (call "%~dp0TaskList.bat" & goto :menu)
if "%OP%"=="7" (call "%~dp0AutoLogGenerator.bat" & goto :menu)
if "%OP%"=="8" (call "%~dp0AutoReportGenerator.bat" & goto :menu)
if "%OP%"=="9" (call "%~dp0AutoNetworkMonitor.bat" & goto :menu)
if "%OP%"=="10" (call "%~dp0AutoWebsiteMonitor.bat" & goto :menu)
if "%OP%"=="11" (call "%~dp0AutoProcessMonitor.bat" & goto :menu)
if "%OP%"=="0" goto :fim
echo Opcao invalida.
timeout /t 2 >nul
goto :menu
:fim
echo.
pause