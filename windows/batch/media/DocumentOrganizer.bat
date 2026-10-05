:: ============================================================
:: BATLAB | DocumentOrganizer.bat | v1.0.0
:: @desc      Organiza documentos em pastas por categoria
:: @category  media
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos das subpastas de categoria de volta para a raiz de Documents
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DocumentOrganizer
echo ============================================
echo  BATLAB - DocumentOrganizer
echo ============================================
set "P=%USERPROFILE%\Documents"
if not exist "%P%" (
    echo [ERRO] Pasta nao encontrada: %P%
    goto :fim
)
echo [ATENCAO] Os documentos de primeiro nivel serao movidos para
echo           subpastas: PDF, Word, Planilhas, Apresentacoes, Texto, Outros.
echo Nada sera apagado; os arquivos apenas mudam de pasta.
echo.
echo Arquivos que serao afetados (lista parcial):
powershell -NoProfile -Command "Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Documents\*') -Include *.pdf,*.doc,*.docx,*.odt,*.rtf,*.txt,*.md,*.xls,*.xlsx,*.csv,*.ods,*.ppt,*.pptx,*.odp -File -EA SilentlyContinue | Select-Object -First 20 Name, LastWriteTime | Format-Table -AutoSize"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Organizando por categoria...
powershell -NoProfile -Command "$m=@{ 'PDF'='PDF'; 'DOC'='Word'; 'DOCX'='Word'; 'ODT'='Word'; 'RTF'='Word'; 'XLS'='Planilhas'; 'XLSX'='Planilhas'; 'CSV'='Planilhas'; 'ODS'='Planilhas'; 'PPT'='Apresentacoes'; 'PPTX'='Apresentacoes'; 'ODP'='Apresentacoes'; 'TXT'='Texto'; 'MD'='Texto' }; Get-ChildItem -Path (Join-Path $env:USERPROFILE 'Documents\*') -Include *.pdf,*.doc,*.docx,*.odt,*.rtf,*.txt,*.md,*.xls,*.xlsx,*.csv,*.ods,*.ppt,*.pptx,*.odp -File -EA SilentlyContinue | ForEach-Object { $e=$_.Extension.TrimStart('.').ToUpper(); $t=$m[$e]; if (-not $t) { $t='Outros' }; $d=Join-Path (Join-Path $env:USERPROFILE 'Documents') $t; New-Item -ItemType Directory -Force -Path $d | Out-Null; Move-Item -LiteralPath $_.FullName -Destination $d -Force }"
if errorlevel 1 (echo [!] O PowerShell retornou um codigo de erro.) else (echo Feito.)
:fim
echo.
pause