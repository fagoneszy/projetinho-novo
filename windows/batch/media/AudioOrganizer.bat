:: ============================================================
:: BATLAB | AudioOrganizer.bat | v1.0.0
:: @desc      Organiza arquivos de audio em pastas por tipo
:: @category  media
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos das subpastas de tipo de volta para a raiz de Music
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AudioOrganizer
echo ============================================
echo  BATLAB - AudioOrganizer
echo ============================================
set "P=%USERPROFILE%\Music"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo [ATENCAO] Os arquivos de audio de primeiro nivel serao movidos
echo           para subpastas por tipo: MP3, WAV, FLAC, OGG, M4A, OUTROS.
echo Nada sera apagado; os arquivos apenas mudam de pasta.
echo.
echo Arquivos que serao afetados (lista parcial):
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Music\*') -Include *.mp3,*.wav,*.flac,*.ogg,*.opus,*.m4a,*.aac,*.wma,*.amr -File -EA SilentlyContinue | Select-Object -First 20 Name, Length | Format-Table -AutoSize"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Organizando por tipo...
powershell -NoProfile -Command "$m=@{ 'MP3'='MP3'; 'WAV'='WAV'; 'FLAC'='FLAC'; 'OGG'='OGG'; 'OPUS'='OGG'; 'M4A'='M4A'; 'AAC'='M4A' }; Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Music\*') -Include *.mp3,*.wav,*.flac,*.ogg,*.opus,*.m4a,*.aac,*.wma,*.amr -File -EA SilentlyContinue | ForEach-Object { $e=$_.Extension.TrimStart('.').ToUpper(); $t=$m[$e]; if (-not $t) { $t='OUTROS' }; $d=Join-Path (Join-Path $env:USERPROFILE 'Music') $t; New-Item -ItemType Directory -Force -Path $d | Out-Null; Move-Item -LiteralPath $_.FullName -Destination $d -Force }"
if errorlevel 1 (echo [!] O PowerShell retornou um codigo de erro.) else (echo Feito.)
:fim
echo.
pause