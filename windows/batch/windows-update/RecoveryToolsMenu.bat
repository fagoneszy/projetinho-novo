:: ============================================================
:: BATLAB | RecoveryToolsMenu.bat | v1.0.0
:: @desc      Menu com as ferramentas de recuperacao
:: @category  windows-update
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Abre ferramentas do BATLAB; cada uma tem seu proprio desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RecoveryToolsMenu
echo ============================================
echo  BATLAB - RecoveryToolsMenu
echo ============================================
echo Ferramentas de recuperacao desta pasta:
powershell -NoProfile -Command "foreach($n in @('UpdateServiceRepair.bat','RestorePointCreator.bat','BootConfigurationBackup.bat','SafeModeHelper.bat','WindowsRepairBundle.bat')){ if(Test-Path -LiteralPath ('%~dp0'+$n)){ Write-Host ('  [ok]    '+$n) } else { Write-Host ('  [falta] '+$n) } }"
echo   1 - UpdateServiceRepair      reinicia servicos do Windows Update
echo   2 - RestorePointCreator      cria um ponto de restauracao
echo   3 - BootConfigurationBackup  exporta backup do BCD
echo   4 - SafeModeHelper           modo seguro com confirmacao
echo   5 - WindowsRepairBundle      DISM + sfc com confirmacao dupla
echo   6 - Sair
choice /c 123456 /m "Escolha (1-6)"
if errorlevel 6 goto :fim
if errorlevel 5 (start "" "%~dp0WindowsRepairBundle.bat" & goto :fim)
if errorlevel 4 (start "" "%~dp0SafeModeHelper.bat" & goto :fim)
if errorlevel 3 (start "" "%~dp0BootConfigurationBackup.bat" & goto :fim)
if errorlevel 2 (start "" "%~dp0RestorePointCreator.bat" & goto :fim)
if errorlevel 1 (start "" "%~dp0UpdateServiceRepair.bat" & goto :fim)
goto :fim
:fim
echo.
pause
endlocal
