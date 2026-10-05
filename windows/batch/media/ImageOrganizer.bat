:: ============================================================
:: BATLAB | ImageOrganizer.bat | v1.0.0
:: @desc      Organiza imagens por ano e mes
:: @category  media
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos das subpastas AAAA-MM de volta para a raiz de Pictures
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ImageOrganizer
echo ============================================
echo  BATLAB - ImageOrganizer
echo ============================================
set "P=%USERPROFILE%\Pictures"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo [ATENCAO] As imagens de primeiro nivel serao movidas para
echo           subpastas AAAA-MM dentro da pasta Pictures.
echo Nada sera apagado; os arquivos apenas mudam de pasta.
echo.
echo Arquivos que serao afetados (lista parcial):
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Pictures\*') -Include *.jpg,*.jpeg,*.png,*.gif,*.bmp,*.webp -File -EA SilentlyContinue | Select-Object -First 20 Name, LastWriteTime | Format-Table -AutoSize"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Organizando por ano e mes...
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Pictures\*') -Include *.jpg,*.jpeg,*.png,*.gif,*.bmp,*.webp -File -EA SilentlyContinue | ForEach-Object { $d=Join-Path (Join-Path $env:USERPROFILE 'Pictures') ($_.LastWriteTime.ToString('yyyy-MM')); New-Item -ItemType Directory -Force -Path $d | Out-Null; Move-Item -LiteralPath $_.FullName -Destination $d -Force }"
if errorlevel 1 (echo [!] O PowerShell retornou um codigo de erro.) else (echo Feito.)
:fim
echo.
pause