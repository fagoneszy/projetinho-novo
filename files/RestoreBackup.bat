:: ============================================================
:: BATLAB | RestoreBackup.bat | v1.0.0
:: @desc      Restaura um backup para a pasta de origem
:: @category  files
:: @admin     no
:: @risk      high
:: @undo      A substituicao nao tem desfazer - use /dryrun antes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RestoreBackup
echo ============================================
echo  BATLAB - RestoreBackup
echo ============================================
set "DRY="
set "BK="
set "DST="
if /i "%~1"=="/dryrun" set "DRY=1"
if /i "%~2"=="/dryrun" set "DRY=1"
if /i "%~3"=="/dryrun" set "DRY=1"
if not "%~1"=="" if /i not "%~1"=="/dryrun" set "BK=%~1"
if not "%~2"=="" if /i not "%~2"=="/dryrun" set "DST=%~2"
if not defined DST if not "%~3"=="" if /i not "%~3"=="/dryrun" set "DST=%~3"
if not defined BK set /p "BK=Pasta que contem o backup: "
if not defined DST set /p "DST=Pasta de destino da restauracao: "
if not defined BK (echo [ERRO] Backup nao informado. & goto :fim)
if not defined DST (echo [ERRO] Destino nao informado. & goto :fim)
if not exist "%BK%\" (echo [ERRO] Pasta do backup nao encontrada: %BK% & goto :fim)
if not exist "%DST%\" (echo [ERRO] Pasta de destino nao encontrada: %DST% & goto :fim)
echo ============================================================
echo  [ATENCAO] Restauracao de backup.
echo  Arquivos do destino iguais aos do backup serao SUBSTITUIDOS.
echo ============================================================
echo   Backup:  %BK%
echo   Destino: %DST%
echo Lista do que sera copiado (simulacao /L):
robocopy "%BK%" "%DST%" /E /L /FP /NS /NC /NFL /NDL /NJH
if defined DRY (echo [/dryrun] Nenhuma alteracao feita. & goto :fim)
choice /c SN /m "Restaurar para este destino? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
choice /c SN /m "Confirmar substituicao no destino? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
robocopy "%BK%" "%DST%" /E /XJ /R:1 /W:1 /NFL /NDL /NJH /NP >nul
if %ERRORLEVEL% GEQ 8 (echo [ERRO] Restauracao falhou. Codigo %ERRORLEVEL%.) else (echo Feito. Backup restaurado em %DST%.)
:fim
echo.
pause