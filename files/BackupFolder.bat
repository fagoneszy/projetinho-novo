:: ============================================================
:: BATLAB | BackupFolder.bat | v1.0.0
:: @desc      Backup simples de uma pasta com robocopy
:: @category  files
:: @admin     no
:: @risk      medium
:: @undo      Apague a pasta de destino do backup
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BackupFolder
echo ============================================
echo  BATLAB - BackupFolder
echo ============================================
set "SRC=%~1"
set "DST=%~2"
if not defined SRC set /p "SRC=Pasta de origem: "
if not defined DST set /p "DST=Pasta de destino do backup: "
if not defined SRC (echo [ERRO] Origem nao informada. & goto :fim)
if not defined DST (echo [ERRO] Destino nao informado. & goto :fim)
if not exist "%SRC%\" (echo [ERRO] Origem nao encontrada: %SRC% & goto :fim)
echo [ATENCAO] Sera feito um backup (nada sera apagado).
echo   Origem:  %SRC%
echo   Destino: %DST%
echo O destino sera criado se nao existir.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if not exist "%DST%" mkdir "%DST%"
robocopy "%SRC%" "%DST%" /E /XJ /COPY:DAT /R:1 /W:1 /NFL /NDL /NJH /NP >nul
if %ERRORLEVEL% GEQ 8 (echo [ERRO] Backup falhou. Codigo %ERRORLEVEL%.) else (echo Feito. Backup concluido em %DST%.)
:fim
echo.
pause