:: ============================================================
:: BATLAB | WindowsUpdateTools.bat | v1.0.0
:: @desc      Menu de manutencao do Windows Update (buscar/baixar/instalar/reiniciar)
:: @category  system
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes system
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      N/A - acoes do Windows Update sao gerenciadas pelo proprio Windows
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WindowsUpdateTools
echo ============================================
echo  BATLAB - WindowsUpdateTools
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
:menu
echo ============================================
echo  Manutencao do Windows Update (UsoClient)
echo ============================================
echo   1. Buscar atualizacoes   (StartScan)
echo   2. Baixar atualizacoes   (StartDownload)
echo   3. Instalar atualizacoes (StartInstall)
echo   4. Reiniciar para concluir (Restart)
echo   5. Sair
choice /c 12345 /n /m "Escolha uma opcao: "
if errorlevel 5 goto :fim
if errorlevel 4 (set "UC=Restart" & goto :run)
if errorlevel 3 (set "UC=StartInstall" & goto :run)
if errorlevel 2 (set "UC=StartDownload" & goto :run)
set "UC=StartScan"
:run
echo [ATENCAO] Sera executado: UsoClient %UC%
choice /c SN /m "Confirmar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :menu)
UsoClient %UC%
if errorlevel 1 (echo [!] UsoClient retornou codigo %ERRORLEVEL%.) else (echo Feito: comando %UC% enviado.)
goto :menu
:fim
echo.
pause
