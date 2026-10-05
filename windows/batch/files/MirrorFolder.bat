:: ============================================================
:: BATLAB | MirrorFolder.bat | v1.0.0
:: @desc      Espelha uma pasta apagando no destino o que nao existe na origem (robocopy /MIR)
:: @category  files
:: @platform windows
:: @admin     no
:: @risk      high
:: @writes user
:: @deletes files
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Irreversivel para os arquivos apagados no destino - use /dryrun antes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MirrorFolder
echo ============================================
echo  BATLAB - MirrorFolder
echo ============================================
set "DRY="
set "SRC="
set "DST="
if /i "%~1"=="/dryrun" set "DRY=1"
if /i "%~2"=="/dryrun" set "DRY=1"
if /i "%~3"=="/dryrun" set "DRY=1"
if not "%~1"=="" if /i not "%~1"=="/dryrun" set "SRC=%~1"
if not "%~2"=="" if /i not "%~2"=="/dryrun" set "DST=%~2"
if not defined DST if not "%~3"=="" if /i not "%~3"=="/dryrun" set "DST=%~3"
if not defined SRC set /p "SRC=Pasta de ORIGEM: "
if not defined DST set /p "DST=Pasta de DESTINO (espelho): "
if not defined SRC (echo [ERRO] Origem nao informada. & goto :fim)
if not defined DST (echo [ERRO] Destino nao informado. & goto :fim)
if not exist "%SRC%\" (echo [ERRO] Origem nao encontrada: %SRC% & goto :fim)
echo ============================================================
echo  [ATENCAO] O robocopy /MIR ESPELHA a origem no destino.
echo  Arquivos que existirem APENAS no destino serao APAGADOS!
echo ============================================================
echo   Origem:  %SRC%
echo   Destino: %DST%
echo Lista do que aconteceria (simulacao /L):
robocopy "%SRC%" "%DST%" /MIR /L /FP /NS /NC /NFL /NDL /NJH
if defined DRY (echo [/dryrun] Nenhuma alteracao feita. & goto :fim)
choice /c SN /m "Espelhar a pasta origem? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo [ATENCAO] Confirmacao final: /MIR apaga tudo que nao existe na origem.
choice /c SN /m "Confirmar espelhamento? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
robocopy "%SRC%" "%DST%" /MIR /XJ /R:1 /W:1 /NFL /NDL /NJH /NP >nul
if %ERRORLEVEL% GEQ 8 (echo [ERRO] Espelhamento falhou. Codigo %ERRORLEVEL%.) else (echo Feito. Destino espelhado.)
:fim
echo.
pause
