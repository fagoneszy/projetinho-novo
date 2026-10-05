:: ============================================================
:: BATLAB | AutoBackup.bat | v1.0.0
:: @desc      Menu de backups simples com robocopy
:: @category  automation
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes user
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Apague ou mova o destino para desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoBackup
echo ============================================
echo  BATLAB - AutoBackup
echo ============================================
if "%~1"=="" (set /p "ORIG=Pasta de origem: ") else set "ORIG=%~1"
if "%~2"=="" (set /p "DEST=Pasta de destino: ") else set "DEST=%~2"
if not defined ORIG (echo Origem nao definida. & goto :fim)
if not defined DEST (echo Destino nao definido. & goto :fim)
if not exist "%ORIG%" (echo Origem nao encontrada: %ORIG% & goto :fim)
echo [ATENCAO] Vai copiar tudo de:
echo    %ORIG%
echo para:
echo    %DEST%
echo Arquivos iguais no destino serao pulados.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
robocopy "%ORIG%" "%DEST%" /E /XO /R:2 /W:2 /NP /NFL /NDL /MT:8
if errorlevel 8 (echo [ERRO] Robocopy terminou com erro. Verifique as pastas.) else (echo Backup concluido com sucesso.)
:fim
echo.
pause
