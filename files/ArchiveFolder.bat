:: ============================================================
:: BATLAB | ArchiveFolder.bat | v1.0.0
:: @desc      Compacta a pasta atual em um arquivo ZIP
:: @category  files
:: @admin     no
:: @risk      low
:: @undo      Apague o arquivo ZIP gerado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ArchiveFolder
echo ============================================
echo  BATLAB - ArchiveFolder
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "D=%%i"
for %%i in ("%CD%") do (set "NAME=%%~nxi" & set "PARENT=%%~dpi")
set "OUT=%~1"
if not defined OUT set "OUT=%PARENT%%NAME%_%D%.zip"
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhum arquivo na pasta atual. & goto :fim)
echo Gerando ZIP com %COUNT% entrada(s) de %CD%
echo [INFO] Subpastas e arquivos do nivel atual entram na compactacao.
echo Arquivo de saida: %OUT%
echo [INFO] O ZIP e criado fora da pasta para nao se incluir.
echo.
powershell -NoProfile -Command "Compress-Archive -Path * -DestinationPath '%OUT%' -Force"
if errorlevel 1 (echo [ERRO] Falha ao criar o ZIP.) else (echo Feito. ZIP gerado: %OUT%)
:fim
echo.
pause