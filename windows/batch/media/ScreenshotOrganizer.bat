:: ============================================================
:: BATLAB | ScreenshotOrganizer.bat | v1.0.0
:: @desc      Organiza as capturas de tela por data
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
:: @undo      Mova os arquivos das subpastas AAAA-MM-DD de volta para a raiz de Pictures\Screenshots
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ScreenshotOrganizer
echo ============================================
echo  BATLAB - ScreenshotOrganizer
echo ============================================
set "P=%USERPROFILE%\Pictures\Screenshots"
if not exist "%P%" (
    echo [ERRO] Pasta de capturas nao encontrada: %P%
    echo [Dica] Use CreateScreenshotFolder.bat para cria-la.
    goto :fim
)
echo [ATENCAO] As capturas de tela serao movidas para subpastas
echo           AAAA-MM-DD (por data) dentro de Pictures\Screenshots.
echo Nada sera apagado; os arquivos apenas mudam de pasta.
echo.
echo Arquivos que serao afetados (lista parcial):
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Pictures\Screenshots\*') -Include *.png,*.jpg,*.jpeg,*.bmp -File -EA SilentlyContinue | Select-Object -First 20 Name, LastWriteTime | Format-Table -AutoSize"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Organizando por data...
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Pictures\Screenshots\*') -Include *.png,*.jpg,*.jpeg,*.bmp -File -EA SilentlyContinue | ForEach-Object { $d=Join-Path (Join-Path $env:USERPROFILE 'Pictures\Screenshots') ($_.LastWriteTime.ToString('yyyy-MM-dd')); New-Item -ItemType Directory -Force -Path $d | Out-Null; Move-Item -LiteralPath $_.FullName -Destination $d -Force }"
if errorlevel 1 (echo [!] O PowerShell retornou um codigo de erro.) else (echo Feito.)
:fim
echo.
pause
