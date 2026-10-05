:: ============================================================
:: BATLAB | WifiPasswordBackup.bat | v1.0.0
:: @desc      Exporta as senhas dos perfis Wi-Fi salvas para um TXT
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes user
:: @deletes files
:: @registry none
:: @services none
:: @tasks none
:: @network read
:: @restart none
:: @undo      Apagar o arquivo TXT gerado com as senhas
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WifiPasswordBackup
echo ============================================
echo  BATLAB - WifiPasswordBackup
echo ============================================
echo [ATENCAO] Este script exporta SENHAS de redes Wi-Fi salvas para um TXT.
echo O arquivo gerado contem dado SENSIVEIS em texto puro.
echo Nao compartilhe o arquivo e apague-o apos o uso.
echo.
set "SAIDA=%~1"
if not defined SAIDA set "SAIDA=%CD%\wifi-senhas.txt"
echo Arquivo de saida: %SAIDA%
if exist "%SAIDA%" echo [!] O arquivo ja existe e sera sobrescrito.
choice /c SN /m "Continuar com a exportacao? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "TMPW=%TEMP%\wperf_%RANDOM%.txt"
netsh wlan show profiles | findstr /i "Profile Perfil" > "%TMPW%"
echo Gerando relatorio em %SAIDA%...
> "%SAIDA%" echo Senhas Wi-Fi - %COMPUTERNAME% - %DATE% %TIME%
for /f "usebackq tokens=1,* delims=:" %%a in ("%TMPW%") do call :salva "%%b"
del "%TMPW%" >nul 2>&1
echo.
echo [OK] Relatorio gravado em %SAIDA%
echo [i] Desfazer: apague o arquivo %SAIDA%
echo [i] Seguranca: apague o TXT apos o uso.
goto :fim

:salva
set "PERFIL=%~1"
if "%PERFIL%"=="" goto :eof
for /f "tokens=* delims= " %%x in ("%PERFIL%") do set "PERFIL=%%x"
if "%PERFIL%"=="" goto :eof
echo Perfil: %PERFIL%
netsh wlan show profile name="%PERFIL%" key=clear >> "%SAIDA%" 2>&1
goto :eof

:fim
echo.
pause
