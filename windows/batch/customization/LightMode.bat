:: ============================================================
:: BATLAB | LightMode.bat | v1.0.0
:: @desc      Ativa o tema claro do Windows
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry write
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Execute DarkMode.bat (AppsUseLightTheme=0 e SystemUsesLightTheme=0)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LightMode
echo ============================================
echo  BATLAB - LightMode
echo ============================================
set "KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
echo [ATENCAO] O tema claro do Windows sera ativado.
echo O registro do usuario sera alterado:
echo   %KEY%
echo   AppsUseLightTheme = 1
echo   SystemUsesLightTheme = 1
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg add "%KEY%" /v AppsUseLightTheme /t REG_DWORD /d 1 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
reg add "%KEY%" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
echo Tema claro ativado.
echo [!] Feche e abra os aplicativos para ver o efeito completo.
echo [Dica] Nao e preciso reiniciar o Explorer.
:fim
echo.
pause
