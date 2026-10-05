:: ============================================================
:: BATLAB | EnableDeveloperMode.bat | v1.0.0
:: @desc      Ativa o Modo de Desenvolvedor do Windows
:: @category  customization
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
:: @undo      Execute DisableDeveloperMode.bat (AllowDevelopmentWithoutDevLicense=0)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - EnableDeveloperMode
echo ============================================
echo  BATLAB - EnableDeveloperMode
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
set "KEY=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
echo [ATENCAO] O Modo de Desenvolvedor do Windows sera ativado.
echo Isso permite instalar aplicativos nao assinados (sideload).
echo O registro da maquina sera alterado:
echo   %KEY%
echo   AllowDevelopmentWithoutDevLicense = 1
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg add "%KEY%" /v AllowDevelopmentWithoutDevLicense /t REG_DWORD /d 1 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
echo Modo de Desenvolvedor ativado.
echo [!] Para desfazer, execute DisableDeveloperMode.bat.
echo [Dica] Voce pode fechar esta janela.
:fim
echo.
pause
