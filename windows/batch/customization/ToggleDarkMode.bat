:: ============================================================
:: BATLAB | ToggleDarkMode.bat | v1.0.0
:: @desc      Alterna entre tema escuro e claro
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
:: @undo      Execute DarkMode.bat ou LightMode.bat conforme o tema desejado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ToggleDarkMode
echo ============================================
echo  BATLAB - ToggleDarkMode
echo ============================================
set "KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
set "CUR=1"
for /f "tokens=3" %%a in ('reg query "%KEY%" /v AppsUseLightTheme 2^>nul ^| findstr /i "AppsUseLightTheme"') do set "CUR=%%a"
echo Tema claro atual (AppsUseLightTheme): %CUR%
set "NEW=0"
set "NOME=escuro"
if "%CUR%"=="0" (set "NEW=1" & set "NOME=claro")
echo [ATENCAO] O tema %NOME% sera ativado.
echo O registro do usuario sera alterado em:
echo   %KEY%
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg add "%KEY%" /v AppsUseLightTheme /t REG_DWORD /d %NEW% /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
reg add "%KEY%" /v SystemUsesLightTheme /t REG_DWORD /d %NEW% /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
echo Tema %NOME% ativado.
echo [!] Feche e abra os aplicativos para ver o efeito completo.
:fim
echo.
pause
