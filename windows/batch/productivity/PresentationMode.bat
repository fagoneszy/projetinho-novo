:: ============================================================
:: BATLAB | PresentationMode.bat | v1.0.0
:: @desc      Prepara o PC para apresentacao (sem sono, tela em 15 min)
:: @category  productivity
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
:: @undo      powercfg /change standby-timeout-ac 30
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PresentationMode
echo ============================================
echo  BATLAB - PresentationMode
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo [ATENCAO] Vai desativar o sono (na tomada) e definir tela em 15 min.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powercfg /change standby-timeout-ac 0
powercfg /change monitor-timeout-ac 15
echo Sono: DESATIVADO | Monitor: 15 min
echo Desfazer: powercfg /change standby-timeout-ac 30
:fim
echo.
pause
