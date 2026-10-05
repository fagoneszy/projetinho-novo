:: ============================================================
:: BATLAB | DisableDeveloperMode.bat | v1.0.0
:: @desc      Desativa o Modo de Desenvolvedor
:: @category  customization
:: @admin     yes
:: @risk      medium
:: @undo      Execute EnableDeveloperMode.bat (AllowDevelopmentWithoutDevLicense=1)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DisableDeveloperMode
echo ============================================
echo  BATLAB - DisableDeveloperMode
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
set "KEY=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
echo [ATENCAO] O Modo de Desenvolvedor do Windows sera desativado.
echo Aplicativos nao assinados deixaram de ser permitidos.
echo O registro da maquina sera alterado:
echo   %KEY%
echo   AllowDevelopmentWithoutDevLicense = 0
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg add "%KEY%" /v AllowDevelopmentWithoutDevLicense /t REG_DWORD /d 0 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
echo Modo de Desenvolvedor desativado.
echo [!] Para ativar de novo, execute EnableDeveloperMode.bat.
echo [Dica] Voce pode fechar esta janela.
:fim
echo.
pause