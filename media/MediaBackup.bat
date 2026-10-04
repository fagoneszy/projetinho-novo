:: ============================================================
:: BATLAB | MediaBackup.bat | v1.0.0
:: @desc      Backup de fotos e videos com robocopy
:: @category  media
:: @admin     no
:: @risk      medium
:: @undo      Remova a copia criada na pasta de destino (a origem nao foi alterada)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MediaBackup
echo ============================================
echo  BATLAB - MediaBackup
echo ============================================
set "SRC=%~1"
set "DST=%~2"
if "%SRC%"=="" goto :uso
if "%DST%"=="" goto :uso
if not exist "%SRC%" (
    echo [ERRO] Pasta de origem nao encontrada: %SRC%
    goto :fim
)
echo [ATENCAO] Os arquivos serao COPIADOS com robocopy (/E).
echo Nenhum arquivo sera apagado na origem nem no destino.
echo Origem:
echo   %SRC%
echo Destino:
echo   %DST%
echo.
set "N=0"
for /f %%c in ('powershell -NoProfile -Command "(Get-ChildItem -LiteralPath $env:SRC -File -Recurse -EA SilentlyContinue).Count"') do set "N=%%c"
if not defined N set "N=0"
echo Arquivos encontrados na origem: %N%
echo Amostra dos arquivos (lista parcial):
powershell -NoProfile -Command "Get-ChildItem -LiteralPath $env:SRC -File -Recurse -EA SilentlyContinue | Select-Object -First 15 Name | Format-Table -AutoSize"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if not exist "%DST%" md "%DST%" 2>nul
echo Copiando...
robocopy "%SRC%" "%DST%" /E /COPY:DAT /R:1 /W:1 /NP /NFL /NDL /NJH /NJS
set "RC=%ERRORLEVEL%"
if %RC% LSS 8 (echo Backup concluido. Codigo do robocopy: %RC%) else (echo [ERRO] Robocopy falhou. Codigo: %RC%)
goto :fim
:uso
echo [ERRO] Uso: MediaBackup.bat "pasta\origem" "pasta\destino"
:fim
echo.
pause