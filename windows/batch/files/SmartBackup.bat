:: ============================================================
:: BATLAB | SmartBackup.bat | v1.0.0
:: @desc      Backup incremental com robocopy (nao reprocessa iguais)
:: @category  files
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
:: @undo      Apague a pasta de destino do backup incremental
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SmartBackup
echo ============================================
echo  BATLAB - SmartBackup
echo ============================================
set "SRC=%~1"
set "DST=%~2"
if not defined SRC set /p "SRC=Pasta de origem: "
if not defined DST set /p "DST=Pasta de destino do backup incremental: "
if not defined SRC (echo [ERRO] Origem nao informada. & goto :fim)
if not defined DST (echo [ERRO] Destino nao informado. & goto :fim)
if not exist "%SRC%\" (echo [ERRO] Origem nao encontrada: %SRC% & goto :fim)
echo [ATENCAO] Backup INCREMENTAL - somente novos ou alterados serao copiados.
echo   Origem:  %SRC%
echo   Destino: %DST%
echo Arquivos identicos no destino NAO serao reprocessados (/FFT + robocopy).
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if not exist "%DST%" mkdir "%DST%"
robocopy "%SRC%" "%DST%" /E /XJ /FFT /R:2 /W:2 /NFL /NDL /NJH /NP >nul
if %ERRORLEVEL% GEQ 8 (echo [ERRO] Backup incremental falhou. Codigo %ERRORLEVEL%.) else (echo Feito. Backup incremental concluido em %DST%.)
:fim
echo.
pause
