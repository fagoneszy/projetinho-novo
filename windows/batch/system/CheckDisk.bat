:: ============================================================
:: BATLAB | CheckDisk.bat | v1.0.0
:: @desc      Verifica integridade do disco (chkdsk /f)
:: @category  system
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      N/A - as correcoes do chkdsk nao tem desfazer; faca backup antes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CheckDisk
echo ============================================
echo  BATLAB - CheckDisk
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
set "DRV=%~1"
if not defined DRV set /p "DRV=Unidade a verificar (ex: C): "
if not defined DRV set "DRV=C:"
set "DRV=%DRV::=%"
echo [ATENCAO] O chkdsk /f corrigira erros do sistema de arquivos em %DRV%:
echo [ATENCAO] Se a unidade estiver em uso, o Windows pode pedir um REINICIO
echo           para executar a verificacao na proxima inicializacao.
echo Responda Y caso seja perguntado sobre agendar a verificacao.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
chkdsk %DRV%: /f
if errorlevel 1 (echo [!] chkdsk pediu reinicio ou encontrou erros - rode novamente apos reiniciar.) else (echo Feito. Nenhum erro encontrado na unidade %DRV%.)
:fim
echo.
pause
