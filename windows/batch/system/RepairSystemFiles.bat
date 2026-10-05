:: ============================================================
:: BATLAB | RepairSystemFiles.bat | v1.0.0
:: @desc      Verifica e repara arquivos do sistema (sfc /scannow)
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
:: @undo      N/A - o sfc restaura arquivos a partir do proprio Windows
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RepairSystemFiles
echo ============================================
echo  BATLAB - RepairSystemFiles
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo [ATENCAO] O sfc /scannow verifica e repara arquivos protegidos do Windows.
echo [ATENCAO] Isso pode DEMORAR de 10 a 30 minutos. Nao feche a janela.
echo [ATENCAO] Pode ser necessario reiniciar o Windows ao final.
choice /c SN /m "Iniciar a verificacao? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Iniciando a verificacao - aguarde...
sfc /scannow
if errorlevel 1 (echo [!] sfc terminou com codigo %ERRORLEVEL% - veja C:\Windows\Logs\CBS\CBS.log) else (echo Feito. Verificacao concluida sem erros.)
:fim
echo.
pause
