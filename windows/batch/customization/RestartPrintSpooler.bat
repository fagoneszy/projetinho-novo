:: ============================================================
:: BATLAB | RestartPrintSpooler.bat | v1.0.0
:: @desc      Reinicia o servico de impressao (spooler)
:: @category  customization
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry none
:: @services write
:: @tasks none
:: @network none
:: @restart none
:: @undo      Execute net start spooler ou reinicie o servico Spooler pelo console Services.msc
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RestartPrintSpooler
echo ============================================
echo  BATLAB - RestartPrintSpooler
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo [ATENCAO] O servico de impressao (spooler) sera reiniciado.
echo Impressoes em andamento podem ser canceladas e a fila sera limpa.
echo.
echo Estado atual do servico:
sc query spooler | findstr /i "STATE"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Parando o servico Spooler...
net stop spooler /y
if errorlevel 1 echo [!] Aviso ao parar o servico (pode ja estar parado).
echo Iniciando o servico Spooler...
net start spooler
if errorlevel 1 (echo [ERRO] Falha ao iniciar o Spooler. & goto :fim)
echo Spooler reiniciado com sucesso.
echo [Dica] Verifique a fila de impressao antes de imprimir de novo.
:fim
echo.
pause
