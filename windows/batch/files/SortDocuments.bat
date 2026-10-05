:: ============================================================
:: BATLAB | SortDocuments.bat | v1.0.0
:: @desc      Separa os documentos em uma pasta Documentos
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
:: @undo      Mova os arquivos da pasta Documentos de volta
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SortDocuments
echo ============================================
echo  BATLAB - SortDocuments
echo ============================================
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d *.doc *.docx *.pdf *.txt *.xls *.xlsx *.ppt *.pptx *.rtf *.odt *.csv 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhum documento encontrado nesta pasta. & goto :fim)
echo [ATENCAO] %COUNT% documento(s) serao MOVIDOS para a subpasta Documentos.
echo   Extensoes: doc docx pdf txt xls xlsx ppt pptx rtf odt csv
echo   Origem: %CD%
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if not exist "Documentos" mkdir "Documentos"
for %%e in (doc docx pdf txt xls xlsx ppt pptx rtf odt csv) do move /Y "*.%%e" "Documentos\" >nul 2>&1
if exist "Documentos\*" (echo Feito. Confera a pasta Documentos.) else (echo [!] Nada foi movido.)
:fim
echo.
pause
