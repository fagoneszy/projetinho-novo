:: ============================================================
:: BATLAB | WallpaperOrganizer.bat | v1.0.0
:: @desc      Organiza wallpapers por data de modificacao
:: @category  media
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos das subpastas AAAA-MM de volta para a raiz de Pictures\Wallpapers
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WallpaperOrganizer
echo ============================================
echo  BATLAB - WallpaperOrganizer
echo ============================================
set "P=%USERPROFILE%\Pictures\Wallpapers"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    echo [Dica] Coloque seus wallpapers em Pictures\Wallpapers e rode de novo.
    goto :fim
)
echo [ATENCAO] Os wallpapers serao movidos para subpastas AAAA-MM
echo           conforme a data de modificacao de cada arquivo.
echo Nada sera apagado; os arquivos apenas mudam de pasta.
echo.
echo Arquivos que serao afetados (lista parcial):
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Pictures\Wallpapers\*') -File -EA SilentlyContinue | Select-Object -First 20 Name, LastWriteTime | Format-Table -AutoSize"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Organizando por data de modificacao...
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Pictures\Wallpapers\*') -File -EA SilentlyContinue | ForEach-Object { $d=Join-Path (Join-Path $env:USERPROFILE 'Pictures\Wallpapers') ($_.LastWriteTime.ToString('yyyy-MM')); New-Item -ItemType Directory -Force -Path $d | Out-Null; Move-Item -LiteralPath $_.FullName -Destination $d -Force }"
if errorlevel 1 (echo [!] O PowerShell retornou um codigo de erro.) else (echo Feito.)
:fim
echo.
pause