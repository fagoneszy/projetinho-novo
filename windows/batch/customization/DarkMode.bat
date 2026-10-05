:: ============================================================
:: BATLAB | DarkMode.bat | v1.0.0
:: @desc      Ativa o tema escuro do Windows
:: @category  customization
:: @admin     no
:: @risk      medium
:: @undo      Execute LightMode.bat (AppsUseLightTheme=1 e SystemUsesLightTheme=1)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DarkMode
echo ============================================
echo  BATLAB - DarkMode
echo ============================================
set "KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
echo [ATENCAO] O tema escuro do Windows sera ativado.
echo O registro do usuario sera alterado:
echo   %KEY%
echo   AppsUseLightTheme = 0
echo   SystemUsesLightTheme = 0
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg add "%KEY%" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
reg add "%KEY%" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
echo Tema escuro ativado.
echo [!] Feche e abra os aplicativos para ver o efeito completo.
echo [Dica] Nao e preciso reiniciar o Explorer.
:fim
echo.
pause