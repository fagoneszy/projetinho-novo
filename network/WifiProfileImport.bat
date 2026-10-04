:: ============================================================
:: BATLAB | WifiProfileImport.bat | v1.0.0
:: @desc      Importa perfis Wi-Fi a partir de XMLs de uma pasta
:: @category  network
:: @admin     no
:: @risk      medium
:: @undo      netsh wlan delete profile name do perfil importado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WifiProfileImport
echo ============================================
echo  BATLAB - WifiProfileImport
echo ============================================
set "SRC=%~1"
if not defined SRC set "SRC=%CD%\wifi-profiles"
echo [ATENCAO] Vai importar perfis Wi-Fi a partir de XMLs da pasta:
echo   %SRC%
echo Isso adiciona redes salvas (com senha) ao Windows.
if not exist "%SRC%" (echo [ERRO] Pasta nao encontrada: %SRC% & goto :fim)
set "ACHEI="
for %%f in ("%SRC%\*.xml") do if exist "%%f" set "ACHEI=1"
if not defined ACHEI (echo [!] Nenhum arquivo .xml encontrado. & goto :fim)
echo XMLs que serao importados:
dir /b "%SRC%\*.xml"
choice /c SN /m "Importar estes perfis? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
for %%f in ("%SRC%\*.xml") do (
    echo Importando %%~nxf ...
    netsh wlan add profile filename="%%f"
)
echo.
echo [OK] Importacao concluida.
echo [i] Desfazer: netsh wlan delete profile name=^<nome^>
:fim
echo.
pause