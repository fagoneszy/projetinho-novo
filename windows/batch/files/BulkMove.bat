:: ============================================================
:: BATLAB | BulkMove.bat | v1.0.0
:: @desc      Move arquivos em massa conforme criterio
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
:: @undo      Mova os arquivos de volta para a pasta de origem
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BulkMove
echo ============================================
echo  BATLAB - BulkMove
echo ============================================
set "PAT=%~1"
set "DEST=%~2"
if not defined PAT set /p "PAT=Padrao dos arquivos (ex: *.txt): "
if not defined DEST set /p "DEST=Pasta de destino: "
if not defined PAT (echo [ERRO] Padrao nao informado. & goto :fim)
if not defined DEST (echo [ERRO] Destino nao informado. & goto :fim)
if not exist "%DEST%\" (echo [ERRO] Destino nao encontrado: %DEST% & goto :fim)
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d "%PAT%" 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhum arquivo corresponde ao padrao %PAT%. & goto :fim)
echo [ATENCAO] %COUNT% arquivo(s) serao MOVIDOS.
echo   Origem:  %CD%
echo   Padrao:  %PAT%
echo   Destino: %DEST%
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
move /Y "%PAT%" "%DEST%" >nul
if errorlevel 1 (echo [ERRO] Falha ao mover - confira permissao e caminhos.) else (echo Feito. %COUNT% arquivo(s) movido(s).)
:fim
echo.
pause
