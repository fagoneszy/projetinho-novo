:: ============================================================
:: BATLAB | BulkCopy.bat | v1.0.0
:: @desc      Copia arquivos em massa conforme criterio
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
:: @undo      Apague os arquivos copiados no destino
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BulkCopy
echo ============================================
echo  BATLAB - BulkCopy
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
echo [ATENCAO] %COUNT% arquivo(s) serao COPIADOS.
echo   Origem:  %CD%
echo   Padrao:  %PAT%
echo   Destino: %DEST%
echo Os arquivos de origem permanecem intactos.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
copy /Y "%PAT%" "%DEST%" >nul
if errorlevel 1 (echo [ERRO] Falha na copia - confira permissao e caminhos.) else (echo Feito. %COUNT% arquivo(s) copiado(s).)
:fim
echo.
pause
