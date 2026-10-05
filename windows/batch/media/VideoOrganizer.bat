:: ============================================================
:: BATLAB | VideoOrganizer.bat | v1.0.0
:: @desc      Organiza videos por ano e mes
:: @category  media
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
:: @undo      Mova os arquivos das subpastas AAAA-MM de volta para a raiz de Videos
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - VideoOrganizer
echo ============================================
echo  BATLAB - VideoOrganizer
echo ============================================
set "P=%USERPROFILE%\Videos"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo [ATENCAO] Os videos de primeiro nivel serao movidos para
echo           subpastas AAAA-MM dentro da pasta Videos.
echo Nada sera apagado; os arquivos apenas mudam de pasta.
echo.
echo Arquivos que serao afetados (lista parcial):
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Videos\*') -Include *.mp4,*.avi,*.mkv,*.mov,*.wmv,*.flv,*.mpg,*.mpeg,*.m4v -File -EA SilentlyContinue | Select-Object -First 20 Name, LastWriteTime | Format-Table -AutoSize"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Organizando por ano e mes...
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Videos\*') -Include *.mp4,*.avi,*.mkv,*.mov,*.wmv,*.flv,*.mpg,*.mpeg,*.m4v -File -EA SilentlyContinue | ForEach-Object { $d=Join-Path (Join-Path $env:USERPROFILE 'Videos') ($_.LastWriteTime.ToString('yyyy-MM')); New-Item -ItemType Directory -Force -Path $d | Out-Null; Move-Item -LiteralPath $_.FullName -Destination $d -Force }"
if errorlevel 1 (echo [!] O PowerShell retornou um codigo de erro.) else (echo Feito.)
:fim
echo.
pause
