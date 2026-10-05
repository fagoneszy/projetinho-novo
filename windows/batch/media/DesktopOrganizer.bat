:: ============================================================
:: BATLAB | DesktopOrganizer.bat | v1.0.0
:: @desc      Organiza a area de trabalho em pastas por tipo
:: @category  media
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos de Desktop\Organizado de volta para a area de trabalho
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DesktopOrganizer
echo ============================================
echo  BATLAB - DesktopOrganizer
echo ============================================
set "P=%USERPROFILE%\Desktop"
set "ORG=%P%\Organizado"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo [ATENCAO] Apenas ARQUIVOS da area de trabalho serao movidos
echo           para subpastas dentro de Desktop\Organizado.
echo Atalhos (.lnk), pastas e itens do sistema NAO serao movidos.
echo Nada sera apagado.
echo.
echo Arquivos que serao afetados (lista parcial):
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Desktop\*') -File -EA SilentlyContinue | Where-Object { $_.Extension -ne '.lnk' } | Select-Object -First 25 Name, Length | Format-Table -AutoSize"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Organizando por tipo...
powershell -NoProfile -Command "$m=@{ 'JPG'='Imagens'; 'JPEG'='Imagens'; 'PNG'='Imagens'; 'GIF'='Imagens'; 'BMP'='Imagens'; 'WEBP'='Imagens'; 'ICO'='Imagens'; 'PDF'='Documentos'; 'DOC'='Documentos'; 'DOCX'='Documentos'; 'ODT'='Documentos'; 'RTF'='Documentos'; 'TXT'='Documentos'; 'XLS'='Planilhas'; 'XLSX'='Planilhas'; 'CSV'='Planilhas'; 'ODS'='Planilhas'; 'PPT'='Apresentacoes'; 'PPTX'='Apresentacoes'; 'MP3'='Audio'; 'WAV'='Audio'; 'FLAC'='Audio'; 'M4A'='Audio'; 'MP4'='Video'; 'MKV'='Video'; 'AVI'='Video'; 'MOV'='Video'; 'ZIP'='Compactados'; 'RAR'='Compactados'; '7Z'='Compactados'; 'EXE'='Instaladores'; 'MSI'='Instaladores' }; Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Desktop\*') -File -EA SilentlyContinue | Where-Object { $_.Extension -ne '.lnk' } | ForEach-Object { $e=$_.Extension.TrimStart('.').ToUpper(); $t=$m[$e]; if (-not $t) { $t='Outros' }; $d=Join-Path $env:ORG $t; New-Item -ItemType Directory -Force -Path $d | Out-Null; Move-Item -LiteralPath $_.FullName -Destination $d -Force }"
if errorlevel 1 (echo [!] O PowerShell retornou um codigo de erro.) else (echo Feito.)
:fim
echo.
pause